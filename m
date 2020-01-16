Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6525313FBA1
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2020 22:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbgAPVgI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Jan 2020 16:36:08 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39077 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbgAPVgI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Jan 2020 16:36:08 -0500
Received: by mail-pg1-f193.google.com with SMTP id b137so10556187pga.6;
        Thu, 16 Jan 2020 13:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:thread-topic:thread-index:date:message-id
         :references:in-reply-to:accept-language:content-language
         :content-transfer-encoding:mime-version;
        bh=VvHjOr4ACw42b4kMyCv1bwkltuHZ5dV8Yk2HQjQZAlI=;
        b=VXMxF6J4VZaz/Wz/4mgtW/q1blQp73b5J3ss4YXtK3xaICcRQ2TRvWJYSWTvfbf+x4
         3JsuoCOm02lXPCiVipKd7lZ6zlcBYl5iJpeMZG6mmvQhc8fijS4jm7OeXiOyUFI4ZyTp
         f2q2cRVF7yklkq/083axeifLLcevK4ZM19nRuhRLDaNEJX1PsllqFr8CEguV3Un01aZa
         d9eL7YrGUJxW5iuIj6Oese/tY5+ijzsL3iWNXvSnstqIf9LcFPOGgTfi+wYoPQHZ4nGu
         PaTKHQY0ff+/rjx04oBxocEGBXUDIL8zNXze+NH+Y8/GN9EMpn2w856KYdkpP2p6aYVD
         bybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:thread-topic:thread-index
         :date:message-id:references:in-reply-to:accept-language
         :content-language:content-transfer-encoding:mime-version;
        bh=VvHjOr4ACw42b4kMyCv1bwkltuHZ5dV8Yk2HQjQZAlI=;
        b=nw8gvnVs4nHYNulV8HcogCQwZXDurflFD8k+UlKXyGvGRQt/i8VQUBStDISYDZrzOQ
         8Lr2j/Wq0T4EgGGCb+syPhhXQoDtMox1uU0x8qyDnGcKywMuidq74RgtZebUJB/XC7N9
         7hHgbC9riNDxjAtDzVT45Lg2pgCYhnTcLKc7U7tLiV826udBRSrBHJBh0wQfwWloADX/
         48GRI83D1Thf3kVMZW881IJqiInv6Ln5kuivyxLQn7zZmSRnCFZepxoXyGD1rYe5+pRs
         9ptWuKxVrmp3T4UEBtXXcC7ajhO5Wt7I2rTeykdAWpfAqsKuHQ5seQ8c06/P1/J5z0vq
         D9fA==
X-Gm-Message-State: APjAAAVH3Hrqsi45S5aF3HDm4/mAOi8V4oGwoeSNgQICdC7hwM4zw8Bw
        uVZYepsvcXkOCsYg8eZaMBk=
X-Google-Smtp-Source: APXvYqxjr+BBlZeEcRR6QoKUFDGOvvBQdbcqg/tsq1gFgKlSEwc4bQlSKtnjEoU0a7Mq2ueap/gU1g==
X-Received: by 2002:a63:554c:: with SMTP id f12mr42586847pgm.23.1579210567196;
        Thu, 16 Jan 2020 13:36:07 -0800 (PST)
Received: from SL2P216MB0105.KORP216.PROD.OUTLOOK.COM ([2603:1046:100:22::5])
        by smtp.gmail.com with ESMTPSA id g2sm26555320pgn.59.2020.01.16.13.36.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Jan 2020 13:36:06 -0800 (PST)
From:   Jingoo Han <jingoohan1@gmail.com>
To:     Shawn Lin <shawn.lin@rock-chips.com>
CC:     Heiko Stuebner <heiko@sntech.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        William Wu <william.wu@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        Han Jingoo <jingoohan1@gmail.com>
Subject: Re: [PATCH 5/6] PCI: rockchip: add DesignWare based PCIe controller
Thread-Topic: [PATCH 5/6] PCI: rockchip: add DesignWare based PCIe controller
Thread-Index: AQHVyqvWb/c4FgGoOUOrdcU9dWh4vqft1IkR
X-MS-Exchange-MessageSentRepresentingType: 1
Date:   Thu, 16 Jan 2020 21:36:00 +0000
Message-ID: <SL2P216MB0105652DE83E7CBBDA2A370CAA360@SL2P216MB0105.KORP216.PROD.OUTLOOK.COM>
References: <1578986580-71974-1-git-send-email-shawn.lin@rock-chips.com>
 <1578986701-72072-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1578986701-72072-1-git-send-email-shawn.lin@rock-chips.com>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator: 
X-MS-Exchange-Organization-RecordReviewCfmType: 0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/14/20, 2:25 AM, Shawn Lin wrote:
>=20
> From: Simon Xue <xxm@rock-chips.com>
>
> Signed-off-by: Simon Xue <xxm@rock-chips.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
>
>  drivers/pci/controller/dwc/Kconfig            |   9 +
>  drivers/pci/controller/dwc/Makefile           |   1 +
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 441 ++++++++++++++++++++=
++++++
>  3 files changed, 451 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-dw-rockchip.c
>
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/=
dwc/Kconfig
> index 0830dfc..9160264 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -82,6 +82,15 @@ config PCIE_DW_PLAT_EP
>  	  order to enable device-specific features PCI_DW_PLAT_EP must be
>  	  selected.
> =20
> +config PCIE_DW_ROCKCHIP
> +	bool "Rockchip DesignWare PCIe controller"
> +	select PCIE_DW
> +	select PCIE_DW_HOST
> +	depends on ARCH_ROCKCHIP
> +	depends on OF
> +	help
> +	  Enables support for the DW PCIe controller in the Rockchip SoC.
> +

The order is PCIE_DW, PCI_*, and PCIE_* as below.

1. Common Frameworks:
    These options are used by other controller drivers.
    e.g., PCIE_DW, PCIE_DW_HOST, PCIE_DW_EP.

2. PCI_* controller drivers:
    PCI_* was used earlier than PCIE_*. If a chip vendor's controllers prov=
ide
    both conventional PCI and PCI Express, or only conventional PCI, PCI_* =
can
    be used.

3. PCIE_* controller drivers
    If a controller can support only PCI Express, not conventional PCI,
    PCIE_* is the proper naming.

Then, within PCI_* or PCIE_* categories, each controller option should be
in an alphabetical order for the readability.

So, add 'PCIE_DW_ROCKCHIP' between 'PCIE_ARTPEC6_EP' and 'PCIE_KIRIN'.

>
>  config PCI_EXYNOS
>  	bool "Samsung Exynos PCIe controller"
>  	depends on SOC_EXYNOS5440 || COMPILE_TEST
> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller=
/dwc/Makefile
> index 8a637cf..cb4857f 100644
> --- a/drivers/pci/controller/dwc/Makefile
> +++ b/drivers/pci/controller/dwc/Makefile
> @@ -19,6 +19,7 @@ obj-$(CONFIG_PCIE_HISI_STB) +=3D pcie-histb.o
>  obj-$(CONFIG_PCI_MESON) +=3D pci-meson.o
>  obj-$(CONFIG_PCIE_TEGRA194) +=3D pcie-tegra194.o
>  obj-$(CONFIG_PCIE_UNIPHIER) +=3D pcie-uniphier.o
> +obj-$(CONFIG_PCIE_DW_ROCKCHIP) +=3D pcie-dw-rockchip.o

Ditto.

[...]

Best regards,
Jingoo Han

