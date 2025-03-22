Return-Path: <linux-pci+bounces-24445-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6943DA6CC27
	for <lists+linux-pci@lfdr.de>; Sat, 22 Mar 2025 21:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A28F13A8AD2
	for <lists+linux-pci@lfdr.de>; Sat, 22 Mar 2025 20:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C029C1D63E4;
	Sat, 22 Mar 2025 20:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EtX7M70j"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1664C6C;
	Sat, 22 Mar 2025 20:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742674579; cv=none; b=k/J929wVUDl4hq8FoJJ8thSB+pIx+TrsvhPfiDhO5IehdtnxbWhSunEND8wF32nXKEE4G/lbE9XzyoETwUoeW+/aXh2QY+i521jDHeGwQHFWeZstzHcdeckJVlAbZJfwMb87eRVTRnEdHZI2OdV05YCZgAjXz/Toc35OmQieoIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742674579; c=relaxed/simple;
	bh=wG6yAeIvUo6cSeHVafODK9l9ixZ9Z1WMTlZDD5+ozSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9YzDAd3Q4jrF8rzN19OnuR/sj6646qsbd6ntmuq0kODHn8ba3sIn2CVl3QREk+wBaMM2PBojwrMLWqhpc1ZjEPNtgjrcNaPYvGYEGq2gP88X2ZkolhXpdBaVcS8mVEJycMMYklBdb6gigj/lVlcM/Hj7ClakKcfVFjQdKS7s9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EtX7M70j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD3A2C4CEDD;
	Sat, 22 Mar 2025 20:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742674574;
	bh=wG6yAeIvUo6cSeHVafODK9l9ixZ9Z1WMTlZDD5+ozSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EtX7M70jBfnFvZxZYHEHqcW1hrL/wSrQ2OerVfeABCqaRzjfX/lolndYDCTi+SExi
	 Gmkp+tgxoIPavEepxwiUTjh5AxJyaD53cpkrByFt0wIjVHvzfLdKmu2nFnYgJlgs4h
	 auauWj0I39DLdf04e9GLeL94RLYT8HNCO006oka5KrfxBYjH7LacCBbX1FpVl/Q2dN
	 CNMRC7S+R7MkMT+AdLuD7xyXUcKZRB3GuqVCaQfpix+MwcbHkB5JlM+MNXVW2ze1pU
	 bLAlYZFWAuzXjq+OyKO54fiZY1u1WOwsNy1Y8v9wGcOOsuX3w+ocSfEY5dxPA5iMEb
	 Kb3tCRaECrvfw==
Date: Sat, 22 Mar 2025 15:16:13 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: George Moussalem <george.moussalem@outlook.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sricharan Ramabadhran <quic_srichara@quicinc.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Nitheesh Sekar <quic_nsekar@quicinc.com>,
	Varadarajan Narayanan <quic_varada@quicinc.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Vinod Koul <vkoul@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	20250317100029.881286-2-quic_varada@quicinc.com,
	linux-kernel@vger.kernel.org,
	Kishon Vijay Abraham I <kishon@kernel.org>
Subject: Re: [PATCH v6 1/6] dt-bindings: phy: qcom: uniphy-pcie: Add ipq5018
 compatible
Message-ID: <174267455671.1906457.16602134107538739913.robh@kernel.org>
References: <20250321-ipq5018-pcie-v6-0-b7d659a76205@outlook.com>
 <20250321-ipq5018-pcie-v6-1-b7d659a76205@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321-ipq5018-pcie-v6-1-b7d659a76205@outlook.com>


On Fri, 21 Mar 2025 16:14:39 +0400, George Moussalem wrote:
> From: Nitheesh Sekar <quic_nsekar@quicinc.com>
> 
> The IPQ5018 SoC contains a Gen2 1 and 2-lane PCIe UNIPHY which is the
> same as the one found in IPQ5332. As such, add IPQ5018 compatible.
> 
> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---
>  .../bindings/phy/qcom,ipq5332-uniphy-pcie-phy.yaml | 49 ++++++++++++++++++----
>  1 file changed, 41 insertions(+), 8 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


