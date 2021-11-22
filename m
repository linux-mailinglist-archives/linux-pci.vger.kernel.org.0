Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79A6D4594B2
	for <lists+linux-pci@lfdr.de>; Mon, 22 Nov 2021 19:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240287AbhKVSbN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Nov 2021 13:31:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:44428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229853AbhKVSbM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Nov 2021 13:31:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BAC8160F6F;
        Mon, 22 Nov 2021 18:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637605686;
        bh=konvSo77Cx8ln8EJy9hBJpfgeh2p+6Im9gPnwaVvtcE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KAoHQNfLF2Vjg4BscPPxWDJ0g3M4DFTf8kY7Ac+dD9nfCBSd+Ya+iAcqVAHZRZHWe
         6/oOOfNQkyJFtScp+pZe+cVhbdU6TfHDwPzm623zb3cE0HwZDe+9mepaj0yHgqJkts
         BUxazuHp2yEK+m3UCIbZleOqik4WeTp1nCJtoi1ufE0C4+OUN8PmVBpkjEmMwBUbzz
         nj3Em69KVmtH+6Hn5Iuo1RT4o7rRzXnVNR/301UWRd/e0uef56vADR+I3+ZnuPeI5b
         OorpzgMfyavFPbk2F6x/EouklIfzULQF3hJuRJTwzranrrBCCKTWNs0mYKtxbAk7k8
         ufbAPbXbTOZ4Q==
Date:   Mon, 22 Nov 2021 12:28:04 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "David E. Box" <david.e.box@linux.intel.com>, lee.jones@linaro.org,
        hdegoede@redhat.com, bhelgaas@google.com,
        andriy.shevchenko@linux.intel.com, srinivas.pandruvada@intel.com,
        mgross@linux.intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/4] PCI: Add #defines for accessing PCIe DVSEC fields
Message-ID: <20211122182804.GA2157671@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZo6aczgqoobIcDC@kroah.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Nov 21, 2021 at 01:24:09PM +0100, Greg KH wrote:
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
> >  #define PCI_DVSEC_HEADER1		0x4 /* Designated Vendor-Specific Header1 */
> > +#define  PCI_DVSEC_HEADER1_VID(x)	((x) & 0xffff)
> > +#define  PCI_DVSEC_HEADER1_REV(x)	(((x) >> 16) & 0xf)
> > +#define  PCI_DVSEC_HEADER1_LEN(x)	(((x) >> 20) & 0xfff)
> >  #define PCI_DVSEC_HEADER2		0x8 /* Designated Vendor-Specific Header2 */
> > +#define  PCI_DVSEC_HEADER2_ID(x)		((x) & 0xffff)
> 
> Why does userspace need to have these defines?  What userspace tool is
> going to use these?

This is pretty typical of other content in pci_regs.h.  There's lots
of existing content that may not be directly useful to userspace, but
it's there because it's convenient to have definitions prescribed by
the spec all together in one place.

They probably shouldn't go in drivers/pci/pci.h because by definition
this vendor-specific stuff will be used by vendor-specific drivers but
not by the PCI core.

I guess these *could* go in include/linux/pci.h, but that wouldn't be
my first choice because there's nothing similar there.

Bjorn
