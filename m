Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D74752B4C00
	for <lists+linux-pci@lfdr.de>; Mon, 16 Nov 2020 18:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731934AbgKPRBx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Nov 2020 12:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730829AbgKPRBw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Nov 2020 12:01:52 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6570CC0613CF;
        Mon, 16 Nov 2020 09:01:52 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id a65so24279785wme.1;
        Mon, 16 Nov 2020 09:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c3CTpkaJK+UixnUEvBg65ZoBUOSpxaDhzbHcJ5DEGNI=;
        b=CuLldi5UDBDN2rTF1hkcZa6Ezpl6ewm/TY1Mtyupsu6d0arVIzH1H26nFGzuHgiO59
         2ZByKjRKOR3joy83M35Y2k4U9RqRJ4AMYs7qshl6R1sYwHTbcdWxKIrCNbXxuvnt0v+e
         4s+17RD2KoZdgIAD1pAvbG9V+fLTi1vTWXoxPPj6jw0neMzW3S9LitqrEeTDvNvZChXz
         t20IvU0E02z0Ln4TLcbLlX8TGXQ8+5HbTHTdETDDTjAkv8vjkpXW86GFMpxdzNPJI5dk
         UolUxpwbxi/cnbeRm7bUCA5Zlkvr+CVmPBMWbng/u6RtxcrYu6/QKhAqgP6T9ezsOzuW
         FynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c3CTpkaJK+UixnUEvBg65ZoBUOSpxaDhzbHcJ5DEGNI=;
        b=a+f4YBXGSEF6XY5FnuN/E+TQWXpLanmz6J//BIABRyoha8atF8FRDB5yWeWtMMJfwQ
         1vJixCuFWv1q8zzsfcZIYuZFFrEAsAr91fxn5Q+ZX0bvGdssvwIP4C1WzPkqyUyV+c1m
         1B6EjBZ4+6aZcP2NJWbW1FSBDejSh2hfx9dKSHfemkiEQsDLV5BTvOGnM5aUZ4VSxfp9
         eDbaKQKdxcu5PJY+zaSNA6JBboBQq3LdN1alj12cV3pFFswe3ZbJfUvl91SZs9G+jXGn
         EzfwaApBFsfdm1a19M6CiAJqdzNoDsJqMVZkFvlIWXMP8K4yQt5NzONSzsjNEcECFlPA
         q20Q==
X-Gm-Message-State: AOAM533RSny7kJ63X6/n4PLCyrfHrFOQshH84f1fCspX/LfK/0QA4mnY
        p+dTehvg5cv/iO6yv2FPDyDUcZOgBfM=
X-Google-Smtp-Source: ABdhPJzI6XAZ9igUYwWvC227Lh/pGF/9AZ8r1Lo0t64282p84UhM0xX65sPVYICkN7HZC6IeMKV9ow==
X-Received: by 2002:a1c:c286:: with SMTP id s128mr16426739wmf.88.1605546110875;
        Mon, 16 Nov 2020 09:01:50 -0800 (PST)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id d134sm20299429wmd.8.2020.11.16.09.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:01:49 -0800 (PST)
Date:   Mon, 16 Nov 2020 18:01:48 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-safety@lists.elisa.tech,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra: Use PTR_ERR_OR_ZERO
Message-ID: <20201116170137.GA2587640@ulmo>
References: <20201116165407.8050-1-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Content-Disposition: inline
In-Reply-To: <20201116165407.8050-1-sudipm.mukherjee@gmail.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2020 at 04:54:07PM +0000, Sudip Mukherjee wrote:
> Coccinelle suggested using PTR_ERR_OR_ZERO() and looking at the code,
> we can use PTR_ERR_OR_ZERO() instead of checking IS_ERR() and then
> doing 'return 0'.
>=20
> Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> ---
>  drivers/pci/controller/pci-tegra.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

This has been proposed multiple times in the past and Bjorn and I have
agreed every time that this is not an improvement, so sorry, but NAK.

Thierry

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+ysHsACgkQ3SOs138+
s6GC7xAAnSsYlESiX6ESGZs1qV+dr+SktWx1QxMTKlk4fG43Mryvctb5YZb8vq2F
YZSf0Z/c1W9TbPrn2OLF3ZGi9dZanU5VsRzIiiCXXUF1NPLIdELn2Nes0WpBD9i2
6ZoUqRG4n3+8av6H3m3VJdbGElBOdFpGDcrzw1v7RQFjkBRYBtCKV7GxJo7so7u5
FgSBoJB/qL5+DVxa/6DJNtmiYqBk4ZGKpiTOVPzTgN1Fb3ZKoz/KPuql7cmunwxV
BbB2Xnibu3yJDW/TxaHin7+xUGTc9J9HAtIOKmY2ZnBeVDW6NC9e31x9i13efMLe
nLFLfw0KNdsHiex4aRgdEHqtZxYOCBUWA0vbMuzG5dnzCkZTZzqvn+Nvw/wntAv8
O7v/SK2j4cuo8g9V2alT8PKU99xALK9K4sxnZaN18sluR0Kx3JwLNnyT7Mqnpdwn
hwrvcHC34nNGAgrVri/SPzFPQt7zUrJHYlCjad5CS4G/sX+dr+AtnJ3gSAEFKo5R
+7YGVow03aIon+34KSyM+WBZrl+xwWxUlc04lr48UwavftC2Bp52Trup/yOaEUpi
3jOmv3hel97NrRun3JZA1SxD86wGuVUWRlDSAbTR6BDgau5bGViGRCobqRYGbA/w
nwgs2ETztkeL2jlyI5nVufNgQJ77SdECYl5Zm3Ga1xqMKZHaOK8=
=hvDV
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--
