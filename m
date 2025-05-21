Return-Path: <linux-pci+bounces-28219-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 004BEABF87E
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 16:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CA167B45FD
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 14:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2493D229B18;
	Wed, 21 May 2025 14:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pFk1IfYN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB7722126A;
	Wed, 21 May 2025 14:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747839174; cv=none; b=DbYCadLu6d76HP0BDn1lMv3bjCYzjLyWOvaw6tEDJs0oB9tEd5xEL039P/ZTOVcd1kQIhaqJXYHiWU8aRkidiqJqD2QeTjiZ4P/uNpsjC16NQAIPMoXv10/9GsIyItDxf/cxrVePhvP1Sm0AqTIkbU2jcXAfKafUAhDQO7SKkA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747839174; c=relaxed/simple;
	bh=WLDWeiD6ADAKu53SIAClrIwXxM68N8o3/ZFh0r242jU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Xwc2iEgHcbjFqLSn6E09Vcb5iK1v2iYYX3tPxm6an4coceiHV/bsuNpyFwnzMVcklPqfmS7ir7xt/Kg85hCWPt4CKa6Nx6ltSrvkQVJlH1KBvc99jEDgg/kxKdszQtGWxS1SOPSTsVL2ja5Tbq4mwpz99WIvO3oUiTeAHUICMaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pFk1IfYN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L9XMXe024816;
	Wed, 21 May 2025 14:52:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SdsgstMIdU3g6wwrbjZnLWpwKvICMJd1ZoQalcYim8s=; b=pFk1IfYNBTOt7iUr
	PRqbzChNk4400R51z7u3OyjLRVTjlhSnRbySXZTk2U6DFGOuyxzj5vCqDqyv4/h7
	pKY4Mvzh2icgfeaB+5aq9LT2yqtTMrGMbjsPO6ntL6u+QnxDzMeEBo/nZLEDsx7Q
	DDBdApL1wL1DcO+l6/WgF7RnkCDLQ74lEm0g9GD2FXb1A1dRQi2Xp2wtprIy7Sa1
	9gYoJTiyunOlSaxhxzjghhN4V+2jVxxSYjYJ6ydfM/4Cl16Cr8ztiw2F7/blBEJA
	6CAErPaDPMAbL+MrRkJnxVSS/GTJwTn+uidXLPPDHIaxaeZu9KHWtDfjLZmu86bx
	Tx6Bcg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf4u9m8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 14:52:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54LEqWYo007457
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 14:52:32 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 21 May
 2025 07:52:30 -0700
Message-ID: <aa45ff83-bc8f-4cef-a82c-9a868396d19d@quicinc.com>
Date: Wed, 21 May 2025 08:52:29 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/11] bus: mhi: host: Add support to read MHI
 capabilities
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        "Bjorn
 Helgaas" <bhelgaas@google.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Johannes Berg
	<johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        "Bartosz
 Golaszewski" <brgl@bgdev.pl>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <mhi@lists.linux.dev>,
        <linux-wireless@vger.kernel.org>, <ath11k@lists.infradead.org>,
        <qiang.yu@oss.qualcomm.com>, <quic_vbadigan@quicinc.com>,
        <quic_vpernami@quicinc.com>, <quic_mrana@quicinc.com>,
        Jeff Johnson
	<jeff.johnson@oss.qualcomm.com>
References: <20250519-mhi_bw_up-v3-0-3acd4a17bbb5@oss.qualcomm.com>
 <20250519-mhi_bw_up-v3-7-3acd4a17bbb5@oss.qualcomm.com>
Content-Language: en-US
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20250519-mhi_bw_up-v3-7-3acd4a17bbb5@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fxrs8dZ9kRawyfjjg5wdyvwEH6rkQL3M
X-Proofpoint-ORIG-GUID: fxrs8dZ9kRawyfjjg5wdyvwEH6rkQL3M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDE0NCBTYWx0ZWRfX9SjuTT+ee+g+
 /GASVjVY2ENXk1MSVLLkTtSk5izXs6pLdPGNjQaczlIX2BA5X88Rcx70K7Q8fuPfsrEy2YFW1Og
 64EFiwReGlkcMYqO2FPvSIh+M+7AnrAbzQkzwhN5xvemAYSCh4FtMLo1AtZSQ8FefWmWgKRd6ir
 SgZBeLaHUh1y1cR3VMtcdyLDkrOKcS7n0066kRJ2BEkJSn1D8MKCxKj6pMJiYx+ZOiM1RZv+HRE
 Qx15ksBQB6qG9uvbOD7cY0uLZEEKIz+KMuNddUjUQOwUd4jKOkSFev4zYIvsl4AOyzzIiyWOaX7
 cPdhNidRI91ikTpzfM3UozbwX5k1on9FXnByw1yPHBVfy6ZpcqLpdMX4foffmYoA6w1rRfIi6YL
 JwwZfa+nLvwKZqOIsk30y3xhjGNVgPtQDS7iB4NzESbMmgYwn8gXndQriUplyikd3XHI0adD
