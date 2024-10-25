Return-Path: <linux-pci+bounces-15254-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AD19AF667
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 03:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61A1B280FBA
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 01:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D21C10A19;
	Fri, 25 Oct 2024 01:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="W4vvwOLP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFF73A8D2;
	Fri, 25 Oct 2024 01:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729818552; cv=none; b=uf27W0jiGISSnPjGMStEFjknrXujnawAbjBotxtbZkbc3vdFbA/QhNbeNlo/pmYI/ptpxTi+XbKCblZIs2rvRBHwpvUpWnKp4VLSK6rARsc0kvWqKVqZFwKYvVaGySaMJbYlAIvio4kJkH2z+vUBp8qZ3CG5UumV3fx5tuF0biI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729818552; c=relaxed/simple;
	bh=wENN2XdTbRUcwTXnMipTh4bnfIGHZx4WtojFXUHh5+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YFDi8cWlYTF0x17B9KKPX2d1t99Q0dGalMIt7l5ba52ber8/KSblJ7cyQ/AD0eD5OkhYnjtveWiTZsHZbP/dkxbfNIbU78UgkkDTvJr+XTjIe+zz2wC9C1TsEUA/ZEKQaNaZMeobhD7YcUoVeW9Yu5dNkSmq6C/Mo+9j5CQJXqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=W4vvwOLP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49OM4uA4016005;
	Fri, 25 Oct 2024 01:08:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0+1oLZauET+j+jh09kk+YkWrDtNFJkeHnfbIQSJpwvo=; b=W4vvwOLPzOGaas9B
	jLSprNxIjvObGraTCmiF/1exlX2OadCSEfpI+huU9MpUlcDGnsG+k+sBCoIy9Y/0
	BekzNapLtjx2wj9geo0YUmMxEyiXQ+JwQBWu6pv8GVqt6GO5j1GGCRsocVyGTGj3
	6SkTFSMyvNnfens8uKFS5ZKXaCU8q7iLGXIUier6OV3HjpYFkJcokirgmRPHusoT
	8Q04Sh+QOVdUNKZkZyrWDS+UzsH5DWpVBRv0mYa4iuAeAaTRJlBZuzBYLndYqobV
	zBEVp45X82ccGByKYuPk1Ge43Ne0ORh9PevtaOeU4cZsSgdTe209UHBucV4H5XnG
	q5FajA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em3xqb1e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 01:08:47 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49P18kTV030019
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 01:08:46 GMT
Received: from [10.216.22.131] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 24 Oct
 2024 18:08:40 -0700
Message-ID: <77d3a1a9-c22d-0fd3-5942-91b9a3d74a43@quicinc.com>
Date: Fri, 25 Oct 2024 06:38:37 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/1] RFC: dt bindings: Add property "brcm,gen3-eq-presets"
Content-Language: en-US
To: Rob Herring <robh@kernel.org>, Jim Quinlan <james.quinlan@broadcom.com>
CC: <linux-pci@vger.kernel.org>, Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi
	<lorenzo.pieralisi@arm.com>,
        <bcm-kernel-feedback-list@broadcom.com>, <jim2101024@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM
 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
        "moderated
 list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
	<linux-rpi-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND
 FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
        open list
	<linux-kernel@vger.kernel.org>
References: <20241018182247.41130-1-james.quinlan@broadcom.com>
 <20241018182247.41130-2-james.quinlan@broadcom.com>
 <20241021190334.GA953710-robh@kernel.org>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20241021190334.GA953710-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bByYqpBSH2WD1znRWTx9ptXkLbDecWdR
X-Proofpoint-ORIG-GUID: bByYqpBSH2WD1znRWTx9ptXkLbDecWdR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 priorityscore=1501 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410250008



On 10/22/2024 12:33 AM, Rob Herring wrote:
> On Fri, Oct 18, 2024 at 02:22:45PM -0400, Jim Quinlan wrote:
>> Support configuration of the GEN3 preset equalization settings, aka the
>> Lane Equalization Control Register(s) of the Secondary PCI Express
>> Extended Capability.  These registers are of type HwInit/RsvdP and
>> typically set by FW.  In our case they are set by our RC host bridge
>> driver using internal registers.
>>
>> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
>> ---
>>   .../devicetree/bindings/pci/brcm,stb-pcie.yaml       | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
>> index 0925c520195a..f965ad57f32f 100644
>> --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
>> +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
>> @@ -104,6 +104,18 @@ properties:
>>       minItems: 1
>>       maxItems: 3
>>   
>> +  brcm,gen3-eq-presets:
>> +    description: |
>> +      A u16 array giving the GEN3 equilization presets, one for each lane.
>> +      These values are destined for the 16bit registers known as the
>> +      Lane Equalization Control Register(s) of the Secondary PCI Express
>> +      Extended Capability.  In the array, lane 0 is first term, lane 1 next,
>> +      etc. The contents of the entries reflect what is necessary for
>> +      the current board and SoC, and the details of each preset are
>> +      described in Section 7.27.4 of the PCI base spec, Revision 3.0.
> 
> If these are defined by the PCIe spec, then why is it Broadcom specific
> property?
> 
Hi Rob,

qcom pcie driver also needs to program these presets as you suggested
this can go to common pci bridge binding.

from PCIe spec 6.0.1 revision section 8.3.3.3 & 4.2.4.2 for data rates
of  8.0 GT/s, 16.0 GT/s, and 32.0 GT/s uses one class of preset (P0
through P10) and where as data rates of 64.0 GT/s use different class of
presets (Q0 through Q10) (Table 4-23). And data rates of 8.0 GT/s also
have optional preset hints (Table 4-24).

And there is possibility that for each data rate we may require
different preset configuration.

Can we have a dt binding for each data rate of 16 byte array.
like gen3-eq-preset array, gen4-eq-preset array etc.

- Krishna Chaitanya
>> +
>> +    $ref: /schemas/types.yaml#/definitions/uint16-array
> 
> minItems: 1
> maxItems: 16
> 
> Last I saw, you can only have up to 16 lanes.
> 
> Rob
> 

