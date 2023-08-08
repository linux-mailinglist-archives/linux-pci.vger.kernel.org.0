Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4E9774287
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 19:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234939AbjHHRq1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Aug 2023 13:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbjHHRpi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 13:45:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFC325EEB;
        Tue,  8 Aug 2023 09:20:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3A61624D6;
        Tue,  8 Aug 2023 11:30:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B01BDC433C7;
        Tue,  8 Aug 2023 11:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691494211;
        bh=vBWSlCDrZROxYuy5ae4tTgkUDzDtAMFgQOHc2MqMN00=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MxQAHNSR+7FUjdWOuwilrrz5CHO2ObEjZl4fLBcr+LuMNcCNKtQAKcmtgTOIFV+Yh
         7cu/EogbhTMQiiZ3g+syK5H83K28a+yereJhUBKnA4a/yOMRSjt3nLsKAHhlUvXYXr
         htGC6od3JcJbQFmH5LiGxzAIRcVqG+ss/EdoPCxLbX1KOl4Sqdx8QNGbbZeNCDXOMi
         IDR3emYO4U9d0hpj/LVopgLJRCXwtM1TvG6zIv47LavRbQnw6i8QGtabKCjXXlhWqN
         1FbmPRagUR0jvtHILpvHSXizSC7kIt/kwtCj1gMpev209vnY2NFhuJbNneA3n1sJyO
         ZFi+GGQOWIk9g==
Date:   Tue, 8 Aug 2023 12:30:03 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Sunil V L <sunilvl@ventanamicro.com>, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org,
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
Message-ID: <20230808-ferry-swarm-e2a0abb17165@spud>
References: <20230803175916.3174453-1-sunilvl@ventanamicro.com>
 <20230803175916.3174453-21-sunilvl@ventanamicro.com>
 <20230808-chalice-easing-1369c7386082@spud>
 <CAK9=C2XZ7_tfSK6HNN1Em5fAHrknWBqGaD9gPL8yGs8AzE3vQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="B+bG6e2jHgiFE7ir"
Content-Disposition: inline
In-Reply-To: <CAK9=C2XZ7_tfSK6HNN1Em5fAHrknWBqGaD9gPL8yGs8AzE3vQg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--B+bG6e2jHgiFE7ir
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2023 at 04:27:16PM +0530, Anup Patel wrote:
> On Tue, Aug 8, 2023 at 2:12=E2=80=AFPM Conor Dooley <conor@kernel.org> wr=
ote:
> >
> > On Thu, Aug 03, 2023 at 11:29:15PM +0530, Sunil V L wrote:
> > > Since PLIC needs to be a platform device
> >
> > For the unwashed, why does the PLCI need to be a platform device?
> > (And while you're at that, please try to make use of the extra ~20
> > characters per line that you can use here.)
>=20
> As suggested by Marc Z, only timers and IPIs need to be probed early.
> Everything else needs to be a platform device. The devlink feature of
> Linux DD framework ensures that platform devices are probed in the
> right order based on the interdependency.
>=20
> The PATCH5 of the v7 AIA series converts the PLIC driver into a
> platform driver. This works perfectly fine.

To be clear, I want the explanation of why the "PLIC needs to be a
platform device" to be in the commit message.

Thanks,
Conor.

>=20
> >
> > > probe the
> > > MADT and create platform devices for each PLIC in the
> > > system. Use software node framework for the fwnode
> > > which allows to create properties and hence the
> > > actual irqchip driver doesn't need to do anything
> > > different for ACPI vs DT.
> > >
> > > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > > Co-developed-by: Haibo Xu <haibo1.xu@intel.com>
> > > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> >
> > > +static struct fwnode_handle *acpi_plic_create_fwnode(struct acpi_mad=
t_plic *plic)
> > > +{
> > > +     struct fwnode_handle *fwnode, *parent_fwnode;
> > > +     struct riscv_irqchip_list *plic_element;
> > > +     struct software_node_ref_args *refs;
> > > +     struct property_entry props[8] =3D {};
> > > +     int nr_contexts;
> > > +
> > > +     props[0] =3D PROPERTY_ENTRY_U32("riscv,gsi-base", plic->gsi_bas=
e);
> > > +     props[1] =3D PROPERTY_ENTRY_U32("riscv,ndev", plic->num_irqs);
> > > +     props[2] =3D PROPERTY_ENTRY_U32("riscv,max_prio", plic->max_pri=
o);
> >
> > My OCD wants to know why this gets an _ but the others have a -.
> >
> > > +     props[3] =3D PROPERTY_ENTRY_U8("riscv,plic-id", plic->id);
> > > +     props[4] =3D PROPERTY_ENTRY_U64("riscv,plic-base", plic->base_a=
ddr);
> > > +     props[5] =3D PROPERTY_ENTRY_U32("riscv,plic-size", plic->size);

--B+bG6e2jHgiFE7ir
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNInOwAKCRB4tDGHoIJi
0sLcAQCDXLAw71GxaGzz6Qp83L1Tb3sQIefjSzU544KRvPaIZwEA0NG4WpAU7bh9
dP9hFr5cEYLKlf5xgRt76/vz3TmyhAM=
=TeDA
-----END PGP SIGNATURE-----

--B+bG6e2jHgiFE7ir--
