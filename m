Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBB1B4628B6
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 00:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbhK2X7M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Nov 2021 18:59:12 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:56478 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhK2X7M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Nov 2021 18:59:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8343DCE093B;
        Mon, 29 Nov 2021 23:55:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73232C53FC7;
        Mon, 29 Nov 2021 23:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638230150;
        bh=caJLxRnOOUvs9NbsXGU86f6l73oZPp0ipg5BxTi8yTg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fmeSjSHHGScKJXlcmE/ndq14LzGZSuFX8Sxs+8n0pNZJY7sEG3sQ9m49RyHUPQiTW
         CTKhX9Lr/KlUCDxlFzkXs3/kH8NLQqSIfPEOf6jWuiY34CGfziRTm8sak6y2RrzFaA
         3su3/M1YKKUnzhbQTL4va/EEvGObulo1GyKNMl1vW+V30uHIOZskAIl0LqETp5jv4b
         dMLXqWZ8hHp6tYcuS3W+8hyV4zXCAysMkQXz1e6EXpZlSvSk49ScCNdOkCsrSVdsCh
         XH6M06v8L724cZHK2aZrkpq+d0II5ajVozGKj26vadw7tS3VVIDARTvSfUAYJXWB9B
         3CsufW9IFPr6g==
Date:   Mon, 29 Nov 2021 17:55:49 -0600
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
Subject: Re: [PATCH v5 09/13] PCI: mediatek: allow selecting controller
 driver for airoha arch
Message-ID: <20211129235549.GA2704502@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129153330.37719-10-nbd@nbd.name>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 29, 2021 at 04:33:25PM +0100, Felix Fietkau wrote:
> The EN7523 SoC uses the same controller as MT7622

If you have occasion to post a v6, please:

  - Update the subject line so it starts with a capital letter,
    capitalizes "Airoha" appropriately, and includes "EN7523" as your
    DT patch does, and moves those close to the beginning, e.g.,

      PCI: mediatek: Allow selection for Airoha EN7532

  - Update the commit log so it says what this patch does.  It's OK to
    repeat the subject line.  Add a period at end.

I expected a patch to add "airoha,en7523-pcie" to
drivers/pci/controller/pcie-mediatek.c.  Did I miss it?

Oh, I see your arch/arm/boot/dts/en7523.dtsi has:

  +       pcie0: pcie@1fa91000 {
  +               compatible = "airoha,en7523-pcie", "mediatek,mt7622-pcie";

so I guess you just rely on the existing "mediatek,mt7622-pcie" string
in the driver?

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
