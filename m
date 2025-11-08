Return-Path: <linux-pci+bounces-40614-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C73BC42B28
	for <lists+linux-pci@lfdr.de>; Sat, 08 Nov 2025 11:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6B05D4E25C5
	for <lists+linux-pci@lfdr.de>; Sat,  8 Nov 2025 10:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03342FA0D4;
	Sat,  8 Nov 2025 10:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QNVVwsZy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hqISzXK1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8542F9DAE
	for <linux-pci@vger.kernel.org>; Sat,  8 Nov 2025 10:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762597109; cv=none; b=IljcRYeVo8B0+0ZzLlg579jKG1xa4lUnkv3YLC/oL+YmD4DCmn8o6gEa46kyoAaIg7I03rkEsMZm1h2aQpjx61n/IEgK0xSp5FHR8VZ2NDiWAVM7MRtPX1YpWeQMNH7CCuXQFRnwaYo3CZs2FnyJkliN9nNOkcEjoZqoI/mMmR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762597109; c=relaxed/simple;
	bh=GBQ/LxB19DrzBHbYNkxm2cmpV5l9U85tqsXTNsQMMmA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Q5bmK36zM1qOt1YIzVebFP3T3dDdCGqOHHgMNcmF1XH95LxfWgxXOJvCoaR5LxgckU0wQRzSrDsKa8pLFX1noGiROF3IO6BR8hyulxjMxTJIzlio601E20cPnrKzvaIaK9g0C5mMlLw8RToJtwioWukM9Ph7x6ZQvEfBoZXXrDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QNVVwsZy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hqISzXK1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A88P6sa1303042
	for <linux-pci@vger.kernel.org>; Sat, 8 Nov 2025 10:18:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OGC/TTYpV1+Z4G2ykrqX5yUAV67xQo1z+FOt72hlRZE=; b=QNVVwsZy+anuPf0S
	V6fy0UbSpryq/tT4f0Q5lbmdTPrxJytYzS8Pv1AhIkSu2lKBJC9GuD/bFEn/Q/+s
	suJQzYQofIK6JM23uBzvlcLXg7+RFvTmhS9aKKzA9yuHdLiIIzl7/etmQsim4iVy
	vXgqbCBct878n4jyvWlDiq3tz8xCVhz0AbS6a2yhPaJ57CbxqppPwZC8EJQDNelr
	sU/tGUgUdztjm0mtu9Ba25d9yOgfk8Ugs5F6Hrvr7Srt4aXGncd+sXTaRPeNWxhD
	37O7NuRpj8T/78CBNSYWkbr6EKrN0dtO2u8lAAxaaNr57tmOJAWTixKwlp31Vn0H
	JX9dpA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9xu9rd1a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 08 Nov 2025 10:18:27 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7ae1d154993so1713984b3a.0
        for <linux-pci@vger.kernel.org>; Sat, 08 Nov 2025 02:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762597107; x=1763201907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OGC/TTYpV1+Z4G2ykrqX5yUAV67xQo1z+FOt72hlRZE=;
        b=hqISzXK1uoZ1lciIVvCuc2YxRbuqlett+N+fuuamPmBmM8wtMqfWEGHR805e1AljJX
         b0vlHwQMrbBHsi/PPG40eBTBCmFihv/xMPZd8UM/WwOniaV/htovb3ig/7jS5ocKD2bf
         BOYMq0VkLzvQD302qkXh+BazurkexQpvM7gKBybBpHnnSQxiH0mNkK0SP93Y87Ib2nSn
         RGqsVmex3kAC+xl0306PC+pR5zablZPR+3is9l6sk0otg06Kh8FSrgfnUl0jdP+XpLOb
         05QnB5Dmlsf1u7VOMqxj//FXlAXcOZ9XYz+BKUuzrawqA2mFiMuelKOO3y84flS2Baqu
         KBuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762597107; x=1763201907;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OGC/TTYpV1+Z4G2ykrqX5yUAV67xQo1z+FOt72hlRZE=;
        b=gI0Y9ohFXfZ/aLI/6h/ps5KRvDqVS88QoxRZWF3Euk+wn2VSoQZb4rAazqEpGrc8XN
         RolEScXg5sITovYGDr+tmXjZCkfPAa+o+uzJ/MW0qeamCFwPQTMFpgPyxqUc5AqbGKGz
         xfxEQX/B9m9+CJfuQcj1CRulkohSTxyhuvE2r5ou+YuJZaXHYSdB5DGJEEB4CCuGIbos
         oqONirV38O9DO+y44X0jIexLcaFF9q2oREUQZQo87Y1vbQUtlnIom30vzewP/ZPl6XAQ
         XQPy3ViGTA4KLriHAe8xWeu/hLMmmTVZRQN6Ff33emw4WTiRDNreYukD5KKkwCgV2rkl
         mPZw==
