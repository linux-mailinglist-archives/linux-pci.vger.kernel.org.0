Return-Path: <linux-pci+bounces-2211-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E66D82F186
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 16:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8594E1C2328A
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 15:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEC01C294;
	Tue, 16 Jan 2024 15:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o3OAUYqX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C2F1C686;
	Tue, 16 Jan 2024 15:30:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407B1C433C7;
	Tue, 16 Jan 2024 15:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705419037;
	bh=NtlQnQd8d2EZvcWS7NP/GFOR2COZ5yvK9sOWTwGlo8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o3OAUYqXjuRS4lQMnLsoD3HyTLFtuoQ6fTk6K+7vDqpRIRyO9IqU9/uml7yDwnyW4
	 W6vn8YR/yZeikXx3ez8i1DVmjJxMvf6ndRzOC9mcH/nnjkYC0rpssRtaWsodUViDyQ
	 oyiA1okSydwtu+/bMtPygyNlVOSqtqZ1F1wrp0z8H8CYaawAqxrFHF2mBREb37ysOI
	 98gC2cH1FL/q8rKBvyTGSsx5qztALn5f4RdzOTQ4bvFIE94JvhmInvgvPI/iUiT4N3
	 ZlmnnGysa+Edo8jY1pwe5m6fI1mP+BYoRM5blUr3Ak8NSzZq2KxLOW9zbli+/mKzWV
	 Ex6n3Ko85vBiA==
Date: Tue, 16 Jan 2024 09:30:30 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>, linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [PATCH 3/6] dt-bindings: PCI: qcom,pcie-sm8250: move SM8250 to
 dedicated schema
Message-ID: <170541902117.4080388.15222330047897033696.robh@kernel.org>
References: <20240108-dt-bindings-pci-qcom-split-v1-0-d541f05f4de0@linaro.org>
 <20240108-dt-bindings-pci-qcom-split-v1-3-d541f05f4de0@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108-dt-bindings-pci-qcom-split-v1-3-d541f05f4de0@linaro.org>


On Mon, 08 Jan 2024 15:19:16 +0100, Krzysztof Kozlowski wrote:
> Move SM8250 PCIe devices from qcom,pcie.yaml binding to a dedicated file
> to make reviewing easier.
> 
> This creates equivalent schema file, except missing required compatible
> which is actually redundant.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie-sm8250.yaml  | 180 +++++++++++++++++++++
>  .../devicetree/bindings/pci/qcom,pcie.yaml         |  48 ------
>  2 files changed, 180 insertions(+), 48 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


