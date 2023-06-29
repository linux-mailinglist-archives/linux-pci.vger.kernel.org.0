Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCE2742E5B
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jun 2023 22:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjF2UbI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jun 2023 16:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjF2UbH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jun 2023 16:31:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3694530F0
        for <linux-pci@vger.kernel.org>; Thu, 29 Jun 2023 13:31:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BD6F61632
        for <linux-pci@vger.kernel.org>; Thu, 29 Jun 2023 20:31:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF2F6C433C0;
        Thu, 29 Jun 2023 20:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688070661;
        bh=FCckL39hhcHT57R5uYeNPhUQQwIFbfubCkljbMtdAYM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pMFxkZiZLQWOpfqIBlL5paN6vadf1xSqWH3B6cDg6kABJyAg2i8HrcsxL+IhRhc0c
         IOsoaOZu0zbuIODy6l6FoTHHpq97rmxDSXrvRNyxm/OHUCmVsrMR653cFN6ahVNpTM
         qUd669BbNdNkLyY3fRbgT5zD0BnZr4hNzl0RoX3x1P6/2OqZpbkQ1d63XJZ/ejlh6p
         boHl0SpSzSuZt0ysN/UtfNgjKS7v8M5iSNITjGA6KX694kD0PBJgItkHBPOFCxpKfi
         afmfzOc80had61Fthbtb8M8adSHUjeyO/MtIhmUUkCmPeeKLBVaXgvn6KgA/8ENsPt
         bHcWmAI5xLtKg==
Date:   Thu, 29 Jun 2023 21:30:55 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>, Yue Wang <yue.wang@amlogic.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Srikanth Thokala <srikanth.thokala@intel.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 3/3] PCI: microchip: Remove cast between incompatible
 function type
Message-ID: <20230629-smirk-resample-6741dcf9eac5@spud>
References: <20230629165956.237832-1-kwilczynski@kernel.org>
 <20230629165956.237832-3-kwilczynski@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1tORRD56oX7m24Ur"
Content-Disposition: inline
In-Reply-To: <20230629165956.237832-3-kwilczynski@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--1tORRD56oX7m24Ur
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 29, 2023 at 04:59:56PM +0000, Krzysztof Wilczy=C5=84ski wrote:
> Rather than casting void(*)(struct clk *) to void (*)(void *), that
> forces conversion to an incompatible function type, replace the cast
> with a small local stub function with a signature that matches what
> the devm_add_action_or_reset() function expects.
>=20
> The sub function takes a void *, then passes it directly to
> clk_disable_unprepare(), which handles the more specific type.
>=20
> Reported by clang when building with warnings enabled:
>=20
>   drivers/pci/controller/pcie-microchip-host.c:866:32: warning: cast from=
 'void (*)(struct clk *)' to 'void (*)(void *)' converts to incompatible fu=
nction type [-Wcast-function-type-strict]
>           devm_add_action_or_reset(dev, (void (*) (void *))clk_disable_un=
prepare,
>                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~
> No functional changes are intended.
>=20
> Fixes: 6f15a9c9f941 ("PCI: microchip: Add Microchip PolarFire PCIe contro=
ller driver")
> Co-developed-by: Daire McNamara <daire.mcnamara@microchip.com>
> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> Co-developed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>

This looks to be the same content wise as the patch I previously acked &
effectively the same as the one I previously reviewed - you could have
picked up either of those tags from the other submissions tbh.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--1tORRD56oX7m24Ur
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJ3p/wAKCRB4tDGHoIJi
0nbtAP4sy4P0Oru7YzNbLHMrWLhkwYJyOVKPMFqjwd0yIUAjLAD+M46rYMGjK+Se
VSqbMkFjW4dHvnCRoYjmNpzWoWvKUAc=
=eJrt
-----END PGP SIGNATURE-----

--1tORRD56oX7m24Ur--
