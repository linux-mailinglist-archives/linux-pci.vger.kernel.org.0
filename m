Return-Path: <linux-pci+bounces-30012-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16344ADE424
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 09:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF6E73B0532
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 07:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE293272806;
	Wed, 18 Jun 2025 07:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="f7ykjwsr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B3D27147E;
	Wed, 18 Jun 2025 07:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750230095; cv=none; b=Ly1bMr+k8veSr1Onc6fdXsL/+APNd7YirO1McU7FhQd8LgKxy4+9mkteOkQ+aSeuPkMenqWp+qveUmUDQ4FOGN2GBRgFsuKEb3xwnG3gymA2tI26NX1Z8/G+DzgDGgzLumjtUECPhb8JHCR62Ws5qAFsHJuSlaNWU4kNXnLsEEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750230095; c=relaxed/simple;
	bh=JDLqapR7/cZbPpvm2T6Lg0Q1JvQoihR2NWQXSjbPi9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AhGyLPY0XLga2mZyN9wXm9DXizqP0XkWR77T5ZFfh7fQmQ1FsJFL5vNrPV7kA0TtanUUPOmWoCUd0b9FjrVnorR3Upf8qf51xvM62xYlZydiZxue9MA3foFI126shAP6FHx7koOGXeYQtwTCpY4HsZTWEs33clKBy46n/FvIpx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=f7ykjwsr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55I45T3w010103;
	Wed, 18 Jun 2025 07:01:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vfjKqlbFovhKXQWVBQzLCyD+4Kfluz5EtoLnuQ7t9Uo=; b=f7ykjwsrss2yxHT4
	sD4yw827k79Bywm+m6zXJwHFyDDFKh9SiRWcr3XI82usAJZF/PXFPRAlTmJte5dg
	qLa0Uvm1KPPQm2WcEWOMtrhAHE4aq9oLmWxQBPz6xAV5OhjEIhO+RdZDqA1L5peb
	j2iVmVwoyj6XlTVk4VeIDwWM2hhEf2Y3NZHuIcisBJjEKr81PIAnZqTLsGwJr/Lj
	7aKDM4hSpLJ5mz0iUcCuHy/cR75EVhT9dBNWtRMu7KgK+/rmXm4l2m7e1INcfv0f
	K280F0z7lRgzYDo1p+UjeZBTms5mTZ6z5HPjLcgLxPJvMU8GNPBLnW+hbkrbfnGJ
	922qRg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 479qp5spm2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Jun 2025 07:01:24 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55I71NrT029804
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Jun 2025 07:01:23 GMT
Received: from [10.253.79.108] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 18 Jun
 2025 00:01:17 -0700
Message-ID: <51ba2ae0-50fd-4fbe-acc0-3e9f89a75049@quicinc.com>
Date: Wed, 18 Jun 2025 15:01:15 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] arm64: dts: qcom: qcs615-ride: Enable PCIe
 interface
To: Manivannan Sadhasivam <mani@kernel.org>
CC: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzk+dt@kernel.org>,
        <neil.armstrong@linaro.org>, <abel.vesa@linaro.org>, <kw@linux.com>,
        <conor+dt@kernel.org>, <vkoul@kernel.org>, <kishon@kernel.org>,
        <andersson@kernel.org>, <konradybcio@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_qianyu@quicinc.com>,
        <quic_krichai@quicinc.com>, <quic_vbadigan@quicinc.com>,
        Konrad Dybcio
	<konrad.dybcio@oss.qualcomm.com>
References: <20250527072036.3599076-1-quic_ziyuzhan@quicinc.com>
 <20250527072036.3599076-5-quic_ziyuzhan@quicinc.com>
 <6vfwiii4sawm722odw6hxomtsrd5m64pmjlqm5sr5m3nblih3m@jkn3txak5nix>
