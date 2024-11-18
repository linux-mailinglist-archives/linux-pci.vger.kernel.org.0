Return-Path: <linux-pci+bounces-17024-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3723D9D09C8
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 07:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1C2E1F21C41
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 06:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C14014901B;
	Mon, 18 Nov 2024 06:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="oV1KzgsK"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFB313E02A;
	Mon, 18 Nov 2024 06:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731912550; cv=none; b=X6PNiBzSUYgqphICyDEQvvghIgStrGd36/jpMp2LgHdmAkg2Yh4mqsc6z+NrzQpEV8ZyXmP93dPUGvWGUzS9hKGS6Qiab3jQH/33GfBMzJDXn4dTDS33fObU9+0H+rKoSHKpdKFqnjAFpWedSL5oIxXZcN/8WYbosPcAs7wVu2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731912550; c=relaxed/simple;
	bh=zAyH4l+W0XzT3+JqlBBg5UyJnzilg1n4gn9fyjQmO1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=en8HchKaeT0JxE/XTNGdF5FNh3Xaw2dLyvoWFULbdCSz8B6IlyvJT+9UXHeLyfOVkp1g28SxMf5Vr7XLqTHkankC7TyWeCsV8aLCWoqEdSJlkGU23oW8lrZrG9aEdQD+03XQo+c+92wVpRD3F+DiVFRF2HFuavffT6Tqk+3nxa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=oV1KzgsK; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1731912547;
	bh=zAyH4l+W0XzT3+JqlBBg5UyJnzilg1n4gn9fyjQmO1w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oV1KzgsKIo6AaQqvLsV3ismvKgoR0s72ZCDc4W2O7S/fxkX6b12mY6f6pfGZKehJH
	 xwhYkz1BmOf1kB2MS0epf7TF2WpJx8un5VfAsY1FWmwc9WSimiugI3PZ7Ph4ImVMXO
	 bRwUzUNdsIb0Ibn8BJ04gJVqJkUTCHMxHY84MT1pWAWJv6+fi7n0SVG+bPYnlCZsYV
	 5wZ/GNubAcTjrGVOx3HKl8gi0A0AEFxQ3Wr9cunUQcSCz56MDOPB8kyS95sMSeDwqg
	 Hq8dPp0yIFe/CcfgOcUdfiF4r63m7i9KINSJ3vjLizAEP7H2mvI8KHvX1yGm8Fc24X
	 yoDTP2okjTkgQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B0AC117E1250;
	Mon, 18 Nov 2024 07:49:06 +0100 (CET)
Message-ID: <f7d69dca-1af6-43f0-b764-38be32aaecd7@collabora.com>
Date: Mon, 18 Nov 2024 07:49:06 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] PCI: mediatek-gen3: Add missing
 reset_control_deassert() for mac_rst in mtk_pcie_en7581_power_up()
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
 <20241116-pcie-en7581-fixes-v3-1-f7add3afc27e@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241116-pcie-en7581-fixes-v3-1-f7add3afc27e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/11/24 09:18, Lorenzo Bianconi ha scritto:
> Even if this is not a real issue since Airoha EN7581 SoC does not require
> the mac reset line, add missing reset_control_deassert() for mac reset
> line in mtk_pcie_en7581_power_up() callback.
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



