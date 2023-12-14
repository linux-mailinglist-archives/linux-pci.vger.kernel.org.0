Return-Path: <linux-pci+bounces-981-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBFC812BD6
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 10:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B43A282729
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 09:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E9ED28C;
	Thu, 14 Dec 2023 09:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ie4VzWtI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E53B7;
	Thu, 14 Dec 2023 01:40:24 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BE5BZ8V000884;
	Thu, 14 Dec 2023 09:40:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ylZKeaeVio8dJQPPzUpdLFA/Xy9jSrZkzVN2dfqdK5Y=; b=ie
	4VzWtIoTJoKnZ2KCiiOUtdJ+HqaBrVgvcFVkqPUEHX7pLjRVxtHJ5Q2/GR7iCvDb
	hF9EDnCYy446BswYuIqpSrwcG2cqoqNB+6IS8ovUI0XJuMe9HxQWlygIpWJ9ZAt2
	Q0csHlUTnMm4J3VZkk1ArttF5Y4lSahwneHT0cf8F5LJSzJzAzfe4kH1jG9+8iCO
	ArS00x0vj9RqwidIV8/C4SeviPUzY72ZkxJ8/8iJTgGnE3ez1DDbxWcjObKmPckr
	xRINraZXDrfWE3Ht/aHDdmRRjv6/JeFj0o4qBGmtk9JNieMrW3ICCanlC1zu7ArQ
	P8Ip6AuWZsjyVx/fky0g==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uyq2try5r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 09:40:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BE9e8Tf026735
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 09:40:08 GMT
Received: from [10.217.219.216] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 14 Dec
 2023 01:40:05 -0800
Message-ID: <feb4ed1b-ed74-aebe-0ab8-dec123fe0a31@quicinc.com>
Date: Thu, 14 Dec 2023 15:10:01 +0530
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
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <lpieralisi@kernel.org>, <kw@linux.com>
CC: <kishon@kernel.org>, <bhelgaas@google.com>, <mhi@lists.linux.dev>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20231127124529.78203-1-manivannan.sadhasivam@linaro.org>
 <20231127124529.78203-7-manivannan.sadhasivam@linaro.org>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20231127124529.78203-7-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: D4LrvjH_ipBuxno5YuE7y02tarNOxuc5
X-Proofpoint-ORIG-GUID: D4LrvjH_ipBuxno5YuE7y02tarNOxuc5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 phishscore=0 clxscore=1011 mlxlogscore=818 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312140062


On 11/27/2023 6:15 PM, Manivannan Sadhasivam wrote:
> Now that both eDMA and iATU are prepared to support async transfer, let's
> enable MHI async read/write by supplying the relevant callbacks.
>
> In the absence of eDMA, iATU will be used for both sync and async
> operations.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   drivers/pci/endpoint/functions/pci-epf-mhi.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> index 3d09a37e5f7c..d3d6a1054036 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> @@ -766,12 +766,13 @@ static int pci_epf_mhi_link_up(struct pci_epf *epf)
>   	mhi_cntrl->raise_irq = pci_epf_mhi_raise_irq;
>   	mhi_cntrl->alloc_map = pci_epf_mhi_alloc_map;
>   	mhi_cntrl->unmap_free = pci_epf_mhi_unmap_free;
> +	mhi_cntrl->read_sync = mhi_cntrl->read_async = pci_epf_mhi_iatu_read;
> +	mhi_cntrl->write_sync = mhi_cntrl->write_async = pci_epf_mhi_iatu_write;
>   	if (info->flags & MHI_EPF_USE_DMA) {
>   		mhi_cntrl->read_sync = pci_epf_mhi_edma_read;
>   		mhi_cntrl->write_sync = pci_epf_mhi_edma_write;
> -	} else {
> -		mhi_cntrl->read_sync = pci_epf_mhi_iatu_read;
> -		mhi_cntrl->write_sync = pci_epf_mhi_iatu_write;
> +		mhi_cntrl->read_async = pci_epf_mhi_edma_read_async;
> +		mhi_cntrl->write_async = pci_epf_mhi_edma_write_async;

I think the read_async & write async should be updated inside the if 
condition where MHI_EPF_USE_DMA flag is set.

- Krishna Chaitanya.

>   	}
>   
>   	/* Register the MHI EP controller */

