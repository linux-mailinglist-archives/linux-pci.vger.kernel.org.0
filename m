Return-Path: <linux-pci+bounces-14234-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 825179993CB
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 22:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33579283795
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 20:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D3E1E00AC;
	Thu, 10 Oct 2024 20:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MKWXOq6M"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AED1D31BB;
	Thu, 10 Oct 2024 20:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728592800; cv=none; b=g+yiAPDy17VwreJJ7PqtUOFXGZ31vyi9620ZrfWu+ZgVVofXyZ7Y/8sTBy3mQKNgKQUNRWXDzQf6ArjRo6PjibMaqPVVnkqpofart9d/Dmte/uBUAc8UaYj+o921xYlAe6y7vKZwE+lzzWf4Cf2wALMGPNuNILw0s8Hl6b9Ginc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728592800; c=relaxed/simple;
	bh=gvg/+uA28ZLCDxBOzLVIsehg+7tsWeOs9wRkN5pt4cc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ib8gUo8fCdxXNjvTodGuinl0w6refd3Yrw+8rPY295kyTyn8mc/m1YRI5gqtz6gil4o6KEBRWuVHHV6MUeGCDjxVpCsSXuL2KiQlVDComHw2wmkz1oYaL35Fd4q7Bhox/EFcarbpsJhuiIjN1lETQ8UO12MiaNcDN1LjpAXOwhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MKWXOq6M; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49AC8lBe022368;
	Thu, 10 Oct 2024 20:39:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZeSNBww/XXF1XIhKa7vJtp6lzRT7/TSjC/iLBaxRmCM=; b=MKWXOq6MUPH2GzoJ
	T7n1GaCYoDV+VUQRQ+CqZIuMFybXojGy92tRS5yRYeNotcAXPrxsl64UqbHA5wcm
	klz5hBZ3GFa6RxAeZIhdQ1SlYHqMqJ11jbr/HGUcmat7rsCcn5BCgwIBJaxxNlYm
	4qWJwC5s4KukaLiY0/Ld+4gx/nMLm4jJWA0lnnhfsAl0Yi1idfnmGXl46V/m/8h0
	A219vdQZ4wubvjyvZc86erOIdEqANUZk3PTwxwsZ7ICRlzf5rz4/qY1ES57lb5yK
	TUfiIq5g0MTCXlaipeFBwqjk74bJIplFjhIL3HC83/EQD/0pHH58TB8H3cgkQub7
	o1Dimg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 425xptupe5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 20:39:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49AKdovH023358
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 20:39:50 GMT
Received: from [10.110.112.240] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 10 Oct
 2024 13:39:49 -0700
Message-ID: <1ca7b2e0-b479-4987-bce2-60208a917b8e@quicinc.com>
Date: Thu, 10 Oct 2024 13:39:49 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] PCI: Enable runtime pm of the host bridge
To: Bjorn Helgaas <helgaas@kernel.org>,
        Marek Szyprowski
	<m.szyprowski@samsung.com>
CC: Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Bjorn Helgaas
	<bhelgaas@google.com>,
        <manivannan.sadhasivam@linaro.org>, <Markus.Elfring@web.de>,
        <rafael@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_vbadigan@quicinc.com>, <quic_ramkri@quicinc.com>
References: <20241010192553.GA574352@bhelgaas>
Content-Language: en-US
From: Mayank Rana <quic_mrana@quicinc.com>
In-Reply-To: <20241010192553.GA574352@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _4Gapw19vlxi7ou0gaE5lSOKVKvK3K1L
X-Proofpoint-GUID: _4Gapw19vlxi7ou0gaE5lSOKVKvK3K1L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410100135

Hi Bjorn

On 10/10/2024 12:25 PM, Bjorn Helgaas wrote:
> On Wed, Oct 09, 2024 at 08:10:32PM +0200, Marek Szyprowski wrote:
>> On 03.10.2024 08:02, Krishna chaitanya chundru wrote:
>>> The Controller driver is the parent device of the PCIe host bridge,
>>> PCI-PCI bridge and PCIe endpoint as shown below.
>>>
>>>           PCIe controller(Top level parent & parent of host bridge)
>>>                           |
>>>                           v
>>>           PCIe Host bridge(Parent of PCI-PCI bridge)
>>>                           |
>>>                           v
>>>           PCI-PCI bridge(Parent of endpoint driver)
>>>                           |
>>>                           v
>>>                   PCIe endpoint driver
>>>
>>> Now, when the controller device goes to runtime suspend, PM framework
>>> will check the runtime PM state of the child device (host bridge) and
>>> will find it to be disabled. So it will allow the parent (controller
>>> device) to go to runtime suspend. Only if the child device's state was
>>> 'active' it will prevent the parent to get suspended.
>>>
>>> It is a property of the runtime PM framework that it can only
>>> follow continuous dependency chains.  That is, if there is a device
>>> with runtime PM disabled in a dependency chain, runtime PM cannot be
>>> enabled for devices below it and above it in that chain both at the
>>> same time.
>>>
>>> Since runtime PM is disabled for host bridge, the state of the child
>>> devices under the host bridge is not taken into account by PM framework
>>> for the top level parent, PCIe controller. So PM framework, allows
>>> the controller driver to enter runtime PM irrespective of the state
>>> of the devices under the host bridge. And this causes the topology
>>> breakage and also possible PM issues like controller driver goes to
>>> runtime suspend while endpoint driver is doing some transfers.
>>>
>>> Because of the above, in order to enable runtime PM for a PCIe
>>> controller device, one needs to ensure that runtime PM is enabled for
>>> all devices in every dependency chain between it and any PCIe endpoint
>>> (as runtime PM is enabled for PCIe endpoints).
>>>
>>> This means that runtime PM needs to be enabled for the host bridge
>>> device, which is present in all of these dependency chains.
>>>
>>> After this change, the host bridge device will be runtime-suspended
>>> by the runtime PM framework automatically after suspending its last
>>> child and it will be runtime-resumed automatically before resuming its
>>> first child which will allow the runtime PM framework to track
>>> dependencies between the host bridge device and all of its
>>> descendants.
>>>
>>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>>> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>
>> This patch landed in today's linux-next as commit 02787a3b4d10 ("PCI/PM:
>> Enable runtime power management for host bridges"). In my tests I found
>> that it triggers a warning on StarFive VisionFive2 RISC-V board. It
>> looks that some more changes are needed in the dwc-pci driver or so.
>> There is a message from runtime pm subsystem about inactive device with
>> active children and suspicious locking pattern. Here is the log I
>> observed on that board:
>> ...
> 
> Thanks very much for the testing and report, Marek!
> 
> I dropped this patch from the PCI -next for now.  We can add it back
> with the fix squashed into it after the complete patch is posted and
> tested.

I just sent fix for above issue as
https://patchwork.kernel.org/project/linux-pci/patch/20241010202950.3263899-1-quic_mrana@quicinc.com/

Can you please consider to include both changes if proposed fix looks 
good and if feasible ?

Regards,
Mayank

> 
> Bjorn

