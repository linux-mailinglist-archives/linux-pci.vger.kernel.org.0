Return-Path: <linux-pci+bounces-44011-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF4CCF37E7
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 13:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6E993007C61
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 12:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF0833A708;
	Mon,  5 Jan 2026 12:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d0EPxDol";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FoJ/cKP0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40CD33A703
	for <linux-pci@vger.kernel.org>; Mon,  5 Jan 2026 12:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767615647; cv=none; b=cQkIxeJOGldhpr/mSw3FftxQCWp+76uhIblkDSkroeuxt++swiaV1BIEaP76S3lT/2N9G7ttIqHdxUMdecsk+oBOEa+TM2UT4AoWIUYS2H2N8yxofiII4iw8b8xp/mmeQzgqTDS4VC7P2yhV4YWDswGBwjOlMdkJO94z0W8ShNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767615647; c=relaxed/simple;
	bh=TqADxzS6aklkX5B6KvAShwsKGKh1j06rX53BjSfupqc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=skK6DrZO+BwwPBpdTO++0l2re0G6/vNnwd0DF69+dtCiKy3//qKSLYwvooY85l8Y4fpmE1kSQo47eHXpNC35F8fd8h+pUF6rXCegjotyVF2oYW0Zzs1Qh16gl0pEVP0y4cxeAePQrmBgVhuyz3Yg3OC5ZxT44aJ5lih8/SFWEJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d0EPxDol; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FoJ/cKP0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 605A9ZEr091437
	for <linux-pci@vger.kernel.org>; Mon, 5 Jan 2026 12:20:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	j6N0+4SXDQraevF2EW/Be8MetunhFs/IYE4WdE/5Dp8=; b=d0EPxDol1ZdEvp/7
	P05Me2wbR8G5S2YsEG0cLlK8+0g9wuzcA760OYo6svchYj1B3cCa/eaRV6NZU3vF
	fQwIdf0WdjssPs3T7j/lVlk9jIou4eY3wfSaQ4IdWOrSCXtDE6GzJF2BYmYbI6Lp
	7abuzCS56fp/yjuwh3d2ubr+Qsu4Rok+Zn6Tj/B2fgw81rcgtTDJOtqRd9WtKus7
	Tbq6ibhfuPwuDVbHgCXbWexMbOo+QSwQw/tXDoZSU4KBBwm+YM4zNEic0QyNKdAd
	MN3rKt/ztmqeRBvLi4CqA+tX0WmN/Wld47p+kKw9nnXW3/Mj6G1iX4TjSeglqi27
	AMnfTg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bg4v61fcw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 05 Jan 2026 12:20:44 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7bb2303fe94so14726206b3a.3
        for <linux-pci@vger.kernel.org>; Mon, 05 Jan 2026 04:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767615643; x=1768220443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6N0+4SXDQraevF2EW/Be8MetunhFs/IYE4WdE/5Dp8=;
        b=FoJ/cKP09dQ/txYsBMI6eJ0jnaSsEAHhrm2q69K6Gis5S5pzf0RC8zPxixbv9WYa16
         /D5G9unnqc0gzkF26J1fsUuW4pE4OdGTgpj7/yAH9JEHg8QYd1BZFZsbmjyXWykOLJlt
         AMhbSLsoOx1ewE0JvTi9jT8K1iRHhJY0e8u1OVfdS3ZfAc5X3l8xm4JAu71SBS6YzEgK
         yD6XYps7fTWm+tJsR8ovX5lNjGXoEO9y50ElHPqqCzO725ObzPuY3CTiesrFxNi13X6V
         jrQi5YtKIiNUk6hQWtNo9h3cxocAan9xdVFI54rliVzlNQelhKZ5GNHWKRyIZU4PvG3X
         aZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767615643; x=1768220443;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j6N0+4SXDQraevF2EW/Be8MetunhFs/IYE4WdE/5Dp8=;
        b=N5YnLMCvkFjga3rZPt6xYTHVTiPOIJpaUYfH57xqN4gs7VuKeS0Wb5/GEyJAqLR1Jo
         ICvnclRWXvF8PmPsM7mlQaT0CPNPA2vzCpUOvsksn/bJUqq8XZs6z6/e3NOXHo1BkCyJ
         3AYFIdP7jPunBp2RKRTHfXyH0DIO1PMeTcmjEQT8+yLwlfqQ88LQRA0QB1U2silqALzl
         IwdyHfvbxIV3R0e5WxMrhVLous4XfYW+yGK+iRCAvdaB7hd3qFYfTwg9CaprfvK745OC
         4C20CP217ovrPEAxjPEc8gcQ3eExtOHinqBAkH+Us8RcMjGui/ByLqPwCs75YEXtabQA
         pcXA==
