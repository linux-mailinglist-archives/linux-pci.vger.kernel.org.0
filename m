Return-Path: <linux-pci+bounces-11825-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE679571D4
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 19:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 264F81F2341E
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 17:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962DC186E2A;
	Mon, 19 Aug 2024 17:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7Z0ZRbz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659E017557E;
	Mon, 19 Aug 2024 17:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724087668; cv=none; b=qxr6GNlycM77+oSB7oOlrYpfe5Eg1gYtCEV3rMSpoo/b6IE0qmf7W/3QlrezrfUbSCI2FNNrPvLDTMYe1Rnykz3/jz68cQaC9dAbZ3r8dG0qkDLmbfDfve8UDEXXUL7bx5paHP+HVLFpvhlIVEsP6aQczbZongSdhrHh5I1pDVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724087668; c=relaxed/simple;
	bh=mD/SdKNsLUbdcSxKkBTS5ae0WOBd6vrjL4PLzT0tdsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZjreY29iZobyiK9hQ45M8vtof7myyvt1iPM2xPk1dvQD+f3UV8r1lUtTiasRTTxa0VaLhLFmOX13Rp1PhVDAIdi/bGrtaK2uhhkpRaqhyOfeua/eWfSMb1n/Wg4Sr3AcMPXmAn1RAJdEsVABh2wIN2ceURI1U+mOwg7qP5/FVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7Z0ZRbz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741AFC32782;
	Mon, 19 Aug 2024 17:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724087667;
	bh=mD/SdKNsLUbdcSxKkBTS5ae0WOBd6vrjL4PLzT0tdsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j7Z0ZRbzhIOsqL3+7KAfa8USBTqfWY43bneX1MgnASqug4pumazw2MDS1FkB1Z8fi
	 aHHRI+6K8yTZVJ+c16CBWr72BI8MBjLViWUIQ/ygwjCHWbEyQqGjmhv0Q3SAiP/zRQ
	 l/oAPm8M6XCQ3IkD4SWS9MQLA6w+XYn1B8KjPXgLqgFETKIF532T6IjIbPFfBQu7rD
	 2EC+iW8j4h34i82b76uz2MG1rMYA0N2vIhhWvWUmQfftl783t7r9Xt44fQV3rIS5Zy
	 XOPxlWORkot9fOamRNcE9dyevKxg0PrqmSdGNQSMiMdq9aLe5zptNB/R5/j1GhxMeo
	 sGKJYmpt95BJA==
Date: Mon, 19 Aug 2024 11:14:25 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, devicetree@vger.kernel.org,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Xiaowei Song <songxiaowei@hisilicon.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-renesas-soc@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-pci@vger.kernel.org,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Binghui Wang <wangbinghui@hisilicon.com>,
	linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: PCI: hisilicon,kirin-pcie: add
 top-level constraints
Message-ID: <172408766523.1697951.12061420500966371659.robh@kernel.org>
References: <20240818172843.121787-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240818172843.121787-1-krzysztof.kozlowski@linaro.org>


On Sun, 18 Aug 2024 19:28:41 +0200, Krzysztof Kozlowski wrote:
> Properties with variable number of items per each device are expected to
> have widest constraints in top-level "properties:" block and further
> customized (narrowed) in "if:then:".  Add missing top-level constraints
> for clock-names and reset-names.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/pci/hisilicon,kirin-pcie.yaml          | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


