Return-Path: <linux-pci+bounces-987-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0ADC812C9D
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 11:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58C52B210CF
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 10:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5071B39FF7;
	Thu, 14 Dec 2023 10:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lIpCFK0m"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936E510E;
	Thu, 14 Dec 2023 02:14:41 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BE9Amoq013135;
	Thu, 14 Dec 2023 10:14:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=5Eh2WYQpbZ/3Zec81rTCR6KeMKnTOxtD+S6i90Tlwy4=; b=lI
	pCFK0mCU/YpYaLzMD170ajo3GljWOklARLpMvatDsPPYyfsTrNsrpvELz+mbyBmt
	r2afsJIn+QTArNPMrcMfmcJ9YfXzsycVDKf8Ad4FrYsP6ah0ywROBrK3dQLVnnyR
	IlFL+2MptCZxnFV4lJwC5PEiMz+McE6WqzBVMT1q61EGLFUj8gk1pB3J/Pk4wdyc
	2AyXdVijk2uR7VZ0qEsyhIXYPZdEiCLso/FlDnrwYScpTiIX+hl7cQFA9mQ1MSfV
	I6aD+fxggF+HNgaD3X3bYE+qt5Dx1OwyIvFQbF2YOqe5Hytnb15+MOEH3D/KRVNN
	qNPU04FyxipsD2z9Zabw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uynre14jv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 10:14:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BEAER4j026127
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 10:14:27 GMT
Received: from [10.217.219.216] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 14 Dec
 2023 02:14:24 -0800
Message-ID: <8929dcd0-af98-5b18-2d90-aad7b5928578@quicinc.com>
Date: Thu, 14 Dec 2023 15:44:21 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 6/9] PCI: epf-mhi: Enable MHI async read/write support
Content-Language: en-US
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: <lpieralisi@kernel.org>, <kw@linux.com>, <kishon@kernel.org>,
        <bhelgaas@google.com>, <mhi@lists.linux.dev>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20231127124529.78203-1-manivannan.sadhasivam@linaro.org>
 <20231127124529.78203-7-manivannan.sadhasivam@linaro.org>
 <feb4ed1b-ed74-aebe-0ab8-dec123fe0a31@quicinc.com>
 <20231214100936.GI2938@thinkpad>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20231214100936.GI2938@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: hRUBvUOtAIqms4wGoJ6kJ7n8P9XE4vua
X-Proofpoint-GUID: hRUBvUOtAIqms4wGoJ6kJ7n8P9XE4vua
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=759
 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312140068


On 12/14/2023 3:39 PM, Manivannan Sadhasivam wrote:
> On Thu, Dec 14, 2023 at 03:10:01PM +0530, Krishna Chaitanya Chundru wrote:
>> On 11/27/2023 6:15 PM, Manivannan Sadhasivam wrote:
>>> Now that both eDMA and iATU are prepared to support async transfer, let's
>>> enable MHI async read/write by supplying the relevant callbacks.
>>>
>>> In the absence of eDMA, iATU will be used for both sync and async
>>> operations.
>>>
>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>> ---
>>>    drivers/pci/endpoint/functions/pci-epf-mhi.c | 7 ++++---
>>>    1 file changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
>>> index 3d09a37e5f7c..d3d6a1054036 100644
>>> --- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
>>> +++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
>>> @@ -766,12 +766,13 @@ static int pci_epf_mhi_link_up(struct pci_epf *epf)
>>>    	mhi_cntrl->raise_irq = pci_epf_mhi_raise_irq;
>>>    	mhi_cntrl->alloc_map = pci_epf_mhi_alloc_map;
>>>    	mhi_cntrl->unmap_free = pci_epf_mhi_unmap_free;
>>> +	mhi_cntrl->read_sync = mhi_cntrl->read_async = pci_epf_mhi_iatu_read;
>>> +	mhi_cntrl->write_sync = mhi_cntrl->write_async = pci_epf_mhi_iatu_write;
>>>    	if (info->flags & MHI_EPF_USE_DMA) {
>>>    		mhi_cntrl->read_sync = pci_epf_mhi_edma_read;
>>>    		mhi_cntrl->write_sync = pci_epf_mhi_edma_write;
>>> -	} else {
>>> -		mhi_cntrl->read_sync = pci_epf_mhi_iatu_read;
>>> -		mhi_cntrl->write_sync = pci_epf_mhi_iatu_write;
>>> +		mhi_cntrl->read_async = pci_epf_mhi_edma_read_async;
>>> +		mhi_cntrl->write_async = pci_epf_mhi_edma_write_async;
>> I think the read_async & write async should be updated inside the if
>> condition where MHI_EPF_USE_DMA flag is set.
>>
> That's what being done here. Am I missing anything?
>
> - Mani

It should be like this as edma sync & aysnc read write should be update 
only if DMA is supported, in the patch I see async function pointers are 
being updated with the edma function pointers for IATU operations.

                 if (info->flags & MHI_EPF_USE_DMA) {

   		mhi_cntrl->read_sync = pci_epf_mhi_edma_read;
   		mhi_cntrl->write_sync = pci_epf_mhi_edma_write;
		mhi_cntrl->read_async = pci_epf_mhi_edma_read_async;
		mhi_cntrl->write_async = pci_epf_mhi_edma_write_async;
	}
- Krishna Chaitanya.

>> - Krishna Chaitanya.
>>
>>>    	}
>>>    	/* Register the MHI EP controller */

