Return-Path: <linux-pci+bounces-24606-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3869A6E8A6
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 04:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 431CE1896535
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 03:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931DF19D88F;
	Tue, 25 Mar 2025 03:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EtR8HaKI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64ED41FDD;
	Tue, 25 Mar 2025 03:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742872679; cv=none; b=tn+J22tciK/rf+YXNVwGFSZqlhf+mvewRrp0mffAZImdRFpl+HPxt5lcs3shlVj2lrFhfhy/6B9arXy2MxG2nPvtjNT/7mLlv0MzjbuYB+BqkEyPeuvBZ7qwfsJ8VRUh8sVXbUJJknZbNimxNTse4iTbpGqKk0CuMzi4fpPcGsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742872679; c=relaxed/simple;
	bh=WcCXntLzQZit3QH6kE07eF3DJST8a8sxgtc9AKLM/C4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCPHtwYz7UgjU0fBV6bMk8P66raqrGeCLynWCzqgMO0DxhUA/o+J5eS9Oz01sn5+bAsdkvobsvxSRGr9yQTRGpSBY6KRgb/7M0OcYDoMGjk/F18q3hPUUwwZjImJ4boVoQPy6QiaGqnUJcpknw2zOZMi1hONLZ4oWK9ULZnW7T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EtR8HaKI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3E1BC4CEDD;
	Tue, 25 Mar 2025 03:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742872678;
	bh=WcCXntLzQZit3QH6kE07eF3DJST8a8sxgtc9AKLM/C4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EtR8HaKIzsyqurMH3hl+zowqyTXnZbefgn8nTrqgS6D0JLDXQZJCBx/Bmp5Up9CY1
	 gnw7310T3/E81oCGVOl3M/0h0GT1t0oXtBWhpPdDErgzlmpZeT97ZPwkzPJGPCBVcF
	 yWcry+K4QCr0QrAridbY4k5lNwXkQRUdV1AWce0aAakiTFoZ1DSG/yGqkYCjlkc3KK
	 bH41B4uKAHyFihg0FHXCL/Gj2iHRlhglv3qNRplI4dXwns6PpmRRW2b8Kx2K/7NeFg
	 y0ei9AwlZcdHapHGTMiifYhxh3nzcoJzzVw/6/HBE5LbQYcd7KQQIO9nF/4OVRDC5O
	 C60gLEjrmlbig==
Date: Mon, 24 Mar 2025 22:17:57 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Michal Simek <michal.simek@amd.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-kernel@vger.kernel.org,
	Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-pci@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Jim Quinlan <jim2101024@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-rpi-kernel@lists.infradead.org,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Srikanth Thokala <srikanth.thokala@intel.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Greentime Hu <greentime.hu@sifive.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
	Tom Joseph <tjoseph@cadence.com>
Subject: Re: [PATCH 2/2] dt-bindings: PCI: sifive,fu740-pcie: Fix include
 placement in DTS example
Message-ID: <174287267578.1624713.1754304673947660629.robh@kernel.org>
References: <20250324125202.81986-1-krzysztof.kozlowski@linaro.org>
 <20250324125202.81986-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324125202.81986-2-krzysztof.kozlowski@linaro.org>


On Mon, 24 Mar 2025 13:52:02 +0100, Krzysztof Kozlowski wrote:
> Coding style and common logic dictates that headers should not be
> included in device nodes.  No functional impact.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


