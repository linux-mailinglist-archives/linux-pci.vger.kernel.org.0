Return-Path: <linux-pci+bounces-35635-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF82B4843F
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 08:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A21037AA3E4
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 06:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B295220687;
	Mon,  8 Sep 2025 06:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qX7shtGQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CBC1B87F2;
	Mon,  8 Sep 2025 06:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757313415; cv=none; b=RiazS+RnVzaqhMuTvk9GsOPJtw7zmgZFTQnYxVfmmCP3sNibMFvomKoPkD7wF9VlvTzKOUcte7fXUWNfAtFcUw69esvQ4dDOpaHFt2VyCkpbj/iSnQafHaFJN80+j54ytNlNdDdQOiQTmXTkD+LAW/RR3zsPDFyTCZYHLjFyNYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757313415; c=relaxed/simple;
	bh=B92/3nbAP6Xjj2WSr9Ku4Ubne2/jL9fXSx4SqSpGssY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8LAPFhKtSWfKJmAdhrWqlom5lHCHPznKQUFmOj7bIb91dVnvH8L0ll/gvEHbc4VwliZZTLRx852itcrATPkeSI1cHKBQWNDyfKLbCX1MYXO252Q+ao9aweIdtMgAe6srcEEdPowSonxH6USox6oUotzc862/sN00eJ2u/TrFwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qX7shtGQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A80C4C4CEF5;
	Mon,  8 Sep 2025 06:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757313413;
	bh=B92/3nbAP6Xjj2WSr9Ku4Ubne2/jL9fXSx4SqSpGssY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qX7shtGQqURrRV42pT1YpqfnLimLKH5dIliGOAGpY3Pt0a44HUcL09J25uyxB0koA
	 /bOr1jrmuZ6vSOGZNtFJ+tqSEe1nde8tTzKx+uJjxt3GYqokcGRDQJSLUE+nJKKku5
	 GAWVHbmmfAIKL6qgdSrnNAMKUXjFTetXEEF9a5shBTXQr1XCV5Gig8VloudjU5L3zG
	 4sMOVsbPCO7LY5kvHf3hww6oi4xeBOGzXKt3ahT2hAzwZQoYdvmt/L4KdIcrLX1RnS
	 zr4r6IiPNG3cnk37WNnWnHxwB1iljfg0IoHcQfFj3LzSZVk/AyhqMKbeBy20fdywsN
	 PCidqhX2uQvUQ==
Date: Mon, 8 Sep 2025 12:06:46 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, 
	"open list:PCIE DRIVER FOR HISILICON STB" <linux-pci@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 0/2] HiSilicon STB PCIe host use bulk API for clock
Message-ID: <mcfkxjbyee4y6fh6akypyubovb45xusvkamh5cltc4j6e7cdrm@gekavh6ybr6c>
References: <20250826114245.112472-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250826114245.112472-1-linux.amoon@gmail.com>

On Tue, Aug 26, 2025 at 05:12:39PM GMT, Anand Moon wrote:
> Simplify the code using the clk_bulk*() and reset_control_bulk() APIs
> 

We need either an Ack from Shawn or the Tested-by tag from anyone having access
to the HiSTB boards.

Also, as others explained, you need to mention the potential order reversing
while switching to these APIs as they may break the driver.

- Mani

> Thanks
> -Anand
> 
> Anand Moon (2):
>   PCI: dwc: histb: Simplify clock handling by using clk_bulk*()
>     functions
>   PCI: dwc: histb: Simplify reset control handling by using
>     reset_control_bulk*() function
> 
>  drivers/pci/controller/dwc/pcie-histb.c | 119 +++++++-----------------
>  1 file changed, 35 insertions(+), 84 deletions(-)
> 
> 
> base-commit: fab1beda7597fac1cecc01707d55eadb6bbe773c
> -- 
> 2.50.1
> 

-- 
மணிவண்ணன் சதாசிவம்

