Return-Path: <linux-pci+bounces-15909-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCF79BAC72
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 07:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 157EFB2130C
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 06:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C1718D63C;
	Mon,  4 Nov 2024 06:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hd1zx2oS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F386818CC00;
	Mon,  4 Nov 2024 06:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730701086; cv=none; b=ZjUuIxYtu6kOqZRbL/qoTfwYE4rhpYK2NZ4NiULcha6jUchV7peXptJHVldJleiI+hg+/89JXUHHm1uRhs6HL+dn208wEPkr3Z/9SK/sU5teZ0qjU7K7/TBZBdAWpnbN8azpV6SinbPs3FxhPUT3ndDmlfHNSM+DvzehgT04xus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730701086; c=relaxed/simple;
	bh=kf73lXDv9ocArmuhHShudHik5NcfKKXQBWihK/qUA38=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZZfCLhLE/4sE4j6zSt/p2Vi1x3VgZGPS+mnj0GIfOjrWWrGQfXvwdvfz6Y0pPH16ALubEjA3GOTaTz72/Anm1+uwjWn8xcHMhx+RO+q9gx2M5EY1prQlhOzuC9Syfh25sfDpj17+pqfl3hEx8hRntdHY3yxWunCnSuKubDoIfCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hd1zx2oS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A3MZbQi028240;
	Mon, 4 Nov 2024 06:17:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vFI/LlS1kryxpKHTB9pMut6HZM5dbPiK54teYpQZJbY=; b=hd1zx2oSdZQ1ga7V
	vnRmRrrQxh70yH/y9RrvWjnQgllmxnyspnVlTD3MOHeMb0m0vp7nqM4gQMkV/vgx
	9cfNwkh1TyM88awhY3p1xtBqTukTZHuNEEdwkH3vUOHjqrTDHTqp7UF7RKmCS9ze
	iI//z14drMrek2Re+pPKru+SG954E+EeO6quGgTz+uHduuXDnUBofAEy5qZ5GBwu
	1bWPGrjDBSCRLhp2SmE/65Fj7hdFdiehldgY3sn+cZgsvNUW8hapPX0p17fTYNP2
	mijxGLBO4k0oHnoHWQhWAexT+qi434xfkbb+TVpvtnRkscIwg8Xf7lQ03KWerKuq
	pX5oMQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42nd4uk851-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 06:17:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A46Hogw014307
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 4 Nov 2024 06:17:50 GMT
Received: from [10.216.5.99] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 3 Nov 2024
 22:17:46 -0800
Message-ID: <aea4b392-3e1a-c8aa-f5da-99ec7d8e0d38@quicinc.com>
Date: Mon, 4 Nov 2024 11:47:43 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 2/3] PCI: qcom: Set linkup_irq if global IRQ handler is
 present
Content-Language: en-US
To: Bjorn Andersson <andersson@kernel.org>
CC: Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_mrana@quicinc.com>,
        <quic_vbadigan@quicinc.com>
References: <20241101-remove_wait-v3-0-7accf27f7202@quicinc.com>
 <20241101-remove_wait-v3-2-7accf27f7202@quicinc.com>
 <rbykc6qnqechpru4sehjvdo6iedeo4cankp3mwesdfnxyxsgs7@vj2p7wwfdqm7>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <rbykc6qnqechpru4sehjvdo6iedeo4cankp3mwesdfnxyxsgs7@vj2p7wwfdqm7>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HAyAWGsjm5SWCq3nSvybY51u5DwEafJe
X-Proofpoint-ORIG-GUID: HAyAWGsjm5SWCq3nSvybY51u5DwEafJe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=999 impostorscore=0 suspectscore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411040055



On 11/1/2024 9:00 PM, Bjorn Andersson wrote:
> On Fri, Nov 01, 2024 at 05:04:13PM GMT, Krishna chaitanya chundru wrote:
>> In cases where a global IRQ handler is present to manage link up
>> interrupts, it may not be necessary to wait for the link to be up
>> during PCI initialization which optimizes the bootup time.
>>
>> So, set linkup_irq flag if global IRQ is present and In order to set the
>> linkup_irq flag before calling dw_pcie_host_init() API, which waits for
>> link to be up, move platform_get_irq_byname_optional() API
>> above dw_pcie_host_init().
>>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index ef44a82be058..474b7525442d 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -1692,6 +1692,10 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>>   
>>   	platform_set_drvdata(pdev, pcie);
>>   
>> +	irq = platform_get_irq_byname_optional(pdev, "global");
>> +	if (irq > 0)
>> +		pp->linkup_irq = true;
> 
> This seems to only ever being used in dw_pcie_host_init(), would it make
> sense to use a argument to the function to pass the parameter instead of
> stashing it in the persistent data structure?
> 
dw_pcie_host_init() API is being used by multiple vendors under
drivers/pci/controller/dwc/* it may not be ideal to change the argument
here.

- Krishna Chaitanya.
> Regards,
> Bjorn
> 
>> +
>>   	ret = dw_pcie_host_init(pp);
>>   	if (ret) {
>>   		dev_err(dev, "cannot initialize host\n");
>> @@ -1705,7 +1709,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>>   		goto err_host_deinit;
>>   	}
>>   
>> -	irq = platform_get_irq_byname_optional(pdev, "global");
>>   	if (irq > 0) {
>>   		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
>>   						qcom_pcie_global_irq_thread,
>>
>> -- 
>> 2.34.1
>>
>>

