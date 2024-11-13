Return-Path: <linux-pci+bounces-16620-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E99CA9C68A9
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 06:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB4AF2831CD
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 05:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8DF1714CB;
	Wed, 13 Nov 2024 05:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="g5V9JwD8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054B0433CE;
	Wed, 13 Nov 2024 05:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731475490; cv=none; b=ipTs7qMxOAENCWjDM9qHJ5sjhkPxRDKI3xTDYTtT8elGGR4TSfwRYtc1C/XNXNJDM7wVTFNpVZZgIK4R81vwlaM8ufAJ2UNFSMO1NaWC2vSMTHX+Sm0E+I2LA7XaoctT979YoZeSyMmr1eWiogYzQoK+1Gx1u1h3lS8cs1OYfsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731475490; c=relaxed/simple;
	bh=++ZK1eWng+G0uvdmReXJNucOazbByuLdx468VaDOnLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DyMlAxjp8f4O8XCuFzsAU70KnoztEsI31iCERzdPrNGDD/qDGBJwHlUZhRJT3Ds4NnF7ZcI9jtzolq87rK2iudkzRDmZ8dOunag96dwrcefDz7QKglMy3OIWaDveevtMmgoxMq1CkvYfCFlqvbzKTOFrSUvxhaeQLIF4mF2E804=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=g5V9JwD8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACMRURk020707;
	Wed, 13 Nov 2024 05:24:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1mCmIuShdr4V8oXy7/eDo7kQN6piT7CsL1EVsN5eeuA=; b=g5V9JwD8aRu5Clvl
	rSpIReO7pnL9hqmHNuVM458XmJfnIpBA3JtvuOHTRrCKBAMGNhWevAvWQzd7fEot
	oUWRWfyR9ymrIk/cqsiu25wuea1GOkPkTAPy2qFIWgKpqigxv3nkn/QJhO4EYoPP
	Y8ihqrA3byUvsutb5oJeRPVaNkjCaVXmQvfNBGCVuiiFKTCZ4Wcs0pY1C4ze2doy
	Swpg0wunjxFG1dFhfymEeLln5ZIzBbQCqRGw5iZeuTT1TIPUA04caU8dq42tHhHd
	QoNenNCig8Zaju03fWBfl8ufGuKkpMLupLsQRFWG1+mb3HwUr9sGG3HBO4bcYDFy
	aHLyDg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42va079w4c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 05:24:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AD5OXZC023102
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 05:24:33 GMT
Received: from [10.216.46.238] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 12 Nov
 2024 21:24:29 -0800
Message-ID: <e84026cf-7b5b-a49b-6f82-f3af7c67f3ef@quicinc.com>
Date: Wed, 13 Nov 2024 10:54:26 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v7 2/2] PCI: Enable runtime pm of the host bridge
Content-Language: en-US
To: Markus Elfring <Markus.Elfring@web.de>, <linux-pci@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Kevin Xie
	<kevin.xie@starfivetech.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?=
	<kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Manivannan
 Sadhasivam" <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>
CC: LKML <linux-kernel@vger.kernel.org>,
        Marek Szyprowski
	<m.szyprowski@samsung.com>,
        Mayank Rana <quic_mrana@quicinc.com>,
        "Rafael J.
 Wysocki" <rafael@kernel.org>
References: <20241111-runtime_pm-v7-0-9c164eefcd87@quicinc.com>
 <20241111-runtime_pm-v7-2-9c164eefcd87@quicinc.com>
 <4de3c1d4-2488-40bf-8089-9e2246dbf28c@web.de>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <4de3c1d4-2488-40bf-8089-9e2246dbf28c@web.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lKkPckjgLSZvVyQGp6N6L6nm0V2BT8HM
X-Proofpoint-ORIG-GUID: lKkPckjgLSZvVyQGp6N6L6nm0V2BT8HM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 mlxlogscore=936 clxscore=1015 adultscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 mlxscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411130046



On 11/11/2024 10:16 PM, Markus Elfring wrote:
> …
>> PM framework expectes parent runtime pm enabled before enabling runtime
> 
>                 expects?                PM?
> 
> 
>> pm of the child. …
> 
>    PM?
> 
> 
>> drivers, before calling pci_host_probe() as pm frameworks expects if the
> 
>                                                PM framework?
> 
> 
>> parent device supports runtime pm then it needs to enabled before child
> 
>                                   PM?
> 
> 
>> runtime pm.
> 
>            PM?
> 
> 
> Can any tags (like “Fixes” and “Cc”) become helpful for the proposed change?
Bjorn,  This problem was present from starting on wards not sure what is 
the fix tag we need to use here, is it fine if we use fix tag as below.
as at this function only we are trying add the fix.

Fixes: 49b8e3f3ed1d4 ("PCI: Add generic function to probe PCI host 
controllers")

- Krishna Chaitanya.
> 
> Regards,
> Markus

