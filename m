Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A5077BA69
	for <lists+linux-pci@lfdr.de>; Mon, 14 Aug 2023 15:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjHNNnU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Aug 2023 09:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbjHNNnH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Aug 2023 09:43:07 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2531A1BD;
        Mon, 14 Aug 2023 06:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1692020585; x=1723556585;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3RJki/UyBhVD4cEMr5FQ7PWWAd+xOqV2/EbyzQNzzuY=;
  b=CP5rEIQCpGrfFmA+69R0x6vb9iGMZmsJByMaNZW01WtMKgGtUw0XhuyM
   P5WsSKj+HDFCju+bxfS/dwz/Nlxzpya9T96gNR/XgYsLIqNrSdP7NU5hf
   vxOStIkSxnoDvLHysi2+MvtDvum62FDAHBwsa7vhAX7RhOUG45qTCAZJA
   +RDGFyBxnA6lLzgYEjWZ/9cN8BtZeyp3MIbvagpDQK/SC3z2IFct/gHn6
   kgVEc2KzKWx+nPAOS9sVAC6C0gyzGJcfXALiEvs1ujibPk0R4f8rCM6JZ
   T79mFu8VYrqOUN+49yNYqXdT5gbtYQhuElMEgz9snhTfUhXUlhlOHsMoJ
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="asc'?scan'208";a="241510632"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Aug 2023 06:43:04 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 14 Aug 2023 06:43:04 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 14 Aug 2023 06:43:00 -0700
Date:   Mon, 14 Aug 2023 14:42:21 +0100
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
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
Subject: Re: [PATCH v3 04/11] PCI: microchip: Rename data structure and
 functions
Message-ID: <20230814-earshot-batting-607d70ccc051@wendy>
References: <20230814082016.104181-1-minda.chen@starfivetech.com>
 <20230814082016.104181-5-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RnUNCLF+ofFKLsLa"
Content-Disposition: inline
In-Reply-To: <20230814082016.104181-5-minda.chen@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--RnUNCLF+ofFKLsLa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2023 at 04:20:09PM +0800, Minda Chen wrote:
> Rename mc_* to plda_* for common data structures,
> setup and IRQ functions.
>=20
> The modification includes:
> - Add related data structures of PCIe host instance.
>   mc_pcie --> plda_pcie_rp (Get most of data members)
>   mc_msi  --> plda_msi
> - function rename list:
>   mc_pcie_setup_window     --> plda_pcie_setup_window
>   mc_pcie_setup_windows    --> plda_pcie_setup_iomems
>   mc_allocate_msi_domains  --> plda_allocate_msi_domains
>   MSI interrupts related functions and IRQ domain
>   (primary function is mc_handle_msi):
>   mc_handle_msi            --> plda_handle_msi
>   INTx interrupts related functions and IRQ domain
>   (primary function is mc_handle_intx):
>   mc_handle_intx           --> plda_handle_intx
>=20
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> ---
>  .../pci/controller/plda/pcie-microchip-host.c | 216 ++++++++----------
>  drivers/pci/controller/plda/pcie-plda.h       |  20 ++
>  2 files changed, 120 insertions(+), 116 deletions(-)
>=20
> diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/=
pci/controller/plda/pcie-microchip-host.c
> index 5ab11741f406..e25459f34891 100644
> --- a/drivers/pci/controller/plda/pcie-microchip-host.c
> +++ b/drivers/pci/controller/plda/pcie-microchip-host.c
> @@ -21,9 +21,6 @@
>  #include "../../pci.h"
>  #include "pcie-plda.h"
> =20
> -/* Number of MSI IRQs */
> -#define MC_MAX_NUM_MSI_IRQS			32
> -
>  /* PCIe Bridge Phy and Controller Phy offsets */
>  #define MC_PCIE1_BRIDGE_ADDR			0x00008000u
>  #define MC_PCIE1_CTRL_ADDR			0x0000a000u
> @@ -175,22 +172,9 @@ struct event_map {
>  	u32 event_bit;
>  };
> =20
> -struct mc_msi {
> -	struct mutex lock;		/* Protect used bitmap */
> -	struct irq_domain *msi_domain;
> -	struct irq_domain *dev_domain;
> -	u32 num_vectors;
> -	u64 vector_phy;
> -	DECLARE_BITMAP(used, MC_MAX_NUM_MSI_IRQS);
> -};
> -
>  struct mc_pcie {
> +	struct plda_pcie_rp plda;

I'm not super keen on the "rp"s that've been introduced here and
elsewhere when "port" is what's used all over the shop.
Not a big gripe though, so
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--RnUNCLF+ofFKLsLa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNovPQAKCRB4tDGHoIJi
0p3PAQC3LAlrzFZcNKEUSHbTg6enYHF6mQCSbRaaKuQ/dLhhRgEAgRII9idgkq6C
1wdA8wsy+0T0C19t6hlAmb4RkChLAAg=
=44Tv
-----END PGP SIGNATURE-----

--RnUNCLF+ofFKLsLa--
