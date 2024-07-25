Return-Path: <linux-pci+bounces-10817-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2FF93CB00
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 01:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D9961C2169B
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 23:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE0813FD66;
	Thu, 25 Jul 2024 23:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ND/mhkBB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDC0131E38;
	Thu, 25 Jul 2024 23:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721948722; cv=none; b=QTCEOi0Hzi+3sTXNrxdCCp/6piVHC5VdMDBKXt63T4Ox//jy8GTfTjO4eFfBSdt+wyX/BePzTvQ9kaVkLnKgsGZIY+zxf17b55x4kzQBxfN0Kks1BKTMbwOPvT/eK+genE4bvcty3yqweT/JPeuBeBLj9IzLihNfHQ4c7a6cbn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721948722; c=relaxed/simple;
	bh=z8KhoeN1VYushmocpVACXGYz6Cr+ixLtwZCt40TBAZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LTbQ/vLNTOFhnvGcjAsDzmWY08S/aqk0Db/AEPz8hEhW5t88cDdgi1KE8AIj1I4Q9A+RFkPF3r4HPRQEnZlkcTpP+ldAuS1QPkoOaTGIHB1hKkN8wR+dPc6/Lcbk8ytoyjwYxHrrDl+W1TajG3aH5R3F5H5+bm4YqhkxabEJPAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ND/mhkBB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46P9iIDC032004;
	Thu, 25 Jul 2024 23:05:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uSEffCNKEvdxx9qjDCSITni5dI4QFMAd0s2TcQ1TgpQ=; b=ND/mhkBBXTLOCOw3
	DPYAMY0PgJEH1xsEyoagH33KLOrnsV3Nrj/K/Q37Qqv9G05CCIAky/JJpIJ0QNxW
	Q8p61Xj6Ger9xF4nvSpcd5Thv0lE+Ht8wNypa5RbCL9iVscUg1eUeEv0vHFGoO+X
	KP8a2Hdz4yLb4TTUwSdxm5jWVdZ+IisIUt4f6My5Vs9no9fGR3M1oU7K0FawMLl8
	57B8hoeRpFhbxf3qzEG8H4/WwgWBwie/txEKZi1PcAjgS4dx9bBWvMXlNd6Rl0ZM
	EyshiVPwsjNsgxBlN7rcg8x5bvmNgciHNUuuDwbYg2ARVqEX/p7CwaclQJcOLd9V
	VxYvCw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40gurtw25n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 23:05:13 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46PN5Csn030879
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 23:05:12 GMT
Received: from [10.46.163.151] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 25 Jul
 2024 16:05:11 -0700
Message-ID: <fa72b87d-2630-40c2-9996-bdf9e16cf11b@quicinc.com>
Date: Thu, 25 Jul 2024 16:05:11 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] PCI: dwc: Add dbi_phys_addr and atu_phys_addr to
 struct dw_pcie
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <jingoohan1@gmail.com>, <manivannan.sadhasivam@linaro.org>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <quic_mrana@quicinc.com>
References: <20240724183918.GA806896@bhelgaas>
Content-Language: en-US
From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
In-Reply-To: <20240724183918.GA806896@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -Tn0u5nXAQdPbC4dW5kZci_2gYOh92Vb
X-Proofpoint-ORIG-GUID: -Tn0u5nXAQdPbC4dW5kZci_2gYOh92Vb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-25_24,2024-07-25_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 mlxlogscore=937
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407250158

Hi Bjorn,

Thanks for the review comments.

On 7/24/2024 11:39 AM, Bjorn Helgaas wrote:
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
>> +	phys_addr_t		dbi_phys_addr;
>>  	void __iomem		*dbi_base2;
>>  	void __iomem		*atu_base;
>> +	phys_addr_t		atu_phys_addr;
>>  	size_t			atu_size;
>>  	u32			num_ib_windows;
>>  	u32			num_ob_windows;
> 
> This patch is pretty trivial and it doesn't show anything to justify
> the need to keep these addresses.  I think this should be squashed
> with the next patch that actually *uses* them.
> 

ACK. I will update it in the next patch.

Thanks,
Prudhvi

