Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11F143187BE
	for <lists+linux-pci@lfdr.de>; Thu, 11 Feb 2021 11:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbhBKKFt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Feb 2021 05:05:49 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2543 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbhBKKDg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Feb 2021 05:03:36 -0500
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DbsWS2GH8z67mBT;
        Thu, 11 Feb 2021 17:57:56 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 11 Feb 2021 11:02:53 +0100
Received: from localhost (10.47.31.44) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2106.2; Thu, 11 Feb
 2021 10:02:52 +0000
Date:   Thu, 11 Feb 2021 10:01:52 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Ben Widawsky <ben.widawsky@intel.com>, <linux-cxl@vger.kernel.org>,
        "Linux ACPI" <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jon Masters <jcm@jonmasters.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>
Subject: Re: [PATCH v2 2/8] cxl/mem: Find device capabilities
Message-ID: <20210211100152.00000667@Huawei.com>
In-Reply-To: <CAPcyv4i4_6HLNpw7p-1PD9cePuMuPkvUfx0ROT8M0Y7ftxzYfg@mail.gmail.com>
References: <20210210000259.635748-1-ben.widawsky@intel.com>
        <20210210000259.635748-3-ben.widawsky@intel.com>
        <20210210174104.0000710a@Huawei.com>
        <20210210185319.chharluce2ly4cne@intel.com>
        <CAPcyv4i4_6HLNpw7p-1PD9cePuMuPkvUfx0ROT8M0Y7ftxzYfg@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.31.44]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 10 Feb 2021 11:54:29 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> > > ...
> > >  
> > > > +static void cxl_mem_mbox_timeout(struct cxl_mem *cxlm,
> > > > +                            struct mbox_cmd *mbox_cmd)
> > > > +{
> > > > +   struct device *dev = &cxlm->pdev->dev;
> > > > +
> > > > +   dev_dbg(dev, "Mailbox command (opcode: %#x size: %zub) timed out\n",
> > > > +           mbox_cmd->opcode, mbox_cmd->size_in);
> > > > +
> > > > +   if (IS_ENABLED(CONFIG_CXL_MEM_INSECURE_DEBUG)) {  
> > >
> > > Hmm.  Whilst I can see the advantage of this for debug, I'm not sure we want
> > > it upstream even under a rather evil looking CONFIG variable.
> > >
> > > Is there a bigger lock we can use to avoid chance of accidental enablement?  
> >
> > Any suggestions? I'm told this functionality was extremely valuable for NVDIMM,
> > though I haven't personally experienced it.  
> 
> Yeah, there was no problem with the identical mechanism in LIBNVDIMM
> land. However, I notice that the useful feature for LIBNVDIMM is the
> option to dump all payloads. This one only fires on timeouts which is
> less useful. So I'd say fix it to dump all payloads on the argument
> that the safety mechanism was proven with the LIBNVDIMM precedent, or
> delete it altogether to maintain v5.12 momentum. Payload dumping can
> be added later.

I think I'd drop it for now - feels like a topic that needs more discussion.

Also, dumping this data to the kernel log isn't exactly elegant - particularly
if we dump a lot more of it.  Perhaps tracepoints?

> 
> [..]
> > > > diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> > > > index e709ae8235e7..6267ca9ae683 100644
> > > > --- a/include/uapi/linux/pci_regs.h
> > > > +++ b/include/uapi/linux/pci_regs.h
> > > > @@ -1080,6 +1080,7 @@
> > > >
> > > >  /* Designated Vendor-Specific (DVSEC, PCI_EXT_CAP_ID_DVSEC) */
> > > >  #define PCI_DVSEC_HEADER1          0x4 /* Designated Vendor-Specific Header1 */
> > > > +#define PCI_DVSEC_HEADER1_LENGTH_MASK      0xFFF00000  
> > >
> > > Seems sensible to add the revision mask as well.
> > > The vendor id currently read using a word read rather than dword, but perhaps
> > > neater to add that as well for completeness?
> > >
> > > Having said that, given Bjorn's comment on clashes and the fact he'd rather see
> > > this stuff defined in drivers and combined later (see review patch 1 and follow
> > > the link) perhaps this series should not touch this header at all.  
> >
> > I'm fine to move it back.  
> 
> Yeah, we're playing tennis now between Bjorn's and Christoph's
> comments, but I like Bjorn's suggestion of "deduplicate post merge"
> given the bloom of DVSEC infrastructure landing at the same time.
I guess it may depend on timing of this.  Personally I think 5.12 may be too aggressive.

As long as Bjorn can take a DVSEC deduplication as an immutable branch then perhaps
during 5.13 this tree can sit on top of that.

Jonathan


