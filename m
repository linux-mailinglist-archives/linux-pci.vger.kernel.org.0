Return-Path: <linux-pci+bounces-11796-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EFE9562B3
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 06:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66F131F213F8
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 04:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4A3328DB;
	Mon, 19 Aug 2024 04:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="K+ZoYqNh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C586C5464A;
	Mon, 19 Aug 2024 04:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724043005; cv=none; b=Up/5kOTHteZqlP1sqnsCCOIjpQNcAxFEc/KNCF2tJf08Cv8N3uugtLssNJejAJ/pREwUm9uN+lXduvFbghelBIQSEr5ivIbbxEQ96b5Op4SXxgNg0r6V65QBfoUcV4jLlg7mXEVit2sItsYiv0DSwBKo34MDawWUdlMrgVcnKpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724043005; c=relaxed/simple;
	bh=Sn9c3xLWKxuyQErvRdQPWfBHjq7w3ObdwIwihxHQK8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kSRtITuik05WNyUPCZIzfvyav1VsLp//sHfrQVuLrpQyuEchDoIi9L+CarhvmRBTWePfH28M+ctZYAY2M2eWF1N7JZWitOtasxCGSDwnuJFxl0o3t4aEtsYFi8YfbuADOa/FM0y+yDLO0rAeMBRKyxTTRJNMsRhPfLNAkv4bY8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=K+ZoYqNh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47ILDVWP025706;
	Mon, 19 Aug 2024 04:49:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jtE0MZORCoRbMxjJSRDPYDNOhI1yObjbUvAPmjpYaL0=; b=K+ZoYqNhz9Xr7v93
	/P8FU52umR31g3PCXeXTfLqoGtlb++cwkLDrXyVeMTL5kWs+AX6Lnzm7aDBhL0dv
	BfC/Xez7FMcZPn3RkiVrL0uSfMloqvrIcRigrpz9t7A2n0tDSiRtm5zb4bDJWzJb
	ydBv4qPykkqtquezP6M4o0XmxGCU/ncKQ8X6RfVI9895cq1gt1ssu7H94YXCUG4x
	mQRHIL8eyaOHldujA7SynWkw4EvI+7+Ps0OgRn6QVhbVHGnyPU204mC+7Pc/YwXY
	t6lb119QEuWegFsxv1Vlv6pR9T7N0XyZRSDtvcvQq3ru6jsuIF+gMBSGEGFXKTQK
	/PuooA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 412n582wfw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 04:49:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47J4nqvA027574
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 04:49:52 GMT
Received: from [10.216.29.179] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 18 Aug
 2024 21:49:48 -0700
Message-ID: <ecd10fb3-ca08-53f7-55bd-c3c437ba310c@quicinc.com>
Date: Mon, 19 Aug 2024 10:19:45 +0530
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
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_vbadigan@quicinc.com>, <quic_ramkri@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_parass@quicinc.com>, "Rafael J. Wysocki"
	<rjw@rjwysocki.net>,
        Mayank Rana <quic_mrana@quicinc.com>,
        Markus Elfring
	<Markus.Elfring@web.de>, <linux-pm@vger.kernel.org>
References: <20240816204539.GA73302@bhelgaas>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20240816204539.GA73302@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mVUcMFSXluVfXcZffPPUvyIGPHmUcZMa
X-Proofpoint-ORIG-GUID: mVUcMFSXluVfXcZffPPUvyIGPHmUcZMa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_02,2024-08-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1011 spamscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408190033



On 8/17/2024 2:15 AM, Bjorn Helgaas wrote:
> [+cc Rafael, Mayank, Markus (when people have commented on previous
> versions, please cc them on new versions).  I'm still hoping Rafael
> will have a chance to chime in]
> 
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
yes host bridge runtime PM is disabled.
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
Ack.
> But I'm still confused about why we can runtime suspend a bridge that
> leads to devices that are not suspended.
> >> Since runtime PM is disabled for host bridge, the state of the child
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
yes and it depends on the runtime suspend implementation of the
controller driver.

>> So enable runtime PM for the host bridge, so that controller driver
>> goes to suspend only when all child devices goes to runtime suspend.
> 
> IIUC, the one-sentence description here is that previously, the PCI
> host controller could be runtime suspended even while an endpoint was
> active, which caused DMA failures.  And this patch changes that so the
> host controller is only runtime suspended after the entire hierarchy
> below it is runtime suspended?  Is that right?
> 
yes bjorn this is correct.
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>> Changes in v4:
> 
> (Note: v4 applies cleanly to v6.10-rc1 and to v6.11-rc1 with a small
> offset).
> 
Based upon the further comments I will send a v5. If there is no
response from Rafael can you apply this patch by correcting that offset.

- Krishna Chaitanya.
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

