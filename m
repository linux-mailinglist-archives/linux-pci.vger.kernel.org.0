Return-Path: <linux-pci+bounces-2212-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF56982F18B
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 16:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4E9E1C23615
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 15:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E9A1C693;
	Tue, 16 Jan 2024 15:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2WnrImY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE541C68F;
	Tue, 16 Jan 2024 15:31:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26CAFC433C7;
	Tue, 16 Jan 2024 15:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705419062;
	bh=IeNw4V9MHFR4LhRdgbtrKJ2XWSOzNXxfb0Q2QL7Hi44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b2WnrImYbPsy/GrKYDCrGGy5GB5++/rHLNskDkg/F/4pAcJwxTbmzGP+TX+iRgSnc
	 aEWQbLnUmC0Dbm16j1KcyA/nikqrFHCM2GiJ8TM6hwxm+Af2oodF/Yk4I899D+VlOG
	 XJ2Bk51SHIKJv5zd4U2ykN/Aq6bUjbxNSlrIIjk5zETw8iZPMaLSsqkLdYClAh80Kw
	 sTZVCJ7AoYK49OvfS7yEPfkAuupiHLd3BwoD7YXHnMUeRTAEssHCb7KwdqLPk4gum9
	 1tr+j5Exg7/Ye2VD0r3PYJ6dd0tDQw5nJTiYno4dnDzaFjFlwG7fpHAcekkhvF5kDZ
	 3BDaR5KMX2I2Q==
Date: Tue, 16 Jan 2024 09:31:00 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>, devicetree@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 4/6] dt-bindings: PCI: qcom,pcie-sm8150: move SM8150 to
 dedicated schema
Message-ID: <170541905929.4085790.1631739367553157527.robh@kernel.org>
References: <20240108-dt-bindings-pci-qcom-split-v1-0-d541f05f4de0@linaro.org>
 <20240108-dt-bindings-pci-qcom-split-v1-4-d541f05f4de0@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108-dt-bindings-pci-qcom-split-v1-4-d541f05f4de0@linaro.org>


On Mon, 08 Jan 2024 15:19:17 +0100, Krzysztof Kozlowski wrote:
> Move SM8150 PCIe devices from qcom,pcie.yaml binding to a dedicated file
> to make reviewing easier.
> 
> This creates equivalent schema file, except missing required compatible
> which is actually redundant.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie-sm8150.yaml  | 157 +++++++++++++++++++++
>  .../devicetree/bindings/pci/qcom,pcie.yaml         |  29 ----
>  2 files changed, 157 insertions(+), 29 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


