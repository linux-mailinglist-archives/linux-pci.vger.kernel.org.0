Return-Path: <linux-pci+bounces-28955-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6104BACDB9F
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 12:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3A7A171DF8
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 10:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BF528D828;
	Wed,  4 Jun 2025 10:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PXU03Ir8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F40280339;
	Wed,  4 Jun 2025 10:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749031541; cv=none; b=e+nWbfrY2nVa+JKIzHVLh0okbzmrzfsSkq3q9ff/lM7gU3KTb5I4NSWm+jIywKFJ2r0TpN1B1SFw4mGuUJoi4Pa4ufkf1DdRbXK4Wig+ryy/xarKJMkVUgqAeX2qB9wtz/BInoXrruSlZu7Q+6ewE2uT73zsIbmaKowKWNPnD3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749031541; c=relaxed/simple;
	bh=CcTfuyjqSM12x50F8W1XyXrsWuiAPxaoahPzB/aeJmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aQ87C7gwMBFSxktq2weOvTvr2V3EHoqeZo4D/upDPGuRc6I+IwFIynYfvDZIvVVSTkZDI3jju50aHp/AIlSzYoNET+6olR3oc4XwjoETwfieMfTgFkgI3jINiLwwtmncxrw+5GZG5MQtFNyZEVGinNOCF+idMN/7jSiq6WUOmpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PXU03Ir8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5548d3Ql004284;
	Wed, 4 Jun 2025 10:05:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LLWn+M7Jb3tl19nO3TgCdp05g80bpe8bTMMZoETnm2Y=; b=PXU03Ir8zSvNrplc
	go2gEUMB7tWONFsOvQ4viPgwwLQCBqTeLr0ioCBXLKX7KGEwEmG9dec0lrVC+TpZ
	DFbcCqqB93ykpzgvAgiD7655+Y/IUzzlpQPDFdKMb0+vs7kdPhwYqIGkfiMd3GwV
	zfROOOuTVb/uc8jAnBkzwgnaV15H85cRjGi26wMdCg/ehBjexd2vVDMf7mOOlFA8
	y3v+TCYWPU5W2ZKJnlZREvgmVCDQy10Nqni+IU7MzZcJSrAFQAE9TDAdRxghW6ep
	TFQECwHEgF/L7h85Om1BMxo1MXUo3eys/MPN3BgUqYtooWTind0yx+oDC9B8BWwA
	WsWwoA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8rwpja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Jun 2025 10:05:30 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 554A5TEm005531
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Jun 2025 10:05:29 GMT
Received: from [10.239.31.134] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 4 Jun 2025
 03:05:24 -0700
Message-ID: <43a6e141-adab-42e9-9966-ec54cb91a6de@quicinc.com>
Date: Wed, 4 Jun 2025 18:05:21 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] dt-bindings: PCI: qcom,pcie-sa8775p: document
 link_down reset
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Ziyue Zhang
	<quic_ziyuzhan@quicinc.com>
CC: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzk+dt@kernel.org>,
        <neil.armstrong@linaro.org>, <abel.vesa@linaro.org>, <kw@linux.com>,
        <conor+dt@kernel.org>, <vkoul@kernel.org>, <kishon@kernel.org>,
        <andersson@kernel.org>, <konradybcio@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_krichai@quicinc.com>,
        <quic_vbadigan@quicinc.com>
References: <20250529035416.4159963-1-quic_ziyuzhan@quicinc.com>
 <20250529035416.4159963-3-quic_ziyuzhan@quicinc.com>
 <drr7cngryldptgzbmac7l2xpryugbrnydke3alq5da2mfvmgm5@nwjsqkef7ypc>
 <e8d1b60c-97fe-4f50-8ead-66711f1aa3a7@quicinc.com>
 <34dnpaz3gl5jctcohh5kbf4arijotpdlxn2eze3oixrausyev3@4qso3qg5zn4t>
Content-Language: en-US
From: Qiang Yu <quic_qianyu@quicinc.com>
In-Reply-To: <34dnpaz3gl5jctcohh5kbf4arijotpdlxn2eze3oixrausyev3@4qso3qg5zn4t>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: kr1ygYF-xldh2_nW38WLv7Xgzahp8F7z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDA3NiBTYWx0ZWRfXydctOvOa9SmP
 /qo4oM6jGlGtQACfZRJfoYKTaT+0JMovEgzeaLABBzhhxSoeNFrgazYh/bLrGlaPROVjgG6VElB
 jEcJGd7ennwLg94abgN2FMZP5TaYC3ZtN08IG1fWFyaOKWQh17I1yR1Gx0ad8BCMJfFRvwf5GjP
 AIu9eD+6PMgzpGaI6DvCPzZsm+7WvqmwKd39DDeTn5jeS8dODGTJtWcaV+bjIP6Q/MqGI1l1xUI
 xnCrjAfMsaba9rtNIAjl7BRbOsnGbWrb//JpxgKl1fj0Z+8zLX3wNtR2FpdffEvDVZOhEGbCbWG
 HYV5sXx+phgwwmYtipQIaa7mKWb2pX/SLTiMntx7YU2a62RAQt+goxFDevDnC88x+c2fe66VbXz
 lfEa5xAF/86c4Ckt4viy9KwCvZjwtLfdslPcbkC44R6zEJeKkNK+9+Ixzxbogc8ckbl9jQpL
