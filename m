Return-Path: <linux-pci+bounces-27273-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2D6AAC0FB
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 12:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A19F1C26EC6
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 10:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0927F2750EB;
	Tue,  6 May 2025 10:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hj8ZNgiB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6684817B4EC
	for <linux-pci@vger.kernel.org>; Tue,  6 May 2025 10:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746526279; cv=none; b=CuMGlHzcIRc23Sa/t0DDHgmDHzGmHKBTNhjXUeSRKMmsKknfdhjeICqlgwDJ1PP9LlHrDX9RYoL2yGYCdCA9Jb+hkfmk6JXFl4haSehemtjn+UnV1vu3C5MY+PjhRQL/6V0QgkYBsnocCd7LwwMCw8U2heqAZu2UD041h9KLTJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746526279; c=relaxed/simple;
	bh=s4kCWQW0ZTSUK3D9Sel80Aj9ycpFDOTL8zaBmcgdIy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V4uSXl9NTtM6F4PhH00QLcdaMDPgEYq2o+OZo7ugunZdKS90fVw3dCNq71bd6bS7B2331pxMcX0/9CloabM85tA5ZdIc5y6T/sC8em2h4RKo8v5e34NEFCZSt44HK6WjDLJogTstE/dwdLSJaK9vYIAMLz9sFFNA9nJnqtP4iK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hj8ZNgiB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5468jvrS014073
	for <linux-pci@vger.kernel.org>; Tue, 6 May 2025 10:11:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R357w52RG43euLotJZLwo3ITJzb0YVqeRsR7WnNZQZA=; b=Hj8ZNgiBzlrftr5B
	F+oKgx4tCDOcM1tQqPIvZHCiqEr15MbOTxiwMhHU82RWMNigam7Teb40Eu2D/asU
	PKPDwUmjbqAoFMZo0rD4VLv/3iFyruY5KtalAqf3r7S7w5IwRF2Jvh2aemELD2ib
	3KOCuuER0o6U6reqHQo6PkohBdQEbNCg8znnLWCPEJF/Fgsf1d0GWY84zdpYvfyJ
	YIdu0moxqFuh1W1jq9f0RfGZj/Yczb4xc7mCSo62iDen3d6dVBlfAZ2rpoJN88Va
	LPqTCk0Qf3+ppW/iNn2gQIWvSG0uvwAiJBlFL5rviN+cOcsijOEWGKdZd3M6nOW0
	7Xnzhg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46f5u41uwq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 06 May 2025 10:11:15 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-22e40e747a3so3664655ad.0
        for <linux-pci@vger.kernel.org>; Tue, 06 May 2025 03:11:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746526274; x=1747131074;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R357w52RG43euLotJZLwo3ITJzb0YVqeRsR7WnNZQZA=;
        b=PlpajkoRhJqoOaykPvvUIlCiYy+5tGA9ZBD0vQ+9ofXI6T65DbQRrEIk4vTCqr0u+g
         bc5NdQnrpCIPaq93C2hCy5CKTq77OtWNeNIDg+vpt6AHUWin18HbATx5end/tNipfo/X
         vR7ZHngGJAhKtiLKYBIfP28+JQ7tnquUuK2yyrd8OEsncRB1HRDOHu0dMgdqrXAdXeUt
         CXMv8R7gesvbBwH33mLDav+H56s+XGipcMRYy70asSG3mFB5OQeQH3Ggfw8BFJQ360+f
         kW0GZxkmshNFC9xZaDO9gcE/S3wbR2NUVyiCs2/hvO2rFqkkXUiaZtbrLvyBDcLzD4r6
         bwWg==
X-Forwarded-Encrypted: i=1; AJvYcCWwTQUsV21fsq2FB9NwdgUIdGAi6pZRRme+1ZKYSKccH4ITY9aO8ezG/Q++pdqpAOa3tPj3CmjWDM8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8oS2WsL6REABKXVGvXY2pHtY90Ezzv1rhDn5hAVheyHrm1sJt
	AhWfuQeuk4n5ETuQGKvjmEDK8EytaTi7WAI00f69p3kbLiw+EFqYWfd+5VKyqOl4H7l5oQ4L/m7
	Ae+w6kwX1KmA0+L05VuznyvptDWnB1wsvyvmadNqJo24QG9O56rvp3YbFjQ8=
X-Gm-Gg: ASbGncuw26GlJNJe6tWoCbZ5GNw+frPmjdla9E4gCNOUxSQALNb7mnj3r8hGGrOHqGs
	NUaUBxEM5dn5h6Oizb9cjhOJxflHUgIY70dDajVR2RW+8C73t/oWClTg4tDhEJLoFnbZVr0jw9g
	4n84qPZLWEaK/HSmvxo7qU61ZZyvWOuL2bpq8tZ0wHqfystK9bZRlOT5NdzBkdTpbDWDu0xw4E3
	Zy7nTUlC/7DD0cC8dfodkhVRGUFiiirqI5T8a0gbqajMFZWfAKSPWy9yxu+VNNn6K8aBCgTO4oZ
	Mro4fD3tJlMekaexJ7FiXOquNLeTdkoGOAyfqTmmrg==
