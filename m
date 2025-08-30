Return-Path: <linux-pci+bounces-35184-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7628FB3CB4B
	for <lists+linux-pci@lfdr.de>; Sat, 30 Aug 2025 15:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 366C7A070D5
	for <lists+linux-pci@lfdr.de>; Sat, 30 Aug 2025 13:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2219A225A24;
	Sat, 30 Aug 2025 13:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZRAhJmch"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB221DF97D;
	Sat, 30 Aug 2025 13:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756560826; cv=none; b=sY5Mji47hhxQtN6EOFRTb7GtTO2LsqInKlusjWamrJsp5d3YWzlu9jb7QGpGzvzrqFXnw603zDMcQjKwLYais6o9PEY11lgwR13cdL8dZCUP4BXJutnBdF/rCMXtUWyHBqL28nDfaNQL4A4f2iwRl2fsJpWUikdD9u4X7zFvoWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756560826; c=relaxed/simple;
	bh=YEwli1tnU1cx/I7//bc61Vi6hf4htLcmUudLpu8NhyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXnOWSk6EmF3EMTnhGMm3uxYvetF5zV7pnlCjxXtrdsQWEwicHH6PhK5mXq/vquEb5nMmg0G7tvCfNTzENYXnLpPt0oIItIKWlNIGrBXbFTTrMm7GxADJZQitLtwuZWNFLbS1O3gsjQmp9DK69K760oA59oWBn4E/9YhIKOjqyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZRAhJmch; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 179BFC4CEEB;
	Sat, 30 Aug 2025 13:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756560825;
	bh=YEwli1tnU1cx/I7//bc61Vi6hf4htLcmUudLpu8NhyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZRAhJmchL00rgGoBhtZj0kZ3aNtQ/stgMlZKyXJ3c6iTlf2MmGPMq+n1whuadKznQ
	 +lrsUqiEqgd1BrwEwyjB3T8867WanSfXpc9O0heg7QRiAcY98c5Ip2R9prLrMfxObp
	 2G495vghbbO/h9BdlhNeO5SqCSZOoZDCsveEPzWHq6RdURC0tBrN0uuQjHy0Qj2DRd
	 vTZ1lK4e+mSg398OKRxBeJL8gQobWdT8AFgjNGu5HOkqWrLidQgXNLPMkZs2zaLcso
	 9/HWktgk9YAgAC7wbrdBp96J9wX9iis6AYHka9Q384oIiY0STEfQE943S29DVUJ9W5
	 gMWsKArltwZPg==
Date: Sat, 30 Aug 2025 19:03:37 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: hans.zhang@cixtech.com
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	robh@kernel.org, kwilczynski@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	mpillai@cadence.com, fugang.duan@cixtech.com, guoyin.chen@cixtech.com, 
	peter.chen@cixtech.com, cix-kernel-upstream@cixtech.com, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 15/15] arm64: dts: cix: Enable PCIe on the Orion O6
 board
Message-ID: <2gc5kikpaljgfkh3zeikvbtgttdbaejrhn7gjc35q4ih67eeje@o7bjvmt3o26n>
References: <20250819115239.4170604-1-hans.zhang@cixtech.com>
 <20250819115239.4170604-16-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250819115239.4170604-16-hans.zhang@cixtech.com>

On Tue, Aug 19, 2025 at 07:52:39PM GMT, hans.zhang@cixtech.com wrote:
> From: Hans Zhang <hans.zhang@cixtech.com>
> 
> Add PCIe RC support on Orion O6 board.
> 

So with this patch (and dependencies), the endpoints are detected and usable?
Any limitation with not supporting the GPIO and pinctrl should be documented in
the description.

- Mani

> Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
> ---
> Dear Krzysztof,
> 
> Due to the fact that the GPIO, PINCTRL and other modules of our platform are
> not yet ready for upstream. Attributes that PCIe depends on, such as reset-gpios
> and pinctrl*, have not been added for the time being. It will be added gradually
> in the future.
> 
> The following are Arnd's previous comments. We can go to upsteam separately.
> https://lore.kernel.org/all/422deb4d-db29-48c1-b0c9-7915951df500@app.fastmail.com/
> ---
>  arch/arm64/boot/dts/cix/sky1-orion-o6.dts | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/cix/sky1-orion-o6.dts b/arch/arm64/boot/dts/cix/sky1-orion-o6.dts
> index d74964d53c3b..be3ec4f5d11e 100644
> --- a/arch/arm64/boot/dts/cix/sky1-orion-o6.dts
> +++ b/arch/arm64/boot/dts/cix/sky1-orion-o6.dts
> @@ -34,6 +34,26 @@ linux,cma {
>  
>  };
>  
> +&pcie_x8_rc {
> +	status = "okay";
> +};
> +
> +&pcie_x4_rc {
> +	status = "okay";
> +};
> +
> +&pcie_x2_rc {
> +	status = "okay";
> +};
> +
> +&pcie_x1_0_rc {
> +	status = "okay";
> +};
> +
> +&pcie_x1_1_rc {
> +	status = "okay";
> +};
> +
>  &uart2 {
>  	status = "okay";
>  };
> -- 
> 2.49.0
> 

-- 
மணிவண்ணன் சதாசிவம்

