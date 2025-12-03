Return-Path: <linux-pci+bounces-42545-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEAAC9DEA3
	for <lists+linux-pci@lfdr.de>; Wed, 03 Dec 2025 07:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E92FC3496A2
	for <lists+linux-pci@lfdr.de>; Wed,  3 Dec 2025 06:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262BF288C2C;
	Wed,  3 Dec 2025 06:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Kx8idC3J";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OZmoSAZP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B54923EA97
	for <linux-pci@vger.kernel.org>; Wed,  3 Dec 2025 06:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764742830; cv=none; b=mYhH1Qomhf8rlYHlIGTbt8nTiA+BwEzPKydl09oHj9U7ueCpr98Xo0Lf6HkMSnsH9SzisCe7OR5f5exk4Vo0kmgjXNO1KcLw2qLgeFZZMwhUz8xbarPjJUYW6IRwCmV1tPQaO6NoJHlWLbmCmrUTy+VrkDFTxd6BzQ6O3osTUaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764742830; c=relaxed/simple;
	bh=O6VXjYhONpDzeHFKxTbME3vLAhP4zYZw3bePDYIq6j8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BvbaKdbLauwZsMDj6Ibe6WNQmddZpgETxFAvpxj4+WjYBBP6Btqx14xEx1P/qaHWGbUemKFK8yXEqC0V+Ab/IBGGdLF3/YIKPkm2ERNOB0wjullqQVQGJ+NxvHymMIpw3vnLqyl1WvEGcBChTFioB9Za/441WSBAZMeGJxXCHEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Kx8idC3J; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OZmoSAZP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B35l3pD331193
	for <linux-pci@vger.kernel.org>; Wed, 3 Dec 2025 06:20:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=uyzrWmEsvcaw4LvkKJsEXU
	IHPC+49vjLKv0Ts47vC2Y=; b=Kx8idC3Jue2frCINMqTS/86eUo3vC0YEtCu47E
	+P7rLRqeM4njb1Ku3V37UIY05fTQ++IakboWLSsBi7uskjIXuPBF0i4xgdzC5l0t
	7UrAhyKtT4eQevSVgVNQ3aJmMUJebgtbeNjjotcGCbGPxwxxBoVwYSQoCgpRynLg
	9H520nzQ3Oupd9wPe/HlRJ/Kr8lvlEqOITXLrujYc8Vld2QDwTX7gAGCaQXV6tTw
	qLZwiWYMQOj6eRi1+abaJaleeHY8B1xOPzT+Fc3tzQMNMDuFjTqjzOk3+589dZZX
	5+L5bnmXEGsNGWuMW5vbrX95TPw7YyFXO/hzhgMIBa6cWrMg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4at67c1mcf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 03 Dec 2025 06:20:25 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-295fbc7d4abso78007365ad.1
        for <linux-pci@vger.kernel.org>; Tue, 02 Dec 2025 22:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764742825; x=1765347625; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uyzrWmEsvcaw4LvkKJsEXUIHPC+49vjLKv0Ts47vC2Y=;
        b=OZmoSAZPJsbSNZQth0S1yQWRE+e1muxWyWZa9JG4IvO23ES5ceLrTgcrpORhowuHlY
         MM3jsv22zWfOKk8I/urRrGBGeqcMd8rPyRejp4mX3bvIHHrqdK2T8QN8ksitoOQ0huUF
         Y9rnURbg8+/b7v2EYHYS6b96+e7GdYnTyH3vefZK4OOnRBfofKrUPbVYQlMA+QViZq+/
         bR2XGnl8+5whk9zc8QTSS4qSUYb6YFc/0s05uMnmG0w0PzUW9j+h/9tFkhPvxzKSg2YR
         7lvZnnR+Ir+5Qf2zGub40pCTdBVwZspgCqXc4Cm0TjXT3TiExEYG9W5z+c4dSgO+6f5l
         Ldew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764742825; x=1765347625;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uyzrWmEsvcaw4LvkKJsEXUIHPC+49vjLKv0Ts47vC2Y=;
        b=F4dSDyddX5OKuMSzhVcY/6y77PCj0fD1OEX6gH+hppapXLcmeDw/R+y4S3ZH4kwVIm
         KfyLiBfQT/VI+emy0U0Rb8QU3LpJqQcurtBYHN3jhJojQSbLCY1HxOkJbeJ7OOsYJOX0
         DtvKgjo1AORQ1c7EAmq/BwTWEN1kj4/taEwr47+8j/r2spLerxBB/Jvhi60QaiTpduGj
         s4bz5v7beRbsGXOKH+4nq4zbXXj9Sjxhsq2xxNx8Z+x/n8Jx4iHPu4g2ad4vq5SK20gp
         g15JrIGRvp/i/dpsp4rp7gIa8QeP8287uscu1KkFYcVqGANeHRMYqz/gqI0rDZHkE2+P
         vUXQ==
X-Gm-Message-State: AOJu0Yw4y8OcgYPjDN9CeZBUYBVh48KDn9snYDHBkC6MiF+lk1EJrApI
	VrLgDVZJJEeP4RYu51muI805OeB1O9iw5xZ1XdJX8PBKOcNKynWE2QQeWDVc52d1xJsA9q78K/j
	dL3SbO9DShHRCZum8QAILTfyn67th8qCVo3xnrlDxxZiMtV4zQli2G4B3u/OxKs8=
