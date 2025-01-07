Return-Path: <linux-pci+bounces-19418-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A18E6A041F4
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 15:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E5F71887600
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 14:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D903A1F5420;
	Tue,  7 Jan 2025 14:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RE3TvC+Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399121F4260;
	Tue,  7 Jan 2025 14:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736259082; cv=none; b=RYrhZrJ38U+FGpfi/yOWNlqq0XwULTvrxIy1OMXnRZ8GAQyCYF5fSxsRke8DzXmprn3nMxR6La8sG0QseqJMVEMHpNmVqw2464MnBlQqxv+Qy+y7yObUsFdPKOSfH3a4Own+rhJQMfSmsij8C53pj9Mbyr2H2GeTo0q6QBfP0B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736259082; c=relaxed/simple;
	bh=AD3/wKV5WOZutg4qZXJn6sKHDJEcJf3XoFskHuQ9QYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HjYj6vzI61v5UqyxodyPuzisjarT8ELT6uraUD12FSiNQdQ6FwFx5Dd/hctEubK6twj6piqn07VjXqpqV3UtnOZig5OeFNQ3KrmVNugPY6FKfhu18rqRTrLlQ7IW2UjW9x0Wd+c4qygITK3Y4XPM73W4yqoHcH5Ur5VZFHcwdMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RE3TvC+Z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5078bcPx010596;
	Tue, 7 Jan 2025 14:10:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9BqVYDyjTuKAUifBsKjiMixAWxJjGwGSkcVFJi1pONI=; b=RE3TvC+ZnBQ20+TD
	gqCWP9MauVpISwPYpZgZb6RCGHAL1smCfAolp2Gnrh/I5SQb5Y03pfcVLDV0LY48
	8itsalDDikCT6muriWKeeZLsz+wasoKXUjBSKUGpbZabJNgo7RbY/VrYNSGMvniP
	miNb/+rsqTWEPOlrbviXMuqVI2thKwvwne3odJNhTaswnhojAyJopO31fQN0nVuE
	pOxAhDqzj6xhHUDOXYFmZftOzMbRO09+xywpGtOtfBnx1Cu7oIN/T6Va5eoNW3iP
	WTc9yntotQhJcwyhbvcbpQKhPEDtCpqHFF04wq9auAPZ8httpmuQT2C6bmJN3vzj
	fVT42Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4410x2rst3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 14:10:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 507EAnCP012031
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 7 Jan 2025 14:10:49 GMT
Received: from [10.216.0.179] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 7 Jan 2025
 06:10:43 -0800
Message-ID: <7882105f-93a3-fab9-70a2-2dc55d6becfc@quicinc.com>
Date: Tue, 7 Jan 2025 19:40:39 +0530
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
To: Johan Hovold <johan@kernel.org>
CC: Kevin Xie <kevin.xie@starfivetech.com>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?=
	<kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "Rob Herring" <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        <Markus.Elfring@web.de>, <quic_mrana@quicinc.com>, <rafael@kernel.org>,
        <m.szyprowski@samsung.com>, <linux-pm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <regressions@lists.linux.dev>
References: <20241111-runtime_pm-v7-0-9c164eefcd87@quicinc.com>
 <20241111-runtime_pm-v7-2-9c164eefcd87@quicinc.com>
 <Z30p2Etwf3F2AUvD@hovoldconsulting.com>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <Z30p2Etwf3F2AUvD@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vQ9bITkFVOVs3ispl7A_dbULvAWq8RmJ
X-Proofpoint-ORIG-GUID: vQ9bITkFVOVs3ispl7A_dbULvAWq8RmJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 malwarescore=0 clxscore=1011
 phishscore=0 adultscore=0 mlxlogscore=999 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501070118



On 1/7/2025 6:49 PM, Johan Hovold wrote:
> On Mon, Nov 11, 2024 at 02:11:53PM +0530, Krishna chaitanya chundru wrote:
>> The Controller driver is the parent device of the PCIe host bridge,
>> PCI-PCI bridge and PCIe endpoint as shown below.
>>
>>          PCIe controller(Top level parent & parent of host bridge)
>>                          |
>>                          v
>>          PCIe Host bridge(Parent of PCI-PCI bridge)
>>                          |
>>                          v
>>          PCI-PCI bridge(Parent of endpoint driver)
>>                          |
>>                          v
>>                  PCIe endpoint driver
>>
>> Now, when the controller device goes to runtime suspend, PM framework
>> will check the runtime PM state of the child device (host bridge) and
>> will find it to be disabled. So it will allow the parent (controller
>> device) to go to runtime suspend. Only if the child device's state was
>> 'active' it will prevent the parent to get suspended.
> 
>> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> 
>> @@ -3106,6 +3106,17 @@ int pci_host_probe(struct pci_host_bridge *bridge)
>>   		pcie_bus_configure_settings(child);
>>   
>>   	pci_bus_add_devices(bus);
>> +
>> +	/*
>> +	 * Ensure pm_runtime_enable() is called for the controller drivers,
>> +	 * before calling pci_host_probe() as pm frameworks expects if the
>> +	 * parent device supports runtime pm then it needs to enabled before
>> +	 * child runtime pm.
>> +	 */
>> +	pm_runtime_set_active(&bridge->dev);
>> +	pm_runtime_no_callbacks(&bridge->dev);
>> +	devm_pm_runtime_enable(&bridge->dev);
>> +
>>   	return 0;
>>   }
>>   EXPORT_SYMBOL_GPL(pci_host_probe);
> 
> I just noticed that this change in 6.13-rc1 is causing the following
> warning on resume from suspend on machines like the Lenovo ThinkPad
> X13s:
>
Hi Johan,

Can you confirm if you are seeing this issue is seen in the boot-up
case also. As this part of the code executes only at the boot time and
will not have effect in resume from suspend.

> 	pci0004:00: pcie4: Enabling runtime PM for inactive device with active children
> 
I believe this is not causing any functional issues.
> which may have unpopulated ports (this laptop SKU does not have a modem).
> 
Can you confirm if this warning goes away if there is some endpoint
connected to it.

- Krishna Chaitanya.
> Reverting dc421bb3c0db ("PCI: Enable runtime PM of the host bridge")
> makes the warning go away.
> 
> Johan
> 
> 
> #regzbot introduced: dc421bb3c0db

