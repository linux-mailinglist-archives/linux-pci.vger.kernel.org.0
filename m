Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3CEF3F344F
	for <lists+linux-pci@lfdr.de>; Fri, 20 Aug 2021 21:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236293AbhHTTJ5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Aug 2021 15:09:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:56488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230327AbhHTTJ4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Aug 2021 15:09:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F83061101;
        Fri, 20 Aug 2021 19:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629486558;
        bh=k1DkM0RoF10WcRSB2B8HCMdchuSikCwXpDoLWO5fe3E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=EbLUDQbjbOeCfSxxPH4E2t3MuURBoEZOvJ5YJHfG98KWZl/Ei5wl8oT6MtkJZf3zP
         +uVJlKQYeLABdGpIY/wPmo0CGYl5GDNrg7eDeh+SUqjU2K7/sW5aiLbLwv23+NuUeN
         ieU8vslkffQyurom8LYRawVRr2Ko3mQUzjqCfFDmsP9zAGTGwUTA4gL8fq06byasUV
         mXpgjqZrWztxM2hyjA04cfPAzO3NXro0z/xWf9dZ9ek+pA7CNEIOikFbQZbNtbWwtW
         zGaq0kjqrqPYd5IVnrOcpdpnDEdQvI4JKhgy8sr/QdRj9t6lLkuujujzhKjoaH40yd
         AZOmf5Z7zNmXQ==
Date:   Fri, 20 Aug 2021 14:09:17 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        nsaenz@kernel.org, bhelgaas@google.com, rjw@rjwysocki.net,
        lenb@kernel.org, robh@kernel.org, kw@linux.com,
        f.fainelli@gmail.com, sdonthineni@nvidia.com,
        stefan.wahren@i2se.com, bcm-kernel-feedback-list@broadcom.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] MAINTAINERS: Widen brcmstb PCIe file scope
Message-ID: <20210820190917.GA3340819@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819215655.84866-5-jeremy.linton@arm.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 19, 2021 at 04:56:55PM -0500, Jeremy Linton wrote:
> The brcmstb PCI hardware is now split across
> multiple files. Include them in the maintainers
> block.

Rewrap to fill 75 columns or so.

> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fd25e4ecf0b9..605a385cea36 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3500,7 +3500,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git
>  F:	Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> -F:	drivers/pci/controller/pcie-brcmstb.c
> +F:	drivers/pci/controller/pcie-brcmstb*

There are already two entries that mention
drivers/pci/controller/pcie-brcmstb.c, and a patch headed for v5.14
adds a third.  Do you want to update them all?

>  F:	drivers/staging/vc04_services
>  N:	bcm2711
>  N:	bcm283*
> -- 
> 2.31.1
> 
