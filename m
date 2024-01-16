Return-Path: <linux-pci+bounces-2214-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA6C82F19B
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 16:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B189285C22
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 15:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B231C684;
	Tue, 16 Jan 2024 15:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e//fziQA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8861C29B;
	Tue, 16 Jan 2024 15:32:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1E4C433C7;
	Tue, 16 Jan 2024 15:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705419143;
	bh=WvIESDAYaGBmdlgwBGS2DDCGE8EdywUUPfxkqNd7bsA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e//fziQAphRkn/sgdSRtXKz6DQqWm97GXt4iC1R9Yk/QnWFZXCFZqhmdmQaaXmhQx
	 HSTf0mTImqk6wLC2q5htMM5pUONV2P9etLACNUfs7i268gEFBei+zyLU1r2YE1NCRm
	 nkVBi1zvqKO4QgsCCoMiB8Uz4Ph7cLngDQ1guLaep8bxFWMbJ5RAiEOcOuIyv9/pHj
	 f8h1V1C//6u744tBwU0HOo1A+xnZE0uXOeJ/YTL8l9Ffz76MzQo91g9wCBg49gEQpj
	 5qb6dSyeg172mztjiR4jmLEPsQY3HvcsJsgc++EmCbW2SWCSF/R1TFxpqJH9HR2ARl
	 o3u1hRAXrQNtQ==
Date: Tue, 16 Jan 2024 09:32:21 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, linux-kernel@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 6/6] dt-bindings: PCI: qcom,pcie-sc8280xp: move SC8280XP
 to dedicated schema
Message-ID: <170541914031.4097799.5054392716277488750.robh@kernel.org>
References: <20240108-dt-bindings-pci-qcom-split-v1-0-d541f05f4de0@linaro.org>
 <20240108-dt-bindings-pci-qcom-split-v1-6-d541f05f4de0@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108-dt-bindings-pci-qcom-split-v1-6-d541f05f4de0@linaro.org>


On Mon, 08 Jan 2024 15:19:19 +0100, Krzysztof Kozlowski wrote:
> Move SC8280XP compatible PCIe devices from qcom,pcie.yaml binding to a
> dedicated file to make reviewing easier.
> 
> This creates equivalent schema file, except missing required compatible
> which is actually redundant.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pci/qcom,pcie-sc8280xp.yaml           | 180 +++++++++++++++++++++
>  .../devicetree/bindings/pci/qcom,pcie.yaml         |  54 -------
>  2 files changed, 180 insertions(+), 54 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


