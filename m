Return-Path: <linux-pci+bounces-44340-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4800D07CC4
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 09:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5EB9306A0FB
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 08:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCC232143E;
	Fri,  9 Jan 2026 08:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z2nybfWe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IQBEGbti"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F97E32277B
	for <linux-pci@vger.kernel.org>; Fri,  9 Jan 2026 08:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767947031; cv=none; b=syjrJispgucSZvfZS0UMLzK8jzxgAgtqUGTqx3FKEngCBuX7z+FqTKtE92Fm8Wbd7s23h2k6Q9yIoT3Q7qJ3HcO1oRsfcjCbTDtY1vEdzQqAC1Ss0N/mxzhC3YZvlMAKiMmyxJ3iBZn4Xopyp+G7rjGHHNhNZvx5jflSLWQTA7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767947031; c=relaxed/simple;
	bh=t66YcJWYF8gPwItNh7NigabW5H/7TnCgG2Dmp0Vx1QU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MehKXtbQsuOjSUvfYUzRvJVDguCAzqRl9ZBEyyBis+sITZPYe78NXigDPeWad4on/poh95n1cl2Seg6/kNlsVEoyiSZ5NlvfbyTvPv2nw4jOAOTcM3H8GqWwK07xH3ZkUOTfhwwtnGndL684IxSFq+dEwQwDSEncQwUY7uUClBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z2nybfWe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IQBEGbti; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6098Ja2s2330318
	for <linux-pci@vger.kernel.org>; Fri, 9 Jan 2026 08:23:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=l1RinWhaIpVYDZAodAhqec
	8cP+gO7+69Y8nAknHi3lE=; b=Z2nybfWe5BamGb06dhVwrrQeOzYQ/lrW46huZq
	JPxAEy4yoXjItOKeRczbnC11j10G9Wqpx5+9Z7iqJqVYAjXYlmKxMeGP1cc6Kh3v
	euCUPmbZUPtoTgOKHPB136yyvTX8LCISdNPHjZPeEXr7NQjmdPd5VrNKbQtMIMdJ
	egqCcB5N+q95oG3WEXLYTAHT0KRxXVTjNzCyOqRcnZgnzJEs3SZCoJgxuL9mCzQb
	9/Pzh1mBBzQzNG+Qw4kOkcWG0KZGCYkyaEnYLxNM4WcwOJqmUgR2ZJIPxXuGZ27j
	5BrVbufD3Pd/YpPddWz97EHArQfu1WevlZ9CpVD2MXfgXEXQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjfdaakae-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 09 Jan 2026 08:23:40 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34c6e05af6fso4544645a91.1
        for <linux-pci@vger.kernel.org>; Fri, 09 Jan 2026 00:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767947019; x=1768551819; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l1RinWhaIpVYDZAodAhqec8cP+gO7+69Y8nAknHi3lE=;
        b=IQBEGbtiMZ5iSeHyUZw30kXoFE93fm8de590M3UyGEOkG+DlMaynAY2tTHYGNI8pVP
         sZIDFPGXV8rS/Yj+cVih93iBvqKk8hERBumtCJ2zMOJszsGC9ZT7fACzhZimRiAp3K4o
         QRsXydNe1hE32CUw0wdP2sm5IcPl9eG3+8gzbaWbY8PiIIP/5/HERYe5/fahGPKFdm2f
         lBQ+sIiCAAAXEiI1KO8cmwiNEmBRt4oDv5NN5DaQ4w4Nz7s2oHEzoTSPkFfAbFNefETf
         4GAjDPxR5y0y03OKThW3DZm4Xk60OJCv9lrZn4hrQj/Znut8Ixow8I7bi0xG/DS9uU/V
         o2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767947019; x=1768551819;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1RinWhaIpVYDZAodAhqec8cP+gO7+69Y8nAknHi3lE=;
        b=jYIEjMqw5wRE3bZjHK+iay03qaqdfiTSpiBb8ZW59dWqiQCG2rtILNrjiUpBlUrQwJ
         h5aSY0kUq1ULwRHaqeJE3ZhIFhmMxRZ7JW9kA0g6eh3+cFb6zPof9d3I1C3Hz+oQsiOW
         g5Wb5A6L0nkgMm0/LtKMbsFmLtNZMMo9MH6w0QzJl0uyLeEeKehexRx6aGBHpd9QvcP/
         qv1ljV/CGLRHCHrJEeN/981hQCdPz95F/Ryb2lLY1kY/3to/tD0H6CurU5Y07l4Qu8pO
         vrVa4TrZkprHlUUIEYRvVZeXuOiQxqEn0TQRk/2NCJowmElrLc7/MqP4gAhLF1F0zB41
         q5hQ==
X-Gm-Message-State: AOJu0YztI2678J4wMDchBy+A1/TiN06txyEY55Ma1U6yLQa8M/A/9ELa
	ge1C9D9JQDDXGR3rd9yxho0wCPCyaLT/UyD4dBwJYmw9Z4aqgmF3FiGT43eiai2Ys9kVNEcYkV2
	xfMhkbBefSDkRNhewhNCUjqGoA0kCH3Hs2v5O4TO6sHApp36UnmmsPJbJPCebJcE=
