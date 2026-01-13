Return-Path: <linux-pci+bounces-44617-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C49DBD19BF2
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 16:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4C90230151AF
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 15:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C192EA490;
	Tue, 13 Jan 2026 15:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E5qhynzc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XftoF3b2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7A62D9499
	for <linux-pci@vger.kernel.org>; Tue, 13 Jan 2026 15:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768316877; cv=none; b=m2AhPrhZ35URrTM0pdiEJuoCNZzvMJQhUKfEKSn0g/6sOESObSr8INIOK6n8+czR8/D6Ja6ryBfjp2ZXuCQBD4QebspZRHMT4N23liB5IzMjgSkVF35PAUha/2IMmIj99rgpaNVaBpDgm/ZtKfQ98HVl59RDhmxekGYdkyuk6bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768316877; c=relaxed/simple;
	bh=VSGkbwv8HFbydgyRyX+OYPrBxwLBYxlOvsSfJGvFESs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QZBw2hMSYETZxot3335u/3rtjolYwG/tybWZ15Z7gqO+257lBBgIwMeUqUCgmjpHe9Hn5VT7eSp4KxtVl9bN8+AXWfwFeeo1IzCmOSroBB3MKPkiKzuVdtas9MQtrR17Lt/SNZtMXxZUVoitfQqOjZqKAJL8/RAuJeqApajgWWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E5qhynzc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XftoF3b2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60DCIfjD3817041
	for <linux-pci@vger.kernel.org>; Tue, 13 Jan 2026 15:07:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5u8zZy+SMq1tuf6StAdBY31X0PCasfr3C7hRuW51Ttg=; b=E5qhynzcBI2GzoXL
	b1/RtLPX+FRGsvl8F84iP8SSkejYgVC74GGemmD+7JS+baYecF+W8QXKUTOr23ST
	wfge79nB9b8wnccBy5Pgah/Oro/zURlH2h0uI70QQWIVflyIzwxNa7WaWTId260T
	qmdDebR9Ty1Oib02+4L9UXlEqCPfe7odWe2rXNvKv2DlJ1toLdFwHK781Up2oBRD
	UyI9XUlj5I804dWIY8lSMKH+l29TJ7rKFLVcRwfN/PBH/rAD5SJ5R/YkwaILGNC4
	/oIIgzRqYcmWPv+gl0qN1aTflPEBpPVt1L/552HkGCp0h27prtltS07h7SixgBXu
	jXF7+g==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bng55ss01-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 13 Jan 2026 15:07:55 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34cc8bf226cso8574554a91.3
        for <linux-pci@vger.kernel.org>; Tue, 13 Jan 2026 07:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768316874; x=1768921674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5u8zZy+SMq1tuf6StAdBY31X0PCasfr3C7hRuW51Ttg=;
        b=XftoF3b2YWAOtPEmUrHgCui2RGmpusmuXEH+AlzYgu9Rpa3ILnFGpvq3MDZ1dP46Lm
         vP7F7vwaNW+zbpLkPmfxnae8KtjfZxiDaBRrqnbaSSjStDSbAz7D1L8SS9Yp0D1zzbCK
         tPfmCoskRbA2Yo3oQ4eSsmdAzDLBKjyH0QbHrT7BxhHAbtO+QpRLyjP6thg3Rl9dsmFe
         f5LZB/3q/g2KivvCo0B5ZauebrP/Gxx3qYQqP9pglf18IwK4DD+k69TAhZpnvdHRPS7O
         e7VvzHj2J3upls+oEHtwGuY1BHI9TJVOC51ece0sugs5Z6MaJoUb3wwsKvPAKw+jbYRR
         FAfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768316874; x=1768921674;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5u8zZy+SMq1tuf6StAdBY31X0PCasfr3C7hRuW51Ttg=;
        b=onjLJrjva8jkAuk7wfuS8W8JRDoh/ytTiPjVtHqcJ8CSaH6PA46ATn0Z4qB3oWTsJT
         eLTyngX0mRgAL+j5aytXbLywFSkzQsMXNygSz500Qee4zb0Xu4Ac2HkbiZqThffcJxLo
         333/0QULCL3Hw0VfrXeNWn04HvbWH5h9Dw5NpQXfphw0SGbi+gHVzELaIriJFRnPVsdV
         AUNiYIi/Kn2198dMUzmDmw7N/ffkcNqAhmmaOALH6B1E4WUfYTKb3bVDsMP24Zb2qtD2
         TCEaCHl3SJCBIm1ojBARxG6jQc6swpf3+LoVPWwO/8Hsx1H/Eo4UL3QN0mtqRk4SWDqv
         1NCg==
X-Forwarded-Encrypted: i=1; AJvYcCWEOvdDQwHDs3kEI/KMIXVxdvVx4oPrlyY58IX7WHK+hTeiCQDSzXgGKKfMl7yT0GUBayNQRJiWpNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNzthV2P7/Bk5YJOHaKWDIJ97uDM1NeG1dGF/Zw4c9ArloKcYA
	LG9wQd+ermz01mYzWMJjJnIHmNpxAOFxkFApkJ0sx/p1za8fo8VAoj1h3rOnZMiqe012YyWRH0k
	zVylUcxtmjahHcmQnSS2EfkOYRKpi+7pKZpoMhJADCw3/lbhsdFA57hp8vv5Cwa8=
