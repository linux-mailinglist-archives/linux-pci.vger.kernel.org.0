Return-Path: <linux-pci+bounces-17025-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B212C9D09D0
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 07:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 782ED281DA8
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 06:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8791494A8;
	Mon, 18 Nov 2024 06:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NVfbl4UV"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20E514901B;
	Mon, 18 Nov 2024 06:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731912576; cv=none; b=EkellLvqnJHr1Svlfgmv/vRcRcBzXlwmcdHuijqtzFbRm3coxbqqftAkMWVRI7JmP5hHKcvi/NKuyiXZ6p/iH6QtFCbKzyrWKxBCU3JATyb1elfmMf193bOXCLFwgpA7OFcRTeJ1g6Y3yNbbpod/66AdiJ86NzG/RHGU6XaPJwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731912576; c=relaxed/simple;
	bh=Ul40GVnC8fMJpggrKRkggKnbsiidAZ2bzmqtOkj/wi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gBUX57qRHDnRpw0XSrelPdqgaWbeZ2mA0uLdkzhS0q/a26bRN4rUodAW+iakCh2QQ+qr4vKMDLLAMxWRIFBuOmTs/EOfOsH1Vi9qhJQcsHVTIt1PXOoRvdEBErdH8l1I9U2OgbQQt2yzrY1yT22AiUek8MaAwsO7uqcV2ysaTOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NVfbl4UV; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1731912573;
	bh=Ul40GVnC8fMJpggrKRkggKnbsiidAZ2bzmqtOkj/wi0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NVfbl4UVQ3/et0vosbqYCNoRN3n/enogc/hoLE4mIwendojGxO2hiFltimkfbwk+e
	 poQWMli3exiTD7AWAlJewRlmAulSRxD5K4N6BVdkg93Mr+T8jI2A8hqXdKvnAPYwhO
	 o2gfdcJlyxmU3hs0qXU0GIBojctHEqYbVOeyjTxk0cxCsvzqRPl8BhSHwBOWzFF2RI
	 7VzQ+CKtuHcKyeTUNQ2Ox5rUo3B89SnGvsY04rjHuu7vkgOJlt5VbIduct+wcNaH3S
	 K9FzpwrqlovaLEWBcESe/bUqoXhH+jgiE95KYskG4LJy6zD8sb0aBEP06i6xp7FNyv
	 sYr0eVj1TToHw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C2F8C17E1232;
	Mon, 18 Nov 2024 07:49:32 +0100 (CET)
Message-ID: <b0cdf6aa-18ca-4645-b0e0-44c7581018b4@collabora.com>
Date: Mon, 18 Nov 2024 07:49:32 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] PCI: mediatek-gen3: rely on msleep() in
 mtk_pcie_en7581_power_up()
To: Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee
 <ryder.lee@mediatek.com>, Jianjun Wang <jianjun.wang@mediatek.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
References: <20241116-pcie-en7581-fixes-v3-0-f7add3afc27e@kernel.org>
 <20241116-pcie-en7581-fixes-v3-6-f7add3afc27e@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241116-pcie-en7581-fixes-v3-6-f7add3afc27e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/11/24 09:18, Lorenzo Bianconi ha scritto:
> Since mtk_pcie_en7581_power_up() runs in non-atomic context, rely on
> msleep() routine instead of mdelay().
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


