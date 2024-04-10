Return-Path: <linux-pci+bounces-6058-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 958ED89FF16
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 19:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47AA1287586
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 17:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E73181BB1;
	Wed, 10 Apr 2024 17:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFHVDTDP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C87A181BA2;
	Wed, 10 Apr 2024 17:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712771301; cv=none; b=fZS7UxmGSqkzie8PYdLsD69C+bChrOxUTPEY53YMu7mVk+82/+0bu0Y0mFLUsDI7abUwMZ+OiRK1b5JtOEVzB6LTlUlcwvnO7ygUSEmtpkQoGsjsDNProPIuqIkV+UP+2On/Ic6Oxrx8qjuub9C+kO8jeGZhIWL/mhjvH3nGfJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712771301; c=relaxed/simple;
	bh=yraIdNTO6tiXi9E0FDT+Fjq60vBK1HqRdRv+vDkxg+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRaMfyX0EYEz32vx34aKXWfoLV6LQUxmfrvnD9mkp7MOqztTs5xY4UCEkvJKQWa6l1O9l+5CRSLEiexTBySU1tdEE92RDoQgW4bxv0on/vQO1oS3ccl2iDsp348Rkut30XfaxMoampURQZg4v6y7g1HVb81GL7TwLaQaqnOsBhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFHVDTDP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB69C433F1;
	Wed, 10 Apr 2024 17:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712771300;
	bh=yraIdNTO6tiXi9E0FDT+Fjq60vBK1HqRdRv+vDkxg+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tFHVDTDPKZMb2q84GZ0sXW0RYG6KlHuL45NUV8ZtdnLdl60bN/oumeIIDWSt/mGbg
	 X16w4k7tV2pXwykGVn+4VE+FruftDxrHN9RWNiTD5vSt17nxaQZwoQ1Iwqmekb1C0U
	 KWhbio/pToZy8jpKK3TkO8MlICuFCMy6C3gpwjoQLqY7CS5lkNkMvI+zLiPu5KtsMb
	 R3l7jO48UHgkJydDoiEDiIpYVSQgaLrVrMvolcmuAUo0nYmLLcqBPHf8RIr19KFMpo
	 l9EdQP9Cj/q6NZB+bTOPxIhmHEZjemysvEJWH57UOd2hvi7krT4l+OVmC4Dt1sO4WV
	 PBb3iYh55we8g==
Date: Wed, 10 Apr 2024 12:48:18 -0500
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Mark Kettenis <kettenis@openbsd.org>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Scott Branden <sbranden@broadcom.com>,
	linux-mediatek@lists.infradead.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Sven Peter <sven@svenpeter.dev>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Ryder Lee <ryder.lee@mediatek.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Srikanth Thokala <srikanth.thokala@intel.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, devicetree@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Tom Joseph <tjoseph@cadence.com>, Will Deacon <will@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	linux-arm-msm@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Michal Simek <michal.simek@amd.com>,
	Sergio Paracuellos <sergio.paracuellos@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Ray Jui <rjui@broadcom.com>,
	Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>,
	Hector Martin <marcan@marcan.st>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>, asahi@lists.linux.dev
Subject: Re: [PATCH 2/3] dt-bindings: PCI: mediatek,mt7621: add missing child
 node reg
Message-ID: <171277129685.801730.14400180887790805749.robh@kernel.org>
References: <20240407102000.37213-1-krzysztof.kozlowski@linaro.org>
 <20240407102000.37213-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240407102000.37213-2-krzysztof.kozlowski@linaro.org>


On Sun, 07 Apr 2024 12:19:59 +0200, Krzysztof Kozlowski wrote:
> MT7621 PCI host bridge has children which apparently are also PCI host
> bridges, at least that's what the binding suggest.  The children have
> "reg" property, but do not explicitly define it.  Instead they rely on
> pci-bus.yaml schema, but that one has "reg" without any constraints.
> 
> Define the "reg" for the children, so the binding will be more specific
> and later will allow dropping reference to deprecated pci-bus.yaml
> schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/pci/mediatek,mt7621-pcie.yaml          | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>


