Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7B93978A8
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jun 2021 19:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbhFAREq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Jun 2021 13:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234492AbhFAREq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Jun 2021 13:04:46 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FA6C06174A;
        Tue,  1 Jun 2021 10:03:04 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id g20so7359199ejt.0;
        Tue, 01 Jun 2021 10:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pXMzv2dknDoL7JPkXn/TuXhQO+T7tuVSK8fCsQ1MDW8=;
        b=cHbMRfl4PTGDrInu+kUlRDrhr2PnoLqGMeMqNrKQ1JzWd7gm1CZhbiz9YCkifNabEd
         AcLiPA9zF03VRY49AL0ya+/76xJVk4CfuT6qX2mf3/JLbIYh6hQoHCbjVPhPsQ59t4zr
         5L5iGMvZHbTqHh6cXXQ4B3fns4pf2fwjzVwuZHqg14wh87I8V6UdjdN7C0aDxur2nQr8
         CiBaC6ynR8ikaT0goUqjpT3ai/IBoDVAVlN1t9J+bBLBEb2828SVLVkc1tSJUXeWp8QB
         mKH348aa0nZpTkq3R4QMXTRWSU2kHjnmX1uVY7+MUd4azHj+86mco2zVA+fPKTup6qmy
         02kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pXMzv2dknDoL7JPkXn/TuXhQO+T7tuVSK8fCsQ1MDW8=;
        b=rcKEYKnnJKKcY5qlhVuPwH4EHS9KHbUTcYdzU07QiajYO9PEMjSb/mYfiVjL2D4cR0
         DHWTUtJI8DP8giTkgsIPZ/dhP43uQaVCOHwyNSuY5amSDAoUQ6KJ8mmaFAxYA8YZqnLJ
         YtZg4FJIv3ZaXfKMMzCSlEl4Ja4J8BbhkBmnHCMT43OUlmMoD26/zhIX8sWU8/+QXGyV
         ItwKthWrMLFxIpTgCyb6LBkFOdI34S5glElCCEVmAc3Ru/GS4oyaN4Uwy6lc5H5qo151
         ywz0y0+nuM82TPm0HQ1s6AlDK2Nbg1fwy5HdgUWXKM8cymptKAh/y45t9H6JWUUjwKCb
         esGw==
X-Gm-Message-State: AOAM5314KePDyticDWCfbdigbA6r7EFpjxF04KEexhghlX+U1iFn7zsc
        I3RUMZRJtIBk9jBhnpgzzK3XxJZJPK8=
X-Google-Smtp-Source: ABdhPJxFRqoyCy02GFAR+AFVjiWrab+UEWNxdzt+a9vFHSF/xWpgpZkGHP33AmKDJB9bQVvqAsXB6w==
X-Received: by 2002:a17:906:f9d1:: with SMTP id lj17mr9644880ejb.345.1622566983014;
        Tue, 01 Jun 2021 10:03:03 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id j1sm8775816edv.14.2021.06.01.10.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 10:03:01 -0700 (PDT)
Date:   Tue, 1 Jun 2021 19:04:37 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Zou Wei <zou_wei@huawei.com>
Cc:     lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] PCI: tegra: Add missing MODULE_DEVICE_TABLE
Message-ID: <YLZopfEiv+4uzH8J@orome.fritz.box>
References: <1620792422-16535-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wx+er7KiEyvePTDY"
Content-Disposition: inline
In-Reply-To: <1620792422-16535-1-git-send-email-zou_wei@huawei.com>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--wx+er7KiEyvePTDY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 12, 2021 at 12:07:02PM +0800, Zou Wei wrote:
> This patch adds missing MODULE_DEVICE_TABLE definition which generates
> correct modalias for automatic loading of this driver when it is built
> as an external module.
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>  drivers/pci/controller/pci-tegra.c | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--wx+er7KiEyvePTDY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmC2aKUACgkQ3SOs138+
s6HcaA/+MbOXo1+hpebluYaY0ckMgHPeUfiGr7UgDbPk/LLG1Sa3B1++2nukfL9D
UXowBEAQIp/VHDZDpmHBpjC1nHAhS3xzCSB29aCeeQI1juJ3mqAIYZgwwf0nTQuO
r9b/ZaiLHTo9eJxnntI+Z8rL93UHFcdQW0CA8WEoqgp4IitzRU5AApJMR2b8tnzs
AsG53CfZu5KRFrWvbfeZ7Urj/4vPMgvTg+K4OAElZxcFF4ylaET+w42dVAWpyliY
h15TceleLv/71HQLpro5Ck/IGY8o4H9oYhWryD4KXT0/RsSVZX/xGH8fkiRHaeVD
P2zpTOZ8NrOqcUU/bIf7V8kYiMHWnc+3YsCpRINT/eY/LOG+Vig7fhmuFYFMRzOb
8vgEM8QPOnA1nAAA2asJ5bBny/f3XMDBp3Rt59yyA9C9QDJoEZOye6mIxilyrqfp
9pRnc59zpdJqsgy40or20CetWGTvgIUm1wq9tr9UcIKK220qfNtrxtJ5uSTUdGw0
rhvL950Mso9oXRegDnxk7bO51rsMZYMW1gZUBfDS6jqdSdElP/OPwj4vouUjcoY/
nqgkO1MjWm39vWgP2JLSU8N3kMzzBiMX4O31TOee8Ta26gyllP1WNQ2RlMusH5un
azG61F15EE43STxJmSEUCrjIPagUkCVtTvuzDJG7M2Iva+OCW7w=
=9uNf
-----END PGP SIGNATURE-----

--wx+er7KiEyvePTDY--
