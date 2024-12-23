Return-Path: <linux-pci+bounces-18984-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 732339FB5E5
	for <lists+linux-pci@lfdr.de>; Mon, 23 Dec 2024 21:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFF051639F0
	for <lists+linux-pci@lfdr.de>; Mon, 23 Dec 2024 20:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073B01D5AD8;
	Mon, 23 Dec 2024 20:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUB5a1yX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA16EAC5;
	Mon, 23 Dec 2024 20:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734987264; cv=none; b=Ww3JusjbyVxD1ESn2ZhkmfKmgSxlnY/ZeCFTOz438Vp5kViifDDkQOxw+kC1Pany7qym12aiAK+01rhK7tCo7wuWO2W6v2FJKqK/9zMNBi9MFYojOtlsgpfxGrDlxvX2q6xTJKDj53qw3yKRdQ5PuhZBUDBdX0Icfe5G7ouX0oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734987264; c=relaxed/simple;
	bh=NMMtTTxdzJLwiKMxV+CYvOfL5ZFO48bV3CdhVJI34gE=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=E6Kam/DlxSJZjqvhqYkAaHQirv2AGNnvMtEzZo8QKOoDnXdJufTp5x7OHz4qzXi7d+EqO5xigBTyHo8TNi4NaMqkzGdX2FjH1NHHUJRyxC5xWos8ByqeeO34HBZZsA2MYJJvHnTPOvcbpDM+/NSK4WlcyCEOnfU4QLuVpbht5NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUB5a1yX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28CC6C4CED3;
	Mon, 23 Dec 2024 20:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734987264;
	bh=NMMtTTxdzJLwiKMxV+CYvOfL5ZFO48bV3CdhVJI34gE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=aUB5a1yXiMwZPIGTyk+izkH/ShpjHcOdrTKB4oIAbQd1FntAk76oJfDOXe4dp0WT2
	 4wL40jcrxAGXkVwac6Acd2fffMI5wrdoJKaWnLve3jk+MF2OAHXtv22nqelpggGwPT
	 ZwO3TkWjCf4ZrupDLAmFmRGxbID1M5tx24EBvMWmQDMM5V3Wfz4/zNe8i+nvTZCyju
	 RM5FnAmGSEBis0mVHp68SxXtzw9lTvkKB69zuoPTYnGm0j5UuQJ/Vyn8ubi21wBEH/
	 Sa/MvoGBlBW0mPBBmdNRYL3xUZjbzp6Jzplf3B5Gvuiw6pYGkfsfP0PiQlrv0BlZYR
	 PEN6Jh84UGZIQ==
Message-ID: <94021cd67e259722e10ac7db2c987b6c.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241217-clk_bulk_ena_fix-v5-1-aafbbb245155@collabora.com>
References: <20241217-clk_bulk_ena_fix-v5-0-aafbbb245155@collabora.com> <20241217-clk_bulk_ena_fix-v5-1-aafbbb245155@collabora.com>
Subject: Re: [PATCH v5 1/3] soc: mediatek: pwrap: Switch to devm_clk_bulk_get_all_enabled()
From: Stephen Boyd <sboyd@kernel.org>
Cc: kernel@collabora.com, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org, linux-samsung-soc@vger.kernel.org
To: Alim Akhtar <alim.akhtar@samsung.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Bjorn Helgaas <bhelgaas@google.com>, Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, Jingoo Han <jingoohan1@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Krzysztof =?utf-8?q?Wilczy=C5=84ski?= <kw@linux.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, Russell King <linux@armlinux.org.uk>
Date: Mon, 23 Dec 2024 12:54:21 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Cristian Ciocaltea (2024-12-17 13:41:51)
> The helper devm_clk_bulk_get_all_enable() missed to return the number of
> clocks stored in the clk_bulk_data table referenced by the clks
> argument and, therefore, will be dropped.
>=20
> Use the newly introduced devm_clk_bulk_get_all_enabled() variant
> instead, which is consistent with devm_clk_bulk_get_all() in terms of
> the returned value:
>=20
>  > 0 if one or more clocks have been stored
>  =3D 0 if there are no clocks
>  < 0 if an error occurred
>=20
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---

Applied to clk-next

