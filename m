Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E034E2C5318
	for <lists+linux-pci@lfdr.de>; Thu, 26 Nov 2020 12:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389351AbgKZLew (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Nov 2020 06:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389343AbgKZLev (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Nov 2020 06:34:51 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561FDC0613D4;
        Thu, 26 Nov 2020 03:34:51 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id a186so1848859wme.1;
        Thu, 26 Nov 2020 03:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QkVX+LYgjyaoGxSHZ8XTxdBnYsMoWUXcJCZHMiWGKus=;
        b=sKkUTs4cNqOVCpy4+hiU5x8ioSSvrcPwd0nSfCOMEtDHEG4y4OkWHteccParWvk4ln
         VyO01UMGJi4oq9CHXvaPv+vRFtN53UPRS9BxENYySNJ/+TPIDR8CQFB3VXC27lMG6Hfr
         b2c1vNRPGZL83eyWIEXYNrFsddXazoc79ZlRA/wWAhFfX4hqigU/cIWZaqHuldvjCtIz
         5l1H11+M1XSOSYW3USpbFJt71U7VvO4X3fxNnB2OqbhUTzhe2E8KsFJ2/NBrh9m2UkQv
         Ll33JQ7unEd/wJA1h6Htiv42axzlNoQvFhqDMH7D6M+yHYSl3dHotP6RzPaouPnsc4I2
         0xcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QkVX+LYgjyaoGxSHZ8XTxdBnYsMoWUXcJCZHMiWGKus=;
        b=D2mBniw76i4AARD3Ny+Qzz9/Vn9UXdaPvYiXB9h3PM/a1TqpT7nLXPbJj5aNkl4L7Y
         SwCaSQGkDtatm3Ap7rLeTDjtssJUD9nAeTflEk3IsIFNZRrBfiNocOb8VMtOfDBijOyL
         Yssl4LceAIIB1Dcmu3Pe7WcaKJBh4vmGskuY3qsUUeNHmfSXt+Q4vpSSvG2Oo2po+1xQ
         d1/ziFJXbAFRnjG7ZvnGEc4nbfazsckZRFzTKlUSkD/R6YpNZjs5IjND2tpWzeRTDgoj
         xg66oB5nOuiiLg7DWaynHn2+rEr7ek+eEFDZyuRZG3N/rK0rQxUOH5KeKLXl4LE+fnUV
         +Kqw==
X-Gm-Message-State: AOAM530PI1ru2jNyhWdnj/dPA8lH9UT85p7XOu3GsLABOYFLtClqNJKx
        /R4m5pJu4GidtiPd8EYj0YQ=
X-Google-Smtp-Source: ABdhPJwNIbwkx89SU5Zfr70Gj0PUI5c/+LLwm6c+rcLIN2VfEm85I4wj4CNoPm8HkOUiQcFEW5qpbw==
X-Received: by 2002:a7b:ca4c:: with SMTP id m12mr2943354wml.11.1606390490145;
        Thu, 26 Nov 2020 03:34:50 -0800 (PST)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id n10sm8284448wrv.77.2020.11.26.03.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 03:34:49 -0800 (PST)
Date:   Thu, 26 Nov 2020 12:34:47 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, robh+dt@kernel.org, bhelgaas@google.com,
        jonathanh@nvidia.com, amanharitsh123@gmail.com,
        dinghao.liu@zju.edu.cn, kw@linux.com, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V4 5/6] PCI: tegra: Check return value of
 tegra_pcie_init_controller()
Message-ID: <X7+S1wSqUCKW+/x6@ulmo>
References: <20201109171937.28326-1-vidyas@nvidia.com>
 <20201109171937.28326-6-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="85sL3q+8YeXPZSg7"
Content-Disposition: inline
In-Reply-To: <20201109171937.28326-6-vidyas@nvidia.com>
User-Agent: Mutt/2.0.2 (d9268908) (2020-11-20)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--85sL3q+8YeXPZSg7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 09, 2020 at 10:49:36PM +0530, Vidya Sagar wrote:
> The return value of tegra_pcie_init_controller() must be checked before
> PCIe link up check and registering debugfs entries subsequently as it
> doesn't make sense to do these when the controller initialization itself
> has failed.
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> V4:
> * None
>=20
> V3:
> * New patch in this series
>=20
>  drivers/pci/controller/dwc/pcie-tegra194.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Tested-by: Thierry Reding <treding@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>

--85sL3q+8YeXPZSg7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+/ktcACgkQ3SOs138+
s6ELhBAAj7OWOMN2zAgZ9IQL58MGpBP2DKECtOGo0ec01e+OGIZ8KmEEQpmS0FPS
atnvTy9HKTY2fhwG5hrElFgolhDMIevSrw14GQry0xi0DHKsKa2jV0u4wCEq5nja
lNUuE7SSeHu/Tph2mtDLWxHJgsDzwwQbqQPsKh3mWgd4bmRXBN72mmq3MP7u7Fk1
w8CIh83Unc/BAYXBYqNhiixtQzYxUfYZYbXEHsA44L3DRF+QaaqPrt21G+w/kUbV
B1/LvCClBcK6H0KZelzDEDbxCzW+aHXlmaLfsSoPblHYu7czjcACoBIms+/AaWSu
+AQek4cJ25nUWkrEFz7vWUf93t4+7oSffMKEglHT9A+arT/bKhiiZnKCRsTBCxv9
mai6U+ZPiMoSufiSNAeFsiWpSaXpwObuXeNVJKSaXZbtdsrthCSxhpiGpzUPYT1B
ycmAHu2pnvI0C7rA2FtPObwaP6Pmc16KFt3vtYH6AV2pFdoMz4ZvhoxT7GUye4+P
StBKwBrRI+V552peX3dRrWGSOMATCVqGKVa+3N6X42CaWNzBl/AqP0IUWAzshZnh
k36GtJmszAHdVfv5+2T2q/fQrw8HD76MkRrMVKeOKoeQJESthDjitEbLGcS8xEhc
+eUzFrLYTGNgMBoefax5NpzuNpZBQrpdnZTlyIiymC375uE5SG0=
=D9Rv
-----END PGP SIGNATURE-----

--85sL3q+8YeXPZSg7--
