Return-Path: <linux-pci+bounces-18858-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9338D9F8CE2
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 07:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A47C1892C9D
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 06:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A92E186E54;
	Fri, 20 Dec 2024 06:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lh4Zkhf9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE32325765;
	Fri, 20 Dec 2024 06:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734676952; cv=none; b=S5/BNuypUGv9J5ulL2Qm95fMfsoN7zlBphbdou8BrsURF5UZNg8CzO2UsBjyONf1TUC7VZ15GGqhuwHNlEgCdNnrsr9WXN2k//pvsxhc3d+aZZoqmeTmOBscNa1NEA3J7uQaqAt6sMR6FLKWBcgCwOtuFVAm416yRMJO17b7SIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734676952; c=relaxed/simple;
	bh=9bvD+hGat8LLJu1xTP46ZD4AahO2wfoy/u/RHEqsTas=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KtV4vnOuVRDvBFHU4gTrif4Fa3t+hIsBXw0/9HkxlFm+zcBOi9opKVzSapPe6p+hYXGboUHOIIdGQdUZDWnU3hYYJW/SdFzX8K64dEKF6ZtJaFQ9uwQjaZA3+LTwcK4voGN7Nid9PrShKcQLMl5OkNEWfKaGKccTzXGknReppko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lh4Zkhf9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BK5ehgG005017;
	Fri, 20 Dec 2024 06:42:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zsp4oqLCT405v81EFBJxahh0RypZYUKhCS90+zQEKD4=; b=lh4Zkhf9z7qI0U3h
	QyTVHYxH9dg1Ul7jKdBLmQ+G+HhAlJ4QQFs0QEgDfKCdSNjFHdyRGfj/yCsCp5MR
	AEJq9GlOrxgPCxYFGJP5oEeliwZV9hgnkQoRIkSFAVf30fTeBV++LMT/drRG9HwO
	BN5kTurJa9xGRqD/y9INJmtB9k8IUhdLG0n5cMKq2vYuQQVQ/d7hwVkj4ISuZ9+2
	uwXZN0e+VwbchqHipiwCsNGdOgFU+zt8LEXuPLfpPosfdUQr5mc8Fej9i0f84Low
	k9UVPGaJj7ikH197Mv9B5BrZKSAmDi3+B6hvpMFqNhxjbe+nr0HyouN3EBtypYmp
	fLcbrQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43n2n5r4ng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Dec 2024 06:42:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BK6gHHj017583
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Dec 2024 06:42:17 GMT
Received: from [10.152.195.140] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 19 Dec
 2024 22:42:10 -0800
Message-ID: <08fbde92-a827-4270-a143-cca56a274e6c@quicinc.com>
Date: Fri, 20 Dec 2024 12:12:06 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: dts: qcom: ipq5424: Add PCIe PHYs and
 controller nodes
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, <bhelgaas@google.com>,
        <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <andersson@kernel.org>, <konradybcio@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
References: <20241213134950.234946-1-quic_mmanikan@quicinc.com>
 <20241213134950.234946-4-quic_mmanikan@quicinc.com>
 <69dffe54-939d-47c3-b951-4a4dea11eae0@oss.qualcomm.com>
Content-Language: en-US
From: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
In-Reply-To: <69dffe54-939d-47c3-b951-4a4dea11eae0@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2_EghpnmcPuSFXnaH0aYSYWvDrYGWDM8
X-Proofpoint-GUID: 2_EghpnmcPuSFXnaH0aYSYWvDrYGWDM8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412200055



