Return-Path: <linux-pci+bounces-6525-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B47498AD2C9
	for <lists+linux-pci@lfdr.de>; Mon, 22 Apr 2024 18:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D71961C20A99
	for <lists+linux-pci@lfdr.de>; Mon, 22 Apr 2024 16:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED29153514;
	Mon, 22 Apr 2024 16:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="m6dGXjxZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F82B1DDE9;
	Mon, 22 Apr 2024 16:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713804930; cv=none; b=gBQEJIpAgRMiCswZoKpeJGuxmygrifl9vI0eoXXpn61AdNNF5uuu/Idbv4rNO9yE6LKlsIp87tbgIvyYbqiQb7Kfkmy9J46gybu6/2jCoICNfTTg6hhB4YS1n7yH4L95a/AShLeqrm6+rXb7q2ZweCCTorcANf1/vLonMr8R2VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713804930; c=relaxed/simple;
	bh=2jZwFQHtiH7cm+Ga9AwJWMCkGznGng+DZ6vbx9U5YrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tFUTMVvm/w6M1YC4jtbpSHFHGC76GPfW+AMUpwkft30LqnFxjLTmS8FxNkBhS25UK784BRgzEAUec5z1ZsDbKTUeKCBOGSwsIK1c2F/MWMgA6F3B0DRzXc3KL5jtfwkfTB3E2N6EaQr395DUKi2ZEv+xZoes/V9pHKBrPw8sVj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=m6dGXjxZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43MBEDIZ005693;
	Mon, 22 Apr 2024 16:55:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=WqGboBVd32J2qAYOSSOnGKGRpD5bTQ7vE9elE/ZKkTA=; b=m6
	dGXjxZbWqEl3GJWLoxB/fz5piKVqA/om+BPGJCQDj0Ysfm9cx8FrmJBHP3nJ+ae0
	8P7C+cwA+OyQUYDr++QSAiSIdKks2mwx8FaOtIXfEK0XdQvSE6Iton0l7BhKbLjx
	Lepk8LiEj5En6SXaJReYKR3PA/5dUdCZpbC7e+LTxiNezu6riCtLCwdK1HrnnJ1f
	3dQeD7Zi+bABkOz0oZamuwtcJ7zCfK7IuXLHcnK3TI5GvO3Zi1MZglvHmO++brox
	LXPqFTJB38QSFQEdoEsqN1CiWhDnG8izgHN1zK5Zl0SMpdonrSTSLSg2YpKFDEaR
	BcUNfYrP2Pt7fWT/ZU5w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xnmuvh5s7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 16:55:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43MGtIjK022925
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 16:55:18 GMT
Received: from [10.216.42.44] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 22 Apr
 2024 09:55:10 -0700
Message-ID: <aaee8605-848f-fe9c-63aa-af4ae2d399a6@quicinc.com>
Date: Mon, 22 Apr 2024 22:25:06 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v10 4/6] arm64: dts: qcom: sm8450: Add OPP table support
 to PCIe
Content-Language: en-US
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas
	<bhelgaas@google.com>, <johan+linaro@kernel.org>,
        <bmasney@redhat.com>, <djakov@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <vireshk@kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_parass@quicinc.com>, <krzysztof.kozlowski@linaro.org>
References: <20240409-opp_support-v10-0-1956e6be343f@quicinc.com>
 <20240409-opp_support-v10-4-1956e6be343f@quicinc.com>
 <20240422144431.GE9775@thinkpad>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20240422144431.GE9775@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: huHlSHyjlGnejDwA-RQTxRbv-uGRYwTh
X-Proofpoint-ORIG-GUID: huHlSHyjlGnejDwA-RQTxRbv-uGRYwTh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1011 priorityscore=1501
 mlxscore=0 suspectscore=0 phishscore=0 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404220071



