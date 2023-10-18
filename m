Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55AB87CD970
	for <lists+linux-pci@lfdr.de>; Wed, 18 Oct 2023 12:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjJRKlt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Oct 2023 06:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjJRKlt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Oct 2023 06:41:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4073BB0;
        Wed, 18 Oct 2023 03:41:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D0F8C433C7;
        Wed, 18 Oct 2023 10:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697625706;
        bh=sFyrtrR928O5YNONsxuEouDQvRY8IpL62l5ARmvnQ5k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tDZtuWgWGHcT2MnvPBicnbXZWhpcKOcfBeGcN7UZvFCojB5gZBL4+6tMFkS5bvl0Q
         RIEg5sn1xLTHy9FWx9oG/cAdbnMh9g9yYbPUsn4x0BRylUoCYhN9jK7RRy3ZgSDmWf
         406RkW0ejGk0OmysreiA7xHA2pGRQGUz+frO4KXMZGrXbYQIDEaWvaPIno1HUa4QYd
         9DFB5TSYWni6cEyjqgk7u36b9e1X1EM/c4wMDMHHD7laQNq771G7z6Srvdbqso2JEy
         Ggtk1UqPEHbH6fnOuEq8AqIuCksCBVa6oEUq7Gj0ld2EJOd6bhHSp5n16q5d5lIcsI
         SrmW+bCoO9HUg==
Date:   Wed, 18 Oct 2023 11:41:40 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Minda Chen <minda.chen@starfivetech.com>
Cc:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
Subject: Re: [PATCH v8 06/22] PCI: microchip: Move PCIe host data structure
 to plda-pcie.h
Message-ID: <20231018-defender-moonlit-3d9a06faddcd@spud>
References: <20231011110514.107528-1-minda.chen@starfivetech.com>
 <20231011110514.107528-7-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+ZHf5FLqtzeKhJjg"
Content-Disposition: inline
In-Reply-To: <20231011110514.107528-7-minda.chen@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--+ZHf5FLqtzeKhJjg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 11, 2023 at 07:04:58PM +0800, Minda Chen wrote:
> Move the common data structures definition to head file for

nit: "to a header file so that these data structures"

> these data structure can be re-used.
>=20
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  .../pci/controller/plda/pcie-microchip-host.c | 20 ------------------
>  drivers/pci/controller/plda/pcie-plda.h       | 21 +++++++++++++++++++
>  2 files changed, 21 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/=
pci/controller/plda/pcie-microchip-host.c
> index 3dc4d4ca9d0c..261147a0a446 100644
> --- a/drivers/pci/controller/plda/pcie-microchip-host.c
> +++ b/drivers/pci/controller/plda/pcie-microchip-host.c
> @@ -21,9 +21,6 @@
>  #include "../../pci.h"
>  #include "pcie-plda.h"
> =20
> -/* Number of MSI IRQs */
> -#define PLDA_MAX_NUM_MSI_IRQS			32
> -
>  /* PCIe Bridge Phy and Controller Phy offsets */
>  #define MC_PCIE1_BRIDGE_ADDR			0x00008000u
>  #define MC_PCIE1_CTRL_ADDR			0x0000a000u
> @@ -179,23 +176,6 @@ struct event_map {
>  	u32 event_bit;
>  };
> =20
> -struct plda_msi {
> -	struct mutex lock;		/* Protect used bitmap */
> -	struct irq_domain *msi_domain;
> -	struct irq_domain *dev_domain;
> -	u32 num_vectors;
> -	u64 vector_phy;
> -	DECLARE_BITMAP(used, PLDA_MAX_NUM_MSI_IRQS);
> -};
> -
> -struct plda_pcie_rp {
> -	struct device *dev;
> -	struct irq_domain *intx_domain;
> -	struct irq_domain *event_domain;
> -	raw_spinlock_t lock;
> -	struct plda_msi msi;
> -	void __iomem *bridge_addr;
> -};
> =20
>  struct mc_pcie {
>  	struct plda_pcie_rp plda;
> diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/contro=
ller/plda/pcie-plda.h
> index 727fc54312c9..363fcbbaf6ec 100644
> --- a/drivers/pci/controller/plda/pcie-plda.h
> +++ b/drivers/pci/controller/plda/pcie-plda.h
> @@ -6,6 +6,9 @@
>  #ifndef _PCIE_PLDA_H
>  #define _PCIE_PLDA_H
> =20
> +/* Number of MSI IRQs */
> +#define PLDA_MAX_NUM_MSI_IRQS			32
> +
>  /* PCIe Bridge Phy Regs */
>  #define PCIE_PCI_IRQ_DW0			0xa8
>  #define  MSIX_CAP_MASK				BIT(31)
> @@ -99,4 +102,22 @@
>  #define EVENT_PM_MSI_INT_SYS_ERR		12
>  #define NUM_PLDA_EVENTS				13
> =20
> +struct plda_msi {
> +	struct mutex lock;		/* Protect used bitmap */
> +	struct irq_domain *msi_domain;
> +	struct irq_domain *dev_domain;
> +	u32 num_vectors;
> +	u64 vector_phy;
> +	DECLARE_BITMAP(used, PLDA_MAX_NUM_MSI_IRQS);
> +};
> +
> +struct plda_pcie_rp {
> +	struct device *dev;
> +	struct irq_domain *intx_domain;
> +	struct irq_domain *event_domain;
> +	raw_spinlock_t lock;
> +	struct plda_msi msi;
> +	void __iomem *bridge_addr;
> +};
> +
>  #endif
> --=20
> 2.17.1
>=20

--+ZHf5FLqtzeKhJjg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZS+2ZAAKCRB4tDGHoIJi
0g8wAQDLfI6cKlLrcjsYvlotPgj0HcXfUcSgUawM+JMX+fAPQwD+MmEJIKAlAn6Q
BqFWTN4tAvjPd7jdT0K4YbncnvPBRw8=
=M+Mv
-----END PGP SIGNATURE-----

--+ZHf5FLqtzeKhJjg--