X-Forwarded-Encrypted: i=1; AJvYcCVB2DTbkbZf7sERganQdNkuUU3AvrwVxuassDqWU90KZe0pQyOQmGb3Bvq921kx6mboUe7l2uewE1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjF/PYUQX4fTXjIsqHS9tYxX1HrB5qCu99FlGu/JG5vU4wqaRD
	t0+YbhEgrwBPRl+maQI2CTjs8bGjN+318JsywSQEwa557BlLchnpZ4ZLrKdaaLHzhuMkv6/xSpr
	Sm8LJ8qYyvUINmvc8BOG1W8o0j4S0lfavJPsNONdh5TAnqec9B3TwtxXTbJW8PNs=
X-Gm-Gg: ASbGncsw0w73jVaxQI3get0gCooNvYE1omdeUhZ8dUy5JhevtFwWhx7w4//IDq5uFfo
	0lUuPfavRmZTkNPlJWC6M6zbfSvkUENwZa7UvPeT5D6oO7aomYFuPgxcV9A22ewGWMH/CuBPcIX
	FIjmAjEXOPpqP0caOsTn0854PfUM/mCoSVvYsaQLXZCCBWWjg3iHaeCpgWTaBq0s5S1rV4HSFCq
	ETy6c8V3TqUG5L5vHsmXua80gnOMKjcqMCRep7MP0YMR5S+sDCNHJKDAmzA6/v9u0hrJyNliGmF
	v3J+TcKG2x+0MFtpr5CqPAT5TemXZg1r05e+/vJ0mTFj/VzxGS/K1g98LQ/LeE060oIZhqJ/fWL
	v
X-Received: by 2002:a05:6a00:91cf:b0:77f:9ab:f5 with SMTP id d2e1a72fcca58-7b14aaebb2amr4980327b3a.14.1762597106625;
        Sat, 08 Nov 2025 02:18:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYAGDn7oNGP43S1VSP2Uam7XVLMvwdXyPhG1Pnyl37aZgcRRZoZ2Ct7oXrIFzeFeOC2vpZ2w==
X-Received: by 2002:a05:6a00:91cf:b0:77f:9ab:f5 with SMTP id d2e1a72fcca58-7b14aaebb2amr4980315b3a.14.1762597106139;
        Sat, 08 Nov 2025 02:18:26 -0800 (PST)
Received: from [192.168.0.104] ([106.219.179.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc863a09sm5511813b3a.53.2025.11.08.02.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 02:18:25 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, elder@riscstar.com
In-Reply-To: <20251030171346.5129-1-manivannan.sadhasivam@oss.qualcomm.com>
References: <20251030171346.5129-1-manivannan.sadhasivam@oss.qualcomm.com>
Subject: Re: [PATCH] PCI: dwc: Warn if the MSI ctrl doesn't have an
 associated platform IRQ in DT
Message-Id: <176259710138.9726.16225246756188234387.b4-ty@kernel.org>
Date: Sat, 08 Nov 2025 15:48:21 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: oEw21gSIPOqxecw-DPAy8AIWx8xTQBeB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA4MyBTYWx0ZWRfXzALPA15T5gOf
 HZecLPboSG/+xr+5T4AC7c5fb6XtFE+P6uo1t6p1hYqNRtPX5tt4PijZx+YA6J6yCyyABijJd9M
 K/qrYbPED0ZjwC8S+288tlP8YH0QnHJDh+IOxEzT5c1vbx7I74AryGlhQWyPrdbaPaxJsJB58Bf
 iWYxwAXHpcTzF0KNjvT+BM6UlK1tG1Ph9/a3zeagZKvKNi6g67XGX/lzVfsum+qJV6T5udnCXbN
 bH8xNQvwuu4TKaQrWbaY5jNna/EIsSFTVdEaIJ+ROrLd/rZim+sUUS9rHGz/J3X1+ph5S01qPHO
 mCLAK2YIG+0oGLz5Lor53O4mFNbXeZ+U4BZKZ842kQlhmqC0MOSBd3E1QSw7EIN91RYB2xt4/8H
 gIlCXI37zXpl+x1pV/ih0qT4yjDY6Q==
X-Authority-Analysis: v=2.4 cv=ZPXaWH7b c=1 sm=1 tr=0 ts=690f18f3 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=qronr9GGDLuyXDLutoyxMA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=OjHfIHeS4pxvzZ7QD-8A:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: oEw21gSIPOqxecw-DPAy8AIWx8xTQBeB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-08_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511080083


On Thu, 30 Oct 2025 22:43:46 +0530, Manivannan Sadhasivam wrote:
> The internal MSI controller in DWC IPs supports multiple MSI ctrls, each
> capable of receiving 32 MSI vectors per ctrl. And each MSI ctrl requires a
> dedicated MSI platform IRQ in devicetree to function. Otherwise, MSIs won't
> be received from the endpoints.
> 
> Currently, dw_pcie_msi_host_init() only registers the IRQ handler if the
> MSI ctrl has the associated MSI platform IRQ in DT. But it doesn't warn if
> the IRQ is not available. This may cause developers/users to believe that
> the platform supports MSI vectors from all MSI ctrls, but it doesn't.
> 
> [...]

Applied, thanks!

[1/1] PCI: dwc: Warn if the MSI ctrl doesn't have an associated platform IRQ in DT
      commit: 571dd53fca80508de39cb2edc49a43be3ea5ae12

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


