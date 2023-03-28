Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA736CBD02
	for <lists+linux-pci@lfdr.de>; Tue, 28 Mar 2023 13:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjC1LF2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Mar 2023 07:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjC1LF1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Mar 2023 07:05:27 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9FEC1BE4;
        Tue, 28 Mar 2023 04:05:26 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id t10so47849485edd.12;
        Tue, 28 Mar 2023 04:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680001525;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hgAzbw56ejUDiI3qD00xbyBSvhLL/o3WUj/Sgq/sOmU=;
        b=pJ9yxRFOnNYegckCt7yIRBc/csN+qzHfDBPX3owq93O32P4SSJL51DEZFLhWbRGgTT
         agVv0pUgtrvo8Ikvvbw5qHUOq3H5t57L0NqRQ4dj0EqaMj6CRRYI1PA1y9KRmy9KLycl
         1WThE+YfrDRZ2TZOKngL2dT5CJodOQ3UAsj37mzM4t1Jj2asXCVUZMShFrScV3+jadxP
         xQAI4w5+nnm5edZXfdM+9o3sxxU73GnTqPuTFqzDJbfWFnXzY6kCmbCZ7BZ2qVrK2EQr
         NwYQU5e+/zJc3RF+Ko90vbzHskYUh2nSM/04zHdAuW66fXacdybn4skssciUOcLH7o84
         1HXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680001525;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hgAzbw56ejUDiI3qD00xbyBSvhLL/o3WUj/Sgq/sOmU=;
        b=W+wABF0pYnPW3WUVy/3hPM0fh/cwYIUV+wzVxsue5FIrxLuysfMHv4xSLfAWttstTd
         H3VzbtCdSJramO42jOrCBuA5dEDx99zIzEpKAxXmwY9Gfymx0wh9VOzoPJr5jrCGBo7p
         7WwHse/z57L+3aDUJAQeZAO2nBqbtMaBfB2vSwC5StXFhg5XBwKUGp7ufP9xU5AVHgd+
         TU1HNwGapyexhN2q/Xw9x/Xt1MQpOgZ1mAMlTntkqJan9wf/D9ZfZAJmsTJatLMQb0wa
         tR5qRIU0ytr+BxrhxecfSLagq48c0XjkmywvAsk5H7wRPlyHa1UzGU8dLKfFxxOOBMqW
         ICww==
X-Gm-Message-State: AAQBX9f9apdgnr9JKoeax0JVi6brQBosIxN/yADlFRRuD5Q28yzxaUDL
        aJ1nVu9ykvUbLXtxPcQ/n94=
X-Google-Smtp-Source: AKy350Z7rt4UoBfZevUBtoA1huLQE0D0hotgjOT3yD3iK4uWGd8PbuMvVbtvJQGJp4u5GzZ70hIxPw==
X-Received: by 2002:a17:907:7e87:b0:93f:f70:b2e6 with SMTP id qb7-20020a1709077e8700b0093f0f70b2e6mr16994611ejc.0.1680001525237;
        Tue, 28 Mar 2023 04:05:25 -0700 (PDT)
