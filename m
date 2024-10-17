Return-Path: <linux-pci+bounces-14826-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F339A2E07
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 21:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54C862893D9
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 19:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9B617D354;
	Thu, 17 Oct 2024 19:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSqchSS7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9512E1531D8;
	Thu, 17 Oct 2024 19:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729194313; cv=none; b=dYCBd5KIaMBENkPZ6ksErCfuc1wUWisxcFB7C5gy+FJDd5cFwHjfighAa7G56CUbmOFyHk43BRlOaWfNSVKZ32Nzp9re3rvhMZvzQYF0qMeb1l89pWS8H2biSy00SQJaBSFXwwAWRQO0NAtE/YtD12d7kDO+jogzGw1BpSEcIcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729194313; c=relaxed/simple;
	bh=psIFTuXuseD2WW6j6T3TcBYpbsekC7/1uzW9/8EknCw=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=JkQsT0CAeOlCdY1gdNf2IfmXJQTGnKla/OSQUA51sv6OFV6oRRnf3eGOkZdlpQI2K/QM5DtNlIOpdWKMoXljZh8zzwj8TfX/yS5y1jkHpm+B3SzapTtGEunDW25hoK492HsU9nsxwXmxAEzRjSgGdjn/LXZFC5NYd1hP4bdlFOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSqchSS7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C588C4CEC3;
	Thu, 17 Oct 2024 19:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729194313;
	bh=psIFTuXuseD2WW6j6T3TcBYpbsekC7/1uzW9/8EknCw=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=PSqchSS7uwi7mlbtwy+4OMoPLCw3Mz2QYvruFaNFiaijIflbUUGHzwVN4Lx6jDGk6
	 /8kMkJamzUqb5RkoyDdK3w3nCV4Zc706jos/rYxDOM9ydLTCE3E1pBYVJQSOOP+srb
	 VRF/gllrmrSFqMWW+ZtaIQCQuvdJaCeRqQFDrCpGCjCpMuGKVImn/FDulfvTvh/DdO
	 6RH2hWeVLjtONIwHKtxCAz69CD3v/WUZoz7oI9oD+wdnrm43D4bfRic6j3oU30kaw+
	 REZToRFVO2nML1M0m/uwKYWkdQ8+NGtBmtBr5wx5127W+OHK704bNA9KHHN4uOKVCy
	 HVUsNIOxLbPbg==
Message-ID: <347771679b3ac765de3f79c26f3d3595.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240926-clk_bulk_ena_fix-v2-1-9c767510fbb5@collabora.com>
References: <20240926-clk_bulk_ena_fix-v2-0-9c767510fbb5@collabora.com> <20240926-clk_bulk_ena_fix-v2-1-9c767510fbb5@collabora.com>
Subject: Re: [PATCH v2 1/4] clk: Provide devm_clk_bulk_get_all_enabled() helper
From: Stephen Boyd <sboyd@kernel.org>
Cc: kernel@collabora.com, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org, linux-samsung-soc@vger.kernel.org
To: Alim Akhtar <alim.akhtar@samsung.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Bjorn Helgaas <bhelgaas@google.com>, Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, Jingoo Han <jingoohan1@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Krzysztof =?utf-8?q?Wilczy=C5=84ski?= <kw@linux.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, Russell King <linux@armlinux.org.uk>
Date: Thu, 17 Oct 2024 12:45:10 -0700
User-Agent: alot/0.10

Quoting Cristian Ciocaltea (2024-09-26 03:43:20)
> Commit 265b07df758a ("clk: Provide managed helper to get and enable bulk
> clocks") added devm_clk_bulk_get_all_enable() function, but missed to
> return the number of clocks stored in the clk_bulk_data table referenced
> by the clks argument.  Without knowing the number, it's not possible to
> iterate these clocks when needed, hence the argument is useless and
> could have been simply removed.
>=20
> Introduce devm_clk_bulk_get_all_enabled() variant, which is consistent
> with devm_clk_bulk_get_all() in terms of the returned value:
>=20
>  > 0 if one or more clocks have been stored
>  =3D 0 if there are no clocks
>  < 0 if an error occurred
>=20
> Moreover, the naming is consistent with devm_clk_get_enabled(), i.e. use
> the past form of 'enable'.
>=20
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/clk/clk-devres.c | 34 ++++++++++++++++++++++++++++++++++
>  include/linux/clk.h      | 24 ++++++++++++++++++++++++
>  2 files changed, 58 insertions(+)
>=20
> diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
> index 82ae1f26e634..4203aaaa7544 100644
> --- a/drivers/clk/clk-devres.c
> +++ b/drivers/clk/clk-devres.c
> @@ -250,6 +250,40 @@ int __must_check devm_clk_bulk_get_all_enable(struct=
 device *dev,
>  }
>  EXPORT_SYMBOL_GPL(devm_clk_bulk_get_all_enable);
> =20
> +int __must_check devm_clk_bulk_get_all_enabled(struct device *dev,

I'm not super excited about the one letter difference in the function
name as that's likely to lead to confusion for someone.

> +                                              struct clk_bulk_data **clk=
s)
> +{
> +       struct clk_bulk_devres *devres;
> +       int ret;
> +
> +       devres =3D devres_alloc(devm_clk_bulk_release_all_enable,
> +                             sizeof(*devres), GFP_KERNEL);
> +       if (!devres)
> +               return -ENOMEM;
> +
> +       ret =3D clk_bulk_get_all(dev, &devres->clks);
> +       if (ret <=3D 0)
> +               goto err_free_devres;
> +
> +       *clks =3D devres->clks;
> +       devres->num_clks =3D ret;
> +
> +       ret =3D clk_bulk_prepare_enable(devres->num_clks, *clks);
> +       if (ret) {
> +               clk_bulk_put_all(devres->num_clks, devres->clks);
> +               goto err_free_devres;
> +       }
> +
> +       devres_add(dev, devres);
> +
> +       return devres->num_clks;
> +
> +err_free_devres:
> +       devres_free(devres);
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(devm_clk_bulk_get_all_enabled);

Instead of duplicating can you make devm_clk_bulk_get_all_enable() use
the devm_clk_bulk_get_all_enabled() function but not return the number
of clks all in this patch? It will make the diff much more readable that
way.

