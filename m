Return-Path: <linux-pci+bounces-18985-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0F49FB5E8
	for <lists+linux-pci@lfdr.de>; Mon, 23 Dec 2024 21:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 225111886858
	for <lists+linux-pci@lfdr.de>; Mon, 23 Dec 2024 20:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73C11D5AD8;
	Mon, 23 Dec 2024 20:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NizACS31"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B17EAC5;
	Mon, 23 Dec 2024 20:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734987273; cv=none; b=sqvDOtYkMa8y5/M++cw3JhYuBSNq+8lpiAj74FJLVFLgkUaFSIvvJuxbbaslV4YGUwVrUcB9JhS9O64SZB65z/mfDl+APIaI2rGg/wzQi8/HouR1ZFBKUoQo3mzCELvasY1yBLdFdl4rDrXdRyjmD66TpTOMA7GMGZNTpX0XoP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734987273; c=relaxed/simple;
	bh=kbXC3RlLQvMbB0Kr3AmNpOGH3nzjNPCGMhfshggZNlA=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=K+rHAeCbDiQPr5T92m7POxwZhD45xLqgx0uZjNzW1nJFlCADgYzqwqdPTltXaQQ5gvD3TP9ItvYuQjNz60WW/ORNWH7QDDZ7OK9HhJl4w96kWoUP93+H533NLHMONon1dSreE1tUDH2j1jTX4KlvnsVqpDIzaLDi5v6eP80Fsz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NizACS31; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0033DC4CED3;
	Mon, 23 Dec 2024 20:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734987273;
	bh=kbXC3RlLQvMbB0Kr3AmNpOGH3nzjNPCGMhfshggZNlA=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=NizACS31YVDw4z71EsAy7Qx2p3j7UDgUZareoT0accQ9ootNCVf66zIWg6xmTqdcn
	 HVQT1rMSyeds1vXm++1I86ABfO6lNxM89jmblxXrQK2fg2YNMQun2Vv61hya3fxM1r
	 dYB/jgByHUj9yqHvQqFBvdtSdGklZVFByJngsjCpbR3h49bYmbJCdJzNBvyAt1lbMv
	 owe+Nxkv7p6OOnk/7BvgPreFTktqshMFuFRbK3QutBxqyVl9s8fQ2CvL9PX8ahJpvs
	 aStLZKWHeVMT3GnHQMqiiZpo9uVgcn5XZTK13euMvaU4q08t1EvpIZmLTej3loyHKo
	 BxY73q6M3yp4Q==
Message-ID: <e16974439c048232c366503d73c2c799.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241217-clk_bulk_ena_fix-v5-2-aafbbb245155@collabora.com>
References: <20241217-clk_bulk_ena_fix-v5-0-aafbbb245155@collabora.com> <20241217-clk_bulk_ena_fix-v5-2-aafbbb245155@collabora.com>
Subject: Re: [PATCH v5 2/3] PCI: exynos: Switch to devm_clk_bulk_get_all_enabled()
From: Stephen Boyd <sboyd@kernel.org>
Cc: kernel@collabora.com, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org, linux-samsung-soc@vger.kernel.org
To: Alim Akhtar <alim.akhtar@samsung.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Bjorn Helgaas <bhelgaas@google.com>, Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, Jingoo Han <jingoohan1@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Krzysztof =?utf-8?q?Wilczy=C5=84ski?= <kw@linux.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, Russell King <linux@armlinux.org.uk>
Date: Mon, 23 Dec 2024 12:54:30 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Cristian Ciocaltea (2024-12-17 13:41:52)
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
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---

Applied to clk-next

