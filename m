Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6514E2DF0D
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2019 16:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfE2OBB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 May 2019 10:01:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:36742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726889AbfE2OBB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 May 2019 10:01:01 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8950C233A0;
        Wed, 29 May 2019 14:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559138459;
        bh=6I6e8RsN54app+WgA8e9wHTb5JQKaczTUSAMC9nxhD8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P/PbkYBO0+PESFocyvmX3yQ8ejtkce/xlNo/QTQ27X4Rr5gMKVwtXyYlysdjFs3Jr
         mLPWrLTSlu0qClL6mmANi9oN62seB1OtaqqdvIwUy0MD32YraneGaQ+wVpBCx91w4L
         b9gs9XherqoaTEXq03Ypd6UOF7RDiffICYLVC85g=
Date:   Wed, 29 May 2019 09:00:58 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Oliver <oohall@gmail.com>
Cc:     Shawn Anastasio <shawn@anastas.io>, linux-pci@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        xyjxie@linux.vnet.ibm.com, rppt@linux.ibm.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] PCI: Introduce pcibios_ignore_alignment_request
Message-ID: <20190529140058.GB28250@google.com>
References: <20190528040313.35582-1-shawn@anastas.io>
 <20190528040313.35582-2-shawn@anastas.io>
 <CAOSf1CEFfbmwfvmdqT1xdt8SFb=tYdYXLfXeyZ8=iRnhg4a3Pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOSf1CEFfbmwfvmdqT1xdt8SFb=tYdYXLfXeyZ8=iRnhg4a3Pg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 28, 2019 at 03:36:34PM +1000, Oliver wrote:
> On Tue, May 28, 2019 at 2:03 PM Shawn Anastasio <shawn@anastas.io> wrote:
> >
> > Introduce a new pcibios function pcibios_ignore_alignment_request
> > which allows the PCI core to defer to platform-specific code to
> > determine whether or not to ignore alignment requests for PCI resources.
> >
> > The existing behavior is to simply ignore alignment requests when
> > PCI_PROBE_ONLY is set. This is behavior is maintained by the
> > default implementation of pcibios_ignore_alignment_request.
> >
> > Signed-off-by: Shawn Anastasio <shawn@anastas.io>
> > ---
> >  drivers/pci/pci.c   | 9 +++++++--
> >  include/linux/pci.h | 1 +
> >  2 files changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 8abc843b1615..8207a09085d1 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -5882,6 +5882,11 @@ resource_size_t __weak pcibios_default_alignment(void)
> >         return 0;
> >  }
> >
> > +int __weak pcibios_ignore_alignment_request(void)
> > +{
> > +       return pci_has_flag(PCI_PROBE_ONLY);
> > +}
> > +
> >  #define RESOURCE_ALIGNMENT_PARAM_SIZE COMMAND_LINE_SIZE
> >  static char resource_alignment_param[RESOURCE_ALIGNMENT_PARAM_SIZE] = {0};
> >  static DEFINE_SPINLOCK(resource_alignment_lock);
> > @@ -5906,9 +5911,9 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
> >         p = resource_alignment_param;
> >         if (!*p && !align)
> >                 goto out;
> > -       if (pci_has_flag(PCI_PROBE_ONLY)) {
> > +       if (pcibios_ignore_alignment_request()) {
> >                 align = 0;
> > -               pr_info_once("PCI: Ignoring requested alignments (PCI_PROBE_ONLY)\n");
> > +               pr_info_once("PCI: Ignoring requested alignments\n");
> >                 goto out;
> >         }
> 
> I think the logic here is questionable to begin with. If the user has
> explicitly requested re-aligning a resource via the command line then
> we should probably do it even if PCI_PROBE_ONLY is set. When it breaks
> they get to keep the pieces.

I agree.  I don't like PCI_PROBE_ONLY in the first place.  It's a
sledgehammer approach that doesn't tell us which resource assignments
need to be preserved or why.  I'd rather use IORESOURCE_PCI_FIXED and
set it for the BARs where there's actually some sort of
hypervisor/firmware/OS dependency.

If there's a way to avoid another pciobios_*() weak function, that
would also be better.

Bjorn
