Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6500845848D
	for <lists+linux-pci@lfdr.de>; Sun, 21 Nov 2021 16:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238400AbhKUPvv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 21 Nov 2021 10:51:51 -0500
Received: from mga07.intel.com ([134.134.136.100]:28739 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233114AbhKUPvv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 21 Nov 2021 10:51:51 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10174"; a="298086781"
X-IronPort-AV: E=Sophos;i="5.87,252,1631602800"; 
   d="scan'208";a="298086781"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2021 07:48:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,252,1631602800"; 
   d="scan'208";a="738905129"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 21 Nov 2021 07:48:45 -0800
Received: from mradosav-MOBL1.amr.corp.intel.com (unknown [10.252.142.12])
        by linux.intel.com (Postfix) with ESMTP id E37445807D4;
        Sun, 21 Nov 2021 07:48:44 -0800 (PST)
Message-ID: <66279e39a81cd4837b11e516a053ebb337e3756e.camel@linux.intel.com>
Subject: Re: [PATCH 1/4] PCI: Add #defines for accessing PCIe DVSEC fields
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     lee.jones@linaro.org, hdegoede@redhat.com, bhelgaas@google.com,
        andriy.shevchenko@linux.intel.com, srinivas.pandruvada@intel.com,
        mgross@linux.intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org
Date:   Sun, 21 Nov 2021 07:48:43 -0800
In-Reply-To: <YZo6aczgqoobIcDC@kroah.com>
References: <20211120231705.189969-1-david.e.box@linux.intel.com>
         <20211120231705.189969-2-david.e.box@linux.intel.com>
         <YZo6aczgqoobIcDC@kroah.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 2021-11-21 at 13:24 +0100, Greg KH wrote:
> On Sat, Nov 20, 2021 at 03:17:02PM -0800, David E. Box wrote:
> > Add #defines for accessing Vendor ID, Revision, Length, and ID offsets
> > in the Designated Vendor Specific Extended Capability (DVSEC). Defined
> > in PCIe r5.0, sec 7.9.6.
> > 
> > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  include/uapi/linux/pci_regs.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> > index ff6ccbc6efe9..318f3f1f9e92 100644
> > --- a/include/uapi/linux/pci_regs.h
> > +++ b/include/uapi/linux/pci_regs.h
> > @@ -1086,7 +1086,11 @@
> >  
> >  /* Designated Vendor-Specific (DVSEC, PCI_EXT_CAP_ID_DVSEC) */
> >  #define PCI_DVSEC_HEADER1		0x4 /* Designated Vendor-Specific
> > Header1 */
> > +#define  PCI_DVSEC_HEADER1_VID(x)	((x) & 0xffff)
> > +#define  PCI_DVSEC_HEADER1_REV(x)	(((x) >> 16) & 0xf)
> > +#define  PCI_DVSEC_HEADER1_LEN(x)	(((x) >> 20) & 0xfff)
> >  #define PCI_DVSEC_HEADER2		0x8 /* Designated Vendor-Specific
> > Header2 */
> > +#define  PCI_DVSEC_HEADER2_ID(x)		((x) & 0xffff)
> 
> Why does userspace need to have these defines?  What userspace tool is
> going to use these?

These headers should useful for userspace tools that access PCI devices. DVSEC
is also used by CXL so they should come in handy for tools accesses those
devices.

> 
> thanks,
> 
> greg k-h

