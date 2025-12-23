Return-Path: <linux-pci+bounces-43589-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1179BCD95B2
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 13:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2139A301FA68
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 12:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3816BA34;
	Tue, 23 Dec 2025 12:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IjOkuFb6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DrzaGE8Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB0832860B
	for <linux-pci@vger.kernel.org>; Tue, 23 Dec 2025 12:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766494129; cv=none; b=ixZfECrTLWKIU8Ajy4bfAYIs7BFteDwakIH8lviAhdSfGRoGKU2Hrnc2GU4tGW24yrVOPecn45yBkgIOxK6HvemA2cGt0PyzGcfc8nG2DH4fJm9oYr+GGWWBuJfFMvNIPOTw8qydRguJ5AePd80fRYRSexjbsqUtLjw4oOVwv8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766494129; c=relaxed/simple;
	bh=i59QBVjcipThG8DPnC9H8UaFM7mf6swYhObM6DGBW4Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=i/DI4/LUc3OdfhLXDHL9kHfNLJnS2YrsGAJCSZr3Z/3A6ykqHi6YlubaHK21Jp1hcjMqStzMPxhpfUAEWNzmNeQwXO8wbF5Dj4lXy2IOrSgGvVQ8MoMHVMetxIyg5IEioOiCeiujNl8+6K6UB5IC5kJ0NO456zkE5GQXSY318OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IjOkuFb6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DrzaGE8Q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BN9uY7N1530068
	for <linux-pci@vger.kernel.org>; Tue, 23 Dec 2025 12:48:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VpdOzjVXXo3ABXz2GAYCU15x+ZuTtI8ZVsD3AfJvyfo=; b=IjOkuFb6Hd9Bm2lF
	Tx/CjUBLnLjHnlr1iSdnrGWhbjFmroGVoRtje0NDq6O7O3VzB6z1HppO6kmHP4LJ
	bVt594axA0kQ9SvzXyizUby2zwKZa3nTfd0OyproWavPFn0+KgRtewYske2dYYYa
	kihm5XTTi+iQ6nFXy/bav3JAB3M9W6TBdX7tY9VILo/pBAH2pZbTcEoEtWiAhJMp
	AKQLb3/b9NUysOcg0mx3EMjXuy2r+XefoZpEyUH7zK23SFGX0bsyOrnWRQKtcScP
	8buJIYz/YNo5b1OZLMe+C9JbR37zY5s5X1phCpbOYxEsmQNDWFeVPQvHltJjgsLV
	BFUmBQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b758y3xqy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 23 Dec 2025 12:48:45 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-29f1f69eec6so61807905ad.1
        for <linux-pci@vger.kernel.org>; Tue, 23 Dec 2025 04:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766494125; x=1767098925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VpdOzjVXXo3ABXz2GAYCU15x+ZuTtI8ZVsD3AfJvyfo=;
        b=DrzaGE8QWg/0Gh5/I1ng1cb0YAMEnvM9eTA8BmULTh0zU5nTJ1G0GkE6r7jwdVg8qq
         /+MpiY7YsYXDH/Q+GX2BlI6hKHohJsI67dRSyCvXBirwLxl1m/iyX5HbKGr7V7q2cmmT
         flmhjV82h+z79l4ERc29ONPxtPfqiBHuX33LieZe+5nFnutmr/oYyFzpmNSTmpYRsxF4
         woIFzHs3JMGpOEshrhQ5CqpCgUXpPnjMHOsJJjm1u/ol9W/e/qy7m2G9DEXdeyLDeoOA
         Hk0IMcOqxNCo9BtKAI6UsTiVQiEEt3nOtPt5GnWxCOpIPoGX/Adw43qAUHdumwudHdUs
         gPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766494125; x=1767098925;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VpdOzjVXXo3ABXz2GAYCU15x+ZuTtI8ZVsD3AfJvyfo=;
        b=YxPoyApTeYpV3zMLORvH3oHVRF7liwyZOWRQepssyB+UajR9D7sjubKjlO7v+4cj+E
         FrZa5O4bRmyO+JChNyZobqfWMI/p9ujfH+yDjdf8eJYCcp1q30G7yZ61zoyihKagOFhQ
         14ThwoGpepU0x9HApqVXJ8xOI/RqKgqPFKjulLfTtpZjlsI3LNvJ9kYQz5lYa4cczA6v
         lSqK0VpQgJVgFnIdcX/pIb28dIqB4nqGse4grvCKTjspcyXoeuc6xrt2AtqzInUBmpei
         e+rCiGQrkXVUERV0JJXjeE4NLn2w9zTJSj6TfqPI70Z05I948e8M5i3AjARM0QPW/trr
         yniA==
X-Gm-Message-State: AOJu0YxktReWgS2jAdpQsH/s2u/bJtOi9FNAh6324zxLldBhPAI5VFe5
	mlYXbHPvIQX+qYEkIxt2SXJlDDVrXMKrqiGxDBeObVaZwNQsW9VfMBQywRES/tzndL5w1g6dH9v
	7HyuqQy8fV0s5UHv7NVHsVhq8VRj7K/td2Zh/GN1QM7S6z627eyXmq/GEzvCF0AE=
