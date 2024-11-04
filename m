Return-Path: <linux-pci+bounces-15908-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCF99BAC68
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 07:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25F5FB2097C
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 06:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCC314E2FD;
	Mon,  4 Nov 2024 06:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pdwk8tr+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C15E552;
	Mon,  4 Nov 2024 06:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730700954; cv=none; b=D432eARjIGTFBIj6oMsrYZwy7JBNSSaytIIecACPNQurhTY1tNaf1tZyIZcDEET7ksmKerOShzTyCxeu2Q6FgGZ4/+eTlQQUV2ua9G6LoayM8pLpy+iYijllV40i0gcT0BYDAklBGtMIxuh6o6vmqh0rC2w6Zj8WxxOpWAGCZeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730700954; c=relaxed/simple;
	bh=vWBUn0EQwvYUEC3nV1RJqT0ko15VPOHlcftqR4KZ+BE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FP9owEH/0/Zrq7GVUZEubMphaLMy7lViKmyLGY3OO3wdkF+1GsclMxV7DcD1JhRvMht0mArK4Ss6eIkVfKdzQUllGc5QjPWyCcEOC+g6IW+pTUmlk73kNIn01fHHfwNdBKhrnDEJrxapZM98byQ22ZVNQETR10Ee4NWUItRd1ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pdwk8tr+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A3Nv2wq021876;
	Mon, 4 Nov 2024 06:15:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QRPcKfq7zkgtJ1CB50cmlKjVjv49c1bwAJmAjjF+5sI=; b=pdwk8tr+2uWZyS2N
	RgP7hLS0FWAP+Y3BMLNaE+tfWyfAth1XaSd56V+TBZONqqwm2gdfC0ZK1hhSZ6KA
	8ZmUiJSMvQC9ipnJl2ktnIchZ69r4pWpTJlDDaid/tMf/zV3kheMa2QKAn+2S9T4
	o90n/waFxVJwg76A5zois1ih7yd7cIYAol1W788G9Xb1kPFxraLfkKIzHCUW82b/
	RRaL1DqpiqmnMZ47aW3UyulvDJ3tTf3e9kclzuQIR1ljVp1LIwVeyWTb0dLCRX8A
	TbaMOcb9W2VUPvshrBD795BsDp53R77vuvM0fNJo2LNU6g2DP38jqaGhmbnUgRaB
	ZXR4Yg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42nd2838cj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 06:15:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A46Fiu7007713
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 4 Nov 2024 06:15:44 GMT
Received: from [10.216.5.99] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 3 Nov 2024
 22:15:40 -0800
Message-ID: <108d1fe2-2a89-ff55-0a7d-a3a59299f417@quicinc.com>
Date: Mon, 4 Nov 2024 11:45:37 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 1/3] PCI: dwc: Skip waiting for link up if vendor
 drivers can detect Link up event
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
 <20241101-remove_wait-v3-1-7accf27f7202@quicinc.com>
 <ywuqtydbapfumelfu66237h65q2xb3rmvjtstiwvd24whn7rju@bcxldl2l4bv2>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <ywuqtydbapfumelfu66237h65q2xb3rmvjtstiwvd24whn7rju@bcxldl2l4bv2>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BmMKC6q6vIH9YQoK-87-D7Vw6Duh6DCR
X-Proofpoint-GUID: BmMKC6q6vIH9YQoK-87-D7Vw6Duh6DCR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 clxscore=1015 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411040054



On 11/1/2024 8:56 PM, Bjorn Andersson wrote:
> On Fri, Nov 01, 2024 at 05:04:12PM GMT, Krishna chaitanya chundru wrote:
>> If the vendor drivers can detect the Link up event using mechanisms
>> such as Link up IRQ and can the driver can enumerate downstream devices
>> instead of waiting here, then waiting for Link up during probe is not
>> needed here, which optimizes the boot time.
>>
>> So skip waiting for link to be up if the driver supports 'linkup_irq'.
>>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-designware-host.c | 10 ++++++++--
>>   drivers/pci/controller/dwc/pcie-designware.h      |  1 +
>>   2 files changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
>> index 3e41865c7290..26418873ce14 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>> @@ -530,8 +530,14 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>>   			goto err_remove_edma;
>>   	}
>>   
>> -	/* Ignore errors, the link may come up later */
>> -	dw_pcie_wait_for_link(pci);
>> +	/*
>> +	 * Note: The link up delay is skipped only when a link up IRQ is present.
>> +	 * This flag should not be used to bypass the link up delay for arbitrary
>> +	 * reasons.
> 
> Perhaps by improving the naming of the variable, you don't need 3 lines
> of comment describing the conditional.
> 
These comments are added so that no one will misuse this flag in the 
future which was happened previously.
>> +	 */
>> +	if (!pp->linkup_irq)
>> +		/* Ignore errors, the link may come up later */
> 
> Does this mean that we will be able to start handling these errors?
we haven't changed anything here it was present from long ago, the
reason why driver is not considering the return value is for some
platforms the link may come up later and the driver doesn't want to
fail here.
> 
>> +		dw_pcie_wait_for_link(pci);
>>   
>>   	bridge->sysdata = pp;
>>   
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
>> index 347ab74ac35a..539c6d106bb0 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
>> @@ -379,6 +379,7 @@ struct dw_pcie_rp {
>>   	bool			use_atu_msg;
>>   	int			msg_atu_index;
>>   	struct resource		*msg_res;
>> +	bool			linkup_irq;
> 
> Please name this for what it is, rather than some property from which
> some other decision should be derived. (And then you need a comment to
> describe how people should interpret and use it)
> 
> Also, "linkup_irq" sound like an int carrying the interrupt number, not
> a boolean.
> 
> 
> Please call it "use_async_linkup", "use_linkup_irq" or something.
> 
ack will change it to "use_linkup_irq"

- Krishna Chaitanya.
> Regards,
> Bjorn
> 
>>   };
>>   
>>   struct dw_pcie_ep_ops {
>>
>> -- 
>> 2.34.1
>>
>>

