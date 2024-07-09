Return-Path: <linux-pci+bounces-10005-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5C892BDF5
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 17:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13802B21769
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 15:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C6719D09E;
	Tue,  9 Jul 2024 15:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IpIVAZdU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15B419D89B;
	Tue,  9 Jul 2024 15:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720537405; cv=none; b=SKRjN6ucFv5kqt0E1D9IOmSQBjHUbMoAYG6oOC2ORoGNiQZuPWpvu73kOKX9SoVOXl9GQyR98n//Ty12fPQnoSeLr2Zn0yeAH3f1VbT6/QUoSbBoLQwt1HrJLlh+qGbxgmacSd5oGzmxmzH6pxkyS9QoxW5y+INwj8oyeODVWOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720537405; c=relaxed/simple;
	bh=Pve8kD2qR5k9am//RgaYXCPw5RIktwMh8PvUr5OnbUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RBYs8Lx7rRTeY3W7K6CKsUxR2LAIbGxeN3MEMvMy69UL8gUCJ5550Nwo315vK8/hVd4V497Hs4cy81PrNtIgT8h1RB/TyEBPLHaWhAivJx2elLkUagCsFpXOol95yd4C4X2rYDz1H9bEmvgrXHb1W1Cui5hvCxVFbpJFqCqxCVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IpIVAZdU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469AX5Bj021735;
	Tue, 9 Jul 2024 15:00:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vrRha6v1MS8bhWVcMku5sIvVckGeI7S6pxyAygH9t40=; b=IpIVAZdU289FVNpJ
	tZYXIkp4i6652FCJtThP3Q+1S9qxa49qSkbCGQRBUJVKi8Qtuvqxud1xlSDKIpKd
	NwZ9fyFD0GhC8rmR/7YMm6JYPOlVqkuwkCwTv7zq5WZnwZuXdNSNH9Nvs+pPvYzS
	fry2xreqboUesoD9BsQ4GrL6F1zxSgGLLG/DJz1cQF/KLKigFdrHgGMwPGER626n
	iztoZr/HJpJs7aZxncaluxbjHKDzjaaqx/gPXehk++PqnOw2pqbPvSFFc+hLc1dy
	Rc9mqTpX3fmUklcqH5f9i1FH0+LPQIr+0iQXQjOaLqftU7blP9Sa1bfxD4US/M8H
	nZTOpg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406wgwprf7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 15:00:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 469F0toM025538
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jul 2024 15:00:55 GMT
Received: from [10.81.24.74] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 9 Jul 2024
 08:00:54 -0700
Message-ID: <647515b7-e5a2-46d8-9c03-a2b68c434070@quicinc.com>
Date: Tue, 9 Jul 2024 08:00:54 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/18] spdm: Introduce library to authenticate devices
Content-Language: en-US
To: Lukas Wunner <lukas@wunner.de>,
        Jonathan Cameron
	<Jonathan.Cameron@huawei.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        David
 Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        David Woodhouse
	<dwmw2@infradead.org>,
        James Bottomley
	<James.Bottomley@HansenPartnership.com>,
        <linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-coco@lists.linux.dev>, <keyrings@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>
CC: <linuxarm@huawei.com>, David Box <david.e.box@intel.com>,
        Dan Williams
	<dan.j.williams@intel.com>,
        "Li, Ming" <ming4.li@intel.com>,
        Ilpo Jarvinen
	<ilpo.jarvinen@linux.intel.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        Wilfred Mallawa <wilfred.mallawa@wdc.com>,
        Damien Le Moal
	<dlemoal@kernel.org>,
        Alexey Kardashevskiy <aik@amd.com>,
        Dhaval Giani
	<dhaval.giani@amd.com>,
        Gobikrishna Dhanuskodi <gdhanuskodi@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>, Peter Gonda <pgonda@google.com>,
        Jerome
 Glisse <jglisse@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Alexander Graf <graf@amazon.com>, Samuel Ortiz <sameo@rivosinc.com>,
        Eric
 Biggers <ebiggers@google.com>,
        Stefan Berger <stefanb@linux.ibm.com>
References: <cover.1719771133.git.lukas@wunner.de>
 <bbbea6e1b7d27463243a0fcb871ad2953312fe3a.1719771133.git.lukas@wunner.de>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <bbbea6e1b7d27463243a0fcb871ad2953312fe3a.1719771133.git.lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yjb8rUAeZdBFm13IhaXy-1T20LJa1kbO
X-Proofpoint-ORIG-GUID: yjb8rUAeZdBFm13IhaXy-1T20LJa1kbO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_04,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=787 mlxscore=0
 adultscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090098

On 6/30/24 12:42, Lukas Wunner wrote:
...
> diff --git a/lib/spdm/core.c b/lib/spdm/core.c
> new file mode 100644
> index 000000000000..f06402f6d127
> --- /dev/null
> +++ b/lib/spdm/core.c
> @@ -0,0 +1,425 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * DMTF Security Protocol and Data Model (SPDM)
> + * https://www.dmtf.org/dsp/DSP0274
> + *
> + * Core routines for message exchange, message transcript,
> + * signature verification and session state lifecycle
> + *
> + * Copyright (C) 2021-22 Huawei
> + *     Jonathan Cameron <Jonathan.Cameron@huawei.com>
> + *
> + * Copyright (C) 2022-24 Intel Corporation
> + */
...
> +
> +MODULE_LICENSE("GPL");

This is missing a MODULE_DESCRIPTION().

Building a module without a MODULE_DESCRIPTION() will result in a 
warning when building with make W=1.

