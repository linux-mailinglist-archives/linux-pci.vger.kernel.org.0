Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1522762E714
	for <lists+linux-pci@lfdr.de>; Thu, 17 Nov 2022 22:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234739AbiKQVih (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Nov 2022 16:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbiKQVig (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Nov 2022 16:38:36 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AA8248DF;
        Thu, 17 Nov 2022 13:38:34 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id n20so8593579ejh.0;
        Thu, 17 Nov 2022 13:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUJN6/PsoAr9DtbWPR15x8grcrsQm71np5836qd63DE=;
        b=qtCVMqDUxoyIcBpnGtQpu4ujjbRGeb4KtYwtjqU6HKyHFfXwZ+YCFYEsU7ICTJLTTa
         k8KYSgvtTY+gYH3K850o1j50RSJ3Eo/zvw+8XTnImz0vO1VgNEleqELQVURSnUmZyPXI
         J8cS7NkLWAnZ2CSaIpl8uvb+mk9HbHbu21+yhZMl38y2ssJMW2a9UmcfUY4od5jVZMzV
         9gKTZKPabws4V5jo4kGyw7nq7kNjN6+4S7GQfn6uV3rx12pI6wilTWwRQXh6dcIJfjNs
         iYEoptIDKRE0w0lLzx4wAu3CINg0YkzdjBjfxhenIYQb8DBWWbk3VYsLSxTurwRt1nat
         m9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KUJN6/PsoAr9DtbWPR15x8grcrsQm71np5836qd63DE=;
        b=LTzkMrgZzx7zfRPVjUB/uyC2UzexSXGlMc7bClEQKJGF1hgRDlsVTi+wT49mI2w27D
         rmlVIIGxZBacXQuilsLpqjqpFv1Qc9NiP1YOZBqhJD9dPppcanOQC21c/t6L8CZkA098
         adfUz82YGnvVhtAiiJsPCpVTP37tgXJZLBqSMzbMZiL5ezaN/hF5vzxjPxcTVDyjQWog
         /ROlfe7b0rTZWdapXLdpWuUwGThbkO89svMHbIbezfdXlfJh/2DL0OBl3ZrFmipSoPCv
         ymmmK3Q7zxWcigxvJZYE0Kortxqt1apUIp9EPLz3FQ6Fw75Id7RMHIxKchhKrX337V82
         K51g==
X-Gm-Message-State: ANoB5pmmSU+/Xm07JwxkTml3H+NrxFwu93H9DlNxANv0pLJYtQz/KDSA
        586wdEO48atqZNDFJbreNNs=
X-Google-Smtp-Source: AA0mqf6PPYkFug87LbQMmOYx+YPskLdCmwrLZsrazrdMUBctp7MS8eZ6nQvVCstuj8kmiVwZYJ3TOQ==
X-Received: by 2002:a17:907:8dcc:b0:7b2:b5aa:f1e0 with SMTP id tg12-20020a1709078dcc00b007b2b5aaf1e0mr136572ejc.54.1668721112573;
        Thu, 17 Nov 2022 13:38:32 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id kz10-20020a17090777ca00b007933047f923sm854163ejc.118.2022.11.17.13.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 13:38:32 -0800 (PST)
Date:   Thu, 17 Nov 2022 22:38:30 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, vidyas@nvidia.com,
        mmaddireddy@nvidia.com
Subject: Re: [PATCH V3 1/2] dt-bindings: PCI: tegra234: Add ECAM support
Message-ID: <Y3ap1o2SbNvFw8Vd@orome>
References: <20221114155333.234496-1-jonathanh@nvidia.com>
 <20221114155333.234496-2-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SRHx2eAeA4iCxjID"
Content-Disposition: inline
In-Reply-To: <20221114155333.234496-2-jonathanh@nvidia.com>
User-Agent: Mutt/2.2.8 (2022-11-05)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--SRHx2eAeA4iCxjID
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 14, 2022 at 03:53:32PM +0000, Jon Hunter wrote:
> From: Vidya Sagar <vidyas@nvidia.com>
>=20
> Add support for ECAM aperture that is only supported for Tegra234
> devices.
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Co-developed-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
> Changes since V2:
> - Avoid duplication of reg items and reg-names
> Changes since V1:
> - Restricted the ECAM aperture to only Tegra234 devices that support it.
>=20
>  .../bindings/pci/nvidia,tegra194-pcie.yaml    | 34 +++++++++++++++++--
>  .../devicetree/bindings/pci/snps,dw-pcie.yaml |  2 +-
>  2 files changed, 33 insertions(+), 3 deletions(-)

Both patches applied now.

Thanks,
Thierry

--SRHx2eAeA4iCxjID
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmN2qdQACgkQ3SOs138+
s6E2+RAAjuFYpzEgHKFuFYH6DWgLcgdiP21748X1m8Qu4TDX3nWnac5RkhXnkMjA
tWJKOEgmm/TTuUidG3HJ5Mt84i5+FKW3mhIKP2JLBOJuPNp5eJBo95aRjCrhNFkX
u8J5j18b3bZmQeZ7Y68Cs3mEp94c5O97c+qbQojYhuaBezHKkPZThs0sV9ngWKfh
oYmzVGWyUXCqIX0Ko24VH0nMx7ZEWDB1jQTzlQtoz3h7VBQbJfDI42ig8Equ8LXJ
etiWTKEbMvwfWeLtGH2bGsfIVgzc87O2LrjyjraYrPYlYzu27wWuKEhnmBZdtaqS
KX2ZRYZAKYvxQc/D5WA0MjqJhnHquT2gnHz48kPk0sEHqjafdK9Pmvqzmu3xDnhe
Q2sTwkcs/x7VrAzwYn2y9tt4cayeMGYyiiDodeQ8qq/tkpcc3Q/tFL3i1OP955CQ
QnXLCulkW9CsXKTy0aQPoL93gsGBwpSr+bsn8/1tifidieSqoINTdP/T3m8HaLK3
VrvvVTdI0yMTOWeyTDaFTc35yG+xabNf6GeAIhKiJLLU0AkmGATcDbG8Df2nBmHY
tzIadd70eX7eu0F9qAdz1PygTa3Pb7HEnvHipTCWj0dOHSz4MWFQCy8RUp9ZfJu8
fywK5oqXU0dp4FnfgGvLB1hqYioqIcnx8i3mLQjEr0QgS/wuKjU=
=9wEV
-----END PGP SIGNATURE-----

--SRHx2eAeA4iCxjID--
