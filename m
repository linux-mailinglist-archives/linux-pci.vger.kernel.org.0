Return-Path: <linux-pci+bounces-4634-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FB4875C91
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 04:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB7251C21101
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 03:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188B828E09;
	Fri,  8 Mar 2024 03:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="U8C6qLJc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E12B1CFB5;
	Fri,  8 Mar 2024 03:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709867358; cv=none; b=rhC6B3L2ZQ6L/NZjd2eD40AkHpT9UZaDCEw/CITk80/hUklw7IaugfmkeZgfgfI55yvp6IGLZgsgzdEASYNDwXTmP8r27eiddR4lwDhZ9qBDqeTb7ywYboks2+dmjV+0nnDLQM/mIXwFYaPl/gzv3s9V+DaqewBRrp0ZJUBOZ0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709867358; c=relaxed/simple;
	bh=f9cqgc6EofVeo+oTsMNSF+u55WfFESfvv7lq6Pl1hG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Wpr6bIT9D0+fWc36sZ+aj2FowIIiXVNTKRoBC2XpjP7qhjs5CI00EN4D/LSr3Vl5yWx9R9kQRaLDQoSuVVCxRe/AMSTVWhRDP2y5YLWjgVKrcQZ6Z1dVOcmPTNhQqlW+uzq7pzHczUn2gWkH6vwSTahzQhIFWn6nKiAbIC23RPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=U8C6qLJc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4282TQp4019873;
	Fri, 8 Mar 2024 03:09:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=JgzMyM7eqHzbroMRm9aZ0Mdd0JyjIWl25BdSwhb/aAU=; b=U8
	C6qLJcvP+e4/g88jlFUOJouTWouYzXm7/e6x+/h5DdHsqssTrSZ8U1GXIBLj6IZO
	LEb6VklyPJAwf0FSkidw+p90c/VyhrHp46ebaco17HsgIRm6ih3agYCIQ0vlR023
	dSdhbIn/fm0xfmfOA8dxbbY9Wz60PxywXDhplFHusRoKNrF6fee1lWN5wYnq0YCM
	M3wooucUxP0bGj0l4br9aRUh8E+36KOh/MNnWzVUHPefwEpeLBLDJtYMf8xo48KR
	3gIYTe+LcDU2/f+Ff3aSEN0NV0YXtRi2PbYiZY3wyDh7c49mFl31z1ssTMJdTdi2
	O89WjgS86s8AicGJ8E0Q==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wqn8n0kfy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 03:09:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 428392oG013851
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 8 Mar 2024 03:09:02 GMT
Received: from [10.216.20.61] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 7 Mar
 2024 19:08:56 -0800
Message-ID: <e83ed3e5-0c31-cfae-6f75-211709e79aa5@quicinc.com>
Date: Fri, 8 Mar 2024 08:38:52 +0530
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
To: Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki"
	<rjw@rjwysocki.net>
CC: Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel
	<gustavo.pimentel@synopsys.com>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_vbadigan@quicinc.com>, <quic_ramkri@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_parass@quicinc.com>
References: <20240307215505.GA632869@bhelgaas>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20240307215505.GA632869@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Zr3Z94GuKV4sm2K3ytlSAPueUTSiyLlz
X-Proofpoint-GUID: Zr3Z94GuKV4sm2K3ytlSAPueUTSiyLlz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_02,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403080024



On 3/8/2024 3:25 AM, Bjorn Helgaas wrote:
> [+to Rafael, sorry, another runtime PM question, beginning of thread:
> https://lore.kernel.org/r/20240305-runtime_pm_enable-v2-1-a849b74091d1@quicinc.com]
> 
> On Thu, Mar 07, 2024 at 07:28:54AM +0530, Krishna Chaitanya Chundru wrote:
>> On 3/6/2024 1:27 AM, Bjorn Helgaas wrote:
>>> On Tue, Mar 05, 2024 at 03:19:01PM +0530, Krishna chaitanya chundru wrote:
>>>> The Controller driver is the parent device of the PCIe host bridge,
>>>> PCI-PCI bridge and PCIe endpoint as shown below.
>>>>
>>>> 	PCIe controller(Top level parent & parent of host bridge)
>>>> 			|
>>>> 			v
>>>> 	PCIe Host bridge(Parent of PCI-PCI bridge)
>>>> 			|
>>>> 			v
>>>> 	PCI-PCI bridge(Parent of endpoint driver)
>>>> 			|
>>>> 			v
>>>> 		PCIe endpoint driver
>>>>
>>>> Since runtime PM is disabled for host bridge, the state of the child
>>>> devices under the host bridge is not taken into account by PM framework
>>>> for the top level parent, PCIe controller. So PM framework, allows
>>>> the controller driver to enter runtime PM irrespective of the state
>>>> of the devices under the host bridge.
>>>
>>> IIUC this says that we runtime suspend the controller even though
>>> runtime PM is disabled for the host bridge?  I have a hard time
>>> parsing this; can you cite a function that does this or some relevant
>>> documentation about how this part of runtime PM works?
>>>
>> Generally controller should go to runtime suspend when endpoint client
>> drivers and pci-pci host bridge drivers goes to runtime suspend as the
>> controller driver is the parent, but we are observing controller driver
>> goes to runtime suspend even when client drivers and PCI-PCI bridge are
>> in active state.
> 
> It surprises me that a device could be suspended while children are
> active.  A PCI-PCI bridge must be in D0 for any devices below it to be
> active.  The controller is a platform device, not a PCI device, but I
> am similarly surprised that we would suspend it when children are
> active, which makes me think we didn't set the hierarchy up correctly.
> 
> It doesn't seem like we should need to enable runtime PM for a parent
> to keep it from being suspended when children are active.
Here we are not enabling runtime PM of the controller device, we are
enabling runtime PM for the bridge device which is maintained by the
PCIe framework. The bridge device is the parent of the PCI-PCI bridge
and child of the controller device. As the bridge device's runtime
PM is not enabled the PM framework is ignoring the child's runtime
status.

- Krishna Chaitanya.

>>>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>>>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>>>> @@ -16,6 +16,7 @@
>>>>   #include <linux/of_pci.h>
>>>>   #include <linux/pci_regs.h>
>>>>   #include <linux/platform_device.h>
>>>> +#include <linux/pm_runtime.h>
>>>>
>>>>   #include "../../pci.h"
>>>>   #include "pcie-designware.h"
>>>> @@ -505,6 +506,9 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>>>>          if (pp->ops->post_init)
>>>>                  pp->ops->post_init(pp);
>>>>
>>>> +       pm_runtime_set_active(&bridge->dev);
>>>> +       pm_runtime_enable(&bridge->dev);
>>>> +
>>>>          return 0;
>>>>
>>>>   err_stop_link:
> 
> Bjorn