From: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
In-Reply-To: <6vfwiii4sawm722odw6hxomtsrd5m64pmjlqm5sr5m3nblih3m@jkn3txak5nix>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: V3s8nWWOqgslY7xCSjz1PZLPS267FGRb
X-Proofpoint-ORIG-GUID: V3s8nWWOqgslY7xCSjz1PZLPS267FGRb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDA1OSBTYWx0ZWRfX2gxXA1Ta3GQd
 Upf8izMESJ/vX4JnijiGFWYwDTrnHOZjRqF5s+dp5F9Q0RQMa9DJPiFRiYvCQM4feoWLTnAdq6+
 vKpBTdlxQ5Z8li5qzvyDCqNG1XzkyKJnAg2quw/WWgCx7xQ5A8yvsFhmJ+JezEVP1HJrNNDSW91
 5ahc6N4t7laedsUZMVySB39U5QuqNTHCWnBts6oAgPOumaL5u4DeIqPQhHvHbRPA5y1o+ULpAnz
 XT9Y4LqH4voXcXwmcN5bhxWvm/Bpg+6wG/tSpKrId5gc1hUAyjtPKRDfBCYoF7bLBV4UacsngFN
 NHFbPwEHExN3gvd1CnHFxOpIgOT51QjnRk3IAVqEQhIejoZyCpDxPQKTJXWy9d9K42Jc1IioAdu
 8/GVjRBmvGVcd+FRoLj7XLe+/0i9QPn4PHLw0/15BCJrkVO002GEXUMnJ9zaI1f/YkeoDSZ4
X-Authority-Analysis: v=2.4 cv=fMc53Yae c=1 sm=1 tr=0 ts=68526444 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=KTbbhH3lz3gsKtoJeJUA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_02,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506180059


On 6/18/2025 12:33 AM, Manivannan Sadhasivam wrote:
> On Tue, May 27, 2025 at 03:20:36PM +0800, Ziyue Zhang wrote:
>> From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>>
>> Add platform configurations in devicetree for PCIe, board related
>> gpios, PMIC regulators, etc.
>>
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/qcs615-ride.dts | 42 ++++++++++++++++++++++++
>>   1 file changed, 42 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qcs615-ride.dts b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
>> index 2b5aa3c66867..c59647e5f2d6 100644
>> --- a/arch/arm64/boot/dts/qcom/qcs615-ride.dts
>> +++ b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
>> @@ -217,6 +217,23 @@ &gcc {
>>   		 <&sleep_clk>;
>>   };
>>   
>> +&pcie {
>> +	perst-gpios = <&tlmm 101 GPIO_ACTIVE_LOW>;
>> +	wake-gpios = <&tlmm 100 GPIO_ACTIVE_HIGH>;
>> +
>> +	pinctrl-0 = <&pcie_default_state>;
>> +	pinctrl-names = "default";
>> +
>> +	status = "okay";
>> +};
>> +
>> +&pcie_phy {
>> +	vdda-phy-supply = <&vreg_l5a>;
>> +	vdda-pll-supply = <&vreg_l12a>;
>> +
>> +	status = "okay";
>> +};
>> +
>>   &pm8150_gpios {
>>   	usb2_en: usb2-en-state {
>>   		pins = "gpio10";
>> @@ -244,6 +261,31 @@ &rpmhcc {
>>   	clocks = <&xo_board_clk>;
>>   };
>>   
>> +&tlmm {
>> +	pcie_default_state: pcie-default-state {
>> +		clkreq-pins {
>> +			pins = "gpio90";
>> +			function = "pcie_clk_req";
>> +			drive-strength = <2>;
>> +			bias-pull-up;
>> +		};
>> +
>> +		perst-pins {
>> +			pins = "gpio101";
>> +			function = "gpio";
>> +			drive-strength = <2>;
>> +			bias-pull-down;
> Are you sure that the default state of the pin should be 'pull down'? Pull down
> of a PERST# is deassert, which should only happen once the power and refclk are
> stable.
>
> - Mani

Hi Mani,

pull-down is assert, we need to make sure perset is asserted before refclk is
stable.

BRs
Ziyue