X-Gm-Gg: ASbGncuJg+isJUR9TXEFv4UoS1Q9c3xZYQFaxMfLctQ/DtiesHL/R9mT+1kV8YYiIpp
	Ibk3g5VpbjIr7bp6gLtDWyATPA55zrl0J+5/kmTa5wiq+ElmZDw4wKmXCHpIjHUig7p+iNPqj2L
	mb9gwL2UJDem8oajFAN4gRghuokwzKhrsurxIIxCYPiA8oK47FwJtb/NZ4f069WIGKmy6s+CTRC
	BzmuTKNB2mJSVgkHAZQASIhdH8wphg+JTbu7VBAto8cWru532qX6jU0RMOZ3iQhs9Oj3SPhlbjr
	28dxqclih5NqAh8UscBZTzpg14LUAqmCkfgCW3P63RGtZHKJ8iQbWyWJ3ZLvi/AKZRewPc4NBtP
	LlMBmu35H7j6/uLmqEk2KFmsqAkkQdG3cXmCB+fzS4r0/
X-Received: by 2002:a17:902:ce09:b0:250:1c22:e78 with SMTP id d9443c01a7336-29d682bd7a9mr16751405ad.1.1764742825063;
        Tue, 02 Dec 2025 22:20:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJyL5nhaIRoacNGDcQQ0qUgdJEwdvY7apkPBlkWmgG0wCnwygqaNMZwqJk48YBkmW6QtxMMg==
X-Received: by 2002:a17:902:ce09:b0:250:1c22:e78 with SMTP id d9443c01a7336-29d682bd7a9mr16751175ad.1.1764742824590;
        Tue, 02 Dec 2025 22:20:24 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb4026bsm174263015ad.71.2025.12.02.22.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 22:20:24 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH 0/2] PCI: dwc: Fix missing iATU setup when ECAM is enabled
Date: Wed, 03 Dec 2025 11:50:13 +0530
Message-Id: <20251203-ecam_io_fix-v1-0-5cc3d3769c18@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ3WL2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDIwNj3dTkxNz4zPz4tMwKXbNUAzODtNTkFOMkCyWgjoKiVKAw2LTo2Np
 aAGpIy+tdAAAA
X-Change-ID: 20251203-ecam_io_fix-6e060fecd3b8
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, macro@orcam.me.uk,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764742821; l=1260;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=O6VXjYhONpDzeHFKxTbME3vLAhP4zYZw3bePDYIq6j8=;
 b=n1+i8oCdi0pTfHhqwG1mvIznX0nXhoGf4DP+av3oR20Z/6hnaakf2DhiE57Gl6OWOVUzkP7KI
 zosdOMK9djFBZezNlQqEU0YVWgZzbDTnoV/Hso+DQsJK4IiySvtNxu+
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: HC9qa-yjbXwbqmcyhZc5jQO4_I4TwJHI
X-Authority-Analysis: v=2.4 cv=W/c1lBWk c=1 sm=1 tr=0 ts=692fd6a9 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=KRKipztoQesxEaMeAmMA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: HC9qa-yjbXwbqmcyhZc5jQO4_I4TwJHI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDA0NyBTYWx0ZWRfX6GTllSElmJ+l
 eVAlYdgZ+i/slMM8h7ZOjTBQ/OwaF2PWksbtmqrZVTj2iDpxe477MibasuU70CZdqnLYaOLxI9m
 6rJtNXrPYtAJJFpygysbUwb1HMjziZmLBK8+4LK7gqyiV0KaaLeGKOz1q9MrBnlb5Q8u7a+VXOY
 ylgS6iJ+P4ElxpQQIQ2TwCNcslhrvRa+tEADb1X+NUvDvvzQ15neatvNgBcTluJ8c8awkF4kblf
 zAo/TSH+kI7YE+e1hbdwpvzM2Naix6lbZQJ0yLq7wqT+YrRnwJqhHnP9XpPPyx1B5Wrmn3lnqa7
 8QMBh1hp2xnYw62gsb/dhtDd1DnPgU9VSVBU9HH3w7n8r27A4s5KdZ1baNd/CZ5nV97yNwRk9Xa
 fonZCrVjxUoJc7Uv0pB18KnU2dHwEQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512030047

When ECAM is enabled, the driver skipped calling dw_pcie_iatu_setup()
before configuring ECAM iATU entries. This left IO and MEM outbound
windows unprogrammed, resulting in broken IO transactions. Additionally,
dw_pcie_config_ecam_iatu() was only called during host initialization,
so ECAM-related iATU entries were not restored after suspend/resume,
leading to failures in configuration space access.

To resolve these issues, the ECAM iATU configuration is moved into
dw_pcie_setup_rc(). At the same time, dw_pcie_iatu_setup() is invoked
when ECAM is enabled.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Krishna Chaitanya Chundru (2):
      PCI: dwc: Correct iATU index increment for MSG TLP region
      PCI: dwc: Fix missing iATU setup when ECAM is enabled

 drivers/pci/controller/dwc/pcie-designware-host.c | 37 ++++++++++++++---------
 drivers/pci/controller/dwc/pcie-designware.c      |  3 ++
 drivers/pci/controller/dwc/pcie-designware.h      |  2 +-
 3 files changed, 26 insertions(+), 16 deletions(-)
---
base-commit: 3f9f0252130e7dd60d41be0802bf58f6471c691d
change-id: 20251203-ecam_io_fix-6e060fecd3b8

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


