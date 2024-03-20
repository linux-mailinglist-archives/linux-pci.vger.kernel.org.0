Return-Path: <linux-pci+bounces-4964-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A9C881492
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 16:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 330771F23696
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 15:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5930C4F1E5;
	Wed, 20 Mar 2024 15:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lx6tJPUY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973D44EB3A;
	Wed, 20 Mar 2024 15:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710948467; cv=none; b=hGvlO1jH6AnwT5aQHmXa0ICt+AoUoRUH6qxXbGatiE+pAB1HUljMv6k0pvNdIMk+5QWrddSyVgessdyqdifIr9FRAdKcjZMqzA1JYPUmrhSAiPApWv86hXWpye5mrKEicuZT3jr34P3ryfBegeU8JJCwzO4ZjkX6vYYfqwtzn94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710948467; c=relaxed/simple;
	bh=VvXjFVhDC5UdCnZSDdvqRXiLwR+8ZN3m2Xh2BQnT37Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gNVzDO4uf4888KOs2/J2FKQRYxjqNPPyeDbpYo0rsH1QMIMKmJSkJ3cQsocnUR2RXkJpOEzzoCCkS1bmbG0hENq2lf+wEcVOgZsj8+8WQ1M6Esknitvk1ENI4Sq0Bg6S8N/rSAAlsA0n6m0PzcRNUR5Aw6Ic5M78LIHV4zS5blo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lx6tJPUY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42KEk1gS024538;
	Wed, 20 Mar 2024 15:27:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=LAuXmYxtnv4Z13tfrPTPny9q2D9yRDHGgVlUHJAfvZw=; b=lx
	6tJPUYF9sEoKuKLuKEMSd1lEUmRNRmyapeJywNYHG8dM4S+uNVwlzM4EZai7W/o8
	LBwTsXYqx7r8PG1O8Z0lQsrHEr+cWGVvmUR3A4F3NDPaagdskWvv4MGR4X5pHEe9
	7kmESDVN23z+BQYkp6R+rBXYrXMh9V4VzRVOBYAsWXsTZTPnD5PmN1yic2n7ExAr
	vsTkv3HFT3hdORUJpFWGz8eQPDlGrWrWCAI0efAv3B3d5TpydbjOQeE+Tw+hBQO3
	IlkCmxXBGR2D1d/aPhVztafQcfS07YnNaBFaEmO/2mxBvdxtZpiJGrzrjVcHgUHN
	w/feNtj5zLBNNLkq63Hw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wyxq90k7s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 15:27:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42KFRVu8026059
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 15:27:31 GMT
Received: from [10.216.53.102] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Mar
 2024 08:27:25 -0700
Message-ID: <83dfe28d-505b-4009-044c-684827a1656d@quicinc.com>
Date: Wed, 20 Mar 2024 20:57:20 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2] PCI: dwc: Enable runtime pm of the host bridge
Content-Language: en-US
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Helgaas
	<helgaas@kernel.org>
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jingoo Han
	<jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_vbadigan@quicinc.com>, <quic_ramkri@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_parass@quicinc.com>
References: <e83ed3e5-0c31-cfae-6f75-211709e79aa5@quicinc.com>
 <20240308171248.GA685266@bhelgaas> <20240319111148.GF52500@thinkpad>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20240319111148.GF52500@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wbtsVke2C90ulOLeApO9PlwAgo3ml6tG
X-Proofpoint-GUID: wbtsVke2C90ulOLeApO9PlwAgo3ml6tG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_10,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 clxscore=1011 priorityscore=1501 impostorscore=0 suspectscore=0
 phishscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403200123



