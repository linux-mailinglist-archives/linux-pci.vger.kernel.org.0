Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A49F222B0F
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jul 2020 20:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbgGPSb1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Jul 2020 14:31:27 -0400
Received: from mga07.intel.com ([134.134.136.100]:48421 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbgGPSb1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Jul 2020 14:31:27 -0400
IronPort-SDR: X2qH1R9trpAYXz79ljqZHuyAmQ6G09RJh6CMikZ+t71g3UWqLd1FKLbWIo3HbfaZjFwbuCuTBs
 1c3+bxhTF+sw==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="214199627"
X-IronPort-AV: E=Sophos;i="5.75,360,1589266800"; 
   d="scan'208";a="214199627"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 11:31:26 -0700
IronPort-SDR: 2t0dmylMk3iWIbS6vD/SuFnigW7SF7YBbtcIIx3Mhigunsx4L5VmqjzHrquvxZ6wZWUsILMegO
 TNWxlA3BD68Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,360,1589266800"; 
   d="scan'208";a="308731140"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 16 Jul 2020 11:31:25 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.7.201.137])
        by linux.intel.com (Postfix) with ESMTP id B3A945804BB;
        Thu, 16 Jul 2020 11:31:25 -0700 (PDT)
Message-ID: <e051971b327d870476dad209ddf27055d001b9b4.camel@linux.intel.com>
Subject: Re: [PATCH V3 1/3] PCI: Add defines for Designated Vendor-Specific
 Capability
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>, lee.jones@linaro.org,
        dvhart@infradead.org, andy@infradead.org, bhelgaas@google.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org
Date:   Thu, 16 Jul 2020 11:31:25 -0700
In-Reply-To: <dc459a96-1434-16bf-80d2-06b0680f9fda@linux.intel.com>
References: <20200508021844.6911-1-david.e.box@linux.intel.com>
         <20200714062323.19990-2-david.e.box@linux.intel.com>
         <3f490460-62f8-8b49-0735-ad29653bfbc0@infradead.org>
         <dc459a96-1434-16bf-80d2-06b0680f9fda@linux.intel.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2020-07-16 at 10:18 -0700, Alexander Duyck wrote:
> 
> On 7/15/2020 7:55 PM, Randy Dunlap wrote:
> > On 7/13/20 11:23 PM, David E. Box wrote:
> > > Add PCIe DVSEC extended capability ID and defines for the header
> > > offsets.
> > > Defined in PCIe r5.0, sec 7.9.6.
> > > 
> > > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > > ---
> > >   include/uapi/linux/pci_regs.h | 5 +++++
> > >   1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/include/uapi/linux/pci_regs.h
> > > b/include/uapi/linux/pci_regs.h
> > > index f9701410d3b5..09daa9f07b6b 100644
> > > --- a/include/uapi/linux/pci_regs.h
> > > +++ b/include/uapi/linux/pci_regs.h
> > > @@ -720,6 +720,7 @@
> > > +#define PCI_EXT_CAP_ID_DVSEC	0x23	/* Designated Vendor-
> > > Specific */
> > > @@ -1062,6 +1063,10 @@
> > > +/* Designated Vendor-Specific (DVSEC, PCI_EXT_CAP_ID_DVSEC) */
> > > +#define PCI_DVSEC_HEADER1		0x4 /* Vendor-Specific
> > > Header1 */
> > > +#define PCI_DVSEC_HEADER2		0x8 /* Vendor-Specific
> > > Header2 */

These comments I'll fix to say "Designated Vendor-Specific"

> > 
> > Just a little comment: It would make more sense to me to
> > s/DVSEC/DVSPEC/g.
> > 
> > But then I don't have the PCIe documentation.
> 
> Arguably some of the confusion might be from the patch title. DVSEC
> is 
> acronym for Designated Vendor-Specific Extended Capability if I
> recall 
> correctly. It would probably be best to call that out since the
> extended 
> implies it lives in the config space accessible via the memory
> mapped 
> config.

I'll change the patch title as well, but agree DVSEC is better as it's
consistent with the spec.

Thanks

David

