Return-Path: <linux-pci+bounces-40707-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F39EC46CFE
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 14:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D2924EBDBF
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 13:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18473112C4;
	Mon, 10 Nov 2025 13:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FnIKMiJ6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F7/DrDrT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F74730FF31
	for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2025 13:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762780425; cv=none; b=FMaLdxAN85G7L2tzGsHk4Tp63n3ZiC+mxUmI8jmS7cv/DO00uEm4gcuZXCNfnCpbSjl6nXoL5ZXKB3Nde6K374i4bj0RhbPI7FIFMtTPuuQH3uaPpq1j0lUrnt2c0LF7teZ/ZpOeUcjzUgkfdW+JSaVldmmxozb9YSqV+gaZnTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762780425; c=relaxed/simple;
	bh=sAyJEnQpOE+CyoPsEVV52oBcegXRqpcGw3Hj73SO1gM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m3eU8Gn0A0YFNLobtfXohmQ7bCyRbLmz5ufDx6zX8qmorsjb6Y2j8qoC5xJ4jwbbRywuPZ6YW+uN/4xLm3UQJ4KoVvpQH0GJC32kuUMHhDBDRkXUXFejEpDcbO1egalyPsZWvDhvhaCIWwCtiJ1VqZrmvWrwK631tiEftfouOwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FnIKMiJ6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=F7/DrDrT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AACOJeZ2407325
	for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2025 13:13:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zf5by7v/g7p+dvGHpfj+j+RRTgR0OJ9Fd2rr/ysTKL4=; b=FnIKMiJ6Agw8Bw7d
	D5l7XFqGN2+lHQ5BEbn0Fv4yo5kBF3fGxUt2j7XPo1HEj7tPwE0dJdcVtcFMsTqR
	nB5DTif6JbwYoEPpvCgCRdhnA66hmCfwRCmYKd4ww+ToVJmDCyFipto/RkoVRccF
	lYgdeyKMb7HCLa2kjMF/jzv9vtmKR772GjPLCZStXjLIoc1lJh9N0clrNKtRUtYI
	R+/6O1HIJaS94oRRCigXi8mfz/Jf5oDKU9qWfrYGwaaU7WgxKPATGra8H1kqx+51
	ZqATOwjTJi/hsTm+beLsCseKwe2j784oW8mFVWUqZ1VyschZpGpcUw9VTYUN1Oev
	9AhXGw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abatd97ar-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2025 13:13:43 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-ba433d88288so2335796a12.2
        for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2025 05:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762780423; x=1763385223; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zf5by7v/g7p+dvGHpfj+j+RRTgR0OJ9Fd2rr/ysTKL4=;
        b=F7/DrDrTohOcSHx8oxMgWQV7l0XZ7Svv1IGwC0DJDJgAb+qdunIhWtq5qLQC05sYGY
         GgdNoHyr36DyWyWAmhnw9BKxXThjvE3MuHnEOYA7ht+iAVAMaNN+Pc60scfGKz4Lf3h5
         N3xBZH8ZSTaAvz56Y2/4SHi+UbMf2L3TcjC3IycIGHhNmIYXHM+JutlUj6IVL+Iwuibn
         jVoEE7yoLRAABLybOHFoKuU7sMJ4hDYb2y/HHOFmAYEPa7RA5v4GZQyc6pHb+kYA/16H
         8qW7ySCSHqBMRq/KnTPNjYqZO2vyydeO+K8EVt3oDAV83uWGhWs9rMSSDhHssJPogXoS
         zYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762780423; x=1763385223;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zf5by7v/g7p+dvGHpfj+j+RRTgR0OJ9Fd2rr/ysTKL4=;
        b=lDhli4588ghlLEtK62dVwnSGjO8jMjfXN1C05FOjkgnydFRk0e7t7p+8riFY497YOS
         4KPjjkg0VpaXA8izJf2RGQaIHWEE0tUkE2Uunx6XMn3w+GmEuamU0GYbl7nbY/QzYHh2
         AaIyxphvGsx9W/dz8Goeamp8GAVjpdVkloRaTak2xSj21JQ6gU1Ui7JikstymJVtTPX5
         KjZSm3t/AcgI48dA7IDWKCzPoagikBnmbzB/fli+FYy11VGVj3UmEHJLw4Kyzn8hNoCx
         rQnsKuQaCuUkM/qw7xmYP/2LyWbB73RKUiLyCg+BHwQBrs6goLFc0/CSqvIojBbr7p8Y
         cCug==
X-Forwarded-Encrypted: i=1; AJvYcCUuzbcL6R0HcgG6yFTJtu9eAKPGZcTwA8Jffqlt+OFPlbZ1+WBjwx8pOfT57ELNUMVSZU9GVocRpMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXm3aZ68Zgl/YoIHuYu108A51di3VeYyVGQbBES6kxl/HQmNyH
	FIaNuoRgzTuuFw8ZK27usLSeGRh2np6Tg9QGLh0G4j7w1CFYS8qOq+q7HwIp9w0HDb+GirYkCki
	BhTDNnVs/MFewn6v0MAxVZgLXggSUzsX+vCIc6x8ooWAfr/n02y1+JS7kHje/bsk=
