Return-Path: <linux-pci+bounces-11508-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8348594C45D
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 20:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37E02286AD6
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 18:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C25145346;
	Thu,  8 Aug 2024 18:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CROxWmNV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6C21474A5;
	Thu,  8 Aug 2024 18:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723141941; cv=none; b=SxbG0vufbmHFjQY/5O77B1zTWgfUoTfIt63MW/MajhV0WD26faoL7YpsObGhZvuciKVT/rGIQdpimVsSOiANnlB1NiPHPGeHNZc++BZ/wvfGt1xjg4pcMYsP5qinyigmcedjHSc0uaep4znPjKfQdi5H+NmbNvkwx9PpaQ8shVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723141941; c=relaxed/simple;
	bh=9Yt4pnncH6mFyFDA0PhRciskoYS67a0cDghZgw5y9/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=U/M/1PaZTtB9UfSl6Nv9CGnt4nIqqFeBjy/upb/0f4KG+GqdYzmxKHI2nXzHkKiMqSGDKX28MQ21SYgjCNrMQRlMGXbHXGrywmOO3/CNJPtcH9+FdT1obcCENMlLIp7u/6/vMKarn0H+nyjck5wcqFQ/4i1emHLregonPku4Poc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CROxWmNV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 478BOGQG020921;
	Thu, 8 Aug 2024 18:32:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zobjxfHDjVRTy23SW+DYAKRhJIe+GrRQlShULtl4F5E=; b=CROxWmNVPUTqyFck
	FFX3F1Pz/rftm7ZnPH+ht97Ey3nDMvWocXSYBAF2zoR4VUJvWHO7qsS8MFqIJfMp
	wqw5KLwQblR65g2Dk2VeHVZPOX7sjChnXBOC89G0Lg+u5CpHcS65c8cGW/aUmM+L
	S/XwLIc6UFjNYwVoijSxClhf5nckA3OMg2Mc5DtjtcZHF4UkcNUQMQb4fBSN+U2q
	wYANu7+KrMWdgMn1L09NaK0uGWOmCv4wlkS+/nmCCUmxe6CvsplmFtJm0+YeLrT0
	R+76F5wZ1Ha1Ujz3owCb7UvliDZA7sVQ9bV96wufIU34PF1UZmV1SyVZPnL0oelB
	gBWi3g==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40v79jcf85-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Aug 2024 18:32:11 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 478IWAxV008391
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 8 Aug 2024 18:32:10 GMT
Received: from [10.46.163.151] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 8 Aug 2024
 11:32:10 -0700
Message-ID: <81f9a907-8010-4c13-970f-d216dd54b1f1@quicinc.com>
Date: Thu, 8 Aug 2024 11:30:52 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] PCI: dwc: Add dbi_phys_addr and atu_phys_addr to
 struct dw_pcie
To: Serge Semin <fancer.lancer@gmail.com>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Bjorn Helgaas <helgaas@kernel.org>
CC: <jingoohan1@gmail.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <quic_mrana@quicinc.com>
References: <20240724022719.2868490-1-quic_pyarlaga@quicinc.com>
 <20240724022719.2868490-2-quic_pyarlaga@quicinc.com>
 <vbq3ma3xanu4budrrt7iwk7bh7evgmlgckpohqksuamf3odbee@mvox7krdugg3>
 <6d926346-1c24-4aee-85b1-ffb5a0df904b@quicinc.com>
 <j62ox6yeemxng3swlnzkqpl4mos7zj4khui6rusrm7nqcpts6r@vmoddl4lchlt>
 <20240802052206.GA4206@thinkpad>
 <rw45lgwf5btlsr64okzk2e4rpd62fdyrou7u2c6lndozxjhdpq@qm5qx4dvw5ci>
Content-Language: en-US
From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
In-Reply-To: <rw45lgwf5btlsr64okzk2e4rpd62fdyrou7u2c6lndozxjhdpq@qm5qx4dvw5ci>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: a_VDmT9LalIgb6dYp_CWrWMX1LyhsfA9
X-Proofpoint-ORIG-GUID: a_VDmT9LalIgb6dYp_CWrWMX1LyhsfA9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-08_18,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408080132



