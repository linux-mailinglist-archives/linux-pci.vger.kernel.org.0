Return-Path: <linux-pci+bounces-23694-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8706CA6062B
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 00:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDEE918991FC
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 23:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA8E1F4630;
	Thu, 13 Mar 2025 23:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dwGqZGNB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AB51F560E
	for <linux-pci@vger.kernel.org>; Thu, 13 Mar 2025 23:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741909731; cv=none; b=gTt5iw+ILHpV8sWB3kFYThMhgmJSUo8g6Dj+hcOXM0+Ua459Ea1/n/2Kjr7910Z8JJpzrKi1o7BodtM49356Rxwnm0pKzyjTB3ik7mmSeaCgpDv2SrNz8Hrmuy0FX8Z2eo37E9mMMrrRkeof6Szvn5+Bv+zIzU2KCitZnRpG+Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741909731; c=relaxed/simple;
	bh=0lu8oU1tyqYj57FgsKOmobIAzRwBp7FW+RRAsiYBpss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VWSVaoB1H0KhyUI2Opbxdsu0JeCpsdJkeJhVqJsCT/zTV6EAa3VE0fIQSGcPE3cuUtYV9DezUF0v8/mZ09adxPS+dERc67jFVSmJtTOI/ir+Wbllcchsd3sMViz2cnnUa9bFSqtQn1z5NmK3WRiwj8EFD94T2jBs4tHc0PhWJBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dwGqZGNB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DLVGNi018481
	for <linux-pci@vger.kernel.org>; Thu, 13 Mar 2025 23:48:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Zkd/Jggqn86Uyh/5JzZQRlmlyi5xVymwBZ1NTqzN0CE=; b=dwGqZGNB2o/W1vhD
	lMvadEKnxYanIo9kqSUDcDRjzYmf0TZceWIIFAN5IMf9GLnu0vKfBl3PmMir/KAk
	WlP/r2ERc2k4tD8cZEiRtt8U6GhiW/3HsZAfKDfDxREL6QCLQJZumrxiCZoUrobj
	pPSJMo/CUvLm3P7FqRGHPp/lUzAaaD0iIqgbxHEUd4/4JGcTN2GOIwGJM+Pw/Y24
	/IjsOyMx6/5dwvtNvPO93+76BHj4j8w1KpQldr2S6nNQXj5cvMNNm1fjqL3bhgOJ
	7VUI9ZyZbtkc0yR2cfQX6LW2QF7I3TlWpXNfCgJDt7E7kXr0g2A23DXmkNyrdAsY
	oWs4Hg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2nyh8j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 13 Mar 2025 23:48:48 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-22410053005so40756395ad.1
        for <linux-pci@vger.kernel.org>; Thu, 13 Mar 2025 16:48:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741909727; x=1742514527;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zkd/Jggqn86Uyh/5JzZQRlmlyi5xVymwBZ1NTqzN0CE=;
        b=M5PLSGPbuf2GPterqhf+bZtqlw/t2ERNvkjiht0E4rQreZjZdBFxalF8J5ISaf7MYi
         2sKGImjDZKIUqnD/UOgVeWXnN0pSja9GiXmI7tog1C5vS7tiMjb7Thwiz4ol0AGVlLc/
         U88fS5vyVkt8Qh/NDYqbVOrHgQSFj/3mUDjbwTKlGsG6bLSBii+FiYavE3GcPeZ2LP9z
         595z3YH+hLWx7VFps3xlHeDd5s8bAdDq+R6KVtV3C7Mla5EPH/NRPA4gB3tRdIPlydA/
         Q5na0B1d5xHPYlP32MKH5RlJpBTUtVK6mxjMHG2+yU955S1/6AqX5T8z7BNkz638EYgw
         5cKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOWEarjv6eVw5w2lhEtv4/fGRQuRpvjibhTsQBbi9ce31OJJ19szx/szqV0hPkX+20/ZKGtLEhV+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YypInDOnvZhH4Y3M3NpfRTlZGqEvZBXGRZ6pj5i7j6EZ4c9YHhE
	fFxUq7bzu60w6M0TcVu70jzM6BiVCIqCmaTuOqUyihy6Fh81mJs8Nrlt3sMcSJZXIkXS6+GEAzj
	sqnIzboSPUuT0A+qxqdjE3AwxIfHaaCeCPn97TfzowRxIweKk7ZK7TTVp53c=
