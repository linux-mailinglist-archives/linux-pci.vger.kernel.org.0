Return-Path: <linux-pci+bounces-6054-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCBF89FEB4
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 19:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 148B1B22AF9
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 17:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C2417BB2B;
	Wed, 10 Apr 2024 17:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKuTdcBD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B95315B0E4;
	Wed, 10 Apr 2024 17:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712770516; cv=none; b=damVUClWM2V0pGe5i0jJlNr+sOSY6RHyw/5GWynD0SMIkqMdJ5QBYwLcIcUfbqBYhOmzHL8CyttUNZu63uCxwxhOq6XZdyeH1LNiw4pKgLlqpoPh4DqzDWLX+eVcJfmO9lgk1YJXW/lnIuXnwyBy7gfcxXlV10O9lnjAYmgcYP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712770516; c=relaxed/simple;
	bh=VQcH65WHqA/FS4uddL5zUJwX+BidAKnJYJdgb3MS8lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lq0dCbnWzPbrDRx+UW2FFdan1+gRxs+3/jjOs1hD94xp+NKoWzy/sU2Kfee01W5x0zjP8eoBMmK3/hSvBZvW5crn2x9IeD7nqJP8pAXL6ClrfV1rsLabRReRe66qoP8B1/QxZWG7/By6kKK0fF5I8RZdt+ZzBMfA1jyMKrbP2kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKuTdcBD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8678C433C7;
	Wed, 10 Apr 2024 17:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712770516;
	bh=VQcH65WHqA/FS4uddL5zUJwX+BidAKnJYJdgb3MS8lk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AKuTdcBDWerDwjKr3wEagpSw7BfaYoAXlOYEPY1HHrIQnQupK0az+5WFmhYNEKTUB
	 vQhp2T8kjdsj9V1lGZzOq+Jmv8XJn72N1Ac3f058geLGA7P1GNtjvHAQk9e1gqituj
	 BrDcAFeKc4sugwHyGJ9801R0GJKa5T7qdFRIqR7UIl6a98qbGS0q9kO4CNrkAL6/uf
	 MJuMEvyla07qZ+4Hq+hTO09S8LuKbG3A2Sl5HKiYXTnsS9XI9KCSdTvL+dqjU9BTZr
	 GUdwqTTXsSFkucF0Pa5wvW/43dtwxTA6XuGHYSf09CItKdCMRLF9eSTZ6ar6cXTH5d
	 otR8iI9lpsx4g==
Date: Wed, 10 Apr 2024 12:35:13 -0500
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Tom Joseph <tjoseph@cadence.com>,
	Magnus Damm <magnus.damm@gmail.com>, linux-arm-msm@vger.kernel.org,
	Ray Jui <rjui@broadcom.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-rpi-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mark Kettenis <kettenis@openbsd.org>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Michal Simek <michal.simek@amd.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Srikanth Thokala <srikanth.thokala@intel.com>,
	Sergio Paracuellos <sergio.paracuellos@gmail.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>, asahi@lists.linux.dev,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, Ryder Lee <ryder.lee@mediatek.com>,
	linux-rockchip@lists.infradead.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>,
	Scott Branden <sbranden@broadcom.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Hector Martin <marcan@marcan.st>,
	Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-kernel@vger.kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: PCI: cdns,cdns-pcie-host: drop
 redundant msi-parent and pci-bus.yaml
Message-ID: <171277051181.788021.12147595660219307279.robh@kernel.org>
References: <20240407102000.37213-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240407102000.37213-1-krzysztof.kozlowski@linaro.org>


On Sun, 07 Apr 2024 12:19:58 +0200, Krzysztof Kozlowski wrote:
> The binding reference common cdns-pcie-host.yaml, which already defines
> msi-parent and has a reference to pci-bus.yaml schema.  Drop redundant
> pieces here to make it a bit smaller.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml | 3 ---
>  1 file changed, 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>


