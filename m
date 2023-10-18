Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB967CD966
	for <lists+linux-pci@lfdr.de>; Wed, 18 Oct 2023 12:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjJRKj5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Oct 2023 06:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjJRKj5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Oct 2023 06:39:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917E2B0;
        Wed, 18 Oct 2023 03:39:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8849EC433C7;
        Wed, 18 Oct 2023 10:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697625595;
        bh=j11DdRa2L1dUqtW3EelcXbCkjO9B0hcjr/Wwlj3hR5Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B9tV+RiXbptKtQxPEmVdAhDVccVnZYa61THs9AEXN5z7ObVtzEwWBniJCqpCJElFp
         D05IfxoqWDDgya2gv9o7kMwqx9BnhtMtUH4fzoczgdiXKlPFkEubBcLC45RW1C+76X
         vB+NgZqBrkOozxfhKQZz7HG8wNNxQJ1TXY8xloY+jhWGFFPs1FVF26QzDPfbvNhfiT
         +NQ51muc0kiWZN7F7dJ3HN1by7U/o47onOc99xqQ8YBNyEo1XlB8vye6TEcKF3/E76
         Vl+2ne0+DNTf+bhvWtOD9Dgp3iPG0wURSTyXbdsOKBzOkvMHhQjovB0NeMtz9Z7gGA
         YMJMHV3IBgCRw==
Date:   Wed, 18 Oct 2023 11:39:49 +0100
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
Subject: Re: [PATCH v8 04/22] PCI: microchip: Add bridge_addr field to struct
 mc_pcie
Message-ID: <20231018-prefix-algebra-972f3e33b165@spud>
References: <20231011110514.107528-1-minda.chen@starfivetech.com>
 <20231011110514.107528-5-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qCrH5eub/BoEPs+2"