X-Gm-Message-State: AOJu0Yy/Yw42jivWs6waqmaokbf0t5o6EWI7CDV4mbvrgCOwS62naN+4
	rXPjuTUjpe2+2nTNR1M4HThOurQHn2BCkDdeLC7x3cx7CpD+QpalcsYDOQ9QzAzUgqrRpeeQISw
	JbFsTURkijXUPNd3OZnZnKLd8QOKhIet3UyeM6xe6OyH4lK7FfEt2PDctulZ36VI=
X-Gm-Gg: AY/fxX4nC4kjYhSQ30trRVM1DMxbbRp2r1L4X30TXY/PtBkJBYSVXOL8hmq/KcG4etv
	Sa0LXxvDW5+i+BJGva1jJT9kN1lyAEGwRoxLLLkLL0ZC4vbIMXfEjHA9WOML4Ff979TPtY1gzE+
	PnPatXIOxWEvPPTZ/N8XTdWf0GoGe95nwaYPwW5PDa1ngm7GLQqtJTpdsWLyDQu3RJFgvhzI/0R
	vngj3Pb5RGRzYpmkHc4JLPXgHREO27VYTAKrHRtdQ6INSx5XBcnMB9wZ8FvGo9Cw8tn5C+5Gqr4
	gjtFCznDaEugntTcOy3NpVZl+7GKl+HerxiGe0ejoDFGLmK9T3twd/IIjJ4RciE1V7aTSdWrvEe
	OJnrxJPvCxA==
X-Received: by 2002:a05:6a00:2884:b0:7e8:4471:8de with SMTP id d2e1a72fcca58-7ff66f56b41mr42852948b3a.63.1767615643261;
        Mon, 05 Jan 2026 04:20:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjveNiR6/Fc3fe/zfd5T/lzVV74kQ8TiLlc6yjb/eiouuAx4/zjHU2DgQMzlz8yfswCq2hWg==
X-Received: by 2002:a05:6a00:2884:b0:7e8:4471:8de with SMTP id d2e1a72fcca58-7ff66f56b41mr42852913b3a.63.1767615642709;
        Mon, 05 Jan 2026 04:20:42 -0800 (PST)
Received: from [192.168.1.102] ([120.56.194.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7a843a18sm48392929b3a.14.2026.01.05.04.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 04:20:42 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
        cassel@kernel.org,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Vidya Sagar <vidyas@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        treding@nvidia.com, jonathanh@nvidia.com, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
In-Reply-To: <20250508051922.4134041-1-vidyas@nvidia.com>
References: <20250417074607.2281010-1-vidyas@nvidia.com>
 <20250508051922.4134041-1-vidyas@nvidia.com>
Subject: Re: [PATCH V4] PCI: dwc: tegra194: Broaden architecture dependency
Message-Id: <176761563871.387882.1751871127496787937.b4-ty@kernel.org>
Date: Mon, 05 Jan 2026 17:50:38 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDEwOCBTYWx0ZWRfX6zlokHEqv21G
 TRQuJLmQsNQlyPkRveXet18Hco/Q98KF/QpVlLvL1GUQ5Is/BklK/1rRwMK+x2iDqQ/fpuawxjE
 qu6YU4pZZd8TzX+0XI7Wg4f51nuArjcvolW39XSSkxuV/fbmTVTVE5YZn1rgzp0yURWmFBt8zbv
 FIIB7T8VlHOgPbu0io4CHnkxNs7fBgf958FTNcec+vfRDn/tXnkUxITVsPvEJ5xsnmw8fsaDWPX
 5bNaveXkpPMxl5qdtt65nJpryJjyUbc5DUQUzMCRg2qwTnBw/X6xNKuH5rHOHOjZVdg9bK5Kf1t
 anhRuZVTD59F3Qx0CREejfgI+eceQqQX5IT3LV5vBIvBSrnclq7/Ov/UYlIAHqSv0zun7/p9V4a
 mzsnE5CvzQ+FNIKJF3S9UwFmU4sjcO0noyLM9TdJ6r3jp3WGAT5dph6gKmmlkAjJwB4rbgyT5p4
 EuRq9VOL59o8ZyZrflQ==
X-Proofpoint-ORIG-GUID: 3UI1FpkjmGMO3x8uiHJwGpgNkZdWz1VD
X-Authority-Analysis: v=2.4 cv=c4ymgB9l c=1 sm=1 tr=0 ts=695bac9c cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=3dEILRYKsVIWdVk4w2Qziw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EuZABCfmLVNWCGki198A:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: 3UI1FpkjmGMO3x8uiHJwGpgNkZdWz1VD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601050108


On Thu, 08 May 2025 10:49:22 +0530, Vidya Sagar wrote:
> Replace ARCH_TEGRA_194_SOC dependency with a more generic ARCH_TEGRA
> check for the Tegra194 PCIe controller, allowing it to be built on
> Tegra platforms beyond Tegra194. Additionally, ensure compatibility
> by requiring ARM64 or COMPILE_TEST.
> 
> 

Applied, thanks!

[1/1] PCI: dwc: tegra194: Broaden architecture dependency
      commit: bd9277c26522eebc6539edd0b0c99b6abdcb14ed

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


