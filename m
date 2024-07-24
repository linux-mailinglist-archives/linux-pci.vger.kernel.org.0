Return-Path: <linux-pci+bounces-10698-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AFA93ABB6
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 05:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C92CB22E2D
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 03:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DB822318;
	Wed, 24 Jul 2024 03:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OIjZcadv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7ADE208A9;
	Wed, 24 Jul 2024 03:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721793586; cv=none; b=t0LF7EpKZQ2EldKfZmSB/hjX/EONc/qnD5yAZLW2BHXs+A+Wl579KaZ65C1KvvO0XE4lO6N7Eq5Epb9b2A+eOQbvpCGS88GYXKVPYMlzTbooW9WmG3c5PnpnTlkTmibO7hKVFAFfQnREAzyd/KWhPtf/PH23N1TYMzS5YrkQCqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721793586; c=relaxed/simple;
	bh=0VE20oZP0wmAVruAQQVRDw7ejOfRwFGPRSoY26K5MAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Zinpja/hdKsfmHtoAC8EcwR7dR3J0ObCAQ7/QVeyCp+TmT6COjdYDnWVBZg1GTFACcYfVQSGNlrBzjEuKhe6bl9lvGepb79BVcKtypwemwXuLeZFepnfNh9nozA4BpkfcRrnIF5OlV/vQ/aR38/jeAmhHKAAtefhjI6ke84ZEbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OIjZcadv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46NKo3FA017629;
	Wed, 24 Jul 2024 03:58:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	o212+6TIMHBoyrOp43HqtASZK3an0lNABPbpwBJAH1o=; b=OIjZcadvNu6/WvV+
	3Um0BBHYAPuTs9A5LlFoullxk3+dYP0zkzteMBtaI0u1PVk3FbMAsFH8yUGgAodN
	gVgGOwgFWvPv/3DK49hDjErilgAUVtz8/M3NWSwSATO3oK1fLQY9TSGxl1dBRHLn
	MFRIl7NXYIMGn/FHlIG7xY/mtr58EODRFGGF6x54ML1KlI05yXJIWWf35OWHQ+33
	/Z2LRkMQQYGbMDEOqatObKMNVDl1lWSyQnpTJojiYhahX6hy/3szjcAX37ODchiR
	NQF2m1azYPwjfr9zzXaHLvHhqmBaL3+Jd3xu7npktN7vvLv95tYV541JeFfKn7F7
	kYnK9g==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g4jh0vyp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 03:58:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46O3wfqR023758
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 03:58:41 GMT
Received: from [10.110.5.87] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 23 Jul
 2024 20:58:39 -0700
Message-ID: <a87d4948-a9ce-473b-ae36-9f0c04c3041e@quicinc.com>
Date: Tue, 23 Jul 2024 20:58:38 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/7] Add power domain and MSI functionality with PCIe
 host generic ECAM driver
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <will@kernel.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <bhelgaas@google.com>, <jingoohan1@gmail.com>,
        <manivannan.sadhasivam@linaro.org>, <cassel@kernel.org>,
        <yoshihiro.shimoda.uh@renesas.com>, <s-vadapalli@ti.com>,
        <u.kleine-koenig@pengutronix.de>, <dlemoal@kernel.org>,
        <amishin@t-argos.ru>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <Frank.Li@nxp.com>,
        <ilpo.jarvinen@linux.intel.com>, <vidyas@nvidia.com>,
        <marek.vasut+renesas@gmail.com>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <quic_ramkri@quicinc.com>, <quic_nkela@quicinc.com>,
        <quic_shazhuss@quicinc.com>, <quic_msarkar@quicinc.com>,
        <quic_nitegupt@quicinc.com>
References: <1721067215-5832-1-git-send-email-quic_mrana@quicinc.com>
 <rzf5jaxs2g4usnqzgvisiols2zlizcqr3pg4b63kxkoaekkjdf@rleudqbiur5m>
Content-Language: en-US
From: Mayank Rana <quic_mrana@quicinc.com>
In-Reply-To: <rzf5jaxs2g4usnqzgvisiols2zlizcqr3pg4b63kxkoaekkjdf@rleudqbiur5m>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xD-o9rgLubvAh8DO3rguk09N3mB3WVjT
X-Proofpoint-GUID: xD-o9rgLubvAh8DO3rguk09N3mB3WVjT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_01,2024-07-23_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=506
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407240028



On 7/23/2024 7:13 PM, Dmitry Baryshkov wrote:
> On Mon, Jul 15, 2024 at 11:13:28AM GMT, Mayank Rana wrote:
>> Based on previously received feedback, this patch series adds functionalities
>> with existing PCIe host generic ECAM driver (pci-host-generic.c) to get PCIe
>> host root complex functionality on Qualcomm SA8775P auto platform.
>>
>> Previously sent RFC patchset to have separate Qualcomm PCIe ECAM platform driver:
>> https://lore.kernel.org/all/d10199df-5fb3-407b-b404-a0a4d067341f@quicinc.com/T/
>>
>> 1. Interface to allow requesting firmware to manage system resources and performing
>> PCIe Link up (devicetree binding in terms of power domain and runtime PM APIs is used in driver)
>> 2. Performing D3 cold with system suspend and D0 with system resume (usage of GenPD
>> framework based power domain controls these operations)
>> 3. SA8775P is using Synopsys Designware PCIe controller which supports MSI controller.
>> This MSI functionality is used with PCIe host generic driver after splitting existing MSI
>> functionality from pcie-designware-host.c file into pcie-designware-msi.c file.
> 
> Please excuse me my ignorance if this is described somewhere. Why are
> you using DWC-specific MSI handling instead of using GIC ITS?
Due to usage of GIC v3 on SA8775p with Gunyah hypervisor, we have 
limitation of not supporting GIC ITS
functionality. We considered other approach as usage of free SPIs (not 
available, limitation in terms of mismatch between number of SPIs 
available with physical GIC vs hypervisor) and extended SPIs (not 
supported with GIC hardware). Hence we just left with DWC-specific MSI 
controller here for MSI functionality.
>> Below architecture is used on Qualcomm SA8775P auto platform to get ECAM compliant PCIe
>> controller based functionality. Here firmware VM based PCIe driver takes care of resource
>> management and performing PCIe link related handling (D0 and D3cold). Linux VM based PCIe
>> host generic driver uses power domain to request firmware VM to perform these operations
>> using SCMI interface.
> 
Regards,
Mayank

