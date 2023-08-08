Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13EED774AF7
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 22:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjHHUi4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Aug 2023 16:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbjHHUbv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 16:31:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376034AA90;
        Tue,  8 Aug 2023 09:50:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60970623F2;
        Tue,  8 Aug 2023 08:31:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A31BC433C8;
        Tue,  8 Aug 2023 08:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691483517;
        bh=MpyvTQzwBjHbZI8sMSOd7J9/piSikcHHm+TWFR/stac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pka7NzrVjEQNbyWGI/WnWkrr+a5FjLtxCmsQcCOXphsY9L5W46RUvd6aapwlo9jCS
         NolUJckCfoY7fX/X9OHUnpMLYiuwRY70OYahppcxYoMgc9SHLse5Xn7id/DhVU/r/7
         nnGGJeO6e3yUm2+hcyf2EF+9bqOSVK4poXjiqNSyxgEPFVLlt4kExzhNuWuz9Xm7fH
         b1yO+pqKpbEjzdwsS/cserCryKALKg+zlphWhxpBehWtx4z+lnaAb+TJGL2UPyW0E/
         ETh8bu5SwkRbm9SP9U2vRi75kNMH8ZwGOZ53Zv9IaZc7clxnmeiTFjwGGpWVI3Plsk
         /lL4HFoVfbKgQ==
Date:   Tue, 8 Aug 2023 09:31:49 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Atish Kumar Patra <atishp@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Will Deacon <will@kernel.org>, Haibo Xu <haibo1.xu@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Robert Moore <robert.moore@intel.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Scally <djrscally@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Anup Patel <anup@brainfault.org>, Len Brown <lenb@kernel.org>
Subject: Re: [RFC PATCH v1 12/21] irqchip/riscv-intc: Use swnode framework to
 create fwnode
Message-ID: <20230808-chuck-jailhouse-0cb08b55d1bd@spud>
References: <20230803175916.3174453-1-sunilvl@ventanamicro.com>
 <20230803175916.3174453-13-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KGbrO9FdUrNn/kR9"
Content-Disposition: inline
In-Reply-To: <20230803175916.3174453-13-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--KGbrO9FdUrNn/kR9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Sunil,

On Thu, Aug 03, 2023 at 11:29:07PM +0530, Sunil V L wrote:
> By using swnode framework, all data from ACPI tables can
> be populated as properties of the swnode. This simplifies
> the driver code and removes the need for ACPI vs DT checks.
> Use this framework for RISC-V INTC driver.

btw, you are permitted to use more than 60 characters in a commit
message...

>=20
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  Documentation/riscv/acpi.rst     | 21 +++++++++++++++
>  arch/riscv/include/asm/acpi.h    |  1 +
>  drivers/acpi/riscv/Makefile      |  2 +-
>  drivers/acpi/riscv/irqchip.c     | 46 ++++++++++++++++++++++++++++++++
>  drivers/irqchip/irq-riscv-intc.c | 12 ++++-----
>  5 files changed, 75 insertions(+), 7 deletions(-)
>  create mode 100644 drivers/acpi/riscv/irqchip.c
>=20
> diff --git a/Documentation/riscv/acpi.rst b/Documentation/riscv/acpi.rst
> index 9870a282815b..e2406546bc16 100644
> --- a/Documentation/riscv/acpi.rst
> +++ b/Documentation/riscv/acpi.rst
> @@ -8,3 +8,24 @@ The ISA string parsing rules for ACPI are defined by `Ve=
rsion ASCIIDOC
>  Conversion, 12/2022 of the RISC-V specifications, as defined by tag
>  "riscv-isa-release-1239329-2023-05-23" (commit 1239329
>  ) <https://github.com/riscv/riscv-isa-manual/releases/tag/riscv-isa-rele=
ase-1239329-2023-05-23>`_
> +
> +Interrupt Controller Drivers
> +=3D=3D=3D=3D=3D=3D=3D
> +
> +ACPI drivers for RISC-V interrupt controllers use software node framewor=
k to
> +create the fwnode for the interrupt controllers. Below properties are
> +additionally required for some firmware nodes apart from the properties
> +defined by the device tree bindings for these interrupt controllers. The
> +properties are created using the data in MADT table.

I don't really understand this text, specifically what you are getting
at w/ the dependency on devicetree properties. What exactly does "apart
=66rom the properties defined by the devicetree bindings" mean?

Is there prior art for this kind of "ACPI needs swnodes that look
vaguely similar to devicetree" for other interrupt controllers?

Thanks,
Conor.