X-Authority-Analysis: v=2.4 cv=RdWQC0tv c=1 sm=1 tr=0 ts=68401a6a cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=JfrnYn6hAAAA:8
 a=COk6AnOGAAAA:8 a=gDmLj3BAQhsnJV4uteAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1CNFftbPRP8L7MoqJWF3:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: kr1ygYF-xldh2_nW38WLv7Xgzahp8F7z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_02,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 mlxscore=0 priorityscore=1501 phishscore=0
 clxscore=1011 lowpriorityscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 spamscore=0 mlxlogscore=999 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506040076


On 6/4/2025 5:15 PM, Dmitry Baryshkov wrote:
> On Wed, Jun 04, 2025 at 03:58:33PM +0800, Ziyue Zhang wrote:
>> On 6/3/2025 9:11 PM, Dmitry Baryshkov wrote:
>>> On Thu, May 29, 2025 at 11:54:14AM +0800, Ziyue Zhang wrote:
>>>> Each PCIe controller on sa8775p supports 'link_down'reset on hardware,
>>>> document it.
>>> I don't think it's possible to "support" reset in hardware. Either it
>>> exists and is routed, or it is not.
>> Hi Dmitry,
>>
>> I will change the commit msg to
>> 'Each PCIe controller on sa8775p includes 'link_down'reset on hardware,
>> document it.'
>> "Supports" implies that the PCIe controller has an active role in enabling
>> or managing the reset functionality—it suggests that the controller is designed
>> to accommodate or facilitate this feature.
>>  "Includes" simply states that the reset functionality is present in the
>> hardware—it exists, whether or not it's actively managed or configurable.
>> So I think change it to includes will be better.
>>
>> BRs
>> Ziyue
>>
>>>> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
>>>> ---
>>>>   .../devicetree/bindings/pci/qcom,pcie-sa8775p.yaml  | 13 +++++++++----
>>>>   1 file changed, 9 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
>>>> index e3fa232da2ca..805258cbcf2f 100644
>>>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
>>>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
>>>> @@ -61,11 +61,14 @@ properties:
>>>>         - const: global
>>>>     resets:
>>>> -    maxItems: 1
>>>> +    minItems: 1
>>>> +    maxItems: 2
>>> Shouldn't we just update this to maxItems:2 / minItems:2 and drop
>>> minItems:1 from the next clause?
>> Hi Dmitry,
>>
>> link_down reset is optional. In many other platforms, like sm8550
>> and x1e80100, link_down reset is documented as a optional reset.
>> PCIe will works fine without link_down reset. So I think setting it
>> as optional is better.
> You are describing a hardware. How can a reset be optional in the
> _hardware_? It's either routed or not.

I feel a bit confused. According to the theory above, everything seems to
be non-optional when describing hardware, such as registers, clocks,
resets, regulators, and interrupts—all of them either exist or do not.

Seems like I misunderstand the concept of 'optional'? Is 'optional' only
used for compatibility across different platforms?

Additionally, we have documented the PCIe global interrupt as optional. I
was taught that, in the PCIe driver, this interrupt is retrieved using the
platform_get_irq_byname_optional API, so it can be documented as optional.
However, this still seems to contradict the theory mentioned earlier.

>> BRs
>> Ziyue
>>
>>>>     reset-names:
>>>> +    minItems: 1
>>>>       items:
>>>> -      - const: pci
>>>> +      - const: pci # PCIe core reset
>>>> +      - const: link_down # PCIe link down reset
>>>>   required:
>>>>     - interconnects
>>>> @@ -161,8 +164,10 @@ examples:
>>>>               power-domains = <&gcc PCIE_0_GDSC>;
>>>> -            resets = <&gcc GCC_PCIE_0_BCR>;
>>>> -            reset-names = "pci";
>>>> +            resets = <&gcc GCC_PCIE_0_BCR>,
>>>> +                     <&gcc GCC_PCIE_0_LINK_DOWN_BCR>;
>>>> +            reset-names = "pci",
>>>> +                          "link_down";
>>>>               perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
>>>>               wake-gpios = <&tlmm 0 GPIO_ACTIVE_HIGH>;
>>>> -- 
>>>> 2.34.1
>>>>
>>>>
>>>> -- 
>>>> linux-phy mailing list
>>>> linux-phy@lists.infradead.org
>>>> https://lists.infradead.org/mailman/listinfo/linux-phy

-- 
With best wishes
Qiang Yu


