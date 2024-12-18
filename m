Return-Path: <linux-pci+bounces-18685-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D509F6324
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 11:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21E587A1FFA
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 10:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EAA19E994;
	Wed, 18 Dec 2024 10:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PM1rSXQr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB58219A298;
	Wed, 18 Dec 2024 10:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734517756; cv=none; b=rKH5O26cxvKsahx66B9TgnLlypsnRqOqiM8ZUZxrUQH3Lrhs2tMb5V/c6ATq/ufk0ItbBbyMrIsATM8Xo0VZGvuAhv+rnJ8rjG/JJihVnbt8jOIhfBEUnbKkN2+nriAnSDFXiiRObrnH6SLk+ahJPMZNAgPj7tWmH2bs+AFXhYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734517756; c=relaxed/simple;
	bh=rVXq692XhX8/BrFOI5DCC52Q9mZNMtBW9bToWcfXw04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OiYOVZc2LmgSbuSzBLf11R+toPfW6aVsg5z07HVmZPorNXyMvrGwDhmLLa5f0pwwYByE4nw9tQRtdYfawk4/KRvoyOgVNlZFqFA/Ji2XHmisUkQSLXWqQ7cGLJItpaHuNwuWikjoOn0O6B9eWwgiQ8c4wGzdpIhnvRccr0EEi/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PM1rSXQr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F103C4CEDD;
	Wed, 18 Dec 2024 10:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734517756;
	bh=rVXq692XhX8/BrFOI5DCC52Q9mZNMtBW9bToWcfXw04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PM1rSXQrGhvqnFXDucTAEykU8xpJnI8LTMJDPQEFai2RxVbx5MaeCpJI7VTsXezjk
	 SL+ZPpF8KRb3vA35Uf3ylG2radHGPkByoOXEcDN6wCNauag0+t0VvAUkHsJgebL378
	 suP/Zve0BHzKV5UBBPwoiwrcPnd+eJexiHX3oRS0QZJTfgTlTXkLUNJ6sspId3Eh4r
	 yiH1hVlxyfepthR6sKmBtqjdFvijZ4vnuO5YBiXs3SiOIyzbSPrXclkuVaOFAwm2YR
	 87uq/nOB8NFwA8Ly1FPrnYpd294ygG/azLqoV3BSGF/J4qyl9qe5uJGOnvCWy4NRsM
	 mMYPO31PhgrwQ==
Date: Wed, 18 Dec 2024 11:29:12 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	manivannan.sadhasivam@linaro.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	vkoul@kernel.org, kishon@kernel.org, andersson@kernel.org, konradybcio@kernel.org, 
	p.zabel@pengutronix.de, quic_nsekar@quicinc.com, dmitry.baryshkov@linaro.org, 
	quic_srichara@quicinc.com, linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v3 3/5] dt-bindings: PCI: qcom: Reuse 'pcie-sdx55' reg
 bindings for ipq9574
Message-ID: <72gjhqpzaszfb36pjl4g4t5x6kyc3xclwaenbzkgrkz6wtkx5j@6dw7stv76sr3>
References: <20241217100359.4017214-1-quic_varada@quicinc.com>
 <20241217100359.4017214-4-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241217100359.4017214-4-quic_varada@quicinc.com>

On Tue, Dec 17, 2024 at 03:33:57PM +0530, Varadarajan Narayanan wrote:
> IPQ5332 PCIe is similar to IPQ9574 except for the 'reg' bindings.
> Hence use the reg bindings that could be applicable for both and
> avoid adding a new binding for IPQ5332.

My comment was about driver, not binding.

You cannot reuse bindings. Use fallbacks.

Best regards,
Krzysztof


