Return-Path: <linux-pci+bounces-2213-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F83082F192
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 16:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E8AF1F221ED
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 15:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9EF1C695;
	Tue, 16 Jan 2024 15:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7RgLf5d"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8521C293;
	Tue, 16 Jan 2024 15:31:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B47FDC433C7;
	Tue, 16 Jan 2024 15:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705419105;
	bh=V2xoTtJUq/UqvZtvQbxp3jrBBucnW249ofTYrqS+xGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K7RgLf5dgWUKePe33ZWUDq03HS6PJNgocRb4TOPDbi9XUvJenj4Pl6sJf4KqUQeYo
	 cHP/Rf9ZLmTH3+PGGUWtTjemvOwYiqvXmJoNtSmxGAVTjL7I79Ljc4tW9Elw2GjWSd
	 EWoSdhZwgqJfc8y5HGnanrXDorhnvYbh6kEfdOurbkgNnRt+1/i51KZof1+KO4hbxZ
	 URa2SQcxHi4BDVmHeBvo+q1EUb3E5AZm5w8cF5RGIZq7zKOnSLr7HohaRo5cyReeoY
	 FiUn3t+1d5ytWJrXS5D6pcHlJJ11OGLGZ3txrQuePdd4biDo8tzBmTke0h0fy+VU7w
	 klSN83JrMRs8g==
Date: Tue, 16 Jan 2024 09:31:43 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>, linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH 5/6] dt-bindings: PCI: qcom,pcie-sm8350: move SM8350 to
 dedicated schema
Message-ID: <170541910304.4092355.5539725704986450934.robh@kernel.org>
References: <20240108-dt-bindings-pci-qcom-split-v1-0-d541f05f4de0@linaro.org>
 <20240108-dt-bindings-pci-qcom-split-v1-5-d541f05f4de0@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108-dt-bindings-pci-qcom-split-v1-5-d541f05f4de0@linaro.org>


On Mon, 08 Jan 2024 15:19:18 +0100, Krzysztof Kozlowski wrote:
> Move SM8350 PCIe devices from qcom,pcie.yaml binding to a dedicated file
> to make reviewing easier.
> 
> This creates equivalent schema file, except missing required compatible
> which is actually redundant.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie-sm8350.yaml  | 169 +++++++++++++++++++++
>  .../devicetree/bindings/pci/qcom,pcie.yaml         |  32 ----
>  2 files changed, 169 insertions(+), 32 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


