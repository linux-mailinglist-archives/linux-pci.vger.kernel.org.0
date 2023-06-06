Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FC8724D28
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jun 2023 21:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238971AbjFFTgQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jun 2023 15:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233962AbjFFTgP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jun 2023 15:36:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B6710CE;
        Tue,  6 Jun 2023 12:36:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60C626377D;
        Tue,  6 Jun 2023 19:36:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 816B4C433EF;
        Tue,  6 Jun 2023 19:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686080173;
        bh=c9XsJutBLh7hmmxKPmQcB1qv2YhvaDLdGlUW8WQJCwY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M/cXtdovllP1cfEWVlHb724WsLUYP8kNtasD7XIcbYqMWUqkNuVOqDfhxUiw+W2xm
         sRhx/Knww0wMM3r+/4EyXLor250isPeXsG5UxUut13HSn8oocxiH8kxkEfi9mTIwYi
         uKqYmq/WU32DRdAmIUgOxiafvIheBgwNaLfeW4l5M3XVnqJhsoJcY1kxRTNm1vGzIb
         eUhckquaKKLlKSRta/1NwNOpXldOnQHMPCwfM6DyhC/xJrClzwFAPV0nEtaSBOO6JY
         39wPbhyw8WajK24S0id2FwpADyA6W/4auxrOa/meGyO9zfeP6ufWhmFoLhkoMJaT+t
         uCoh4vk+rQaCA==
Date:   Tue, 6 Jun 2023 20:36:09 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com, Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>,
        Jude Onyenegecha <jude.onyenegecha@codethink.co.uk>,
        Greentime Hu <greentime.hu@sifive.com>,
        Jeegar Lakhani <jeegar.lakhani@sifive.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 2/2] dt-bindings: updated max-link-speed for newer
 generations
Message-ID: <20230606-outbound-certified-ac4d1f243459@spud>
References: <20230531092121.291770-1-ben.dooks@codethink.co.uk>
 <20230531092121.291770-2-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Drhd2EszKiBvUPTf"
Content-Disposition: inline
In-Reply-To: <20230531092121.291770-2-ben.dooks@codethink.co.uk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--Drhd2EszKiBvUPTf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 31, 2023 at 10:21:21AM +0100, Ben Dooks wrote:
> Add updated max-link-speed values for newer generation PCIe link
> speeds.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

>=20
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: devicetree@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/pci/pci.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentatio=
n/devicetree/bindings/pci/pci.txt
> index 6a8f2874a24d..56391e193fc4 100644
> --- a/Documentation/devicetree/bindings/pci/pci.txt
> +++ b/Documentation/devicetree/bindings/pci/pci.txt
> @@ -22,8 +22,9 @@ driver implementation may support the following propert=
ies:
>     If present this property specifies PCI gen for link capability.  Host
>     drivers could add this as a strategy to avoid unnecessary operation f=
or
>     unsupported link speed, for instance, trying to do training for
> -   unsupported link speed, etc.  Must be '4' for gen4, '3' for gen3, '2'
> -   for gen2, and '1' for gen1. Any other values are invalid.
> +   unsupported link speed, etc.  Must be '6' for gen6,  '5' for gen5,
> +   '4' for gen4, '3' for gen3, '2' for gen2, and '1' for gen1.
> +   Any other values are invalid.
>  - reset-gpios:
>     If present this property specifies PERST# GPIO. Host drivers can pars=
e the
>     GPIO and apply fundamental reset to endpoints.
> --=20
> 2.39.2
>=20

--Drhd2EszKiBvUPTf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZH+KqAAKCRB4tDGHoIJi
0uEYAQCJvsmVOqTqiVTOFRrbj2TpkFa99Hdagd5ZBTc5DjrMHgD+JQXKGbO8W1qc
5fHURf+KU+8MVjttlTYHST8KgVsAxQk=
=CMzh
-----END PGP SIGNATURE-----

--Drhd2EszKiBvUPTf--