Received: from orome (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id c16-20020a170906925000b009327f9a397csm14596170ejx.145.2023.03.28.04.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 04:05:24 -0700 (PDT)
Date:   Tue, 28 Mar 2023 13:05:23 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sumit Gupta <sumitg@nvidia.com>, treding@nvidia.com,
        dmitry.osipenko@collabora.com, viresh.kumar@linaro.org,
        rafael@kernel.org, jonathanh@nvidia.com, robh+dt@kernel.org,
        lpieralisi@kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        mmaddireddy@nvidia.com, kw@linux.com, bhelgaas@google.com,
        vidyas@nvidia.com, sanjayc@nvidia.com, ksitaraman@nvidia.com,
        ishah@nvidia.com, bbasu@nvidia.com
Subject: Re: [Patch v4 03/10] memory: tegra: add interconnect support for
 DRAM scaling in Tegra234
Message-ID: <ZCLJ895gHPXQE+Lz@orome>
References: <20230327161426.32639-1-sumitg@nvidia.com>
 <20230327161426.32639-4-sumitg@nvidia.com>
 <8b04a266-20eb-f1c1-278f-764b1b06b78b@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="z50dz8DtOK299JG9"
Content-Disposition: inline
In-Reply-To: <8b04a266-20eb-f1c1-278f-764b1b06b78b@linaro.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--z50dz8DtOK299JG9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 28, 2023 at 09:31:58AM +0200, Krzysztof Kozlowski wrote:
> On 27/03/2023 18:14, Sumit Gupta wrote:
[...]
> > diff --git a/drivers/memory/tegra/tegra186-emc.c b/drivers/memory/tegra=
/tegra186-emc.c
[...]
> > @@ -158,6 +260,9 @@ static int tegra186_emc_probe(struct platform_devic=
e *pdev)
> >  	if (!emc)
> >  		return -ENOMEM;
> > =20
> > +	platform_set_drvdata(pdev, emc);
> > +	emc->dev =3D &pdev->dev;
>=20
> This patch looks like stiched from two or more patches... emc->dev does
> not look like new member of emc, thus why do you set in exisitng
> function in this patch? Why it wasn't needed before?

This looks like it may be leftover from some development. These two
lines exist in this driver a few lines further down. Either one pair
should be removed. I don't see why this would need to be moved, so
probably the above additions can just be dropped.

Thierry

> >  	emc->bpmp =3D tegra_bpmp_get(&pdev->dev);
> >  	if (IS_ERR(emc->bpmp))
> >  		return dev_err_probe(&pdev->dev, PTR_ERR(emc->bpmp), "failed to get =
BPMP\n");
> > @@ -236,6 +341,25 @@ static int tegra186_emc_probe(struct platform_devi=
ce *pdev)
> >  	debugfs_create_file("max_rate", S_IRUGO | S_IWUSR, emc->debugfs.root,
> >  			    emc, &tegra186_emc_debug_max_rate_fops);
> > =20
> > +	mc =3D dev_get_drvdata(emc->dev->parent);
> > +	if (mc && mc->soc->icc_ops) {
> > +		/*
> > +		 * Initialize the ICC even if BPMP-FW doesn't support 'MRQ_BWMGR_INT=
'.
> > +		 * Use the flag 'mc->bwmgr_mrq_supported' within MC driver and return
> > +		 * EINVAL instead of passing the request to BPMP-FW later when the BW
> > +		 * request is made by client with 'icc_set_bw()' call.
> > +		 */
> > +		err =3D tegra_emc_interconnect_init(emc);
> > +		if (err)
> > +			goto put_bpmp;
> > +
> > +		if (tegra_bpmp_mrq_is_supported(emc->bpmp, MRQ_BWMGR_INT))
> > +			mc->bwmgr_mrq_supported =3D true;
> > +		else
> > +
>=20
> Drop blank line.
>=20
> > +			dev_info(&pdev->dev, "MRQ_BWMGR_INT not present\n");
>=20
> And what user is supposed to do with this? Either make it descriptive or
> drop.

Agreed. I think we can just drop this. If the intention was to provide a
quick way for people to detect whether BWMGR is available or not, using
something from sysfs/debugfs would be preferable.

Thierry

--z50dz8DtOK299JG9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmQiyfAACgkQ3SOs138+
s6FbVA//bUVPUi8Z6YbSbsr4lHpodrVcNKo8kLvOAIm4MrRyRHiEXz+fzcorFDD1
DuvPL76LXtzwRgA6fcQPOgRjeLkTQspfkIb69WzeGYFwqVY6ddPTfMTwucmYwIqZ
4lMCMpiDuv8onPnmMH/l3PEiHFlzETb1IIfIDs6+u1NZ0jVyi0ovEM4y9jGhOb5x
3+K+HFl9zAMLaXRWH+ckLaVJ075FUTZw3rp13v4kCjSy7Zbm3NhnJqf7zftJDfk5
Hxzawn21Yw/Kb5ANSWOuPhwP+has+BPAp1P8JZIgBSURxJaxY1C6Utv6yx7zWWpS
LydIrQBS62gSS0l5Kh095FZbPUwHOKbCh7E0yqvDSz323v+HjhGm1KUeJ42tYKkg
b2D0vwMqSjKVKm2vZ1QqVqvYSU/2UFeo5Iu4niGeOiaRRQ0D93zTmDzK4VN5ISBo
rTQIt3u+ypphgF9rcHixfORuyIE0pmR1UJy+U5D+ko0x6599i5d+gXinXAg67DMG
DUTGb0JP+9FqF5wcpMacTkR+s2eux5IvT+hRaKr0PAzityvDlcnq9lWa6SLkCJsp
eDpPoDcTRGYtaEcy37zU5wtXuV9lLGOUWVrkZiHILwN8S+G8EO6lmM0ISmHemHAJ
acMXRTtGeOMCybdN+qD+41oLPMMlqzgqhNKQWDkPHceO5Lu3jEY=
=xbRH
-----END PGP SIGNATURE-----

--z50dz8DtOK299JG9--