On 8/2/2024 2:22 AM, Serge Semin wrote:
> On Fri, Aug 02, 2024 at 10:52:06AM +0530, Manivannan Sadhasivam wrote:
>> On Fri, Aug 02, 2024 at 12:59:57AM +0300, Serge Semin wrote:
>>> On Thu, Aug 01, 2024 at 02:29:49PM -0700, Prudhvi Yarlagadda wrote:
>>>> Hi Serge,
>>>>
>>>> Thanks for the review comment.
>>>>
>>>> On 8/1/2024 12:25 PM, Serge Semin wrote:
>>>>> On Tue, Jul 23, 2024 at 07:27:18PM -0700, Prudhvi Yarlagadda wrote:
>>>>>> Both DBI and ATU physical base addresses are needed by pcie_qcom.c
>>>>>> driver to program the location of DBI and ATU blocks in Qualcomm
>>>>>> PCIe Controller specific PARF hardware block.
>>>>>>
>>>>>> Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
>>>>>> Reviewed-by: Mayank Rana <quic_mrana@quicinc.com>
>>>>>> ---
>>>>>>  drivers/pci/controller/dwc/pcie-designware.c | 2 ++
>>>>>>  drivers/pci/controller/dwc/pcie-designware.h | 2 ++
>>>>>>  2 files changed, 4 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
>>>>>> index 1b5aba1f0c92..bc3a5d6b0177 100644
>>>>>> --- a/drivers/pci/controller/dwc/pcie-designware.c
>>>>>> +++ b/drivers/pci/controller/dwc/pcie-designware.c
>>>>>> @@ -112,6 +112,7 @@ int dw_pcie_get_resources(struct dw_pcie *pci)
>>>>>>  		pci->dbi_base = devm_pci_remap_cfg_resource(pci->dev, res);
>>>>>>  		if (IS_ERR(pci->dbi_base))
>>>>>>  			return PTR_ERR(pci->dbi_base);
>>>>>> +		pci->dbi_phys_addr = res->start;
>>>>>>  	}
>>>>>>  
>>>>>>  	/* DBI2 is mainly useful for the endpoint controller */
>>>>>> @@ -134,6 +135,7 @@ int dw_pcie_get_resources(struct dw_pcie *pci)
>>>>>>  			pci->atu_base = devm_ioremap_resource(pci->dev, res);
>>>>>>  			if (IS_ERR(pci->atu_base))
>>>>>>  				return PTR_ERR(pci->atu_base);
>>>>>> +			pci->atu_phys_addr = res->start;
>>>>>>  		} else {
>>>>>>  			pci->atu_base = pci->dbi_base + DEFAULT_DBI_ATU_OFFSET;
>>>>>>  		}
>>>>>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
>>>>>> index 53c4c8f399c8..efc72989330c 100644
>>>>>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>>>>>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
>>>>>> @@ -407,8 +407,10 @@ struct dw_pcie_ops {
>>>>>>  struct dw_pcie {
>>>>>>  	struct device		*dev;
>>>>>>  	void __iomem		*dbi_base;
>>>>>
>>>>>> +	phys_addr_t		dbi_phys_addr;
>>>>>>  	void __iomem		*dbi_base2;
>>>>>>  	void __iomem		*atu_base;
>>>>>> +	phys_addr_t		atu_phys_addr;
>>>>>
>>>>> What's the point in adding these fields to the generic DW PCIe private
>>>>> data if they are going to be used in the Qcom glue driver only?
>>>>>
>>>>> What about moving them to the qcom_pcie structure and initializing the
>>>>> fields in some place of the pcie-qcom.c driver?
>>>>>
>>>>> -Serge(y)
>>>>>
>>>>
>>>
>>>> These fields were in pcie-qcom.c driver in the v1 patch[1] and
>>>> Manivannan suggested to move these fields to 'struct dw_pcie' so that duplication
>>>> of resource fetching code 'platform_get_resource_byname()' can be avoided.
>>>>
>>>> [1] https://lore.kernel.org/linux-pci/a01404d2-2f4d-4fb8-af9d-3db66d39acf7@quicinc.com/T/#mf9843386d57e9003de983e24e17de4d54314ff73
>>>
>>> Em, polluting the core driver structure with data not being used by
>>> the core driver but by the glue-code doesn't seem like a better
>>> alternative to additional platform_get_resource_byname() call in the
>>> glue-driver. I would have got back v1 version so to keep the core
>>> driver simpler. Bjorn?
>>>
>>
>> IDK how adding two fields which is very related to DWC code *pollutes* it. Since
>> there is already 'dbi_base', adding 'dbi_phys_addr' made sense to me even though
>> only glue drivers are using it. Otherwise, glue drivers have to duplicate the
>> platform_get_resource_byname() code which I find annoying.
> 
> I just explained why it was redundant:
> 1. adding the fields expands the core private data size for _all_
> platforms for no reason. (a few bytes but still)
> 2. the new fields aren't utilized by the core driver, but still
> defined in the core private data which is first confusing and
> second implicitly encourages the kernel developers to add another
> unused or even weakly-related fields in there.
> 3. the new fields utilized in a single glue-driver and there is a small
> chance they will be used in another ones. Another story would have
> been if we had them used in more than one glue-driver...
> 
> So from that perspective I find adding these fields to the driver core
> data less appropriate than duplicating the
> platform_get_resource_byname() call in a _single_ glue driver. It
> seems more reasonable to have them defined and utilized in the code
> that actually needs them, but not in the place that doesn't annoy you.)
> 
> Anyway I read your v1 command and did understand your point in the
> first place. That's why my question was addressed to Bjorn.
> 
> Please also note the resource::start field is of the resource_size_t
> type. So wherever the fields are added, it's better to have them
> defined of that type instead.
> 
> -Serge(y)
> 

Hi Bjorn,

Gentle ping for your feedback on the above discussed two approaches.

Thanks,
Prudhvi
>>
>> - Mani
>>
>> -- 
>> மணிவண்ணன் சதாசிவம்
> 

