Return-Path: <linux-pci+bounces-10417-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 224519333D6
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 23:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97EC81F244EB
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 21:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDD57441A;
	Tue, 16 Jul 2024 21:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JRGMiGwj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66878224D2;
	Tue, 16 Jul 2024 21:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721166552; cv=none; b=aNrm4rTwXStDl5gAFI8YfmoQNAE3Uaa1akW6sojmxwm+zL8jqbGfE9M298kdHDBw0gNX+ojvU6a5Ampid3akKDE2cqY5c0PZcZccVDRREtlWTd0qRGIuYHqXLjJuH+uH3ObLpED4Akasgew096SgJGwFeJD1ah3Wi13eKZrWdlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721166552; c=relaxed/simple;
	bh=sfSS4ZwVX3Zw6eGyrEZImYKV1ilehLk8LTaomnOYvus=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GEfUZVQ4YFOHFl3w21I1VXEfUm/wcWAm42uj3tI4ZkXfG4oyqJJ9+bABB/yRNbrQsy6vAeJ0tiuzqdVdNe3MevB3OOnLhjm2+3di0mx9f2TuxTomY/L0PLZ7jphooEy8iSon8IuXjchh8iUUShGxwbxfFfJHBYRdX3hwK/D2Rm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JRGMiGwj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46GHej0Z004324;
	Tue, 16 Jul 2024 21:47:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gTcJ2zwrT//sBmhanqg4yWW9MCmCe0qiT2k20Ee/UW0=; b=JRGMiGwj9Rwht6fd
	qcrkHmoQT1QfIzZRceRiCAF9KYWn2yAgnAKNuUoPeGJXhukh5wb7hWZtzAtsjcsY
	e5ORZaVxa7FDBuYWGSd3ed34qfo9O7gQuiMpgeUUDuI4g9hcxx262r+bWOdk03MG
	qpfzODKQsyG0N+38H4ACy7Uy9J5/Sp4MGNVPSiLmX0vImyNaXkx9+Q7fesVGfmZc
	bckCQxSnuezF4J3GoxtD+4ni5oPD7UhIvS3gz/IAkVG6IOTmBGXbE/iBQ3fqa1DE
	EQLHFkqU7qt7iAXSHgK0sF+PTekpZ3WJX11Rvl58cc6SJjKYi7RT/pILsN4patJs
	GlxpHw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40dwfp8f24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 21:47:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46GLlwDp006997
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 21:47:58 GMT
Received: from [10.110.79.225] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 16 Jul
 2024 14:47:57 -0700
Message-ID: <4bc75de3-f415-4560-892b-c17326190d2a@quicinc.com>
Date: Tue, 16 Jul 2024 14:47:56 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 4/7] dt-bindings: PCI: host-generic-pci: Add
 power-domains related binding
To: Krzysztof Kozlowski <krzk@kernel.org>, <will@kernel.org>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <jingoohan1@gmail.com>,
        <manivannan.sadhasivam@linaro.org>, <cassel@kernel.org>,
        <yoshihiro.shimoda.uh@renesas.com>, <s-vadapalli@ti.com>,
        <u.kleine-koenig@pengutronix.de>, <dlemoal@kernel.org>,
        <amishin@t-argos.ru>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <Frank.Li@nxp.com>,
        <ilpo.jarvinen@linux.intel.com>, <vidyas@nvidia.com>,
        <marek.vasut+renesas@gmail.com>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>
CC: <quic_ramkri@quicinc.com>, <quic_nkela@quicinc.com>,
        <quic_shazhuss@quicinc.com>, <quic_msarkar@quicinc.com>,
        <quic_nitegupt@quicinc.com>
References: <1721067215-5832-1-git-send-email-quic_mrana@quicinc.com>
 <1721067215-5832-5-git-send-email-quic_mrana@quicinc.com>
 <bc7ced85-8bba-46d4-be1e-6a436bfd2ee3@kernel.org>
Content-Language: en-US
From: Mayank Rana <quic_mrana@quicinc.com>
In-Reply-To: <bc7ced85-8bba-46d4-be1e-6a436bfd2ee3@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _310y3tXY8XlduREp5T96xyqRkMKygHj
X-Proofpoint-GUID: _310y3tXY8XlduREp5T96xyqRkMKygHj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-16_01,2024-07-16_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 clxscore=1011 impostorscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407160159

Hi Krzysztof

Appreciate your quick review comments.

On 7/16/2024 12:25 AM, Krzysztof Kozlowski wrote:
> On 15/07/2024 20:13, Mayank Rana wrote:
>> Add "power-domains" usage (optional) related binding to power up ECAM
>> compliant PCIe root complex.
>>
>> Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>
>> ---
>>   Documentation/devicetree/bindings/pci/host-generic-pci.yaml | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/host-generic-pci.yaml b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
>> index 3484e0b..9c714fa 100644
>> --- a/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
>> +++ b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
>> @@ -110,6 +110,12 @@ properties:
>>     iommu-map-mask: true
>>     msi-parent: true
>>   
>> +  power-domains:
>> +    maxItems: 1
>> +    description:
>> +      A phandle to the node that controls power or/and system resource or interface to firmware
> 
> Wrap how Coding Style asks (so 80).
My bad, I shall fix it into next patchset.
> I am sorry, but power domains are power domains, not interface to
> firmware to enable your hardware. Rephrase it to actually describe the
> hardware.
Agree with your above first part of comment.

I understood that you are suggesting to describe all steps in terms of 
what happen with usage of power domain instead of mentioning generic 
abstraction with proposed solution here. I mentioned generic way as
power domain is not tied with specific compatible string or platform
as optional usage with this generic driver.

Power domain shall be doing possible below implementation:
1. controls power -> can be just regulators
2. system resource -> can be PCIe related all system resource like 
GDSC/Clock/regulators/gpio
3. Interface to firmware -> including all system resource handling in 
addition to PCIe PHY and controller programming to PCIe ECAM RC mode 
with D0 state.

Cover letter is showing high level architecture and usage here although 
it would be lost. So to document here I can add more information. Below 
are steps which is being performed:
1. Handle all system resources (GDSC/CLOCKs/regulators/bus (interconnect 
voting))
2. Bring PCIe PHY and Controller out of reset
3. Program PCIe PHY and controller to get PCIe link up

Power domain interface is also used to perform D3cold based 
functionality with system suspend case to turn off resources after
performing PCIe level handshake (i.e. PME turn off and L23 ready).

I can rework/reword above provided power domain binding information but
not sure shall I keep it generic information or capture specific above 
usage with proposed solution. Please let me know what do suggest or 
prefer here ?

> Also, drop all redundant information. It cannot be anything else than
> phandle to the node...
ACK

>> +      to enable ECAM compliant PCIe root complex.
>> +
> 
> Anyway, there are no DTS users with such power domain. Look at the
> binding and its compatibles. Does any of these devices have power
> domain? No.
Agree. Work in progress, and based on outcome of that I shall add user 
of it as part of next patchset.
> 
> Best regards,
> Krzysztof
> 
> 