X-Gm-Gg: ASbGncstuAXF5cRI/HM180t7j32Jvs3WoFNRjsaqp2LdjVOfNErEePbOhu88WLCnmUa
	7A4vYRx3QzgvfOiFWUaVOddJywO8BHR2zzDjiKdoyUopibDLKcSptv3ZmIh5sUNV45o47AU3AR2
	Sl+XSuQ/3xNbqxGFnn3/xBq25qxlPJDtS0URXb2aGPAupfvDl8ZV/p+OohO0R7UoZCcnzRhYDfh
	UhkdUkYI6g6py95NXNSMvv6umHKBwIUDeWRteC/2SawR3/c9+3fXfLDoYfTN4KmBcBKKx55UsXj
	Cg7jhQ7qCc2PJXgnR/QoHmf4HPS6jbLHZU0+hTyBZFBQv1lwb1GGK7PnuyTFNpis1XNzF6xp3pQ
	KtPlFcVuoftgXopSnlwV+AMv6OX49MaI=
X-Received: by 2002:a17:90a:e710:b0:340:ec3b:b587 with SMTP id 98e67ed59e1d1-3436cb7a93amr9070689a91.1.1762780422764;
        Mon, 10 Nov 2025 05:13:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpxzKYemCJDBtZNVtT/gk1VWfrU0u+FC6zzifoWeyFyq0P4Hf5egp7j8ghzn6uNZubwpXZ1w==
X-Received: by 2002:a17:90a:e710:b0:340:ec3b:b587 with SMTP id 98e67ed59e1d1-3436cb7a93amr9070654a91.1.1762780422139;
        Mon, 10 Nov 2025 05:13:42 -0800 (PST)
Received: from [192.168.29.63] ([49.43.224.0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc17a688sm12007008b3a.40.2025.11.10.05.13.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 05:13:41 -0800 (PST)
Message-ID: <511ebf46-63ed-45af-9d66-ccd1d944763a@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 18:43:34 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] schemas: pci: Document PCIe T_POWER_ON
To: andersson@kernel.org, robh@kernel.org, manivannan.sadhasivam@linaro.org,
        krzk@kernel.org, helgaas@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        lpieralisi@kernel.org, kw@linux.com, conor+dt@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree-spec@vger.kernel.org, quic_vbadigan@quicinc.com
References: <20251110112550.2070659-1-krishna.chundru@oss.qualcomm.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20251110112550.2070659-1-krishna.chundru@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 4frKZwVq3GCBi62XmUj3XofW1QlegBZ7
X-Authority-Analysis: v=2.4 cv=eZowvrEH c=1 sm=1 tr=0 ts=6911e507 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=08Rv9HEMxtlCNW7Dos5SIA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=SpA6wshyjLPcRYPzmHsA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: 4frKZwVq3GCBi62XmUj3XofW1QlegBZ7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDExNSBTYWx0ZWRfX2xETzjBYs+YR
 /V6TWVd31af/jqubfB6APtdJiNY/HgxGyFfscbruRexppZkIhCJTteEmNd6BMIBxBa3FaKCj40J
 p7PF0CcsBh3se80Ipe7XTRWCG7uh/HawSj6d7wiWHsK0HbJjKFddMz8FvWySSHQ/DtQGlYQXcwl
 nHJXEP5HsFLKFLooO2zWNkBONq7q2hCBFUrROfEmsC05yH2c1bucgez7yqodKpl9HDgT6wBbKvW
 LPzgEzeqcKX/yo+ZYmFDEgvXAQHJvFjj3MiehxauHygfgLwJl6p5tBLoW8YmWGpGu2uMkHp4rTf
 kBXmpXL8eplW1vJjArmUM+hsWhB9Y35sWciDkz0AyO8Xm1vuDkJCayYz2TrnTsB52SYLj+OitZ4
 JrZcScYXxofSM4MdbHG18GubCvhYpg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_05,2025-11-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100115

Please ignore this patch, it has some mistakes which I have sent 
accidentally.

- Krishna Chaitanya.

On 11/10/2025 4:55 PM, Krishna Chaitanya Chundru wrote:
>  From PCIe r6, sec 5.5.4 & Table 5-11 in sec 5.5.5 T_POWER_ON is the
> minimum amount of time(in us) that each component must wait in L1.2.Exit
> after sampling CLKREQ# asserted before actively driving the interface to
> ensure no device is ever actively driving into an unpowered component and
> these values are based on the components and AC coupling capacitors used
> in the connection linking the two components.
>
> This property should be used to indicate the T_POWER_ON for each Root Port.
>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
> Changes in V1:
> - Updated the commit text (Mani).
>
>   dtschema/schemas/pci/pci-bus-common.yaml | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/dtschema/schemas/pci/pci-bus-common.yaml b/dtschema/schemas/pci/pci-bus-common.yaml
> index 5257339..bbe5510 100644
> --- a/dtschema/schemas/pci/pci-bus-common.yaml
> +++ b/dtschema/schemas/pci/pci-bus-common.yaml
> @@ -152,6 +152,15 @@ properties:
>         This property is invalid in host bridge nodes.
>       maxItems: 1
>   
> +  t-power-on-us:
> +    description:
> +      The minimum amount of time that each component must wait in
> +      L1.2.Exit after sampling CLKREQ# asserted before actively driving
> +      the interface to ensure no device is ever actively driving into an
> +      unpowered component. This value is based on the components and AC
> +      coupling capacitors used in the connection linking the two
> +      components(PCIe r6.0, sec 5.5.4).
> +
>     supports-clkreq:
>       description:
>         If present this property specifies that CLKREQ signal routing exists from

