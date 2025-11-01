Return-Path: <linux-pci+bounces-39990-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8005C2771D
	for <lists+linux-pci@lfdr.de>; Sat, 01 Nov 2025 05:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 920FC1B2180B
	for <lists+linux-pci@lfdr.de>; Sat,  1 Nov 2025 04:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D4226B2AD;
	Sat,  1 Nov 2025 03:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cr32YXH2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L6nCXHB0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F498269AEE
	for <linux-pci@vger.kernel.org>; Sat,  1 Nov 2025 03:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761969596; cv=none; b=PsSwho4rfN51oabveQ0EYNsJ2CsQv/uLMlBct7Pct2JS7Ioib49JEddxfs94uASrV68nTD3axadhMNuyXn5ZzoXHZag7LFg7b9V7a7AAjWm0xDMT5t4TfRdKIPhIJZ6MAUqswP0fUKpw88wMjG80FpYPus5pJXLBhAP10BdjiDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761969596; c=relaxed/simple;
	bh=vSnGup2JudH8xVBPFB0jjQrhBAINf0wdJNrLvwKVmwY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ETPgwPKWZX1usdQV/2Hi6XCCttnFFcRlOzERUKnn03LYXy8y7f/Bs5SE/U/VBw1DAKW1rPNe6ZOwv0r+ZkP5Mli6f7u2WNlUG72pR9vUZI7VkkEQT2Sg514GTS4fHyv6vP5Mc6O12Ug853bWYp15S2VQPGI/h/DHvKtl/WjGLyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cr32YXH2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L6nCXHB0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A10KktI216193
	for <linux-pci@vger.kernel.org>; Sat, 1 Nov 2025 03:59:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DkpQEOYIwWUftyRlBH6Rvb7+GGcnx4ZiE6KfmGnzrYw=; b=cr32YXH2Z0/tzkwi
	XUzVIASfAAMuaDUMLlJEROFCMwKVt5btOS6+iNSuB80VUuylsTDStnt5oXaqSA+J
	fPLMYFuDP3GfNyhXZ/FPoPj2wOJ1UaCu+BDOCxaTM73G6xy52i4Os6MXEogR4yu8
	uoB7L2O51Zc4LxchVbQEqdoFV41Sv0QVtcAyX/H37iSSj4eksCLUAfJ4fY9Bd0gm
	tL0CZmXDph6PQFbllNXCSsO8Wk+n9vvXQp3lRAladebYoJ13sNsFDgWgMr+yneGi
	VAlaJ8HbFIF3NScwqEYDN9CKlZ1f7S//5Gw+33Ff5lQlqGybOtFfTaTFDq/AVH7a
	9CS0vw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a57jn08hp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 01 Nov 2025 03:59:54 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b9293cd6abcso737756a12.1
        for <linux-pci@vger.kernel.org>; Fri, 31 Oct 2025 20:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761969593; x=1762574393; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DkpQEOYIwWUftyRlBH6Rvb7+GGcnx4ZiE6KfmGnzrYw=;
        b=L6nCXHB0wapUl+zRSUhOjTWWfZO3g7C79enTl0/nj5CDBe4D8937UEq4z8myDaUTwX
         D2IhUxNLA8BjsJ4Y54bPTsDVnFc+VNsvTep7fqDjzaepUCvpckLUPdNAdlum50ZOdsTJ
         N1h/4iFPCNHxIlFVzqy84lTP4zW06EBCBGdmsUZhGbpMHHpFcCIPwEMOzB2Jc/Cy8nvP
         uTAelUTxghDR/xcEu4ntzIjsg/ilf58FIBz9i2h3PKAr1bzBRPFh4DDnU2vrZQG+wLOO
         Oe7A+22rABfhOTNQ6a2BEa2NjQcCgRI73fmELX8qWg/jEwy4zSn1/kHVPv/3mM5kKqBr
         nwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761969593; x=1762574393;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DkpQEOYIwWUftyRlBH6Rvb7+GGcnx4ZiE6KfmGnzrYw=;
        b=NoMGWKuQja7my7XNe7orZtlxTs6/YR3apCWhgYexLZ9J/UL8TsojHvsud9xpqHjujs
         edoHsetION+PWulSxiFMO0vYuuAwDFtEH0uYg+8aDxDxvrktF9lUYBcDTbvFn2zdJTnS
         m/vr9+Pu9XhF3rXQcXXsGR2PnL6zpUxu7VbtI0OKc1haFAgdcW7KqbJdWZL86OyQc5nv
         07Bm8weUw5yV4heBs3b9PMIFu+FiMIScqBsXj8ZXtuPGVoxsRm51gfP85MojbtVahiU5
         efSk+Lt0Q06BSi0koKRb+IntVbklErFzVNf69tw7pDRcR240XUtdflge7sS63TmeeMr5
         P9Ag==
X-Gm-Message-State: AOJu0YxIRqt1fyhOP1dWU0FCFpeXgxq0LpcQSvyQu0mUIxkbh+kLJOHz
	vdqoCD47n7ZUMm35Dy/vPWGQjsNDeltc6UOqGwIul7/sPAe4aakP6Gqllqp8ybaa65cSEoER6S2
	0vO6Bfg3hh5Qz6NIi2pxJUpVv0jVVoguOpInvTkhWfTPY0E2KeeYCg1srqc4diig=
