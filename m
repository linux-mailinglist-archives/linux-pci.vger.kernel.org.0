Return-Path: <linux-pci+bounces-18386-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA21B9F1045
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 16:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BF4C2842FC
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 15:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5561E0B67;
	Fri, 13 Dec 2024 15:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ml2h24Nr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CF419F40E
	for <linux-pci@vger.kernel.org>; Fri, 13 Dec 2024 15:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734102427; cv=none; b=lkR0XrdiHlX2SPgQDmpIGGDPku0Eyk/yRnDNBQUW5W0PPjKMMZmfKcIdVfvBnvNtxHEJBSDVE2zVO+7lvUkC6rd5jDrGcAPTNBbpN6Ot7tEcKEW6g8ZlmLKSM2YvEtWXOoIG9a72Lo2Wpi5FuslaYmcWPVZH3EnFm3eyYNvETvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734102427; c=relaxed/simple;
	bh=LSopQMi+iD5+5VSVXyKVixm37tCFvIgTLJ870YoR6T8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zngm+3RS0IhWhmCxjtygWAak/lNuD0fUEQlmELtj3FWmkTbWn/uENcXxZPjkgYUqLihMGiKrerBw6w/JpmQiKbyhQPNZyX9Ut3skn+0FP0NrqtmmhVejnFVUVoYbXLyxX3lXQUB9KWVLigIvangJm0Lyo4kpfEUawqEGUR0fy+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ml2h24Nr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDA3xB3013192
	for <linux-pci@vger.kernel.org>; Fri, 13 Dec 2024 15:07:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	95sMhGv8JzId9Jkjd/s1AKc37jB1S5fUjQhHk6lxW9w=; b=Ml2h24Nr0x9cz3x2
	UnO7eDH5Ar/+Q5FpHmHLR4siyOf899HRx/MV0TtE2rxERBLz25CP2R0bGc8fY9Ug
	ZFDuOYFudCycE46doqAfsuNvfgeKgfWkKNgvvL19z5qe55rQ9oASHSsgPYtDLq4S
	zZ3y+4xZXjtVIjnmWsGavTPrGAT8eVXdVMv2TYwTHi47hMSn8G1te+XveosFrm3e
	k3Io0mFJjHUKlddCds9XZQwbGaTSRKni3Hp63fAxYQmJ6FrSMFQ2KV9n12NTkcmY
	CaljqLDFar3qGG9uS2GB6ogwX7Av3e8kwUeZkloAIUoJO3XD6jErJdCBOCnFWPqO
	tHdohQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43gjudgueb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 13 Dec 2024 15:07:04 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6d8824c96cdso5032716d6.2
        for <linux-pci@vger.kernel.org>; Fri, 13 Dec 2024 07:07:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734102424; x=1734707224;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=95sMhGv8JzId9Jkjd/s1AKc37jB1S5fUjQhHk6lxW9w=;
        b=vMAiMDzo+AD9rhI56vzTlpSqFQvSjGY28EtdlXBUQ4STG38wZOUY1d59CsnixD0762
         vSUBtWIrHDDtLTrlcx3ZE3EvoflGWL9NRG3v16UDt8kZR5XFQWIjW8cPEb6cJ7pJ10Ak
         HVC6o+UYHIN3EgOztAg+iAeWYUHVhTUA/t19hsiI19VGqxK1BWM+HFb8sLLVGwhs/gLX
         RbAY9Ke7iMOMeds8uDuEUA6CifBM+L/dV8mCJNZzdJjaOGRACm7EaX5iPZEchUUT0+de
         yhnHmiqbJnUIGEGktPbpW0NUykkZlIEBx3E1vVMQ04jEwvcvigmQxFRILCyQnH7CqQwI
         5Gsw==
X-Forwarded-Encrypted: i=1; AJvYcCXSJrAEaWAJ4VYlU7CtKhLn8FdCT+qmA94cb1IFTGiZe0saZr4Z9AODD3aP+ZNjwCw8dYhXsp+bIms=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT6c9Sm6dwjaHm30CcQAdqfLeLB7JzKpq7Ju27lkgnnCbhykav
	5ai5rSIR0M/Bu5FcNNlnmOezOMHKW/cbXsMqoRID/fzd2MtG4OLvXgBUyNkzQe60ReRJhJ1cYVf
	ZdCv5gVqn4Ks4XAjVr4C7rlo7upTuuvqTurK2Z7DfvzVJVj9191Sdg8GzPUc=
