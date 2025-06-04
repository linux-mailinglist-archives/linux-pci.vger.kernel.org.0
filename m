Return-Path: <linux-pci+bounces-28941-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9F9ACD92B
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 10:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CFF6189BE07
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 08:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492B62798FB;
	Wed,  4 Jun 2025 07:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pGLaKOCU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEBB27877D;
	Wed,  4 Jun 2025 07:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749023950; cv=none; b=HwTb19eYgEqXxLOxc9Kj6yq+IuWE43ln/EiBUEFJ7L5rQ7c5lN6JQc/TjfI76yg2H42he2p4Qcp7XEqhcsekk9GsRXtzEl+5PcLWEWHGzO1z4Dhv85C75s4jMTgA85YQaXWOP1HQHEJwdtEl2u+fa1D4oYPk2WuQcI+NSdR8vXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749023950; c=relaxed/simple;
	bh=iCqux5kt4G7I2DhrbXSMK5wVXZlC+bSpbVS0TjtVGRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BpCgn0MCyQADRhfl5P7WiP2A44mN2s8Gx/wUGiYzDyPznCkpTWdu5I37ana27kVdd7vfqpDivp1XONRPK9LH8HCKQBEthCTGchxs3Lsvbku6VM/9k3sGXsRN+CZRjQI0RgLJJae6fz6zd2Cnt4owkHIhhEeBq7h5pDppH+QdeZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pGLaKOCU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 553Kohct012745;
	Wed, 4 Jun 2025 07:58:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	13QvruWdyVcS9mIBsvc1M5XXNtaXK//w/xWjOBf3jyg=; b=pGLaKOCUKqs/q+iv
	bgDjF75sV8OEY6+6KYBXn9osh2ipby4az29r43hIeyHcTSOP2p8AROQAoZKdYfsC
	2I/aw+h88KCdgrRddXfo84E4QOMx32ttxewMjo0Oqk/LkRpI7dJaA5m3DezDT2Rs
	h2uVbHr9oV9tM3cH+IsmkxBnYkeEGhSRw7Ssc/4uvwxahNx+y7MHE/oZIAW8f1mb
	B6v5ElvzCLvLb01gRru4eBFU0h0oFFh+51UL2LXgLDKWcyN5bXnb+NekA96aC6OR
	vmH+XqKsgQOhOUlSPkA5z/mQ+KEJrD2xodavJzg62zy2sxiZ6o/NaKmEKQylnOlO
	ur/nLQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8yn8y9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Jun 2025 07:58:58 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5547wgnq010824
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Jun 2025 07:58:42 GMT
Received: from [10.253.14.73] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 4 Jun 2025
 00:58:36 -0700
Message-ID: <e8d1b60c-97fe-4f50-8ead-66711f1aa3a7@quicinc.com>
Date: Wed, 4 Jun 2025 15:58:33 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] dt-bindings: PCI: qcom,pcie-sa8775p: document
 link_down reset
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
CC: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzk+dt@kernel.org>,
        <neil.armstrong@linaro.org>, <abel.vesa@linaro.org>, <kw@linux.com>,
        <conor+dt@kernel.org>, <vkoul@kernel.org>, <kishon@kernel.org>,
        <andersson@kernel.org>, <konradybcio@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_qianyu@quicinc.com>,
        <quic_krichai@quicinc.com>, <quic_vbadigan@quicinc.com>
References: <20250529035416.4159963-1-quic_ziyuzhan@quicinc.com>
 <20250529035416.4159963-3-quic_ziyuzhan@quicinc.com>
 <drr7cngryldptgzbmac7l2xpryugbrnydke3alq5da2mfvmgm5@nwjsqkef7ypc>
