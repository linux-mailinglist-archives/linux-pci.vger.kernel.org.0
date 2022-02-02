Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86554A6DE1
	for <lists+linux-pci@lfdr.de>; Wed,  2 Feb 2022 10:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbiBBJgY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Feb 2022 04:36:24 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4612 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbiBBJgY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Feb 2022 04:36:24 -0500
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jpc9c2kHkz67Zqk;
        Wed,  2 Feb 2022 17:35:48 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Feb 2022 10:36:21 +0100
Received: from localhost (10.47.70.124) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 2 Feb
 2022 09:36:20 +0000
Date:   Wed, 2 Feb 2022 09:36:19 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Ben Widawsky <ben.widawsky@intel.com>, <linux-cxl@vger.kernel.org>,
        "Linux PCI" <linux-pci@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v3 27/40] cxl/pci: Cache device DVSEC offset
Message-ID: <20220202093619.0000072c@Huawei.com>
In-Reply-To: <CAPcyv4hhOa8hRdy3R8oiuw9Whfke-s67KfvcazP4VFuhuXCtsQ@mail.gmail.com>
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
        <164298426273.3018233.9302136088649279124.stgit@dwillia2-desk3.amr.corp.intel.com>
        <20220131181924.00006c57@Huawei.com>
        <20220201152410.36jvdmmpcqi3lhdw@intel.com>
        <CAPcyv4iyRKfviJNtHP=wsqRtppDb+BrmhNeum+ZcyBAJ5VSPtA@mail.gmail.com>
        <20220201221114.25ivh5ubptd7kauk@intel.com>
        <CAPcyv4hYSm+q1RYnrdNvr_dXsU-OZ-v94RRvNGtr5-wtHc97=w@mail.gmail.com>
        <20220201222042.hv2xipmuous7s7qh@intel.com>
        <CAPcyv4hhOa8hRdy3R8oiuw9Whfke-s67KfvcazP4VFuhuXCtsQ@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.70.124]
X-ClientProxiedBy: lhreml715-chm.china.huawei.com (10.201.108.66) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 1 Feb 2022 14:24:51 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> On Tue, Feb 1, 2022 at 2:20 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > On 22-02-01 14:15:22, Dan Williams wrote:  
> > > On Tue, Feb 1, 2022 at 2:11 PM Ben Widawsky <ben.widawsky@intel.com> wrote:  
> > > >
> > > > On 22-02-01 13:41:50, Dan Williams wrote:  
> > > > > On Tue, Feb 1, 2022 at 7:24 AM Ben Widawsky <ben.widawsky@intel.com> wrote:  
> > > > > >
> > > > > > On 22-01-31 18:19:24, Jonathan Cameron wrote:  
> > > > > > > On Sun, 23 Jan 2022 16:31:02 -0800
> > > > > > > Dan Williams <dan.j.williams@intel.com> wrote:
> > > > > > >  
> > > > > > > > From: Ben Widawsky <ben.widawsky@intel.com>
> > > > > > > >
> > > > > > > > The PCIe device DVSEC, defined in the CXL 2.0 spec, 8.1.3 is required to
> > > > > > > > be implemented by CXL 2.0 endpoint devices. Since the information
> > > > > > > > contained within this DVSEC will be critically important, it makes sense
> > > > > > > > to find the value early, and error out if it cannot be found.
> > > > > > > >
> > > > > > > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > > > > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>  
> > > > > > > Guess the logic makes sense about checking this early though my cynical
> > > > > > > mind says, that if someone is putting in devices that claim to be
> > > > > > > CXL ones and this isn't there it is there own problem if they
> > > > > > > kernel wastes effort bringing the driver up only to find later
> > > > > > > it can't finish doing so...  
> > > > > >
> > > > > > I don't remember if Dan and I discussed actually failing to bind this early if
> > > > > > the DVSEC isn't there.  
> > > > >
> > > > > On second look, the error message does not make sense because there is
> > > > > "no functionality" not "limited functionality" as a result of this
> > > > > failure because the cxl_pci driver just gives up. This failure should
> > > > > be limited to cxl_mem, not cxl_pci as there might still be value in
> > > > > accessing the mailbox on this device.
> > > > >  
> > > > > > I think the concern is less about wasted effort and more
> > > > > > about the inability to determine if the device is actively decoding something
> > > > > > and then having the kernel driver tear that out when it takes over the decoder
> > > > > > resources. This was specifically targeted toward the DVSEC range registers
> > > > > > (obviously things would fail later if we couldn't find the MMIO).  
> > > > >
> > > > > If there is no CXL DVSEC then cxl_mem should fail, that's it.
> > > > >  
> > > >
> > > > If there is no CXL DVSEC we have no way to find the device's MMIO. You need the
> > > > register locator dvsec. Not sure how you intend to do anything with the device
> > > > at that point, but if you see something I don't, then by all means, change it.  
> > >
> > > I see:
> > >
> > > pci_find_dvsec_capability(pdev, PCI_DVSEC_VENDOR_ID_CXL, CXL_DVSEC_PCIE_DEVICE);
> > >
> > > ...and:
> > >
> > > pci_find_dvsec_capability(pdev, PCI_DVSEC_VENDOR_ID_CXL, CXL_DVSEC_REG_LOCATOR);
> > >
> > > ...aren't they independent?  
> >
> > My mistake. I was thinking of a different patch, "cxl/pci: Retrieve CXL DVSEC
> > memory info". You're correct, they are independent (both mandatory for type 3
> > devices).
> >
> > However, Jonathan was the one who originally suggested it. I had it as a warn
> > originally.
> > https://lore.kernel.org/linux-cxl/20211122223430.gvkwj3yeckriffes@intel.com/  
> 
> At least to the concern of "nothing" working without the base CXL
> DVSEC the cxl_mem driver failing to attach catches that case.
> Otherwise a device that only implements the mailbox seems not outside
> the realm of possibility. Jonathan?

I don't really care. To my mind the hardware is broken anyway,
but if you want to try and enable 'some stuff' then I'm fine with
that - mostly I think if it's broken enough that the DVSEC locator
isn't there, then chances the mailbox works are probably low, but
then I'm not implementing the hardware :)

Jonathan


