Return-Path: <linux-pci+bounces-2844-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B08B84305F
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 23:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7F422864DD
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 22:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9337EEF9;
	Tue, 30 Jan 2024 22:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOhvN486"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4467EEF0;
	Tue, 30 Jan 2024 22:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706654959; cv=none; b=MvSAXSWiFvo0qHK7XMOVNzR3eTEWKNblHPx3052U8qfPFt/Xty1PG67scgn21bLh8QTvsWCTPIGF/lclvgGpy2ugtpgDlyiiliR8kCV034IR/4R947uxpFzVw91yvuVP1gBoE3x08NyPHedPZ2zcX/8fCQsviKJUKYI6Cu+riSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706654959; c=relaxed/simple;
	bh=wufVf89FBbzS40Tb6P4wB9pAf1/vCzzKTz/PUGrNOOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0VQnIpuYJR/cpSFOXOw2eWe19iIBVVUF7XVRGD3Kt8O6q67fgsm1WkqXnaBIFZ23vJIM9siC/sgntuC6ODeHxFehYlTDMG8XlPAXPa9IhfOVjFNFgKPGTtHliWcNCFJUcjHWs1XIoq+CZlOd4iG6xeKDxnYVGC4uLCrGSIAJsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOhvN486; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B819C43609;
	Tue, 30 Jan 2024 22:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706654958;
	bh=wufVf89FBbzS40Tb6P4wB9pAf1/vCzzKTz/PUGrNOOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HOhvN486y0a/3xne7IsJWEF7CeoRX77RnR3Dx3MJdiE7VL/6u3AIMO4eccU+ynXD4
	 tgYUf3CqzW1AsELFoZZHcnN3rz+WCTf5PgJ4aLpcbZHlhf0xQjHXhhuFxIAjcDFVMf
	 L+/owbQhxjOYe7VVsA0g+qSFMZO76FkCzC/iPGL6LdCDM0si2lvv7+1qPmx/UaA7E6
	 Ot43ABSiL0fAUOsAcUHii61348ZDmRRsDseQ0devbHHRuDVQtfsv3AUd/BMnG/oNdH
	 NW7hgPRqlQ0DM7v6BCykMDla7uyCtVyLU+hhWXLjefgDlMWlmnIf8mq18e8Df9ltVd
	 8vSHsobSy6NLA==
Date: Tue, 30 Jan 2024 16:49:15 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>, devicetree@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3 2/6] dt-bindings: PCI: qcom,pcie-sm8450: move SM8450
 to dedicated schema
Message-ID: <170665495522.2559069.14002850909301395083.robh@kernel.org>
References: <20240126-dt-bindings-pci-qcom-split-v3-0-f23cda4d74c0@linaro.org>
 <20240126-dt-bindings-pci-qcom-split-v3-2-f23cda4d74c0@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126-dt-bindings-pci-qcom-split-v3-2-f23cda4d74c0@linaro.org>


On Fri, 26 Jan 2024 09:56:43 +0100, Krzysztof Kozlowski wrote:
> Move SM8450 PCIe devices from qcom,pcie.yaml binding to a dedicated file
> to make reviewing easier.
> 
> This creates equivalent schema file, except:
>  - Missing required compatible which is actually redundant.
>  - Expecting eight MSI interrupts, instead of only one, which was
>    incomplete hardware description.
> 
> Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie-sm8450.yaml  | 178 +++++++++++++++++++++
>  .../devicetree/bindings/pci/qcom,pcie.yaml         |  67 --------
>  2 files changed, 178 insertions(+), 67 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


