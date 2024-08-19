Return-Path: <linux-pci+bounces-11827-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0659571E3
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 19:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B2C7282FEB
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 17:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA79B1891CF;
	Mon, 19 Aug 2024 17:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qa8/G0jq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B60817B4ED;
	Mon, 19 Aug 2024 17:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724087687; cv=none; b=tgFkn5SG0LtontDEBr2S9fknvUcaN5GIfA7qaCdup0pHizYH/46fSencoOboY/auzfiVga289syuAAfk697ihrDo1zfRI9Q70bum7SoXtXsT1a5bdYEvL6qgrdrU8sUTl+scB8+7dD2rStN58suZMfH40+1ku7ILvnoS6LwFaPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724087687; c=relaxed/simple;
	bh=SJa9wNA/DEXcDPJUqIOrI6KUrhWQ1+evwmrEEGfcIwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pwLAvenHnIDVir2MrZ+yjX/YcCf1EmGcW+xAk9Xw5tKZ8pmLPJdavdjdc3EJyZajcESEeQITpz/yJvOyf6PZ/jZuiRuWarseGMBoBeXbJWJehkSHtfW3l4XPX5b9+Mv7a6ql5fdCy7/sqVwDZropCy6EwDW0QQD8D5An5zSpxl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qa8/G0jq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F79C4AF0F;
	Mon, 19 Aug 2024 17:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724087687;
	bh=SJa9wNA/DEXcDPJUqIOrI6KUrhWQ1+evwmrEEGfcIwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qa8/G0jqFFqmmyfCasZrZoFluls7lx4M9/fOlifj6LAzb4DtCYP8VPjwTygC7mpiV
	 m+c/TuXNxLVKa31GpiZU2CEntrIsqMKrn6x4Kje3nS7e4kcezmQxa+4HCeSzrjkLer
	 HdRbOVriuMhjA18kVr6R+pr9x9RoXA0a8wS6BuPAO/bW+Z8gneSyd6w6/VEwc1RCZf
	 +gQ3l6WdgGRbMRdlExLBR5aKNZbbO5Y5EAfIQfWD8Ix3mMA3xrRhPkPjeeEk+bkVUm
	 fyLpPnSX3+gulEDvf/Ejqolm475HWbGBVIXMDQUJzIqDYeL4hBdgalyhFUYixja9Lz
	 1RbKOzVUUNv2A==
Date: Mon, 19 Aug 2024 11:14:45 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-renesas-soc@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Binghui Wang <wangbinghui@hisilicon.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-arm-kernel@lists.infradead.org,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Xiaowei Song <songxiaowei@hisilicon.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: PCI: socionext,uniphier-pcie-ep: add
 top-level constraints
Message-ID: <172408768452.1698595.1459135684597826789.robh@kernel.org>
References: <20240818172843.121787-1-krzysztof.kozlowski@linaro.org>
 <20240818172843.121787-3-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240818172843.121787-3-krzysztof.kozlowski@linaro.org>


On Sun, 18 Aug 2024 19:28:43 +0200, Krzysztof Kozlowski wrote:
> Properties with variable number of items per each device are expected to
> have widest constraints in top-level "properties:" block and further
> customized (narrowed) in "if:then:".  Add missing top-level constraints
> for clock-names and reset-names.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pci/socionext,uniphier-pcie-ep.yaml          | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


