Return-Path: <linux-pci+bounces-16276-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFD19C0D1B
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 18:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C76E5284DD7
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 17:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA9321620A;
	Thu,  7 Nov 2024 17:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Y7FwIoai"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACC920F5DD;
	Thu,  7 Nov 2024 17:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731001219; cv=none; b=Pi2ZCx6VYlX9fqVUUq6pZuB0vlzuD5CAP9V6TgiSUSyPWyZ5D2e9OzBj6No0tZnLcCOFnyjJKsqpbRiHF52tLatfXw/Vd2yqvFGpLK+s6HYm6KgI8/D4ST4FGkQoFrhfoJ6GWSE7PHM+P/EmxsQCgyNwqA2uSD2jZOfseF70vLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731001219; c=relaxed/simple;
	bh=V/lOaJybCwy6k6qiDtv2PEu7Aolfa9YmROLaa5DZ82Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=K5CCIw/hcNkZdQMR8aNCIhnDKYBNO8rOYe1WC6aGi1SMeb66m9CGKO7fk+mhgMTjqFXiTHPZzE+Kuy1qAFsIo8UNMy4Xpw+jR3k7XG8hs+q85GRnhC0AlL7dqhPpZe3OIbOERpIOVZHQz8Fwn4GAh8PPoQxIDI+LtZuBZfE6RhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Y7FwIoai; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7HLnYN022341;
	Thu, 7 Nov 2024 17:40:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZGm+WyjxVBnEHda1KQC7rg2+03zBE0q8aCdfntQMgMw=; b=Y7FwIoaid9wdFfY1
	6BRQu6V2Y1gHSHkucTwmcE1LekWowI2G6xnSLVBXkTlahOZxf+4n8M2d1sxufwnO
	cdGZ7ZGLupf3DPJjPD/S31rGTxtMkx9JIkKZJS/FUyFnpgZsA785TskZZslyu8ff
	brbQouE3VPiYT2M7JX5IuMj7Nhm7GSp21OLhmhYsE8tjVR2kD8yPRYUwls1JJtGb
	g4PL17dcQvg9pvsh9lYCai56YM/mbeiFHmqrAjTo9HVcooCke7osVdZlyT59PDlj
	Z//9C050buDdecRax4Jm5NrQUGNU8iU3A/QDOXJOUOuOT7kagBeod9sGzk7ZoSRz
	+xSm6g==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42r3c1d81g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 17:39:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A7HdwjC012691
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Nov 2024 17:39:58 GMT
Received: from [10.110.112.161] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 7 Nov 2024
 09:39:58 -0800
Message-ID: <ba50ce49-3149-49ec-b825-3be29738d0b0@quicinc.com>
Date: Thu, 7 Nov 2024 09:39:58 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] dt-bindings: PCI: qcom,pcie-sa8255p: Document ECAM
 compliant PCIe root complex
To: Krzysztof Kozlowski <krzk@kernel.org>, <jingoohan1@gmail.com>,
        <manivannan.sadhasivam@linaro.org>, <will@kernel.org>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_krichai@quicinc.com>
References: <20241106221341.2218416-1-quic_mrana@quicinc.com>
 <20241106221341.2218416-4-quic_mrana@quicinc.com>
 <6e4ef0cc-1695-4956-af27-94ab28a4404b@kernel.org>
Content-Language: en-US
From: Mayank Rana <quic_mrana@quicinc.com>
In-Reply-To: <6e4ef0cc-1695-4956-af27-94ab28a4404b@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0mlOFMwXaQLiEP4mwX7rC9ndhGZy7S0T
X-Proofpoint-ORIG-GUID: 0mlOFMwXaQLiEP4mwX7rC9ndhGZy7S0T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 clxscore=1015
 spamscore=0 phishscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411070138



On 11/7/2024 1:35 AM, Krzysztof Kozlowski wrote:
> On 06/11/2024 23:13, Mayank Rana wrote:
>> On SA8255p, PCIe root complex is managed by firmware using power-domain
>> based handling. This root complex is configured as ECAM compliant.
>> Document required configuration to enable PCIe root complex.
>>
>> Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>
>> ---
>>   .../bindings/pci/qcom,pcie-sa8255p.yaml       | 103 ++++++++++++++++++
> 
> NAK
> 
> <form letter>
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC. It might happen, that command when run on an older
> kernel, gives you outdated entries. Therefore please be sure you base
> your patches on recent Linux kernel.
> 
> Tools like b4 or scripts/get_maintainer.pl provide you proper list of
> people, so fix your workflow. Tools might also fail if you work on some
> ancient tree (don't, instead use mainline) or work on fork of kernel
> (don't, instead use mainline). Just use b4 and everything should be
> fine, although remember about `b4 prep --auto-to-cc` if you added new
> patches to the patchset.
> 
> You missed at least devicetree list (maybe more), so this won't be
> tested by automated tooling. Performing review on untested code might be
> a waste of time.
> 
> Please kindly resend and include all necessary To/Cc entries.
> </form letter>
> 
> BTW, you also Cc-ed incorrect addresses :/
sorry, I missed adding right set of folks and mailing list here.
I shall resend after updating correct reviewers.

> Best regards,
> Krzysztof
> 

