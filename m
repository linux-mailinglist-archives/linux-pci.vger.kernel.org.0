Return-Path: <linux-pci+bounces-11826-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BB89571DF
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 19:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 250D31C23B14
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 17:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A53718A6B1;
	Mon, 19 Aug 2024 17:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOO+yzR7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04F018A6AD;
	Mon, 19 Aug 2024 17:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724087680; cv=none; b=o9rZWNzmPOZz9pX2FsEVSkTTENtzgU5kToza5IiZV9rXFN9CETEpFUttx0beeGRo1Gw1IppyXNo5/L80akFqUu4hRkjBpT0Pdk/ZgoJRLDmJ6e02EbCrG26jSGOBgwCUlVarsnAZrWDiz2SUOSNsrRoyXDwP2myHl/PS05n3Oq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724087680; c=relaxed/simple;
	bh=YYidCEjmEXUvYF7/etgGS8mYr8J9j/++nBJOBY7rXHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZjB3NAgxUfnwOSz6AS4DhiuMm7/9wSfQemlkP5KWU31fCpECDXPkcerE3uNfT7JSjPs/xx26OvVmsDRslBX5RFIq16rWnaN6EsxOtnOv8eSY/RpgzInkY0UAA93k7WIqd5672kTBg7dDpex2f6Q/o7UsCO66VUhP1psT0jLgLMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOO+yzR7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F41DC4AF10;
	Mon, 19 Aug 2024 17:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724087679;
	bh=YYidCEjmEXUvYF7/etgGS8mYr8J9j/++nBJOBY7rXHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BOO+yzR74SlOh86aW67MODsCOB47I4n/6F1O106pRAOTgjTUUYSWAHN8mkl5XggWg
	 XoKg22FyEesUAVrN2eBG1cyVOVwjHOJVKYTU3VzPR9AR7Wolzk/7+3MhiDExfWQvB3
	 +V6BDSNW0HO5vV++kaocRuKTJP2O7Uu2IpCn2CLz3OHB1l1FFfPa57Ezx2vTR2sKB2
	 R1BK9+1Iq4DDPRjgZlR8/sa7VSSEFrgOltJj4x0Dk76fhZUipOXvyJaFafnPGSuK7H
	 4/mcv0gskC8o6m4c2l7PjdwuAVd19DDMVxMg7xzmfcETRJ6/vKk+yXWpyj4Kwbnrh9
	 B7BnGuWTh0jOQ==
Date: Mon, 19 Aug 2024 11:14:37 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Xiaowei Song <songxiaowei@hisilicon.com>,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-renesas-soc@vger.kernel.org,
	Binghui Wang <wangbinghui@hisilicon.com>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH 2/3] dt-bindings: PCI: renesas,pci-rcar-gen2: add
 top-level constraints
Message-ID: <172408767657.1698317.12400518792693718628.robh@kernel.org>
References: <20240818172843.121787-1-krzysztof.kozlowski@linaro.org>
 <20240818172843.121787-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240818172843.121787-2-krzysztof.kozlowski@linaro.org>


On Sun, 18 Aug 2024 19:28:42 +0200, Krzysztof Kozlowski wrote:
> Properties with variable number of items per each device are expected to
> have widest constraints in top-level "properties:" block and further
> customized (narrowed) in "if:then:".  Add missing top-level constraints
> for clocks and clock-names.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml    | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


