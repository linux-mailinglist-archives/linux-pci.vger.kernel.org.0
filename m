Return-Path: <linux-pci+bounces-10739-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A5E93B6BE
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 20:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5423B21887
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 18:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0FC15F3E0;
	Wed, 24 Jul 2024 18:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gAhz6rYB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3DE481CE;
	Wed, 24 Jul 2024 18:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721846132; cv=none; b=CvfzOYDXM7XM5tSRy8viUGcwtQ9l0LFXAMN/2P51a/wN8fYim3AXF2bbS09icz49rXRnNM3ZK0Xv4mhc+mg4NpTRxoEd4G7f8gbMrgjykPK9/e077G4AZn3+b/nmEtm98SFMmLIXJR7irFqqsXozlLwWkwRl6fzdcgJlNN53E6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721846132; c=relaxed/simple;
	bh=VTqyW1fA2hEoyM4IoPfHczNWlFr3fCQYjIliGCgRJCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YaUgZlXLXuJ71s+us0fw2XrmRrUc1P4F+vVyQX0xyiy0eswD///B8J4liAV66TJpXobsDwbeFnAwpCtLv4BNEygLxSSIugt5McPlVSUppi3ps7qi0NEhYt/TJUTJo7oiUlpTl9tGQWvWwL9dXsn+AHKicUQHFfyl6X7mEztC8eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gAhz6rYB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46O9hewl003709;
	Wed, 24 Jul 2024 18:35:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KybfWc4urbYhivrAcsfRTYGiaTQ6pBXng08Y4H9TpKU=; b=gAhz6rYBqddZKIZk
	sCVvT2j1XXq/09l7juoakK73I28s2Ozz1O3LtulVC0PWYH3G/0t9hHrkWab2D62L
	U6nH+6D+t3LBzqP+JMUwK2yEY0Fz95x6eMeA7jn9TqT/C+2cH0fEkCdsJI5F2MnU
	xg6pdjm26E8jESpgAQEasvVjMfeQdl2eV4e8EC1vACwDv3gidAqZnGQw0MXq975Y
	d6xCYsaY/u3xZ4PmUyB3hOZ+nHHILQGgJm6ORUZ/+KtHqUYKkbUls8OIGdi7Tqp9
	OfMhlaDE2zmcgRUhrZOjsUjt4KZzOd68KYB7CtB7tNPssVBXvdqomMQ0dULriSs2
	699Gow==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g5autwsa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 18:35:21 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46OIZKvE013172
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 18:35:20 GMT
Received: from [10.110.66.115] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 24 Jul
 2024 11:35:20 -0700
Message-ID: <f7012a31-6c04-47fb-a562-a991db76a6ff@quicinc.com>
Date: Wed, 24 Jul 2024 11:34:55 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] PCI: qcom: Avoid DBI and ATU register space mirror
 to BAR/MMIO region
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: <jingoohan1@gmail.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <quic_mrana@quicinc.com>
References: <20240724022719.2868490-1-quic_pyarlaga@quicinc.com>
 <20240724022719.2868490-3-quic_pyarlaga@quicinc.com>
 <20240724141011.GF3349@thinkpad>
Content-Language: en-US
From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
In-Reply-To: <20240724141011.GF3349@thinkpad>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3SPsoihfCY5aTcJqBfDnkbFOAp6j9Bc1
X-Proofpoint-GUID: 3SPsoihfCY5aTcJqBfDnkbFOAp6j9Bc1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_19,2024-07-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 clxscore=1015 phishscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407240134

Hi Manivannan,

Thanks for the review comments.

On 7/24/2024 7:10 AM, Manivannan Sadhasivam wrote:
> Subject:
> 
> PCI: qcom: Disable mirroring of DBI and iATU register space in BAR/MMIO region
> 

ACK. I will update it in the next patch.

