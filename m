Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE2F46A691
	for <lists+linux-pci@lfdr.de>; Mon,  6 Dec 2021 21:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349214AbhLFUOn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Dec 2021 15:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349005AbhLFUOn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Dec 2021 15:14:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5841EC061746;
        Mon,  6 Dec 2021 12:11:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F5E6B81252;
        Mon,  6 Dec 2021 20:11:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E91C341C1;
        Mon,  6 Dec 2021 20:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638821471;
        bh=sk7m/9ChjeTsUjA1qk7j5ctQRQdk4uoA60tUGbHHSbY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Ijqw3kx78+LoGUnZpNWhLrf6RJGhHPXcRbeTgQpFuaMUVRTUTWI8XhpfU07JhYiF6
         5DEgw+7DXFREt8rqlLdP05XBl37ZYamSIRws3GbozwvAdDznYkF/eTrhwsrvuNvsw4
         kP997oKmoV2ltKht/7ZgM4FStAZ3TGzwmR5rJMsuy1j/hjV3bvreo8ubXb1O/nUpdc
         0ZuuNv62ge7uND2fceBU1CmJoWxCV/QAdsnKHgDl3Dv7iwOu+EOHYM/XtqNNlyBmGk
         U4fo439hFDcGJlkk3uYOG4rCwSbX5oN2g3G9i++wbM4d8lo1jT3NQiDve8zHXgz8li
         yTsyLZMLn7nZQ==
Date:   Mon, 6 Dec 2021 14:11:10 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>, john@phrozen.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v6 10/14] PCI: mediatek: allow selecting controller
 driver for airoha arch
Message-ID: <20211206201110.GA7319@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203113331.20510-11-nbd@nbd.name>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 03, 2021 at 12:33:27PM +0100, Felix Fietkau wrote:
> The EN7523 SoC uses the same controller as MT7622

See https://lore.kernel.org/r/20211206200601.GA7175@bhelgaas

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
> 2.30.1
> 
