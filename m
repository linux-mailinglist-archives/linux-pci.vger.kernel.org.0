Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9295479002C
	for <lists+linux-pci@lfdr.de>; Fri,  1 Sep 2023 17:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237385AbjIAPxj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Sep 2023 11:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234355AbjIAPxi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Sep 2023 11:53:38 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC4210E4;
        Fri,  1 Sep 2023 08:53:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D482FCE241C;
        Fri,  1 Sep 2023 15:53:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 340B7C433C7;
        Fri,  1 Sep 2023 15:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693583612;
        bh=JWNcJNvheH+akiGf3PgkzFM5AjpEwjUxYvmw8i2FLMc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jJaPxDJwSdCAsS6m4FKe5rBGc6WVj0fdAMb0QJ/AUJmaVUP5LRv3cF8ldefuEun4j
         6Dl6Dra+bI51laMGDUgK/zifULC+Ck5YujTXyPkwcaxsp3Z9VTEWeVA31Vw5vvwP64
         xxCcUDwlfqo2u02+fVn64jp8XxvFYS1Dk3Uds2zTkfPM02zvK27SOsFAjX4cd68nMD
         NQYMu5r1Q1pgVFsxFF2e5WC3fjMpl6eUjwO2wkYkbhI5+ngilgLpDhfdOWA7GULIgt
         x5UGSFAJwnlojdKkcgW+ONYr1VejzO4LUA5YDVV68edNdF0P9r0w8T/ATXp0TxICjP
         tuQcX0y//zx7Q==
Date:   Fri, 1 Sep 2023 16:53:26 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, mani@kernel.org,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 0/3] dt-bindings: PCI: Revise dwc and rcar-gen4-pcie
Message-ID: <20230901-squeak-pacifism-00639bfab28a@spud>
References: <20230901131711.2861283-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VryAOrk3H+CfsRBh"
Content-Disposition: inline
In-Reply-To: <20230901131711.2861283-1-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--VryAOrk3H+CfsRBh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 01, 2023 at 10:17:08PM +0900, Yoshihiro Shimoda wrote:
> This patch series is based on pci.git / controller/rcar branch
> to fix dt-bindings doc patches. Krzysztof mentioned that the paches
> will be squashed everything later [1].
>=20
> [1]
> https://lore.kernel.org/linux-pci/20230831140426.GA255922@rocinante/

On the basis of it being squashed:
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Otherwise, the commit messages don't offer explanation of what the
problems are etc. "Fix minor issues of rcar-gen4-pci-ep.yaml." means
nothing to me, for example. A link to the comments you were addressing
would have been nice.

Thanks,
Conor.

>=20
> Yoshihiro Shimoda (3):
>   dt-bindings: PCI: dwc: Update maxItems of reg and reg-names take 2
>   dt-bindings: PCI: rcar-gen4-pcie: Fix minor issues
>   dt-bindings: PCI: rcar-gen4-pcie-ep: Fix minor issues
>=20
>  .../bindings/pci/rcar-gen4-pci-ep.yaml        | 39 ++++++++++++-------
>  .../bindings/pci/rcar-gen4-pci-host.yaml      | 36 +++++++++--------
>  .../bindings/pci/snps,dw-pcie-common.yaml     |  4 +-
>  .../bindings/pci/snps,dw-pcie-ep.yaml         |  4 +-
>  .../devicetree/bindings/pci/snps,dw-pcie.yaml |  4 +-
>  5 files changed, 50 insertions(+), 37 deletions(-)
>=20
> --=20
> 2.25.1
>=20

--VryAOrk3H+CfsRBh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZPII9gAKCRB4tDGHoIJi
0iNhAP92naUqrS2pxl328tQuKWri+BT9Ad3GNBIuPvfp+k/bpQD/eCEogjTZ1Yxh
nLz5NastQ6MJgEuBUspxqGk1REW/KgM=
=OJRm
-----END PGP SIGNATURE-----

--VryAOrk3H+CfsRBh--
