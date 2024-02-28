Return-Path: <linux-pci+bounces-4180-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BCB86AFE1
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 14:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B58421C22173
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 13:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2E2149DE5;
	Wed, 28 Feb 2024 13:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UXiHg9a/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C331314691C;
	Wed, 28 Feb 2024 13:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709125586; cv=none; b=CPyZMi60eH+eMMvvPFPSuiFr0awxUS8sFlvEOCoa0lWXpgkS7cQ304/fesxAzvHZ7hzK/HlSJV9+tGdKW4Z0tPSBIaYq5sJ2WaFL5azpPvA5KTMORm0Jd9IKBo6+Am0iM4XOdLWIYdrXLK7ten1D2J0AsfQB75o65Anvv7L7/Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709125586; c=relaxed/simple;
	bh=b2Ig2bSrvAWCjWDAGJzCNXj0xb7pA3/vdDPzXmg9efw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dlxNpJW7hXy8azcWaaTKJ9E1y0rDtbkgqQmOHTlA+eaAsxXQmMPiLndVpatHEFJXWrTY4b0IlLfBIoc9dpNSSU0vlmJFCq1r6G1VyiF7V4vj6ZN3mr4zeT8r7ddhKaQJNFXWWbRHPf8sp59bWS678O/bUnpv9jMuLrjJDKeF8pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UXiHg9a/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41S59x2g021611;
	Wed, 28 Feb 2024 13:06:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=5OVExsAPMnmn+la7f25Pu1bxp8NeHQu4Jdb0u6jp0oE=; b=UX
	iHg9a/2wYQEXWWWNye5X8EtbzAByLyhHgem+jAmLGzcHK/PUfwem4JrxgyTDgl7d
	VSJpV8fTfcUdQnlda9ef3OTVmKx7NOYC8Eph175zCLJAGDI4GOoHSYq9rQ7LTXqF
	HPKa6aTofv1ax1pWxfqUcy0kP5BvxAGf2wKwoU3YVmw1qxQ9PnN8NQ7ArsPNAKMA
	KF2AB5Ln9leCGOvFo/omBEfcght/B4/yl3FQOhRxd1q/9VHaGSF+YglB7A92uzUG
	HiM/jCtkSn9IWPGVAlTpJXKzWVRqya9dZe9tyGGyuGbd78aeO77VKDOe5yj9Y7G9
	AH7Y4dTL92PthYTmgXAA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3whu8k19xe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 13:06:12 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41SD6BeA018566
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 13:06:11 GMT
Received: from [10.218.10.86] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 28 Feb
 2024 05:06:04 -0800
Message-ID: <8dc0f8e4-e7e6-98b6-037b-31b86c6087af@quicinc.com>
Date: Wed, 28 Feb 2024 18:36:01 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 2/3] PCI: qcom-ep: Enable cache coherency for SA8775P
 EP
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>
CC: <quic_shazhuss@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_nayiluri@quicinc.com>,
        <dmitry.baryshkov@linaro.org>, <quic_krichai@quicinc.com>,
        <quic_vbadigan@quicinc.com>, <quic_schintav@quicinc.com>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?=
	<kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
References: <1708697021-16877-1-git-send-email-quic_msarkar@quicinc.com>
 <1708697021-16877-3-git-send-email-quic_msarkar@quicinc.com>
 <640775cb-3508-4228-aa94-2e4b7b6b2b6d@linaro.org>
From: Mrinmay Sarkar <quic_msarkar@quicinc.com>
In-Reply-To: <640775cb-3508-4228-aa94-2e4b7b6b2b6d@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SxOULRZ_ja7o0_1XuoiMOY3p95yOxIWy
X-Proofpoint-GUID: SxOULRZ_ja7o0_1XuoiMOY3p95yOxIWy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_06,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 impostorscore=0 suspectscore=0 clxscore=1015 phishscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402280103


On 2/24/2024 5:37 AM, Konrad Dybcio wrote:
> On 23.02.2024 15:03, Mrinmay Sarkar wrote:
>> Due to some hardware changes, SA8775P has set the NO_SNOOP attribute
>> in its TLP for all the PCIe controllers. NO_SNOOP attribute when set,
>> the requester is indicating that there no cache coherency issues exit
>> for the addressed memory on the host i.e., memory is not cached. But
>> in reality, requester cannot assume this unless there is a complete
>> control/visibility over the addressed memory on the host.
>>
>> And worst case, if the memory is cached on the host, it may lead to
>> memory corruption issues. It should be noted that the caching of memory
>> on the host is not solely dependent on the NO_SNOOP attribute in TLP.
>>
>> So to avoid the corruption, this patch overrides the NO_SNOOP attribute
>> by setting the PCIE_PARF_NO_SNOOP_OVERIDE register. This patch is not
>> needed for other upstream supported platforms since they do not set
>> NO_SNOOP attribute by default.
>>
>> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom-ep.c | 20 +++++++++++++++++---
>>   1 file changed, 17 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
>> index 89d06a3e6e06..369954649254 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
>> @@ -45,6 +45,7 @@
>>   #define PARF_SLV_ADDR_MSB_CTRL			0x2c0
>>   #define PARF_DBI_BASE_ADDR			0x350
>>   #define PARF_DBI_BASE_ADDR_HI			0x354
>> +#define PARF_NO_SNOOP_OVERIDE			0x3d4
> Any reason for this to be unsorted?
>
> Konrad
Yes, this should be sorted. Will fix this in next series.

Thanks
Mrinmay

