Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE2923DADC4
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jul 2021 22:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbhG2UjU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jul 2021 16:39:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:59192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232948AbhG2UjT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Jul 2021 16:39:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ADD3F60F46;
        Thu, 29 Jul 2021 20:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627591156;
        bh=23CvQYj7vBJPIjUpKtfNVlJJTUdpVKDePqdpdjh4i60=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BDxjlUky75ruJkim/jfgnv1psAhwyFUZZMx64lrPe/YQmLAEzufYQ/aVQsQwAglDV
         NGXKis8HHUw7/I0oWVuG7Jgd+RwG2NC2SDGMRCvCagGqxXcrGAddKIKSnPPfQxQcMW
         MQOPNzofgg8nxr0tj3A+mBgTPbvfmqGNmoDuIBh8YM5uLABj0X/ggP0j2LSj6FYjI/
         6qtFoEz6oNuAfbrrFpVv5/pnLzUu7cWIY+jconcr/Fe1yJKsqpfZNELsJ8cjcmztdG
         5kCigXDexL5R3GoZWedJdhdA5k08GG6l5heG7OoHhaQZbTTJfI4I3vNovQZLAR5EKX
         gmq4LXmHjEnrQ==
Date:   Thu, 29 Jul 2021 15:39:14 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        Marcin Bachry <hegel666@gmail.com>, mario.limonciello@amd.com,
        prike.liang@amd.com, shyam-sundar.s-k@amd.com
Subject: Re: [PATCH] PCI: quirks: Quirk PCI d3hot delay for AMD xhci
Message-ID: <20210729203914.GA987812@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722025858.220064-1-alexander.deucher@amd.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 21, 2021 at 10:58:58PM -0400, Alex Deucher wrote:
> From: Marcin Bachry <hegel666@gmail.com>
> 
> Renoir needs a similar delay.
> 
> [Alex: I talked to the AMD USB hardware team and the
>  AMD windows team and they are not aware of any HW
>  errata or specific issues.  The HW works fine in
>  windows.  I was told windows uses a rather generous
>  default delay of 100ms for PCI state transitions.]
> 
> Signed-off-by: Marcin Bachry <hegel666@gmail.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Added stable tag and applied to pci/pm for v5.15, thanks!

> Cc: mario.limonciello@amd.com
> Cc: prike.liang@amd.com
> Cc: shyam-sundar.s-k@amd.com
> ---
> 
> Bjorn,
> 
> With the above comment in mind, would you consider this patch
> or would you prefer to increase the default timeout on Linux?
> 100ms seems a bit long and most devices seems to work within
> that limit.  Additionally, this patch doesn't seem to be
> required on all AMD platforms with the affected USB controller,
> so I suspect the current timeout on Linux is probably about
> right.  Increasing it seems to fix some of the marginal cases.
> 
> Alex
> 
>  drivers/pci/quirks.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 22b2bb1109c9..dea10d62d5b9 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -1899,6 +1899,7 @@ static void quirk_ryzen_xhci_d3hot(struct pci_dev *dev)
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x15e0, quirk_ryzen_xhci_d3hot);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x15e1, quirk_ryzen_xhci_d3hot);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1639, quirk_ryzen_xhci_d3hot);
>  
>  #ifdef CONFIG_X86_IO_APIC
>  static int dmi_disable_ioapicreroute(const struct dmi_system_id *d)
> -- 
> 2.31.1
> 
