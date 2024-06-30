Return-Path: <linux-pci+bounces-9487-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B57F91D429
	for <lists+linux-pci@lfdr.de>; Sun, 30 Jun 2024 23:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D88328140E
	for <lists+linux-pci@lfdr.de>; Sun, 30 Jun 2024 21:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39554D8C0;
	Sun, 30 Jun 2024 21:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RBsz+IcG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF11547F45;
	Sun, 30 Jun 2024 21:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719783000; cv=none; b=QMEOQtIK3G9BIuibaB3tm8G1Dr0tAqTAvAfhfQsw1rJS6RArnBJZVhGihafZbeE0t544Wu2KoqhZhxpVKOMqiD/H3UW63wb+Cer+NC91Luy+p4Vm77yTDyRzE0V3OakoIdUdNtqN+cXBqyS1g8YPtRtiXx5x05ZMA/snwqw26s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719783000; c=relaxed/simple;
	bh=2cdIpYv3Qek2Qx6bvpfvorzTCDILPqUdOm4V17j/qeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=E9X+whczNFN6FZLjlWychNh1Fg3KbCAMt0nOwGIjB4DJYZEsYWoFOzxejbZLPoAprsxQuWQvR4ELKYPXX2EFdkXbxPFZOLbkAu8s11bQdIuD06SaIzlB9YsW+LsNUeskK8kWuqotlNT6dxoTRuaEspM0JysfOU08D3go0zEEFrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RBsz+IcG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45ULTBBd004635;
	Sun, 30 Jun 2024 21:29:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	y3GpGeYTN17W9oZGhEbcWZavV5/VT4oeTCFhAefroiw=; b=RBsz+IcG/hzMYogz
	OJVPHSqF+8Mp0U6/vLnmopEP5vMsbz6kuNhX02BQ7I6R3C7T+fZ4iUg65J4dT7Uq
	9pM7rPMFb3R2ob6MBG9hLs8vPGYdBJzi74d8O+79RrRx5WtedgORQT9kyNMBBBGt
	/Hq8lSZ9WTNWKhMeQMoIbi43wLMSX6WaWBVBiuxTcCFO4C4z+y5fLEV3ln3LYMLC
	rEA9DKL+cdBi7zHOvOPohGA1RmsRQf0giijj7kykCSz9TDws8f5SE2rszgs2WeG+
	7gz13rW++BFpdWvc4Ho6uWSRl6cXKYa64pOJIeJMaZxaK3Eqbk9IETG8gHUboJtP
	XCpQzQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 402b1f2cnf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 30 Jun 2024 21:29:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45ULTA8G002731
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 30 Jun 2024 21:29:10 GMT
Received: from [10.81.24.74] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 30 Jun
 2024 14:29:09 -0700
Message-ID: <60c59775-ebce-4dbc-817d-2456e1c64f75@quicinc.com>
Date: Sun, 30 Jun 2024 14:29:08 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/18] spdm: Introduce library to authenticate devices
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
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <bbbea6e1b7d27463243a0fcb871ad2953312fe3a.1719771133.git.lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: olZGwKd3O7cMGZLV6I_BgaZ8xrApQgm7
X-Proofpoint-GUID: olZGwKd3O7cMGZLV6I_BgaZ8xrApQgm7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-30_16,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 malwarescore=0 adultscore=0 clxscore=1011 mlxscore=0
 impostorscore=0 mlxlogscore=732 suspectscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406300171

On 6/30/24 12:42, Lukas Wunner wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> The Security Protocol and Data Model (SPDM) allows for device
> authentication, measurement, key exchange and encrypted sessions.
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
> +EXPORT_SYMBOL_GPL(spdm_destroy);
> +
> +MODULE_LICENSE("GPL");

missing MODULE_DESCRIPTION()
this will generate a warning when built as a module with make W=1


