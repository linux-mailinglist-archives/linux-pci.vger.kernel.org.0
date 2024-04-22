Return-Path: <linux-pci+bounces-6519-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D858ACFCE
	for <lists+linux-pci@lfdr.de>; Mon, 22 Apr 2024 16:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A141281754
	for <lists+linux-pci@lfdr.de>; Mon, 22 Apr 2024 14:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9C415217C;
	Mon, 22 Apr 2024 14:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lhu3AVpL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57001514F2
	for <linux-pci@vger.kernel.org>; Mon, 22 Apr 2024 14:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713797084; cv=none; b=oNUO02KRn/TzUbUkCSIhacudCUMhEd2yjoj3s3V741L681fTcek6PWJS3drils4YnPpcWsfqJ+7LprxtyCRao40LP/8fYFQ/fmNmuk8f6u/jGiTGcwhwUQSc98NO0kC8df3+NjVaqHIorpZF7MRt1V7IUDEDv2N4OdDr4mNq7Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713797084; c=relaxed/simple;
	bh=uWsKl1wAe7kVcGq6U6naQwvSk15aE/AV9VCmlH9NuAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uP+RZ4dBIyZ4e+OB8ixB0zCA8hQwZNiT6LJ7nNa7v+ew6vDvmwPSve7RvFIpYJdeGqTlGuDOkCF9sliUgTnCt5c83/XmikSiJ58E25NmnFyy+SdCpmpWJPpV7YuuYascV8OUAZ6kAjzlklHxvOSf2pJ3fHiHQ4DfttBHre9Dlpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lhu3AVpL; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e2c725e234so41585155ad.1
        for <linux-pci@vger.kernel.org>; Mon, 22 Apr 2024 07:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713797082; x=1714401882; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LVRNChhXa7FZ9k90/6TDVi7/XDV6ST4jrfTPlduROb4=;
        b=lhu3AVpLMOqAeeqq2ozi6/Puu3pZhvDMoarqfG2GKHmJuzNQ30EBCebevlcCVbmFGF
         O3rz7Jq9sykVtDQ9C6ZfdJjEmZvm7LqROI+HDMhgce0EwXZd4prynwGlI99qK/ZniTG/
         caRVrpqM6kLWBZbzWGDnsYf4rvFzazcjCUtMQ9iJu8giUISVtfRHAhNlhNQaU6IiNzVE
         dD3Qp64WAli3yVKgzAienVIfX+STTTo9hbxKJ1GpLBKteESvBoNz38NU5NSvgm1Nvpcj
         njle/hkn3TH0Ziyjl9eP25HGYXre6qkYTxL0BhDpPYu8YnbKmP5ekrr2YBaMEmRXwfPu
         zFCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713797082; x=1714401882;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LVRNChhXa7FZ9k90/6TDVi7/XDV6ST4jrfTPlduROb4=;
        b=c2mZsVLlytOgJfgEGM9Dth2QI8MDnWrLn9uSxbRrEel0QCa4aweAgX3crlISKejP0g
         PxINOGAQjAa+ZkN++pui9xUFzCPRqSbsYW8+7DWicL2feQxAxZgS3ExpMBjWdXCJ+qL7
         sriDVJEWeWi7/TuFhkNkCwA5juS5cAxzks6QV2VVZkiCN/XRyXk+wstiDOpMROw0/ETU
         mj0vpQyaFfkQxSlKN/8U9j6fZNlygkT3uGPbVoHAtToK5924EBud0GzUtzdX78KN05VJ
         mgupTFQajBudW24ItpT59u4JIbH/Y4ECk8G/kcUeuHELrqUO8q60ks/wcsxi6w/oK4Mb
         R25g==
X-Forwarded-Encrypted: i=1; AJvYcCXY4ekpZcDtP1nkK5dJ/qhGdfZdwYPcE5axgYCeIHmvrDjEHDwuTTV0N+hbN8YmB7Tro5MiavGdCBIqq/Y8a60SMXXABE+MOCj9
X-Gm-Message-State: AOJu0Yw8TTYTuqaw/H35r3Zc3G60UZVytPiDlUCXNH9+M1o4jIqf/1ye
	Ke47zJM77HJDFQS7+Ig6WXD0F7BscpjiByg7xa19fiYG1DEt3wcVCxcDTAmzrw==
X-Google-Smtp-Source: AGHT+IG6t5wD268CJ9WM36yr69Ky8Cqce1xxt3gCjMhfQP8IBUnGiHqPiYx8GUUBwnRLDr0gdFewlg==
X-Received: by 2002:a17:903:2308:b0:1ea:147:d4fd with SMTP id d8-20020a170903230800b001ea0147d4fdmr243785plh.32.1713797081973;
        Mon, 22 Apr 2024 07:44:41 -0700 (PDT)
