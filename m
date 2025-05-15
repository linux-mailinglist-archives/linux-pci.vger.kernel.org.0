Return-Path: <linux-pci+bounces-27776-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9CAAB8215
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 11:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EEA48C01E1
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 09:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D20D293B69;
	Thu, 15 May 2025 09:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A6h6YO9k"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDDA28E5E6
	for <linux-pci@vger.kernel.org>; Thu, 15 May 2025 09:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747299930; cv=none; b=jH6yld84b7Y1gRgyvMZ1L6xT0BDyQEG2U8pMObVDPoT50bgpytLfaYVw8MQjInRnzR6tcAk4cxrN49ZQ3Vw8MAAGiJgQcVjWIJJ+Q2iVXfpjdD9MSS/dlp1Y9tUWUJw2EpKo8tnPUupjrcYArHq3wc4cokU9ZhAVAKejxqgv1aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747299930; c=relaxed/simple;
	bh=d/o7Mz3sAp8md6UzDFd0xwUYBNcPpwQbc3zYFVW6fsk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aqg6fKuNE8GbyBaQWkV6pIugQnrMq3I2+LfURbT/P4GZ4d+DEA5qCKHFEIWka0NbWVbl7H+i8rR23KSEHlbrdlkm4A1Ic6tYBUyP30i1L8ozRQ/PXngbPAgmeoibAmCo2pTWkP8oEh2ZNEtdj7KLCw7UMZn0qbZ8I2gViI0EMRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A6h6YO9k; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EKok6J015190
	for <linux-pci@vger.kernel.org>; Thu, 15 May 2025 09:05:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=0YoUGwDFzZJBnV+f8ZJ21xbDmwwcBNjqe86
	lZSuKbew=; b=A6h6YO9kEG6PFhPqn2UQS2MlPIOgGgIfWURMZNbMDsJsPMwakAn
	mkR61avif1PXE9zNA5Vzxoutz8Z02s+s5e+jiU31h5uxy4Yt1UosK8eQiH+4MioX
	mdvtQ98XnglIhU+IMIvl7EDxs3tJPdQGXhxbEvXRKv4cGQcio1zfiH01mtdBWqzI
	U9bbp5GYcnx+uadWFmdPNnjwrgAETPeylWgaRRCRw/xX+bufy79Y0uyxoiEOmq2l
	qsd6A9zZUtsBpjc+KPZ7do9rnXr513czMaw/h54ksch9wBGKyjkalZraSgyIPG/Y
	cc4D1upxYxUQugHvLKcSAoUEERl8mxFywyg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcr5f35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 15 May 2025 09:05:27 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7425ba8300aso709626b3a.2
        for <linux-pci@vger.kernel.org>; Thu, 15 May 2025 02:05:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747299926; x=1747904726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0YoUGwDFzZJBnV+f8ZJ21xbDmwwcBNjqe86lZSuKbew=;
        b=oAoRi8ccDyGxzhzUposmfmBoEb3AmRqaj6GzbOoC19WKEpru3Wq3/CkxGBx+YYdZou
         YFSRK4KtdrBXQ15kMqlno2hG0owyWsnQqHFgXJdnuZyEJPba4PuORQHDdenSnX8JBLkM
         NrFmVRYkRhF/nnUW4/yaZiaXBCbd7HjAfUPqCheOzBiTLIKi3DJk32JDQrUJzAZwXD5x
         Fgd0GzDFuZ4TtRXJ36wWBWJc1Tei70HojfWMtAJIIFIwpcoOzskK83i4ZMnTR6LkKuUs
         lnnjCukTi1uM5zxV+DZCSRLMRzW3ZARnoQNPU6+zqi+71ZMyAXvK5QtFrHZ7PDjhafdx
         +m1A==
X-Forwarded-Encrypted: i=1; AJvYcCXyBIlDc6XgtrqqSS9x5MGe9yaZNMHbVtl99+qQJcNpXS2IIuOk3jeM5OvS5DFz/OfVwa3xW8fl7iI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9iEHgXZw6TFtLQ5lFZPagSDuNFNL2H79jOPnLdEpV3uYU35hn
	OX5HOGZP6W/uAkxjDoP0ALNua2ZmKqUy5iqsE9lHoUZeC2qBogTIExEh0NLEEVq2YXEQBiDF3ep
	UgcU98c5PKDMlXIrwLijnF1tbr8GWdUqmYZzGdCQHjxanWOa9xEFh4kgYPpU=
