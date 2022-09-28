Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B5A5EDEDC
	for <lists+linux-pci@lfdr.de>; Wed, 28 Sep 2022 16:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbiI1OfR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Sep 2022 10:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233506AbiI1OfQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Sep 2022 10:35:16 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8D87CB79;
        Wed, 28 Sep 2022 07:35:14 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id l14so27560779eja.7;
        Wed, 28 Sep 2022 07:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=bITryamKPXAaRRd2P5JThc+kCnMrI1AdcBLFS62YJTM=;
        b=JME++gzbxsQDSHyB5nBuZ+eAXbc+6lkyj/ZOK33HsVtR7zkN40I3qzN3hi9LxzimAP
         Dfw34Bbc0jDus2v8SCLIs3VF4bA+7dI78cTOsJDOas4EDEtKYywcJ+VrbGyG7IpP0iSO
         0PKTR3wnaYzH1i0LFnR87b5ndDyTJYTBed3m18qBCHBWIx7z/uwAC5cy4wa8y2N4Q3Ue
         dLHKikSqmaN57yU5P+0OimIXTsY4/Jg8fkoJ7THtLvEYpAENciUb/J8kJwrEBqG8BI5p
         GV9PQEsTQe4lJodk82nGdvnFFGYcaZSHa2iUNxQvnuX1PaS0uvGGU48CE9dISv3oape0
         v1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=bITryamKPXAaRRd2P5JThc+kCnMrI1AdcBLFS62YJTM=;
        b=AtmHUryLi5+SWJJWbVlN+k4HKwC7w76WRA6S3zSffKd9EZYEfnk34KiQI6iv9TlD5O
         BKZpP6Rp7lG14nlCJ6URV/w3SWHCMfSHOoKcJJp3xpqBkfjOWZZbkudU9080tfTQeq5D
         u6FGXiWmHRwIN3hAI4hK2uBzNNUJ0L/aksslPHFCxSaxbHk/B3aulF++xsa4Avqyx/iv
         AVzrmQwHRQdmqOvw13pkRrVE7VGMrHTCHj788pX6j/kZrI6/lELBqKkVGeJppFtx8aDE
         IQmzsCc63yg8rf0+J3BUk7jJGS2ICSCGrvIxoLHSr+9hxkUWzUS9tY2bngJpMFLQd5YF
         lRkw==
X-Gm-Message-State: ACrzQf0pPjJndAoNjkgx+2RCSFMmBFed8Ny4qpZuzUR3ZabMmvv4j1Ag
        jmvcds4KK1tvQ5LlIPWSYto=
X-Google-Smtp-Source: AMsMyM7EDKPCuPoi+lD+mpD0Wys7tz3LPH1v2LlA7lAm8CznGXnuyPttmyMkcDlXYNpz9imHcrdwJw==
X-Received: by 2002:a17:906:730b:b0:782:2eaf:a4ad with SMTP id di11-20020a170906730b00b007822eafa4admr29146255ejc.27.1664375713473;
        Wed, 28 Sep 2022 07:35:13 -0700 (PDT)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id t7-20020a170906a10700b0074136cac2e7sm2467887ejy.81.2022.09.28.07.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 07:35:12 -0700 (PDT)
Date:   Wed, 28 Sep 2022 16:35:10 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra: Use PCI_CONF1_EXT_ADDRESS() macro
Message-ID: <YzRbnjb6UVwrj/li@orome>
References: <20220928121911.14994-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RyfNZ9e+knk+ANeR"
Content-Disposition: inline
In-Reply-To: <20220928121911.14994-1-pali@kernel.org>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--RyfNZ9e+knk+ANeR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 28, 2022 at 02:19:11PM +0200, Pali Roh=C3=A1r wrote:
> Simplify pci-tegra.c driver code and use new PCI_CONF1_EXT_ADDRESS() macro
> for accessing PCI config space.
>=20
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> ---
> Please look also at this related patch:
> https://patchwork.kernel.org/project/linux-pci/patch/20220911113216.14892=
-1-pali@kernel.org/
> ---
>  drivers/pci/controller/pci-tegra.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)

I had to go chase down the patch that introduces PCI_CONF1_EXT_ADDRESS.
It would've been easier if this had been part of the series that
introduced that, or if you had provided a link to that patch here.

Anyway, looks like this is equivalent to the existing inline function,
so:

Acked-by: Thierry Reding <treding@nvidia.com>

--RyfNZ9e+knk+ANeR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmM0W54ACgkQ3SOs138+
s6H5Dw/8CCO0A48ejlIl6fquIuKAyXV4HMQnBUd+DQgaINWHH893pKdu1BsR672v
IBVB6xEb+9zR5l5zqPyxGl6p51xXhzE6H3FxEOYnSxk1tJAzRTeo/hslUvhWTCWy
ePiI+7zY8zxAEwSIUF0fU0kyoMuUMyDZELJTbxF5PM4PoDYy7fYSTptN0DTztsEk
ftpnOOVTWVIArYRrBPQEyk60teDGwQOAYlICcjqlm8yt3Zsn6yNEh5M0wmO/oDZH
kJtCaw5kymBa610fny18hooEZpE8SypRbFptOpi6/Tagkj4RywPYlBTfCo3qWDvR
Tv33A/X2RB+f0/vyUjfUmZN3GWY00lv64N9IRucYLpSDoN4xjrWsVTXAmCDjAMKS
OOkGIJuEt+T/aPX0DqpxrKOEm/dw3ywURK05rinmPsisWShOyBm7p1/yxm3smZL4
35TyDIsSCLpGQCoLZc7zPsD6h0fo0bK8VLPUeulzMC4ZYXjP53G7HTSGWHcMqecM
PJFUv9PuzLdfvbkbixFsNzSpZo4HqTi41VlHIdlSzUXd1aZsBvcc4a3B9c8fFd1X
8Jc0bGLDhmxAFQeGpjKtXMy1++p34yrO1hI80IS2jDV7je63ZKA7zlCrBA4+cjM7
cnjGjC+ZyDLd8S0XkYf3NdJXIkmrk3EOfzXdDSj3EfOOyVHLl2k=
=a3Eo
-----END PGP SIGNATURE-----

--RyfNZ9e+knk+ANeR--
