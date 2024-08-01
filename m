Return-Path: <linux-pci+bounces-11141-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B861D945420
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 23:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70D5E285B6A
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 21:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35D114A4F8;
	Thu,  1 Aug 2024 21:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HynzRLwq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3358B145A0E;
	Thu,  1 Aug 2024 21:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722547875; cv=none; b=JIXEuqXOAlz60xpTUDno707Tc/UlKzLbCt+D/XP3MTJpVFgoFz+KwEk0ubHHnRVTbUoQru5G0/OIZSWP9R03lI0zYNLB8OLMK23WTumx/9Bt8YVOgorQr2YQyVTuWDTePipisL/43BLxc+cQ36raVlvUK+LDyHGNBJfoY8Hkvp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722547875; c=relaxed/simple;
	bh=YDMhKOtxTq1jYJ50nd+PYkIQElC8/pW9HKmRAdDxVEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QcUVFVOAamoKNqwlzWLg+Rq3uY9SChY+C8HUTZC4GOumPZDBTiRcQtuWQ8FaFzYByAUvQmCn9/J/WwULy0Fmw53F1rpXRBKilZfBQ6wZ8Z6KGAwlmNheKHjYusaTXlB5dU7CED3Ml4+dDSLsdSphasQqJrbqGILty7YQ/dat7LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HynzRLwq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 471DaXsu028637;
	Thu, 1 Aug 2024 21:31:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NgTpcmA89mPS0AT7m4ON1UEBFi6RJT/8dMQ5Scp9Q0w=; b=HynzRLwqDNQ8iWuo
	/onKVEuURtel8rSDZ/MCXwTO6UXfeiQxXG86ES4dkp0fDcI7cOh5fDdmSsBHHXMd
	NXXZo/OooQ1PjxCnj0Q1jofKxVY3GvhhSwJQji9wJjFjWwVu0gvqiRs1w7zdulCD
	TjSw09pzDgx1oHazwT2Gotu9c3ZxZ28wsFx21KdSc69EeOvKSUfd3wQJGbR4tBkz
	/1VfHywPOeisnH3Vc5Jxy7Mu02tEFHg+6X6Kbxa2OlOFXmTYvRftBeUj8RYvyiG1
	y+D5YHq3kNLrS7ZaYnhGbYMEWs82hWMb5WaaI09tpCmBjJ09qVxflLs+cPfNMNsU
	k8r2gw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40qkv0wdgb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Aug 2024 21:31:04 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 471LV3HZ004046
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Aug 2024 21:31:03 GMT
Received: from [10.46.163.151] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 1 Aug 2024
 14:31:03 -0700
Message-ID: <6d926346-1c24-4aee-85b1-ffb5a0df904b@quicinc.com>
Date: Thu, 1 Aug 2024 14:29:49 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] PCI: dwc: Add dbi_phys_addr and atu_phys_addr to
 struct dw_pcie
To: Serge Semin <fancer.lancer@gmail.com>
CC: <jingoohan1@gmail.com>, <manivannan.sadhasivam@linaro.org>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <quic_mrana@quicinc.com>
References: <20240724022719.2868490-1-quic_pyarlaga@quicinc.com>
 <20240724022719.2868490-2-quic_pyarlaga@quicinc.com>
 <vbq3ma3xanu4budrrt7iwk7bh7evgmlgckpohqksuamf3odbee@mvox7krdugg3>
Content-Language: en-US
From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
In-Reply-To: <vbq3ma3xanu4budrrt7iwk7bh7evgmlgckpohqksuamf3odbee@mvox7krdugg3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: sh8bPoie0V6mHVYQZfpYlcpnNVy2e7yo
X-Proofpoint-GUID: sh8bPoie0V6mHVYQZfpYlcpnNVy2e7yo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_20,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=921 clxscore=1011
 adultscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408010143

Hi Serge,

Thanks for the review comment.

On 8/1/2024 12:25 PM, Serge Semin wrote:
> On Tue, Jul 23, 2024 at 07:27:18PM -0700, Prudhvi Yarlagadda wrote:
>> Both DBI and ATU physical base addresses are needed by pcie_qcom.c
>> driver to program the location of DBI and ATU blocks in Qualcomm
>> PCIe Controller specific PARF hardware block.
>>
>> Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
>> Reviewed-by: Mayank Rana <quic_mrana@quicinc.com>
>> ---
>>  drivers/pci/controller/dwc/pcie-designware.c | 2 ++
>>  drivers/pci/controller/dwc/pcie-designware.h | 2 ++
>>  2 files changed, 4 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
>> index 1b5aba1f0c92..bc3a5d6b0177 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware.c
>> @@ -112,6 +112,7 @@ int dw_pcie_get_resources(struct dw_pcie *pci)
>>  		pci->dbi_base = devm_pci_remap_cfg_resource(pci->dev, res);
>>  		if (IS_ERR(pci->dbi_base))
>>  			return PTR_ERR(pci->dbi_base);
>> +		pci->dbi_phys_addr = res->start;
>>  	}
>>  
>>  	/* DBI2 is mainly useful for the endpoint controller */
>> @@ -134,6 +135,7 @@ int dw_pcie_get_resources(struct dw_pcie *pci)
>>  			pci->atu_base = devm_ioremap_resource(pci->dev, res);
>>  			if (IS_ERR(pci->atu_base))
>>  				return PTR_ERR(pci->atu_base);
>> +			pci->atu_phys_addr = res->start;
>>  		} else {
>>  			pci->atu_base = pci->dbi_base + DEFAULT_DBI_ATU_OFFSET;
>>  		}
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
>> index 53c4c8f399c8..efc72989330c 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
>> @@ -407,8 +407,10 @@ struct dw_pcie_ops {
>>  struct dw_pcie {
>>  	struct device		*dev;
>>  	void __iomem		*dbi_base;
> 
>> +	phys_addr_t		dbi_phys_addr;
>>  	void __iomem		*dbi_base2;
>>  	void __iomem		*atu_base;
>> +	phys_addr_t		atu_phys_addr;
> 
> What's the point in adding these fields to the generic DW PCIe private
> data if they are going to be used in the Qcom glue driver only?
> 
> What about moving them to the qcom_pcie structure and initializing the
> fields in some place of the pcie-qcom.c driver?
> 
> -Serge(y)
> 

These fields were in pcie-qcom.c driver in the v1 patch[1] and
Manivannan suggested to move these fields to 'struct dw_pcie' so that duplication
of resource fetching code 'platform_get_resource_byname()' can be avoided.

[1] https://lore.kernel.org/linux-pci/a01404d2-2f4d-4fb8-af9d-3db66d39acf7@quicinc.com/T/#mf9843386d57e9003de983e24e17de4d54314ff73

Thanks,
Prudhvi
>>  	size_t			atu_size;
>>  	u32			num_ib_windows;
>>  	u32			num_ob_windows;
>> -- 
>> 2.25.1
>>
>>

