Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC0045A100
	for <lists+linux-pci@lfdr.de>; Tue, 23 Nov 2021 12:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbhKWLMq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Nov 2021 06:12:46 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4154 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234555AbhKWLMq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Nov 2021 06:12:46 -0500
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Hz1bS3nttz67wvf;
        Tue, 23 Nov 2021 19:08:36 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 23 Nov 2021 12:09:36 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Tue, 23 Nov
 2021 11:09:35 +0000
Date:   Tue, 23 Nov 2021 11:09:34 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 18/23] cxl/pci: Implement wait for media active
Message-ID: <20211123110934.000070a2@Huawei.com>
In-Reply-To: <20211122225751.bofqtswxree74n7f@intel.com>
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
        <20211120000250.1663391-19-ben.widawsky@intel.com>
        <20211122170335.0000563c@Huawei.com>
        <20211122225751.bofqtswxree74n7f@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml744-chm.china.huawei.com (10.201.108.194) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 22 Nov 2021 14:57:51 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> On 21-11-22 17:03:35, Jonathan Cameron wrote:
> > On Fri, 19 Nov 2021 16:02:45 -0800
> > Ben Widawsky <ben.widawsky@intel.com> wrote:
> >   
> > > CXL 2.0 8.1.3.8.2 defines "Memory_Active: When set, indicates that the
> > > CXL Range 1 memory is fully initialized and available for software use.
> > > Must be set within Range 1. Memory_Active_Timeout of deassertion of  
> > 
> > Range 1?
> >   
> 
> Not my numbering... It's the first DVSEC range.

Ah, got it. Maybe Range 1: Memory Active timeout ?

> 
> > > reset to CXL device if CXL.mem HwInit Mode=1" The CXL* Type 3 Memory
> > > Device Software Guide (Revision 1.0) further describes the need to check
> > > this bit before using HDM.
> > > 
> > > Unfortunately, Memory_Active can take quite a long time depending on
> > > media size (up to 256s per 2.0 spec). Since the cxl_pci driver doesn't
> > > care about this, a callback is exported as part of driver state for use
> > > by drivers that do care.
> > > 
> > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>  
> > 
> > Same thing about size not being used...
> >   
> 
> Yep, got it.
> 
> > > ---
> > > This patch did not exist in RFCv2
> > > ---
> > >  drivers/cxl/cxlmem.h |  1 +
> > >  drivers/cxl/pci.c    | 56 ++++++++++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 57 insertions(+)
> > > 
> > > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > > index eac5528ccaae..a9424dd4e5c3 100644
> > > --- a/drivers/cxl/cxlmem.h
> > > +++ b/drivers/cxl/cxlmem.h
> > > @@ -167,6 +167,7 @@ struct cxl_dev_state {
> > >  	struct cxl_endpoint_dvsec_info *info;
> > >  
> > >  	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
> > > +	int (*wait_media_ready)(struct cxl_dev_state *cxlds);
> > >  };
> > >  
> > >  enum cxl_opcode {
> > > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > > index b3f46045bf3e..f1a68bfe5f77 100644
> > > --- a/drivers/cxl/pci.c
> > > +++ b/drivers/cxl/pci.c
> > > @@ -496,6 +496,60 @@ static int wait_for_valid(struct cxl_dev_state *cxlds)
> > >  	return valid ? 0 : -ETIMEDOUT;
> > >  }
> > >  
> > > +/*
> > > + * Implements Figure 43 of the CXL Type 3 Memory Device Software Guide. Waits a
> > > + * full 256s no matter what the device reports.
> > > + */
> > > +static int wait_for_media_ready(struct cxl_dev_state *cxlds)
> > > +{
> > > +	const unsigned long timeout = jiffies + (256 * HZ);
> > > +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> > > +	u64 md_status;
> > > +	bool active;
> > > +	int rc;
> > > +
> > > +	rc = wait_for_valid(cxlds);
> > > +	if (rc)
> > > +		return rc;
> > > +
> > > +	do {
> > > +		u64 size;
> > > +		u32 temp;
> > > +		int rc;
> > > +
> > > +		rc = pci_read_config_dword(pdev, CDPDR(cxlds, 0, SIZE, HIGH),
> > > +					   &temp);
> > > +		if (rc)
> > > +			return -ENXIO;
> > > +		size = (u64)temp << 32;
> > > +
> > > +		rc = pci_read_config_dword(pdev, CDPDR(cxlds, 0, SIZE, LOW),
> > > +					   &temp);
> > > +		if (rc)
> > > +			return -ENXIO;
> > > +		size |= temp & CXL_DVSEC_PCIE_DEVICE_MEM_SIZE_LOW_MASK;
> > > +
> > > +		active = FIELD_GET(CXL_DVSEC_PCIE_DEVICE_MEM_ACTIVE, temp);  
> > 
> > Only need to read the register to get active for this particular functionality.
> >   
> > > +		if (active)
> > > +			break;
> > > +		cpu_relax();
> > > +		mdelay(100);
> > > +	} while (!time_after(jiffies, timeout));
> > > +
> > > +	if (!active)
> > > +		return -ETIMEDOUT;
> > > +
> > > +	rc = check_device_status(cxlds);
> > > +	if (rc)
> > > +		return rc;
> > > +
> > > +	md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
> > > +	if (!CXLMDEV_READY(md_status))
> > > +		return -EIO;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  static struct cxl_endpoint_dvsec_info *dvsec_ranges(struct cxl_dev_state *cxlds)
> > >  {
> > >  	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> > > @@ -598,6 +652,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > >  	if (!cxlds->device_dvsec)
> > >  		dev_warn(&pdev->dev,
> > >  			 "Device DVSEC not present. Expect limited functionality.\n");
> > > +	else
> > > +		cxlds->wait_media_ready = wait_for_media_ready;
> > >  
> > >  	rc = cxl_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
> > >  	if (rc)  
> >   

