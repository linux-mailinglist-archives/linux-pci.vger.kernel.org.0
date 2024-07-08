Return-Path: <linux-pci+bounces-9902-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B289929B4C
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 06:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15461B20DBF
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 04:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47C86FB9;
	Mon,  8 Jul 2024 04:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KDDjJCPV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF160AD21;
	Mon,  8 Jul 2024 04:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720412936; cv=none; b=OMRFwBVXO+5z7xhhomr7SmMAhMh/NkBa3gDZtFDe1OTUEL8zfemhkljgR31z8GRzxy+fRRJxDGxFJbp75Lfez/CUEWEXLY2Xo06XIG0Wblgyp3xZCONM4Gleodcj3EuKrPOR9vZ2PT/dv5tVLQiUv26DCrFz3In1cNOZ4t24LCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720412936; c=relaxed/simple;
	bh=u2dvuQpQzqhCs0g4IjQ4wZu0OThTOkRlkLcVW5za8e0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WO1FrKtMr+HEptE7ox65sUm9iAOGsk3DUVb1zUA0D7QKFQhBfFU0MUfUScdxBpyNn3rlCD9LOifvE2pRaXJIvXx+EGe6kzVnm9hDjF4h8J/jbgnjyBa6mPC/jIBYd0jt5LhQrO9b63LqNLWJemlLNhKS/zkynpkAvMHV5L43aG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KDDjJCPV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 467Moh8P017926;
	Mon, 8 Jul 2024 04:28:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TAV6s6XApo1U20XEbYHTaWuf5u8aUOnk4RbEr7gq3qs=; b=KDDjJCPVj7MVkc7D
	q+o9QFF8mMDjLShVQGmCIJm59eDnG34DHldbfZqUDr99uaeZyjzph5BQkO0f8C4R
	3R5TQyD3uYRlyeu8L9sL2ANhBr3p4zlPNytlGvqt2jYFh9X3BbfUz3ggbU5ml9Yz
	S9zuFiztE1iy3gynzlHty55jTsB9M4niHKHMhMS18WK6YCO+Xp0UZYTVTBYxMfKJ
	U5wHE/RxbIBCgt8aTenx+/VPwatOzc0b2Nvh5sx6ZaM9J8ZQRZopgLE5us5fp5lk
	JCEpANzj2zIhPIgvNDh9eIkKfv8nxRJYjPg/7+u57IM6EB/I+LLixhoiOkkGxtI7
	vgp4Bg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406wg3tmtj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jul 2024 04:28:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4684Sla5005382
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jul 2024 04:28:47 GMT
Received: from [10.216.31.252] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 7 Jul 2024
 21:28:44 -0700
Message-ID: <31f75b20-7e7b-c070-bd52-9343276a43e3@quicinc.com>
Date: Mon, 8 Jul 2024 09:58:40 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3] PCI: Enable runtime pm of the host bridge
Content-Language: en-US
To: Mayank Rana <quic_mrana@quicinc.com>, Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Rafael J.
 Wysocki" <rjw@rjwysocki.net>, <quic_vbadigan@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_parass@quicinc.com>
References: <20240609-runtime_pm-v3-1-3d0460b49d60@quicinc.com>
 <4b81e0f0-ecc6-44b3-9388-aacf54230788@quicinc.com>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <4b81e0f0-ecc6-44b3-9388-aacf54230788@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xkaQo6iEjunOtJ1z9jUWT4C8JDmNR5K_
X-Proofpoint-GUID: xkaQo6iEjunOtJ1z9jUWT4C8JDmNR5K_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_01,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 clxscore=1011 impostorscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407080033



On 6/11/2024 12:04 AM, Mayank Rana wrote:
> 
> On 6/8/2024 8:14 PM, Krishna chaitanya chundru wrote:
>> The Controller driver is the parent device of the PCIe host bridge,
>> PCI-PCI bridge and PCIe endpoint as shown below.
>>
>>          PCIe controller(Top level parent & parent of host bridge)
>>                          |
>>                          v
>>          PCIe Host bridge(Parent of PCI-PCI bridge)
>>                          |
>>                          v
>>          PCI-PCI bridge(Parent of endpoint driver)
>>                          |
>>                          v
>>                  PCIe endpoint driver
>>
>> Now, when the controller device goes to runtime suspend, PM framework
>> will check the runtime PM state of the child device (host bridge) and
>> will find it to be disabled. So it will allow the parent (controller
>> device) to go to runtime suspend. Only if the child device's state was
>> 'active' it will prevent the parent to get suspended.
>>
>> Since runtime PM is disabled for host bridge, the state of the child
>> devices under the host bridge is not taken into account by PM framework
>> for the top level parent, PCIe controller. So PM framework, allows
>> the controller driver to enter runtime PM irrespective of the state
>> of the devices under the host bridge. And this causes the topology
>> breakage and also possible PM issues like controller driver goes to
>> runtime suspend while endpoint driver is doing some transfers.
>>
>> So enable runtime PM for the host bridge, so that controller driver
>> goes to suspend only when all child devices goes to runtime suspend.
>>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>> Changes in v3:
>> - Moved the runtime API call's from the dwc driver to PCI framework
>>    as it is applicable for all (suggested by mani)
>> - Updated the commit message.
>> - Link to v3: 
>> https://lore.kernel.org/all/20240305-runtime_pm_enable-v2-1-a849b74091d1@quicinc.com
>> Changes in v2:
>> - Updated commit message as suggested by mani.
>> - Link to v1: 
>> https://lore.kernel.org/r/20240219-runtime_pm_enable-v1-1-d39660310504@quicinc.com
>> ---
>>
>> ---
>>   drivers/pci/probe.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 20475ca30505..b7f9ff75b0b3 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -3108,6 +3108,10 @@ int pci_host_probe(struct pci_host_bridge *bridge)
>>           pcie_bus_configure_settings(child);
>>       pci_bus_add_devices(bus);
>> +
>> +    pm_runtime_set_active(&bridge->dev);
>> +    pm_runtime_enable(&bridge->dev);
> Can you consider using devm_pm_runtime_enable() instead of 
> pm_runtime_enable() ?
> It serves calling pm_runtime_disable() when bridge device is removed as 
> seeing pcie driver is using pci_host_probe() after allocating bridge 
> device, and as part of pcie driver removal calls pci_remove_host_bus(), 
> and bridge device would be freed, but it doesn't call 
> pm_runtime_disable() on it. I don't see any specific functionality issue 
> here as bridge device would be freed anyway, although as we have way to 
> undo what is probe() is doing when bridge device is binding with bridge 
> device. Perhaps we can use available mechanism.
> 
> Regards,
> Mayank
Sure I will add as suggested in my next patch.

- Krishna Chaitanya
>>       return 0;
>>   }
>>   EXPORT_SYMBOL_GPL(pci_host_probe);
>>
>> ---
>> base-commit: 30417e6592bfc489a78b3fe564cfe1960e383829
>> change-id: 20240609-runtime_pm-7e6de1190113
>>
>> Best regards,

