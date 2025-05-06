Return-Path: <linux-pci+bounces-27279-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A430AAC2D7
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 13:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C92B3B1A15
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 11:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713CB2641FD;
	Tue,  6 May 2025 11:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="RIqOtHt9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5A74A02
	for <linux-pci@vger.kernel.org>; Tue,  6 May 2025 11:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746531485; cv=none; b=SC/KOum3Y+b2NKqEtnvLOQRGEI02tU+LNiA+pT2kINWW0vO4kVU1gnQzc3s6PB2BOE8Xl1j9A2PBK/kkrAlgUi6mVF2YbLNVE3SPIaePuDVIuRNRsUxs2eyHotXGp4PRDSnCangEYGFIOMnXcTGbNYyNo4U0RiL4fHmxMKOAxxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746531485; c=relaxed/simple;
	bh=8nb9Q9aHce0TgLMbIGMIWrkwQCMxktUy7JYaCexsKls=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y2gBgkvHc2Gv0/QjBEA9fSKLEARUiywFNo0oj8w3xGNdDgnU+sR7o4+ZOTq5qZoxzpGNRmQu6wx3yHipPJeRlpMcgaVHXlhw9HGkYx9VfS6T8w05j5tpkzs7fUzZqH0LewLbhRrND6YlaHC8nJ+ERmWF4EtmdCP1BWeAvn1DpLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=RIqOtHt9; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1746531466; x=1746790666;
	bh=8nb9Q9aHce0TgLMbIGMIWrkwQCMxktUy7JYaCexsKls=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=RIqOtHt9I3KnBDPsOIydRznVi6evNbzhhfim5sK04+wvbiHH4ifTJSwS/RU4SYNOr
	 PG8ZZVDBGrmVpiisN/4xKeSIvgWlpjaiYm2SvEMn/0hbASjr40QevBkPF318LUwBq+
	 RPhXhY5hza4auKTMNR8o6E3NDH02YZWTpBQc886tAGoLg55NHkMiz7AnLxpLG4RyO6
	 KfErYRTJnhbl9SXv/pDUCnMqm5ClU/+SnWGhvInefGc1RA8jDJvnmT9O3g+h/76lD7
	 riifWPeKa+IZJi185hfJfffgmDAsTyn6PYXxZxzFhOh/TbBxhpOsKV9Xyk3P+BUWDH
	 tnvolCZcRuEhQ==
Date: Tue, 06 May 2025 11:37:43 +0000
To: Niklas Cassel <cassel@kernel.org>
From: Laszlo Fiat <laszlo.fiat@proton.me>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Wilfred Mallawa <wilfred.mallawa@wdc.com>, Damien Le Moal <dlemoal@kernel.org>, Hans Zhang <18255117159@163.com>, linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 4/4] PCI: qcom: Replace PERST sleep time with proper macro
Message-ID: <O_21RG2up3FyQMAAzBNhGf8jSIyQC2MdXvT-dURBco4BCAGVZ2xv3GjZTadQ306OuOqF-2jzlCsFRED5uRH0JW_9F59L8qE5tgepErs5lC0=@proton.me>
In-Reply-To: <20250506073934.433176-10-cassel@kernel.org>
References: <20250506073934.433176-6-cassel@kernel.org> <20250506073934.433176-10-cassel@kernel.org>
Feedback-ID: 130963441:user:proton
X-Pm-Message-ID: 7b33a741e0c737365d3f7dcec39fd4394fdf766e
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On Tuesday, May 6th, 2025 at 9:40 AM, Niklas Cassel <cassel@kernel.org> wro=
te:

> Replace the PERST sleep time with the proper macro (PCIE_T_PVPERL_MS).
> No functional change.
>=20
> Signed-off-by: Niklas Cassel cassel@kernel.org
>=20
> ---
> drivers/pci/controller/dwc/pcie-qcom.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/control=
ler/dwc/pcie-qcom.c
> index 01a60d1f372a..fa689e29145f 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -289,7 +289,7 @@ static void qcom_ep_reset_assert(struct qcom_pcie *pc=
ie)
> static void qcom_ep_reset_deassert(struct qcom_pcie pcie)
> {
> / Ensure that PERST has been asserted for at least 100 ms */
> - msleep(100);
> + msleep(PCIE_T_PVPERL_MS);
> gpiod_set_value_cansleep(pcie->reset, 0);
>=20
> usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
> }
> --
> 2.49.0

Tested-by: Laszlo Fiat <laszlo.fiat@proton.me>

