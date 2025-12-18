Return-Path: <linux-pci+bounces-43244-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE698CCA66A
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 07:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B82B6302F6A4
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 06:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CCA32E6BF;
	Thu, 18 Dec 2025 06:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="llT36KeQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T/KJwd3H"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3660D25DB0D
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 06:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766037623; cv=none; b=uBSVJ0ugkjhuX5GeX7NLC38WKqavNadgHtnRzCKzD7PyxPl/elX936pRQd+P+laWJIPHfks8mYwVGh8yc+IT+VChPZLD5s/5+KvKHyc1AfLzBtQNY0pkXeK6nXYNj6hOw//irL4bAzzGUXe3FvriCK5awGqK8jfVB/ycbrerHSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766037623; c=relaxed/simple;
	bh=cdVj/hRu+voRQi3RJENW2nc0ztKos515StfT43y/03Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qY+28hopNgO3/SyIFKEfMjtLKpG/u2lAWG04BbPIMBZxfJG8cQaz1j60nmkL9+fmiY1Q+a/zYQvhz7kmSBYLRTMRQAygYQDa9DA5BWHgdom+dodUlj/el4fqxDrYPZE/8B+sI/ntHGNVDYGK7CF+c+4o4SFHWnwaktKyimu3mik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=llT36KeQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T/KJwd3H; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BI1YTAv237445
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 06:00:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	r70sXYxDSL8gIqv+vmmF54NbZNT1R75arkAwnxmmKFk=; b=llT36KeQIBT2EvFX
	GShfngyUKyAkfB3q6bqxPAWJ52lwd6qKK74JxDF3O+bX3RcnEBv2EWEbQX/n6uvb
	OiUx/8q4H21cuxd7/lq/RRq7HiFam+Nz9amRGwkxXKYJg/gZAj5b0+9L80+2pMUP
	8Ds+aavaieZVkDnePP8vfKWks9s9H489ry7ivLeGM9dJ4UJQEGM613BV298MiMzL
	NQ2+3nGBVTje7K1A4E35+4+lZxScWEZjaZRdxd8onYVaXzlp6k4ppNoWtxGE05gR
	Y3fwl40HjV2xYCVV9ekjx40PXLk8BvA/Wd7osghpactfKNCXCu7qdOmyuev5Nxxq
	dFRtwQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b44x3h47k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 06:00:20 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-29f13989cd3so8708445ad.1
        for <linux-pci@vger.kernel.org>; Wed, 17 Dec 2025 22:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766037620; x=1766642420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r70sXYxDSL8gIqv+vmmF54NbZNT1R75arkAwnxmmKFk=;
        b=T/KJwd3HMLLDZH7oj7cVSNi4vOGwHIULj+Ov/wqH4xi0ymbIPvQXJJjwogTBnjaCtb
         6DCZMXcG/uhPv8E7WTAjpsqQn1yo3UvCGzSiR91X89ScZLZAwT7iKjeejs4ggfYsJkJx
         Fh0gnAoo1F7zaPdiTFve6Kgc/ox6NMKMkZWIvr8aeInU9McfGA6AaLPoG3keyqk/cGAB
         iRi/sq5SkSGMIIo6uU+e7KN5X93YZ3tvyzWb8LlCDHP3Vr9JuxKInFw6Euj5nt4yIOFA
         NlfW8GuGIDNx8cC7Wv09GZCdlkIIUolzkV+Fiw3PGxb0facSbuNnA6LeLPwcnlS262Mx
         /fUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766037620; x=1766642420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r70sXYxDSL8gIqv+vmmF54NbZNT1R75arkAwnxmmKFk=;
        b=XaWmzelXJUj22zaUBZDzpFrPs+VBERJ0Jpo8tW/KzD+SdlDmdnYAzdK5MQei+8hvL3
         FiGmfeUDFCrwCFqschWYU3lSZvZLhPmdrdHHgBxqjhCDNheAZRYrznNsQecta1Tgt0Px
         p7GluvF4IlNLwGRHfJXUEkEE2dhQywI1SIuHTitmFGgQONvGoO4GgUJo2dDVbUhnkf9l
         A1rXDxYICPKTMcPY9GyJbWUppLe/ktp8lesELiFKhr7wrBwpMjviQU1t1CERwdFcciST
         47rLW5Tc68kxwULZ4Q+88OHVFh2XWW/mdlqk8F2sULIwoJyx5aBogFsCzzHEiYh12j2P
         BmFw==
X-Forwarded-Encrypted: i=1; AJvYcCW4iBKwLlAX0CvOgLnSqm4P/2ZRNZriUXNBDwWI5x880qDc0ApF01qeuxFOqlYR/Jnb9UnaLo65tzw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxq5ASSNWTD+znoV1tqp+zwOpDMGur6MJ1RNWasrSbg7G/gMCL
	GfIyMFayXDOLUW/tlaqh3mL/fR5N9UJ+xmY1Upetr/kuVHSjcMbOu9FkgEcWd22+DZiRW17S16s
	tAThyU2G3ERT/ifbSr484WledP2ZDjmN4dw66cODeO0vL+3ZGT7rDGZbqIAAt3H2lWoJ8ABM=
