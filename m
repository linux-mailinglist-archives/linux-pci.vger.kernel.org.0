Return-Path: <linux-pci+bounces-2401-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28293833530
	for <lists+linux-pci@lfdr.de>; Sat, 20 Jan 2024 16:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 998131F23048
	for <lists+linux-pci@lfdr.de>; Sat, 20 Jan 2024 15:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76862FC1F;
	Sat, 20 Jan 2024 15:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+F1rVpi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBA9FC0A;
	Sat, 20 Jan 2024 15:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705763818; cv=none; b=s0vPhf9l8lcXVAZwiuwANtEF76wTSEkJ6Yxs+vDqdHQh3Nfqwe36oVi+VWMIkLX5IcE1Dm3SGH6//Gocxv945lyRQXSCOLl6mZLVMh1rclGBoRy9tjQ2skfTBSFzeVGTZJt66taaGuU/UtV8a+UWaThDoTg05EVB74Kx5DnV/yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705763818; c=relaxed/simple;
	bh=9SEr9/XdzmIJc8yNG3vWCLsaNfMf/4ZUEDrax18u5Lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2S+Oxy3x1uNi9g953lpoxK2UFkVKtMPGxip78WofL0jnW/VK0w1oSGvqK4JYI7lf53Y5aZxXRKJA9cnmRon16ba6UIoTjSJ6/R2DChxsnbrXGdQOEtG2Cea4tZ9iNjx9jSugrE0i0oOWITm+tAt6+fB9pjm2kOtw9nMvkXzFgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+F1rVpi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D5BC433F1;
	Sat, 20 Jan 2024 15:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705763817;
	bh=9SEr9/XdzmIJc8yNG3vWCLsaNfMf/4ZUEDrax18u5Lw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y+F1rVpim1lh58P9Zy9Zh6bCb4LhbBHG1z86l9c38GqIK+VkSDyUYxHPMaOvXSDir
	 6NJxz3OfvOXSLItgldd5mKhTSj6rbzCYyNkGXTFqY8m3gsrLd3SmbFIC0z2B/w0zou
	 F9IkN0rRyy5lTKyeHISV0P7TF+yurnUiy8/eF7Ce7I5xqzKZdxE8inZ4H1VOdAyWd4
	 PsaZpcFt9UaGip2cLCpjtgCvNWOVj2zW9cjPG3vk432FRtNSFmZgpAFOG9RLOwgDSj
	 NSQkR/UpNnHu9YFBf2fMbuAOLA4rn3n/6RZdkaHHrDbJQiCd6Snfu0dnRtRiesIWH/
	 Qyrp1fafZIEgA==
Date: Sat, 20 Jan 2024 20:46:48 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] dt-bindings: PCI: qcom: move to dedicated schema
 (part one)
Message-ID: <20240120151648.GB6371@thinkpad>
References: <20240108-dt-bindings-pci-qcom-split-v1-0-d541f05f4de0@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240108-dt-bindings-pci-qcom-split-v1-0-d541f05f4de0@linaro.org>

On Mon, Jan 08, 2024 at 03:19:13PM +0100, Krzysztof Kozlowski wrote:
> Hi,
> 
> The qcom,pcie.yaml containing all devices results in huge allOf: section
> with a lot of if:then: clauses making review and changes quite
> difficult.
> 
> Split common parts into common schema and then move few devices to
> dedicated files, so that each file will be easier to review.
> 
> I did not split/move all devices yet, so if this gets accepted I plan to
> send more patches.
> 

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> Best regards,
> Krzysztof
> 
> ---
> Krzysztof Kozlowski (6):
>       dt-bindings: PCI: qcom,pcie-sm8550: move SM8550 to dedicated schema
>       dt-bindings: PCI: qcom,pcie-sm8450: move SM8450 to dedicated schema
>       dt-bindings: PCI: qcom,pcie-sm8250: move SM8250 to dedicated schema
>       dt-bindings: PCI: qcom,pcie-sm8150: move SM8150 to dedicated schema
>       dt-bindings: PCI: qcom,pcie-sm8350: move SM8350 to dedicated schema
>       dt-bindings: PCI: qcom,pcie-sc8280xp: move SC8280XP to dedicated schema
> 
>  .../devicetree/bindings/pci/qcom,pcie-common.yaml  |  98 ++++++++
>  .../bindings/pci/qcom,pcie-sc8280xp.yaml           | 180 ++++++++++++++
>  .../devicetree/bindings/pci/qcom,pcie-sm8150.yaml  | 157 ++++++++++++
>  .../devicetree/bindings/pci/qcom,pcie-sm8250.yaml  | 180 ++++++++++++++
>  .../devicetree/bindings/pci/qcom,pcie-sm8350.yaml  | 169 +++++++++++++
>  .../devicetree/bindings/pci/qcom,pcie-sm8450.yaml  | 215 +++++++++++++++++
>  .../devicetree/bindings/pci/qcom,pcie-sm8550.yaml  | 171 +++++++++++++
>  .../devicetree/bindings/pci/qcom,pcie.yaml         | 268 ---------------------
>  8 files changed, 1170 insertions(+), 268 deletions(-)
> ---
> base-commit: a0bf076e449e022944b440174491f5c583753d84
> change-id: 20240108-dt-bindings-pci-qcom-split-624737f7ba67
> 
> Best regards,
> -- 
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 

-- 
மணிவண்ணன் சதாசிவம்

