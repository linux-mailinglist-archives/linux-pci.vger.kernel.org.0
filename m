Return-Path: <linux-pci+bounces-19487-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19158A050F3
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 03:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D1D37A3426
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 02:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068BD13790B;
	Wed,  8 Jan 2025 02:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="G5JFA6yr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579982EAE5;
	Wed,  8 Jan 2025 02:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736304186; cv=none; b=qtX4pw/TaEbwF7Ro4esFeot3zjUvPcjE2PKDKLGOfA6f/GUcdRQ4GSH7NgamW4CHHe14JcgitvWJnKePFyO2FJZpW972pXlAAgdYCtl+Uk926CEyCd4p/a6l7DOOX+hn21qPGqgBLKKfM0xiUCqYfgr7QTnVODKUONAPTmxoqC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736304186; c=relaxed/simple;
	bh=JlSwh/0gE6sirlxADVlIqNfAcabpWdazRoq04XhYycU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JFdOakWSgKAmllAUty1h54231LiejK4ovFPEjavgSAKJbFnfHIaxS2L+ddOKhUfDoR7LqNTtGvOYDd/gvgNnPT5aGg8m5WBMhMm/d5DwMalIFlAdbrDzA2ZG4Pb63lPFxW8SYM0rlNvIrEvQKclkBT6jpmJ5p0b5m4OFcMW8OR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=G5JFA6yr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50829ViL017165;
	Wed, 8 Jan 2025 02:42:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	id4Q4t7To12y3BMf3JeHw3Jjoq3ak7F8TiFe2dBOU/Y=; b=G5JFA6yrJK2GimHn
	YHoVMUGOlwJ8H+1ouwWZVilb+c/LbWL3TvYcQv8ECCk6ao9ooIIiJaa67eUw9ZAl
	1sS2bcqhvxhnVU8uVnqfm2tczo4TEUzfmhPHS4AC0OiOpDyAlYSsBwvMTACd90Y9
	MJOJnx41Vp7EnS9+ZPP4Yyag9Kd6sKFwNtyfZhu5nJ2Al6aK4oC4V7zXRvH/XzUX
	SeL3vFDnVXnFtviDgKPSynYd0i0miy+fyV2WiiADyk77wv9rG4MMN0cqnKuh88YR
	ZXM32mAX6DsihWDjJOqJlrmy+xxQS2A9HpXGHr1/mLbyiMawmlYgevGUXXO4F/w5
	mPIwLA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 441gb582sp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 02:42:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5082gsCj020216
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 8 Jan 2025 02:42:54 GMT
Received: from [10.216.0.179] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 7 Jan 2025
 18:42:49 -0800
Message-ID: <f71ad2e5-684a-3444-14ba-794238ef48d1@quicinc.com>
Date: Wed, 8 Jan 2025 08:12:46 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V1] schemas: pci: bridge: Document PCI L0s & L1 entry
 delay and nfts
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Rob Herring <robh@kernel.org>,
        Krishna Chaitanya Chundru
	<krishna.chundru@oss.qualcomm.com>,
        <andersson@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <manivannan.sadhasivam@linaro.org>, <krzk@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <conor+dt@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree-spec@vger.kernel.org>, <quic_vbadigan@quicinc.com>
References: <20250107204228.GA180123@bhelgaas>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20250107204228.GA180123@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PDG1HlW3hGETA6rip5FsPff5_7pRIRpT
X-Proofpoint-ORIG-GUID: PDG1HlW3hGETA6rip5FsPff5_7pRIRpT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=999 impostorscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501080019



On 1/8/2025 2:12 AM, Bjorn Helgaas wrote:
> On Tue, Jan 07, 2025 at 07:49:00PM +0530, Krishna Chaitanya Chundru wrote:
>> On 1/6/2025 8:37 PM, Rob Herring wrote:
>>> On Mon, Jan 6, 2025 at 3:33 AM Krishna Chaitanya Chundru
>>> <krishna.chundru@oss.qualcomm.com> wrote:
>>>>
>>>> Some controllers and endpoints provide provision to program the entry
>>>> delays of L0s & L1 which will allow the link to enter L0s & L1 more
>>>> aggressively to save power.
>>>>
>>>> As per PCIe spec 6 sec 4.2.5.6, the number of Fast Training Sequence (FTS)
>>>> can be programmed by the controllers or endpoints that is used for bit and
>>>> Symbol lock when transitioning from L0s to L0 based upon the PCIe data rate
>>>> FTS value can vary. So define a array for each data rate for nfts.
>>>>
>>>> These values needs to be programmed before link training.
> 
>>> Do these properties apply to any link like downstream ports on a
>>> PCIe switch?
>>>
>> These applies to downstream ports also on a switch.
> 
> IIUC every PCIe component with a Link, i.e., Upstream Ports (on a
> Switch or Endpoint) and Downstream Ports (a Root Port or Switch), has
> an N_FTS value that it advertises during Link training.
> 
> I suppose N_FTS depends on the component electrical design and maybe
> the Link, and it only makes sense to have this n-fts property for
> specific devices that support this kind of configuration, right?  I
> don't think we would know what to do with n-fts for random plug-in
> Switches or Endpoints because there's no generic way to configure
> N_FTS, and we *couldn't* do it before the Link is trained anyway
> unless there's some sideband mechanism.
yes I agree with it, we have one such type of PCIe switch which has i2c
sideband mechanism = to program it before enabling link training. This
properties can be used for the switches which has side band mechanism.
> 
>>>> +    description:
>>>> +      Number of Fast Training Sequence (FTS) used during L0s to L0 exit for bit
>>>> +      and Symbol lock.
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>>>> +    minItems: 1
>>>> +    maxItems: 5
>>>
>>> Need to define what is each entry? Gen 1 to 5?
>>>
>> yes there are from Gen1 to Gen 5, I will update this in next patch these
>> details.
> 
> Components are permitted to advertise different N_FTS values at
> different *speeds*, not "GenX" (PCIe r6.0, sec 4.2.5.6)
> 
> The spec discourages use of Gen1, etc because they are ambiguous (sec
> 1.2):
> 
>    Terms like "PCIe Gen3" are ambiguous and should be avoided. For
>    example, "gen3" could mean (1) compliant with Base 3.0, (2)
>    compliant with Base 3.1 (last revision of 3.x), (3) compliant with
>    Base 3.0 and supporting 8.0 GT/s, (4) compliant with Base 3.0 or
>    later and supporting 8.0 GT/s, ....
> 
> We're stuck with the use of genX for max-link-speed, but we should use
> speeds when we can for clarity, e.g., in the description here.
Ack, that's why I tried to mention data rates instead of gen in the
commit text.

- Krishna Chaitanya.

