Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60FD343BC63
	for <lists+linux-pci@lfdr.de>; Tue, 26 Oct 2021 23:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239617AbhJZVbH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Oct 2021 17:31:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:56818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239602AbhJZVbC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Oct 2021 17:31:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 43F1F60EC0;
        Tue, 26 Oct 2021 21:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635283717;
        bh=vZzMrLdzjVgl45kMa17jL2Gl11RNsZN64ShKJDy3pBs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=p69Of5Nb8lT9mXleEJ1X0d8EgyRhLVY3JWLEhq4dV5LvQoLSGE6IjjVmB2ugvbE6q
         ZnODEE/9YODv39TDzYi9ddPt0Iezj+52j+mUAYF7h/S8QOB7TAajXY8Cb7PPCd3NOd
         vzqenPmN5PL7CMYm3kW7OP6jW6beiPdgxA3aOiwZKI7CNH0Xl73y3z78MOuHnN8/cz
         lp8jUuKqJdxQhvbTude5bSSzTNqgfcPOKpisdhNwmhMnGhpedBhE0shRS62wnyjX6z
         WqaQd+y7y0RXz3gwJfx2tubVHtmrNnTiroOldWkm+Ua7obGjHMsSOAf8q6J38miK/G
         oNXC3oPQfFd7w==
Date:   Tue, 26 Oct 2021 16:28:35 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Robin McCorkell <robin@mccorkell.me.uk>
Cc:     linux-pci@vger.kernel.org,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Nirmoy Das <nirmoy.das@amd.com>
Subject: Re: [PATCH] Limit AMD Radeon rebar hack to a single revision
Message-ID: <20211026212835.GA167500@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211026204639.21178-1-robin@mccorkell.me.uk>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Christian, Nirmoy, authors of 907830b0fc9e]

Subject line should look like previous ones for this file, e.g.,

  88769e64cf99 ("PCI: Add ACS quirk for Pericom PI7C9X2G switches")
  e3f4bd3462f6 ("PCI: Mark Atheros QCA6174 to avoid bus reset")
  60b78ed088eb ("PCI: Add AMD GPU multi-function power dependencies")
  8304a3a199ee ("PCI: Set dma-can-stall for HiSilicon chips")
  8c09e896cef8 ("PCI: Allow PASID on fake PCIe devices without TLP prefixes")
  32837d8a8f63 ("PCI: Add ACS quirks for Cavium multi-function devices")
  e0bff4322092 ("PCI: Increase D3 delay for AMD Renoir/Cezanne XHCI")
  ...
  907830b0fc9e ("PCI: Add a REBAR size quirk for Sapphire RX 5600 XT Pulse")

Would be good to mention "Sapphire RX 5600 XT Pulse" explicitly since
that's what 907830b0fc9e said.

On Tue, Oct 26, 2021 at 09:46:38PM +0100, Robin McCorkell wrote:
> A particular RX 5600 device requires a hack in the rebar logic, but the
> current branch is too general and catches other devices too, breaking
> them. This patch changes the branch to be more selective on the
> particular revision.
> 
> See also: https://gitlab.freedesktop.org/drm/amd/-/issues/1707

There's a lot of legwork in the bug report to bisect this, but no
explanation of what the root cause turned out to be.

907830b0fc9e says RX 5600 XT Pulse advertises 256MB-1GB BAR 0 sizes but
actually supports up to 8GB.

Does this patch mean your RX 5600 XT Pulse supports fewer sizes and 
advertises them correctly?  And consequently we resize BAR 0 to
something that's too big, and something fails when we try to access
the part the isn't actually implemented by the device? 

It would be useful to attach your "lspci -vv" output to the bug
report.

> This patch fixes intermittent freezes on other RX 5600 devices where the
> hack is unnecessary. Credit to all contributors in the linked issue on
> the AMD bug tracker.

Thanks.  This would need a signed-off-by [1].

We should also include a "Fixes:" line for the commit the problem was
bisected to, 907830b0fc9e ("PCI: Add a REBAR size quirk for Sapphire
RX 5600 XT Pulse"), if I understand correctly, e.g.,

  Fixes: 907830b0fc9e ("PCI: Add a REBAR size quirk for Sapphire RX 5600 XT Pulse")

And probably a stable tag, since 907830b0fc9e appeared in v5.12, e.g.,

  Cc: stable@vger.kernel.org	# v5.12+

If stable maintainers backported 907830b0fc9e to earlier kernels, as
it appears they have, it's up to them to watch for fixes to
907830b0fc9e.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=v5.14#n365

> ---
>  drivers/pci/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index ce2ab62b64cf..1fe75243019e 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3647,7 +3647,7 @@ u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar)
>  
>  	/* Sapphire RX 5600 XT Pulse has an invalid cap dword for BAR 0 */
>  	if (pdev->vendor == PCI_VENDOR_ID_ATI && pdev->device == 0x731f &&
> -	    bar == 0 && cap == 0x7000)
> +	    pdev->revision == 0xC1 && bar == 0 && cap == 0x7000)

I'd like to get the AMD folks to chime in and confirm that revision
0xC1 is the only one that requires this quirk.

>  		cap = 0x3f000;
>  
>  	return cap >> 4;
> -- 
> 2.31.1
> 