On 4/22/2024 8:14 PM, Manivannan Sadhasivam wrote:
> On Tue, Apr 09, 2024 at 03:43:22PM +0530, Krishna chaitanya chundru wrote:
>> PCIe needs to choose the appropriate performance state of RPMh power
> 
> 'PCIe host controller driver'
> 
>> domain and interconnect bandwidth based up on the PCIe data rate.
> 
> 'based on the PCIe data rate'
> 
>>
>> Add the OPP table support to specify RPMh performance states and
> 
> 'Hence, add...'
> 
>> interconnect peak bandwidth.
>>
>> Different link configurations may share the same aggregate bandwidth,
> 
> 'It should be noted that the different...'
> 
>> e.g., a 2.5 GT/s x2 link and a 5.0 GT/s x1 link have the same bandwidth
>> and share the same OPP entry.
>>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sm8450.dtsi | 77 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 77 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> index 615296e13c43..9dfe16012726 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> @@ -1855,7 +1855,35 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
>>   			pinctrl-names = "default";
>>   			pinctrl-0 = <&pcie0_default_state>;
>>   
>> +			operating-points-v2 = <&pcie0_opp_table>;
>> +
>>   			status = "disabled";
>> +
>> +			pcie0_opp_table: opp-table {
>> +				compatible = "operating-points-v2";
>> +
>> +				/* GEN 1 x1 */
>> +				opp-2500000 {
>> +					opp-hz = /bits/ 64 <2500000>;
>> +					required-opps = <&rpmhpd_opp_low_svs>;
>> +					opp-peak-kBps = <250000 1>;
>> +				};
>> +
>> +				/* GEN 2 x1 */
>> +				opp-5000000 {
>> +					opp-hz = /bits/ 64 <5000000>;
>> +					required-opps = <&rpmhpd_opp_low_svs>;
>> +					opp-peak-kBps = <500000 1>;
>> +				};
>> +
>> +				/* GEN 3 x1 */
>> +				opp-8000000 {
>> +					opp-hz = /bits/ 64 <8000000>;
> 
> I doubt this value. See below...
> 
>> +					required-opps = <&rpmhpd_opp_nom>;
>> +					opp-peak-kBps = <984500 1>;
>> +				};
>> +			};
>> +
>>   		};
>>   
>>   		pcie0_phy: phy@1c06000 {
>> @@ -1982,7 +2010,56 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
>>   			pinctrl-names = "default";
>>   			pinctrl-0 = <&pcie1_default_state>;
>>   
>> +			operating-points-v2 = <&pcie1_opp_table>;
>> +
>>   			status = "disabled";
>> +
>> +			pcie1_opp_table: opp-table {
>> +				compatible = "operating-points-v2";
>> +
>> +				/* GEN 1 x1 */
>> +				opp-2500000 {
>> +					opp-hz = /bits/ 64 <2500000>;
>> +					required-opps = <&rpmhpd_opp_low_svs>;
>> +					opp-peak-kBps = <250000 1>;
>> +				};
>> +
>> +				/* GEN 1 x2 GEN 2 x1 */
>> +				opp-5000000 {
>> +					opp-hz = /bits/ 64 <5000000>;
>> +					required-opps = <&rpmhpd_opp_low_svs>;
>> +					opp-peak-kBps = <500000 1>;
>> +				};
>> +
>> +				/* GEN 2 x2 */
>> +				opp-10000000 {
>> +					opp-hz = /bits/ 64 <10000000>;
>> +					required-opps = <&rpmhpd_opp_low_svs>;
>> +					opp-peak-kBps = <1000000 1>;
>> +				};
>> +
>> +				/* GEN 3 x1 */
>> +				opp-8000000 {
>> +					opp-hz = /bits/ 64 <8000000>;
> 
> GEN 3 x1 frequency is lower than GEN 2 x2? This looks strange. Both should be of
> same frequency.
> 
Gen2 is 5GT/s where as GEN3 is 8GT/s. so the freq for 3 x1(8 x1 GT/s) is
less than Gen2 x2(5 x2 GT/s)

- Krishna Chaitanya.
>> +					required-opps = <&rpmhpd_opp_nom>;
>> +					opp-peak-kBps = <984500 1>;
>> +				};
>> +
>> +				/* GEN 3 x2 GEN 4 x1 */
> 
> 'GEN 3 x2 and GEN 4 x1'
> 
> - Mani
> 

