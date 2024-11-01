Return-Path: <linux-pci+bounces-15764-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C78C9B888F
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 02:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 505851C21968
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 01:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8E455896;
	Fri,  1 Nov 2024 01:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kas7r+OI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820031EF1D;
	Fri,  1 Nov 2024 01:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730424925; cv=none; b=LhvHcGLgBEEF8m43bccRTefLFUpCJECtMWI7ntDavfBAn2LKV/3qr094nFyRyhWkrQos5hCaTUglmKMFo3iUMDmJZ027m5h7Nnlwvxw1KfUmu1jgAwuYrIxSOaD4I+BgGIzxvwL1qA7cOeUiz/Z7xalYOwBtWYK6QXrBGPQhF4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730424925; c=relaxed/simple;
	bh=CHQYwTaOoB5G1FjEGqeMsZNtf+ecf+kThedH0H2MY50=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Obx4bXU3GnlwnMuT4G/mwFg7CG0URlfem6B1ImT8kcLH0n6EG6Ae3Lsnvsf9zgJdMWwmw8kxNLcx+xUi8lW0yFgTO6T/FiCjWT40l6q4jyxi3hrmBlmw68v7B1YRs1i527yplW3RMY6z58OvpAmcdboWoH5BHXEAe0FWYPnNaI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kas7r+OI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49VMxlUe012383;
	Fri, 1 Nov 2024 01:34:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R790T1EHXVODECLYBvEJ72O5oSHDdrKj+hvqIaPzC/4=; b=kas7r+OIftD3Fbkz
	N9PijBOLN6EhdBgJrt4OuEbBAlhFsEQ0QDpjW/jDa/8y9iVYT/s5pToAyLvzaYfW
	RFeqLt6sz4TcbOqgJuPIg8TVzbqp9FD3aX1RCkrWpNyRTQgOft0/XPlYNbnjwxol
	t5ATfqy8cAaPRKzIqu0rOWqw4Y813rp6Nr/3elnWLSjj2euE82vuhi2IUrdoJccu
	N9D/G7lPC2M7f2KsHnG8HnijrjZEWz6P8jOoE72htrpocatHUQRDaHTTnhE6Rydk
	02isenHI3Oii3HAyrFKL6Z+MsSGRhBy6LI+snXK3gmd/6txnYjHsiy3/nGwgbxw0
	IQXPlA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42m65pakec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Nov 2024 01:34:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A11Ysvk018649
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 1 Nov 2024 01:34:54 GMT
Received: from [10.216.14.24] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 31 Oct
 2024 18:34:50 -0700
Message-ID: <4f21ad43-294b-5ec0-4e92-c21d6b3cbe9a@quicinc.com>
Date: Fri, 1 Nov 2024 07:04:46 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 2/2] PCI: Enable runtime pm of the host bridge
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Kevin Xie <kevin.xie@starfivetech.com>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?=
	<kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "Rob Herring" <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        <Markus.Elfring@web.de>, <quic_mrana@quicinc.com>, <rafael@kernel.org>,
        <m.szyprowski@samsung.com>, <linux-pm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241029153546.GA1156846@bhelgaas>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20241029153546.GA1156846@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: spCg1FgvsLDzBvppsEly_fmvrt02yMC8
X-Proofpoint-GUID: spCg1FgvsLDzBvppsEly_fmvrt02yMC8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 phishscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411010009



On 10/29/2024 9:05 PM, Bjorn Helgaas wrote:
> On Thu, Oct 17, 2024 at 09:05:51PM +0530, Krishna chaitanya chundru wrote:
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
>> It is a property of the runtime PM framework that it can only
>> follow continuous dependency chains.  That is, if there is a device
>> with runtime PM disabled in a dependency chain, runtime PM cannot be
>> enabled for devices below it and above it in that chain both at the
>> same time.
>>
>> Since runtime PM is disabled for host bridge, the state of the child
>> devices under the host bridge is not taken into account by PM framework
>> for the top level parent, PCIe controller. So PM framework, allows
>> the controller driver to enter runtime PM irrespective of the state
>> of the devices under the host bridge. And this causes the topology
>> breakage and also possible PM issues like controller driver goes to
>> runtime suspend while endpoint driver is doing some transfers.
>>
>> Because of the above, in order to enable runtime PM for a PCIe
>> controller device, one needs to ensure that runtime PM is enabled for
>> all devices in every dependency chain between it and any PCIe endpoint
>> (as runtime PM is enabled for PCIe endpoints).
>>
>> This means that runtime PM needs to be enabled for the host bridge
>> device, which is present in all of these dependency chains.
> 
> Earlier I asked about how we can verify that no other drivers need a
> change like the starfive one:
> https://lore.kernel.org/r/20241012140852.GA603197@bhelgaas
>
Hi Bjorn,

I added those details in cover letter as you suggested to add them in
cover letter.
"PM framework expectes parent runtime pm enabled before enabling runtime
pm of the child. As PCIe starfive device is enabling runtime pm after
the pci_host_probe which enables runtime pm of the child device i.e for
the bridge device a warning is shown saying "pcie-starfive 940000000.pcie:
Enabling runtime PM for inactive device with active children" and also
shows possible circular locking dependency detected message.

As it is must to enable parent device's runtime PM before enabling child's
runtime pm as the pcie-starfive device runtime pm is enabled after child
runtime starfive device is seeing the warning.

In the first patch fix the pcie-starfive driver by enabling runtime
pm before calling pci_host_probe().

All other PCIe controller drivers are enabling runtime pm before
calling pci_host_probe() which is as expected so don't require any
fix like pcie-starfive driver."

> I guess this sentence is basically how we verify all drivers are safe
> with this change?
> 
> Since this patch adds devm_pm_runtime_enable() in pci_host_probe(),
> can we expand this along the lines of this so it's more specific about
> what we need to verify?
> 
>    Every host bridge driver must call pm_runtime_enable() before
>    runtime PM is enabled by pci_host_probe().
> 
> Please correct me if that's not the right requirement.> 
yes this is correct requirement only. Do you want us to add this for
this patch .

- Krishna Chaitanya.
>> After this change, the host bridge device will be runtime-suspended
>> by the runtime PM framework automatically after suspending its last
>> child and it will be runtime-resumed automatically before resuming its
>> first child which will allow the runtime PM framework to track
>> dependencies between the host bridge device and all of its
>> descendants.
>>
>> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>> Changes in v6:
>> - no change
>> Changes in v5:
>> - call pm_runtime_no_callbacks() as suggested by Rafael.
>> - include the commit texts as suggested by Rafael.
>> - Link to v4: https://lore.kernel.org/linux-pci/20240708-runtime_pm-v4-1-c02a3663243b@quicinc.com/
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
>>   drivers/pci/probe.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 4f68414c3086..8409e1dde0d1 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -3106,6 +3106,11 @@ int pci_host_probe(struct pci_host_bridge *bridge)
>>   		pcie_bus_configure_settings(child);
>>   
>>   	pci_bus_add_devices(bus);
>> +
>> +	pm_runtime_set_active(&bridge->dev);
>> +	pm_runtime_no_callbacks(&bridge->dev);
>> +	devm_pm_runtime_enable(&bridge->dev);
>> +
>>   	return 0;
>>   }
>>   EXPORT_SYMBOL_GPL(pci_host_probe);
>>
>> -- 
>> 2.34.1
>>

