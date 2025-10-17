Return-Path: <linux-pci+bounces-38456-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE496BE86EE
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 13:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5533C1882A61
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 11:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE19332EBA;
	Fri, 17 Oct 2025 11:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O9+czvjN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C224332EA8
	for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 11:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760701264; cv=none; b=GICPlMu1uQi3a1yLL1KYHhNSC9FWoRltIk9uFCFPq8l46S703fcnId3oFuo59O2shTSTeD2eXzFtAWUdEIQhSaAeuLWy+LA6ZevOmzCTR1a4XWcexmYlYywbpWHLntsYUSfj7U9koUPEFjHMHCjMkgDlH/Dw/IgUXFKj+/mUP/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760701264; c=relaxed/simple;
	bh=M6oHNRR5dlFPX5JEy37yFZ5TtRSAw19n5ny/DK3/HhE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cyF7y0PnKnqYRsknNghIjuuQthmOYXDqOC5g8rMu32kfMV3avV7WN7/vfiEUIXMrz3akrWcFY18DanR6rGlX/POv0dyj2apJ4xgAOqCa+CHhx6aMhvlQxPLJWUJiq2MfbFsSa6/FJwS2MlWxccbS7eLEjYSWF5fww8TUzFPq4gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O9+czvjN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H8AZpB006091
	for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 11:41:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=1Dvs+F9iRc/LZxLL9MWhmX
	ciP9znGuKAC6w03W6C6Q4=; b=O9+czvjNiHlvcrEgno6XKkTdpRnRxVKL5XhIPk
	7UQdmGv99WqBP2pKyuWtExxV4d6DX8vAXFTPmYBVmJu4dlF/WF1OSAO+wPms8mki
	FaVlfM9MI9W3YF/jrJ60ZQk7bexgq9co/tkurwpyFzMallKPj5faKlUOkiY8y3GR
	OzDMz1Cmn7/0cAmfZfbCjX5mTCaiU0o2A37/JR8k1lHKaZGLNpUG5fPkCU+vEE4b
	Ov3dd+ZWT4zb2xRMqh5XAOdQLTweffa8HGzTEY53nXEySrt6Fas8WdA786G8Nu40
	zHGTWWUkwunbGCkw/OP+KOpT3o5/P40pv9bI5iNLYGWc3clw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49s6mwxcw2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 11:41:02 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-28a5b8b12bbso40014345ad.2
        for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 04:41:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760701261; x=1761306061;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Dvs+F9iRc/LZxLL9MWhmXciP9znGuKAC6w03W6C6Q4=;
        b=vozfNjpQFGGksA/0RAF1G4EcTp/CYdehCt1J2FrAjyJTmeDo0gZ3FDqbJYo3VVpVCR
         +OKALlHmOWe/EYojO57/eyegSrsShm24X941Q0CEmFA+Mp01NK53XJApUC+XxT83m7P2
         22bsZbs8vJ70k4SzkqMDLVlg11i5CL3upQHo9N3DFn0KeAEPnQRKBxS1bNkBWnu2/QxR
         P05RQlcpWVxo/n7xveMUBC9Xizj1PcNQN3G7ta05TnywSyJhFHMaXCJR4zLjdt3bto6N
         wX/QOdF1z3Bne6Z046quSCFs7M1eQcosn8oBIViVDqdR3AhNB4+LdcK17CUrwy4cimK3
         XDBg==
X-Gm-Message-State: AOJu0YwdzQQkLeLfDpcAhC/bgp+Bxqt+QxtX1jMMuEHMeZXb+UHe/9oS
	sqs5ObGUUwGR0Vvz8LtkWWHfGwE9BbYzrzMfIuxr+yY7rEdQ2xwhEUXECbS1KbMg8MTjZTbqsoY
	fU/it26VIN/DXoRkfeaRVwyEF5zAw3n7e7KD2SSwdutbQ/fORYLNsN8vDuBXN3BE=
X-Gm-Gg: ASbGncuDfUYojoq+L43w6jmTXOBwFLRrL5MMrosigqpDi53tkFXRddbxWVt2gXtsGUU
	hwURdIeU1zLnhmj0Kfu6DG0ZgFGVysjAQaJlTTG6i2VGj1YDd8O1Xmp/lhzBS/a+SiVqorfmYeH
	8FHXLxRd9wV3k8JuYU9/sEMtmMA2bbpz2mreeEoN+vV2/Jo7WROIe6K7MjOHMOYK+3MstsVYQ+B
	kMRu0OJrgzPZvmQHbu3v6Of2jer/iFSf5ljx4ZUbhCT0pKg2cqZlx+J1V3IJbZUVudPayfsuztM
	HNsYbSaBtosZwgZelE6vBC/4yIuBZvdetZHSrVxzonV04gV7GtMBqH/xHcUSbPv2np241fqMB4r
	6zryFcunUOqXWK8d0SAj6WfXWQ+VojUWCMg==
