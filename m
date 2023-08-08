Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992C0773E72
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 18:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbjHHQaF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Aug 2023 12:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbjHHQ2z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 12:28:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3762812538;
        Tue,  8 Aug 2023 08:51:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D43F62461;
        Tue,  8 Aug 2023 08:41:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8003EC433C8;
        Tue,  8 Aug 2023 08:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691484113;
        bh=RmuHI6SnVuFMKUQ2d0Pd88TnzEPcPc2NGqkjG7ikYO4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cwr+yMbUV+NM94lVf0ySZk4FQ2nozF+U9wyhfVylYCpXbt1OL0ssrTMJwXSxsdsHi
         18rTqTqxxueHW+nMM+ermi6IQknqO8+usQdaIiyi1h1tiB82F262sqvPDUGDacSDkO
         a+eTTnFx91yf6zmVoeagFEWEQ3lln0JhVGRC83P65FbUnGAKxwHLFQyg6fLOXTTdZn
         A1EoGEKnrrv1NvaNJ3siqRI5n1/LCn3oUKEUABC06gGoEHMihEoitC1g2km+U7SlBq
         HDlEJ7VYY0XrzBN2J0H3HcQA4IRPSXjHrlCgv6J3k9J5QInU+H7jleqW4Lu80DSrip
         ExqC2/GRUi8eA==
Date:   Tue, 8 Aug 2023 09:41:45 +0100
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
Subject: Re: [RFC PATCH v1 20/21] RISC-V: ACPI: Create PLIC platform device
Message-ID: <20230808-chalice-easing-1369c7386082@spud>
References: <20230803175916.3174453-1-sunilvl@ventanamicro.com>
 <20230803175916.3174453-21-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yKOyY2Nm+bU0Ajrr"
Content-Disposition: inline
In-Reply-To: <20230803175916.3174453-21-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--yKOyY2Nm+bU0Ajrr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 03, 2023 at 11:29:15PM +0530, Sunil V L wrote:
> Since PLIC needs to be a platform device

For the unwashed, why does the PLCI need to be a platform device?
(And while you're at that, please try to make use of the extra ~20
characters per line that you can use here.)

> probe the
> MADT and create platform devices for each PLIC in the
> system. Use software node framework for the fwnode
> which allows to create properties and hence the
> actual irqchip driver doesn't need to do anything
> different for ACPI vs DT.
>=20
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Co-developed-by: Haibo Xu <haibo1.xu@intel.com>
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>

> +static struct fwnode_handle *acpi_plic_create_fwnode(struct acpi_madt_pl=
ic *plic)
> +{
> +	struct fwnode_handle *fwnode, *parent_fwnode;
> +	struct riscv_irqchip_list *plic_element;
> +	struct software_node_ref_args *refs;
> +	struct property_entry props[8] =3D {};
> +	int nr_contexts;
> +
> +	props[0] =3D PROPERTY_ENTRY_U32("riscv,gsi-base", plic->gsi_base);
> +	props[1] =3D PROPERTY_ENTRY_U32("riscv,ndev", plic->num_irqs);
> +	props[2] =3D PROPERTY_ENTRY_U32("riscv,max_prio", plic->max_prio);

My OCD wants to know why this gets an _ but the others have a -.

> +	props[3] =3D PROPERTY_ENTRY_U8("riscv,plic-id", plic->id);
> +	props[4] =3D PROPERTY_ENTRY_U64("riscv,plic-base", plic->base_addr);
> +	props[5] =3D PROPERTY_ENTRY_U32("riscv,plic-size", plic->size);

--yKOyY2Nm+bU0Ajrr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNH/yQAKCRB4tDGHoIJi
0o+oAQCMWQ+6bAgMjck+BSFaQF/FjtKfLfwDUTH+w218stePOwD8DiC9qCq9yuol
xjAhVIcaeVplSIBN2+Ti/3cDd5sR5AE=
=0Z4N
-----END PGP SIGNATURE-----

--yKOyY2Nm+bU0Ajrr--
