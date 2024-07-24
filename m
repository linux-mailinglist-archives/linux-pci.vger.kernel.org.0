Return-Path: <linux-pci+bounces-10738-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE5093B6B7
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 20:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ED7B1C210F4
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 18:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3443216A943;
	Wed, 24 Jul 2024 18:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JFkn6aSY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739B715FA6B;
	Wed, 24 Jul 2024 18:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721845761; cv=none; b=sj+w6QxborNrMbtOkEBybtbknV1U5nS3ahkrogVVWFxwbEQ2r+Dd/Yh2Iz9FPbw7kTCrWBkcaq3pz1jn81EKGgQ+mkyVonEevW3pCZxrGOivMpoNuk9IVrk1TmkRZo3DBizjiEkleMWEraKOojZJSPFiqdv5JJpkdbIxSseoAdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721845761; c=relaxed/simple;
	bh=CTbhc2XR6ED+P758V6IIHvmcwsbhKOz48ZEW3Fuhb+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=A24vs2c9mXvQ5ymiIwr0bJhXs5HFJnEAHdbH+28zvdFnFyj2BAkWvPAJCBlvoP0s0wIIWaSFlPpG5VdQPjw1gDlF6bB9b3QZbftOcOo7hSBeXWUW0fNPADJ6uNeGqiD12E35SSQXNqXnA2Dl+yL1qGxcYixdDDoOE6fZZJ+Q/68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JFkn6aSY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46OFAUS6007443;
	Wed, 24 Jul 2024 18:28:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LYaajTvqjnJdCOkMntWCIMJGdccPtPX0LbzNyy7YInI=; b=JFkn6aSYf6KRb1eI
	IUTMNMD09XCIsOGuHQeDl7RZe2CLHV/07K90V70SVKiElyahWYTiaS9r1I5F4ENn
	aiy2gfLKEThzhT/HohvSH4XN1jaPtulrfEJhwvoBet1iUP73kN5/j8fXF3JlxeqA
	yAJ3w10PIzLqtk1ZeS8YF8g7ykYpmrGwB2oSV8Xxj/zveZ/qmfnQ0VKtl1bBXVfy
	dVFqsCaGMuq5oCd0l67WJdBLOFkEbYx8n5sT1lnm7ctC2Zd0zx/2nGJG4j/80cHj
	eZa/wGbGE+Nz4lFzF38W/7Ao22GeUhAumXHTprQPoO14oyKTOre7JjwLwzhf4X1u
	NCifwQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40k413ggpg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 18:28:59 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46OISwhg007609
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 18:28:58 GMT
Received: from [10.110.66.115] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 24 Jul
 2024 11:28:58 -0700
Message-ID: <f60f3c75-d1cf-4622-8815-8cea17ae323c@quicinc.com>
Date: Wed, 24 Jul 2024 11:28:36 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] PCI: dwc: Add dbi_phys_addr and atu_phys_addr to
 struct dw_pcie
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: <jingoohan1@gmail.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <quic_mrana@quicinc.com>
References: <20240724022719.2868490-1-quic_pyarlaga@quicinc.com>
 <20240724022719.2868490-2-quic_pyarlaga@quicinc.com>
 <20240724135305.GE3349@thinkpad>
Content-Language: en-US
From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
In-Reply-To: <20240724135305.GE3349@thinkpad>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: E7EKnnQ48I5svAshJPWH7wFIf2muEXbS
X-Proofpoint-GUID: E7EKnnQ48I5svAshJPWH7wFIf2muEXbS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_19,2024-07-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 mlxscore=0 spamscore=0 mlxlogscore=913 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407240133

Hi Manivannan,

Thanks for the review comments.

On 7/24/2024 6:53 AM, Manivannan Sadhasivam wrote:
> On Tue, Jul 23, 2024 at 07:27:18PM -0700, Prudhvi Yarlagadda wrote:
> 
> Subject could be modified as below:
> 
> PCI: dwc: Cache DBI and iATU physical addresses in 'struct dw_pcie_ops'
> 

ACK. I will update it in the next patch.

>> Both DBI and ATU physical base addresses are needed by pcie_qcom.c
>> driver to program the location of DBI and ATU blocks in Qualcomm
>> PCIe Controller specific PARF hardware block.
>>
>> Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
> 
> Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> - Mani
> 

ACK. I will add it in the next patch.

Thanks,
Prudhvi
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
>> +	phys_addr_t		dbi_phys_addr;
>>  	void __iomem		*dbi_base2;
>>  	void __iomem		*atu_base;
>> +	phys_addr_t		atu_phys_addr;
>>  	size_t			atu_size;
>>  	u32			num_ib_windows;
>>  	u32			num_ob_windows;
>> -- 
>> 2.25.1
>>
> 