X-Received: by 2002:a17:903:19c3:b0:267:44e6:11d3 with SMTP id d9443c01a7336-290c9d36c03mr39709475ad.21.1760701261420;
        Fri, 17 Oct 2025 04:41:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4oDHAXVAXNMRAmy5dRggblbTIjjpbkAOgElQ9q/OQj2LXAR7K1mSO62iOIN0oWbcWoxYnPQ==
X-Received: by 2002:a17:903:19c3:b0:267:44e6:11d3 with SMTP id d9443c01a7336-290c9d36c03mr39709205ad.21.1760701261008;
        Fri, 17 Oct 2025 04:41:01 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099a7de45sm61489675ad.54.2025.10.17.04.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 04:41:00 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH 0/2] PCI: dwc: Fix ECAM enablement when used with vendor
 drivers
Date: Fri, 17 Oct 2025 17:10:52 +0530
Message-Id: <20251017-ecam_fix-v1-0-f6faa3d0edf3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEUr8mgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA0NT3dTkxNz4tMwKXTMTwxTDFNPUFHPDFCWg8oKiVKAw2Kjo2NpaAPj
 iweZaAAAA
X-Change-ID: 20251015-ecam_fix-641d1d5ed71d
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Ron Economos <re@w6rz.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760701257; l=1150;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=M6oHNRR5dlFPX5JEy37yFZ5TtRSAw19n5ny/DK3/HhE=;
 b=zejePTE4BD0Qu4XAYU3th9wsZhWU9YwDBrfTsCJDr69zR4jht8IGoD0vpvmz/5lBALq8YWqID
 GBYvCIYqzMJDkaeQyjzZvWOFMxy/HpcMPyb1Ufuy1WkNOw6M6561Ps7
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDA4MyBTYWx0ZWRfXwXA0OvzfnzEC
 3yj0kRGFAQh/oq5TZPTwuRra37vuSpBP7QGfRdTBxyFUGBIW1e/bUENTWrY8tVA+4TnDtU4aJUv
 mocovEjhsY4j5ZxdLPplT8/w+YbWkmCa9x/Fd76RepWTSN8mAgbQUyTuDslrgkNwxcwczUWGVvp
 kDCQovuALwlkrxI72mf+lQos6K8mmdlScdNKZlxoNvo9kbZJoGvs0J1MiTCVJKNOEHBFyceb6GV
 /hh+8aAOcfWSKI+49GX8Y0UmQj00c4vxIsxqxTZPMjnE8loYrK/YLw+aTEWanxUN5dWRvjWlpOf
 9LnSVoupZokLOMCNsPBhmRpGkRkyr44Bk8OKCN+CNKFfy6wZvQs0WxcyYupCVJ4KVIDirD7WUX5
 iNI46bfZjuSbPSDhmH91sQHbb+bN8A==
X-Authority-Analysis: v=2.4 cv=Fr4IPmrq c=1 sm=1 tr=0 ts=68f22b4e cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=KRKipztoQesxEaMeAmMA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: -R6v34wxwWDb-Tm_rcobzGskxShnUlNO
X-Proofpoint-ORIG-GUID: -R6v34wxwWDb-Tm_rcobzGskxShnUlNO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130083

This series addresses issues with ECAM enablement in the DesignWare PCIe
host controller when used with vendor drivers that rely on the DBI base
for internal accesses.

The first patch fixes the ECAM logic by introducing a custom PCI ops
implementation that avoids overwriting the DBI base, ensuring compatibility
with vendor drivers that expect a stable DBI address.

The second patch reverts Qualcomm-specific ECAM preparation logic that
is no longer needed due to the updated design.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Krishna Chaitanya Chundru (2):
      PCI: dwc: Fix ECAM enablement when used with vendor drivers
      PCI: dwc: qcom: Revert "PCI: qcom: Prepare for the DWC ECAM enablement"

 drivers/pci/controller/dwc/pcie-designware-host.c | 28 ++++++++--
 drivers/pci/controller/dwc/pcie-qcom.c            | 68 -----------------------
 2 files changed, 24 insertions(+), 72 deletions(-)
---
base-commit: 9b332cece987ee1790b2ed4c989e28162fa47860
change-id: 20251015-ecam_fix-641d1d5ed71d

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


