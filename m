Return-Path: <linux-pci+bounces-34705-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D178B353A6
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 07:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6089F1892746
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 05:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10DB2F39C8;
	Tue, 26 Aug 2025 05:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ln9gUA1G"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF042EF64A;
	Tue, 26 Aug 2025 05:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756187848; cv=none; b=Zp9YdvavQm4ZBJ1Gu1Jq4cRX9Watz4M/M0Ktk9IUxaA6GWfoamuPZjJYChLDvFQrooV4KJKoFtsRz0/bMJHXDhMeW5C1RufMokuqsk8jEAfUb3J4OsQ9hj9aXaavubjeQA5iqSfEHlHA+NRENupIZuAeOv5qtPMU78A5OH0zyug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756187848; c=relaxed/simple;
	bh=kKNH8NUIKhO94RwCUn5nWlFEWU6qfkkFMbDLyS0gX0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ri4XUoBaWJCZEHICFjYiWzDyfE1meuCFLqge7VzE5vUT1U4TqwcXEygyXw5OL0P0bYPIgoY7MpL6yyjzQPOezElZXo4//+yp7xRsIT8TbdIxnyu4Gkj+AGdFm01pchIo1px7pEbwlK7EKZ3SLsMzj1249nwbgnaQnrPi+5Kk+Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ln9gUA1G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC04AC4CEF1;
	Tue, 26 Aug 2025 05:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756187847;
	bh=kKNH8NUIKhO94RwCUn5nWlFEWU6qfkkFMbDLyS0gX0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ln9gUA1G06fZktO8IE1FEsVV3ABrBpoEvWvmBLz2mWUJIu1k7gwHVtEwna4XoA9g/
	 V9EpMnEOF8H7QyGHxgr7eck3KTr0lYbav+9YwjJcGdeh6iohVzfUJXhT0GRMOy+ejc
	 g2AXVc0668NFypwEHhVGnGoKy1/YUvMgkVVFWbymrUN713HNWZRQznBlNm5Fr6Oqn/
	 FBPmpKrvsoieRxEuuQp9lu4V6vKNEjYYUw9gfxFAAjRYufUivmMOVvpGl0aXwwSw56
	 YBVmEvDnkFgoFQ9WvB4hI8B64Bh4pcP00U3D40cGQvgZ/iVvL853IvAFxLDja/ht70
	 aqNFoO4SZ4OaQ==
Date: Tue, 26 Aug 2025 11:27:11 +0530
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
Message-ID: <6nwss6gl3d47zer4pai23xcu4weok7m3ptyuptvu5oli7u7ads@zzhbw67hnhz5>
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

First define the problem statement of why this change is needed. You've
mentioned it in the cover letter, but that won't be preserved in git history.
Then you need to justify the change and make it clear that *this* platform
doesn't suffer the issue but you are doing it for the unification.

This needs to be done for all DTS patches.

- Mani

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
> @@ -2059,6 +2060,7 @@ opp-5000000 {
>  					opp-hz = /bits/ 64 <5000000>;
>  					required-opps = <&rpmhpd_opp_low_svs>;
>  					opp-peak-kBps = <500000 1>;
> +					opp-level = <2>;
>  				};
>  
>  				/* GEN 3 x1 */
> @@ -2066,6 +2068,7 @@ opp-8000000 {
>  					opp-hz = /bits/ 64 <8000000>;
>  					required-opps = <&rpmhpd_opp_nom>;
>  					opp-peak-kBps = <984500 1>;
> +					opp-level = <3>;
>  				};
>  			};
>  
> @@ -2210,45 +2213,67 @@ pcie1_opp_table: opp-table {
>  				compatible = "operating-points-v2";
>  
>  				/* GEN 1 x1 */
> -				opp-2500000 {
> +				opp-2500000-1 {
>  					opp-hz = /bits/ 64 <2500000>;
>  					required-opps = <&rpmhpd_opp_low_svs>;
>  					opp-peak-kBps = <250000 1>;
> +					opp-level = <1>;
>  				};
>  
> -				/* GEN 1 x2 and GEN 2 x1 */
> -				opp-5000000 {
> +				/* GEN 1 x2 */
> +				opp-5000000-1 {
> +					opp-hz = /bits/ 64 <5000000>;
> +					required-opps = <&rpmhpd_opp_low_svs>;
> +					opp-peak-kBps = <500000 1>;
> +					opp-level = <1>;
> +				};
> +
> +				/* GEN 2 x1 */
> +				opp-5000000-2 {
>  					opp-hz = /bits/ 64 <5000000>;
>  					required-opps = <&rpmhpd_opp_low_svs>;
>  					opp-peak-kBps = <500000 1>;
> +					opp-level = <2>;
>  				};
>  
>  				/* GEN 2 x2 */
> -				opp-10000000 {
> +				opp-10000000-2 {
>  					opp-hz = /bits/ 64 <10000000>;
>  					required-opps = <&rpmhpd_opp_low_svs>;
>  					opp-peak-kBps = <1000000 1>;
> +					opp-level = <2>;
>  				};
>  
>  				/* GEN 3 x1 */
> -				opp-8000000 {
> +				opp-8000000-3 {
>  					opp-hz = /bits/ 64 <8000000>;
>  					required-opps = <&rpmhpd_opp_nom>;
>  					opp-peak-kBps = <984500 1>;
> +					opp-level = <3>;
> +				};
> +
> +				/* GEN 3 x2 */
> +				opp-16000000-3 {
> +					opp-hz = /bits/ 64 <16000000>;
> +					required-opps = <&rpmhpd_opp_nom>;
> +					opp-peak-kBps = <1969000 1>;
> +					opp-level = <3>;
>  				};
>  
> -				/* GEN 3 x2 and GEN 4 x1 */
> -				opp-16000000 {
> +				/* GEN 4 x1 */
> +				opp-16000000-4 {
>  					opp-hz = /bits/ 64 <16000000>;
>  					required-opps = <&rpmhpd_opp_nom>;
>  					opp-peak-kBps = <1969000 1>;
> +					opp-level = <4>;
>  				};
>  
>  				/* GEN 4 x2 */
> -				opp-32000000 {
> +				opp-32000000-4 {
>  					opp-hz = /bits/ 64 <32000000>;
>  					required-opps = <&rpmhpd_opp_nom>;
>  					opp-peak-kBps = <3938000 1>;
> +					opp-level = <4>;
>  				};
>  			};
>  
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

