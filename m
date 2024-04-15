Return-Path: <linux-pci+bounces-6245-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE448A4CAF
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 12:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3596F1F2273A
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 10:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA885D47F;
	Mon, 15 Apr 2024 10:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="T2gNX3w6"
X-Original-To: linux-pci@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B81D5CDF2;
	Mon, 15 Apr 2024 10:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713177745; cv=none; b=pmuPgIDwxt5LZoAoyWFv/oj/V9nnLbpkZu0k67ViPNm0KBTrgQGWqbJ7mGbHUHmIhy64Ixju9x9XLjU6P27JaQ29BI7X9iZFYuHeHRdQ70tgdqBcCOzTfqvcMSz7b7OCA7s1MbZOmAUshT865rDzRW/aF/VcUUdLout3VriS8jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713177745; c=relaxed/simple;
	bh=2LE6BYHGaIkUEPfoSEEycHjkQxb7ScTXGb+1RjmYa40=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bqNto/6QRBE2DViegmRexk6nX1WOhhniALwrbwh/dM5re/qzDL02ve8Px5ReMflnJ4E4iExJ6mSCzoWLdNvQvz2/L7MMbDQIbntWRt+bRcpbtMeqxs06S6oSKF73jS3405kqRAF4eSBDT1gAwTafhw2+cRb3Xtl6m1PBge7LzFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=T2gNX3w6; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713177742;
	bh=2LE6BYHGaIkUEPfoSEEycHjkQxb7ScTXGb+1RjmYa40=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=T2gNX3w6MCKpptHBDjWUa0QuL/mlCEZSlhCMsoGDBrxpKIvs4dHlqUnieB9UCpW29
	 2PFQjmzexQqeqQZrqbnkudvAHehcY2FUeZdfBG4Vf7SyHFr8gBFQIoPaPpX2JgIUaI
	 fbz7W4mutYJjKLayzskqfUkboqxrPq9cyFJUi31kqBp8AXncDR43OC4L+Hcrrler5w
	 X9SgHm/WQ3bPyCE7mn19NgCIZiLAv1HUKzD4k8CwX8gujpSd8XJlRJOzQznsCjHGsB
	 j/tysx8yw7KUuChgUEp5FARuoWlDit9S8ZQdm3htwcOPa6WbEIMOk0eR1LFbqOGBM4
	 lFjD+q3xy5wkw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0E156378042B;
	Mon, 15 Apr 2024 10:42:18 +0000 (UTC)
Message-ID: <4f1142a5-e231-401b-9b84-cc44d3800a7d@collabora.com>
Date: Mon, 15 Apr 2024 12:42:18 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] dt-bindings: PCI: mediatek,mt7621: add missing
 child node reg
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>,
 Sven Peter <sven@svenpeter.dev>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Jim Quinlan <jim2101024@gmail.com>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>, Will Deacon <will@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Srikanth Thokala <srikanth.thokala@intel.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Jianjun Wang
 <jianjun.wang@mediatek.com>,
 Sergio Paracuellos <sergio.paracuellos@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Daire McNamara <daire.mcnamara@microchip.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Marek Vasut <marek.vasut+renesas@gmail.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Shawn Lin <shawn.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 Jingoo Han <jingoohan1@gmail.com>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>, Tom Joseph <tjoseph@cadence.com>,
 Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org
References: <20240413151617.35630-1-krzysztof.kozlowski@linaro.org>
 <20240413151617.35630-2-krzysztof.kozlowski@linaro.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240413151617.35630-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 13/04/24 17:16, Krzysztof Kozlowski ha scritto:
> MT7621 PCI host bridge has children which are PCI root ports.  The
> children have "reg" property, but do not explicitly define it.  Instead
> they rely on pci-bus.yaml schema, but that one has "reg" without any
> constraints.
> 
> Define the "reg" for the children, so the binding will be more specific
> and later will allow dropping reference to deprecated pci-bus.yaml
> schema.
> 
> Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



