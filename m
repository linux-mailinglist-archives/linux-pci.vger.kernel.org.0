Return-Path: <linux-pci+bounces-22665-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE44A4A489
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 22:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 424B63BA6A3
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 21:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E651C5D4D;
	Fri, 28 Feb 2025 21:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GoX13EPt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC331C54B2;
	Fri, 28 Feb 2025 21:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740777104; cv=none; b=qsAJ3eT3reEz2pyXvBltRbSn1h6F6NVe5TjFzdp3yArCgQ4XMNrwCOFbU7Ow5x1chZrKoss5miSzx2rMqwTjVXHI/YLedFe8t08DyG1QUu9O0zLESqO0uEw0Us2raxgfYRLUCm+GwDAKvq8H+YM/CoscQGeAplrch+5wIJz9ztY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740777104; c=relaxed/simple;
	bh=OhiDMrLy0xrsSZkJWroK/LlflbefgXgljMQJlgwY/k0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqhH2oPpSNZD4Wjn9Me+amdj5r06eaJzEwu3sA17rU1Szrs3QorEoqkuPfF1uyKFkSzS0Bep/MUGmR0G7UmdR27De2NwGP1H4jpCnn1ymsBs1+lvUH5JZNhwXcsppqhDNj16vOf49VsqkJlowYDjE//+r+EOzWO2JIMB8LqJWbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GoX13EPt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8A4C4CED6;
	Fri, 28 Feb 2025 21:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740777104;
	bh=OhiDMrLy0xrsSZkJWroK/LlflbefgXgljMQJlgwY/k0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GoX13EPtRE3Yt1x4rFIYVL3t6P4n2wGcSDANo+mqw+QinEvtd82pGq5yEB43bNFA0
	 4J2AddwlzQtC4HgJW9nxPxNo4zz+O4jiqL5rgZYP5uuGwUM8r+t8SRhD7YIoSgeYE8
	 RFDee6ceSF+hfd1+lS9cI4ljJ98QBgVO3tvGsIYzUpRhhjfkIzwI05xDNCgb5I3He4
	 eEi8uIzfoDo20WS4SYi8oxedGq4wNWDz7RE2deLvSk9IpWkQKZIOHVoXVF/0LFIxNj
	 9GzLAmE95M5iypfjFy4eb1nnCo93R6SX3b1JTqoLtONd8Jx871WxdDsSgjRp5GCrD0
	 mpD2WnaUEJ5sQ==
Date: Fri, 28 Feb 2025 15:11:41 -0600
From: Rob Herring <robh@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/23] dt-bindings: PCI: qcom,pcie-sm8150: Add 'global'
 interrupt
Message-ID: <20250228211141.GA3724122-robh@kernel.org>
References: <20250227-pcie-global-irq-v1-0-2b70a7819d1e@linaro.org>
 <20250227-pcie-global-irq-v1-1-2b70a7819d1e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227-pcie-global-irq-v1-1-2b70a7819d1e@linaro.org>

On Thu, Feb 27, 2025 at 07:10:43PM +0530, Manivannan Sadhasivam wrote:
> 'global' interrupt is used to receive PCIe controller and link specific
> events.

These are all the same change going to the same maintain, it could be 1 
patch.

> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie-sm8150.yaml | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

