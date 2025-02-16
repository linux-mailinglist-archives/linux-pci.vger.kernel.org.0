Return-Path: <linux-pci+bounces-21554-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B96A3719B
	for <lists+linux-pci@lfdr.de>; Sun, 16 Feb 2025 02:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04A867A39CD
	for <lists+linux-pci@lfdr.de>; Sun, 16 Feb 2025 01:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0245D748F;
	Sun, 16 Feb 2025 01:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IFBbSwP+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EC2A2D
	for <linux-pci@vger.kernel.org>; Sun, 16 Feb 2025 01:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739670338; cv=none; b=KyqItBU66Tw5z42f/yIcdjZflkvpk5yCY9ITYWSxr2Ozxlco5iik4DVHhRUkN/XwBOhZAlFX7Upbj94l6cR8f2QSND6VtrLuxyuQfzlJRwVQaavkwtUF5114/F/fEt+cq/R4rxn4mUD1iv12mHMSvDfxdLOSYLWx3XYeNNnF6ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739670338; c=relaxed/simple;
	bh=6d/C0OzP206Bfx6ax3rRPN3TPah22XiTEZpdfRfQaV0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s976ys9rKlp8qYKbveWhX1aHY2mcsbKKJGV/3Q6+xtNIa6AZ3/UEZwiUTVjHcyjMsDf0EYayrAgbC5idSDxlgbh9MDcbPmmCajF3hrBIRj3BPM61s4DelQdC8e3gPNvk15N0UpHwpVFluliuNtL+/y6kyxArmT2uwFx1vxeLx1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IFBbSwP+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51G0Lqin018651
	for <linux-pci@vger.kernel.org>; Sun, 16 Feb 2025 01:45:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=QChqI6vVHRRW6C7u3A4HFPKyjHOOONIPmTq
	BbAmlM34=; b=IFBbSwP+L+TKBLOwDGTSfMR5We3MsKpzulNpXwSmmpszde/zIOm
	Q8atyutJnYwGXXt5ApAhqftF4z3CgCIRxqaY4ffma2ANRT2wy/VpyT2ARs5t3vJf
	aVQCycsROPe94dL9Dz37E7CF0ZNfPZ5HyD0ICHeO4zWWN9UFkyB5CKQ9oaOSwMnz
	baNoZWcwENPE2huuhp7qJSzqnXVzKMBlg/pZygLUzuDyyJQ6hk1OZUQPJpTq2vrD
	GAdTggzkFcElz/AbFews+Q/PPuLkXeJWxyPayXAPdLyHrnuTWqM3z/VRssjLnUYN
	FMiqu6+jWjsEV2jndKlSmjhAbmhl4uF0MlQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44tktf9b1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sun, 16 Feb 2025 01:45:35 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-220d6018858so52723605ad.2
        for <linux-pci@vger.kernel.org>; Sat, 15 Feb 2025 17:45:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739670334; x=1740275134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QChqI6vVHRRW6C7u3A4HFPKyjHOOONIPmTqBbAmlM34=;
        b=ElzpfRct/5PYElLAxegCfswmtoJ11G/gdAlO8JAwwxUW96NrLrSFk1xovCewInhTKN
         3klNKjR9Sturw5dBmkkSarbD9gXTOGe3GNDmk45FKGgBsWREhtx5czFyfN1kXebvkctk
         QPvA26lO5wQb63UL/SbRejH+5tzc0JOOV6TF5FV1jyD9jBzG4Nm3rNGxsNYCJzW3Exqk
         GwPmQg3r86oU2gAqKgViYYRn6Jcd4u/CNaZDnKDRch/qi9GnaX9RvzuPlbD4oxUMrp4i
         3WMSWMFgHVWcV5VLa77SM+2MaqR4e7+8B7MuKQUjmJc3UaUZRhnW3rmAyh8IFN+9XLjR
         C90Q==
X-Forwarded-Encrypted: i=1; AJvYcCWRPJITkLldQKYfPFNczgcLFbov66Th2t2zS0bCDX/AVyAHNar/K75en5oNFGjvcELmsIuJ34euWU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGC2+PPOUMpsBge9L3MPZuYrc90PfCJaiuJ3P+ao65KWMx5Pjh
	lvqOGqaXpI7U1blDF/vuWavabJr2cWAAJ6d8eGb0mp4HQeslfnrQJCVIY5DOFQMAFQZSA/7ZWgK
	UWAmC2KeF6sp/M6UtmEqmDPswjCs2eZYEKghop2YvmvD8Z238j3aToSBm5ZM=
X-Gm-Gg: ASbGnctF54EQGr4yqs20+T68jxRfmm2nYAnPZFtZV2ogKxj/X9aL4x9Ifw0rHNc8kqa
	V32oW/QQ2y7JPSAqWA33tc81/LmNo5PcbkTqrnaNC+MLn2DmhibO9bMSU25Wgp4j1pjm0UyYZqn
	KMU/HeCJFA6lSCuB/6Tc834Yu8+Q0vMriB9Yj4dw4OB9IrvEDqo2uO4clB0cw0X+q6ACvyLGO+v
	nnaC13RZJl3UbL7jkoZe48cWnGHLfYQDllW+q7+2afq1rEaP8CHWEXLahj0AA7HvxQ+r/dxlGhJ
	HFm0oBjwPXKyh8LE0YAwBY+egwHLjxVjljqthJ2f
X-Received: by 2002:a17:902:fb45:b0:21f:89e5:2704 with SMTP id d9443c01a7336-221040b1427mr59927815ad.34.1739670334385;
        Sat, 15 Feb 2025 17:45:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGk0Wm6pBDN1zI1JP/eN7P464Mszuon80WKDa6iniNlFdMaUXzJp9MDPJ+nFawzsFqmexnMJw==
X-Received: by 2002:a17:902:fb45:b0:21f:89e5:2704 with SMTP id d9443c01a7336-221040b1427mr59927565ad.34.1739670333991;
        Sat, 15 Feb 2025 17:45:33 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d536455esm49896955ad.74.2025.02.15.17.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 17:45:33 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
To: andersson@kernel.org, robh@kernel.org, dmitry.baryshkov@linaro.org,
        manivannan.sadhasivam@linaro.org, krzk@kernel.org, helgaas@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        lpieralisi@kernel.org, kw@linux.com, conor+dt@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree-spec@vger.kernel.org, quic_vbadigan@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH V3 0/2] schemas: pci: bridge: Document PCI L0s & L1 entry delay and N_FTS
Date: Sun, 16 Feb 2025 07:15:08 +0530
Message-Id: <20250216014510.3990613-1-krishna.chundru@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 7hjcTDzGTUbpgHXunSO7sCN5V3rQpoVW
X-Proofpoint-GUID: 7hjcTDzGTUbpgHXunSO7sCN5V3rQpoVW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-15_09,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 impostorscore=0
 priorityscore=1501 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502160014

Some controllers and endpoints provide provision to program the entry
delays of L0s & L1 which will allow the link to enter L0s & L1 more
aggressively to save power.

Per PCIe r6.0, sec 4.2.5.1, during Link training, a PCIe component
captures the N_FTS value it receives.  Per 4.2.5.6, when
transitioning the Link from L0s to L0, it must transmit N_FTS Fast
Training Sequences to enable the receiver to obtain bit and Symbol
lock.

Components may have device-specific ways to configure N_FTS values
to advertise during Link training.  Define an n-fts array with an
entry for each supported data rate.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
changes in v3:-
- Update the description to specfify about entries of the array (rob)
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


