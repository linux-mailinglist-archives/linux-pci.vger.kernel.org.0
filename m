Return-Path: <linux-pci+bounces-42103-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF9EC88B9B
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 09:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D98963A56D0
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 08:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6436A2C236B;
	Wed, 26 Nov 2025 08:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UB6Bd9EI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="frY8lBc4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFED30EF6B
	for <linux-pci@vger.kernel.org>; Wed, 26 Nov 2025 08:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764146865; cv=none; b=sSyHAbE5/vimkU5dcUIhwPIcPWD04pFLdb/e9AQY3ieu75FOWKvZJCMOEN/3OsPimlC3x+fAUzRHYSMdHa9oTbB6VqU4QmVFp+1ATMfjwcAXhBQJyUULnk/YOse3Xv1PBI2pB74ZX2Ue5uVGb1bbLZ6MxtnIiLFTs8JN7lLR2dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764146865; c=relaxed/simple;
	bh=Y2lKCts5CJPNH0MSL8iowT5ojUWvEug7hDEUecBfUVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKYc5pssuHiZ8ul4e5CGvW6GU7MkySP5+hKMKANuQCRhdlwpCwEj/l3LYRKIR/1SxhJbn1dO4QgzMJ9eQlRS4t+1wOYiUJBakjP7ZdF0uvdFKyjeP/H9yWRw/WYc9rZWrGtUnFBm/7qsUY/PyUhw3VUwv25qmLaX+XPv447AuKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UB6Bd9EI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=frY8lBc4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AQ3AgA93707407
	for <linux-pci@vger.kernel.org>; Wed, 26 Nov 2025 08:47:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=SA1QjlGJ7UYJoW3bkSJoRtZs
	L6FcyH/jM6IDdNF5+J8=; b=UB6Bd9EI6P8muNVAQscUaIaGfC7kuMC49BYKjbei
	1V1/iosNN6MIkLMh6DKABUch95CiOD5jUzz7iv9IMIFvytw0M4hpRPFVG2uaFlcc
	nO+sV03z77Q/k7BJN5SQwoCLAqAgwqeEx2A1WjI91UcKKa4oUr77MqPahXDpRzg/
	xYa4tZeAuKBm9NatR8pnp36yy9ejrzs3wY34wtnNDUrsGvXTniwESyc0ecP1LLZ/
	ufWXURD0CaUhJEWi0ubGkSpHAex/grcajiUBdFwEwgXN3+teQ1tL7cr2q4GNMqE5
	G0uJIJHHerP3JiHBdv5RM9biDu9Yo6Bn8nJOW5ynj4ro9Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4anduftrm0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 26 Nov 2025 08:47:42 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8b2ea3d12fcso1432516085a.0
        for <linux-pci@vger.kernel.org>; Wed, 26 Nov 2025 00:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764146862; x=1764751662; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SA1QjlGJ7UYJoW3bkSJoRtZsL6FcyH/jM6IDdNF5+J8=;
        b=frY8lBc4vePUvaBX7FO/Xg3QH50IpD5akvcLvNUOx8WppzKrGYjNmF4tJarnQb93+2
         nCe9yOfxkE67u+rSotV0NVUJt7acdqEcO30UA8fCZAESBhd+6I+Gp/czXWKjeNW7xVQE
         u9W9x8AhVOjzXlkxZ4cCcgk37rQJHXITn1YqidOEdy2x+9y/bjHLSW0DQ0UC6qZeoeId
         04n9TgYfz5nPeMZOiaxrYypOj0ckJ7VoxBoQMf+64M/Hl8peeUtpXINxt+S+TrloM4KG
         ebWYO0/MeWOs9ZA3VWxmAPjFLez5JEorS8Hlql8gO3bqcrAA1xAiiUnmr/NVWeaKyA0w
         yXEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764146862; x=1764751662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SA1QjlGJ7UYJoW3bkSJoRtZsL6FcyH/jM6IDdNF5+J8=;
        b=cqueneFUE6Kc5WcC3zrOZRuxxSM25Q6Tbw0A1iwZnExGKERERvB5e8kx6SGWkFgloF
         ojoJHTuAUQooxi4bkhGB2rBYhU+ca8sKL7LZzSSiUeCqEq1m0sPZo/3kx78DuK6SFumt
         SISb+7bF0IuseBnLMJVHRoV8siFAaPFyW+Yx5F53rE/bDsackY2EpuNmC5SKsngALv39
         43dWqGKcZK/7IVp1Rippuy7W8YtXAW9/X17AmczmiTKOhZalspFecJQ66lbIfUBsLJBU
         yU45KxHSQthZg7Kmt+Z7Jnl0T1GURwv31CKku0bv2QUpfnZSPeTn87oY9c2ssh122SR/
         j/Lg==
