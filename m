Return-Path: <linux-pci+bounces-25639-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD0BA84E8A
	for <lists+linux-pci@lfdr.de>; Thu, 10 Apr 2025 22:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB82C7B47D5
	for <lists+linux-pci@lfdr.de>; Thu, 10 Apr 2025 20:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17CE29614A;
	Thu, 10 Apr 2025 20:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1YIhwyE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDC3296143;
	Thu, 10 Apr 2025 20:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744318127; cv=none; b=YwONNWlegZ1fpPaFEh8ouB8NvmwQ22WGXyHYS+Ie78A7QYVk+5xEXvRVkSMmxNpr11140N7GKetkwOxaC5rWUp686tI6Fv++UXwbxLjtrvb/DszQ70jsoQ7SkVPDQDmWtpoNKUZJmHgIcnElnHRUxG8Ny5B1ckcHHzL2mNvQJkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744318127; c=relaxed/simple;
	bh=eG+6Ol7t6Jj0rmtAVTf0NWu+4c3ZvYZT4LmvW2k3t+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rh4lQk75nxNhnUrzesta1nZ7z8zN35pCsMdza7chQ+3nmc0H/6uAGly26YRR53zDOTBM8cqco7FrrK964RWYmLamR9vU0x7vvqlbSi3SHhO1Atm7K26OMvfoYb8F2ELfBnY9sjOMFPzU1CpRqTzLIi3BAU+6YipYIYxek4VoZoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1YIhwyE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9BB1C4CEE7;
	Thu, 10 Apr 2025 20:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744318127;
	bh=eG+6Ol7t6Jj0rmtAVTf0NWu+4c3ZvYZT4LmvW2k3t+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k1YIhwyEzq71tlj7GHnadKh+rEg9ITWeOv8zeoZNsiU0nGaIob+u0Q2Jo8BE+TjkB
	 prQ5Vdlv/gsCfYVrzjIZP8RQVzpASF8CQ/ONtjT2JY9yxLAfjvffjMj3TMhQNY2JzB
	 nICPWXrNe+4kUK5Me79C/rcdmdF84K2CI4jTs336XzThQ/Qp/iVINPo3Kaiq21jQRR
	 DlPRbD7Fh7mH0tzYrFss6IbV2hj32w3w4rX2qLIOz477Fbq02KuVpElNwX59tWQiPB
	 QPPAje5HiyT3iyTPJvD4IndiDkQluWy6djxG2sQHEhHIOZv4K4Rh+uaMrKmB/TTS6I
	 B74GPRvtmKlRw==
Date: Thu, 10 Apr 2025 15:48:45 -0500
From: Rob Herring <robh@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-arm-kernel@lists.infradead.org,
	Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Aradhya Bhatia <a-bhatia1@ti.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Heiko Stuebner <heiko@sntech.de>, Junhao Xie <bigfoot@classfun.cn>,
	Kever Yang <kever.yang@rock-chips.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: PCI: rcar-gen4-pci-host: Document
 optional aux clock
Message-ID: <20250410204845.GA1027003-robh@kernel.org>
References: <20250406144822.21784-1-marek.vasut+renesas@mailbox.org>
 <20250406144822.21784-2-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250406144822.21784-2-marek.vasut+renesas@mailbox.org>

On Sun, Apr 06, 2025 at 04:45:21PM +0200, Marek Vasut wrote:
> Document 'aux' clock which are used to supply the PCIe bus. This
> is useful in case of a hardware setup, where the PCIe controller
> input clock and the PCIe bus clock are supplied from the same
> clock synthesiser, but from different differential clock outputs:
> 
>  ____________                    _____________
> | R-Car PCIe |                  | PCIe device |
> |            |                  |             |
> |    PCIe RX<|==================|>PCIe TX     |
> |    PCIe TX<|==================|>PCIe RX     |
> |            |                  |             |
> |   PCIe CLK<|======..  ..======|>PCIe CLK    |
> '------------'      ||  ||      '-------------'
>                     ||  ||
>  ____________       ||  ||
> |  9FGV0441  |      ||  ||
> |            |      ||  ||
> |   CLK DIF0<|======''  ||
> |   CLK DIF1<|==========''
> |   CLK DIF2<|
> |   CLK DIF3<|
> '------------'
> 
> The clock are named 'aux' because those are one of the clock listed in
> Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml which
> fit closest to the PCIe bus clock. According to that binding document,
> the 'aux' clock describe clock which supply the PMC domain, which is
> likely PCIe Mezzanine Card domain.

Pretty sure that PMC is "power management controller" given it talks 
about low power states.


> 
> Tested-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> NOTE: Shall we patch Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
>       instead and add 'bus' clock outright ?

Based on the diagram, this has nothing to do with the specific 
controller. It should also probably a root port property, not host 
bridge.

Rob

