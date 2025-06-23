Return-Path: <linux-pci+bounces-30382-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D3DAE3FC8
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 14:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F20A53A46E2
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 12:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2C8246777;
	Mon, 23 Jun 2025 12:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VA4AwAHW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DB82459D4;
	Mon, 23 Jun 2025 12:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750680789; cv=none; b=dEb5ix62y1Thc1ipPLya62ycx3VCiuM6lAhKfDMM+QpStQfrk73pt1Dm5DuZU6YimE8oCetmCDcxhsSP/rFz16eC0HSllxHRR4oxKRSFcocShWGciHgAh+uZvBBKUHmCyHmuxc5airXQ7pX4VpL2Ltp/6rV5MIO59MuhfthGVSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750680789; c=relaxed/simple;
	bh=2PC+knTY5x5lOCBbzbS0Ubx+8aVrsaLIP9Mh9VLPrJo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MLbCWCx8C3GowdIoSAmtVFUVmdLdMbg4Yg+txZJYqlUooY2BHB6ppC2guLUkKxgX4F+hEFJ1heMemsEcG51pWDZC4+CXjRv1aKiqkua/zGABDydtB/BMIdcMSkR8xbYFTcqcCmq3V9iYUukdszaddFZ+1BT8pSLidZ/lscLq+Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VA4AwAHW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB7C3C4CEEA;
	Mon, 23 Jun 2025 12:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750680788;
	bh=2PC+knTY5x5lOCBbzbS0Ubx+8aVrsaLIP9Mh9VLPrJo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=VA4AwAHWOkFYBn7OH625vRsz3hViv53X4iPL6X6ZiITzC8cKgpkQK/0N75a4eIYz7
	 rGoK9Bm+IUHpFrSnnlZrKXR9n91QeliX2c5WbEp5ZMHMMcSeRAPyWVePkC0VZF/agE
	 4mqlNTtRYJbBV9uNyasd0fE+Qg+HV4lgnhS5Ag1x4yTNtgamHyRUARGgbcpw0hJrtx
	 YkHKHu0gISdZgToGUUXUCp4UCDdzzL9BwSCnaoTqPeKEbOp+/cwxOeOzYjdJuELU+u
	 yZzeLm3SHx7igvbAPpW9J38/Q0i9T4ksvwZuFtNZ7O4xUkdEmxwUiqzAWwKYdy+W3Y
	 Ewfiui5D3qUCQ==
From: Manivannan Sadhasivam <mani@kernel.org>
To: lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
 bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, 
 p.zabel@pengutronix.de, johan+linaro@kernel.org, cassel@kernel.org, 
 shradha.t@samsung.com, thippeswamy.havalige@amd.com, 
 quic_schintav@quicinc.com, Christian Bruel <christian.bruel@foss.st.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250610090714.3321129-1-christian.bruel@foss.st.com>
References: <20250610090714.3321129-1-christian.bruel@foss.st.com>
Subject: Re: (subset) [PATCH v12 0/9] Add STM32MP25 PCIe drivers
Message-Id: <175068078778.15794.15418191733712827693.b4-ty@kernel.org>
Date: Mon, 23 Jun 2025 06:13:07 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 10 Jun 2025 11:07:05 +0200, Christian Bruel wrote:
> Changes in v12;
>    Fix warning reported by kernel test robot <lkp@intel.com>
> 
> Changes in v11;
>    Address comments from Manivanna:
>    - RC driver: Do not call pm_runtime_get_noresume in probe
>                 More uses of dev_err_probe
>    - EP driver: Use level triggered PERST# irq
> 
> [...]

Applied, thanks!

[1/9] dt-bindings: PCI: Add STM32MP25 PCIe Root Complex bindings
      commit: 41d5cfbdda7a61c5d646a54035b697205cff1cf0
[2/9] PCI: stm32: Add PCIe host support for STM32MP25
      commit: f6111bc2d8fe6ffc741661126a2174523124dc11
[3/9] dt-bindings: PCI: Add STM32MP25 PCIe Endpoint bindings
      commit: 203cfc4a23506ffb9c48d1300348c290dbf9368e
[4/9] PCI: stm32: Add PCIe Endpoint support for STM32MP25
      commit: 8869fb36a107a9ff18dab8c224de6afff1e81dec
[5/9] MAINTAINERS: add entry for ST STM32MP25 PCIe drivers
      commit: 003902ed7778d62083120253cd282a9112674986

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


