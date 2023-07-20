Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1315E75AC93
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jul 2023 13:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjGTLH6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jul 2023 07:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjGTLH4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jul 2023 07:07:56 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1B326A3;
        Thu, 20 Jul 2023 04:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1689851271; x=1721387271;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kRnPBYIg/Txid4eQMW5mWguX6Sa02z6B8L96xUlIcwA=;
  b=je8sQ/nRC2fmRGykXXGVeywNz+Xgzn6uXmTZoqZqiySRX+rn4mEO4W/3
   Za7TjnrLqdICm5g2w2NpkPhLNMpL2h/yLSfuu7XBOgdJN/PFIHWs1V2Dz
   r9W+bWthtt0M3xgJ94vdUf3LSRihy8REWjBkcemN+8MK/i3TJbcQ1YDSV
   pBdOJfAYX9zJe6wzTKAf3TfxAaP5MOP2iadnuHpjrlpN3ID5z0cOnXJ7L
   EECDflkZWtqbvC7PppAQdkgxN4ItooFDFniOwNlo4mDTLo4MXFdWC/ur/
   movByS4Kq/BCyOjDVlMgG+3x5YraqBMaacEUhm0R3WrRuinl4qvU8xhc8
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="asc'?scan'208";a="236690299"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jul 2023 04:07:51 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 20 Jul 2023 04:07:50 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 20 Jul 2023 04:07:47 -0700
Date:   Thu, 20 Jul 2023 12:07:14 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Minda Chen <minda.chen@starfivetech.com>
CC:     Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
Subject: Re: [PATCH v1 4/9] PCI: microchip: Move PCIe driver to PLDA directory
Message-ID: <20230720-parched-laborer-a8416d86a85e@wendy>
References: <20230719102057.22329-1-minda.chen@starfivetech.com>
 <20230719102057.22329-5-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="R981OROlZpffAhaD"
Content-Disposition: inline
In-Reply-To: <20230719102057.22329-5-minda.chen@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--R981OROlZpffAhaD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Minda,

On Wed, Jul 19, 2023 at 06:20:52PM +0800, Minda Chen wrote:
> Move Microchip specific platform codes to PLDA directory.
> Including clock init, interrupt event handle and platform
> init codes.
>=20
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> ---
>  MAINTAINERS                                   |   4 +-
>  drivers/pci/controller/Kconfig                |   8 -
>  drivers/pci/controller/Makefile               |   1 -
>  drivers/pci/controller/plda/Kconfig           |  10 +-
>  drivers/pci/controller/plda/Makefile          |   1 +
>  .../{ =3D> plda}/pcie-microchip-host.c          | 594 ++----------------

I think that you should squash this with the previous patch, rather than
duplicate the code and then de-duplicate it, so that it is more obvious
what is being extracted.