X-Received: by 2002:a17:902:f682:b0:216:410d:4c53 with SMTP id d9443c01a7336-22e1036be29mr230061325ad.41.1746526274370;
        Tue, 06 May 2025 03:11:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8U/guIu0vbzSPfeTmdl89koUVyuEsL/oTZLqYtIdxTjXuLx/PmEC/GmoUm6x6tbynQ691+Q==
X-Received: by 2002:a17:902:f682:b0:216:410d:4c53 with SMTP id d9443c01a7336-22e1036be29mr230061015ad.41.1746526273933;
        Tue, 06 May 2025 03:11:13 -0700 (PDT)
Received: from [10.218.37.122] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a3484bc23sm13457073a91.43.2025.05.06.03.11.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 03:11:13 -0700 (PDT)
Message-ID: <99da4243-3e55-3aa0-5657-5a5d2a4415cd@oss.qualcomm.com>
Date: Tue, 6 May 2025 15:41:07 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/4] PCI: qcom: Do not enumerate bus before endpoint
 devices are ready
Content-Language: en-US
To: Niklas Cassel <cassel@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>,
        Damien Le Moal <dlemoal@kernel.org>, Hans Zhang <18255117159@163.com>,
        Laszlo Fiat <laszlo.fiat@proton.me>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kwilczynski@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20250506073934.433176-6-cassel@kernel.org>
 <20250506073934.433176-8-cassel@kernel.org>
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20250506073934.433176-8-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KcfSsRYD c=1 sm=1 tr=0 ts=6819e043 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=S-OeyO6ZCgE5XVXCpeMA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: D_WQfTL1nlddQPud_fYVaF_Ft-lE8_sM
X-Proofpoint-ORIG-GUID: D_WQfTL1nlddQPud_fYVaF_Ft-lE8_sM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDA5NyBTYWx0ZWRfX3VLVM8SZ4bKj
 Jjg7neX0ZxWCqsm605RgrPNiDSa2o79B6ajTCcjvDM2QvC7s4VYb8oUwesk0GNZca77vH0qE54Z
 HSqIZC8kkDO1kxv5I2Plk8lYHXetrPuLs1mZJLRzzEtVZ9rB9wIAVamHksIW5OUk9GKI87wgEPA
 FnsBVXf9U453nTpVbOmrMfjg/MhmYu1GXCo00oH7atE2EH+nwtg9wQBvgOOBT5Otr7B+JmZ+2U8
 hPP47nhFvnePnGRP8SSDhkFgCAxgXck2oTLrjwR6iGr36NHIGRsGDEemhEfezDmM/Z6soPnGttE
 QaQ+zzgIqiPWZ4IdDr9DAEJSla3y/jP3d/YXQUouTmJ1jFRfPohTdPgdpJE7JaGCWPD+gfEsujW
 ZIVBrujvVCQ+AM+wnz4KPvzQmaTnAAthyHgDmNTpMbwTpza+9ZIHujq20FMWEufp3oPP4iyU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_04,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505060097



On 5/6/2025 1:09 PM, Niklas Cassel wrote:
> Commit 36971d6c5a9a ("PCI: qcom: Don't wait for link if we can detect Link
> Up") changed so that we no longer call dw_pcie_wait_for_link(), and instead
> enumerate the bus when receiving a Link Up IRQ.
> 
> Before 36971d6c5a9a, we called dw_pcie_wait_for_link(), and in the first
> iteration of the loop, the link will never be up (because the link was just
> started), dw_pcie_wait_for_link() will then sleep for LINK_WAIT_SLEEP_MS
> (90 ms), before trying again.
> 
> This means that even if a driver was missing a msleep(PCIE_T_RRS_READY_MS)
> (100 ms), because of the call to dw_pcie_wait_for_link(), enumerating the
> bus would essentially be delayed by that time anyway (because of the sleep
> LINK_WAIT_SLEEP_MS (90 ms)).
> 
> While we could add the msleep(PCIE_T_RRS_READY_MS) after deasserting PERST
> (qcom already has an unconditional 1 ms sleep after deasserting PERST),
> that would essentially bring back an unconditional delay during probe (the
> whole reason to use a Link Up IRQ was to avoid an unconditional delay
> during probe).
> 
> Thus, add the msleep(PCIE_T_RRS_READY_MS) before enumerating the bus in the
> IRQ handler. This way, for qcom SoCs that has a link up IRQ, we will not
> have a 100 ms unconditional delay during boot for unpopulated PCIe slots.
> 
> Fixes: 36971d6c5a9a ("PCI: qcom: Don't wait for link if we can detect Link Up")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>   drivers/pci/controller/dwc/pcie-qcom.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index dc98ae63362d..01a60d1f372a 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1565,6 +1565,7 @@ static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
>   
>   	if (FIELD_GET(PARF_INT_ALL_LINK_UP, status)) {
>   		dev_dbg(dev, "Received Link up event. Starting enumeration!\n");
> +		msleep(PCIE_T_RRS_READY_MS);
>   		/* Rescan the bus to enumerate endpoint devices */
>   		pci_lock_rescan_remove();
>   		pci_rescan_bus(pp->bridge->bus);

