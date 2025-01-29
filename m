Return-Path: <linux-pci+bounces-20546-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BEEA220D0
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 16:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F09E1888D88
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 15:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EDA1DE880;
	Wed, 29 Jan 2025 15:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAoSCGWx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD0C1AAA1F;
	Wed, 29 Jan 2025 15:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738165477; cv=none; b=L03Gcf35tJ8rLEXwkCsuA/1aGcml6s/fQt27hYoQ+zo4ugUJz8J3wulkIkdKCDsfKa6FPvw7l5KuWvjkHk5mpCD8pbD5+hkhnrY7BrkmtDpoRKFh011i5tR77gcwgR5PNy162FdvURqVg4m/G+tKiQ/80vqn+bdwPsCYftX4Y4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738165477; c=relaxed/simple;
	bh=1VUif8Q56cdMe1cHovQowDVeYxK9USFWvRbdMuxlrJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TE0IlxTcfxsVa3TaPslNIFQjskMykINtNVoYE0tjgzXin1BN7sA/S3ivOn9NkKCFAYO5Dlvg/HE2x3YSaUWN/l06qXZMpWc5P+FIVvtiagZhnJH5Xgf28ehpQ3+9TNZs/XWc+s5Nznd5RlZtScYAOjCIaoMe4F/BasO6TQIs0AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAoSCGWx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 986BEC4CED1;
	Wed, 29 Jan 2025 15:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738165477;
	bh=1VUif8Q56cdMe1cHovQowDVeYxK9USFWvRbdMuxlrJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mAoSCGWx1Xjlffqp3lezZGmNfTX8wU8bPQbfRsMb+1OL0l+DUeANYFwtaMBZbBeHk
	 NjMLIomxBAPH19nYTYoeJFQvXUwwV8J8QOmKsXXNfk8KnEQVQ+k7U+2ITUoe5GZdGt
	 XEvPFSMIzG1uKZeaL2Lga3vpSGcejUwrzcTQQA7OwXe2vzDL+H/HMGgzRgtqyMJRDf
	 Vgk3gS/jijLBxPGL3XDQkqxfh6jwtjv14sdAUOlkSxjvCfMuRPJqMNOK+ew6HrV694
	 IpL+wpDMhCqR6Zj/2ofBS+AtAvHN+f8r2TZZuFIbX+mP1Yap3ptZ80y5qwROVC/Abt
	 ZcAc+4+FGDiOg==
Date: Wed, 29 Jan 2025 09:44:35 -0600
From: Rob Herring <robh@kernel.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, jingoohan1@gmail.com,
	p.zabel@pengutronix.de, johan+linaro@kernel.org,
	quic_schintav@quicinc.com, cassel@kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	fabrice.gasnier@foss.st.com
Subject: Re: [PATCH v4 01/10] dt-bindings: PCI: Add STM32MP25 PCIe Root
 Complex bindings
Message-ID: <20250129154435.GA2145727-robh@kernel.org>
References: <20250128120745.334377-1-christian.bruel@foss.st.com>
 <20250128120745.334377-2-christian.bruel@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128120745.334377-2-christian.bruel@foss.st.com>

On Tue, Jan 28, 2025 at 01:07:36PM +0100, Christian Bruel wrote:
> Document the bindings for STM32MP25 PCIe Controller configured in
> root complex mode with one root port.
> 
> Supports 4 INTx and MSI interrupts from the ARM GICv2m controller.
> 
> STM32 PCIe may be in a power domain which is the case for the STM32MP25
> based boards.
> 
> Supports WAKE# from wake-gpios
> 
> Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
> ---
>  .../bindings/pci/st,stm32-pcie-common.yaml    |  33 +++++
>  .../bindings/pci/st,stm32-pcie-host.yaml      | 116 ++++++++++++++++++
>  2 files changed, 149 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/st,stm32-pcie-common.yaml
>  create mode 100644 Documentation/devicetree/bindings/pci/st,stm32-pcie-host.yaml

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

