Return-Path: <linux-pci+bounces-24730-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E88A71191
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 08:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 696FB3B9C10
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 07:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3896819DF66;
	Wed, 26 Mar 2025 07:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gzizc3WK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E21119D892;
	Wed, 26 Mar 2025 07:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742974924; cv=none; b=qGLIy6YW4QGPolDYMqzQgpKSCA2aD683kV4lxnPGKoOkdLjbjwovpogOCa1lQIsd8+LsvHtXEhlNVLUm7zWvQbPzFFJNHFyWQE+GF91vsJvte+JgiUVloiSUG6dyUV9BMKNycQn5Jo1/rOMy+1iuc1sJMirgmq3auWsP/JfiZGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742974924; c=relaxed/simple;
	bh=3jjMk+1ohQmFTfl7cvpKkj3gRrcef1To/+F1eHyPB4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ww/s9/GgPcMJF8pznfjNUWc5pLWOUAYFhOZxH7NzBC18X0Snbi3ubp9OCpow3s/iRtz1CddEB5mUBzr+M/dn1Pu0Yy23MWeFjmReQxO5kxHFARYwDx8YjgZvlEQbvjvZzd6weEr6G8ASuJy9mwQPxG0oW0jH086SWgi0EKLR4rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gzizc3WK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52Q737jj023557;
	Wed, 26 Mar 2025 07:41:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GkRvfCij4pd3uVBUt5aRBIESRSztyKt9Ey8pjtoRQmg=; b=gzizc3WKUwwo3BnW
	Srwe+oav/ojUDIRnwr5sNWLZ+zhEDWWg5vSepW0+QoQu9yBfnJmJghz+Vk16sIUO
	HT2HiwujaFeNvCPPxwYAF7S4se8PMw4LiGAMjRQFw4cA+lpqhKXBqhylqm34OSD5
	C3qGIWxv7x3I8ecFe9PTPpR7vmn+9uz/O2CgXsZNEkgAc5OzKg0vHtvlpBT4Xnpm
	LuQGjXNPdUqJYWNEqsNzgXFcZ2ojWtFxb+X3IePWKQjt2qR9w2EI8afL04ip5/n/
	Cp12e/niOcAFkshw/Zkgl3exu8fbmdbu1dMr8gpOET6eTLGHKdLtJvOukJTMVX3a
	LeyH0g==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45m7nf0smg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 07:41:45 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52Q7fiKl027437
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 07:41:44 GMT
Received: from [10.50.18.203] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 26 Mar
 2025 00:41:38 -0700
Message-ID: <988510be-ee5f-49c9-a5a4-074c51245f95@quicinc.com>
Date: Wed, 26 Mar 2025 13:11:35 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/6] arm64: dts: qcom: ipq5018: Add PCIe related nodes
Content-Language: en-US
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: <george.moussalem@outlook.com>, Vinod Koul <vkoul@kernel.org>,
        "Kishon
 Vijay Abraham I" <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        "Nitheesh Sekar" <quic_nsekar@quicinc.com>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        Bjorn Helgaas
	<bhelgaas@google.com>,
        "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>,
        <20250317100029.881286-2-quic_varada@quicinc.com>,
        Sricharan R
	<quic_srichara@quicinc.com>
References: <20250321-ipq5018-pcie-v6-0-b7d659a76205@outlook.com>
 <20250321-ipq5018-pcie-v6-5-b7d659a76205@outlook.com>
 <a4n3w62bg6x2iux4z7enu3po56hr5pcavjfmvtzdcwv2w4ptrr@ssvfdrltfg5y>
 <6fa2bd30-762b-4a3a-b94f-8798c027764a@quicinc.com>
 <ycv74l5nop5mptj6uobuacffnwho2gvznh4dhxagupt5gh6x4k@vgik7ouydy6f>
From: Praveenkumar I <quic_ipkumar@quicinc.com>
In-Reply-To: <ycv74l5nop5mptj6uobuacffnwho2gvznh4dhxagupt5gh6x4k@vgik7ouydy6f>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: imIP0sofuN1yHsf_tMzzQw6yL0oxWwZm
X-Proofpoint-GUID: imIP0sofuN1yHsf_tMzzQw6yL0oxWwZm
X-Authority-Analysis: v=2.4 cv=IMMCChvG c=1 sm=1 tr=0 ts=67e3afb9 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=UqCG9HQmAAAA:8 a=KKAkSRfTAAAA:8
 a=P2ilW47UxfeQljOifu4A:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_10,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 malwarescore=0 mlxscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503260045