X-Gm-Gg: AY/fxX67BGnWXD57b/Xm+FXy1jW/WyMG8cQMB82pqVWJlA3TO7mZTZsJEEbxl7EDDxo
	TxfqafUgvcXM+EChQXHxqD/hBa/B+KJrlrNrE+Kchhyio1g671ywP0wEv84jizjSPfsfBaa2j5v
	CZ8rBMXnO4AqYesovEJvKHq5y86SxjJVOmR1gq73fehaQeCjD06zC+uGcFMMOVgBtCC7DUPKCnE
	6AyE3LosuQhaBVehRMr/oPC3ikW3pAqyRGvPm04iImMK4MFk1Qo9bL5DrxMU4RU/18S5Qv3FkAJ
	XsXcLzte/1Qpp5JqT8gs8kYiOkapW9l5fFTMcb091CjHVJuWIhQxRgXGI7v5LixNNWl8NCJOJlb
	Bg70u+PKQ
X-Received: by 2002:a17:903:b8b:b0:2a1:243:94a8 with SMTP id d9443c01a7336-2a2f2a4f102mr148061965ad.49.1766494124673;
        Tue, 23 Dec 2025 04:48:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8YWs/Lrk8D8Qax6Yg5cm74s9TOxV44XYaEydl2Aosk2GGRg9fclJgfKsjM+Tlt+pRR6geZw==
X-Received: by 2002:a17:903:b8b:b0:2a1:243:94a8 with SMTP id d9443c01a7336-2a2f2a4f102mr148061735ad.49.1766494124140;
        Tue, 23 Dec 2025 04:48:44 -0800 (PST)
Received: from [192.168.1.102] ([120.60.139.28])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a322d76a19sm80283965ad.101.2025.12.23.04.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 04:48:43 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, macro@orcam.me.uk,
        stable@vger.kernel.org
In-Reply-To: <20251203-ecam_io_fix-v1-0-5cc3d3769c18@oss.qualcomm.com>
References: <20251203-ecam_io_fix-v1-0-5cc3d3769c18@oss.qualcomm.com>
Subject: Re: [PATCH 0/2] PCI: dwc: Fix missing iATU setup when ECAM is
 enabled
Message-Id: <176649412094.525930.11885393958582645087.b4-ty@kernel.org>
Date: Tue, 23 Dec 2025 18:18:40 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=TOdIilla c=1 sm=1 tr=0 ts=694a8fad cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=wbxd9xFQoh2bOL7BUxlcyw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=dOtSmj_QbqaLots3hlYA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: 57C2zwVEoXo_dbfI7r8xp7jZ9ALMizmR
X-Proofpoint-GUID: 57C2zwVEoXo_dbfI7r8xp7jZ9ALMizmR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIzMDEwNCBTYWx0ZWRfX4EJ42eaeCkpl
 tNbzQDw09l416s/qiJacT+UUwAK2xvy7iSlQyxpeOt5WKYoA4QJtTfaOerQDQ8ZEPoCJPXN2IQZ
 h06qHWl+PYe9y/8/crMKdXSq0vTanwSMceaDsIX14P7pLprWBsR1XH8UfqPAuKL8uGdB5dUaZ/9
 KWDa1kKKCUeGiIUV8ZBalqQIToitqx0me5efMSfnEa0nRqwnf2uC4y4SBebbvwjypG8DJxy9cig
 4V31Fo7bbJxr2K9KkKe8Ps1iO2QQ/HC7kYGMczEXkp35rDI0Rx4z74sbvgoj4Yjb/mRxmisHHns
 gTJJYuNG99ykS/6BxJUQ4sdFCMzwPcATR1BiIJOEHnJ41BfMaWG/1xzUq6K48Kb4bdyiWFaLkW/
 NGHqoiUq2ql04AnVUmpGwqlsdOEbxb9xg1uUtiPsREYmc1BQ+0Fi0sHkTOpudpUuyoyrydXwmZl
 DJuLhvecGMSRxZm0/2w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-23_03,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512230104


On Wed, 03 Dec 2025 11:50:13 +0530, Krishna Chaitanya Chundru wrote:
> When ECAM is enabled, the driver skipped calling dw_pcie_iatu_setup()
> before configuring ECAM iATU entries. This left IO and MEM outbound
> windows unprogrammed, resulting in broken IO transactions. Additionally,
> dw_pcie_config_ecam_iatu() was only called during host initialization,
> so ECAM-related iATU entries were not restored after suspend/resume,
> leading to failures in configuration space access.
> 
> [...]

Applied, thanks!

[1/2] PCI: dwc: Correct iATU index increment for MSG TLP region
      commit: 3c364c9b96f1a0629a29363cdc6239c1ad2f68ad
[2/2] PCI: dwc: Fix missing iATU setup when ECAM is enabled
      commit: 37781eb814e16c75abb78dec2f9412d2e4d88298

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