Content-Disposition: inline
In-Reply-To: <20231011110514.107528-5-minda.chen@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--qCrH5eub/BoEPs+2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 11, 2023 at 07:04:56PM +0800, Minda Chen wrote:
> For bridge address base is common PLDA field, Add this
> to struct mc_pcie first.
>=20
> INTx and MSI codes interrupts codes will get the bridge base
> address from port->bridge_addr. For these codes will be
> changed to common codes. axi_base_addr is Microchip its own
> data.
>=20
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  .../pci/controller/plda/pcie-microchip-host.c | 23 ++++++++-----------
>  1 file changed, 9 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/=
pci/controller/plda/pcie-microchip-host.c
> index a34ec6aad4be..60870ee1f1c9 100644
> --- a/drivers/pci/controller/plda/pcie-microchip-host.c
> +++ b/drivers/pci/controller/plda/pcie-microchip-host.c
> @@ -195,6 +195,7 @@ struct mc_pcie {
>  	struct irq_domain *event_domain;
>  	raw_spinlock_t lock;
>  	struct mc_msi msi;
> +	void __iomem *bridge_addr;
>  };
> =20
>  struct cause {
> @@ -339,8 +340,7 @@ static void mc_handle_msi(struct irq_desc *desc)
>  	struct irq_chip *chip =3D irq_desc_get_chip(desc);
>  	struct device *dev =3D port->dev;
>  	struct mc_msi *msi =3D &port->msi;
> -	void __iomem *bridge_base_addr =3D
> -		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
> +	void __iomem *bridge_base_addr =3D port->bridge_addr;
>  	unsigned long status;
>  	u32 bit;
>  	int ret;
> @@ -365,8 +365,7 @@ static void mc_handle_msi(struct irq_desc *desc)
>  static void mc_msi_bottom_irq_ack(struct irq_data *data)
>  {
>  	struct mc_pcie *port =3D irq_data_get_irq_chip_data(data);
> -	void __iomem *bridge_base_addr =3D
> -		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
> +	void __iomem *bridge_base_addr =3D port->bridge_addr;
>  	u32 bitpos =3D data->hwirq;
> =20
>  	writel_relaxed(BIT(bitpos), bridge_base_addr + ISTATUS_MSI);
> @@ -488,8 +487,7 @@ static void mc_handle_intx(struct irq_desc *desc)
>  	struct mc_pcie *port =3D irq_desc_get_handler_data(desc);
>  	struct irq_chip *chip =3D irq_desc_get_chip(desc);
>  	struct device *dev =3D port->dev;
> -	void __iomem *bridge_base_addr =3D
> -		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
> +	void __iomem *bridge_base_addr =3D port->bridge_addr;
>  	unsigned long status;
>  	u32 bit;
>  	int ret;
> @@ -514,8 +512,7 @@ static void mc_handle_intx(struct irq_desc *desc)
>  static void mc_ack_intx_irq(struct irq_data *data)
>  {
>  	struct mc_pcie *port =3D irq_data_get_irq_chip_data(data);
> -	void __iomem *bridge_base_addr =3D
> -		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
> +	void __iomem *bridge_base_addr =3D port->bridge_addr;
>  	u32 mask =3D BIT(data->hwirq + PM_MSI_INT_INTX_SHIFT);
> =20
>  	writel_relaxed(mask, bridge_base_addr + ISTATUS_LOCAL);
> @@ -524,8 +521,7 @@ static void mc_ack_intx_irq(struct irq_data *data)
>  static void mc_mask_intx_irq(struct irq_data *data)
>  {
>  	struct mc_pcie *port =3D irq_data_get_irq_chip_data(data);
> -	void __iomem *bridge_base_addr =3D
> -		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
> +	void __iomem *bridge_base_addr =3D port->bridge_addr;
>  	unsigned long flags;
>  	u32 mask =3D BIT(data->hwirq + PM_MSI_INT_INTX_SHIFT);
>  	u32 val;
> @@ -540,8 +536,7 @@ static void mc_mask_intx_irq(struct irq_data *data)
>  static void mc_unmask_intx_irq(struct irq_data *data)
>  {
>  	struct mc_pcie *port =3D irq_data_get_irq_chip_data(data);
> -	void __iomem *bridge_base_addr =3D
> -		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
> +	void __iomem *bridge_base_addr =3D port->bridge_addr;
>  	unsigned long flags;
>  	u32 mask =3D BIT(data->hwirq + PM_MSI_INT_INTX_SHIFT);
>  	u32 val;
> @@ -896,8 +891,7 @@ static void mc_pcie_setup_window(void __iomem *bridge=
_base_addr, u32 index,
>  static int mc_pcie_setup_windows(struct platform_device *pdev,
>  				 struct mc_pcie *port)
>  {
> -	void __iomem *bridge_base_addr =3D
> -		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
> +	void __iomem *bridge_base_addr =3D port->bridge_addr;
>  	struct pci_host_bridge *bridge =3D platform_get_drvdata(pdev);
>  	struct resource_entry *entry;
>  	u64 pci_addr;
> @@ -1081,6 +1075,7 @@ static int mc_host_probe(struct platform_device *pd=
ev)
>  	mc_disable_interrupts(port);
> =20
>  	bridge_base_addr =3D port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
> +	port->bridge_addr =3D bridge_base_addr;
> =20
>  	/* Allow enabling MSI by disabling MSI-X */
>  	val =3D readl(bridge_base_addr + PCIE_PCI_IRQ_DW0);
> --=20
> 2.17.1
>=20
>=20

--qCrH5eub/BoEPs+2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZS+13wAKCRB4tDGHoIJi
0scjAQDhrkZUunucMZI0RXCT/PVHRPxjeaEj5Btpn50y+TDCHAD9EkOlHuKnIDOA
jsXGsg7DnuvYG5LslZ9g0LO1/2MAXwc=
=VpnB
-----END PGP SIGNATURE-----

--qCrH5eub/BoEPs+2--
