Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4524445ECC5
	for <lists+linux-pci@lfdr.de>; Fri, 26 Nov 2021 12:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbhKZLmN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Nov 2021 06:42:13 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4171 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345005AbhKZLkN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Nov 2021 06:40:13 -0500
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4J0t466syJz67kSQ;
        Fri, 26 Nov 2021 19:36:22 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 26 Nov 2021 12:36:58 +0100
Received: from localhost (10.122.247.231) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 26 Nov
 2021 11:36:57 +0000
Date:   Fri, 26 Nov 2021 11:36:56 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 18/23] cxl/pci: Implement wait for media active
Message-ID: <20211126113656.0000723c@huawei.com>
In-Reply-To: <20211122170335.0000563c@Huawei.com>
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
        <20211120000250.1663391-19-ben.widawsky@intel.com>
        <20211122170335.0000563c@Huawei.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml739-chm.china.huawei.com (10.201.108.189) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 22 Nov 2021 17:03:35 +0000
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Fri, 19 Nov 2021 16:02:45 -0800
> Ben Widawsky <ben.widawsky@intel.com> wrote:
> 
> > CXL 2.0 8.1.3.8.2 defines "Memory_Active: When set, indicates that the
> > CXL Range 1 memory is fully initialized and available for software use.
> > Must be set within Range 1. Memory_Active_Timeout of deassertion of  
> 
> Range 1?
> 
> > reset to CXL device if CXL.mem HwInit Mode=1" The CXL* Type 3 Memory
> > Device Software Guide (Revision 1.0) further describes the need to check
> > this bit before using HDM.
> > 
> > Unfortunately, Memory_Active can take quite a long time depending on
> > media size (up to 256s per 2.0 spec). Since the cxl_pci driver doesn't
> > care about this, a callback is exported as part of driver state for use
> > by drivers that do care.
> > 
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>  
> 
> Same thing about size not being used...
> 
> > ---
> > This patch did not exist in RFCv2
> > ---
> >  drivers/cxl/cxlmem.h |  1 +
> >  drivers/cxl/pci.c    | 56 ++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 57 insertions(+)
> > 
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index eac5528ccaae..a9424dd4e5c3 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -167,6 +167,7 @@ struct cxl_dev_state {
> >  	struct cxl_endpoint_dvsec_info *info;
> >  
> >  	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
> > +	int (*wait_media_ready)(struct cxl_dev_state *cxlds);

Missing docs for this. 

Jonathan
