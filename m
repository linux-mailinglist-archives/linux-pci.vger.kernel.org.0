Return-Path: <linux-pci+bounces-34763-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82148B36DF7
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 17:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D4BC5E1D0B
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 15:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A927B2D061C;
	Tue, 26 Aug 2025 15:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X4P3LLgH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279AA2C1788
	for <linux-pci@vger.kernel.org>; Tue, 26 Aug 2025 15:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222745; cv=none; b=tpPhaAFdOCk5zii/Yrh7agjrvJStMZ/TOR86pF8tnABfMjchPfCsgOKl9zkGiBfCjip+SW6fA8XM68FDo1mV5a5cfapcBzRDYJHVm1QHml64RYu/1kHxeNFq5yDuoRWwdghshl9DrDLPMMGSNjjnj8BBRsTdoms8qvYMKaAJQbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222745; c=relaxed/simple;
	bh=bkCkv19S9wHdnx0Kc3+tOj9A6SmyMAB9oyi/16jxTxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q+k0RFL0sDhodG9t8VfTWhuLYqxpyQ5aDMLjywo70KrxRP+B6WQWtycaW4OwTr7s35wPxJoMtezv1bKKoPkaGh9zZ5jAq3xQRsF2/F3dwPtbJqs92Ju9qkPslrSpGf3rhN0O15zFf2LhENt6iGG5zewy5dsjfgL5QZ6OXZkj+aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X4P3LLgH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q8hkUY019067
	for <linux-pci@vger.kernel.org>; Tue, 26 Aug 2025 15:39:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1//9ar4mn96BTeRcegh7QawnDMTKdyK81gfdwaa5TQA=; b=X4P3LLgHNPk2C2Jd
	5x2qMx8myzFcDvd3GsgCO3pcGV7w/koG/tWWh8qqUqFLDyP4Xd3ZwtdBIaPmaidi
	CONaiwJ1SXb0I/hfrCPY5IUnND3ndfEJ4BbY0/s0gcu3Pdjj53rWqbLM3QetSuDg
	+PTAZVmBdEg58qEPG1qHl+l5GbRyM65DPxZrLo0x7Vj8RHPm2B+DsNnNOpj+WWAL
	nssxfJamSDEvzBJMGG6JfRcIIZ1IbW5tIrNFPT4mVAaU9PFInlQq3qkxyP06VT9X
	WRWT8Y+vIIHPMy4g2iPQf6Erh9HUUZCeuJu0VqcU4h0OTCckdFf9SAEIApRkXmu1
	OkHQIA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q615hajf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 26 Aug 2025 15:39:03 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-771e43782aaso2220605b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 26 Aug 2025 08:39:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222741; x=1756827541;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1//9ar4mn96BTeRcegh7QawnDMTKdyK81gfdwaa5TQA=;
        b=EdJTMrG7vyP1ZZ/KUI+8qiHB3ucHSUpfS0RBmDQPKdlJJ9iKaATvd21ID8Atk/Ye/y
         yn2uzZ3zZi3dD8CusR3CH0t1H180CHPicRx2TqkGU9w9GSryrTkQmuR4B+QHoaABFC+9
         Wb9GYvBpnmPrVTRkbDeLlxRPUqK3I3mqFsF+JGHFgr/4EKoy3kMuCswxiEgt0m/3/34m
         RQk74Yezc/SjlO41IsLtFRFSKokYfwE5LY+hY15Ra8yLIvFB3+gzSse9+MUS/ZtWg760
         knrKwESrv5DuY2K1mZIUE/VCBsdcQR9bhmQxESn0KQtnE4bHw8IJhlZL51jYMH+SDY7E
         cA6g==
X-Gm-Message-State: AOJu0Yy2g5EIlMhtxYKDC/I007xnQDq+Va0dZnD0UP88+RXRNys9y9/Z
	ErJCs69mznWo3DQG73gnsNShUO40v0e7ENFax+xv8hKMAxUiLskNkiw+OoiUTCauUBJwu/LxwOF
	3vM7XzfWOPCZgxUsJZbeNi9C1ZvmRXGw6N8UwQ0DayBoYzE6910FnGrdZnEBuxJfXTrxLa0Q=
