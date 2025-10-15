Return-Path: <linux-pci+bounces-38214-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF56BDE858
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 14:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DE9485007F8
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 12:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3879D1B4224;
	Wed, 15 Oct 2025 12:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXIRVnnX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0860B39FCE;
	Wed, 15 Oct 2025 12:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760532238; cv=none; b=r1Sv9pgwrowy9fCaEs1KPtOhut0dRC6QHpwvtA4W03DhMTt0MLo+VuvcrWmK9b9BMg34iRv86roj8CT520bxJHSriueNzp6zv9Llf0VgHeKFUWqhI7CX+gEeBy4CbV9pPI/LSeZiSu0Yoy2YHjApJzLsH2Q89Z66mxfy9EvKtrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760532238; c=relaxed/simple;
	bh=Rv/WTcy0mNMm+uRot/GU/7Fbs+K4qxalPuCtaq1ElJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m6dIR5sTC6nhZwmFzxn+DIN/vkSf/tmDyWr81zvrzcfsD/S8QwsVTdmj2TSs63+r7yCSz1c0x9nSirKQN13zImeeEF+Is4sdoi5FcXLLdneKt6yIrQ/mIMMXNojGW/SBJ/JeXPGf4mproRV+awYl/v1rt37gGb72lwIDo3uk57M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXIRVnnX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5362DC4CEF8;
	Wed, 15 Oct 2025 12:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760532237;
	bh=Rv/WTcy0mNMm+uRot/GU/7Fbs+K4qxalPuCtaq1ElJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aXIRVnnX1DKzvIv1B6Y3BFLJbfCl+l7UBPd4iL2xwtSnN+cZL6OtcgShLadRkxhuK
	 CPemmyAY+8iEQiMjSq0J64kBB2mJTgtuKkDF1MbRZAfmyJGpAT2CcyMUnaPBFlVnG8
	 +RnWbNmsHeX3KAnSbxy2xUWIXly6N5NuddQAkm7w0qWHxdDfiOOqkuppPuS70weaIT
	 UTk5zxeRhYiMKl8gKtgC7R4myMQBofR2hCp8CDo9ldjljHX66+Poifj02PoPPjaYVe
	 nkZbTG74SRlPUeyhg3r70EAAp3vzy60TvuIyp+KkqMo3VAhWjdyNX52JuIQhC9tmWE
	 I0oQiebGdts3Q==
Date: Wed, 15 Oct 2025 07:43:55 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Abraham I <kishon@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: PCI: Update the email address for
 Manivannan Sadhasivam
Message-ID: <176053223303.3202616.6553332621383327286.robh@kernel.org>
References: <20251010-pci-binding-v1-0-947c004b5699@oss.qualcomm.com>
 <20251010-pci-binding-v1-1-947c004b5699@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010-pci-binding-v1-1-947c004b5699@oss.qualcomm.com>


On Fri, 10 Oct 2025 11:25:47 -0700, Manivannan Sadhasivam wrote:
> My linaro email id is no longer active. So switch to kernel.org one.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/pci/pci-ep.yaml             | 2 +-
>  Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml   | 2 +-
>  Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml       | 2 +-
>  Documentation/devicetree/bindings/pci/qcom,pcie-sa8255p.yaml  | 2 +-
>  Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml  | 2 +-
>  Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml   | 2 +-
>  Documentation/devicetree/bindings/pci/qcom,pcie-sc8180x.yaml  | 2 +-
>  Documentation/devicetree/bindings/pci/qcom,pcie-sc8280xp.yaml | 2 +-
>  Documentation/devicetree/bindings/pci/qcom,pcie-sm8150.yaml   | 2 +-
>  Documentation/devicetree/bindings/pci/qcom,pcie-sm8250.yaml   | 2 +-
>  Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml   | 2 +-
>  Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml   | 2 +-
>  Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml   | 2 +-
>  Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml | 2 +-
>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml          | 2 +-
>  15 files changed, 15 insertions(+), 15 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


