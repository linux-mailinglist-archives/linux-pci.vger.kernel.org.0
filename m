Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF6591DAF06
	for <lists+linux-pci@lfdr.de>; Wed, 20 May 2020 11:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgETJko (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 05:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbgETJko (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2020 05:40:44 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0631BC061A0F;
        Wed, 20 May 2020 02:40:38 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id x20so2824505ejb.11;
        Wed, 20 May 2020 02:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ADjHdTIqQWA2GKdm5wosIbVA7qcZMOsh9pTvjrEbKGc=;
        b=atLc/iwFND3LI8tpTOAPuRqxkiJzV6Ul7YMqJqhMS5JHWaH6/pwpYhJK4p5Fqciqc3
         JyneqrVO/Jzd7emLQpiyMycoytfjo3dudeIbwaGujGCcyyroVrx4bjUMdTsAfqpycZlb
         83jlB7EgroB0rgoDyBLjVTwsveoE1o2UsKao64q+BWESa9vu5HfIsqDI941gx9Scx1rJ
         hg5RCYVcbjTxYvxaH7QaFaaf0JuhySw1wn9CX06zOGxJzJLL7gtdHeleJyeOnBcfBx42
         ONiLBtHfAjMxf1X1/PXSBullG7Di+8b/7V3aTh0wXMTYDYsbxyGe8Ma1X/5OrGlILEVI
         xeAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ADjHdTIqQWA2GKdm5wosIbVA7qcZMOsh9pTvjrEbKGc=;
        b=OXnCh884hluHyyWF4cv/fRnQ7TenJ6U9FYWJSg6lsY0f/2iwNDkdMeerwM3kz/HvSU
         +j/Dx4W3woXTE8qVMTq8oselffGVHIrnkETaTevi0IBCwZ2X4E4IKiYnfJ98W7bMM/gj
         eV1GMNBlEJT8VClI1551ZjvX2YeOAVm3gn2/du2jwb2VBP5QeRoK4j2TENd8yJRdtnT/
         71hFPRuE6blqPNu3D+pbfgCCDiHPWwBG8K19eiB+JWgJWDqOABAfXbEQ69ue7MZD3drb
         OVObTtrd335GNrwbNig2HnnKXcQ4z5mbNvPwxWSk66H0i86OWF79tpianEmnpzTVBkTO
         ynbg==
X-Gm-Message-State: AOAM530HRDfYbqR1eFCYjALOLKKSjiTlWMReT95CeZeN9c9fbJYirNaa
        ejm9p03yVbm/A0lG0oWVdHQ=
X-Google-Smtp-Source: ABdhPJzwBNPfX8wLJBhheOieRefmuo7Yih3L2ox5kOQGM1KQSaz0kDU4d4/OhNLC9RUb/PXkwrCZ/g==
X-Received: by 2002:a17:906:3095:: with SMTP id 21mr3090796ejv.32.1589967637648;
        Wed, 20 May 2020 02:40:37 -0700 (PDT)
Received: from localhost (pd9e51079.dip0.t-ipconnect.de. [217.229.16.121])
        by smtp.gmail.com with ESMTPSA id u10sm1325154edb.65.2020.05.20.02.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 02:40:36 -0700 (PDT)
Date:   Wed, 20 May 2020 11:40:35 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     kjlu@umn.edu, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra: fix runtime pm imbalance on error
Message-ID: <20200520094035.GC2136208@ulmo>
References: <20200520084012.30190-1-dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="S1BNGpv0yoYahz37"
Content-Disposition: inline
In-Reply-To: <20200520084012.30190-1-dinghao.liu@zju.edu.cn>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--S1BNGpv0yoYahz37
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2020 at 04:40:12PM +0800, Dinghao Liu wrote:
> pm_runtime_get_sync() increments the runtime PM usage counter even
> it returns an error code. Thus a pairing decrement is needed on

s/even it/even when it/

> the error handling path to keep the counter balanced.
>=20
> Also This driver forgets to call pm_runtime_disable() when

s/Also This/Also this/

> pm_runtime_get_sync() returns an error code.
>=20
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>  drivers/pci/controller/pci-tegra.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Otherwise looks correct. It's came as somewhat of a surprise to me that
pm_runtime_get_sync() increments the usage counter even on failure, but
it does indeed.

With the above fixes to the commit message:

Acked-by: Thierry Reding <treding@nvidia.com>

--S1BNGpv0yoYahz37
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl7E+xAACgkQ3SOs138+
s6Ev0A/+LbNyGHEdbiqOD9y5/qaNsNqqMWMlwIt/mWXfZScDeEIpC3QPIsDtD5xU
ouYqP8sbmo/0Elu56py6NUKPWEC0xDRX9TwopJ7HwSFa8egl1AjR87eHOgjXFXgd
EuVB7+7TyE2rxp6UBtqQu1y9PDcTWmjQvyLaXBfQMyZqNaSt7e71yTdsz3cMHVa0
DnNipyvYDrGUzr/cgadt/kN5FrTGQbgEodLebDnkgzOHVuqeJKuCBGpOGUL2eEKS
r6fg3zb64SNwzQxB8k5hBek6+S+drfyTRcxzJgJOctehCq9xFA/5COUwdZpdzWQr
7tD8AVEe+GUb1MS1VugJyVdMe3QecRKCuO7fqJPLjLuy54LCHYJVUyMpWBvVYslf
Sl1e3ClVjUUt65y3Rtuvf0c7WzhRURoVBycKxsGlwM/nWZ+JjF/eejknZsifFZLQ
FDtEgX+MWIa0XL59NY419YH1ul6xwTIkK6mU7F+gEkK0E0lcsVyX1ItHKPPJWQ0C
hsRJCuGMqTlYetZorIzkAuOQCY0qR7qtsif1g+k7y2NeGBtDVDFmrsZjJNw52NRE
6wDjxlZaCGGAXMu38SqDjUCSuXSSBywODU+BJuD3AyzT3CZ6nU/gfBv4K1QsITQi
M9Q3U4+kFzKGpLHCVngyRhbZG9IYh012GSJeEDY+K+PX+I+/MU0=
=0vzD
-----END PGP SIGNATURE-----

--S1BNGpv0yoYahz37--