X-Gm-Gg: ASbGncvR44sZa4FBZ5RrPvpFPyqyiX4FAw71J6q9h7Ay3cZsY/b+4KJ4OlDQU8l4BS6
	4aA4fVnqGXMl7ym0RhyjTS84HlXx49CNIHCFMgWmNhfOXeTwNz/Jgl/xiKmRhdmPslCtj59irdV
	oK7TUYEHGhH+rezOPX4woLiRoh9KB8qh3ogzOs7gVykD74zH6/FuFBf1l+RZDsRhiFbpOuScGgQ
	oqRH6GeGQbGSAS7DDW5HDCVWE7R0f2gISaLgWB+JcqJVXAPgsiEzp741BKNSlAzz7ihOMHZjiM4
	8WmsOjX1iPAbcraff2QrnUbglHRKJQVPziF9
X-Received: by 2002:a05:620a:4714:b0:7b6:5e36:224c with SMTP id af79cd13be357-7b6fbec7893mr130159785a.3.1734102423778;
        Fri, 13 Dec 2024 07:07:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfUebqUqZS7Y8o9ZMXBvY3yYBIuA+QkiY22vXgsLp37i+bH8jWKJluwlAQE+Ir/r62U/7iFA==
X-Received: by 2002:a05:620a:4714:b0:7b6:5e36:224c with SMTP id af79cd13be357-7b6fbec7893mr130157085a.3.1734102423321;
        Fri, 13 Dec 2024 07:07:03 -0800 (PST)
Received: from [192.168.58.241] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6656f306csm913017466b.61.2024.12.13.07.07.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 07:07:02 -0800 (PST)
Message-ID: <69dffe54-939d-47c3-b951-4a4dea11eae0@oss.qualcomm.com>
Date: Fri, 13 Dec 2024 16:06:59 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: dts: qcom: ipq5424: Add PCIe PHYs and
 controller nodes
To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>, bhelgaas@google.com,
        lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        vkoul@kernel.org, kishon@kernel.org, andersson@kernel.org,
        konradybcio@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com
References: <20241213134950.234946-1-quic_mmanikan@quicinc.com>
 <20241213134950.234946-4-quic_mmanikan@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241213134950.234946-4-quic_mmanikan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: lhQzQhyRRVgZ87xsUIxiAIOoBsgZJsEp
X-Proofpoint-ORIG-GUID: lhQzQhyRRVgZ87xsUIxiAIOoBsgZJsEp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130107

