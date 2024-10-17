Return-Path: <linux-pci+bounces-14736-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 989699A1C32
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 09:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C784C1C20362
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 07:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57D61D45E0;
	Thu, 17 Oct 2024 07:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hiDeOPU0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C301D416E;
	Thu, 17 Oct 2024 07:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729151883; cv=none; b=Z8NS0WvQpJ7FLv6C2jURviSLL0izEHodVW1JThRgQ1WMSIFM5R88i56w4jJmdQBSUQ7yPsznV244nV/COSu1PC1v3ASE72+iimhNb1rWfsncYMfnt0cUWFy3n07tF9GMDeBS7Oq9QBbiW+FoEMmYqIiat/kTpZaUohbqFivozJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729151883; c=relaxed/simple;
	bh=TT5FczrKxysAiZJvvPtBBY0kZo8jywbmX45UXo/wZWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8CeeoNBhvA86BCi9g/QyF4yiRQOaxiNnlmT+94Vb/8ISyPe6Ylk0cgETZh+Yd7bMlEhf5NVZbgO5YYXrhHyNbKPTeZfkuGinTUgySGlIExLROyLzbVe869kNmA6Xw3YpnYeQSulwVWwLPgX4toASLoskQ4a7HYV5ngPsvRyhcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hiDeOPU0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457F3C4CEC3;
	Thu, 17 Oct 2024 07:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729151883;
	bh=TT5FczrKxysAiZJvvPtBBY0kZo8jywbmX45UXo/wZWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hiDeOPU0DvCq5r0uudv036FZfkakGno/3tHGLt0F7GaaDT6a0qa/6l3xUEpzn5PyN
	 1coUKmQEbq3ay/ofxkhom+gmQ+PqzqEWgTF8vqwOkfcOnACXTV5jDzcxAKQCncHw1A
	 gL2VR03J6fVDcM0MO6sfEDlbfic66fefS4w0blPkRCb+bqaDIQ/s3AD/G9gZyyv4WW
	 fsQOgohaqzV6qkmjE8Uo/Bcrj/js4jQFQVIIKX7vlEDtPRHHvqfcvRrsOU6kll/iQe
	 UssdRmeQmKDtacTqXYvemzQww2AXuuO23OxK2OTnuE0s6C/rMC4xLTiWaBIBi+xUCs
	 cQY4SAicN7XLQ==
Date: Thu, 17 Oct 2024 09:58:00 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Qiang Yu <quic_qianyu@quicinc.com>
Cc: manivannan.sadhasivam@linaro.org, vkoul@kernel.org, kishon@kernel.org, 
	robh@kernel.org, andersson@kernel.org, konradybcio@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, abel.vesa@linaro.org, 
	quic_msarkar@quicinc.com, quic_devipriy@quicinc.com, dmitry.baryshkov@linaro.org, 
	kw@linux.com, lpieralisi@kernel.org, neil.armstrong@linaro.org, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
	johan+linaro@kernel.org
Subject: Re: [PATCH v7 3/7] dt-bindings: PCI: qcom,pcie-x1e80100: Add
 'global' interrupt
Message-ID: <a6yxt4o5alnu5oa5t4guvjq4x37xa6t664ae3palhmumztawlv@n3r3mnrnui2f>
References: <20241017030412.265000-1-quic_qianyu@quicinc.com>
 <20241017030412.265000-4-quic_qianyu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241017030412.265000-4-quic_qianyu@quicinc.com>

On Wed, Oct 16, 2024 at 08:04:08PM -0700, Qiang Yu wrote:
> Qcom PCIe RC controllers are capable of generating 'global' SPI interrupt
> to the host CPU. This interrupt can be used by the device driver to handle
> PCIe link specific events such as Link up and Link down, which give the
> driver a chance to start bus enumeration on its own when link is up and
> initiate link training if link goes to a bad state. The PCIe driver can
> still work without this interrupt but it will provide a nice user
> experience when device gets plugged and removed.
> 
> Hence, document it in the binding along with the existing MSI interrupts.
> Global interrupt is parsed as optional in driver, so adding it in bindings
> will not break the ABI.
> 
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> ---
>  .../devicetree/bindings/pci/qcom,pcie-x1e80100.yaml      | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


