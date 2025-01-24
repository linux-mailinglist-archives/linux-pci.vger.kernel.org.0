Return-Path: <linux-pci+bounces-20326-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 740ACA1B351
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2025 11:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 439C8188E5DC
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2025 10:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69AA21ADC3;
	Fri, 24 Jan 2025 10:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WX6Y35iC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EF221ADB7
	for <linux-pci@vger.kernel.org>; Fri, 24 Jan 2025 10:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737713458; cv=none; b=qG2nnqXbaovc/1hgAbdNV+/+GZ9lrAFh9lY5SH6APD7DXCDmK85c6t74Cayt7T8MDTOr4/BnDoYH6JxYm0H9vrIC21+0rxzLvZJV1TuSd1w39qhzQbZyIT/pPWYkzQ1p/H3R2U8/bOqTkYiTGq2OpClFN8uMxteXrbVA3usdk14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737713458; c=relaxed/simple;
	bh=n8LBnxrDnBbcUXm/xD+VonYiva2MgEDrR8IbQUCoyGs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aeDXAUTMo1rQD2FazcM7bk+JKRI1GRO3I2oihjW/GB+3vu3o3CdHWKfygihn3RmBURf9A/QCzAoBYKbjFjZK6TaT18evxWSiAmvuWwM4UoikQ4Ofj6GXRHLYjNhRORPe+iZYJdGsb6YrjCiEeVS3VmCdJtij9Vz1CiyvQ4wFshw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WX6Y35iC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50O5Nxpq029389
	for <linux-pci@vger.kernel.org>; Fri, 24 Jan 2025 10:10:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=9NBpxVg2cBMC6znT9WBrpS6Wfd6zoznAlFR
	eZfrgsW0=; b=WX6Y35iCRJ8/LvrXYDqlJCfCj7r+rLn8ReP/VSffq4OFX3SwVHe
	bq6e7BWdsF8Whxad1gXrDRpxfJAuGoGj0ASKw+cZTuhOn+/9koP/WfgbWCoi4Orn
	c/scdESldRhWS92qKXsODagUditLe6itiKubJnL4NKB9u8lj5ELhroQxzl8aQLvI
	p8H9QwYAufpbhHXHWogODApmlR+Ipnpip2wDumMcmM/gB0PdmSl8Q9qguZfYoRKt
	5vYs21/oVoqXcz/qopjm21DItjjWvpwIfWiTvNloLLuxbHpQKQLvtY9oZYfvb1fH
	1S3HJb3x/frHGtSZVMwQ50tcxX8Tei3tMeA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44c4p5gqaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 24 Jan 2025 10:10:50 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2166e907b5eso35203965ad.3
        for <linux-pci@vger.kernel.org>; Fri, 24 Jan 2025 02:10:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737713449; x=1738318249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9NBpxVg2cBMC6znT9WBrpS6Wfd6zoznAlFReZfrgsW0=;
        b=hj3FT5XoDqHwZM8CL2j1qeSYjsTqPPXt7+pxsk4LLASO1eJziNSlPo31Q9Aa77lgHZ
         jP63iu/ZfXtpxkMP5TkLMCxVy1Oq6UA45zA6nio5prAi3L2n8AUMRwutvygFzvWeYrgu
         y93soRbZVy+rihdTr6ZEWM3X1i1T0bxDGhgK/oB8bJw8gJN6t17Qef0WlEcgD0XcNFr5
         4w3dMJ5X0TXqJ5ZyOI5DndHTsAzXg0wcYN5YBhaHABGITSxUubkieSQ3X8wSFKwG3tPt
         iNR1Zg4a+E/7Dt+sTwM/d09WC3iEpkw9IIAG8GlYDqjyjOfD8BxohIyydgN0949tmY/i
         eNaw==