On 3/25/2025 10:23 PM, Manivannan Sadhasivam wrote:
> On Mon, Mar 24, 2025 at 04:48:34PM +0530, Praveenkumar I wrote:
>>
>> On 3/24/2025 1:26 PM, Manivannan Sadhasivam wrote:
>>> On Fri, Mar 21, 2025 at 04:14:43PM +0400, George Moussalem via B4 Relay wrote:
>>>> From: Nitheesh Sekar<quic_nsekar@quicinc.com>
>>>>
>>>> Add phy and controller nodes for a 2-lane Gen2 and
>>> Controller is Gen 3 capable but you are limiting it to Gen 2.
>>>
>>>> a 1-lane Gen2 PCIe bus. IPQ5018 has 8 MSI SPI interrupts and
>>>> one global interrupt.
>>>>
>>>> Signed-off-by: Nitheesh Sekar<quic_nsekar@quicinc.com>
>>>> Signed-off-by: Sricharan R<quic_srichara@quicinc.com>
>>>> Signed-off-by: George Moussalem<george.moussalem@outlook.com>
>>> One comment below. With that addressed,
>>>
>>> Reviewed-by: Manivannan Sadhasivam<manivannan.sadhasivam@linaro.org>
>>>
>>>> ---
>>>>    arch/arm64/boot/dts/qcom/ipq5018.dtsi | 234 +++++++++++++++++++++++++++++++++-
>>>>    1 file changed, 232 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>>>> index 8914f2ef0bc4..d08034b57e80 100644
>>>> --- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>>>> +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>>>> @@ -147,6 +147,40 @@ usbphy0: phy@5b000 {
>>>>    			status = "disabled";
>>>>    		};
>>>> +		pcie1_phy: phy@7e000{
>>>> +			compatible = "qcom,ipq5018-uniphy-pcie-phy";
>>>> +			reg = <0x0007e000 0x800>;
>>>> +
>>>> +			clocks = <&gcc GCC_PCIE1_PIPE_CLK>;
>>>> +
>>>> +			resets = <&gcc GCC_PCIE1_PHY_BCR>,
>>>> +				 <&gcc GCC_PCIE1PHY_PHY_BCR>;
>>>> +
>>>> +			#clock-cells = <0>;
>>>> +			#phy-cells = <0>;
>>>> +
>>>> +			num-lanes = <1>;
>>>> +
>>>> +			status = "disabled";
>>>> +		};
>>>> +
>>>> +		pcie0_phy: phy@86000{
>>>> +			compatible = "qcom,ipq5018-uniphy-pcie-phy";
>>>> +			reg = <0x00086000 0x800>;
>>>> +
>>>> +			clocks = <&gcc GCC_PCIE0_PIPE_CLK>;
>>>> +
>>>> +			resets = <&gcc GCC_PCIE0_PHY_BCR>,
>>>> +				 <&gcc GCC_PCIE0PHY_PHY_BCR>;
>>>> +
>>>> +			#clock-cells = <0>;
>>>> +			#phy-cells = <0>;
>>>> +
>>>> +			num-lanes = <2>;
>>>> +
>>>> +			status = "disabled";
>>>> +		};
>>>> +
>>>>    		tlmm: pinctrl@1000000 {
>>>>    			compatible = "qcom,ipq5018-tlmm";
>>>>    			reg = <0x01000000 0x300000>;
>>>> @@ -170,8 +204,8 @@ gcc: clock-controller@1800000 {
>>>>    			reg = <0x01800000 0x80000>;
>>>>    			clocks = <&xo_board_clk>,
>>>>    				 <&sleep_clk>,
>>>> -				 <0>,
>>>> -				 <0>,
>>>> +				 <&pcie0_phy>,
>>>> +				 <&pcie1_phy>,
>>>>    				 <0>,
>>>>    				 <0>,
>>>>    				 <0>,
>>>> @@ -387,6 +421,202 @@ frame@b128000 {
>>>>    				status = "disabled";
>>>>    			};
>>>>    		};
>>>> +
>>>> +		pcie1: pcie@80000000 {
>>>> +			compatible = "qcom,pcie-ipq5018";
>>>> +			reg = <0x80000000 0xf1d>,
>>>> +			      <0x80000f20 0xa8>,
>>>> +			      <0x80001000 0x1000>,
>>>> +			      <0x00078000 0x3000>,
>>>> +			      <0x80100000 0x1000>,
>>>> +			      <0x0007b000 0x1000>;
>>>> +			reg-names = "dbi",
>>>> +				    "elbi",
>>>> +				    "atu",
>>>> +				    "parf",
>>>> +				    "config",
>>>> +				    "mhi";
>>>> +			device_type = "pci";
>>>> +			linux,pci-domain = <0>;
>>>> +			bus-range = <0x00 0xff>;
>>>> +			num-lanes = <1>;
>>>> +			max-link-speed = <2>;
>>> This still needs some justification. If Qcom folks didn't reply, atleast move
>>> this to board dts with a comment saying that the link is not coming up with
>>> Gen3.
>>>
>>> - Mani
>> The IPQ5018 PCIe controller can support Gen3, but the PCIe phy is limited
>> Gen2 and does not supported Gen3.
> Hmm, so if a Gen 3 capable device is connected, the link will not work at Gen 2?
> It seems so from the error that George shared previously.
No, that is not the case. The link will work with a Gen3 capable device 
at Gen2 speed. The failure log shared by George indicates a PHY failure, 
which is due to IPQ5018 PHY's hardware limitation.
>
>> Hence, it is restricted using the DTSI property.
>>
> Ok. George, please add a comment for the property stating the reason.
>
> - Mani
>
--
Thanks,
Praveenkumar