X-Gm-Gg: AY/fxX7XEbV05195mMbM2KO6k8gNAUxOp/SDde7/MpD97c6dygdcvhrTS3ze5CMZ9oO
	ToSu6f/MwusEB/X9/1j1EnIkutLryTmu345GfsRoNMnp3O2JCwE9/WAYOlKKB3nLifYGJDJatgY
	uF4VGTxI8wODE1tn2YEFXbgdc+V39oqzOHehb+ZUTlNjCdZ4MetsQcc9G/Gp8xS1zn8PJGoHMeX
	mmJ8TuRqtZJMmDOpFALEqVY0h1VTYuVgDXnatxaarrGTcJL8Uo9x20gtxU2UvyNIrU+sOqZZUuk
	zmN48p9cTfu4vVTZwoJ5barmrVyslTlV6kfl0ZjqmocQ4UoYpftXTcfWgbwTJOJpA/ZmIu1Fce5
	penlJYQLz
X-Received: by 2002:a17:90b:5708:b0:341:8b2b:43c with SMTP id 98e67ed59e1d1-34f68ca4541mr20354404a91.18.1768316874341;
        Tue, 13 Jan 2026 07:07:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlt8ZgEvivm97+Rg+mnmfT7T2zykprrAJCxYtGFDtZ2bzCPakH5pqcMmlIJmmG2RqIRh42vQ==
X-Received: by 2002:a17:90b:5708:b0:341:8b2b:43c with SMTP id 98e67ed59e1d1-34f68ca4541mr20354355a91.18.1768316873746;
        Tue, 13 Jan 2026 07:07:53 -0800 (PST)
Received: from [192.168.1.102] ([120.60.62.237])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5f7c4118sm20111482a91.7.2026.01.13.07.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 07:07:52 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        quic_vbadigan@quicinc.com, quic_shazhuss@quicinc.com,
        konrad.dybcio@oss.qualcomm.com, Rama Krishna <quic_ramkri@quicinc.com>,
        Ayiluri Naga Rashmi <quic_nayiluri@quicinc.com>,
        Nitesh Gupta <quic_nitegupt@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260106-firmware_managed_ep-v5-0-1933432127ec@oss.qualcomm.com>
References: <20260106-firmware_managed_ep-v5-0-1933432127ec@oss.qualcomm.com>
Subject: Re: [PATCH v5 0/2] Add firmware-managed PCIe Endpoint support for
 SA8255P
Message-Id: <176831686765.502522.2253728268158673109.b4-ty@kernel.org>
Date: Tue, 13 Jan 2026 20:37:47 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: P04O0FBZwhNWIEnzGMrad6-xQBrBgz62
X-Proofpoint-ORIG-GUID: P04O0FBZwhNWIEnzGMrad6-xQBrBgz62
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDEyNyBTYWx0ZWRfX28IGX2WOyaRr
 WSCz42RF1mhR5Sfl7pTAGpB/OhfsfBYR6NafqFL1UO9YMJI6uNBL0Wksf5gviC+4EWOMST2XAF0
 Jv/UXbDJM51srE4J0vWjrc2aYUtCJcIA3ih/npF7zFgUrgV4a52oDNKKqOkNIQ2nahdLVhb9dkf
 qjNvhi9KkvId5Jt3hULGVGrvrDev78tx1uUVf3BCBq/iqYcNup+jIMAMt95EKLbh7xdvx5iDKoH
 7UTPsxzQsRkHgbbIbAuhq7fALPXr9EhUDRViK3biYGL7B+AiiefBxmTmQwGHJtDr6TFZyuovqWu
 /l0iBqKBrFvizdHfnIoCQ2BhBo/tGF55pd1FateTDAKXkHzlhXNGKQHXq6VRRCx9Q91csP1bFJ8
 i6/iYwA5pKOXElV3wik63CesFKH3kLjtSEEnGqMCCdEf4NYZvnC/LPpGGGEdauxCuiifwiyI+Nj
 0PgRjQS6JMcfDA1GNig==
X-Authority-Analysis: v=2.4 cv=IIsPywvG c=1 sm=1 tr=0 ts=69665fcb cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=tlgrONNCw2HA119KiuRAjA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=90D3mx7Vd8eILxI8FvwA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601130127


On Tue, 06 Jan 2026 18:04:44 +0530, Mrinmay Sarkar wrote:
> This patch series introduces support for Qualcomm SA8255P platform
> where PCIe Endpoint resources are managed by firmware instead of
> Linux driver. So the Linux driver should avoid redundant resource
> management and relies on runtime PM calls to inform firmware for
> resource management.
> 
> And document the new compatible string "qcom,sa8255p-pcie-ep" for
> SA8255P platform in the device tree bindings.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: PCI: qcom,sa8255p-pcie-ep: Document firmware managed PCIe endpoint
      commit: 20165a8ac68ff375e4955b3f9fda0404229131bd
[2/2] PCI: qcom-ep: Add support for firmware-managed PCIe Endpoint
      commit: 5b026a9e714d33bb61f6041b9e1bffa2dcc66ff6

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


