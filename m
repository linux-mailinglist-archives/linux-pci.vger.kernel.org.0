Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB89C375CFB
	for <lists+linux-pci@lfdr.de>; Thu,  6 May 2021 23:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbhEFVtm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 May 2021 17:49:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:52880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229572AbhEFVtm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 May 2021 17:49:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9730C61289;
        Thu,  6 May 2021 21:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620337723;
        bh=/xnbyNHiGvABXLOh4nGkPg4FBu6sR2mO28PZbtLlye4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=u9E7QSXlH3EbybDAE2tV6zPEqGCM9WIPV/6pK9OJanj+RFO9OFa839lIezM2c61Bh
         Gow5KNWIKd28enuGA/z7K2IvnqckfEofDBa7dTi0mvaIevNOgpeFJJ4Swi0tJWUZoU
         m25ZaZUODDkTiXwAbxYZa9fgD1Gcr49RSN52fb3fCk4GjPaB8+Qq8jOD/LXQ2lnFSP
         vyZi5/7co9MaOTh5XBiMsxfsqoLmRr7VCX+IxvY6IUBMHyZ3amGHig6H7nciL9QW1v
         bWlzXNnqICKqXpG4SGNxiJ73B0sauunBOmCyenR6Ol5ZtxA8EqqWaBVIMcXsHVo8WE
         J9fxbUAtqF7zQ==
Date:   Thu, 6 May 2021 16:48:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Konstantin Kharlamov <Hi-Angel@yandex.ru>
Cc:     linux-pci@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andreas Noever <andreas.noever@gmail.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] PCI: don't power-off apple thunderbolt controller on
 s2idle
Message-ID: <20210506214842.GA1436993@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210506173820.21876-1-Hi-Angel@yandex.ru>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Rafael, Andreas, linux-pm]

On Thu, May 06, 2021 at 08:38:20PM +0300, Konstantin Kharlamov wrote:
> On Macbook 2013 resuming from s2idle results in external monitor no
> longer being detected, and dmesg having errors like:
> 
>     pcieport 0000:06:00.0: can't change power state from D3hot to D0 (config space inaccessible)
> 
> and a stacktrace. The reason turned out that the hw that the quirk
> powers off does not get powered on back on resume.

quirk_apple_poweroff_thunderbolt() was added in 2014 by 1df5172c5c25
("PCI: Suspend/resume quirks for Apple thunderbolt").  It claims
"power is automatically restored before resume," so there must be
something special about s2idle that prevents the power-on.

IIUC this change will reduce the s2idle power savings.  I would feel
better about this if we understood what the difference was.  

> Thus, add a check for s2idle to the quirk, and do nothing if the suspend
> mode is s2idle.

Obviously the *hardware* hasn't changed since 1df5172c5c25.  Is s2idle
something that wasn't tested back then, or is this problem connected
to an s2idle change since then?  Can we identify a commit that
introduced this problem?  That would help with backporting or stable
tags.

> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=212767

Thanks for this!  Would you mind attaching the output of
"sudo lspci -vvv"?  If you attach any other dmesg, could you
use "dmesg --color=never" so the log doesn't include all the
escape characters?

> Signed-off-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
> ---
>  drivers/pci/quirks.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 653660e3ba9e..86fedcec37e2 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -27,6 +27,7 @@
>  #include <linux/nvme.h>
>  #include <linux/platform_data/x86/apple.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/suspend.h>
>  #include <linux/switchtec.h>
>  #include <asm/dma.h>	/* isa_dma_bridge_buggy */
>  #include "pci.h"
> @@ -3646,6 +3647,13 @@ static void quirk_apple_poweroff_thunderbolt(struct pci_dev *dev)
>  		return;
>  	if (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM)
>  		return;
> +
> +	/*
> +	 * If suspend mode is s2idle, power won't get restored on resume.
> +	 */
> +	if (!pm_suspend_via_firmware())
> +		return;
> +
>  	bridge = ACPI_HANDLE(&dev->dev);
>  	if (!bridge)
>  		return;
> -- 
> 2.31.1
> 
