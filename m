Return-Path: <linux-pci+bounces-17315-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BED719D9249
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 08:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AA282837D2
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 07:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2460E192D69;
	Tue, 26 Nov 2024 07:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DoBzocZ5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938F88F54;
	Tue, 26 Nov 2024 07:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732605362; cv=none; b=uYPGRykW52g7atWrzX4EGYR/4lqR/0f+bfH6TM/UVyBJAOLKSEQZPvgOKH1l9JT5LcixnzI9pUsm3bmeGs7eHyPrmTdxVty3wzTFzbeco7SnQHTezm4wpzxwZLd3dyqJjaR9G60kBu9ZgzCAou9XovfuYtoNLx6Dib8JtSMHGpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732605362; c=relaxed/simple;
	bh=SalpNVycsXOdStRp7sEYPqOWh1/eh+t4LqNMJC0wAto=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZL5ueXwKra2bsyPvkAVf2QquAMIpbl2mZVNwYhR3l0UL3OuO4nb5LqKaQ/WufSzH06EJX2KuPy9jsetpY1dcpqnl0sjG1P0EMHz0XHHAx5n4sZ/CqFM2v8gONCXBntctzybVCMGViE3Vg2Udlwe+kvM9NlCe8W8p4Y/wBR6wZAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DoBzocZ5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQ3oNM5010336;
	Tue, 26 Nov 2024 07:15:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7g6XLmM4hbthvCgpSK+EOyqhePvgSura3/T5/LCII0Y=; b=DoBzocZ50opxXuBH
	jaQICIaLUVofv1hql732VhLqRTyAmPNrz+NIoemBhZSZaTOauSXSCpGG7cPoJoCJ
	drRNo6fLaMAn2pQhtFDw8pH2dg1QjKLfX14nIzAZnMENRHusrVG9+Xeyuc2blcvN
	8PJafumijbb5hTTUB+7aIMZ2QuQdDYgrrW23E1Xnlupk8qh41QU5/ujNuzKDj14t
	NwAcuIoMfLsRbb+GMnTgS7BkqMYk6tNLazwXlAXSWr9oajZcMopO1OnCrI39djvv
	KJMsBN384ZJK6+8O3h4BwO7lZCYE20ioCnstDRV/uMkAk9xxRs8vi0JDjFSZAYhV
	aukU7Q==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 434sw9abmf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 07:15:47 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AQ7FlOY026452
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 07:15:47 GMT
Received: from [10.217.218.192] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 25 Nov
 2024 23:15:42 -0800
Message-ID: <35395249-7aeb-459c-9c78-2cfdaad2bb6a@quicinc.com>
Date: Tue, 26 Nov 2024 12:45:39 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] Add support for RAS DES feature in PCIe DW
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
        Shradha Todi
	<shradha.t@samsung.com>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
CC: <manivannan.sadhasivam@linaro.org>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <jingoohan1@gmail.com>, <fancer.lancer@gmail.com>,
        <yoshihiro.shimoda.uh@renesas.com>, <conor.dooley@microchip.com>,
        <pankaj.dubey@samsung.com>, <gost.dev@samsung.com>
References: <CGME20240625094434epcas5p2e48bda118809ccb841c983d737d4f09d@epcas5p2.samsung.com>
 <20240625093813.112555-1-shradha.t@samsung.com>
 <03c5bf0e-d65b-7ebb-d12d-3f9b3bae2a4c@quicinc.com>
Content-Language: en-US
From: Nitesh Gupta <quic_nitegupt@quicinc.com>
In-Reply-To: <03c5bf0e-d65b-7ebb-d12d-3f9b3bae2a4c@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vG7WqxJuRQnWwWoDasVK4EMFJVKppoC-
X-Proofpoint-ORIG-GUID: vG7WqxJuRQnWwWoDasVK4EMFJVKppoC-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 clxscore=1011 mlxscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411260056

Hi Shradha,

Can you please update on status of this Patch?

Are you going to take it up or is it fine for us to take it up?

-Nitesh Gupta

On 11/26/2024 10:47 AM, Krishna Chaitanya Chundru wrote:
>
> forgot to add the email in the previous mail.
>
> - Krishna chaitanya.
> On 6/25/2024 3:08 PM, Shradha Todi wrote:
>> DesignWare controller provides a vendor specific extended capability
>> called RASDES as an IP feature. This extended capability provides
>> hardware information like:
>>   - Debug registers to know the state of the link or controller.
>>   - Error injection mechanisms to inject various PCIe errors including
>>     sequence number, CRC
>>   - Statistical counters to know how many times a particular event
>>     occurred
>>
>> However, in Linux we do not have any generic or custom support to be
>> able to use this feature in an efficient manner. This is the reason we
>> are proposing this framework. Debug and bring up time of high-speed IPs
>> are highly dependent on costlier hardware analyzers and this solution
>> will in some ways help to reduce the HW analyzer usage.
>>
>> The debugfs entries can be used to get information about underlying
>> hardware and can be shared with user space. Separate debugfs entries has
>> been created to cater to all the DES hooks provided by the controller.
>> The debugfs entries interacts with the RASDES registers in the required
>> sequence and provides the meaningful data to the user. This eases the
>> effort to understand and use the register information for debugging.
>>
>> v2: https://lore.kernel.org/lkml/20240319163315.GD3297@thinkpad/T/
>>
>> v1: 
>> https://lore.kernel.org/all/20210518174618.42089-1-shradha.t@samsung.com/T/
>>
>> Shradha Todi (3):
>>    PCI: dwc: Add support for vendor specific capability search
>>    PCI: debugfs: Add support for RASDES framework in DWC
>>    PCI: dwc: Create debugfs files in DWC driver
>>
>>   drivers/pci/controller/dwc/Kconfig            |   8 +
>>   drivers/pci/controller/dwc/Makefile           |   1 +
>>   .../controller/dwc/pcie-designware-debugfs.c  | 474 ++++++++++++++++++
>>   .../controller/dwc/pcie-designware-debugfs.h  |   0
>>   .../pci/controller/dwc/pcie-designware-host.c |   2 +
>>   drivers/pci/controller/dwc/pcie-designware.c  |  20 +
>>   drivers/pci/controller/dwc/pcie-designware.h  |  18 +
>>   7 files changed, 523 insertions(+)
>>   create mode 100644 
>> drivers/pci/controller/dwc/pcie-designware-debugfs.c
>>   create mode 100644 
>> drivers/pci/controller/dwc/pcie-designware-debugfs.h
>>

