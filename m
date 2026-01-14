Return-Path: <linux-pci+bounces-44734-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 413FDD1E119
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 11:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3CBCC3044B8F
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 10:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4F538B7DA;
	Wed, 14 Jan 2026 10:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZncLeU2v"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C6438A9B9;
	Wed, 14 Jan 2026 10:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768386668; cv=none; b=damYrwIjlmikKt9UoW/jucfD73RBJfdvtjNIB3olyV56iNqGF2Liw1RAIyRXSrUmi4cXM0ySzpCNkEsgPs0qmgbxSKboI5VIdbsEEO2MEiidpS8LEoRfFqiYO976eKLhAHeZlvbKT9R50tgttkOQoAwlHuMTDEOegcfQtxRcq1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768386668; c=relaxed/simple;
	bh=jhP+Ux+9M7AktWU3hsCE9s9kQrJMiHWvQXrGSRM2jWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R06PAoWTjz9h2OiKHGFwnUelUL6Y8gepL5WBswjH/iSzCjjA14rn7fXHCO9lHQb0RdG4ow1Z2oDcxUrptDtTlxVYafr+4BXvB8bxmCGvoHAjsr+LAce5HpC50auUUabcmZA10SvX3Uy8l/JFEnxy8333gCG95QhbzaIy2ekMFU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZncLeU2v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED94CC16AAE;
	Wed, 14 Jan 2026 10:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768386667;
	bh=jhP+Ux+9M7AktWU3hsCE9s9kQrJMiHWvQXrGSRM2jWA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZncLeU2v/p3gZ6APS9CDIonkzqkaOUUrAOVjcR50WUVckRCx66z7QftytiAozCIQP
	 iQQtL0LYjDABBUU3Z0VcR/aQlkvCHTVHaRqfuxso6qONnuUBIq7p+vZmbsNZJV1djv
	 80G13BeW2iJtxlF9V/IYDidme6HQeW4sL6WwzZTkHV4gPKbaUaQTkmVkfF8LHUpoo4
	 JLK2iCeIiDGUn2H7HCKJSmpINGamf/jTB+nsX2IZYJPVKtCkB407FgXLCebkB3ZEYz
	 P0lq2kuWANdMbdW7g6TI7kyY/rmGRU+Uu+6dLpXp8RsKwFt05kj1SKGJ41ILMoi6z/
	 mMe5CWw7bZjQw==
Message-ID: <84882e25-2ff9-490e-81c7-068bd20d6342@kernel.org>
Date: Wed, 14 Jan 2026 11:31:02 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/5] dt-bindings: ata: sata: Document the graph port
To: manivannan.sadhasivam@oss.qualcomm.com,
 Bjorn Helgaas <bhelgaas@google.com>, Manivannan Sadhasivam
 <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Niklas Cassel <cassel@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 linux-pm@vger.kernel.org, linux-ide@vger.kernel.org
References: <20260107-pci-m2-v5-0-8173d8a72641@oss.qualcomm.com>
 <20260107-pci-m2-v5-1-8173d8a72641@oss.qualcomm.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260107-pci-m2-v5-1-8173d8a72641@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/7/26 15:11, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> An external connector like M.2 could expose the SATA interface to the
> plugin cards. So add the graph port to establish link between the SATA Port
> and the connector node.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

I applied this patch to the libata tree, for-6.20 branch. Thanks !


-- 
Damien Le Moal
Western Digital Research