X-Gm-Gg: ASbGncuIXLKpeZIoRn90ZHkCYf8Lu8iIq17Smlym05IPT6tBtpaqMbkLQURMe2FlmTa
	nYt5gno+DNS/1iB/bgogbWkQ/y1oU9J1HZSEqdxfoR9j3wmJPhhun4X+15wPRyzBA1SkMTWaw7y
	Q5cX7t9cyoaeAu4+jClQTtQW8skqlIydzjMcul1Tx8X97ECCCpPwkAUOPhtb0abow5sG682hHLn
	PKSVccJ/TKf/YkOp+sIK8KZDSgENVulvQ4HLBL3fVhSTXVb+3pkUe3+fgVZhD4S127Mu37wT7kh
	mPDJZb7Ou9uTPlG6z2AQRUjoZazS1kHo+UoJF0U7K4DOrKBdY7jzKl4Mh8EmKn1L7Acsu1wTJgO
	3PWPFzb71d5dEz3+r9Uk=
X-Received: by 2002:a05:6a20:3d12:b0:243:7cff:6251 with SMTP id adf61e73a8af0-2437cff65ccmr9026056637.26.1756222741341;
        Tue, 26 Aug 2025 08:39:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEL0KSG01yve3r3qzqiKchOxZo/p+aKsbAcVtQItkNd7vJ4cyfMgvyDRPq539k48rr7cMjN6Q==
X-Received: by 2002:a05:6a20:3d12:b0:243:7cff:6251 with SMTP id adf61e73a8af0-2437cff65ccmr9026009637.26.1756222740816;
        Tue, 26 Aug 2025 08:39:00 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7703ffae973sm10724369b3a.12.2025.08.26.08.38.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 08:39:00 -0700 (PDT)
Message-ID: <2fab10a7-8758-4a5c-95ff-2bb9a6dea6bf@oss.qualcomm.com>
Date: Tue, 26 Aug 2025 08:38:57 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] wifi: ath12k: Use
 pci_{enable/disable}_link_state() APIs to enable/disable ASPM states
To: manivannan.sadhasivam@oss.qualcomm.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam
 <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, ath11k@lists.infradead.org,
        ath10k@lists.infradead.org,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>
References: <20250825-ath-aspm-fix-v2-0-61b2f2db7d89@oss.qualcomm.com>
 <20250825-ath-aspm-fix-v2-6-61b2f2db7d89@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250825-ath-aspm-fix-v2-6-61b2f2db7d89@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzNCBTYWx0ZWRfXx7r4NUaaHZVO
 7f2jjhfOsHLVfTXVoayuNWXPIfIM4RBZHt+fEfyfjpZJUvtGwwXRVGMtCoDy2Ys1EiQr8UWp8hu
 KVRWWQ7qyKhXh0muGM86ssHPS7dchaw30O6Bj78Sbcc8KhdnCvbbGHCK8VDg8oCtMHczaGsV9na
 PYwTjAyIbZ162Y7KOYlA5REZLhQ2wGxRVhom6AXYxhku72c5KbEoNwDo4AVvZhFqyNjzB8o758Z
 FRW2AMNYHme68sobmUTxNFQ6FxRUcCYfPvRk1OYkv0V9L6Vq0K2RDi18aVVGUy+8z8Y5qJY3K/A
 zfnv2uJjwvNpcn+n+HE0nARjV2064h7ntdQr8MoLvTBnhafmcrf3GIYIuQWbS57n710QQ2Cz4uy
 2KqYuheQ
X-Proofpoint-GUID: 9asOyPN0r3ubQWgptAzkEuRt16v1vSc5
X-Authority-Analysis: v=2.4 cv=K+AiHzWI c=1 sm=1 tr=0 ts=68add517 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=gMjHX16tY-KYiP7tJ_8A:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: 9asOyPN0r3ubQWgptAzkEuRt16v1vSc5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230034

On 8/25/2025 10:44 AM, Manivannan Sadhasivam via B4 Relay wrote:
> --- a/drivers/net/wireless/ath/ath12k/Kconfig
> +++ b/drivers/net/wireless/ath/ath12k/Kconfig
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: BSD-3-Clause-Clear
>  config ATH12K
>  	tristate "Qualcomm Technologies Wi-Fi 7 support (ath12k)"
> -	depends on MAC80211 && HAS_DMA && PCI
> +	depends on MAC80211 && HAS_DMA && PCI && PCIEASPM

As you point out in patch 1/8, PCIEASPM is protected by EXPERT.

Won't this prevent the driver from being built (or even showing up in
menuconfig) if EXPERT is not enabled?

Should we consider having a separate CONFIG item that is used to protect just
the PCI ASPM interfaces? And then we could split out the ath12k_pci_aspm
functions into a separate file that is conditionally built based upon that
config item?

Or am I too paranoid since everyone enables EXPERT?

/jeff