> On Tue, Jul 23, 2024 at 07:27:19PM -0700, Prudhvi Yarlagadda wrote:
>> PARF hardware block which is a wrapper on top of DWC PCIe controller
>> mirrors the DBI and ATU register space. It uses PARF_SLV_ADDR_SPACE_SIZE
>> register to get the size of the memory block to be mirrored and uses
>> PARF_DBI_BASE_ADDR, PARF_ATU_BASE_ADDR registers to determine the base
>> address of DBI and ATU space inside the memory block that is being
>> mirrored.
>>
>> When a memory region which is located above the SLV_ADDR_SPACE_SIZE
>> boundary is used for BAR region then there could be an overlap of DBI and
>> ATU address space that is getting mirrored and the BAR region. This
>> results in DBI and ATU address space contents getting updated when a PCIe
>> function driver tries updating the BAR/MMIO memory region. Reference
>> memory map of the PCIe memory region with DBI and ATU address space
>> overlapping BAR region is as below.
>>
>>                         |---------------|
>>                         |               |
>>                         |               |
>>         ------- --------|---------------|
>>            |       |    |---------------|
>>            |       |    |       DBI     |
>>            |       |    |---------------|---->DBI_BASE_ADDR
>>            |       |    |               |
>>            |       |    |               |
>>            |    PCIe    |               |---->2*SLV_ADDR_SPACE_SIZE
>>            |    BAR/MMIO|---------------|
>>            |    Region  |       ATU     |
>>            |       |    |---------------|---->ATU_BASE_ADDR
>>            |       |    |               |
>>         PCIe       |    |---------------|
>>         Memory     |    |       DBI     |
>>         Region     |    |---------------|---->DBI_BASE_ADDR
>>            |       |    |               |
>>            |    --------|               |
>>            |            |               |---->SLV_ADDR_SPACE_SIZE
>>            |            |---------------|
>>            |            |       ATU     |
>>            |            |---------------|---->ATU_BASE_ADDR
>>            |            |               |
>>            |            |---------------|
>>            |            |       DBI     |
>>            |            |---------------|---->DBI_BASE_ADDR
>>            |            |               |
>>            |            |               |
>>         ----------------|---------------|
>>                         |               |
>>                         |               |
>>                         |               |
>>                         |---------------|
>>
>> Currently memory region beyond the SLV_ADDR_SPACE_SIZE boundary is not
>> used for BAR region which is why the above mentioned issue is not
>> encountered. This issue is discovered as part of internal testing when we
>> tried moving the BAR region beyond the SLV_ADDR_SPACE_SIZE boundary. Hence
>> we are trying to fix this.
>>
>> As PARF hardware block mirrors DBI and ATU register space after every
>> PARF_SLV_ADDR_SPACE_SIZE (default 0x1000000) boundary multiple, write
>> U32_MAX (all 0xFF's) to PARF_SLV_ADDR_SPACE_SIZE register to avoid
>> mirroring DBI and ATU to BAR/MMIO region. Write the physical base address
>> of DBI and ATU register blocks to PARF_DBI_BASE_ADDR (default 0x0) and
>> PARF_ATU_BASE_ADDR (default 0x1000) respectively to make sure DBI and ATU
>> blocks are at expected memory locations.
>>
>> The register offsets PARF_DBI_BASE_ADDR_V2, PARF_SLV_ADDR_SPACE_SIZE_V2
>> and PARF_ATU_BASE_ADDR are applicable for platforms that use PARF
> 
> There is no 'PARF Qcom IP', just 'Qcom IP'. Here and below.
> 

ACK. I will update it in the next patch.

>> Qcom IP rev 1.9.0, 2.7.0 and 2.9.0. PARF_DBI_BASE_ADDR_V2 and
>> PARF_SLV_ADDR_SPACE_SIZE_V2 are applicable for PARF Qcom IP rev 2.3.3.
>> PARF_DBI_BASE_ADDR and PARF_SLV_ADDR_SPACE_SIZE are applicable for PARF
>> Qcom IP rev 1.0.0, 2.3.2 and 2.4.0. Updating the init()/post_init()
> 
> Use imperative tone in commit message. s/Updating/Update
> 

ACK. I will update it in the next patch.

>> functions of the respective PARF versions to program applicable
>> PARF_DBI_BASE_ADDR, PARF_SLV_ADDR_SPACE_SIZE and PARF_ATU_BASE_ADDR
>> register offsets. And remove the unused SLV_ADDR_SPACE_SZ macro.
>>
>> Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
>> Reviewed-by: Mayank Rana <quic_mrana@quicinc.com>
>> ---
>>  drivers/pci/controller/dwc/pcie-qcom.c | 62 +++++++++++++++++++-------
>>  1 file changed, 45 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index 0180edf3310e..6976efb8e2f0 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -45,6 +45,7 @@
>>  #define PARF_PHY_REFCLK				0x4c
>>  #define PARF_CONFIG_BITS			0x50
>>  #define PARF_DBI_BASE_ADDR			0x168
>> +#define PARF_SLV_ADDR_SPACE_SIZE		0x16C
> 
> Use lowercase for hex.
> 

ACK. I will update it in the next patch.

Thanks,
Prudhvi
> Rest LGTM! With above mentioned changes,
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> - Mani
> 

