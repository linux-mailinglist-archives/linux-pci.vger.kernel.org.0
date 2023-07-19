Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970E0759BC0
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jul 2023 19:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjGSRAo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jul 2023 13:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjGSRAn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jul 2023 13:00:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62151BB
        for <linux-pci@vger.kernel.org>; Wed, 19 Jul 2023 10:00:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DD06617A8
        for <linux-pci@vger.kernel.org>; Wed, 19 Jul 2023 17:00:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC45EC433C7;
        Wed, 19 Jul 2023 17:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689786041;
        bh=NCr+wrohPKasdJtsGDWcsEmJh/cWN0ySeKvgcJTFzIE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ul/zdll6AFFD6188OX5Iny3t12DdgbcXapKizmchwK+ELZ+2ucxDwsLE5Rg0caviR
         jeC/VE0nM9nR9eLmLN5vTuEmNA8isXukMtrZnZ6M9ra8f3hIhBD91neU5+u2D/dKdA
         82g29m1/FOo6BlcKHcOMt8cbxz0oVtAvWx8vlVLVGKbo6Wrx4nB7OVTy4V9yarx36b
         eQuqcSmQP4f8JETm7YvB6qjneV4/gIqU68eVn29dlqJI01dnzZyV+EfL7c6VgxEY8L
         NcHTrDUF++0dTrNp0wR12QJQdQCyvMdIGbksR3vxuqrt4E7e/UemHiwcRgLjkYitGa
         F9p/BcI8b6lvA==
Date:   Wed, 19 Jul 2023 18:00:37 +0100
From:   Conor Dooley <conor@kernel.org>
To:     daire.mcnamara@microchip.com
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/8] PCI: microchip: Fixes and clean-ups
Message-ID: <20230719-roster-preheated-799d7e103ddb@spud>
References: <20230630154859.2049521-1-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xRfGtZNLLEHjsLNX"
Content-Disposition: inline
In-Reply-To: <20230630154859.2049521-1-daire.mcnamara@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--xRfGtZNLLEHjsLNX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey folks,

On Fri, Jun 30, 2023 at 04:48:51PM +0100, daire.mcnamara@microchip.com wrot=
e:
> From: Daire McNamara <daire.mcnamara@microchip.com>
>=20
> This patch series contains fixes and clean-ups for the Microchip PolarFir=
e SoC PCIe driver
>=20
> These patches are extracted from the link below to separate them from the=
 outbound and inbound
> range handling which is taking considerable time.
> Link: https://lore.kernel.org/linux-riscv/20230111125323.1911373-1-daire.=
mcnamara@microchip.com/
>=20
> These patches are regenerated on v6.4-rc6.
>=20
> Main Changes from v1:
> - Dropped "Remove cast warning for devm_add_action_or_reset()". This
>   has been overtaken by a patch series from Krzysztof Wilczynski.
> - Improved the comment for "Enable building driver as a module" to
>   clarify what enables building the driver as a module.
> - Split "Gather MSI information from hardware config registers",
>   for clarity, into:
>    - "Gather MSI information from hardware config registers" purely
>       changing the of source of MSI-related information (Num MSIs and
>       MSI address) from #defines (which can be incorrect) to FPGA
>       configuration registers (which is the ultimate source of truth),
>       and a
>    - "Rename and refactor ..." patch as a function's code is now clearly
>       unrelated to its current name.

This series has been sitting with reviews (albeit from myself) for a
couple of weeks. What's missing to get this series picked up?

Thanks,
Conor.

> cc: Conor Dooley <conor.dooley@microchip.com>
> cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> cc: "Krzysztof Wilczy=C5=84ski" <kw@linux.com>
> cc: Rob Herring <robh@kernel.org>
> cc: Bjorn Helgaas <bhelgaas@google.com>
> cc: linux-riscv@lists.infradead.org
> cc: linux-pci@vger.kernel.org
>=20
> Daire McNamara (8):
>   PCI: microchip: Correct the DED and SEC interrupt bit offsets
>   PCI: microchip: Enable building driver as a module
>   PCI: microchip: Align register, offset, and mask names with hw docs
>   PCI: microchip: Enable event handlers to access bridge and ctrl ptrs
>   PCI: microchip: Clean up initialisation of interrupts
>   PCI: microchip: Gather MSI information from hardware config registers
>   PCI: microchip: Rename and refactor mc_pcie_enable_msi()
>   PCI: microchip: Re-partition code between probe() and init()
>=20
>  drivers/pci/controller/Kconfig               |   2 +-
>  drivers/pci/controller/pcie-microchip-host.c | 402 +++++++++++--------
>  2 files changed, 238 insertions(+), 166 deletions(-)
>=20
>=20
> base-commit: 858fd168a95c5b9669aac8db6c14a9aeab446375
> --=20
> 2.25.1
>=20

--xRfGtZNLLEHjsLNX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLgWtQAKCRB4tDGHoIJi
0lonAP9PCe1BscZRjZgxgo1oxmf0IEZvZbis0Lm3q5HPIMeiHAEA+ZkGJ57OVfKM
AMKYN+3w4QGjetvoPOjvn66wmw6kFQ4=
=TJqo
-----END PGP SIGNATURE-----

--xRfGtZNLLEHjsLNX--
