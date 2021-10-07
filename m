Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B225425A98
	for <lists+linux-pci@lfdr.de>; Thu,  7 Oct 2021 20:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243636AbhJGSXM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Oct 2021 14:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233844AbhJGSXJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Oct 2021 14:23:09 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BAAC061570;
        Thu,  7 Oct 2021 11:21:14 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t8so21956462wri.1;
        Thu, 07 Oct 2021 11:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eS5l5u8+Tk1mYVZJCj81/uOAKA7hO8DSQEcw2KahanU=;
        b=Aqh1NVC9X02IZBff+Y2fVgaNXtq7LJr2Cffbg2WfNn/nxN22OU7uiiO4eG7FutWVhH
         QRcPYXj+1KOvlBszW3ALiv3iIlBv/1TIe86sCMiuY1/ezhdrUJM+1Zf4YsesgzqGUD9R
         OhDDnadyRA2mXCLv1kUad+/PmxNiHPtv6l8p+9a4pLgDKhPvwc2FcRlTpYs6XWHt/l4x
         IDq/TsTnsfwAPongKHkADEqnXXClygQl5r/bYOZHjFCgT0YMaI3ZUycB4LwZb5gyTl8z
         WzxQ7ZerOJdIJj51S4zOx/gOEb32AGwCliXSez2SHbJPoQKMB4TgbvYLtCcm/mPPleLa
         94kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eS5l5u8+Tk1mYVZJCj81/uOAKA7hO8DSQEcw2KahanU=;
        b=Q0oh9KyuoMW+c+L8LETYjbgrnTwk72dKDrr4RCtIahER0FHURPaTPg8/Zu/C6/FYnN
         nXph+kxO6K1tbiiOIsrkC5TsxxrN5PlJWjpNj9wYI1g5F4GepNz52xaUnj40XxrLCmax
         wTUT4GJdq+o4/Gus9BAdo7/fTQOAHlm6DpKrf94xR9Jq+8addICfMQBkm8fVc5y3tiyC
         8ms886b9t9NKh/R2XofUmmjJF7rmTHrDNj3ZozmisJVadkLfjAyfRIcKMAwNoRWH2teZ
         EnrLfyx95xzZ3sZN7SBNZ66MUpB8+u41S18AIk+ArAh/C3ucoiYEgZiUVlEm4U0xagD+
         PbgA==
X-Gm-Message-State: AOAM532JPsDX4cuCFk0V8hu9L7X770sAM6n/LT7ol4e0760Z9QhZxEti
        cDyrbs04XrtMHZifNj5caMM=
X-Google-Smtp-Source: ABdhPJzwTcFatw6/sTe7GgwZ8BP0NH/upuFhBMqxDL6/Mqrqgx3lhSRIq/brVJdjM5NLMwB5o1k3mA==
X-Received: by 2002:adf:a1d7:: with SMTP id v23mr7467729wrv.171.1633630873247;
        Thu, 07 Oct 2021 11:21:13 -0700 (PDT)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id b15sm76170wrr.90.2021.10.07.11.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 11:21:12 -0700 (PDT)
Date:   Thu, 7 Oct 2021 20:21:11 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Mikko Perttunen <mperttunen@nvidia.com>
Cc:     rafael@kernel.org, viresh.kumar@linaro.org, jonathanh@nvidia.com,
        krzysztof.kozlowski@canonical.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, kw@linux.com, p.zabel@pengutronix.de,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 5/5] PCI: tegra194: Handle errors in BPMP response
Message-ID: <YV86l4OhqKN0AkMN@orome.fritz.box>
References: <20210915085517.1669675-1-mperttunen@nvidia.com>
 <20210915085517.1669675-5-mperttunen@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tFSCm+qk1Uyu+TSl"
Content-Disposition: inline
In-Reply-To: <20210915085517.1669675-5-mperttunen@nvidia.com>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--tFSCm+qk1Uyu+TSl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 15, 2021 at 11:55:17AM +0300, Mikko Perttunen wrote:
> The return value from tegra_bpmp_transfer indicates the success or
> failure of the IPC transaction with BPMP. If the transaction
> succeeded, we also need to check the actual command's result code.
> Add code to do this.
>=20
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  drivers/pci/controller/dwc/pcie-tegra194.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--tFSCm+qk1Uyu+TSl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmFfOpcACgkQ3SOs138+
s6HiLQ//QBasV3sip7PQxWdzfgJL74Ctwh7OfExUCBSd1PhakUoyS+m9sk8Tieqm
FxVvU6tJjLci5HoRkYwh9Xmat6Gxn14YR7NI2LsofCuh2DD1huc9WbxyoNzuzMl0
ASLP4qY2a3jDoaAQEyVhsl+yIYqW2xzt1R+/WcMKVrwfOlbc7GkQGHM1WmbOssZ/
e82MUvIiQOlKzH7EfNHONZMlAj4puk4n27ho3pDGqGgZKYzhUhIdx+hl+QfQwsvy
LfMuYghB3Khz+f6u8oJoVMfNJxEs/jr+bjsKinYY1QsB0UefOd/1SPFkyQznBLG6
wzSTHPKL02/WVsIO5urOXomFCp2iDaP6xLdpmS1pnw89KD4/d6HoAmi0rW2T5fXK
91TYp0U9Vg951AtK8vCWaP14qPgdlb8hZtl25OBut1UJBLwfnRUwNP+t+ng/r6aZ
12NtV0TTTLeP5z9e/R9FDzD6Grmm3CuVCNpZqrZyv6a7PD+xaN/wvklDzPnRf0Cj
t1C40n+j2Tu+BYOZCE9wRD1o5vErXhhkA6lKQI8EyuO8YR/EimQa7hvzoaFGkamY
R2x4v0MLy7ql8seZnX0rPVh3RGSUtWjXZMOzAfnWdLYGMBwIu8VVeLwtDFgpw+b9
gMTrX+6AvdyhqqqNpWZhOo4XyfbUpyiDgizZn7m0n0o0eomxf0A=
=Esys
-----END PGP SIGNATURE-----

--tFSCm+qk1Uyu+TSl--
