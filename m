Return-Path: <linux-pci+bounces-13072-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1F797650E
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 10:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6EF5B21278
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 08:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09B8191F6E;
	Thu, 12 Sep 2024 08:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GCHWaUx3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60FC126C16;
	Thu, 12 Sep 2024 08:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726131553; cv=none; b=psAK/wMdJxxQudH3dIgQU/iYWSB0XBHHQWAgEB5N7NlsuZ1weUXGz7InDXjrcIzHssElQ+GlxnmHaTGEUH7C4vhznx4SE7E/9dDWsO9OBnvTs+ldI4VVH2MUEMl+d6wWnnVbaMw3RJC/6sLMj7p5rWdZHUiz4mTdnfQeqWb+S6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726131553; c=relaxed/simple;
	bh=KtNs7TtMsBskAl71qNZJTVFRHbxRPgOUNG/liZGVZ4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=spquxdXjAKwB5VOl/7HTyq1+v5bMLQyUtcYwsoq72/AoWpCgUv8VAQdZxIFIdpLeYaUAIgPmYNbs/bFZQuj71aKbZzNAtrT3dJGq13mAEqSs5Hy24FQD8nT4tuR4Gz7c48ifIyDLA0R+g2+oCnlRVVzjeJDXijEZsdoPsoddEsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GCHWaUx3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48C2KxMY013919;
	Thu, 12 Sep 2024 08:58:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cUS+U9kCkSzvXeHe6zaaMU2mcz0i1vyb30Znxb5RkFE=; b=GCHWaUx3aC/S0HXS
	waW76snG/kk6YMlq3qBJDz9UW+wGFJTofPAdghko9T95tU3kd2PU7Cea+FJelKpp
	7ns2buznzKnvrXV5mC58moTDO0VME2ppll5nHliNo5884ojdvtbHgXfwvaYYI9qR
	08FNaNnnBC9S2Xo+ly8CQKP9c4oM+bHEqth6FAmx5mfiZ/aEcAwhXpeDc+wbY+qB
	kfZGxRcupfSrJ3GaVBuqf68AsnpWeNaADLNqBrp2aUeI84+e9pOcEZ80Blmqmyji
	+FNahu6w0lg/7i8mKHTXTGkTmTLn4LOeXO42PINP46h5nkE3n0MdIaPOVQ9QECNk
	ZNvRtA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gy8p4kc2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Sep 2024 08:58:49 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48C8wmdQ009680
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Sep 2024 08:58:48 GMT
Received: from [10.216.12.143] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 12 Sep
 2024 01:58:44 -0700
Message-ID: <90dca882-3c14-4c3e-aed2-e710593d2a9d@quicinc.com>
Date: Thu, 12 Sep 2024 14:28:41 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4] PCI: Enable runtime pm of the host bridge
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki"
	<rjw@rjwysocki.net>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_vbadigan@quicinc.com>, <quic_ramkri@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_parass@quicinc.com>, Mayank Rana
	<quic_mrana@quicinc.com>,
        Markus Elfring <Markus.Elfring@web.de>, <linux-pm@vger.kernel.org>
References: <20240816204539.GA73302@bhelgaas>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20240816204539.GA73302@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cB13-ZzqLNZyloOaHEjKIuR8mrOnbtF6
X-Proofpoint-ORIG-GUID: cB13-ZzqLNZyloOaHEjKIuR8mrOnbtF6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 impostorscore=0 mlxscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409120062



On 8/17/2024 2:15 AM, Bjorn Helgaas wrote:
> [+cc Rafael, Mayank, Markus (when people have commented on previous
> versions, please cc them on new versions).  I'm still hoping Rafael
> will have a chance to chime in]
> 
Rafael,

Can you please check on this behavior?

- Krishna Chaitanya.
> On Mon, Jul 08, 2024 at 10:19:40AM +0530, Krishna chaitanya chundru wrote:
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
>> will find it to be disabled.
> 
> I guess "will find it to be disabled"  means the child (host bridge)
> has runtime PM disabled, not that the child device is disabled, right?
> 
>> So it will allow the parent (controller
>> device) to go to runtime suspend. Only if the child device's state was
>> 'active' it will prevent the parent to get suspended.
> 
> Can we include a hint like the name of the function where the PM
> framework decides this?  Maybe this is rpm_check_suspend_allowed()?
> 
> rpm_check_suspend_allowed()  checks ".ignore_children", which sounds
> like it could be related, and AFAICS .ignore_children == false here,
> so .child_count should be relevant.
> 
> But I'm still confused about why we can runtime suspend a bridge that
> leads to devices that are not suspended.
> 
>> Since runtime PM is disabled for host bridge, the state of the child
>> devices under the host bridge is not taken into account by PM framework
>> for the top level parent, PCIe controller. So PM framework, allows
>> the controller driver to enter runtime PM irrespective of the state
>> of the devices under the host bridge. And this causes the topology
>> breakage and also possible PM issues like controller driver goes to
>> runtime suspend while endpoint driver is doing some transfers.
> 
> What does "topology breakage" mean?  Do you mean something other than
> the fact that an endpoint DMA might fail if the controller is
> suspended?
> 
>> So enable runtime PM for the host bridge, so that controller driver
>> goes to suspend only when all child devices goes to runtime suspend.
> 
> IIUC, the one-sentence description here is that previously, the PCI
> host controller could be runtime suspended even while an endpoint was
> active, which caused DMA failures.  And this patch changes that so the
> host controller is only runtime suspended after the entire hierarchy
> below it is runtime suspended?  Is that right?
> 
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>> Changes in v4:
> 
> (Note: v4 applies cleanly to v6.10-rc1 and to v6.11-rc1 with a small
> offset).
> 
>> - Changed pm_runtime_enable() to devm_pm_runtime_enable() (suggested by mayank)
>> - Link to v3: https://lore.kernel.org/lkml/20240609-runtime_pm-v3-1-3d0460b49d60@quicinc.com/
>> Changes in v3:
>> - Moved the runtime API call's from the dwc driver to PCI framework
>>    as it is applicable for all (suggested by mani)
>> - Updated the commit message.
>> - Link to v2: https://lore.kernel.org/all/20240305-runtime_pm_enable-v2-1-a849b74091d1@quicinc.com
>> Changes in v2:
>> - Updated commit message as suggested by mani.
>> - Link to v1: https://lore.kernel.org/r/20240219-runtime_pm_enable-v1-1-d39660310504@quicinc.com
>> ---
>>
>> ---
>>   drivers/pci/probe.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 8e696e547565..fd49563a44d9 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -3096,6 +3096,10 @@ int pci_host_probe(struct pci_host_bridge *bridge)
>>   	}
>>   
>>   	pci_bus_add_devices(bus);
>> +
>> +	pm_runtime_set_active(&bridge->dev);
>> +	devm_pm_runtime_enable(&bridge->dev);
>> +
>>   	return 0;
>>   }
>>   EXPORT_SYMBOL_GPL(pci_host_probe);
>>
>> ---
>> base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
>> change-id: 20240708-runtime_pm-978ccbca6130
>>
>> Best regards,
>> -- 
>> Krishna chaitanya chundru <quic_krichai@quicinc.com>
>>