From: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
In-Reply-To: <drr7cngryldptgzbmac7l2xpryugbrnydke3alq5da2mfvmgm5@nwjsqkef7ypc>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDA2MyBTYWx0ZWRfX77FdHn2XCV8M
 vKMLW3uJTfMu6h/rW0OuqK5CabkLuyZs/YtDfW7zcWih7b2Okt77codf9WliWxFE7SqaxwiTDhd
 BO5tYEFOFNdmO4aJUm3Fvfn5VWkTupELTSP716Cl0n4bC995+NZIaSXxxZnVCrK/VrwM7Kkmuff
 o3gmp4GSdsVjlKSxbwponKSmnVT9jAUSyLbaX/5D2ari45OKQiNq2NazTdFHR6edfMUg9MUmbBE
 lN3KNSEvqSHlw3bo7OdwFIP/j/xKFkPd1F56SpPiRnLlcJB+5wdgRP/2xHTAYPurLNVyvgXBA4T
 9T0yahIIKfQHbaRUXB5aKyn3zcfB91dNXVdYnOiUmXBjM4zxhg/yYL6cBi0Ug36UYaUzbzaqIwF
 zet8xmYMD7aJxDLIGywxGdyPz9IjEBXhgpqrizM1qy0eRQa3kVwvc3x8tCGW2jogPbKOQfJO
X-Proofpoint-ORIG-GUID: W8ozeskPvM20bNOMHtkaqIPpffrjzj5Z
X-Proofpoint-GUID: W8ozeskPvM20bNOMHtkaqIPpffrjzj5Z
X-Authority-Analysis: v=2.4 cv=T/uMT+KQ c=1 sm=1 tr=0 ts=683ffcc2 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=JfrnYn6hAAAA:8
 a=COk6AnOGAAAA:8 a=WXbjEpnkNGJP-WVJ2wQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1CNFftbPRP8L7MoqJWF3:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_02,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 suspectscore=0 impostorscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 malwarescore=0 phishscore=0
 adultscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506040063


On 6/3/2025 9:11 PM, Dmitry Baryshkov wrote:
> On Thu, May 29, 2025 at 11:54:14AM +0800, Ziyue Zhang wrote:
>> Each PCIe controller on sa8775p supports 'link_down'reset on hardware,
>> document it.
> I don't think it's possible to "support" reset in hardware. Either it
> exists and is routed, or it is not.

Hi Dmitry,

I will change the commit msg to
'Each PCIe controller on sa8775p includes 'link_down'reset on hardware,
document it.'
"Supports" implies that the PCIe controller has an active role in enabling
or managing the reset functionality—it suggests that the controller is designed
to accommodate or facilitate this feature.
  "Includes" simply states that the reset functionality is present in the
hardware—it exists, whether or not it's actively managed or configurable.
So I think change it to includes will be better.

BRs
Ziyue

>> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
>> ---
>>   .../devicetree/bindings/pci/qcom,pcie-sa8775p.yaml  | 13 +++++++++----
>>   1 file changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
>> index e3fa232da2ca..805258cbcf2f 100644
>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
>> @@ -61,11 +61,14 @@ properties:
>>         - const: global
>>   
>>     resets:
>> -    maxItems: 1
>> +    minItems: 1
>> +    maxItems: 2
> Shouldn't we just update this to maxItems:2 / minItems:2 and drop
> minItems:1 from the next clause?

Hi Dmitry,

link_down reset is optional. In many other platforms, like sm8550
and x1e80100, link_down reset is documented as a optional reset.
PCIe will works fine without link_down reset. So I think setting it
as optional is better.

BRs
Ziyue

>>   
>>     reset-names:
>> +    minItems: 1
>>       items:
>> -      - const: pci
>> +      - const: pci # PCIe core reset
>> +      - const: link_down # PCIe link down reset
>>   
>>   required:
>>     - interconnects
>> @@ -161,8 +164,10 @@ examples:
>>   
>>               power-domains = <&gcc PCIE_0_GDSC>;
>>   
>> -            resets = <&gcc GCC_PCIE_0_BCR>;
>> -            reset-names = "pci";
>> +            resets = <&gcc GCC_PCIE_0_BCR>,
>> +                     <&gcc GCC_PCIE_0_LINK_DOWN_BCR>;
>> +            reset-names = "pci",
>> +                          "link_down";
>>   
>>               perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
>>               wake-gpios = <&tlmm 0 GPIO_ACTIVE_HIGH>;
>> -- 
>> 2.34.1
>>
>>
>> -- 
>> linux-phy mailing list
>> linux-phy@lists.infradead.org
>> https://lists.infradead.org/mailman/listinfo/linux-phy

