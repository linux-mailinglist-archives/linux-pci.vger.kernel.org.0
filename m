Return-Path: <linux-pci+bounces-32391-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 174FBB08D51
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 14:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECCD23B3495
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 12:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD57299AB3;
	Thu, 17 Jul 2025 12:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kUPfhJ7e"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7207F63CF
	for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 12:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752756455; cv=none; b=IMIZimztBzkcfsyFk9dsGB76S4xbUSAphmTMU2A4v/d8UC2q8nKuUoD7BbY3bs3PvT+TcKXRIYEVEzSmMgI1YEt1W5mNgc8CBZOr9SJat86nC+cCrgozw0oFQVx6cp1ULTTRKXtqz8KY5EDHjXTb8lD95xpr/IU8Z7CK3GOiDm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752756455; c=relaxed/simple;
	bh=5D9EnBrawa9zcKiNLPVRmyAqThneR7lTzfcy5UjWtm4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=emrhyicNQMRtkFnnV64M9ubtejc5/n7gNCPvCb/gXW81WcJrzfVa6/dQ01kYSJZtELDX+/VyJTDZWSpd4mNIpgJe4pjld9NTxUZTuqFFEgFoj/Cy2ReLdE/nW7C7vY/q62US2kjD4M6pwCFHVDt2vlVB6plYJrwvacfz4AuEQk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kUPfhJ7e; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HCEh8N020662
	for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 12:47:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QyCNQ3TRjAn753UkRsRqUtDMNS9fnsDSx3XVAmAgxtU=; b=kUPfhJ7eQ02lEORM
	CETlO9BpKe4lrxCXg/rMGb5p/a5aca/d6bXEUGksvCRPqiekKfPr21yhWzc+1emc
	eoM2/zNUeqy/8sYpO0haaWTZODyX6evXpMUSwgiDMKPDSpasjbOCeoJ3eEjTWf8i
	DBtRrZIKPMVc4Cps0lo3yaGPfEVbmCwVjcv+9ce5fMhi/ZV6BAxJ7mawqp7iWwwF
	b/7E9JRATGWBwfJIOfHoDqWmpA+wIGZNreQ/jd9DSdvAJNRUOHuWnHm/AFotvCeN
	VGZWIXF4oD6fWfwtqLsPNinezqS+xT3GIPU74l2Hm8/Huozjmlj7ShehheMqFIPM
	Cicz7Q==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dpjpxs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 12:47:33 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b31f112c90aso828661a12.0
        for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 05:47:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752756453; x=1753361253;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QyCNQ3TRjAn753UkRsRqUtDMNS9fnsDSx3XVAmAgxtU=;
        b=VPHi98LVvvJSJL05ebI2LBgx23oO5Cg10v9IX+nOGGdDKxGw/M1HPm+dn8WJvXFk0S
         cZQb889KS1AuB67ERgBD8F1X89IOtLgz2Xoy4jAe2fx5pVVe+/7yyuOJcHC5lVIvOgwI
         hTWSkVjqT9d9ceufxygnpNuXfVtBBTEtiRchuwHpL5EYmpua0ueZcGE/aAVTPN9GTy9B
         8S2Bx4jw9a4896iaHsP2g14f8GcZjQr81q4TSQ+QO9UNKJ+uRfllopN/hVsDjjbeXZvi
         +WW+pNXhLUUMGvezFApQH3R5WuFiP/GI557Uii6Pyw1goL08sB+gEiCWu8cJO4enNan/
         fvgg==
X-Forwarded-Encrypted: i=1; AJvYcCV864Mf4Y1YaZevjmhMJOnXuqln6aH3JQ1wlMAPFF9uxsS05WxM/cWSI6hpfIAkHiCbS9ttf4ZCnMA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc+cmZJW9eHEur9gPNMHfEtfNyoLXHrXUpfRo/mv9heT3/NQsW
	YbTxWGI9np01bkyZZLogPCgKE3xbh4xn4zgQQFAsBZu3Qk7pwHLODorxnNJfZtJe0sX2qfv0q/7
	37EsFpu2StdmEuMICkw155gS3Jo+S6J3O3WTei9QHgKaUpASVn0aEdMBsDtHhlEk=
