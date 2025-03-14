Return-Path: <linux-pci+bounces-23718-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D3EA60AFE
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 09:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0DF13A37BD
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 08:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B72198E7B;
	Fri, 14 Mar 2025 08:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGVfFVhK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D4B17557C;
	Fri, 14 Mar 2025 08:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741940118; cv=none; b=LpaVxtcWeqvN9Q71d8HzvuDP6cAfK3CMTMTJC2SoooOUwdv+J/CkCk/D3YuhAGRv5GYE28QOY9/YuYUDEYEujRTPWiDHfXy7opYjEq+P+pReLMFRilULdHeNirYPUY8FwxEiPJ763dzhB6bzpcsnCzMZiobmu4rlloqXGUz97ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741940118; c=relaxed/simple;
	bh=c7ABCEaXzhXf2ga+O2xCrbFV5cHGA14uEMNM19s30iE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5zf24LOMnVyvzOttrVzab9/GrE/FI1MWNfkPhfwx/K4OILNyenSJV9LhfvohuXn5nJ77NFxWtMmxhV8xdr0z7nnBAMgGzP7b7ZAcbgbAXY6n9zgulhaED6PtHe795xnsJ/MW6XPt/r2+hafCtjRGYfF5ojl3/t1277Nf2oFAX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGVfFVhK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D543C4CEE3;
	Fri, 14 Mar 2025 08:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741940117;
	bh=c7ABCEaXzhXf2ga+O2xCrbFV5cHGA14uEMNM19s30iE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iGVfFVhK+WLUZG7BUB+ebQBe+trOCgECkGqgrujM2C+YvwxVLrLF4iKC64cNVEkjw
	 +zzYnJPAs8XrBuAlpNZpk2uQAs0Tlfnlj+vGSbhqM/Z7qhN1aSX9O4jHhyiQFqHHbl
	 3fAOL9wV2m/Kojtgb0nFkodCOCtkwGiuXfTBHjCpVlf/yWn2b46IHF8BVUiQGHxad4
	 EcIq7BnVz9ZjrmiWEgG4AB/Lx+7+qcn9v7VD8KKaqbZPuEMIt5g8dh4rVMzl2cHae+
	 hYmD9/pjVlCDuIJqc4X6FjAT+qtKG5AqyGsnBIvK6y2QUFHZgoLJFiI8Fbgv4lAM/6
	 NiNH0xzDFzcvw==
Date: Fri, 14 Mar 2025 09:15:13 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: George Moussalem <george.moussalem@outlook.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org, andersson@kernel.org, 
	bhelgaas@google.com, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	lumag@kernel.org, kishon@kernel.org, konradybcio@kernel.org, krzk+dt@kernel.org, 
	kw@linux.com, lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org, 
	p.zabel@pengutronix.de, quic_nsekar@quicinc.com, robh@kernel.org, robimarko@gmail.com, 
	vkoul@kernel.org, quic_srichara@quicinc.com
Subject: Re: [PATCH v4 1/6] dt-bindings: phy: qcom: uniphy-pcie: Add ipq5018
 compatible
Message-ID: <20250314-hypersonic-starfish-of-sunshine-75f8fb@krzk-bin>
References: <DS7PR19MB8883F2538AA7D047E13C102B9DD22@DS7PR19MB8883.namprd19.prod.outlook.com>
 <DS7PR19MB88835F541CBC60C97A818B3A9DD22@DS7PR19MB8883.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DS7PR19MB88835F541CBC60C97A818B3A9DD22@DS7PR19MB8883.namprd19.prod.outlook.com>

On Fri, Mar 14, 2025 at 09:56:39AM +0400, George Moussalem wrote:
> From: Nitheesh Sekar <quic_nsekar@quicinc.com>
> 
> The IPQ5018 SoC contains a Gen2 1 and 2-lane PCIe UNIPHY which is the
> same as the one found in IPQ5332. As such, add IPQ5018 compatible.
> 
> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---
>  .../devicetree/bindings/phy/qcom,ipq5332-uniphy-pcie-phy.yaml  | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


