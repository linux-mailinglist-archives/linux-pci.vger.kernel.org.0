Return-Path: <linux-pci+bounces-17422-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB419DAA3B
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 15:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F971166B62
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 14:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D1C1EF09B;
	Wed, 27 Nov 2024 14:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGTTDtjw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F7C1FF5F8;
	Wed, 27 Nov 2024 14:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732719565; cv=none; b=NYlhZh5KcRmy0GN8eBNSWIbUqdj0NMLmW3Eo7IQXlL22Ry4U0a5EGI+w132V7z76H27hnHr4hcOOP8r5GXodYK/L646dJsIQ5dLwrbkipLL5jDyMziyQwh6zwksNOwy3LXi5h2agDWTw5e9Lvzt/JThSsB1X5Ks3Zhw0+S2eYoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732719565; c=relaxed/simple;
	bh=SVhXyj/ZbRJBm3pGNYNcl/3ggq+hcnNG3Esckkf/+Yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j28PdIyZrEoy/lGzyT33MvURwVKJkm2uUR1k1OLc9PFWHwoghmSHg+wkmoXYotuyrBHXGzywf06F3GsQCVQzHxSKuTGXNu0uznk9rcqbxnQ/06xIBHRxwF3Y3UH5HwvOyhmCEzzmGt58mSHP6suIDDU1CC0gncWUs8H9fDS1h4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGTTDtjw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 753AEC4CECC;
	Wed, 27 Nov 2024 14:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732719564;
	bh=SVhXyj/ZbRJBm3pGNYNcl/3ggq+hcnNG3Esckkf/+Yw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TGTTDtjwHXPmzkERIfnnt1B08xP9zER2IuaQCb6KIZPwaS6Gja8vheY34Uo/TfQF0
	 Uvrmiz1eloyHIZind1vhluijfaF7fPXrqKw6Jj17pD/ONXPyxYyZu85V+gsevxU2Gm
	 T8Hnl4x6Yd6Od8VwiJbyY5sObEOqEeBkpXseFFSkYX0UhWw5hadQ2J8SuD2Zo0WLDD
	 tNtEoCHAIwNO8nAx9k1yoiUz/RyJvYXG8d2a1u/MhHdibUF+rYHVsOuZ7ZP5nTe/Yc
	 8x/H4AmzuryL/HTW9M+bc4VTgALSWNEubNbu4PNmdMWIAMHAyYoOHPfYGtqXAusS6J
	 0M6eMhpeTELfg==
Date: Wed, 27 Nov 2024 08:59:22 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: linux-stm32@st-md-mailman.stormreply.com,
	manivannan.sadhasivam@linaro.org, quic_schintav@quicinc.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, p.zabel@pengutronix.de,
	linux-kernel@vger.kernel.org, mcoquelin.stm32@gmail.com,
	cassel@kernel.org, linux-pci@vger.kernel.org,
	alexandre.torgue@foss.st.com, devicetree@vger.kernel.org,
	lpieralisi@kernel.org, bhelgaas@google.com, kw@linux.com,
	fabrice.gasnier@foss.st.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/5] dt-bindings: PCI: Add STM32MP25 PCIe endpoint
 bindings
Message-ID: <173271956195.3489911.2255772456897177524.robh@kernel.org>
References: <20241126155119.1574564-1-christian.bruel@foss.st.com>
 <20241126155119.1574564-4-christian.bruel@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126155119.1574564-4-christian.bruel@foss.st.com>


On Tue, 26 Nov 2024 16:51:17 +0100, Christian Bruel wrote:
> STM32MP25 PCIe Controller is based on the DesignWare core configured as
> end point mode from the SYSCFG register.
> 
> Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
> ---
>  .../bindings/pci/st,stm32-pcie-ep.yaml        | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/st,stm32-pcie-ep.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