X-Forwarded-Encrypted: i=1; AJvYcCWnfz0vIHB+nyE1pklS7HTG5OyVRnwn5ZMaXKSFQfoDAW7pqikIbZ08HwNvDSgzY2K+hrSAtJGIwDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHmMxHt9ZZ8Cx+N2ZRkf1yCTnvVgGI1Hj6LhzsX/ASraMS7Pni
	B/4phRFIP6214kn0D/FLyYHGfvl9qHzB2ojDYubYeVJcCEa/NYTetvpihIQaaQP6LxKSDVo2ExV
	sC2u2aeXBxhXqwh5HTjqQFJc5KkA7hFceCyv8tTRH+mYsApROaV7So70zkSM=
X-Gm-Gg: ASbGncuhpYuXqrqHSTMcz6cufMveJl78N9YDlqyJYCvyIOdKIBzw/Rzi8Hq8fx4gfrO
	sI7hsphW4VwcykF46wLj7YHujjLlZ+H9U1qHXYmccKb6RwdBANpI49wIcoIY/psZL2mxj/4WJ6K
	hQGy2UAVHBp0qDCX202DQXynGkcCbitFwOJVahNWotIThQndpUV11WVgc3tkgFFXmPSqg7IQEsX
	l5fYID0hb052ASzuiq8FsrvFpjUszYb1NyG3FkMiJud4Q0l1sqZp+v7oUeVOKbUXnbJjBfLpQ3l
	c1cWVoKhcOblxx0LS2VoIDDbEL+YFA==
X-Received: by 2002:a17:902:f601:b0:21a:82b7:feab with SMTP id d9443c01a7336-21c35594fd9mr441785625ad.33.1737713448937;
        Fri, 24 Jan 2025 02:10:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGABoegU/H7TpE+0qoZZPoBSDODBsyYLWoLVFOYvGbOKcXuJH6boH3o2G7cWF/3MfuPx8Cbvw==
X-Received: by 2002:a17:902:f601:b0:21a:82b7:feab with SMTP id d9443c01a7336-21c35594fd9mr441785265ad.33.1737713448598;
        Fri, 24 Jan 2025 02:10:48 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da4141dacsm12773825ad.133.2025.01.24.02.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 02:10:48 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
To: andersson@kernel.org, robh@kernel.org, dmitry.baryshkov@linaro.org,
        manivannan.sadhasivam@linaro.org, krzk@kernel.org, helgaas@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        lpieralisi@kernel.org, kw@linux.com, conor+dt@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree-spec@vger.kernel.org, quic_vbadigan@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH V2 0/2] schemas: pci: bridge: Document PCI L0s & L1 entry delay and N_FTS
Date: Fri, 24 Jan 2025 15:40:36 +0530
Message-Id: <20250124101038.3871768-1-krishna.chundru@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: LlG6n_2Tp4ibwZlY5nr8k7PECZkJsLxK
X-Proofpoint-ORIG-GUID: LlG6n_2Tp4ibwZlY5nr8k7PECZkJsLxK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_04,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 spamscore=0 mlxlogscore=999 impostorscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501240072

Some controllers and endpoints provide provision to program the entry
delays of L0s & L1 which will allow the link to enter L0s & L1 more
aggressively to save power.

Per PCIe r6.0, sec 4.2.5.1, during Link training, a PCIe component
captures the N_FTS value it receives.  Per 4.2.5.6, when
transitioning the Link from L0s to L0, it must transmit N_FTS Fast
Training Sequences to enable the receiver to obtain bit and Symbol
lock.

Components may have device-specific ways to configure N_FTS values
to advertise during Link training.  Define an n_fts array with an
entry for each supported data rate.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
changes in v2:-
- Split N_FTS & L1 and L0s entry delay in two patches (bjorn)
- Update the commit text, description (bjorn)

Krishna Chaitanya Chundru (2):
  schemas: pci: bridge: Document PCI L0s & L1 entry delay
  schemas: pci: bridge: Document PCIe N_FTS

 dtschema/schemas/pci/pci-bus-common.yaml | 12 ++++++++++++
 1 file changed, 12 insertions(+)

-- 
2.34.1


