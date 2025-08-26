Return-Path: <linux-pci+bounces-34712-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1581B353D4
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 08:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7648A1785CB
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 06:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8682F4A00;
	Tue, 26 Aug 2025 06:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqEpZ9c2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CC2393DD1;
	Tue, 26 Aug 2025 06:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756188556; cv=none; b=gsEcaDfIb4UT6a4FrsFOPfZKPKq5Y/GqjGH2oypS9Sd0X9qHrb2uO2yM/WdJb4ncBmDeB+gafC1B/1KkWk6rjhV9Cw7dpcaX/acpxB3aJjUdkERO0wIBNz2Sz77EZQrDi1OZd7O/nacUCh/jYF4jBMExUhip2dX5qo3jmTflZA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756188556; c=relaxed/simple;
	bh=Y1YfOik/jH8XSk9AjKAd3bp1YMLIvNt8r+PVdKv4L6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bh3X5C5cX4Oxsh/gSJnL9y7/nDB4v/0zXHDaFjLxSDsJEa3SvnmJ/Q4JZiy4gHLmHVh516wSYlNdk7lwMsnVOy91/rkJEJP7u5LnkXFjC17XSeDd9yeInL6eFNE0/rz4O0Rk194p3SZES/E+sE8gg1CPNRzfduwS5v2TxFti4xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WqEpZ9c2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F5AC116B1;
	Tue, 26 Aug 2025 06:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756188555;
	bh=Y1YfOik/jH8XSk9AjKAd3bp1YMLIvNt8r+PVdKv4L6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WqEpZ9c2/4LH3UZfwZHdaOlGMVlccuh9VNiMHhtPNI5vJJLcVFMmcl4j8d2Zm8GR+
	 JedqBXMLIqdAJyxCIFF2byiJrLP6IhOGsGJjEx/Z0IwU53AdUw+LFm4duXxWNyOFuq
	 3P1i0uNG7o+8WSuV/fBbCb7/6S2NwUBokVPFQTof/7EsShGGHMzLF9D+40P+KFhutI
	 Li/WNBz8D/eIglUTSjUlLIapSELoLht2DK9lvAKRyLONLo15hMC+M/6b7apIR2mQWC
	 cIxLlQ4VqyeHFbqO0FGnnsqUG+xN1IN2mk6IaA0/2LufewaVuW/A9AzTNma9V50MFc
	 m3+keHMdqI4zw==
Date: Tue, 26 Aug 2025 11:38:58 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/7] arm64: dts: qcom: sm8450: Add opp-level to
 indicate PCIe data rates
Message-ID: <wjufmrbat2fpepln6yudyejfxkhb5ptcokpcknax3k5c75fuf3@sugwt7kmfafk>
References: <20250820-opp_pcie-v4-0-273b8944eed0@oss.qualcomm.com>
 <20250820-opp_pcie-v4-3-273b8944eed0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250820-opp_pcie-v4-3-273b8944eed0@oss.qualcomm.com>

On Wed, Aug 20, 2025 at 01:58:49PM GMT, Krishna Chaitanya Chundru wrote:
> Add opp-level to indicate PCIe data rates and also define OPP enteries
> for each link width and data rate. Append the opp level to name of the
> opp node to indicate both frequency and level.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8450.dtsi | 41 +++++++++++++++++++++++++++++-------
>  1 file changed, 33 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 33574ad706b915136546c7f92c7cd0b8a0d62b7e..d7f8706ca4949e253a4102474c92b393a345262f 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -2052,6 +2052,7 @@ opp-2500000 {
>  					opp-hz = /bits/ 64 <2500000>;
>  					required-opps = <&rpmhpd_opp_low_svs>;
>  					opp-peak-kBps = <250000 1>;
> +					opp-level = <1>;
>  				};
>  
>  				/* GEN 2 x1 */

While you are doing the change, please use data rate instead of 'GEN' to align
with the spec. Like,
				/* 5 GT/s x1 */

- Mani

-- 
மணிவண்ணன் சதாசிவம்

