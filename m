Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDE57032B5
	for <lists+linux-pci@lfdr.de>; Mon, 15 May 2023 18:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242040AbjEOQS4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 May 2023 12:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242300AbjEOQSo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 May 2023 12:18:44 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22910A3;
        Mon, 15 May 2023 09:18:43 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-96622bca286so2067008766b.1;
        Mon, 15 May 2023 09:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684167521; x=1686759521;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fFPJu/bdf2To7OKUQNPH4m9IQexv87evllOs7pwaC0s=;
        b=HOI4BtGRGKeREF4vFCjUoTunSeoZhYrwxv47tp75FfmjjcgWHsaU0LNYoVuKZrMktk
         hqnIWnXQb2ZfIUWOuSigjbAmmxsWMLe3HoI9rUbL/UDVgYtGx5YtzY0RcqES+MTXVvR1
         hDy5+Aj56e/EaKdD+mRC9hKUcKxf1WalvDAvcjlUFDy0GQprZivcrhDgOKsh5HvbvNrF
         y6aeTIBOi2EYSWOYWNOJpYnIOLmYGiJUoP83ZTY7j+HcaEbEd6SN2u5/VbJsg9oOb4g4
         EUMNKOklA2Cck+L3MZEP6xP4GMOVmdwDpEmt11g44Gg1sb2sR66mrk9filyfrArjC5cp
         AoEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684167521; x=1686759521;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fFPJu/bdf2To7OKUQNPH4m9IQexv87evllOs7pwaC0s=;
        b=OaJgIFpzvW35q/x6rkvvpf7YrobK0jFQ8fE/cbupTpMk+UpEAy5PAFg7P0+xnRbEhl
         uc7If/S6AudcW0s9bLuTXjTJvvVbftDyktkIMYFFScGc1UFFETmD2nMKvlngDoxSYcBn
         QIY65JdlnkCoYiB7y2PqANYv5av2kouX1hL2yflE1QONSLTbiNsqvaLSmjMf9onpEdf5
         jFtLwh5Jhd52DjoobJ0jry0rOFblDksgRmtxLUDq5e3AvrALaSlaxJBpi3HckibQjrtf
         cVFoR3sqnk7Z2sz1mvj8ujltoQyQdzqmu3DELwMQpygjZQVJn2Bft2/eXrlTgNVd6Ur3
         7DSA==
X-Gm-Message-State: AC+VfDwMK/MPgzpe/jWPiLkeJ29OGvmyIbIlLjBj4sDD2Mk7gAkMEnnT
        b6jfwq+t3JGNWB8xqnN6VqCxg1f7fLGjRg==
X-Google-Smtp-Source: ACHHUZ7syZQng2BvbRJEc59vRXvP+m7Y4V8LOWuPg2Y+gG3U6DbYMfHN6uYfLKL8kbgDSe1ANhRheQ==
X-Received: by 2002:a17:907:d91:b0:933:4d37:82b2 with SMTP id go17-20020a1709070d9100b009334d3782b2mr31727220ejc.57.1684167521167;
        Mon, 15 May 2023 09:18:41 -0700 (PDT)
Received: from orome (p200300e41f305300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f30:5300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id hg10-20020a1709072cca00b009659c23e78fsm9653018ejc.215.2023.05.15.09.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 09:18:40 -0700 (PDT)
Date:   Mon, 15 May 2023 18:18:38 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sumit Gupta <sumitg@nvidia.com>, treding@nvidia.com,
        dmitry.osipenko@collabora.com, viresh.kumar@linaro.org,
        rafael@kernel.org, jonathanh@nvidia.com, robh+dt@kernel.org,
        lpieralisi@kernel.org, helgaas@kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, mmaddireddy@nvidia.com, kw@linux.com,
        bhelgaas@google.com, vidyas@nvidia.com, sanjayc@nvidia.com,
        ksitaraman@nvidia.com, ishah@nvidia.com, bbasu@nvidia.com
Subject: Re: [Patch v8 0/8] Tegra234 Memory interconnect support
Message-ID: <ZGJbXg88JOu4aiNe@orome>
References: <20230511173211.9127-1-sumitg@nvidia.com>
 <a032d9e6-6cb5-1856-9eda-28028bf05633@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8qg6A1xwpz6/pQdH"
Content-Disposition: inline
In-Reply-To: <a032d9e6-6cb5-1856-9eda-28028bf05633@linaro.org>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--8qg6A1xwpz6/pQdH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 14, 2023 at 12:41:45PM +0200, Krzysztof Kozlowski wrote:
> On 11/05/2023 19:32, Sumit Gupta wrote:
> > Hi All,
> >=20
> > Have incorporated the suggestions in v7. Only changed 'patch 1' in v7
> > to fix possible race when setting 'mc->bpmp' as pointed by Krzysztof.
> > Requesting to merge the patch series.
> >=20
>=20
> Can I apply it since you request it? I asked you long time ago to
> clearly state dependencies or merging limitations. It's v8 and cover
> letter still does not state it. Neither the patches do.

I thought we had discussed and agreed to merge this through the Tegra
tree, which is why you had provided Acked-bys on all the patches. I was
waiting for a final Acked-by on patch 1, since that was the only one
still being revised.

If you prefer to merge this, that works for me too. In that case, the
series:

Acked-by: Thierry Reding <treding@nvidia.com>

Although it might be good if I pick up at least patch 8, just as a
precautionary measure to avoid potential conflicts going forward. As I
understand, it should be safe to apply that separately.

Thierry

--8qg6A1xwpz6/pQdH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmRiW14ACgkQ3SOs138+
s6Hwyg//UwQpQ0EtSE3NvPmUTkNdtOnRCNocLMvlMPxH/nQSEy+fKcNW1vtXrFWn
2hOa0ZdmQaS+3M8ZECIQlnuu9AsBJuivyeuGhOvyf7FX96wiGqtgSxbZHk/mzljL
N3n1dOX90QYos9kh2OvRxreV/CnSwutuvs3AmhXv3MS1MNHBSFCAJ/RIc+n8McqU
WDxRDhdyUyPdfsaO7rEpdm3VbSQqcUSEnY6q93lJd6/I4xYacQDPsKxlSyurZT07
pqn+6oPTXnfRJH2qhXPDLceVLV2RxJdj8dv5ig/cpZBGPUPSY7gDsVhpib8OikUt
NXfT/TXX0GVwC+w0T7BXbFS1ZlHUeoA/cW+l5wOjz5zKHMNqkjpKYQ8gHDC3fX7p
0Lm4Jpj+TRr5Crb0pXNdRk9t5ZxeFGndOyqOW2CZTEbVNKjSNVsEhGd5AmsEny0u
6yk9+iLf1mcLrWwzAWF6WwzyYOcB45cDRv8YFbyaTy9HIVH0ZZuJi+anaYZQRcOF
sK3ERbA9P/e+d0j7pRgN8J2DR44z71Qq5jP338tBUeyq4xG970h4ikdVd9rF7Arb
8ZJyRhHJnQ4zfbhCRGioIU5aINj3yn87p9l1N5MIoFV4ZzsGiO2e1zAGBUh7QN/b
5YxjVuIyMSsH+tYrb5GHHtrJPmBOV9swfnwQHkfXiIEMd1Lnn3c=
=V4PZ
-----END PGP SIGNATURE-----

--8qg6A1xwpz6/pQdH--
