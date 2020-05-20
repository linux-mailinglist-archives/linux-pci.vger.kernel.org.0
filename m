Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F382E1DAF83
	for <lists+linux-pci@lfdr.de>; Wed, 20 May 2020 11:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgETJ7M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 05:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgETJ7M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2020 05:59:12 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C79C061A0E;
        Wed, 20 May 2020 02:59:11 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id e10so2443715edq.0;
        Wed, 20 May 2020 02:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2mSdUGmI7gLDVcTe2cRva7FjtWoTpHYcaj/XLsqA2vI=;
        b=YrtU39lTeJAqPQQkZb43lfRtC64CIn07XJVKPFiifIeX+yYz+y0kFt69hvsUi1DL5I
         hdSX1YhEVemNYrY8ZU/B4CBhvMiKIDSPRz2hFHvmvwlGtEaCT/qhu3jzhZ2wcCru8SzQ
         znm/aRGuTKVPL1YPAondIqQVKPQdHmlGdkdJJMxnqRtjuMcR2huK7dXWq6OIlfR+30By
         xHXw+QmlpAbFep08t3buYP5+wxakkJh9lxXfAAtFu9xYhfhAubhb2pE4xCEM9DFVyN6m
         xAywPomt/pSC0O6K7a20RqGfT7TkVx/iMcf5NgMgFsWsS2fYnlQtrwjYMiX9y4cdiHC8
         C3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2mSdUGmI7gLDVcTe2cRva7FjtWoTpHYcaj/XLsqA2vI=;
        b=t5WKKjF+JfaqF4g33EeyXmkXw47EvOX1wRCP5mOWQt88QiwsuLglWSB6DC3Lkok711
         gXjicPyeovv3wRtTBdFs6DpvlwToOFk4Ky/WMwESnWog+qHI+bU8xb1UJnU+IlK789SM
         DvzPE3DuDM4BLm/fS9mzrlLizDpuu4RcQ9sAju1N2SEWUEROQ7d5axOWwxoORPjN0gYZ
         O5UP2RvQ91jlvGyBDiJqtURC0PnLWXHyNskpEErccWYhkgPsN7/hv7S5uELhSQKWXlFY
         cUK1tF7ZJDZtZwsD3NK2b7ie+sZFRBqargrWWeQjY/Yj2g+JtCBAVSa/HvZlsPzZo0+1
         /OQA==
X-Gm-Message-State: AOAM530VXbrr9mykJKLRKcBz2KD5yhdW+fnBzZFWTxGCvOIisrMInZ72
        mL3PUgC+4F6ct60nPrZj/Hk=
X-Google-Smtp-Source: ABdhPJxVsaM7q70jtdMBWaUYowpQP/8V2aQND/netL1y3AK3+eEzndfn8T1/gqlfNFC78XNNc91zQw==
X-Received: by 2002:aa7:dd0a:: with SMTP id i10mr2544659edv.291.1589968750534;
        Wed, 20 May 2020 02:59:10 -0700 (PDT)
Received: from localhost (pd9e51079.dip0.t-ipconnect.de. [217.229.16.121])
        by smtp.gmail.com with ESMTPSA id n11sm1505695ejh.39.2020.05.20.02.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 02:59:09 -0700 (PDT)
Date:   Wed, 20 May 2020 11:59:08 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     kjlu@umn.edu, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra: fix runtime pm imbalance on error
Message-ID: <20200520095908.GD2136208@ulmo>
References: <20200520085231.32552-1-dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RYJh/3oyKhIjGcML"
Content-Disposition: inline
In-Reply-To: <20200520085231.32552-1-dinghao.liu@zju.edu.cn>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--RYJh/3oyKhIjGcML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2020 at 04:52:23PM +0800, Dinghao Liu wrote:
> pm_runtime_get_sync() increments the runtime PM usage counter even
> it returns an error code. Thus a pairing decrement is needed on

s/even it/even when it/

Might also be a good idea to use a different subject prefix because I
was almost not going to look at the other patch, taking this to be a
replacement for it.

Although, looking at the log we have used this same prefix for both
drivers in the past...

> the error handling path to keep the counter balanced.
>=20
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>  drivers/pci/controller/dwc/pcie-tegra194.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/con=
troller/dwc/pcie-tegra194.c
> index ae30a2fd3716..a69f9e49dcb5 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -1651,8 +1651,8 @@ static int tegra_pcie_config_rp(struct tegra_pcie_d=
w *pcie)
>  fail_host_init:
>  	tegra_pcie_deinit_controller(pcie);
>  fail_pinctrl:
> -	pm_runtime_put_sync(dev);
>  fail_pm_get_sync:

Either of those two labels is now no longer needed. Of course it'll now
be odd to jump to fail_pm_get_sync on pinctrl_pm_select_default_state()
failure, but that's one of the reasons why label should have names
describing what they do rather than describe the failure location. I
guess we can live with that for now. I'll make a note to send a cleanup
patch for that later on.

With the fixup in the commit message and either of the labels removed:

Acked-by: Thierry Reding <treding@nvidia.com>

--RYJh/3oyKhIjGcML
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl7E/2gACgkQ3SOs138+
s6H1dRAAjP9fv8WTiqlN64A0U8jgW7w0okcZGXwf1+Lrb+g7s94GdR8KJD4vLHpL
lOVPr0BwTg4u6ED50ZaMrr0AJkkwlJCMniWIF9RK4Qdetuw2clnu/+Rx98ptS053
TcOa0LpwWQ8qPwBO/HQ9tRA+4EmrCG8qOLXHWIa1HkyAp8Gq4ju5x2x4E10MTNWc
YtjLDKnXLICCLLcPmhhG+gnVln6YF5l5qTPVcMOfPm7H31OMm8cTeGFgg8j3TdR9
P9ZyHooksciS4sktzruBzSoyYlun1OyCQoUK5yHTa+FhiXcvcG5C0ABSQkDlj87B
7ormUGu9p9BTXLZbch+iE3rCh4HCeNtppUY3RCrWSbAsXmnFeDEqItCTFthlcQyq
5PUwVLH3AixFgAigFSZ01i0TrBCox5ypo6lcUMpgFhmzPrQ8iHGlAU+ZUx3kVyNZ
mKSk2jh5wrJlgLQnDDs776nv2zwCXS2MV1xLunkUIw+dZe4twPQGbyqLnLov0nax
uHSUtL5wS4H/2tHim7EwhZwaz9JHIliKPz+yFx9Usk08uOL1q61JbWiMhKl+yXlL
X+3cYIM5AsO6wN0LaKj90msAlW0HqkfuVpCfULTzyxGjSNhwqiNNl4bM/FQG7Byq
L1vf1atVlNld4rFXE8yMCnAOHzFn5M9hjq45DnyYERIFSRa+/oQ=
=zMyM
-----END PGP SIGNATURE-----

--RYJh/3oyKhIjGcML--