X-Gm-Gg: AY/fxX55NCpfsAeVAhzidzWgIjUCDcGtPyjosnDKyOwonRmFxkxxL63pq6ZPGgHUF10
	f/Sxe9Co8KFKqwYBzZkQlRGCswgC6aDRf02vq3AuSJm60HYJMHsXIM/ICtbRbUnzUleOffLLYOU
	lI6tld0cggJFp6EEefU++Hg+69msYd9Iz96SuMMZFxv0SPGpn6nfLYZ+Qw2Wa2BntXj9nbFB+Y7
	3cc7Bx/3jVYaUScs9OtnQyT/tvqmhxBjLWSEUv3EH/BwXGaElKuaONNbZMhVAJIrX3SRqlbhuOL
	xnWdpmyU/6gw7B5vURKf+5ad1n2o51ZEUD7tR+5uBsNziOUPFSCs4VJi3YR0JzL7BmsxOoshtKO
	EBahBE5pCFdi9zrdYnTdS5MAD8d1z0v+fAfYHG1d6q/CG
X-Received: by 2002:a17:90b:1d12:b0:340:e8e9:cc76 with SMTP id 98e67ed59e1d1-34f68c4ff6amr8671917a91.11.1767947019338;
        Fri, 09 Jan 2026 00:23:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCCHCUWquqNdzle7N3tC5J9wvcEsWHZK+EMajpD75goTeki8B22WcNIzWzU4+TQz95gxQ6kg==
X-Received: by 2002:a17:90b:1d12:b0:340:e8e9:cc76 with SMTP id 98e67ed59e1d1-34f68c4ff6amr8671899a91.11.1767947018773;
        Fri, 09 Jan 2026 00:23:38 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5f7b19ebsm9778147a91.3.2026.01.09.00.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 00:23:38 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Fri, 09 Jan 2026 13:53:32 +0530
Subject: [PATCH] PCI: Add ACS quirk for Qualcomm Hamoa & Glymur
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-acs_quirk-v1-1-82adf95a89ae@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAO7YGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQwNL3cTk4vjC0syibF2DNItUC+OUZEsT01QloPqCotS0zAqwWdGxtbU
 A+5Lj8lsAAAA=
X-Change-ID: 20260109-acs_quirk-0f8e83dc945e
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, mani@kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767947016; l=1327;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=t66YcJWYF8gPwItNh7NigabW5H/7TnCgG2Dmp0Vx1QU=;
 b=2zGfbBbxxThGn6mJtkfUAkBy1KHtA2nIA0cJCUsEORf6z8GJp3/Lx6mAf9O+7FjFpUR6yJ+La
 xbJG4+wwXX3CMg0DE9xl39YYrrgR0DdBT/YgGlmdPq1PhxlZqmFG8kN
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=Ue1ciaSN c=1 sm=1 tr=0 ts=6960bb0c cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=4e2BeidDuOQdp-_SO8YA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: -ukMSxUI1GZKOrYwW_6vzjKq2ZDWQCJ8
X-Proofpoint-GUID: -ukMSxUI1GZKOrYwW_6vzjKq2ZDWQCJ8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA1OCBTYWx0ZWRfXydcZVftQk8Fd
 TNpdzW+TKIUWcTBZJfZAIW7bA/hxlESbLaHTfL1TPjLtQVcGUHFKMjO+05yLgNKwNIyvKtkHrsQ
 MQlcOb7fbgZc+WNJEH2Mz98hRlAwgadTZLdCO6MhTXlJIygnsYaRfiPG73cVmRlS297yzWvGX2C
 nKq7nuIRue8Obul1VF4Y593XS50Z/EUhVyiNwuvGqrf2KCsd/9leFh9Lqf8xiatTSSwSaqUwBai
 1x4NKIz/BfK0ZKhN5DGfKA5Rxx4hhfA9n5c81bQyezVgs9uOJKza6hRoaGgFVIYeOAXiOgividP
 BxMdy+F7mGgMDNLz4YTmSHsUTD6PXMUb4F7A7AdETGKx/4uIfL4y/y6fw3UnwE12pcEH3kzLTwI
 JXc9fDQEE5BouzDBzoe321QFB7Y/zoHTCvHOKCtf0TeN/VCpo+YZ9PeBF3tGkMl3gQhCyGQkF4l
 YtUnQIDNiuGryflLbjg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_02,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601090058

The Qualcomm Hamoa & Glymur root ports don't advertise an ACS capability,
but they do provide ACS-like features to disable peer transactions and
validate bus numbers in requests.

So add an ACS quirk for Hamoa & Glymur.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/quirks.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b9c252aa6fe08a864cebe245f5dd7bf41fcc5116..75dee46f474a643cc79d112df1f5a57a9f6b95b1 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5107,6 +5107,10 @@ static const struct pci_dev_acs_enabled {
 	{ PCI_VENDOR_ID_QCOM, 0x0401, pci_quirk_qcom_rp_acs },
 	/* QCOM SA8775P root port */
 	{ PCI_VENDOR_ID_QCOM, 0x0115, pci_quirk_qcom_rp_acs },
+	/* QCOM Hamoa root port */
+	{ PCI_VENDOR_ID_QCOM, 0x0111, pci_quirk_qcom_rp_acs },
+	/* QCOM Glymur root port */
+	{ PCI_VENDOR_ID_QCOM, 0x0120, pci_quirk_qcom_rp_acs },
 	/* HXT SD4800 root ports. The ACS design is same as QCOM QDF2xxx */
 	{ PCI_VENDOR_ID_HXT, 0x0401, pci_quirk_qcom_rp_acs },
 	/* Intel PCH root ports */

---
base-commit: 623fb9912f6af600cda3b6bd166ac738c1115ef4
change-id: 20260109-acs_quirk-0f8e83dc945e

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