X-Gm-Gg: ASbGnctgk7mYwECxPNFzaubAcRoT/V0DOLfOtRzrxFf4PTi6hFYc+WuNo7tDKQHxUeF
	ph7oJ/ynP1jczjzJJTeiLgnulPfOBfitsUDp8Uprn1SZSpDMCgnG7lVYDAoVh5nu6j89bViQNT/
	XF0ocSK8GKtg0jBtSrIrSkRR9YjZFG/d9OYq4NMpEB1UZkDlBpB9ckMIdun1YjpzuJd6idg9YCh
	ExZnA9zJ8EXQJdcHJmvlVBuj45DkUIRDCzSZQCsqJNzHl8BfWKEHpElRVp6t2RW92xIFfULWOPw
	UvGWJFLHUFNE86/POIQN0F13lS3SBZnga+EHEFWGKdQ7z3c=
X-Received: by 2002:a05:6a00:b4c:b0:73c:b86:b47f with SMTP id d2e1a72fcca58-742984c25damr2428807b3a.4.1747299926109;
        Thu, 15 May 2025 02:05:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCFMufWAFO9NdsfiHbNKngrTVhvlxFVYN/2LnoJXLvaE75D+Kk58BJpsD/u0hFFioSfscu5Q==
X-Received: by 2002:a05:6a00:b4c:b0:73c:b86:b47f with SMTP id d2e1a72fcca58-742984c25damr2428776b3a.4.1747299925720;
        Thu, 15 May 2025 02:05:25 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742944e32a0sm1378000b3a.20.2025.05.15.02.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 02:05:25 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
To: andersson@kernel.org, robh@kernel.org, dmitry.baryshkov@linaro.org,
        manivannan.sadhasivam@linaro.org, krzk@kernel.org, helgaas@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        lpieralisi@kernel.org, kw@linux.com, conor+dt@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree-spec@vger.kernel.org, quic_vbadigan@quicinc.com,
        sherry.sun@nxp.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH] schemas: PCI: Add standard PCIe WAKE# signal
Date: Thu, 15 May 2025 14:35:17 +0530
Message-Id: <20250515090517.3506772-1-krishna.chundru@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: m9jiJYQNQKJH6KbNGMyLFhXK9xQ3iCu4
X-Authority-Analysis: v=2.4 cv=Auju3P9P c=1 sm=1 tr=0 ts=6825ae57 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=aeoR8HoxK4P27VDVSowA:9
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: m9jiJYQNQKJH6KbNGMyLFhXK9xQ3iCu4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDA4NyBTYWx0ZWRfX6zzhjRjt4LWN
 R7tkQTMdMzywQ6ZFXzpJxPe2JDhc7TOVsfKZYy1CHu0h3BSg2jjGFDrYA/EPvUAJDKXK/18Mcf9
 CzldKLO/MCcyNO2f60rL4un/goJm60fgmiap9aS16n5HEsLWrG22V1+0kkNhDnMa6+LyhvGRlIF
 snkSwXxdgdaYOg3qZ/kDMpRTX4SFo4/hQepiUkblUMgul8DAmTr/XhqdmU1Cb+7QHkxPP4Zge5B
 2/wYRiu26AzYxUdZHTZW3tdIb9Rqtl6qvoz8vKWl7rGaW8GjH3m+CsjnHsZMSAV+/X76Bn9hEuK
 /S7oNPTXqzyIqviziuD31krVcnveXV0anVn91Kd+MSP/FS8K5S9M6OFyz2zHTINeOiIHADsKFWp
 HrrhyPo69BuiSdMrXiyaUh8X//bX6C86P3E+DIjOXroRrGEek7psPZpBXc+Iul4sOz2dSpBQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_04,2025-05-14_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 adultscore=0 priorityscore=1501 mlxlogscore=908
 phishscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150087

As per PCIe spec 6, sec 5.3.3.2 document PCI standard WAKE# signal,
which is used to re-establish power and reference clocks to the
components within its domain.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 dtschema/schemas/pci/pci-bus-common.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/dtschema/schemas/pci/pci-bus-common.yaml b/dtschema/schemas/pci/pci-bus-common.yaml
index ca97a00..a39fafc 100644
--- a/dtschema/schemas/pci/pci-bus-common.yaml
+++ b/dtschema/schemas/pci/pci-bus-common.yaml
@@ -142,6 +142,10 @@ properties:
     description: GPIO controlled connection to PERST# signal
     maxItems: 1
 
+  wake-gpios:
+    description: GPIO controlled connection to WAKE# signal
+    maxItems: 1
+
   slot-power-limit-milliwatt:
     description:
       If present, specifies slot power limit in milliwatts.
-- 
2.34.1


