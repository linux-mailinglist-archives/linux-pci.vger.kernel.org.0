Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F84744BBA
	for <lists+linux-pci@lfdr.de>; Sun,  2 Jul 2023 01:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjGAXNY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 1 Jul 2023 19:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGAXNX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 1 Jul 2023 19:13:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9B110DC
        for <linux-pci@vger.kernel.org>; Sat,  1 Jul 2023 16:13:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A40F60A29
        for <linux-pci@vger.kernel.org>; Sat,  1 Jul 2023 23:13:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19154C433C7;
        Sat,  1 Jul 2023 23:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688253201;
        bh=yKgMddQapKf3JCyJBuC01M7yETVYS19zD9KU+DqtD4Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LvdPoGGWJ6pcmV0sx7sh71ClnpIipklO1ZZBtDaBCMXjdIpcSjBhxDVMguluosZxQ
         8QH5Kt5DxMf+y+1cqOLjJdAIYVXIQB+p4quUUdfmpnwLWNuZ3K5gWzkLVtns8UDr9D
         ORp+hl7Rjcd+Ijh3Zupax24T5tPh4uDwsp4KUQOPMz96HDiZUNlOHVxhT4nmFnM1+V
         o2a9lBKzqqlTvjFC+bCO6IT8COWwGceL9UEbKGqOZk3Ly/wXqi3jjGG3262f6LRoC2
         Yq6AZlapivbt/UnuBwbim2Yoklp/d43qzMGHUVDroayPo4lV+jt1/Lokioi7xjxgPz
         OE27EhBkyUISg==
Date:   Sun, 2 Jul 2023 00:13:17 +0100
From:   Conor Dooley <conor@kernel.org>
To:     daire.mcnamara@microchip.com
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 7/8] PCI: microchip: Rename and refactor
 mc_pcie_enable_msi()
Message-ID: <20230702-audacity-gradient-a7871e31a97a@spud>
References: <20230630154859.2049521-1-daire.mcnamara@microchip.com>
 <20230630154859.2049521-8-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Kd4aL8O75rLHZ9c+"
Content-Disposition: inline
In-Reply-To: <20230630154859.2049521-8-daire.mcnamara@microchip.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--Kd4aL8O75rLHZ9c+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 30, 2023 at 04:48:58PM +0100, daire.mcnamara@microchip.com wrot=
e:
> From: Daire McNamara <daire.mcnamara@microchip.com>
>=20
> After improving driver to get MSI-related information from
> configuration registers (set at power on from the Libero FPGA
> design), its now clear that mc_pcie_enable_msi() is not a good
> name for this function.  The function is better named as
> mc_pcie_fixup_ecam() as its purpose is to correct the queue
> size of the MSI CAP CTRL.
>=20
> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--Kd4aL8O75rLHZ9c+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKCzDQAKCRB4tDGHoIJi
0j67AQDk5OEcJCa5lf1hVQ/cU8VwhepULzIUArDgqfqy3RVOSAD/WCrLcO+TP3g5
WIKDODvJxGPI0CPXgT8CWAA04v/+zQc=
=BAuH
-----END PGP SIGNATURE-----

--Kd4aL8O75rLHZ9c+--
