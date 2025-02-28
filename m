Return-Path: <linux-pci+bounces-22671-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A43A4A4A1
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 22:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9FDD3B54F3
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 21:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40F91D61B9;
	Fri, 28 Feb 2025 21:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yfd8FoQ9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E741CD210;
	Fri, 28 Feb 2025 21:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740777193; cv=none; b=HgocrFfpLzVVJS1OxP+BjS90Fz+Q8nH/s0m6nwfPNSLWeTuYdKpVBlb+WpXTe3xrVvR5WkC8nIjJYLyd3AEEeBRtp/wGTuhol1LqorHXPhgFEaqMWYW1Jy91/p6KZeEYiFmGwJ1mKJH61r7GFF/16cGK4PSkVQ7pgZ7NdUwVg/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740777193; c=relaxed/simple;
	bh=o630j4ozSxj6QOjgjq2PqdF3ZG3YxmMrdxMJ8Lrpch4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UsY5OFT34AgFiZSWwvp08Lxkpr8xwKDfb8URMQtNRdWGvaf/8Fx6XbdIk4Nh/123858nG7LetP4yQIdMcNNLJPG212/dbpfnKzXdNACHfNnqEr6hziie/qew17v1gjZB0YYxJgutmtYxupoHS+Qfwwu7V8Eiu/9iMj/pu3BMrpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yfd8FoQ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33D02C4CED6;
	Fri, 28 Feb 2025 21:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740777193;
	bh=o630j4ozSxj6QOjgjq2PqdF3ZG3YxmMrdxMJ8Lrpch4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yfd8FoQ9uVCEwK/EYb13cq28HvdL4WlDZe6y2QEJIJq9aPhkEIaKk0d5FNWu42664
	 mbfPTaAXDqkz5nRW4DHW0nqyZ1+ko/zQLsQVPKxtUjHLo3gkPZQ5Rv6czbQZfXNfdW
	 I00OLp3C6kyfv1dLK2m7/KjtqpV9SQjaF0ZhFc7KHwl6d5upwE/cxMYwhhLbCFUCCO
	 v7Z+e/W68pZV/JQGf5z2GY5sC8Sr6ONsI2dM1vNikPn2MUwbAt8SDyzAzbzIytVBZq
	 UMQ00V4sr1c9du2hTffrL52R7Ef5WlkDrWYg3giuhVags+Dc0EtvZHN5M44cDcSUd5
	 16Fo9rc1d38LA==
Date: Fri, 28 Feb 2025 15:13:11 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	cros-qcom-dts-watchers@chromium.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-arm-msm@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH 11/23] dt-bindings: PCI: qcom: Add 'global' interrupt for
 SDM845 SoC
Message-ID: <174077719117.3727982.4943120481364696957.robh@kernel.org>
References: <20250227-pcie-global-irq-v1-0-2b70a7819d1e@linaro.org>
 <20250227-pcie-global-irq-v1-11-2b70a7819d1e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227-pcie-global-irq-v1-11-2b70a7819d1e@linaro.org>


On Thu, 27 Feb 2025 19:10:53 +0530, Manivannan Sadhasivam wrote:
> 'global' interrupt is used to receive PCIe controller and link specific
> events.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


