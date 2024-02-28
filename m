Return-Path: <linux-pci+bounces-4170-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D2186A887
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 07:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30B9E1F244F6
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 06:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A46A22EF4;
	Wed, 28 Feb 2024 06:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IJMkKHja"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7BF2263E;
	Wed, 28 Feb 2024 06:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709102915; cv=none; b=MH4REagKpJ2i+UXC3se/+s5pMsdgj1MEkzzYq+SO9PrTigdmRATVlZkrrQl+z8WWpiaBTmMkU0K/wlR9DLnK3AdnYUQ4v3ywIAyQ7wMyGYhk/tGWegdxnQndviUv2fQoJwO31buOKJ8m5VbuGirgNYBkqzUXPjjZ25+Xfo3LpOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709102915; c=relaxed/simple;
	bh=K/V7UDqd9oyCfGoEQjqNayC7luvGAUZSwuSQSnnpafI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=T+UgLj7k/DvCCwt/11BXTiwh2FVzso4N90Rw4U8xOSDOAhKRjCsbIHisSXqrVM6uvaWeq4Cs2A+YE6uDjaQv57HGpYOYh6nKV7urSVCqLQnvHPBUMS/yCErJqshIPQzlJUCyBizw2cuFARdumd6kEM35g8DLng3wrShEIQkmGs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IJMkKHja; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41S5e1lx030528;
	Wed, 28 Feb 2024 06:48:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=PXjQPQzxzzwGnFRp68FJYBNtPt7qoVZVZBr8tHSF5MY=; b=IJ
	MkKHjakoctDI6wGkWcSP/IyXYXZufauKgG1ED+wGNmiT5emGEVmmSG0TxKWBPYjc
	5Lkm2vyhzvJJt7MDD+UxzvXvlV0/ypgI2PinlF29RxSwacBTl2Gb80k7MHyHGt7k
	uE8BhuZm0iZ5Dn0/HOvlA2dGPb/Ea1QXJ9DLCKD3W93XjsKvZ8Li/+JWLBxy3xkp
	vp4GgbPZkoVRNDa0mRFEZ3nqFNdARne5T5GB5FitkYfZvDXUSG5ezOpGuE83x7G4
	wplQKtSDWJ66McXqFJxQDc+/lQlIJq2mxH1INK7MClLMxEGsHNgcexbjzuiI2J2c
	h2LmRI2M41AECv5YpZVw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3whv1frcrc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 06:48:18 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41S6mH8x017390
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 06:48:17 GMT
Received: from [10.216.14.152] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 27 Feb
 2024 22:48:09 -0800
Message-ID: <c9369d12-c31c-50cd-7b2c-974839388d72@quicinc.com>
Date: Wed, 28 Feb 2024 12:18:06 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v7 7/7] PCI: qcom: Add OPP support to scale performance
 state of power domain
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Brian Masney
	<bmasney@redhat.com>, Georgi Djakov <djakov@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vireshk@kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_parass@quicinc.com>
References: <20240227234549.GA251722@bhelgaas>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20240227234549.GA251722@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XTAq6dwlcIf-let6VF0nOWobX5a97s3y
X-Proofpoint-ORIG-GUID: XTAq6dwlcIf-let6VF0nOWobX5a97s3y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_04,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 impostorscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402280051



On 2/28/2024 5:15 AM, Bjorn Helgaas wrote:
> On Tue, Feb 27, 2024 at 05:36:38PM -0600, Bjorn Helgaas wrote:
>> On Fri, Feb 23, 2024 at 08:18:04PM +0530, Krishna chaitanya chundru wrote:
>>> QCOM Resource Power Manager-hardened (RPMh) is a hardware block which
>>> maintains hardware state of a regulator by performing max aggregation of
>>> the requests made by all of the clients.
> 
>>> It is manadate to scale the performance state based up on the PCIe speed
>>> link operates so that SoC can run under optimum power conditions.
>>
>> It sounds like it's more power efficient, but not actually
>> *mandatory*.  Maybe something like this?
>>
>>    The SoC can be more power efficient if we scale the performance
>>    state based on the aggregate PCIe link speed.
> 
> Actually, maybe it would be better to say "aggregate PCIe link
> bandwidth", because we use "speed" elsewhere (PCIE_SPEED2MBS_ENC(),
> etc) to refer specifically to the data rate independent of the width.
> 
>>> Add Operating Performance Points(OPP) support to vote for RPMh state based
>>> upon the speed link is operating.
>>
>> "... based on the link speed."
> 
> "... based on the aggregate link bandwidth."
> 
>>> In PCIe certain speeds like GEN1x2 & GEN2x1 or GEN3x2 & GEN4x1 use
>>> same bw and frequency and thus the OPP entry, so use frequency based
>>> search to reduce number of entries in the OPP table.
>>
>> GEN1x2, GEN2x1, etc are not "speeds".  I would say:
>>
>>    Different link configurations may share the same aggregate speed,
>>    e.g., a 2.5 GT/s x2 link and a 5.0 GT/s x1 link have the same speed
>>    and share the same OPP entry.
> 
>    Different link configurations may share the same aggregate
>    bandwidth, e.g., a 2.5 GT/s x2 link and a 5.0 GT/s x1 link
>    have the same bandwidth and share the same OPP entry.
- I will update the commit message as suggested in my next series.

- Krishna Chaitanya.