On 12/13/2024 8:36 PM, Konrad Dybcio wrote:
> On 13.12.2024 2:49 PM, Manikanta Mylavarapu wrote:
>> Add PCIe0, PCIe1, PCIe2, PCIe3 (and corresponding PHY) devices
>> found on IPQ5424 platform. The PCIe0 & PCIe1 are 1-lane Gen3
>> host whereas PCIe2 & PCIe3 are 2-lane Gen3 host.
>>
>> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
>> ---
>>  arch/arm64/boot/dts/qcom/ipq5424.dtsi | 482 +++++++++++++++++++++++++-
>>  1 file changed, 477 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq5424.dtsi b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
>> index 5e219f900412..ade512bcb180 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq5424.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
>> @@ -9,6 +9,7 @@
>>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>>  #include <dt-bindings/clock/qcom,ipq5424-gcc.h>
>>  #include <dt-bindings/reset/qcom,ipq5424-gcc.h>
>> +#include <dt-bindings/interconnect/qcom,ipq5424.h>
>>  #include <dt-bindings/gpio/gpio.h>
>>  
>>  / {
>> @@ -143,7 +144,99 @@ soc@0 {
>>  		compatible = "simple-bus";
>>  		#address-cells = <2>;
>>  		#size-cells = <2>;
>> -		ranges = <0 0 0 0 0x10 0>;
>> +		ranges = <0 0 0 0 0x0 0xffffffff>;
> 
> This must be a separate change, with a clear explanation
> 
>> +
>> +		pcie0_phy: phy@84000 {
>> +			compatible = "qcom,ipq5424-qmp-gen3x1-pcie-phy",
>> +				     "qcom,ipq9574-qmp-gen3x1-pcie-phy";
>> +			reg = <0 0x00084000 0 0x2000>;
>> +			clocks = <&gcc GCC_PCIE0_AUX_CLK>,
>> +				 <&gcc GCC_PCIE0_AHB_CLK>,
>> +				 <&gcc GCC_PCIE0_PIPE_CLK>;
>> +			clock-names = "aux", "cfg_ahb", "pipe";
>> +
>> +			assigned-clocks = <&gcc GCC_PCIE0_AUX_CLK>;
>> +			assigned-clock-rates = <20000000>;
>> +
>> +			resets = <&gcc GCC_PCIE0_PHY_BCR>,
>> +				 <&gcc GCC_PCIE0PHY_PHY_BCR>;
>> +			reset-names = "phy", "common";
>> +
>> +			#clock-cells = <0>;
>> +			clock-output-names = "gcc_pcie0_pipe_clk_src";
>> +
>> +			#phy-cells = <0>;
>> +			status = "disabled";
>> +		};
>> +
>> +		pcie1_phy: phy@8c000 {
>> +			compatible = "qcom,ipq5424-qmp-gen3x1-pcie-phy",
>> +				     "qcom,ipq9574-qmp-gen3x1-pcie-phy";
>> +			reg = <0 0x0008c000 0 0x2000>;
>> +			clocks = <&gcc GCC_PCIE1_AUX_CLK>,
>> +				 <&gcc GCC_PCIE1_AHB_CLK>,
>> +				 <&gcc GCC_PCIE1_PIPE_CLK>;
>> +			clock-names = "aux", "cfg_ahb", "pipe";
>> +
>> +			assigned-clocks = <&gcc GCC_PCIE1_AUX_CLK>;
>> +			assigned-clock-rates = <20000000>;
>> +
>> +			resets = <&gcc GCC_PCIE1_PHY_BCR>,
>> +				 <&gcc GCC_PCIE1PHY_PHY_BCR>;
>> +			reset-names = "phy", "common";
>> +
>> +			#clock-cells = <0>;
>> +			clock-output-names = "gcc_pcie1_pipe_clk_src";
>> +
>> +			#phy-cells = <0>;
>> +			status = "disabled";
>> +		};
>> +
>> +		pcie2_phy: phy@f4000 {
>> +			compatible = "qcom,ipq5424-qmp-gen3x2-pcie-phy",
>> +				     "qcom,ipq9574-qmp-gen3x2-pcie-phy";
>> +			reg = <0 0x000f4000 0 0x2000>;
>> +			clocks = <&gcc GCC_PCIE2_AUX_CLK>,
>> +				 <&gcc GCC_PCIE2_AHB_CLK>,
>> +				 <&gcc GCC_PCIE2_PIPE_CLK>;
>> +			clock-names = "aux", "cfg_ahb", "pipe";
>> +
>> +			assigned-clocks = <&gcc GCC_PCIE2_AUX_CLK>;
>> +			assigned-clock-rates = <20000000>;
>> +
>> +			resets = <&gcc GCC_PCIE2_PHY_BCR>,
>> +				 <&gcc GCC_PCIE2PHY_PHY_BCR>;
>> +			reset-names = "phy", "common";
>> +
>> +			#clock-cells = <0>;
>> +			clock-output-names = "gcc_pcie2_pipe_clk_src";
>> +
>> +			#phy-cells = <0>;
>> +			status = "disabled";
>> +		};
>> +
>> +		pcie3_phy: phy@fc000 {
>> +			compatible = "qcom,ipq5424-qmp-gen3x2-pcie-phy",
>> +				     "qcom,ipq9574-qmp-gen3x2-pcie-phy";
>> +			reg = <0 0x000fc000 0 0x2000>;
>> +			clocks = <&gcc GCC_PCIE3_AUX_CLK>,
>> +				 <&gcc GCC_PCIE3_AHB_CLK>,
>> +				 <&gcc GCC_PCIE3_PIPE_CLK>;
>> +			clock-names = "aux", "cfg_ahb", "pipe";
>> +
>> +			assigned-clocks = <&gcc GCC_PCIE3_AUX_CLK>;
>> +			assigned-clock-rates = <20000000>;
>> +
>> +			resets = <&gcc GCC_PCIE3_PHY_BCR>,
>> +				 <&gcc GCC_PCIE3PHY_PHY_BCR>;
>> +			reset-names = "phy", "common";
>> +
>> +			#clock-cells = <0>;
>> +			clock-output-names = "gcc_pcie3_pipe_clk_src";
>> +
>> +			#phy-cells = <0>;
>> +			status = "disabled";
>> +		};
>>  
>>  		tlmm: pinctrl@1000000 {
>>  			compatible = "qcom,ipq5424-tlmm";
>> @@ -168,11 +261,11 @@ gcc: clock-controller@1800000 {
>>  			reg = <0 0x01800000 0 0x40000>;
>>  			clocks = <&xo_board>,
>>  				 <&sleep_clk>,
>> +				 <&pcie0_phy>,
>> +				 <&pcie1_phy>,
>>  				 <0>,
> 
> This leftover zero needs to be removed too, currently the wrong
> clocks are used as parents
> 

Hi Konrad,

The '<0>' entry is for "USB PCIE wrapper pipe clock source".
And, will update the pcie entries as follows
	<&pcie0_phy GCC_PCIE0_PIPE_CLK>
	<&pcie1_phy GCC_PCIE1_PIPE_CLK>
	<&pcie2_phy GCC_PCIE2_PIPE_CLK>
	<&pcie3_phy GCC_PCIE3_PIPE_CLK>

Please correct me if i am wrong.

Thanks & Regards,
Manikanta.

>> -				 <0>,
>> -				 <0>,
>> -				 <0>,
>> -				 <0>;
>> +				 <&pcie2_phy>,
>> +				 <&pcie3_phy>;
>>  			#clock-cells = <1>;
>>  			#reset-cells = <1>;
>>  			#interconnect-cells = <1>;
>> @@ -292,6 +385,385 @@ frame@f42d000 {
>>  			};
>>  		};
>>  

