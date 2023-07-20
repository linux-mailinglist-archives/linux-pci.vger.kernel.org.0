Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B91F75ACA2
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jul 2023 13:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjGTLPP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jul 2023 07:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjGTLPO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jul 2023 07:15:14 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F202690;
        Thu, 20 Jul 2023 04:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1689851714; x=1721387714;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YNjRIglSn+Mq54+ClkMlyrrKM6JqxpWLeZXEHD/ENyE=;
  b=DrgBMB5AMNK+Q0c83VIY+JW9y4vCzZb8w96M6JdXQTwlZFyTiu81AiPO
   ED7dbl0yRiXk6BdU5TvS4zAfPaweILaDkWVKAiEXNV9VYbvMXPFht6yna
   /DBujXGOC4mjX7pDjljxKJ4a3JNofKH67XNatLVU+D3ie2u1P5bBkhj2t
   C3h56ZkC3LihH3L9otS3Y3eM+VZeaapXh3Q7HSY3mGn8Q2IcKvJhRSaLZ
   XLjCbI0kQt2qaROJtdtM4gD7EWwZCr0PeI8q0Nkfj+2S1UZLmpaKs/jwU
   AlKNPUQNgC+RaRqcYp7NodYH8P5nHlVTWmrQ7mne9DgxjRsnpa0agAEtb
   w==;
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="asc'?scan'208";a="224157917"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jul 2023 04:15:13 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 20 Jul 2023 04:15:12 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 20 Jul 2023 04:15:09 -0700
Date:   Thu, 20 Jul 2023 12:14:36 +0100
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
Subject: Re: [PATCH v1 8/9] PCI: PLDA: starfive: Add JH7110 PCIe controller
Message-ID: <20230720-vanquish-upcoming-1145e052c849@wendy>
References: <20230719102057.22329-1-minda.chen@starfivetech.com>
 <20230719102057.22329-9-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="J786f78MG4rGWZCB"
Content-Disposition: inline
In-Reply-To: <20230719102057.22329-9-minda.chen@starfivetech.com>
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

--J786f78MG4rGWZCB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 19, 2023 at 06:20:56PM +0800, Minda Chen wrote:
> Add StarFive JH7110 SoC PCIe controller platform
> driver codes.
>=20
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> Reviewed-by: Mason Huo <mason.huo@starfivetech.com>
> ---
>  MAINTAINERS                                 |   7 +
>  drivers/pci/controller/plda/Kconfig         |   8 +
>  drivers/pci/controller/plda/Makefile        |   1 +
>  drivers/pci/controller/plda/pcie-plda.h     |  58 ++-
>  drivers/pci/controller/plda/pcie-starfive.c | 415 ++++++++++++++++++++
>  5 files changed, 487 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/pci/controller/plda/pcie-starfive.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f02618c2bdf5..b88a54a24ae5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20356,6 +20356,13 @@ S:	Supported
>  F:	Documentation/devicetree/bindings/watchdog/starfive*
>  F:	drivers/watchdog/starfive-wdt.c
> =20
> +STARFIVE JH71x0 PCIE DRIVER
> +M:	Minda Chen <minda.chen@starfivetech.com>
> +L:	linux-pci@vger.kernel.org
> +S:	Supported
> +F:	Documentation/devicetree/bindings/pci/starfive*
> +F:	drivers/pci/controller/plda/pcie-starfive.c
> +
>  STATIC BRANCH/CALL
>  M:	Peter Zijlstra <peterz@infradead.org>
>  M:	Josh Poimboeuf <jpoimboe@kernel.org>
> diff --git a/drivers/pci/controller/plda/Kconfig b/drivers/pci/controller=
/plda/Kconfig
> index a3c790545843..eaf72954da9f 100644
> --- a/drivers/pci/controller/plda/Kconfig
> +++ b/drivers/pci/controller/plda/Kconfig
> @@ -24,4 +24,12 @@ config PCIE_MICROCHIP_HOST
>  	  Say Y here if you want kernel to support the Microchip AXI PCIe
>  	  Host Bridge driver.
> =20
> +config PCIE_STARFIVE_HOST
> +	tristate "StarFive PCIe host controller"
> +	select PCIE_PLDA_HOST

Ditto here, I think this suffers from the same issue, although its
probably only really randconfigs that'll trigger it.

> +	help
> +	  Say Y here if you want to support the StarFive PCIe controller
> +	  in host mode. StarFive PCIe controller uses PLDA PCIe
> +	  core.
> +
>  endmenu

--J786f78MG4rGWZCB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLkXHAAKCRB4tDGHoIJi
0m9pAP9EyJHAUvHXemhchcieYU5ZwFz9SUQoN1qLf6k7DVl5aQEA5wHTHNqMKBQ7
SycW/eeQcp3dKd4ozKRqEI0wwtYsmQw=
=9Nkb
-----END PGP SIGNATURE-----

--J786f78MG4rGWZCB--
