Return-Path: <linux-pci+bounces-43171-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C217CC8514
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 15:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F26F43083FD3
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 14:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FED39379C;
	Wed, 17 Dec 2025 14:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="COj/Z3nK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CAA393797;
	Wed, 17 Dec 2025 14:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765980434; cv=none; b=DzMChH4IMZ7N3v/z4OR7E4Yrp8qg3PrDKT5gZvSLXqTcrEZkVfckE1ZrDs854bxOb4myz20agav8MEuVKq6btQIgTjmShfwj8LZlUgVQJvEKElnIimxEF6P6Adi8TfPx93AlcLe1ldr3ZcjQ3pX9A3Bjl9Oj4J21xCZOpKKS35k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765980434; c=relaxed/simple;
	bh=BBej7b2TZcIfv26VO07aVWI/nJSmjhBy+pY5L+9zcb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FvW7cOP4Lj16eITkAdUzFWZf/AFk8L5uV5c6wnpQbpICBhcETCwxZHc4tR44+2Jq1BG7q+3W0vd6R2xS3hjvcE6kvMZo3n3NEp9qNlQQ0LT3PxUAteaYvzZbTrc7d/MnTPoohu5jK1G/Kcd2GXxg2R5O8B7UDSsGH8dRszNn2kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=COj/Z3nK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7828C4CEF5;
	Wed, 17 Dec 2025 14:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765980434;
	bh=BBej7b2TZcIfv26VO07aVWI/nJSmjhBy+pY5L+9zcb8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=COj/Z3nKklzgE1lymvXRLZGmg/6UR6V78uX8ycnn0SpbWOJFD//Tg/lKvkrv+zzpt
	 KJmm3fOvLHd4j4ZFg+6/uGG4WACNgTs/vdylLOhGT5TANFGTJK2lPvQN4/Z1QG26CY
	 Jj2buSSzuYkRB41d1MQmoOV6hGIL2FdNUHCgu0Uoo0WNYpPU2XS3yp5nwVsioshvWP
	 cGUceKKnL2caC3UC1OAflD7JMCoqIWXwNe8O5eaiMPqs7HJ2EMcAhYjt8I+IFQtxQs
	 3HlkLx7Kss0Kh/B/ENnxkaAwJxYiJzpVokdyTv6qtVRgPJfTodJSPLHuxzcH2dOQwj
	 Rwr2agbdZ/hXQ==
Date: Wed, 17 Dec 2025 08:07:09 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Andrew Jeffery <andrew@aj.id.au>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	openbmc@lists.ozlabs.org, Vinod Koul <vkoul@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-gpio@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org,
	Linus Walleij <linus.walleij@linaro.org>, linux-pci@vger.kernel.org,
	Joel Stanley <joel@jms.id.au>, Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Subject: Re: [PATCH v7 2/7] dt-bindings: PCI: Add ASPEED PCIe RC support
Message-ID: <176598042865.925447.819427829703405501.robh@kernel.org>
References: <20251216-upstream_pcie_rc-v7-0-4aeb0f53c4ce@aspeedtech.com>
 <20251216-upstream_pcie_rc-v7-2-4aeb0f53c4ce@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216-upstream_pcie_rc-v7-2-4aeb0f53c4ce@aspeedtech.com>


On Tue, 16 Dec 2025 09:50:01 +0800, Jacky Chou wrote:
> ASPEED AST2600 provides one PCIe RC for Gen2 and AST2700 provides three
> PCIe RC for two Gen4 and one Gen2. All of these RCs have just one root
> port to connect to PCIe device. And also have Mem, I/O access, legacy
> interrupt and MSI.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>  .../bindings/pci/aspeed,ast2600-pcie.yaml          | 182 +++++++++++++++++++++
>  1 file changed, 182 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


