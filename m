Return-Path: <linux-pci+bounces-4588-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A968745D6
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 02:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FE7D1F25BAE
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 01:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45BB05227;
	Thu,  7 Mar 2024 01:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="k/7wd482"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA5B4C9B;
	Thu,  7 Mar 2024 01:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709776789; cv=none; b=QDLbrMxgxwq2h7qd4PpwA1Hrb9ySqcpTb7f3f1CEgAg2o6CS6UVBDRH81fEqaeCGyMWPnfnFvXq/ZbxU3r+gsTZhAnmA0Gu4IWUqcGrizaUfUbNpzE/W2buCojhui+o/YqiZJBq17wL3VVWz9kn0XgZ57i7OvcV4NDkVbtitQgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709776789; c=relaxed/simple;
	bh=iXEy1OKVX5U3UbielGi3xT8MapgMEL75d1p6MVZeUKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kWPcymj2QwtALoidnFb9qU61WEwgyHdC96ctUabylwnLva88iW2S6JFGt6YCzZc+L+I7PcaJEtuDHayk1WyBjAVXqB7syiM/QqXtVvgklFTdQhtqb+ST5J7a5+lmhMk5XbLHDnnXAv4tvrU+o9ijlYSBcXYstoBlxF8MbNrAbSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=k/7wd482; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4270mY3l006009;
	Thu, 7 Mar 2024 01:59:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=fo20e5u8kRX0TH8Ebk4q96Y5aavtMUPyPXPpSWsJ1kk=; b=k/
	7wd482xhM+Nt9nIvRrgYgqfivMZsN79S5KkUI6ET8YUjBEi2HfuOJuP6lxP4BKIc
	51hdv7lvQGiaOYW9hK3JNN9YN5bHVATUhvCUPGbNtkAVcLbpfV92Yggw/IhNKqGD
	91g6f/maa54NlZ2w4FPrlcmyXN46mE7GQyhgc2v4MmgAoPoYimhIx1yOCqgedpfy
	qOdrlY3nn3zL46ynkh9utCbjiiqZ4FtdSe+Df/93vc2Feoc3ogfYlR7qi3hcc4M3
	8BbAEfSgShZwzEXnS7t6WKcYegN5SlYd+OGJkl88h4gEGGzfF4Ov2J7Y8gMKVPXa
	rTFA6qkS096kdE5gg+gw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wq2mfr5gn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 01:59:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4271x40J016549
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Mar 2024 01:59:04 GMT
Received: from [10.216.20.61] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 6 Mar
 2024 17:58:58 -0800
Message-ID: <be760502-446b-f4cc-776d-8751bdb75ff7@quicinc.com>
Date: Thu, 7 Mar 2024 07:28:54 +0530
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
To: Bjorn Helgaas <helgaas@kernel.org>
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
References: <20240305195722.GA541937@bhelgaas>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20240305195722.GA541937@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qZMEMk_YTASH6IEsnk1l7XVue-ZdsUiT
X-Proofpoint-ORIG-GUID: qZMEMk_YTASH6IEsnk1l7XVue-ZdsUiT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_14,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403070013



On 3/6/2024 1:27 AM, Bjorn Helgaas wrote:
> On Tue, Mar 05, 2024 at 03:19:01PM +0530, Krishna chaitanya chundru wrote:
>> The Controller driver is the parent device of the PCIe host bridge,
>> PCI-PCI bridge and PCIe endpoint as shown below.
> 
> Nit: add blank line here.
> 
Ack.
>> 	PCIe controller(Top level parent & parent of host bridge)
>> 			|
>> 			v
>> 	PCIe Host bridge(Parent of PCI-PCI bridge)
>> 			|
>> 			v
>> 	PCI-PCI bridge(Parent of endpoint driver)
>> 			|
>> 			v
>> 		PCIe endpoint driver
> 
> Nit: use spaces instead of tabs to ensure this still looks good when
> "git log" indents this.  In this case it doesn't seem to matter,
> 
Ack.
>> Since runtime PM is disabled for host bridge, the state of the child
>> devices under the host bridge is not taken into account by PM framework
>> for the top level parent, PCIe controller. So PM framework, allows
>> the controller driver to enter runtime PM irrespective of the state
>> of the devices under the host bridge.
> 
> IIUC this says that we runtime suspend the controller even though
> runtime PM is disabled for the host bridge?  I have a hard time
> parsing this; can you cite a function that does this or some relevant
> documentation about how this part of runtime PM works?
> 
Generally controller should go to runtime suspend when endpoint client
drivers and pci-pci host bridge drivers goes to runtime suspend as the
controller driver is the parent, but we are observing controller driver
goes to runtime suspend even when client drivers and PCI-PCI bridge are
in active state.

Unfortunately I don't have any reference for any documentation about how
runtime PM works.
>> And this causes the topology breakage and also possible PM issues.
> 
> Not sure what this refers to, since you didn't mention topology
> breakage earlier.  And "possible PM" issues is too vague to be useful.
> 
>> So enable pm runtime for the host bridge, so that controller driver
>> goes to suspend only when all child devices goes to runtime suspend.
> 
> s/pm runtime/runtime PM/ so all the references match (unless you mean
> something different here) (also in subject line)
> 
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>> Changes in v2:
>> - Updated commit message as suggested by mani.
>> - Link to v1: https://lore.kernel.org/r/20240219-runtime_pm_enable-v1-1-d39660310504@quicinc.com
>> ---
>>   drivers/pci/controller/dwc/pcie-designware-host.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
>> index d5fc31f8345f..57756a73df30 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>> @@ -16,6 +16,7 @@
>>   #include <linux/of_pci.h>
>>   #include <linux/pci_regs.h>
>>   #include <linux/platform_device.h>
>> +#include <linux/pm_runtime.h>
>>   
>>   #include "../../pci.h"
>>   #include "pcie-designware.h"
>> @@ -505,6 +506,9 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>>   	if (pp->ops->post_init)
>>   		pp->ops->post_init(pp);
>>   
>> +	pm_runtime_set_active(&bridge->dev);
> 
> There are currently no callers of pm_runtime_set_active() in
> drivers/pci/controller/.  This adds it to dw_pcie_host_init(), but it
> doesn't seem to be a DWC-specific issue, so I assume other drivers and
> driver cores like cadence and mobiveil should have this, too?
> 
I think cadence and mobiveil also should have this.
>> +	pm_runtime_enable(&bridge->dev);
> 
> There are several existing calls of pci_runtime_enable(), including
> from several DWC drivers.  Are they now redundant?
> 
No These are not redundant, Those drivers are calling this
pm_runtime_enable() for their controller dev node. Here we are calling
runtime enable for the bridge dev which is allocated and used by the
PCIe framework.

- Krishna Chaitanya.
> In addition, [1] suggests that pm_runtime_enable() should be called
> *after* pm_runtime_set_active(), but these existing calls
> (dra7xx_pcie_probe(), ks_pcie_probe(), qcom_pcie_probe(),
> rcar_gen4_pcie_prepare(), tegra_pcie_config_rp()) happen *before*
> dw_pcie_host_init() calls pm_runtime_set_active().
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/power/runtime_pm.rst?id=v6.7#n582
>  >>   	return 0;
>>   
>>   err_stop_link:
>>
>> ---
>> base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
>> change-id: 20240219-runtime_pm_enable-bdc17914bd50
>>
>> Best regards,
>> -- 
>> Krishna chaitanya chundru <quic_krichai@quicinc.com>
>>

