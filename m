Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F01535E63A
	for <lists+linux-pci@lfdr.de>; Tue, 13 Apr 2021 20:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347628AbhDMSXZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Apr 2021 14:23:25 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2848 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345963AbhDMSXZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Apr 2021 14:23:25 -0400
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FKYk30Yhhz688qy;
        Wed, 14 Apr 2021 02:17:47 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Tue, 13 Apr 2021 20:23:02 +0200
Received: from localhost (10.47.93.73) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 13 Apr
 2021 19:23:01 +0100
Date:   Tue, 13 Apr 2021 19:21:35 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Chris Browy <cbrowy@avery-design.com>,
        <linux-acpi@vger.kernel.org>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <linuxarm@huawei.com>, Fangjian <f.fangjian@huawei.com>
Subject: Re: [RFC PATCH v2 1/4] PCI: Add vendor define ID for the PCI SIG
Message-ID: <20210413192135.000024de@Huawei.com>
In-Reply-To: <20210413163448.GA2240386@bjorn-Precision-5520>
References: <20210413160159.935663-2-Jonathan.Cameron@huawei.com>
        <20210413163448.GA2240386@bjorn-Precision-5520>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.93.73]
X-ClientProxiedBy: lhreml713-chm.china.huawei.com (10.201.108.64) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 13 Apr 2021 11:34:48 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Wed, Apr 14, 2021 at 12:01:56AM +0800, Jonathan Cameron wrote:
> > This ID is used in DOE headers to identify protocols that are
> > defined within the PCI Express Base Specification.  
> 
> Can you please include the specific spec citation here?

Will make sure to add to cover leter for next version but for now, 

Table 7-x2: Data Object Exchange ECN
(first column lists the Vendor ID for the protocols)

Available on the PCI SIG spec downloads page.
It also exists in various other places in the 5.0 spec, but I'm
not sure if any are software visible (e.g. VDMs)

Jonathan


> 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> > Since V1: New Patch
> > 
> >  include/linux/pci_ids.h | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> > index a76ccb697bef..2c0459c23331 100644
> > --- a/include/linux/pci_ids.h
> > +++ b/include/linux/pci_ids.h
> > @@ -149,6 +149,7 @@
> >  #define PCI_CLASS_OTHERS		0xff
> >  
> >  /* Vendors and devices.  Sort key: vendor first, device next. */
> > +#define PCI_VENDOR_ID_PCI_SIG		0x0001
> >  
> >  #define PCI_VENDOR_ID_LOONGSON		0x0014
> >  
> > -- 
> > 2.19.1
> >   