X-Authority-Analysis: v=2.4 cv=R7UDGcRX c=1 sm=1 tr=0 ts=682de8b1 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=3N43v1ldxO06oT20SBYA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_04,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1011 mlxlogscore=999 priorityscore=1501 spamscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 impostorscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505210144

On 5/19/2025 3:42 AM, Krishna Chaitanya Chundru wrote:
> From: Vivek Pernamitta <quic_vpernami@quicinc.com>
> 
> As per MHI spec v1.2,sec 6.6, MHI has capability registers which are
> located after the ERDB array. The location of this group of registers is
> indicated by the MISCOFF register. Each capability has a capability ID to
> determine which functionality is supported and each capability will point
> to the next capability supported.
> 
> Add a basic function to read those capabilities offsets.
> 
> Signed-off-by: Vivek Pernamitta <quic_vpernami@quicinc.com>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>   drivers/bus/mhi/common.h    |  4 ++++
>   drivers/bus/mhi/host/init.c | 29 +++++++++++++++++++++++++++++
>   2 files changed, 33 insertions(+)
> 
> diff --git a/drivers/bus/mhi/common.h b/drivers/bus/mhi/common.h
> index dda340aaed95a5573a2ec776ca712e11a1ed0b52..eedac801b80021e44f7c65d33cd50760e06c02f2 100644
> --- a/drivers/bus/mhi/common.h
> +++ b/drivers/bus/mhi/common.h
> @@ -16,6 +16,7 @@
>   #define MHICFG				0x10
>   #define CHDBOFF				0x18
>   #define ERDBOFF				0x20
> +#define MISCOFF				0x24
>   #define BHIOFF				0x28
>   #define BHIEOFF				0x2c
>   #define DEBUGOFF			0x30
> @@ -113,6 +114,9 @@
>   #define MHISTATUS_MHISTATE_MASK		GENMASK(15, 8)
>   #define MHISTATUS_SYSERR_MASK		BIT(2)
>   #define MHISTATUS_READY_MASK		BIT(0)
> +#define MISC_CAP_MASK			GENMASK(31, 0)
> +#define CAP_CAPID_MASK			GENMASK(31, 24)
> +#define CAP_NEXT_CAP_MASK		GENMASK(23, 12)
>   
>   /* Command Ring Element macros */
>   /* No operation command */
> diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
> index 13e7a55f54ff45b83b3f18b97e2cdd83d4836fe3..a7137a040bdce1c58c98fe9c2340aae4cc4387d1 100644
> --- a/drivers/bus/mhi/host/init.c
> +++ b/drivers/bus/mhi/host/init.c
> @@ -467,6 +467,35 @@ int mhi_init_dev_ctxt(struct mhi_controller *mhi_cntrl)
>   	return ret;
>   }
>   
> +static int mhi_find_capability(struct mhi_controller *mhi_cntrl, u32 capability, u32 *offset)
> +{
> +	u32 val, cur_cap, next_offset;
> +	int ret;
> +
> +	/* Get the 1st supported capability offset */

"first"?  Does not seem like you are short on space here.

> +	ret = mhi_read_reg_field(mhi_cntrl, mhi_cntrl->regs, MISCOFF,
> +				 MISC_CAP_MASK, offset);

This fits on one line.

> +	if (ret)
> +		return ret;

Blank line here would be nice.

> +	do {
> +		if (*offset >= mhi_cntrl->reg_len)
> +			return -ENXIO;
> +
> +		ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->regs, *offset, &val);
> +		if (ret)
> +			return ret;


There is no sanity checking we can do on val?  We've had plenty of 
issues blindly trusting the device.  I would like to avoid having more.

Also looks like if we find the capability we are looking for, we return 
the offset without validating it.

> +
> +		cur_cap = FIELD_GET(CAP_CAPID_MASK, val);
> +		next_offset = FIELD_GET(CAP_NEXT_CAP_MASK, val);
> +		if (cur_cap == capability)
> +			return 0;
> +
> +		*offset = next_offset;
> +	} while (next_offset);
> +
> +	return -ENXIO;
> +}
> +
>   int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
>   {
>   	u32 val;
> 


