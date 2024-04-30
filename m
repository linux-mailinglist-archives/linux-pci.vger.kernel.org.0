Return-Path: <linux-pci+bounces-6908-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8388B818C
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 22:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 223E8B23F11
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 20:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0200C1A0AED;
	Tue, 30 Apr 2024 20:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OetM1xSZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26C7199E9B;
	Tue, 30 Apr 2024 20:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714509375; cv=none; b=EEGh1wMqq0hR9+LSfD7hlRkZ2DrYjTaoFPkHwGAyXnS57LmJ/0ONM3McAOh2aWaykO87mInIvQQgnqeDP+M99ZcV2aeG640YLYrRWs4s3KPUrUs5nZJQiN/4kiGaGLzeSITLudMZ9wdYyAbm8LGIujAL+MpFSfERDfFyJULJWno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714509375; c=relaxed/simple;
	bh=Hkj282ZLhfbSUGTDTtv67ovkyS9SO/gWC6U/Vkj6ntE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGtfs7c5SgCzh7By2yX6e8tFARBTPOGhLMLBPIgtNU5DjtZhS5AUr6RZSRtekbJbSJIcX/EcoTZw9FCF/OhL3ImZMynIb/EYqBmEaB1ps25coUfcbaqLcRgj2XTNrJ0db8qtZpPhKf9GyA+aetzqyTQmlfv2BaCbBE3raxiqyaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OetM1xSZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65FE6C2BBFC;
	Tue, 30 Apr 2024 20:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714509375;
	bh=Hkj282ZLhfbSUGTDTtv67ovkyS9SO/gWC6U/Vkj6ntE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OetM1xSZk1J0d3YpjnwC9bXo2yKgdoivZ1Z2sUGNB56z1UgB9XmC+L6fSQBlWbQI/
	 qKFuZWpF+P3kxNZoRXRfqPW6cU6T2XJW/G1Ux4af34+Tp7umnXcllQyUj+UjP06+p1
	 a8VxltRmcsXGj1X7eQi9/gFo9y8jKV4xsGQy0EYHtFR8sWygzcmIb1Fd2WNYomut6L
	 3qatP8rGrvwURD97AJZD99iqXpbk1DUASWyPQBNibwd+HI4tSiLzVkOWoEaMwko+9O
	 e5ag0rcBDxffjSolV52iuRTxMkxf+ZNKtRV7ltVDUlTtkO8w7m+zvq40Im9rf7Wm1z
	 Hu7AibVsyDe0Q==
Date: Tue, 30 Apr 2024 15:36:14 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>, Eric Dumazet <edumazet@google.com>,
	linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
	Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Michal Simek <michal.simek@amd.com>, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] dt-bindings: Drop unnecessary quotes on keys
Message-ID: <171450935610.1153506.3784386455405156371.robh@kernel.org>
References: <20240426202239.2837516-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426202239.2837516-1-robh@kernel.org>


On Fri, 26 Apr 2024 15:22:37 -0500, Rob Herring (Arm) wrote:
> The yamllint quoted-strings check wasn't checking keys for quotes, but
> support for checking keys was added in 1.34 release. Fix all the errors
> found when enabling the check.
> 
> Clean-up the xilinx-versal-cpm formatting while we're here.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/net/sff,sfp.yaml   | 12 ++++++------
>  .../devicetree/bindings/pci/xilinx-versal-cpm.yaml   |  7 +++++--
>  .../devicetree/bindings/pci/xlnx,nwl-pcie.yaml       |  2 +-
>  .../devicetree/bindings/phy/brcm,sata-phy.yaml       |  8 ++++----
>  .../devicetree/bindings/regulator/ti,tps62864.yaml   |  2 +-
>  .../bindings/soc/tegra/nvidia,tegra20-pmc.yaml       |  6 +++---
>  Documentation/devicetree/bindings/tpm/ibm,vtpm.yaml  |  4 ++--
>  7 files changed, 22 insertions(+), 19 deletions(-)
> 

Applied, thanks!


