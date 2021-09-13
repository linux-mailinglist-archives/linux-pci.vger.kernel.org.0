Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0995F409DFC
	for <lists+linux-pci@lfdr.de>; Mon, 13 Sep 2021 22:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241684AbhIMUOG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Sep 2021 16:14:06 -0400
Received: from rosenzweig.io ([138.197.143.207]:46318 "EHLO rosenzweig.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233368AbhIMUOF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Sep 2021 16:14:05 -0400
Date:   Mon, 13 Sep 2021 14:55:53 -0400
From:   Alyssa Rosenzweig <alyssa@rosenzweig.io>
To:     Marc Zyngier <maz@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Stan Skowronek <stan@corellium.com>,
        Mark Kettenis <kettenis@openbsd.org>,
        Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>,
        Robin Murphy <Robin.Murphy@arm.com>, kernel-team@android.com
Subject: Re: [PATCH v3 09/10] iommu/dart: Exclude MSI doorbell from PCIe
 device IOVA range
Message-ID: <YT+euTycu1hp75L8@sunset>
References: <20210913182550.264165-1-maz@kernel.org>
 <20210913182550.264165-10-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913182550.264165-10-maz@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> +config PCIE_APPLE_MSI_DOORBELL_ADDR
> +	hex
> +	default 0xfffff000
> +	depends on PCIE_APPLE
> +
>  config PCIE_APPLE
>  	tristate "Apple PCIe controller"
>  	depends on ARCH_APPLE || COMPILE_TEST
> diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
> index 1ed7b90f8360..76344223245d 100644
> --- a/drivers/pci/controller/pcie-apple.c
> +++ b/drivers/pci/controller/pcie-apple.c
> @@ -120,8 +120,10 @@
>   * The doorbell address is set to 0xfffff000, which by convention
>   * matches what MacOS does, and it is possible to use any other
>   * address (in the bottom 4GB, as the base register is only 32bit).
> + * However, it has to be excluded from the the IOVA range, and the
> + * DART driver has to know about it.
>   */
> -#define DOORBELL_ADDR			0xfffff000
> +#define DOORBELL_ADDR		CONFIG_PCIE_APPLE_MSI_DOORBELL_ADDR

I'm unsure if Kconfig is the right place for this. But if it is, these
hunks should be moved earlier in the series (so the deletion gets
squashed away of the hardcoded-in-the-C.)