On 3/19/2024 4:41 PM, Manivannan Sadhasivam wrote:
> On Fri, Mar 08, 2024 at 11:12:48AM -0600, Bjorn Helgaas wrote:
>> On Fri, Mar 08, 2024 at 08:38:52AM +0530, Krishna Chaitanya Chundru wrote:
>>> On 3/8/2024 3:25 AM, Bjorn Helgaas wrote:
>>>> [+to Rafael, sorry, another runtime PM question, beginning of thread:
>>>> https://lore.kernel.org/r/20240305-runtime_pm_enable-v2-1-a849b74091d1@quicinc.com]
>>>>
>>>> On Thu, Mar 07, 2024 at 07:28:54AM +0530, Krishna Chaitanya Chundru wrote:
>>>>> On 3/6/2024 1:27 AM, Bjorn Helgaas wrote:
>>>>>> On Tue, Mar 05, 2024 at 03:19:01PM +0530, Krishna chaitanya chundru wrote:
>>>>>>> The Controller driver is the parent device of the PCIe host bridge,
>>>>>>> PCI-PCI bridge and PCIe endpoint as shown below.
>>>>>>>
>>>>>>> 	PCIe controller(Top level parent & parent of host bridge)
>>>>>>> 			|
>>>>>>> 			v
>>>>>>> 	PCIe Host bridge(Parent of PCI-PCI bridge)
>>>>>>> 			|
>>>>>>> 			v
>>>>>>> 	PCI-PCI bridge(Parent of endpoint driver)
>>>>>>> 			|
>>>>>>> 			v
>>>>>>> 		PCIe endpoint driver
>>>>>>>
>>>>>>> Since runtime PM is disabled for host bridge, the state of the child
>>>>>>> devices under the host bridge is not taken into account by PM framework
>>>>>>> for the top level parent, PCIe controller. So PM framework, allows
>>>>>>> the controller driver to enter runtime PM irrespective of the state
>>>>>>> of the devices under the host bridge.
>>>>>>
>>>>>> IIUC this says that we runtime suspend the controller even though
>>>>>> runtime PM is disabled for the host bridge?  I have a hard time
>>>>>> parsing this; can you cite a function that does this or some relevant
>>>>>> documentation about how this part of runtime PM works?
>>>>>>
>>>>> Generally controller should go to runtime suspend when endpoint client
>>>>> drivers and pci-pci host bridge drivers goes to runtime suspend as the
>>>>> controller driver is the parent, but we are observing controller driver
>>>>> goes to runtime suspend even when client drivers and PCI-PCI bridge are
>>>>> in active state.
>>>>
>>>> It surprises me that a device could be suspended while children are
>>>> active.  A PCI-PCI bridge must be in D0 for any devices below it to be
>>>> active.  The controller is a platform device, not a PCI device, but I
>>>> am similarly surprised that we would suspend it when children are
>>>> active, which makes me think we didn't set the hierarchy up correctly.
>>>>
>>>> It doesn't seem like we should need to enable runtime PM for a parent
>>>> to keep it from being suspended when children are active.
>>>
>>> Here we are not enabling runtime PM of the controller device, we are
>>> enabling runtime PM for the bridge device which is maintained by the
>>> PCIe framework. The bridge device is the parent of the PCI-PCI
>>> bridge and child of the controller device. As the bridge device's
>>> runtime PM is not enabled the PM framework is ignoring the child's
>>> runtime status.
>>
>> OK, it's the host bridge, not the controller.
>>
>> I'm still surprised that the PM framework will runtime suspend a
>> device when child devices are active.
>>
> 
> There is a catch here. Even though the child devices are funtionally active, PM
> framework will only consider their runtime_pm state, which is initially set to
> 'disabled' for all devices. It is upto the device drivers to enable it when
> required.
> 
> Here is the initial runtime PM status of each device post boot:
> 
> Controller device -> disabled initially but enabled by pcie-qcom.c
> Host bridge -> disabled initially
> PCIe bridge -> disabled initially but conditionally enabled by portdrv.c
> PCIe devices -> disabled initially but enabled by respective drivers like WLAN
> 
> Now, when the controller device goes to runtime suspend, PM framework will check
> the runtime PM state of the child device (host bridge) and will find it to be
> disabled. So it will allow the parent (controller device) to go to runtime
> suspend. Only if the child device's state was 'active' it will prevent the
> parent to get suspended.
> 
> But you may wonder if this is ideal? IMO NO. But we cannot blame the PM
> framework here. The responsibility is within the device drivers to handle the PM
> state based on the usecase. Ideally, the host bridge driver should've handled
> runtime PM state during the probe time. Otherwise, PM framework wouldn't know
> when would be the best time to suspend the devices.
> 
>> And further confused about managing the host bridge runtime PM in a
>> controller driver.  Which other callers of pci_alloc_host_bridge() or
>> devm_pci_alloc_host_bridge() will need similar changes?
>>
> 
> This scenario applies to all host bridges. So I think we should enable it inside
> pci_host_probe().
> 
> - Mani
> 
I will these runtime enable inside the pci_host_probe().

- Krishna Chaitanya.