> +1) RISC-V Interrupt Controller (INTC)
> +-----------
> +``hartid`` - Hart ID of the hart this interrupt controller belongs to.
> +
> +``riscv,imsic-addr`` - Physical base address of the Incoming MSI Control=
ler
> +(IMSIC) MMIO region of this hart.
> +
> +``riscv,imsic-size`` - Size in bytes of the IMSIC MMIO region of this ha=
rt.
> +
> +``riscv,ext-intc-id`` - The unique ID of the external interrupts connect=
ed
> +to this hart.
> diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
> index 0c4e8b35103e..0ac2df2dd194 100644
> --- a/arch/riscv/include/asm/acpi.h
> +++ b/arch/riscv/include/asm/acpi.h
> @@ -68,6 +68,7 @@ int acpi_get_riscv_isa(struct acpi_table_header *table,
>  static inline int acpi_numa_get_nid(unsigned int cpu) { return NUMA_NO_N=
ODE; }
>  int acpi_get_cbo_block_size(struct acpi_table_header *table, unsigned in=
t cpu, u32 *cbom_size,
>  			    u32 *cboz_size, u32 *cbop_size);
> +struct fwnode_handle *acpi_rintc_create_irqchip_fwnode(struct acpi_madt_=
rintc *rintc);
>  #else
>  static inline void acpi_init_rintc_map(void) { }
>  static inline struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu)
> diff --git a/drivers/acpi/riscv/Makefile b/drivers/acpi/riscv/Makefile
> index 8b3b126e0b94..8b664190d172 100644
> --- a/drivers/acpi/riscv/Makefile
> +++ b/drivers/acpi/riscv/Makefile
> @@ -1,2 +1,2 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -obj-y 	+=3D rhct.o
> +obj-y 	+=3D rhct.o irqchip.o
> diff --git a/drivers/acpi/riscv/irqchip.c b/drivers/acpi/riscv/irqchip.c
> new file mode 100644
> index 000000000000..36f066a2cad5
> --- /dev/null
> +++ b/drivers/acpi/riscv/irqchip.c
> @@ -0,0 +1,46 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2023, Ventana Micro Systems Inc
> + *	Author: Sunil V L <sunilvl@ventanamicro.com>
> + *
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/fwnode.h>
> +#include <linux/irqdomain.h>
> +#include <linux/list.h>
> +#include <linux/property.h>
> +
> +struct riscv_irqchip_list {
> +	struct fwnode_handle *fwnode;
> +	struct list_head list;
> +};
> +
> +LIST_HEAD(rintc_list);
> +
> +struct fwnode_handle *acpi_rintc_create_irqchip_fwnode(struct acpi_madt_=
rintc *rintc)
> +{
> +	struct property_entry props[6] =3D {};
> +	struct fwnode_handle *fwnode;
> +	struct riscv_irqchip_list *rintc_element;
> +
> +	props[0] =3D PROPERTY_ENTRY_U64("hartid", rintc->hart_id);
> +	props[1] =3D PROPERTY_ENTRY_U32("riscv,ext-intc-id", rintc->ext_intc_id=
);
> +	props[2] =3D PROPERTY_ENTRY_U64("riscv,imsic-addr", rintc->imsic_addr);
> +	props[3] =3D PROPERTY_ENTRY_U32("riscv,imsic-size", rintc->imsic_size);
> +	props[4] =3D PROPERTY_ENTRY_U32("#interrupt-cells", 1);
> +
> +	fwnode =3D fwnode_create_software_node_early(props, NULL);
> +	if (fwnode) {
> +		rintc_element =3D kzalloc(sizeof(*rintc_element), GFP_KERNEL);
> +		if (!rintc_element) {
> +			fwnode_remove_software_node(fwnode);
> +			return NULL;
> +		}
> +
> +		rintc_element->fwnode =3D fwnode;
> +		list_add_tail(&rintc_element->list, &rintc_list);
> +	}
> +
> +	return fwnode;
> +}
> diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv=
-intc.c
> index 1a0fc87152c5..1ef9cada1ed3 100644
> --- a/drivers/irqchip/irq-riscv-intc.c
> +++ b/drivers/irqchip/irq-riscv-intc.c
> @@ -203,6 +203,12 @@ static int __init riscv_intc_acpi_init(union acpi_su=
btable_headers *header,
> =20
>  	rintc =3D (struct acpi_madt_rintc *)header;
> =20
> +	fn =3D acpi_rintc_create_irqchip_fwnode(rintc);
> +	if (!fn) {
> +		pr_err("unable to create INTC FW node\n");
> +		return -ENOMEM;
> +	}
> +
>  	/*
>  	 * The ACPI MADT will have one INTC for each CPU (or HART)
>  	 * so riscv_intc_acpi_init() function will be called once
> @@ -212,12 +218,6 @@ static int __init riscv_intc_acpi_init(union acpi_su=
btable_headers *header,
>  	if (riscv_hartid_to_cpuid(rintc->hart_id) !=3D smp_processor_id())
>  		return 0;
> =20
> -	fn =3D irq_domain_alloc_named_fwnode("RISCV-INTC");
> -	if (!fn) {
> -		pr_err("unable to allocate INTC FW node\n");
> -		return -ENOMEM;
> -	}
> -
>  	return riscv_intc_init_common(fn);
>  }
> =20
> --=20
> 2.39.2
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--KGbrO9FdUrNn/kR9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNH9dQAKCRB4tDGHoIJi
0irpAQCn4tpo+ZUuKBiS5LlN2kTNA7QFVujwPoaS1jfnlSeJTAEAkLdDYwU7W+ML
Vydp6LtqVqBQYdbOuMRHnZvBwVgH6A0=
=cP5x
-----END PGP SIGNATURE-----

--KGbrO9FdUrNn/kR9--
