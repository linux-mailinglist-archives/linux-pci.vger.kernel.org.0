Return-Path: <linux-pci+bounces-27567-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C691AB3152
	for <lists+linux-pci@lfdr.de>; Mon, 12 May 2025 10:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C2AA189B9C3
	for <lists+linux-pci@lfdr.de>; Mon, 12 May 2025 08:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738B7255F21;
	Mon, 12 May 2025 08:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PlQimwUY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932642AEE1;
	Mon, 12 May 2025 08:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747037783; cv=none; b=hu6sLJ4I9VpKzPgo1sP6qIPhyZC6FeuZDqPPqmur7+BaUS+kmkWQLZCudZOOPqq8KZq449yQjSj1Z5lgiI0uWaEjdKtTdtKdZx0K14f9/Y+jpg0XTOlSWwWcE7PLk7SrwFrWV7+JlK3ss4uZkpsIV7P13vx6mmDzc5ZZwV1XbDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747037783; c=relaxed/simple;
	bh=emBuZer2FeLc8X6hMB1rIrKH91yoxdgCpR/nZiBSk3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oEdicpFZsTMG8H7tj7xw1huRni4QYPguv5fnKzTLevy4u4seAyLwYDqJEgjrzxQjdkzE2L2RyFIyz8LOcMhkE3dz+5qwxT0uBNuAOxO5mNkZbWVQA95UDvZ3OKFyxFBVIrgF2jN74VyGV59WviytD6Bpz5u12pO+ZteNLF4ixVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PlQimwUY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54BMLk7O015839;
	Mon, 12 May 2025 08:16:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7l2dkG0n9j+CsoG1wnaET0QWA0eavfqlFSf8kRou3tw=; b=PlQimwUY7BKOKoqG
	y/9yR95dgL0N0aQ8IGR8AhsFfRzA4/ZRD2nowQBYgdgnxFNfh3mdWrUSxooI4Rvr
	rkkxtUstgdVoS3UjkyaNQZKHitnGaI/OPh/YlQ+II7JTk6YqugyBYt3PiV7LRqq2
	76WkBTTF+a1m0nHGctJKo48Q9gs3RIlo2XdIQaVe62/W3GFVkMTqQN6CNetKkLOL
	unTZkdEZJ/rUk4fNRxf8omS26OK/DMmKXMresp2W8M6YdWLsfErOqzpC3953JlDU
	1JuRofoN6SSIXRJJw+sGZHhspIoFrQdDS+FKSHY1gGF4BgDG9Fp2tc4grhwXirlp
	RUVE1g==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46hx4k3p9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 08:16:10 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54C8G9nm012278
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 08:16:09 GMT
Received: from [10.253.34.155] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 12 May
 2025 01:16:02 -0700
Message-ID: <e434124b-6975-4027-bb0d-3840fbd25a15@quicinc.com>
Date: Mon, 12 May 2025 16:16:00 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] dt-bindings: PCI: qcom: Document the QCS615 PCIe
 Controller
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: <vkoul@kernel.org>, <kishon@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <neil.armstrong@linaro.org>,
        <abel.vesa@linaro.org>, <manivannan.sadhasivam@linaro.org>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <bhelgaas@google.com>,
        <andersson@kernel.org>, <konradybcio@kernel.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <quic_qianyu@quicinc.com>,
        <quic_krichai@quicinc.com>, <quic_vbadigan@quicinc.com>
References: <20250507031559.4085159-1-quic_ziyuzhan@quicinc.com>
 <20250507031559.4085159-3-quic_ziyuzhan@quicinc.com>
 <20250507-astute-realistic-ferret-bcdfce@kuoka>
From: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
In-Reply-To: <20250507-astute-realistic-ferret-bcdfce@kuoka>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=ReqQC0tv c=1 sm=1 tr=0 ts=6821ae4a cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8
 a=BJE1r2VZsCeTiZ4UBNQA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: V5s_apCAjcq1Od78LL7jE0-zWqwPirK2
X-Proofpoint-ORIG-GUID: V5s_apCAjcq1Od78LL7jE0-zWqwPirK2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDA4NiBTYWx0ZWRfX+VftKDg6Txx+
 R+tRpQqwZCVxaDNwRPrFZU0/+Nzyl0LRPKPjE5KJ8eOI+5WvvzUgxAhDzZ+ZMaHVlWKbd0bdgn+
 l1pStK923YA+goPIqypVxgvVVA72ave/ojyCdqbbeI3S9cUe77yVA+03Orh69xypywX90IYTbck
 Wal4d5TjPmibMbhivRUAjpQDczZbgFCT3KfkjXKymwxEYvlDFoL+aErFYY6Lxw+j69FZmOyyLa6
 RLDYecqGLOBv5OqpxoNN8jfnIqScpfTJWFXkMUK5gQNEvc5DLP2yobd15CaJIxfHryY/IVGcpkE
 J4G0n5Q+UiLiahDjXe75eImfhJinWRqTaR5DoZjarEBxTd0YvoOsHPwuo7BQVNwzRtLge1woADh
 Qir0NxU8M8EmkSDilqRhKdvbcLt117fSKuVSQVnaL23NP/3Gf9R3o++Vtgp55Jv+8JJ3Alue
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_03,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 adultscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505120086


On 5/7/2025 1:17 PM, Krzysztof Kozlowski wrote:
> On Wed, May 07, 2025 at 11:15:56AM GMT, Ziyue Zhang wrote:
>> From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>>
>> Add dedicated schema for the PCIe controllers found on QCS615.
>> Due to qcs615's clock-names do not match any of the existing
>> dt-bindings, a new compatible for qcs615 is needed.
> Other bindings for QCS615 were not finished, so I have doubts this is
> done as well. Send your bindings once you finish them.
>
> ...
>
>> +properties:
>> +  compatible:
>> +    const: qcom,qcs615-pcie
>> +
>> +  reg:
>> +    minItems: 6
>> +    maxItems: 6
>> +
>> +  reg-names:
>> +    items:
>> +      - const: parf # Qualcomm specific registers
>> +      - const: dbi # DesignWare PCIe registers
>> +      - const: elbi # External local bus interface registers
>> +      - const: atu # ATU address space
>> +      - const: config # PCIe configuration space
>> +      - const: mhi # MHI registers
>> +
>> +  clocks:
>> +    minItems: 5
> Drop or use correct value - 6. I don't understand why this changed and
> nothing in changelog explains this.
>
> Best regards,
> Krzysztof

Hi Krzysztof

As discussed in qcs8300, gcc_aux_clk is recommended to be removed from PCIe PHY
device tree node, so I need to update the bindings.

BRs
Ziyue