On 13.12.2024 2:49 PM, Manikanta Mylavarapu wrote:
> Add PCIe0, PCIe1, PCIe2, PCIe3 (and corresponding PHY) devices
> found on IPQ5424 platform. The PCIe0 & PCIe1 are 1-lane Gen3
> host whereas PCIe2 & PCIe3 are 2-lane Gen3 host.
> 
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq5424.dtsi | 482 +++++++++++++++++++++++++-
>  1 file changed, 477 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq5424.dtsi b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
> index 5e219f900412..ade512bcb180 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5424.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
> @@ -9,6 +9,7 @@
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/clock/qcom,ipq5424-gcc.h>
>  #include <dt-bindings/reset/qcom,ipq5424-gcc.h>
> +#include <dt-bindings/interconnect/qcom,ipq5424.h>
>  #include <dt-bindings/gpio/gpio.h>
>  
>  / {
> @@ -143,7 +144,99 @@ soc@0 {
>  		compatible = "simple-bus";
>  		#address-cells = <2>;
>  		#size-cells = <2>;
> -		ranges = <0 0 0 0 0x10 0>;
> +		ranges = <0 0 0 0 0x0 0xffffffff>;

This must be a separate change, with a clear explanation

> +
> +		pcie0_phy: phy@84000 {
> +			compatible = "qcom,ipq5424-qmp-gen3x1-pcie-phy",
> +				     "qcom,ipq9574-qmp-gen3x1-pcie-phy";
> +			reg = <0 0x00084000 0 0x2000>;
> +			clocks = <&gcc GCC_PCIE0_AUX_CLK>,
> +				 <&gcc GCC_PCIE0_AHB_CLK>,
> +				 <&gcc GCC_PCIE0_PIPE_CLK>;
> +			clock-names = "aux", "cfg_ahb", "pipe";
> +
> +			assigned-clocks = <&gcc GCC_PCIE0_AUX_CLK>;
> +			assigned-clock-rates = <20000000>;
> +
> +			resets = <&gcc GCC_PCIE0_PHY_BCR>,
> +				 <&gcc GCC_PCIE0PHY_PHY_BCR>;
> +			reset-names = "phy", "common";
> +
> +			#clock-cells = <0>;
> +			clock-output-names = "gcc_pcie0_pipe_clk_src";
> +
> +			#phy-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		pcie1_phy: phy@8c000 {
> +			compatible = "qcom,ipq5424-qmp-gen3x1-pcie-phy",
> +				     "qcom,ipq9574-qmp-gen3x1-pcie-phy";
> +			reg = <0 0x0008c000 0 0x2000>;
> +			clocks = <&gcc GCC_PCIE1_AUX_CLK>,
> +				 <&gcc GCC_PCIE1_AHB_CLK>,
> +				 <&gcc GCC_PCIE1_PIPE_CLK>;
> +			clock-names = "aux", "cfg_ahb", "pipe";
> +
> +			assigned-clocks = <&gcc GCC_PCIE1_AUX_CLK>;
> +			assigned-clock-rates = <20000000>;
> +
> +			resets = <&gcc GCC_PCIE1_PHY_BCR>,
> +				 <&gcc GCC_PCIE1PHY_PHY_BCR>;
> +			reset-names = "phy", "common";
> +
> +			#clock-cells = <0>;
> +			clock-output-names = "gcc_pcie1_pipe_clk_src";
> +
> +			#phy-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		pcie2_phy: phy@f4000 {
> +			compatible = "qcom,ipq5424-qmp-gen3x2-pcie-phy",
> +				     "qcom,ipq9574-qmp-gen3x2-pcie-phy";
> +			reg = <0 0x000f4000 0 0x2000>;
> +			clocks = <&gcc GCC_PCIE2_AUX_CLK>,
> +				 <&gcc GCC_PCIE2_AHB_CLK>,
> +				 <&gcc GCC_PCIE2_PIPE_CLK>;
> +			clock-names = "aux", "cfg_ahb", "pipe";
> +
> +			assigned-clocks = <&gcc GCC_PCIE2_AUX_CLK>;
> +			assigned-clock-rates = <20000000>;
> +
> +			resets = <&gcc GCC_PCIE2_PHY_BCR>,
> +				 <&gcc GCC_PCIE2PHY_PHY_BCR>;
> +			reset-names = "phy", "common";
> +
> +			#clock-cells = <0>;
> +			clock-output-names = "gcc_pcie2_pipe_clk_src";
> +
> +			#phy-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		pcie3_phy: phy@fc000 {
> +			compatible = "qcom,ipq5424-qmp-gen3x2-pcie-phy",
> +				     "qcom,ipq9574-qmp-gen3x2-pcie-phy";
> +			reg = <0 0x000fc000 0 0x2000>;
> +			clocks = <&gcc GCC_PCIE3_AUX_CLK>,
> +				 <&gcc GCC_PCIE3_AHB_CLK>,
> +				 <&gcc GCC_PCIE3_PIPE_CLK>;
> +			clock-names = "aux", "cfg_ahb", "pipe";
> +
> +			assigned-clocks = <&gcc GCC_PCIE3_AUX_CLK>;
> +			assigned-clock-rates = <20000000>;
> +
> +			resets = <&gcc GCC_PCIE3_PHY_BCR>,
> +				 <&gcc GCC_PCIE3PHY_PHY_BCR>;
> +			reset-names = "phy", "common";
> +
> +			#clock-cells = <0>;
> +			clock-output-names = "gcc_pcie3_pipe_clk_src";
> +
> +			#phy-cells = <0>;
> +			status = "disabled";
> +		};
>  
>  		tlmm: pinctrl@1000000 {
>  			compatible = "qcom,ipq5424-tlmm";
> @@ -168,11 +261,11 @@ gcc: clock-controller@1800000 {
>  			reg = <0 0x01800000 0 0x40000>;
>  			clocks = <&xo_board>,
>  				 <&sleep_clk>,
> +				 <&pcie0_phy>,
> +				 <&pcie1_phy>,
>  				 <0>,

This leftover zero needs to be removed too, currently the wrong
clocks are used as parents

> -				 <0>,
> -				 <0>,
> -				 <0>,
> -				 <0>;
> +				 <&pcie2_phy>,
> +				 <&pcie3_phy>;
>  			#clock-cells = <1>;
>  			#reset-cells = <1>;
>  			#interconnect-cells = <1>;
> @@ -292,6 +385,385 @@ frame@f42d000 {
>  			};
>  		};
>  
> +		pcie3: pcie@40000000 {
> +			compatible = "qcom,pcie-ipq5424",
> +				     "qcom,pcie-ipq9574";
> +			reg = <0 0x40000000 0 0xf1d>,
> +			      <0 0x40000f20 0 0xa8>,
> +			      <0 0x40001000 0 0x1000>,
> +			      <0 0x000f8000 0 0x3000>,
> +			      <0 0x40100000 0 0x1000>;
> +			reg-names = "dbi", "elbi", "atu", "parf", "config";

Please make this a vertical list, in all nodes

[...]

> +			phys = <&pcie3_phy>;
> +			phy-names = "pciephy";
> +			interconnects = <&gcc MASTER_ANOC_PCIE3 &gcc SLAVE_ANOC_PCIE3>,
> +					<&gcc MASTER_CNOC_PCIE3 &gcc SLAVE_CNOC_PCIE3>;
> +			interconnect-names = "pcie-mem", "cpu-pcie";
> +			status = "disabled";

And add a newline above status

Konrad