X-Forwarded-Encrypted: i=1; AJvYcCVD41lbkNiYUAIQz2C5ea7LCp1w51TD254iMpIOWR5wLQ0olmVdUeKqVJ1yqxdirWaYKRSgtlKqG4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCs0CTG8ysYHp892sM4qceEAkfvd2unL5h44CJuL/1BFdIvZLD
	uOJC/J+KNRHhgEYKnvAXf9GjhsqYGhGPcnTb5+quduUCFg58xGqbFUnCMkxYnnM4E5+NzoPVulB
	50qu6FqU/uIKSrsC93b/NlYgfAFblkb3qwKRlu7eWnMYgNY9b57S+BxCjrS/PDfk=
X-Gm-Gg: ASbGncvDy9ZqhFevg/OIIfbrns6U77wPw0VQOS13lcSAv4vOJE43eNrGLM5Qazf09V5
	Y6oZ6o07QkPVqFAfzVNx9LY1KnavVJ5JN2/akwywrNbx6+N1lpAzyHEawU45DgRtivhEgNzVit7
	XE6t5+G8y46fy4jZ5M1phOH3ZIRsKSxkLpKvc484ADA9NWUdGhFVQqHwzH//K8zSdHj+m8ISLRV
	whwvYc6wwQYb1mPKzN+Rm4S6JTPDUtU/04kitIuQ3Ud1WNd+zG9+1XbdSZFkRGcbi3/rFH4fMyw
	IfAaP0C3YLij+sZl5DTBvXxR5xAnTauf1cSjV6e1DHRhwMZ6Io6ur5/GXld/LaPNDPRhKMnudTV
	W7drASReLsw94/0flrNA23ZC+yTl248pKxeQ+AHNFkIJKGIw8jMqg9z0ZreWeOy7ffk5Sa0xB5M
	kCYtGtWWSfFctTnSFWR4g1diI=
X-Received: by 2002:a05:620a:4102:b0:8b2:f0dd:2a89 with SMTP id af79cd13be357-8b33d1f009dmr2299921185a.37.1764146861906;
        Wed, 26 Nov 2025 00:47:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8s5j5+VqMpqJZ/EsYjx8m89SW1+XSyVuNt5iFdlq1JMKVOVOpsI8Wuj3Hse5mJd69888Rcg==
X-Received: by 2002:a05:620a:4102:b0:8b2:f0dd:2a89 with SMTP id af79cd13be357-8b33d1f009dmr2299919485a.37.1764146861487;
        Wed, 26 Nov 2025 00:47:41 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5969dbc5be9sm5716685e87.81.2025.11.26.00.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 00:47:40 -0800 (PST)
Date: Wed, 26 Nov 2025 10:47:39 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
        bhelgaas@google.com, robh@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom: Clear ASPM L0s CAP for MSM8996 SoC
Message-ID: <utecia46qscniiapbki6nonn24pr7rimxh5mkptkbj27ohvgsv@6fftnshj3rjs>
References: <20251126081718.8239-1-mani@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126081718.8239-1-mani@kernel.org>
X-Authority-Analysis: v=2.4 cv=C53kCAP+ c=1 sm=1 tr=0 ts=6926beae cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=vqDPTjLrrVU5Klh6hrwA:9 a=CjuIK1q_8ugA:10
 a=zZCYzV9kfG8A:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI2MDA3MSBTYWx0ZWRfXxhcxu0eOQUK9
 fxW3lbJHURRjSOqlz0A2dUUweSpU/64GgFuQjyGr3BQrZRlXTDBW9tS4uVUbCBV9v+hdM29VVQB
 FqsgFzz/OgUtRowV0t7VZOLH9esW9Ckzj6/09Oiz/+Gn0ExKinLeYq3gme0EHhN5YtCSIw6XbpU
 Ip16dNVD8sVuuzdlbLJ3W0NYqQNh3CkHMBXaPAWorzIYfh6hPCzUEm1DWlxlws6hKdqZlUd78yF
 6TF0ZlPNbfYJDScxBalF4g4xuNGVtcvRMz4/o02YmuOOPz66/V4dyWya9wX+EMY66cYP6Z+y0br
 IgKX/H12HvNWQs30eYu0zQ/OpaCkMKzkpdiMtKSJVv6XFvXXS96yGYI6P8npVN2nbyxLwYGfR+d
 CveVylE/FGbGNHEcY+mNiVdBy3N+Kg==
X-Proofpoint-ORIG-GUID: gU0oHcQUbcQFG0d0VenX59ANtWWmYeCZ
X-Proofpoint-GUID: gU0oHcQUbcQFG0d0VenX59ANtWWmYeCZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 adultscore=0 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511260071

On Wed, Nov 26, 2025 at 01:47:18PM +0530, Manivannan Sadhasivam wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> Though I couldn't confirm the ASPM L0s support with the Qcom hardware team,
> bug report from Dmitry suggests that L0s is broken on this legacy SoC.
> Hence, clear the L0s CAP for the Root Ports in this SoC.
> 
> Since qcom_pcie_clear_aspm_l0s() is now used by more than one SoC config,
> call it from qcom_pcie_host_init() instead.
> 
> Reported-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Closes: https://lore.kernel.org/linux-pci/4cp5pzmlkkht2ni7us6p3edidnk25l45xrp6w3fxguqcvhq2id@wjqqrdpkypkf
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Tested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Thanks!

-- 
With best wishes
Dmitry

