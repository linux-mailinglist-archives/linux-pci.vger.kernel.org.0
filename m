Return-Path: <linux-pci+bounces-17100-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A35409D307A
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 23:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D5481F2194C
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 22:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5921BD9F0;
	Tue, 19 Nov 2024 22:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNJzz5cS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DFE45945;
	Tue, 19 Nov 2024 22:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732055531; cv=none; b=fWvougPT51GLcLk6DDp/YDnyIjnaoVLWeJXolvqZjmltW40OH4KZzPT6XLJ+vsy+Swpy/g9fvTI23HzAZhNbpeRip03FajTLQKpMY0eCZ/wpDUnmIW2U9Y+XQ7gcY/zbL1xg/1BZYeRfPTRpJiXxgLh3uktSis0Ghqh8Onl4xEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732055531; c=relaxed/simple;
	bh=GOaB+mblNl249+MePTU1DE2MN9+1aEVwNpuvl7SsLWQ=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=onBepdSzqfP29BD8yLWdEFgMZ7CTCUjAzjlCH/fnl2W2vU/qvUISG735deDOYAl2ftZ+rAKzKLMCLwADrzJoZQ4uNM7ZgctBkG76jofC26SY+lOFVCvwNWAncIL0Vf+/9fzbNVb2pLdLqk/bUNx7GAi+Qp6R2l9/TU+dtwyL9YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tNJzz5cS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F92C4CECF;
	Tue, 19 Nov 2024 22:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732055531;
	bh=GOaB+mblNl249+MePTU1DE2MN9+1aEVwNpuvl7SsLWQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=tNJzz5cSc9U3/7Pl6b52akZ5MJrLaUc0TAcPYt+Tauiu3FHuog/wvq7keYws8WD5v
	 sC+L1gpt5TDaJYQqtUONPr1GSLhK+S7d8z8j3u/fUZCF16klistlTCs1maNHiaHbuT
	 jLP4Sv+8s7SISlv1MYlpxT594OfiPPUJRHMPnmEeMyr/ovPXorPvRngPYSJ6z1WJM2
	 Lsd4e76Ler0cQkH1ylJYu9Q6X/WFLOEDMexBBYVET2iRSZqdf/0p2Mr3G/xvnt36N7
	 44DjDAm/pym5C8eSJeG6Z6EcZk11NQJp6JEi5tyDKFRrZyT58kgBDNa3zJsZ2cpWVp
	 f+KAhm7pC0YUA==
Message-ID: <38e3593a9bd02fbdbc23b677eda57108.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241118-pcie-en7581-fixes-v4-5-24bb61703ad7@kernel.org>
References: <20241118-pcie-en7581-fixes-v4-0-24bb61703ad7@kernel.org> <20241118-pcie-en7581-fixes-v4-5-24bb61703ad7@kernel.org>
Subject: Re: [PATCH v4 5/6] PCI: mediatek-gen3: Add reset delay in mtk_pcie_en7581_power_up()
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Bjorn Helgaas <bhelgaas@google.com>, Jianjun Wang <jianjun.wang@mediatek.com>, Krzysztof =?utf-8?q?Wilczy=C5=84ski?= <kw@linux.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>
Date: Tue, 19 Nov 2024 14:32:09 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Lorenzo Bianconi (2024-11-18 00:04:57)
> Airoha EN7581 has a hw bug asserting/releasing PCIE_PE_RSTB signal
> causing occasional PCIe link down issues. In order to overcome the
> problem, PCIe block is reset using REG_PCI_CONTROL (0x88) and
> REG_RESET_CONTROL (0x834) registers available in the clock module
> running clk_bulk_prepare_enable in mtk_pcie_en7581_power_up().
> In order to make the code more readable, move the wait for the time
> needed to complete the PCIe reset from en7581_pci_enable() to
> mtk_pcie_en7581_power_up().
> Reduce reset timeout from 250ms to PCIE_T_PVPERL_MS (100ms).
>=20
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

