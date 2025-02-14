Return-Path: <linux-pci+bounces-21453-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D492A35E2B
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 14:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 990723A931B
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 12:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1903F263F46;
	Fri, 14 Feb 2025 12:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PVgUCeCE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D891263C77;
	Fri, 14 Feb 2025 12:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739537880; cv=none; b=J5fwKjaeHV3Qnzz1X4UvboVjhW2bdTAdH/83E9VTOOm9S9C8BS8nPvpm1vKx2bvZeFjvmJnafFkSv9aIFEZ3hNQNR/4rKMfELubC6pmaD9jDWz8AohnuDiWu2ETUHUhmisUBKtPj8IvdJAQkdHI1l1ydNJ4Yy26YofaAeijuPIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739537880; c=relaxed/simple;
	bh=alONTJ5izPBs5NVNtGqcxXXw/F3dPnAoYUIDkZtfNoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BqztOKEDT5pqFX+41gKyLw8QifQRplG0M+WdCj38dD5HeUnwaUpJwnnEYmsHZfkdJ4O1spJNgVzJrUewzv1tyyKnTMTNf9maNXXM4qfwdh839w13YE9JKOrpgJAH+hoM2lEUiJjawp40eMu3HWRDbnf+1X71ITgl9Lf6asPLy9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PVgUCeCE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51E7i2wV015968;
	Fri, 14 Feb 2025 12:57:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Eeic6vXkmMzY8YnqF8B8+d/0s0ePlY9ZRC/bULfVz9M=; b=PVgUCeCE9F2rRhXX
	GzjSWiCH6P5O+kLbZtt+AEZ00puhiZnlYoo/pAAzuLWkhBph/rjI4DZd31iJmfi+
	w8+AAy73Zwm+JekXLLMZIvS6Ece5ErQBvOEiS3OtI8glWeY7G+9ldBueMK0Cgu8u
	TbUH8HTI5gRptoBqobtu0Tl0aCekLv5NbM6DNccHsjO2N53bm4O7uEDQYBkZj1jR
	rtsOVsh7C9fJ6ZGGqC559iqh2qMu4nciP3boqhzPVDa7Olvt5Nm6hIeQ9cN8WusZ
	uS6VK7KmdOLPDBV/uMM9CUtT6PG2PoEptRYrFYV8arfJO4DbPSyQ5594X99aCh4C
	wkBp+g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44sde8btc2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 12:57:26 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51ECvPfS025861
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 12:57:25 GMT
Received: from [10.219.56.14] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 14 Feb
 2025 04:57:18 -0800
Message-ID: <2a090f80-e145-410d-8d02-efdaf324c8c9@quicinc.com>
Date: Fri, 14 Feb 2025 18:27:14 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iommu: Handle race with default domain setup
To: Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla
	<sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
	<lenb@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>, Stuart
 Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Nipun
 Gupta <nipun.gupta@amd.com>,
        Nikhil Agarwal <nikhil.agarwal@amd.com>,
        Joerg
 Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Rob Herring
	<robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
        Bjorn Helgaas
	<bhelgaas@google.com>
CC: <linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
        <devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <cover.1739486121.git.robin.murphy@arm.com>
 <87bd187fa98a025c9665747fbfe757a8bf249c18.1739486121.git.robin.murphy@arm.com>
Content-Language: en-US
From: Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <87bd187fa98a025c9665747fbfe757a8bf249c18.1739486121.git.robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8MPMEM59TFtEpOVHpTq1BK9dVBJIHPE2
X-Proofpoint-ORIG-GUID: 8MPMEM59TFtEpOVHpTq1BK9dVBJIHPE2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_05,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 clxscore=1011 mlxscore=0 mlxlogscore=999 spamscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502140095

Thanks a lot for posting these patches, Robin.

On 2/14/2025 5:18 AM, Robin Murphy wrote:
>  drivers/iommu/iommu.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 870c3cdbd0f6..2486f6d6ef68 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -3097,6 +3097,11 @@ int iommu_device_use_default_domain(struct device *dev)
>  		return 0;
>  
>  	mutex_lock(&group->mutex);
> +	/* We may race against bus_iommu_probe() finalising groups here */
> +	if (!group->default_domain) {
> +		ret = -EPROBE_DEFER;
> +		goto unlock_out;
> +	}

We just hit the issue again even after picking up this patch, though
very hard to reproduce, on 6.6 LTS.

After code inspection, it seems the issue is that - default domain is
setup in the bus_iommu_probe() before hitting of this replay.

A:async client probe in platform_dma_configure(), B:bus_iommu_probe() :-

1) A: sets up iommu_fwspec under iommu_probe_device_lock.

2) B: Sets the dev->iommu_group under iommu_probe_device_lock. Domain
setup is deferred.

3) A: Returns with out allocating the default domain, as
dev->iommu_group is set, whose checks are also made under the same
'iommu_probe_device_lock'. __This miss setting of the valid dev->dma_ops__.

4) B: Sets up the group->default_domain under group->mutex.

5) A: iommu_device_use_default_domain(): Relies on this
group->default_domain, under the same mutex, to decide if need to go for
replay, which is skipped. This is skipping the setting up of valid
dma_ops and that's an issue.

But I don't think that the same issue exists on 6.13 because of your
patch, b67483b3c44e ("iommu/dma: Centralise iommu_setup_dma_ops()").
bus_iommu_probe():
     list_for_each_entry_safe(group, next, &group_list, entry) {
		mutex_lock(&group->mutex);
		for_each_group_device(group, gdev)
			iommu_setup_dma_ops(gdev->dev);
		mutex_unlock(&group->mutex);
     }

This makes the step4 above force to use the valid dma_iommu api, thus I
see no issue when there is no probe deferral.

So, I think we are good with this patch on 6.13.

Now coming back to 6.6 LTS, any ideas you have here, please?

>  	if (group->owner_cnt) {
>  		if (group->domain != group->default_domain || group->owner ||
>  		    !xa_empty(&group->pasid_array)) {


Thanks,
Charan

