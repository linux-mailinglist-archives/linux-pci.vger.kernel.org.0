Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 107AC479169
	for <lists+linux-pci@lfdr.de>; Fri, 17 Dec 2021 17:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238569AbhLQQZa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Dec 2021 11:25:30 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58750 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238005AbhLQQZa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Dec 2021 11:25:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C886A622F0;
        Fri, 17 Dec 2021 16:25:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E51AEC36AE8;
        Fri, 17 Dec 2021 16:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639758329;
        bh=K2+x1WBF60nqGDXE3hSHxTF/9S7av35S8BbzdwS/bII=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=l8hwWpJtkqVosVL1Kl9DrJR9eNeTjGsOabJ1jmqTyRBnOdLlGFscPuQAyytPGUMMW
         2fmAkkhuPt4g5lEQJlqW/8B+8zyfLPpzInlCtXQ0SV2ZNwCV9FoHzgVPXRmJfv6x9A
         BdxclGi+welPPl4Y+1Ns2caPVXlnfbmURx8QDbMThG/ant8ydu07RMYr9REQFpIHMd
         C+vf0gZGuJ07uEnz6Bi2jkwNLhbE7b/clp/fVKVjOhADCpHEaUyLhPni4D++wWGFX7
         8VUiu/sYaWCWz2N8UeGQR0bhxbm6eRP4WHy2nti+di5Z91/eJnIy4XjbSNO5e0342r
         05TvmL0xbe+Lw==
Date:   Fri, 17 Dec 2021 10:25:27 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>, john@phrozen.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v7 10/14] PCI: mediatek: Allow selecting controller
 driver for airoha arch
Message-ID: <20211217162527.GA895301@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217112345.14029-11-nbd@nbd.name>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 17, 2021 at 12:23:40PM +0100, Felix Fietkau wrote:
> This patch allows selecting the pcie-mediatek driver if ARCH_AIROHA is set,
> because the Airoha EN7523 SoC uses the same controller as MT7622.
> The driver itself is not modified. The PCIe controller DT node should use
> mediatek,mt7622-pcie after airoha,en7523-pcie.

s/This patch allows/Allow/ ("This patch" is redundant)

For the subject:

  PCI: mediatek: Allow building for ARCH_AIROHA

since "controller driver" is similarly redundant and this earlier patch
does essentially the same for a different case:

  70060ee313be ("PCI: brcmstb: Allow building for BMIPS_GENERIC")

> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  drivers/pci/controller/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index 93b141110537..f1342059c2a3 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -233,7 +233,7 @@ config PCIE_ROCKCHIP_EP
>  
>  config PCIE_MEDIATEK
>  	tristate "MediaTek PCIe controller"
> -	depends on ARCH_MEDIATEK || COMPILE_TEST
> +	depends on ARCH_AIROHA || ARCH_MEDIATEK || COMPILE_TEST
>  	depends on OF
>  	depends on PCI_MSI_IRQ_DOMAIN
>  	help
> -- 
> 2.34.1
> 
