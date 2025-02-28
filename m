Return-Path: <linux-pci+bounces-22675-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9C8A4A4B7
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 22:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8455A1899E71
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 21:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1D21D6DB5;
	Fri, 28 Feb 2025 21:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qrtz+e+Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7981D61BC;
	Fri, 28 Feb 2025 21:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740777278; cv=none; b=B5JvmHXhU0IPt7nHPnvcUJhLfjlyXUHG0wtZ03a2udhElRGTshnkDqJ5i/imFrF8gNuBNL5kerppJkF1wrhg2QiLM1ZGrEgMR2IzXd9XulMEj1grtfNccOcDRiQ0+1DMU/8wgPiWYSUENCW9d34E4B4LvE94SdPGhkoA7GTzbB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740777278; c=relaxed/simple;
	bh=v6hg4ep7NJBZvKg8VhFMoYeFiyQJhiLYnuQpuY51rsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPW1TJAyf5icvXf/JoKIVtrydwn+rHq3b2sU2d6NALkvgt230sqPvIaE6p9LnKkwQ7uvFU2KBCIGjiDhBNHILkZtf47dUWPmTRTDSxhgfbZDsFrrWfm15H5t4gH/kkdqs64C/a0UnWcCId2+x3TmMN+Xf+uj+M7DaNqdoQEjFGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qrtz+e+Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C9D8C4CED6;
	Fri, 28 Feb 2025 21:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740777277;
	bh=v6hg4ep7NJBZvKg8VhFMoYeFiyQJhiLYnuQpuY51rsg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qrtz+e+YUzo/HnRWuZZm7lPpC2vVDipssXL/59sjSwy2Oez+Rju/8wpFe319SA2Tw
	 SPpbWS7SlezVO9yy4dTX86bNfNvjHQQBA5OUlQDwnsaX+S4R0HToizcvPglfc5bTuh
	 Zuhx91ZkpGnG6cZbX9Vt99BHTB3TPfLUB/VAMwNJ/TBuQWIWM3lZHceh93mmDPATPD
	 U44IIbf7uUJBFf6bFXXPJ4rgBhFKJFWeacmqbArP3ivsyIfx1V+U2mTOF84CEOLOoP
	 XGOJ8GGTe/e899CLMo7wqRxUvlZE61qe32wr1XzpZliHlmKRytaxfTbrSTTy/r8GLA
	 sN/F5hjcvlisg==
Date: Fri, 28 Feb 2025 15:14:35 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	devicetree@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-pci@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH 20/23] dt-bindings: PCI: qcom,pcie-sc8180x: Add 'global'
 interrupt
Message-ID: <174077727539.3730432.3006306754622669525.robh@kernel.org>
References: <20250227-pcie-global-irq-v1-0-2b70a7819d1e@linaro.org>
 <20250227-pcie-global-irq-v1-20-2b70a7819d1e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227-pcie-global-irq-v1-20-2b70a7819d1e@linaro.org>


On Thu, 27 Feb 2025 19:11:02 +0530, Manivannan Sadhasivam wrote:
> 'global' interrupt is used to receive PCIe controller and link specific
> events.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie-sc8180x.yaml | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


