Return-Path: <linux-pci+bounces-14891-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF969A4B69
	for <lists+linux-pci@lfdr.de>; Sat, 19 Oct 2024 07:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57D271F220AF
	for <lists+linux-pci@lfdr.de>; Sat, 19 Oct 2024 05:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2A91D63E3;
	Sat, 19 Oct 2024 05:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8zSQrzX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067F11CCB38;
	Sat, 19 Oct 2024 05:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729317391; cv=none; b=nmy2ezZscbL5AYZwbjqCXezDI8sgGi+yd9UGkhsFebwL798ZjMnYkddf7R4qEDWpO9z4CL4vzfcU/iGu0J9bpU3psTptfo5tN+BYeyDUNes71kJj3p1jZNuzjF12dBlPmwRVl/K94z21uj/46Ru/B2IsvVwTvKNn2PkxDlwDl4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729317391; c=relaxed/simple;
	bh=b5b4LY3dZKio27Rh7DTB+kLmPwIAeyavRYt/eXrOWjs=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=u3PsEnFn88kME1oO+g6JJ2oUI5p+f287Rd4o4tfKe2PqTchwW1IU/bcRQZnh0hdNQhWxb0ceRsxbKIScvAS5OFynKCiM6SdnjYT3fNgVTRd1ait6aGOovh9phIPPphtuOKD0V41etdyOwF+pN17KxKT6eioNBhdXrSC063MkVA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8zSQrzX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D5E9C4CEC5;
	Sat, 19 Oct 2024 05:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729317390;
	bh=b5b4LY3dZKio27Rh7DTB+kLmPwIAeyavRYt/eXrOWjs=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=b8zSQrzX3j48lS9xgwwlNdaleIZeuC9FGNWAcOS6yg+fNeAWgvJzxkV4/QKGYLVMZ
	 CRFG9QebUF496vvbdOddO2quSYDrBm7WzENbPXE6irTqtdmmZl4HRZzKwc/uAKwns8
	 udFBU55QVuEaej6ppKTDg+JFsopQEwx0fbeIV0mwDcpu7PyYi0IVwJMWB4Oel9QWdh
	 If/tuEqkD34A1FRXVSR7HkPd7Qu+lvo0fWrJYPVGr0cdnNxJntaiROfxlYd72Rd9ec
	 AtQ2LliDUlRBQj07tO6CxcHwXr8IGRX1J4J4dpjyrVbNLT9IZzIROzccSnFi0oSbM3
	 E4SKGvsMCy7Dw==
Message-ID: <c0afdf9f8c9773ef83274cb119d14c90.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241018-clk_bulk_ena_fix-v3-1-57e8bb82460c@collabora.com>
References: <20241018-clk_bulk_ena_fix-v3-0-57e8bb82460c@collabora.com> <20241018-clk_bulk_ena_fix-v3-1-57e8bb82460c@collabora.com>
Subject: Re: [PATCH v3 1/4] clk: Provide devm_clk_bulk_get_all_enabled() helper
From: Stephen Boyd <sboyd@kernel.org>
Cc: kernel@collabora.com, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org, linux-samsung-soc@vger.kernel.org
To: Alim Akhtar <alim.akhtar@samsung.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Bjorn Helgaas <bhelgaas@google.com>, Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, Jingoo Han <jingoohan1@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Krzysztof =?utf-8?q?Wilczy=C5=84ski?= <kw@linux.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, Russell King <linux@armlinux.org.uk>
Date: Fri, 18 Oct 2024 22:56:28 -0700
User-Agent: alot/0.10

Quoting Cristian Ciocaltea (2024-10-17 16:17:29)
> diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
> index 82ae1f26e634572b943d18b8d86267f0a69911a6..0d0fe364b66a8590d5e7c63dc=
6c1e70c59d53e89 100644
> --- a/drivers/clk/clk-devres.c
> +++ b/drivers/clk/clk-devres.c
> @@ -230,25 +239,27 @@ int __must_check devm_clk_bulk_get_all_enable(struc=
t device *dev,
>                 return -ENOMEM;
> =20
>         ret =3D clk_bulk_get_all(dev, &devres->clks);
> -       if (ret > 0) {
> -               *clks =3D devres->clks;
> -               devres->num_clks =3D ret;
> -       } else {
> -               devres_free(devres);
> -               return ret;
> -       }
> +       if (ret <=3D 0)
> +               goto err_free_devres;

Please don't use goto so that the diff is minimized.

> +
> +       *clks =3D devres->clks;
> +       devres->num_clks =3D ret;
> =20
>         ret =3D clk_bulk_prepare_enable(devres->num_clks, *clks);
> -       if (!ret) {
> -               devres_add(dev, devres);
> -       } else {
> +       if (ret) {
>                 clk_bulk_put_all(devres->num_clks, devres->clks);
> -               devres_free(devres);
> +               goto err_free_devres;

		return ret;