X-Gm-Gg: ASbGncvgh2isH7XmCs6HxB+HJBpcz8dSWQ6/9wgGIv2mLqfz7e+w2L53iTq42dU5b5b
	UNraEWOIZIOs7IKeX8wwtnVtR6O+1pIWObhCo4dytHL4Z0boRWUY5I2oCiFDA8GEJAuWGzuNT9o
	SNxkhfLsYcjCbLnMKjLVoBcRgAaA3Awrm1QnweTm85gIgJIq/ck8ocSUccy0S3FE5MPBg5VKLbW
	G1JSECFfLr4BJUv6xlkYAmygP+r3R3sacxJYbBe7HgphQUWIvRiHw1byP2XZUD6qCRd6rr999yI
	kTy8/NuDadTTjt5J5MhTboa0NAWCad2SDzEctogjAisI5DVV2xeV+QPTw6i6G37iltk=
X-Received: by 2002:a05:6a20:394a:b0:215:e02f:1eb8 with SMTP id adf61e73a8af0-2390c7db653mr5445649637.14.1752756452621;
        Thu, 17 Jul 2025 05:47:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUK5pLXOx8e0IV+sa+E0Kwv1NKC6QjmytUiIFxW4avHeLfR8OSrOUNYppe6+YPfhe+N/XZgg==
X-Received: by 2002:a05:6a20:394a:b0:215:e02f:1eb8 with SMTP id adf61e73a8af0-2390c7db653mr5445603637.14.1752756452177;
        Thu, 17 Jul 2025 05:47:32 -0700 (PDT)
Received: from [192.168.1.17] ([120.60.63.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9e07facsm16466393b3a.68.2025.07.17.05.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 05:47:31 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: linux-kernel@vger.kernel.org,
        Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Jim Quinlan <jim2101024@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
In-Reply-To: <20250624231923.990361-1-florian.fainelli@broadcom.com>
References: <20250624231923.990361-1-florian.fainelli@broadcom.com>
Subject: Re: [PATCH 0/2] PCI: brcmstb: Trivial changes
Message-Id: <175275644815.7439.10347177721311626088.b4-ty@oss.qualcomm.com>
Date: Thu, 17 Jul 2025 18:17:28 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDExMiBTYWx0ZWRfX+GvphMmobScK
 avE4x2VeovemrxQxLbJWfr1k6ZbdrSk4xji0LvDordijWnEMMdoFPsMe+l4wSlb1NtOKXiVXm/r
 tHGjjOW2YUgLdbNWVJM2oUVTqiTrCnza0FrMqeiEbk6BjUgtwyNHGoV7YS6FBEyV8uoxdH1tfZA
 8cz+ixSnKfuUyIjrl9O4rqPo7VE9WbkydR87feOuZgXSzazE5CgwHXwU5RpIS2vCr416n0cGlZN
 OcE9S7swoHIGIy901wezNlfb5yGt54o9MJnaOwJFYCaPdJTLQQKXjVuLVbNVCK4bxQA90o7/8tR
 9j755Du97e0feJsfKcaf4h6Ih5D0m1i5WlWA+cuX/q5nKRoirCWokshCUUcKa4KrojHPAvsD+sK
 Sz6qd/81j76ga++JHGHPRMNHR83o7ajyzoUOd0gvgl63JSxdmszjqLLbj540UdXXhekVMqbX
X-Proofpoint-GUID: qvyyWmvMPaKLda5Y6LY67jCCIOrWKz8y
X-Proofpoint-ORIG-GUID: qvyyWmvMPaKLda5Y6LY67jCCIOrWKz8y
X-Authority-Analysis: v=2.4 cv=Y+r4sgeN c=1 sm=1 tr=0 ts=6878f0e5 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=A4mJK6/VAfRUM2WLv3bxlg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=kdDjAxzh71lflxr6eakA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=527 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170112


On Tue, 24 Jun 2025 16:19:21 -0700, Florian Fainelli wrote:
> The first patch removes Nicolas from the maintainers list since he has
> not been active and the second patch uses an existing constant rather
> than open code the value.
> 
> Florian Fainelli (2):
>   MAINTAINERS: Drop Nicolas from maintaining pcie-brcmstb
>   PCI: brcmstb: Replace open coded value with PCIE_T_RRS_READY_MS
> 
> [...]

Applied, thanks!

[1/2] MAINTAINERS: Drop Nicolas from maintaining pcie-brcmstb
      commit: fde41f282590b46e96864ae88da2e2c20a967b3a
[2/2] PCI: brcmstb: Replace open coded value with PCIE_T_RRS_READY_MS
      commit: e8e7c1e95d6d4ccdc53654a5966d2183532ab115

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>


