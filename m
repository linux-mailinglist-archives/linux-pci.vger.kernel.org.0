Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 786A51E8631
	for <lists+linux-pci@lfdr.de>; Fri, 29 May 2020 20:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgE2SFZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 May 2020 14:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbgE2SFY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 May 2020 14:05:24 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39569C03E969;
        Fri, 29 May 2020 11:05:24 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id e1so4808419wrt.5;
        Fri, 29 May 2020 11:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oaV3HDgGaW/NdtRSKlBZ4ciqfTWQuovxIxjYOpe1nbU=;
        b=MComGRxNSGOa2AQcZx8svu/uqApOWKEYSEr2xBJDnae+l5DzInr1bPXiPAH+Fna2w8
         QOoAzytrQn9ZyvJ0B6YJUJIvAzc+ETN9gBglLQBM5HRcN+K33ubV8ts7QyGrlYhaLEv1
         ebNasHcWy12Mx8+fAnzNK3pJPqS0+B0rSvIsLYGUguzA0pzvqix4meK7bxRLFKcqFIzm
         0b1rEjyO+aV0eVutL7TO55I2WAPfo2o1FYIkEEbcuw4XvIRXN/CjdmEvxQWG1TWFpfdf
         4gyhbbz4Q9N2Z+7yh01woPV/QR9FjUJzefck20Xy0Lny2vqrBcGqIiC1zkieeOxWEtGz
         Jadg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oaV3HDgGaW/NdtRSKlBZ4ciqfTWQuovxIxjYOpe1nbU=;
        b=OruHiKZaVunDLfCT7ixKx+dCr0t9wWOFM9gUj0aIYtneq0nULxy95ONMW1SzjdxFYK
         ydoztacbGN3+oAMIdpwUPON9R1tHn6iKqZuKH8NRSgz4cRDcjc5nICpCqaiJ0pMI18mb
         0x7A1fbeu4nOJMPz5RX2fM1usJbbiVUEt2DI5L8c/CLbUz+BQwU1PKoZSHpX+32Dqhlh
         wa+rccAd7In4XbSwncHaTtAJuwxP54bYNawVIGQi3xT+0x9gj3DG+kFk2f15c0ska0T3
         homqkR01qCXEBNGT4rj4zeg5mypwUkYWtmL5aiOrLRaPWQAgMgn1ZwGIDYFw5VTVoNO4
         i1Yg==
X-Gm-Message-State: AOAM530zetuUoqN8JzouzhIgNt9tvxAQUECnsFDnUnMWzlWiSowS6vpD
        RGMJNA/3JiO4WVcsV6x8irA=
X-Google-Smtp-Source: ABdhPJxWYCv97CQHbzXupNUr3SbhQeyf/jQNBDfH31WBn02Uqr5j6SgI7ipKH03fRVpx/lh3Omy+1w==
X-Received: by 2002:adf:f707:: with SMTP id r7mr10497594wrp.390.1590775522997;
        Fri, 29 May 2020 11:05:22 -0700 (PDT)
Received: from localhost (pd9e51079.dip0.t-ipconnect.de. [217.229.16.121])
        by smtp.gmail.com with ESMTPSA id u10sm248995wmc.31.2020.05.29.11.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 11:05:20 -0700 (PDT)
Date:   Fri, 29 May 2020 20:05:18 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     kjlu@umn.edu, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] PCI: tegra: Fix runtime PM imbalance on error
Message-ID: <20200529180518.GA3078281@ulmo>
References: <20200521024709.2368-1-dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <20200521024709.2368-1-dinghao.liu@zju.edu.cn>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2020 at 10:47:09AM +0800, Dinghao Liu wrote:
> pm_runtime_get_sync() increments the runtime PM usage counter even
> when it returns an error code. Thus a pairing decrement is needed on
> the error handling path to keep the counter balanced.
>=20
> Also, call pm_runtime_disable() when pm_runtime_get_sync() returns
> an error code.
>=20
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>  drivers/pci/controller/pci-tegra.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl7RTtcACgkQ3SOs138+
s6FFww/+KMM+DRTaPWNZojZr63GKToc/xvSE1Nb55d6CJHWJdLjxwzaoeVxmMAzO
W9sX31ectNIrK1a1p+4TiErNIrzNr4bEyjZWpGMlljo2LJrS3e7n5VNVHrZBK5PW
mfxdVWdhYWVoVtQOeXf193TSRLkAuvsiznFknYHr4sKCBTXCm06zaRucjFxIX2Jt
EzF0L72aKYGQe93JmSGh3HJdOrryiCd3f5IAc8kc+KfYRAUm8jlLIgmUUGM9o+GR
NQGhHFHm/fnsQAehXieRx1DR4GwZPa1FzrBBkhGcMNcg+io8Qe1rdH3imSD17P5D
v+lB6v3SMHOdf0/ahUGHf6/xkuX2oBvOYEhmMucguOXksM0N/QsuyHUAkIc/W6Tc
RnPrxtK4ui8LrCJtrLb4+Qn3L33IMj0eIKEajY7/IA1Z/ElILC25HgQHlsbFWPis
WCbAv7vYvdf7uunrys6fTr2WIuX6f3lOI2svqfVfWFkmzAN3D0Cxl1vOyTb5FXjG
CH/1Jf0CxgCMZDMB4F/7NNH1snTQ8hNPe+u40TjlDexYV28ArVCzJ+IH3ghdUb9O
2RcDyL4yIpAJJ5VPwd9ao9HEg9TiRzGoi0nqSWtauGDbasTFLcDtpFSQYijJpJfg
JFgpeJ4a5Cn54XZSwdZs9oWaXvkJoP902S5fUZkuHgDc8SQXtqU=
=3fsG
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
