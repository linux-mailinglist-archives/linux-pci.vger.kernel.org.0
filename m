Return-Path: <linux-pci+bounces-4083-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93ACD8689F9
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 08:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A146289972
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 07:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0CA54BC8;
	Tue, 27 Feb 2024 07:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ldapwmYw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48D61E89A;
	Tue, 27 Feb 2024 07:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709019509; cv=none; b=k7Na8KIttF0dU8i6fe8ENl6K7x+8lQamL4YfMszh7fYMoVpvWmxy/7FtdVP9TvPda4QBUtZAf+E+Ta8m+PZ1b2AHxvyWFll6iIWcjCg/8iNyP2wklWcOaeS3OTUCwJbZGn/y2ju4IUUH5nidrJafZF3N4ENXcZ9LL9khONzSzNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709019509; c=relaxed/simple;
	bh=8P7wEXB4wTBPTemmiBXHngBFEUVYIia1gN+EfoUB+0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=G8nIrzoMEmg/AVSPXD6ENsMnlqiUwfIyqIlQpQqU5SySb4iZBEtAV1RFqzYS+xBMEG7gLQ3iNgA7sLA0Lu/ufrpbc8NlaE5VLNGj4ZKHJ/md3KLNytzzzC4KbhDuo69hzBUkB8sVgVcJE8tJ836FfdWfxEai1B9I/qP3XVjdxBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ldapwmYw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41R7Mca8027755;
	Tue, 27 Feb 2024 07:38:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=nU88DR30Nj5YQI+Bz1I/p5HrTkiLJwjFVYR+uGcIayg=; b=ld
	apwmYw6vIj/SUgJJAvqkoqhIe3atBGsY1mbECLE7WkoLf19ON2oEJPofQj6qjJ/r
	O9+RMQc2wUzb7fgRaG/3K5JNRuQ1DQmhp9V4mxs9CQg8o/gcAH6oBdgZEDacAJzs
	414yLN8tvfP4rzzMdx1bRHcjddy9C/+UWDYuoA+qoISniq0cINFEj+lRVlzoxFI2
	gD04UZtuwtT7qvfqaylIqHbYOd32EHO2wccB/Y5GdQ+EgGFqijaJV+4iomhTPYei
	PkjdkTiJFs9ZIdanoLJKixSWll39tO3ReacTonQ/U6nYLKy6/9Sp94JmK85Xarg7
	VYZX0r5o418BxTPkVoyw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wh232s4xt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 07:38:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41R7cFK9019448
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 07:38:15 GMT
Received: from [10.216.14.152] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 26 Feb
 2024 23:38:10 -0800
Message-ID: <3b4d553c-401e-da56-4554-47c4cf040e8c@quicinc.com>
Date: Tue, 27 Feb 2024 13:08:05 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] PCI: dwc: Enable runtime pm of the host bridge
Content-Language: en-US
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel
	<gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_vbadigan@quicinc.com>, <quic_ramkri@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_parass@quicinc.com>
References: <20240219-runtime_pm_enable-v1-1-d39660310504@quicinc.com>
 <20240226155305.GJ8422@thinkpad>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20240226155305.GJ8422@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: oGDMTX3oJ701THTMqleJNtchrlA0al0W
X-Proofpoint-GUID: oGDMTX3oJ701THTMqleJNtchrlA0al0W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 mlxlogscore=970 impostorscore=0 phishscore=0 mlxscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402270060



On 2/26/2024 9:23 PM, Manivannan Sadhasivam wrote:
> On Mon, Feb 19, 2024 at 06:51:10PM +0530, Krishna chaitanya chundru wrote:
>> Currently controller driver goes to runtime suspend irrespective
>> of the child(pci-pci bridge & endpoint driver) runtime state.
>> This is because the runtime pm is not being enabled for the host
>> bridge dev which maintains parent child relationship.
>>
> 
> You should describe the parent-child topology first. Maybe a simple flow like
> below will help:
> 
> 	PCIe Controller
> 	      |
> 	PCIe Host bridge
> 	      |
> 	PCI-PCI bridge
> 	      |
> 	PCIe endpoint
> 
> Also explain the fact that since runtime PM is disabled for host bridge, the
> state of the child devices under the host bridge is not taken into account by
> PM framework for the top level parent, PCIe controller. So PM framework, allows
> the controller driver to enter runtime PM irrespective of the state of the
> devices under the host bridge. And this causes the topology breakage and also
> possible PM issues.
> 
> - Mani
>
ACK.

- Krishna Chaitanya.
>> So enable pm runtime for the host bridge, so that controller driver
>> goes to suspend only when all child devices goes to runtime suspend.
>>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
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
>> +	pm_runtime_enable(&bridge->dev);
>> +
>>   	return 0;
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
> 