>  6 files changed, 55 insertions(+), 563 deletions(-)
>  rename drivers/pci/controller/{ =3D> plda}/pcie-microchip-host.c (50%)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3b3c4d8808ae..f02618c2bdf5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16503,7 +16503,7 @@ M:	Daire McNamara <daire.mcnamara@microchip.com>
>  L:	linux-pci@vger.kernel.org
>  S:	Supported
>  F:	Documentation/devicetree/bindings/pci/microchip*
> -F:	drivers/pci/controller/*microchip*
> +F:	drivers/pci/controller/plda/*microchip*
> =20
>  PCIE DRIVER FOR QUALCOMM MSM
>  M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> @@ -18287,7 +18287,7 @@ F:	drivers/char/hw_random/mpfs-rng.c
>  F:	drivers/clk/microchip/clk-mpfs*.c
>  F:	drivers/i2c/busses/i2c-microchip-corei2c.c
>  F:	drivers/mailbox/mailbox-mpfs.c
> -F:	drivers/pci/controller/pcie-microchip-host.c
> +F:	drivers/pci/controller/plda/pcie-microchip-host.c
>  F:	drivers/pwm/pwm-microchip-core.c
>  F:	drivers/reset/reset-mpfs.c
>  F:	drivers/rtc/rtc-mpfs.c
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kcon=
fig
> index a106dabcb8dc..107cdb69e15c 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -216,14 +216,6 @@ config PCIE_MT7621
>  	help
>  	  This selects a driver for the MediaTek MT7621 PCIe Controller.
> =20
> -config PCIE_MICROCHIP_HOST
> -	bool "Microchip AXI PCIe controller"
> -	depends on PCI_MSI && OF
> -	select PCI_HOST_COMMON
> -	help
> -	  Say Y here if you want kernel to support the Microchip AXI PCIe
> -	  Host Bridge driver.
> -
>  config PCI_HYPERV_INTERFACE
>  	tristate "Microsoft Hyper-V PCI Interface"
>  	depends on ((X86 && X86_64) || ARM64) && HYPERV && PCI_MSI
> diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Mak=
efile
> index aa0a691ebcbc..93236dc97b21 100644
> --- a/drivers/pci/controller/Makefile
> +++ b/drivers/pci/controller/Makefile
> @@ -32,7 +32,6 @@ obj-$(CONFIG_PCIE_ROCKCHIP_EP) +=3D pcie-rockchip-ep.o
>  obj-$(CONFIG_PCIE_ROCKCHIP_HOST) +=3D pcie-rockchip-host.o
>  obj-$(CONFIG_PCIE_MEDIATEK) +=3D pcie-mediatek.o
>  obj-$(CONFIG_PCIE_MEDIATEK_GEN3) +=3D pcie-mediatek-gen3.o
> -obj-$(CONFIG_PCIE_MICROCHIP_HOST) +=3D pcie-microchip-host.o
>  obj-$(CONFIG_VMD) +=3D vmd.o
>  obj-$(CONFIG_PCIE_BRCMSTB) +=3D pcie-brcmstb.o
>  obj-$(CONFIG_PCI_LOONGSON) +=3D pci-loongson.o
> diff --git a/drivers/pci/controller/plda/Kconfig b/drivers/pci/controller=
/plda/Kconfig
> index 37e17326671b..fb274976b84b 100644
> --- a/drivers/pci/controller/plda/Kconfig
> +++ b/drivers/pci/controller/plda/Kconfig
> @@ -4,8 +4,16 @@ menu "PLDA PCIe controllers support"
>  	depends on PCI
> =20
>  config PCIE_PLDA_HOST
> -	bool "PLDA PCIe host controller"
> +	bool
>  	depends on OF && PCI_MSI

Is this okay w.r.t. unmet dependencies? IOW, if PCI_MSI is disabled,
PCIE_MICROCHIP_HOST can still select PCIE_PLDA_HOST, no?

>  	select IRQ_DOMAIN
> =20
> +config PCIE_MICROCHIP_HOST
> +	bool "Microchip AXI PCIe controller"
> +	select PCI_HOST_COMMON
> +	select PCIE_PLDA_HOST
> +	help
> +	  Say Y here if you want kernel to support the Microchip AXI PCIe
> +	  Host Bridge driver.
> +
>  endmenu
> diff --git a/drivers/pci/controller/plda/Makefile b/drivers/pci/controlle=
r/plda/Makefile
> index 79dbae655c2b..4340ab007f44 100644
> --- a/drivers/pci/controller/plda/Makefile
> +++ b/drivers/pci/controller/plda/Makefile
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_PCIE_PLDA_HOST) +=3D pcie-plda-host.o
> +obj-$(CONFIG_PCIE_MICROCHIP_HOST) +=3D pcie-microchip-host.o

--R981OROlZpffAhaD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLkVYgAKCRB4tDGHoIJi
0k0bAQCls5FIJwFB57TYTloKZdZpGhbCdYfiHdflmFpajndJsQD6ApkFiSrTI7Lc
iflf2JhxaeFtKVbea64gWAB2NFZTTQ8=
=QWY5
-----END PGP SIGNATURE-----

--R981OROlZpffAhaD--