X-Gm-Gg: ASbGncu1Rt4LzWx6TtAJFA9kXhZrqMQwd+8+p5NTOlvh3l2TkcQekVtFUHmGoxahADg
	mlc8T5i0Xc4iKuH7qJGEF8Q2GHTTvgV/c/dIOZ56qORCeG6y2RBOA8ppgmnfud+O4RuwSqvkNV5
	woXrTwKqq6BcpE1qwr4IbIaPIu246noSzwixK8JSooNCZWWKxDnLGA8Q3JS0RcbT2FB3URkRjTE
	t46780fgxSQ9PBerXicvMwUMKFzeHQZLMn3ScR99r1B0DfXj63ZfNpo9H29d7GPjVHeBbKxw1Mz
	H7TRbLvzypyU+EBAU4f9aFDQ+nmRDOkeEjQG1sXR3/HyHA8jDHgINUYQDoYMIYUW7KUnmFGk2x2
	FVLGvXkYhRwF9YPG5DAWju7r/efVdMIV1Cg==
X-Received: by 2002:a17:902:ea0e:b0:28a:8ae7:4034 with SMTP id d9443c01a7336-2951a3e2049mr73930975ad.25.1761969592998;
        Fri, 31 Oct 2025 20:59:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwCqyKB3mpvsWxxw+JBQzmx/93xx7CP640Eolf60h4FSqH+JAV9+V70iDeHOfwspmHkbDUkw==
X-Received: by 2002:a17:902:ea0e:b0:28a:8ae7:4034 with SMTP id d9443c01a7336-2951a3e2049mr73930735ad.25.1761969592476;
        Fri, 31 Oct 2025 20:59:52 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295268717ffsm41490725ad.2.2025.10.31.20.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 20:59:52 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sat, 01 Nov 2025 09:29:33 +0530
Subject: [PATCH v9 2/7] PCI: Add assert_perst() operation to control PCIe
 PERST#
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251101-tc9563-v9-2-de3429f7787a@oss.qualcomm.com>
References: <20251101-tc9563-v9-0-de3429f7787a@oss.qualcomm.com>
In-Reply-To: <20251101-tc9563-v9-0-de3429f7787a@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761969577; l=1537;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=vSnGup2JudH8xVBPFB0jjQrhBAINf0wdJNrLvwKVmwY=;
 b=gut1hfiDLkSs+kqWQ9M5DWLQy9Nba7OE9UxTj038maNYm6R2rUxuL983XoTMVhFN62jj0tCvo
 EgyDQ/kmYYBC/udv5VPWSYOB8p87FySkLajH5B86xv+INa/e4SkMETm
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=StidKfO0 c=1 sm=1 tr=0 ts=690585ba cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=Ocqi7cVID08-S0eeb-IA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: XGZRN0Ql6np7UTU-eFJE-y0ktnWKPTSO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAzMCBTYWx0ZWRfX/L47kd5x6d/E
 iUreZXPmSRRf+LyFgR3rkRZ0axVAXnDv2vo/WpS+sTQOzY1DwKw2decHejWL9yayFAVh916Fyql
 HiQ1KDCAY1lh2v538tM2z5yPBD0EaDE5dhAo5nMklGUcnLZH0catk096vi9U5yUBQdBXOzSkwzF
 XzNQ0VNvkG+2j/TfzxIuPFvo9jnCb64TYkbzh8PKRE4UcM+MmOXaktXjlNhrlSU7J06OYrR/LB3
 9EKwFB7llq7rih9xdRvVehPMsNMsT3L5ljjp0FdcWkep3Z4zwoivG+VBO35qSW1kNnIp5McRINa
 sgT9WXCJrh6X5Rr8RzGBK89uBzL3Klk7mCPygB9VmOdJS5gl+YOYicMW4PSyUu5HRbXGzRay+oi
 G+U5/vUQhsqvR06OOY4JSNHjVkfCbg==
X-Proofpoint-ORIG-GUID: XGZRN0Ql6np7UTU-eFJE-y0ktnWKPTSO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_08,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 malwarescore=0 impostorscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511010030

Controller driver probes firsts, enables link training and scans the
bus. When the PCI bridge is found, its child DT nodes will be scanned
and pwrctrl devices will be created if needed. By the time pwrctrl
driver probe gets called link training is already enabled by controller
driver.

Certain devices like TC9563 which uses PCI pwrctl framework needs to
configure the device before PCI link is up.

As the controller driver already enables link training as part of
its probe, the moment device is powered on, controller and device
participates in the link training and link can come up immediately
and may not have time to configure the device.

So we need to stop the link training by using assert_perst() by asserting
the PERST# and de-assert the PERST# after device is configured.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 include/linux/pci.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index d1fdf81fbe1e427aecbc951fa3fdf65c20450b05..ed5dac663e96e3a6ad2edffffc9fa8b348d0a677 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -829,6 +829,7 @@ struct pci_ops {
 	void __iomem *(*map_bus)(struct pci_bus *bus, unsigned int devfn, int where);
 	int (*read)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val);
 	int (*write)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val);
+	int (*assert_perst)(struct pci_bus *bus, bool assert);
 };
 
 /*

-- 
2.34.1