Received: from thinkpad ([120.60.70.118])
        by smtp.gmail.com with ESMTPSA id w19-20020a170902c79300b001e0c956f0dcsm8215015pla.213.2024.04.22.07.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 07:44:41 -0700 (PDT)
Date: Mon, 22 Apr 2024 20:14:31 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>, johan+linaro@kernel.org,
	bmasney@redhat.com, djakov@kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	vireshk@kernel.org, quic_vbadigan@quicinc.com,
	quic_skananth@quicinc.com, quic_nitegupt@quicinc.com,
	quic_parass@quicinc.com, krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH v10 4/6] arm64: dts: qcom: sm8450: Add OPP table support
 to PCIe
Message-ID: <20240422144431.GE9775@thinkpad>
References: <20240409-opp_support-v10-0-1956e6be343f@quicinc.com>
 <20240409-opp_support-v10-4-1956e6be343f@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240409-opp_support-v10-4-1956e6be343f@quicinc.com>

On Tue, Apr 09, 2024 at 03:43:22PM +0530, Krishna chaitanya chundru wrote:
> PCIe needs to choose the appropriate performance state of RPMh power

'PCIe host controller driver'

> domain and interconnect bandwidth based up on the PCIe data rate.

'based on the PCIe data rate'

> 
> Add the OPP table support to specify RPMh performance states and

'Hence, add...'

> interconnect peak bandwidth.
> 
> Different link configurations may share the same aggregate bandwidth,

'It should be noted that the different...'

> e.g., a 2.5 GT/s x2 link and a 5.0 GT/s x1 link have the same bandwidth
> and share the same OPP entry.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8450.dtsi | 77 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 615296e13c43..9dfe16012726 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -1855,7 +1855,35 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
>  			pinctrl-names = "default";
>  			pinctrl-0 = <&pcie0_default_state>;
>  
> +			operating-points-v2 = <&pcie0_opp_table>;
> +
>  			status = "disabled";
> +
> +			pcie0_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				/* GEN 1 x1 */
> +				opp-2500000 {
> +					opp-hz = /bits/ 64 <2500000>;
> +					required-opps = <&rpmhpd_opp_low_svs>;
> +					opp-peak-kBps = <250000 1>;
> +				};
> +
> +				/* GEN 2 x1 */
> +				opp-5000000 {
> +					opp-hz = /bits/ 64 <5000000>;
> +					required-opps = <&rpmhpd_opp_low_svs>;
> +					opp-peak-kBps = <500000 1>;
> +				};
> +
> +				/* GEN 3 x1 */
> +				opp-8000000 {
> +					opp-hz = /bits/ 64 <8000000>;

I doubt this value. See below...

> +					required-opps = <&rpmhpd_opp_nom>;
> +					opp-peak-kBps = <984500 1>;
> +				};
> +			};
> +
>  		};
>  
>  		pcie0_phy: phy@1c06000 {
> @@ -1982,7 +2010,56 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
>  			pinctrl-names = "default";
>  			pinctrl-0 = <&pcie1_default_state>;
>  
> +			operating-points-v2 = <&pcie1_opp_table>;
> +
>  			status = "disabled";
> +
> +			pcie1_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				/* GEN 1 x1 */
> +				opp-2500000 {
> +					opp-hz = /bits/ 64 <2500000>;
> +					required-opps = <&rpmhpd_opp_low_svs>;
> +					opp-peak-kBps = <250000 1>;
> +				};
> +
> +				/* GEN 1 x2 GEN 2 x1 */
> +				opp-5000000 {
> +					opp-hz = /bits/ 64 <5000000>;
> +					required-opps = <&rpmhpd_opp_low_svs>;
> +					opp-peak-kBps = <500000 1>;
> +				};
> +
> +				/* GEN 2 x2 */
> +				opp-10000000 {
> +					opp-hz = /bits/ 64 <10000000>;
> +					required-opps = <&rpmhpd_opp_low_svs>;
> +					opp-peak-kBps = <1000000 1>;
> +				};
> +
> +				/* GEN 3 x1 */
> +				opp-8000000 {
> +					opp-hz = /bits/ 64 <8000000>;

GEN 3 x1 frequency is lower than GEN 2 x2? This looks strange. Both should be of
same frequency.

> +					required-opps = <&rpmhpd_opp_nom>;
> +					opp-peak-kBps = <984500 1>;
> +				};
> +
> +				/* GEN 3 x2 GEN 4 x1 */

'GEN 3 x2 and GEN 4 x1'

- Mani

-- 
மணிவண்ணன் சதாசிவம்

