Return-Path: <linux-pci+bounces-11736-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7545954161
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2024 07:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECDEF1C20C13
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2024 05:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6124F3C24;
	Fri, 16 Aug 2024 05:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AhhFGsTm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC9A81ACB;
	Fri, 16 Aug 2024 05:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723787450; cv=none; b=On+Zm3q+S1VQmS9pteuAgNnEYfBFdj4trpmh7csaOc4XHcBDKLJVHoce9E6eLxQ1iN2e6cqB/uGrGzj4k4dVn6bq7kX1fw0vFIVMgsQnAqtO+Rs7B1ln8B9PFTnxVTZi2jJw6kIGDZiUrua0Yu2x3IlAtaH4sxNUy5p1q7dk4a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723787450; c=relaxed/simple;
	bh=X+dC19SNkF/3zkkyDBtVZz60ApU5tv+BD8Dx7X3mQaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Aq9p69FgOluAJS9S97V8glHrrDL04vTks+6SNG2eq5fzDYU78Nxp7N2KKP+DWiLldc0oW0HLJl0ji6KAYcIXsUup04tThNAzHH0/Morh+X2AjGHwvEoZjNEjmQAlut8se2OkWZbmifSV3Dmma+1RYHYLNtfNwPFel4cQjPYMMXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AhhFGsTm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47FNenEs019741;
	Fri, 16 Aug 2024 05:50:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YcWHXJb4lNanO3k4HO0F5e0ZHB8cGR8bbceP52zkwy8=; b=AhhFGsTm64lstMRB
	HJyNpt1cwIAqPgdrLkbdfqpz7uJGt0dI+BVqsV+kwQRg+GprlfrY7Kqu6vWV3WhP
	T+moqAIEHyhe8ISj8WnEtKjTWyoXEs5JuDgMUr0x4DFQb3lgFuSWwvVZtZ1eaJ3x
	QKwovLgK5E0k3csN5ao43GDJ2Ce6vyvSE08E6eL/gXtGA4uZIRPqJsrDCvu95VAl
	aGX0kh9v1+lHL3AARvg/yR/PMa2BJii2V6FsYPudlU2KhbMyXIz89qLbPV4G/v8L
	9RDLUgRotPnqVsTjG4I4J+znhHhSehlgRJx1G2LhHijtD6pjlXPVGC+jaOg0fpK+
	UukTmQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4103ws9bsr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Aug 2024 05:50:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47G5oils008866
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Aug 2024 05:50:44 GMT
Received: from [10.216.10.29] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 15 Aug
 2024 22:50:41 -0700
Message-ID: <117f21e3-94af-74dd-fd92-5d92e244bd3d@quicinc.com>
Date: Fri, 16 Aug 2024 11:20:38 +0530
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
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Helgaas
	<bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_vbadigan@quicinc.com>, <quic_ramkri@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_parass@quicinc.com>
References: <20240708-runtime_pm-v4-1-c02a3663243b@quicinc.com>
 <20240708073056.GC3866@thinkpad>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20240708073056.GC3866@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LnG9Ty7-G5YRBjQ6AlBe-aItHL3nMvAN
X-Proofpoint-ORIG-GUID: LnG9Ty7-G5YRBjQ6AlBe-aItHL3nMvAN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-15_18,2024-08-15_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408160040

Hi Bjorn,

can you please review this once.

Thanks & Regards,
Krishna Chaitanya.

On 7/8/2024 1:00 PM, Manivannan Sadhasivam wrote:
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
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Note to the maintainers: This patch should be applied at the start of the RC
> window to give enough testing in linux-next since it touches the PM of all host
> bridges.
> 
> - Mani
> 
>> ---
>> Changes in v4:
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
> 