X-Gm-Gg: ASbGnctjszMALQb8hXVpY9B0ByFFb9j41xrEBo/F659mj+3DMIpUjzIBbb/0X6d2uxi
	J1fOADdJMSRe/Si8Ou3BGID82bS6y0pKRqv/jtuuU45X/c4/OoW1p83NME8E2NpBqxX/olSRs9+
	mshm0fQYZ5V3gc3es+YoPLgkXzVaJxvYTi6rt846X6BO/Rvz/5i2mdnC4Z+GGVZw76ku4LPM3jI
	Vu4cIqOp31fp57zXxYT8tiLYbaFdpy9NohQziKBxzvHrgnscsL1LHSOXmj7e6IBV8PtML0m33so
	1XCWdGbMowxQx7/JyDVxrETLlkPGUc+cp4Vvo2ow2zboIq+OJjBE1cWo2kCqBCiOO+khjxlNJSJ
	TDGJAmg0F
X-Received: by 2002:a17:902:ecc5:b0:223:f7ec:f834 with SMTP id d9443c01a7336-225e0a840camr4626085ad.31.1741909727071;
        Thu, 13 Mar 2025 16:48:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcphUQ8UCrGDx8Md02DmjuseFiFZVhQ2qPU88RhdsaxrxfnuW+c53+Y3w5UiXV4O9t74jPcQ==
X-Received: by 2002:a17:902:ecc5:b0:223:f7ec:f834 with SMTP id d9443c01a7336-225e0a840camr4625785ad.31.1741909726725;
        Thu, 13 Mar 2025 16:48:46 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68887fcsm19356845ad.39.2025.03.13.16.48.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 16:48:46 -0700 (PDT)
Message-ID: <2654f986-eb8b-430d-b962-8e77d9e11826@oss.qualcomm.com>
Date: Thu, 13 Mar 2025 16:48:44 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/10] PCI: Add function to convert lnkctl2speed to
 pci_bus_speed
To: Bjorn Helgaas <helgaas@kernel.org>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        mhi@lists.linux.dev, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, quic_pyarlaga@quicinc.com,
        quic_vbadigan@quicinc.com, quic_vpernami@quicinc.com,
        quic_mrana@quicinc.com
References: <20250313171637.GA739165@bhelgaas>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250313171637.GA739165@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: xghPoOczRNQ8XgRpl79Egv5NvWKtWUMd
X-Authority-Analysis: v=2.4 cv=Q4XS452a c=1 sm=1 tr=0 ts=67d36ee0 cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=e70TP3dOR9hTogukJ0528Q==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=wUlHnouiQKlN4MMnk_oA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: xghPoOczRNQ8XgRpl79Egv5NvWKtWUMd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_10,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=770 adultscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503130181

On 3/13/2025 10:16 AM, Bjorn Helgaas wrote:
> On Thu, Mar 13, 2025 at 05:10:16PM +0530, Krishna Chaitanya Chundru wrote:
>> + * @speed: LNKCAP2 SLS value
>> + *
>> + * Returns pci_bus_speed
> 
> Not sure how strict kernel-doc is about this, but I've been told
> it wants "Return:" with a colon here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/doc-guide/kernel-doc.rst?id=v6.13#n142

Yes, patchwork is flagging kernel-doc issues in this series.
However, there are numerous pre-existing kdoc issues in the MHI and PCI files
being modified in this series. Just look at the patches with errors being
flagged in patchwork (including build errors with 06/10):

https://patchwork.kernel.org/project/linux-wireless/list/?series=943497


