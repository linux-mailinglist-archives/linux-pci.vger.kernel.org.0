Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C13383A230C
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jun 2021 06:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhFJEGZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Jun 2021 00:06:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:40728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229592AbhFJEGY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Jun 2021 00:06:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB2D2613FF;
        Thu, 10 Jun 2021 04:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623297869;
        bh=gp8DSf2esejDzMXehJatTxOWzp66b5XoGY3UTIHCbD8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=AZmcaE+0HKjr2RD9KRGy4kZ97dxs/cgNCvnqI1q9uOmfdb1Rj2q3RPh84QE/mct9J
         wx4/AIzg8GsqluYOOlMEfzfDGFCYIgieeqsMET8dR4vq+6pVKLHzXBK4dV05+c896U
         SxMr26o02Arm84iU8LcbESBixMhb+hezwxvM8OBfes3NoRWP6kObdcdx1vFuVVa5cl
         vZgHwdXMprNIznRLN4xjppEvlU0phebLYC2UgXyMN+8ToASg3uI3Q3dqY80WyE9B+x
         nWWHqnGEkH/BM0c1IMSxTYwXaSxGyAKO486tR26hmP/ibsgQLo4VwVPmclLr1jBvfD
         yU9BrsH3g0XIA==
Date:   Wed, 9 Jun 2021 23:04:27 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Punit Agrawal <punitagrawal@gmail.com>, robh+dt@kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, alexandru.elisei@arm.com, wqu@suse.com,
        robin.murphy@arm.com, pgwipeout@gmail.com, ardb@kernel.org,
        briannorris@chromium.org, shawn.lin@rock-chips.com
Subject: Re: [PATCH v3 2/4] PCI: of: Relax the condition for warning about
 non-prefetchable memory aperture size
Message-ID: <20210610040427.GA2696540@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac6bf3c8-fe8e-5897-b225-699a7c46a818@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 09, 2021 at 12:36:08AM +0530, Vidya Sagar wrote:
> On 6/7/2021 4:58 PM, Punit Agrawal wrote:
> > 
> > Commit fede8526cc48 ("PCI: of: Warn if non-prefetchable memory
> > aperture size is > 32-bit") introduced a warning for non-prefetchable
> > resources that need more than 32bits to resolve. It turns out that the
> > check is too restrictive and should be applicable to only resources
> > that are limited to host bridge windows that don't have the ability to
> > map 64-bit address space.
>
> I think the host bridge windows having the ability to map 64-bit address
> space is different from restricting the non-prefetchable memory aperture
> size to 32-bit.

> Whether the host bridge uses internal translations or not to map the
> non-prefetchable resources to 64-bit space, the size needs to be programmed
> in the host bridge's 'Memory Limit Register (Offset 22h)' which can
> represent sizes only fit into 32-bits.

> Host bridges having the ability to map 64-bit address spaces gives
> flexibility to utilize the vast 64-bit space for the (restrictive)
> non-prefetchable memory (i.e. mapping non-prefetchable BARs of endpoints to
> the 64-bit space in CPU's view) and get it translated internally and put a
> 32-bit address on the PCIe bus finally.

The vastness of the 64-bit space in the CPU view only helps with
non-prefetchable memory if you have multiple host bridges with
different CPU-to-PCI translations.  Each root bus can only carve up
4GB of PCI memory space for use by its non-prefetchable memory
windows.

Of course, if we're willing to give up the performance, there's
nothing to prevent us from using non-prefetchable space for
*prefetchable* resources, as in my example below.

I think the fede8526cc48 commit log is incorrect, or at least
incomplete:

  As per PCIe spec r5.0, sec 7.5.1.3.8 only 32-bit BAR registers are defined
  for non-prefetchable memory and hence a warning should be reported when
  the size of them go beyond 32-bits.

7.5.1.3.8 is talking about non-prefetchable PCI-to-PCI bridge windows,
not BARs.  AFAIK, 64-bit BARs may be non-prefetchable.  The warning is
in pci_parse_request_of_pci_ranges(), which isn't looking at
PCI-to-PCI bridge windows; it's looking at PCI host bridge windows.
It's legal for a host bridge to have only non-prefetchable windows,
and prefetchable PCI BARs can be placed in them.

For example, we could have the following:

  pci_bus 0000:00: root bus resource [mem 0x80000000-0x1_ffffffff] (6GB)
  pci 0000:00:00.0: PCI bridge to [bus 01-7f]
  pci 0000:00:00.0:   bridge window [mem 0x80000000-0xbfffffff] (1GB)
  pci 0000:00:00.0:   bridge window [mem 0x1_00000000-0x1_7fffffff 64bit pref] (2GB)
  pci 0000:00:00.1: PCI bridge to [bus 80-ff]
  pci 0000:00:00.1:   bridge window [mem 0xc0000000-0xffffffff] (1GB)
  pci 0000:00:00.1:   bridge window [mem 0x1_80000000-0x1_ffffffff 64bit pref] (2GB)

Here the host bridge window is 6GB and is not prefetchable.  The
PCI-to-PCI bridge non-prefetchable windows are 1GB each and the bases
and limits fit in 32 bits.  The prefetchable windows are 2GB each, and
we're allowed but not required to put these in prefetchable host
bridge windows.

So I'm not convinced this warning is valid to begin with.  It may be
that this host bridge configuration isn't optimal, and we might want
an informational message, but I think it's *legal*.

> > Relax the condition to only warn when the resource size requires >
> > 32-bits and doesn't allow mapping to 64-bit addresses.
> > 
> > Link: https://lore.kernel.org/r/7a1e2ebc-f7d8-8431-d844-41a9c36a8911@arm.com
> > Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
> > Tested-by: Alexandru Elisei <alexandru.elisei@arm.com>
> > Cc: Vidya Sagar <vidyas@nvidia.com>
> > ---
> >   drivers/pci/of.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > index 1e45186a5715..38fe2589beb0 100644
> > --- a/drivers/pci/of.c
> > +++ b/drivers/pci/of.c
> > @@ -581,7 +581,8 @@ static int pci_parse_request_of_pci_ranges(struct device *dev,
> >                          res_valid |= !(res->flags & IORESOURCE_PREFETCH);
> > 
> >                          if (!(res->flags & IORESOURCE_PREFETCH))
> > -                               if (upper_32_bits(resource_size(res)))
> > +                               if (!(res->flags & IORESOURCE_MEM_64) &&
> > +                                   upper_32_bits(resource_size(res)))
> >                                          dev_warn(dev, "Memory resource size exceeds max for 32 bits\n");
> > 
> >                          break;
> > --
> > 2.30.2
> > 
