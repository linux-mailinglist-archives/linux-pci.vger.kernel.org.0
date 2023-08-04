Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD192770438
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 17:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbjHDPTi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Aug 2023 11:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjHDPTh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Aug 2023 11:19:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD5B49C1;
        Fri,  4 Aug 2023 08:19:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EC4B6206B;
        Fri,  4 Aug 2023 15:19:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5DCC433C7;
        Fri,  4 Aug 2023 15:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691162375;
        bh=hHDz38CB+HkMmklWio9ZQ4ndafz59B33DbehJXavBS0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=teXBdQCpJJ3OGjY6KbGN8tilDfEVQue00QTazqmjd5fBUChKMXwOGVLq6daR4FDbf
         qXh6CboMr6leIH/oWN8yvGpcscwwrmjslQI7QWzulffY5+kupSZmmzvZ2nADFHqYpn
         hwtMmUs4Kis5KLg9HTEElgLwEVXJLeLiD5tCsk80v3kCvaBGsw2mel+YFrODxvvtV/
         Ts8Qms6P4ibqHP3HIOFH2wVY41OCAztspxeUmXNBIbic3ZQMgoib/QdWzIRwLJ1DDB
         64aCZw/DlYyOHtdIzi/HMivb12UiKmuYrX7cNySDYMdLixoNqonCdaUopDLIoJ2XuD
         FKVAXtlKSpXKA==
Date:   Fri, 4 Aug 2023 16:19:27 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Sunil V L <sunilvl@ventanamicro.com>, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anup Patel <anup@brainfault.org>,
        Marc Zyngier <maz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robert Moore <robert.moore@intel.com>,
        Haibo Xu <haibo1.xu@intel.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Atish Kumar Patra <atishp@rivosinc.com>
Subject: Re: [RFC PATCH v1 09/21] RISC-V: cacheflush: Initialize CBO
 variables on ACPI systems
Message-ID: <20230804-dreamy-unharmed-a502d02af35a@spud>
References: <20230803175916.3174453-1-sunilvl@ventanamicro.com>
 <20230803175916.3174453-10-sunilvl@ventanamicro.com>
 <ZMyTDcffqXYT29JX@smile.fi.intel.com>
 <ZMzC4nHOJOfp0vaa@sunil-laptop>
 <ZM0SZwL9SXrEuFMT@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GXjvkfPtI3JRgl/C"
Content-Disposition: inline
In-Reply-To: <ZM0SZwL9SXrEuFMT@smile.fi.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--GXjvkfPtI3JRgl/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 04, 2023 at 05:59:51PM +0300, Andy Shevchenko wrote:
> On Fri, Aug 04, 2023 at 02:50:34PM +0530, Sunil V L wrote:
> > On Fri, Aug 04, 2023 at 08:56:29AM +0300, Andy Shevchenko wrote:
> > > On Thu, Aug 03, 2023 at 11:29:04PM +0530, Sunil V L wrote:
> > > > Using new interface to get the CBO block size information in
> > > > RHCT, initialize the variables on ACPI platforms.
>=20
> ...
>=20
> > > > +#include <asm/acpi.h>
> > >=20
> > > What do you need this for?
> > >=20
> > > >  #include <asm/cacheflush.h>
> > >=20
> > When CONFIG_ACPI is disabled, this include is required to get
> > acpi_get_cbo_block_size().
>=20
> How is it useful without ACPI being enabled?

It is not, as evidenced by the `return -EINVAL;`.

> If it's indeed
> (in which I do not believe), better to make sure you have it
> avaiable independently on CONFIG_ACPI. Otherwise, just put
> #ifdef CONFIG_ACPI around the call.

Let's not litter the code with ifdeffery please where it can be easily
avoided.

--GXjvkfPtI3JRgl/C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZM0W/wAKCRB4tDGHoIJi
0kuVAQDw7o9CBBPZvOZRnV4GOgYrlNOO9/0bJ6PGEvVlWlJR2wD+Im0XikBKI2i3
E2WQtTAIBya29pYaEsPNynJY6+2BqAc=
=E2dR
-----END PGP SIGNATURE-----

--GXjvkfPtI3JRgl/C--