X-Gm-Gg: AY/fxX4z3fteOMzrN77buTqFgmUelWEHtEmaYucTOkeUeK+UO3+WKQCwo6CBA+Hqy7W
	AsItd8iYdR7lFz3TnjUL9o3YC2CG/XfRKxD/shjcPUuPECBbjr1mF6A0ZAE1BWpsoFpymS3UAdh
	C5tKPfWLpiv49Fxrnu8Wvf6WGyVwopBXcWF4XMWCibvHv0s57C6uj0jXhZPOO5UgXmvLWnYw/HB
	CzQphcOiCcXNsDdTlAYiDK/iyb7JLs/ubTGhS9ef7CQPDgDlfhzzmgztGvbkoPVLG4qeOnb918T
	6dCiLTRYyOp9unIxL/IUCj/JgWVEgqiMXVPrWfTtdaeEHHH0o1F/LAxKaZAUsXHoPbA2KvGA/0g
	=
X-Received: by 2002:a17:902:ecc4:b0:24c:da3b:7376 with SMTP id d9443c01a7336-29f23b6ac14mr191649835ad.26.1766037619624;
        Wed, 17 Dec 2025 22:00:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHcGCY4FbXNgDyk5ejGuwfZbq1WfYH/d3pVJ7pfDiUTTgntkEUJHYiGtFJUG0VcAGS9DkHs5A==
X-Received: by 2002:a17:902:ecc4:b0:24c:da3b:7376 with SMTP id d9443c01a7336-29f23b6ac14mr191649495ad.26.1766037619155;
        Wed, 17 Dec 2025 22:00:19 -0800 (PST)
Received: from work.. ([117.193.213.102])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2d193cfaesm11811745ad.89.2025.12.17.22.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 22:00:18 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Baruch Siach <baruch@tkos.co.il>
Cc: Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org,
        ntb@lists.linux.dev, Frank Li <Frank.Li@nxp.com>,
        Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>
Subject: Re: [PATCH 1/2] Documentation: PCI: endpoint: fix vNTB bind command
Date: Thu, 18 Dec 2025 11:30:09 +0530
Message-ID: <176603753982.14831.5759032053215324311.b4-ty@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <b51c2a69ffdbfa2c359f5cf33f3ad2acc3db87e4.1762154911.git.baruch@tkos.co.il>
References: <b51c2a69ffdbfa2c359f5cf33f3ad2acc3db87e4.1762154911.git.baruch@tkos.co.il>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDA0NiBTYWx0ZWRfXw4bqxkn+CxyT
 DpaZb748Kt8D6xawLZvNflHDqai0/m7j6LUo4cM/gpzKKFGcohU336WROQoV2XuqiFl3JqGtm/A
 fwPN4OADZijjJTik0pFNIrEK5PfK6l6m/o1bmMOhAFPcZ3OrfS0Tyf3FgAfGgs8IaRRI8Iescet
 GQXCXNlhnQsRZBxzG/nXBduTIdrCExLWebbLFfQsXucTcysq7t2WA7NkFEfK0LFcxYPSaofZQT1
 Cv7aViEDR4pf5bVZ61dYqxoQMFP9Tvv+b2HBr/KF85YLuhYLbOHn82XmN2zDMT9kI+sN3Y+V3EZ
 9XYVbXSEPr+G0DMbQmV6GiwH5n0NhqPoa8nzyTA7A+z8hdM23XUD8a7XWUQeZevsZfwoMAkXcUr
 McGuf64dOdNGUn7fFhzkqaGVbe5ovw==
X-Proofpoint-GUID: ztwz3NTCo3HM5wFh29VDBEK5IyB6_9FS
X-Proofpoint-ORIG-GUID: ztwz3NTCo3HM5wFh29VDBEK5IyB6_9FS
X-Authority-Analysis: v=2.4 cv=Zpjg6t7G c=1 sm=1 tr=0 ts=69439874 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=PLOdWElDzbaVVj/XHNhp9A==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=A_WhBnD8GSCFf1a9GOYA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 clxscore=1015 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512180046


On Mon, 03 Nov 2025 09:28:30 +0200, Baruch Siach wrote:
> EP function directory is named pci_epf_vntb as mentioned throughout this
> document.
> 
> 

Squashed the patches together, fixed some more errors and applied, thanks!

[1/2] Documentation: PCI: endpoint: fix vNTB bind command
      commit: 33f4eb34c8cea6246325f2a4b2ef93c207945ef6
[2/2] Documentation: PCI: endpoint: fix section cross reference name
      (no commit info)

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

