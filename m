Return-Path: <linux-pci+bounces-29208-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B6FAD1BE0
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 12:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CB18188CF61
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 10:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3492580FF;
	Mon,  9 Jun 2025 10:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E9zComcs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E712561AE
	for <linux-pci@vger.kernel.org>; Mon,  9 Jun 2025 10:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749466320; cv=none; b=YRTlVu3A4Vb/ub4Qn9dLrVtuFaUOyDeGSQJfpQHEwIMKIfRYr4ngXmQMuUQayyKjhNa/mBHWemMWYdbotEHxmF8GqWBKCHu2gR6ESCvCpeblGKnzHxixLw82KsVI8wF/PrZZNvs4GtL77LiQEP2JU8tNjGRnx6m2T8ysCnOBipQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749466320; c=relaxed/simple;
	bh=a92PRGNUNrfHcs8KDpNTetPfxsdyIy5osxzi+vJe1No=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D7yZkGRYJ91KJQaLQxnRsyczgsbZEbOU4g6KYPN/yfS18ON129SLW0ic3DuH1OjAyk/9CoPET2vHOoDPeE17EZLYGAXe9ar2wptY3jdfZpScrc5A4neWIEAiE+V+uYwcew7HJyWGnwx9X0V/VoRdi0tV3avZRAWGQzr92T0VRFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E9zComcs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5598OxWI000796
	for <linux-pci@vger.kernel.org>; Mon, 9 Jun 2025 10:51:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+WnB7SCx1sSjpKFGf2TGgRqSA56lOzErLbFukBFtOrU=; b=E9zComcsbVuP74kv
	F5FxwcDfUY71bl5ezAMP2a7SDHlkQbj0b6ztptvsN923Z4XT4H6WM65AmGIMtzko
	BsxU/+SLLgOXmpEc2fMYm2eZbJXHoT6tEPpd0Tk4C0w33eDGqyYkiH56z7cyJq6e
	0DwtndcFJmu7q2UajswYtNjTJNkcpeblZpvgZLKVQ1WDyXCWQNMMxlYcNSs03iFS
	q2g+lsq/R3b6SuwHfVe0XJ73bSlLHqHw08Hvv6u9inmKX21juutSNLaWfxcY4Pmv
	y1Gg5Ar31tsnA/ktW4UraRZ4N8ulSlP8Yu2H07H+JcFis7rBatmIp3C9Dl9sz/I1
	9oBWiw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 475v2t8g31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 09 Jun 2025 10:51:56 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-23592f5fcb0so66526015ad.3
        for <linux-pci@vger.kernel.org>; Mon, 09 Jun 2025 03:51:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749466315; x=1750071115;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+WnB7SCx1sSjpKFGf2TGgRqSA56lOzErLbFukBFtOrU=;
        b=R8o+JLOql0Hx/VrbfptFBr6a30u/8cWyUXHDg6TRKUrRJZ7DLjh0IpnwcFxVd+8fnC
         0bFDVU26bLF5vVMl2RawrJjJGemS5tPHno9RR73HoIWZbtjplouUBIGplOO8mzY26dlS
         9T2Iv5diGTN7TXt7bF0tRF4UDsfpnKh6lBcS8Z5l2mYS0fW4CobYCRSH+P3J+Yq26JbZ
         WSdvWbyQrp943Oma5G3WhPk1c90iLEb6HTNu2rzxi9RVriqdiTZqtZDKD1Uua4wU23JY
         JUSF1LtZDwSM0EXV6EiotW2y6EYpxYk0BwX1oubd9cR6Wp+h8Lv8/+/SY8fU8RU786h4
         LNkA==
X-Gm-Message-State: AOJu0YyBMFB5P9dMWfLCv1moUgtIhVieV3W6K/HpvS4CU3yrq61iVSvq
	eqUCQuumuhNlAuJQ9f+6tT3oNWzwKxC8TFM0S11mqq5JvLAcSurIDSgmQmRdcW36UWiVfexNuEX
	9Ox86yfCflu487InX47H2m5nyS1CjdmltUVmcW/PBFgnfsmaxcj7+EXpooy0dXIx/TKpLOyU=
X-Gm-Gg: ASbGnctpjwhxyBF7Dy0VSvpyXyHLTzh6Y08E0GSW7Bkbb9jVpLiMnQRBY9D+3VszyHh
	liOlIbgGIr5yY9zyzhRRFCee/3KzMGvlbe/7v9BS2GMGUVTcTvD2gs78us+D91jo0VZ7licnyl8
	NsH3wqb69h9Wtv5WjE+4ss0tt3IXm1Ew0tacPTBnAGqfmAUqCaKmIWrB+70Bt7MVgvuUQqjZ8pK
	EWK1WqahM+biRsg0ULMWd5edacAP79MI9Y2tL+8NpYJUSHWTDJ7E1K2pZoG1EnuV3GjV5K+V8Bx
	BCRaV+D0t8lC/c3M8nu6p4OSZRkegmEShuy9rwX0NDLahRklAx8N68bAOg==
X-Received: by 2002:a17:902:ced0:b0:224:24d3:6103 with SMTP id d9443c01a7336-23601d7129bmr193945955ad.35.1749466315159;
        Mon, 09 Jun 2025 03:51:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZzNGiSveCaXAGmwtao4h3zyuFCWnr+dvJQS7X9x0EspRwQDlYIe+sfocOUBtwpZVbvfenNw==
X-Received: by 2002:a17:902:ced0:b0:224:24d3:6103 with SMTP id d9443c01a7336-23601d7129bmr193945685ad.35.1749466314751;
        Mon, 09 Jun 2025 03:51:54 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603092f44sm51836465ad.63.2025.06.09.03.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 03:51:54 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 09 Jun 2025 16:21:24 +0530
Subject: [PATCH v4 03/11] bus: mhi: host: Add support to read MHI
 capabilities
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250609-mhi_bw_up-v4-3-3faa8fe92b05@qti.qualcomm.com>
References: <20250609-mhi_bw_up-v4-0-3faa8fe92b05@qti.qualcomm.com>
In-Reply-To: <20250609-mhi_bw_up-v4-0-3faa8fe92b05@qti.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Manivannan Sadhasivam <mani@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        qiang.yu@oss.qualcomm.com, quic_vbadigan@quicinc.com,
        quic_vpernami@quicinc.com, quic_mrana@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749466291; l=3193;
 i=krichai@qti.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=YHDxvxn32l4GiIqpkw0a5BDQyd01kwaHJ7Ari+cyZhw=;
 b=DP+yy3+lpPTfsiVUb0XvmLVgjM8De6zxu8hdMbo96oYzwD6QES2VKKMQTmLaH1CE6MUJzipa+
 DTAoju4J5e6DK6smrc+9F8YhHpnmnbR7S5Yt6qFi2oNVysn4xALurSH
X-Developer-Key: i=krichai@qti.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: GRS9l25CfM7OESzE-oS172EgCA35Vd1C
X-Authority-Analysis: v=2.4 cv=GoxC+l1C c=1 sm=1 tr=0 ts=6846bccc cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=CnzCB1l8zP_khqs2e6IA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: GRS9l25CfM7OESzE-oS172EgCA35Vd1C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDA4MiBTYWx0ZWRfX75+lccbkZfZF
 kI7e0CX2oGnz9nhsKIz+B7WtSg8/pVdwVNqIyaWgMIPzrJ1m5Vb6NOCf+z2YcVLg2Boz2wTxOIt
 hVDT4QDaehdl2DVw7aj2gzKMvZ1GM+YcHVJwrHQXvn2NrfQirY9BHeEkJXZn91vxd/x1HUtIdNK
 YLfCB0oP8UbSkui/Oa9kMBaishkrOtk/GJmtAKFyIPj3sPjsGm4S5fXRh9SgIxtcWEMg8wymZ02
 2TFvE/WHlAZbXAoC/QsGPGOKOEIDs0t/Px5seA0U5JCRp9AGDeVs620IMDiDsybNJoDV+dQ3gw0
 E1tAfvbBX1aQtiuNpV0QD43BXKW73hG09L+I57fACaRfwHzlwCWRphWebF5DLdR+OKVAdeAbc3y
 grJDpkBH07xBlMg32FYSLt9VtsY80VhHwZOf2FG2PhrdSzYCf18Z9+fSwYOslupZMjj/SXqd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_04,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 adultscore=0 impostorscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506090082

From: Vivek Pernamitta <quic_vpernami@quicinc.com>

As per MHI spec v1.2,sec 6.6, MHI has capability registers which are
located after the ERDB array. The location of this group of registers is
indicated by the MISCOFF register. Each capability has a capability ID to
determine which functionality is supported and each capability will point
to the next capability supported.

Add a basic function to read those capabilities offsets.

Signed-off-by: Vivek Pernamitta <quic_vpernami@quicinc.com>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/bus/mhi/common.h    | 13 +++++++++++++
 drivers/bus/mhi/host/init.c | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/bus/mhi/common.h b/drivers/bus/mhi/common.h
index dda340aaed95a5573a2ec776ca712e11a1ed0b52..58f27c6ba63e3e6fa28ca48d6d1065684ed6e1dd 100644
--- a/drivers/bus/mhi/common.h
+++ b/drivers/bus/mhi/common.h
@@ -16,6 +16,7 @@
 #define MHICFG				0x10
 #define CHDBOFF				0x18
 #define ERDBOFF				0x20
+#define MISCOFF				0x24
 #define BHIOFF				0x28
 #define BHIEOFF				0x2c
 #define DEBUGOFF			0x30
@@ -113,6 +114,9 @@
 #define MHISTATUS_MHISTATE_MASK		GENMASK(15, 8)
 #define MHISTATUS_SYSERR_MASK		BIT(2)
 #define MHISTATUS_READY_MASK		BIT(0)
+#define MISC_CAP_MASK			GENMASK(31, 0)
+#define CAP_CAPID_MASK			GENMASK(31, 24)
+#define CAP_NEXT_CAP_MASK		GENMASK(23, 12)
 
 /* Command Ring Element macros */
 /* No operation command */
@@ -204,6 +208,15 @@
 #define MHI_RSCTRE_DATA_DWORD1		cpu_to_le32(FIELD_PREP(GENMASK(23, 16), \
 							       MHI_PKT_TYPE_COALESCING))
 
+enum mhi_capability_type {
+	MHI_CAP_ID_INTX = 0x1,
+	MHI_CAP_ID_TIME_SYNC = 0x2,
+	MHI_CAP_ID_BW_SCALE = 0x3,
+	MHI_CAP_ID_TSC_TIME_SYNC = 0x4,
+	MHI_CAP_ID_MAX_TRB_LEN = 0x5,
+	MHI_CAP_ID_MAX,
+};
+
 enum mhi_pkt_type {
 	MHI_PKT_TYPE_INVALID = 0x0,
 	MHI_PKT_TYPE_NOOP_CMD = 0x1,
diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
index 13e7a55f54ff45b83b3f18b97e2cdd83d4836fe3..9102ce13a2059f599b46d25ef631f643142642be 100644
--- a/drivers/bus/mhi/host/init.c
+++ b/drivers/bus/mhi/host/init.c
@@ -467,6 +467,40 @@ int mhi_init_dev_ctxt(struct mhi_controller *mhi_cntrl)
 	return ret;
 }
 
+static int mhi_find_capability(struct mhi_controller *mhi_cntrl, u32 capability, u32 *offset)
+{
+	u32 val, cur_cap, next_offset;
+	int ret;
+
+	/* Get the first supported capability offset */
+	ret = mhi_read_reg_field(mhi_cntrl, mhi_cntrl->regs, MISCOFF, MISC_CAP_MASK, offset);
+	if (ret)
+		return ret;
+
+	*offset = (__force u32)le32_to_cpu(*offset);
+	do {
+		if (*offset >= mhi_cntrl->reg_len)
+			return -ENXIO;
+
+		ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->regs, *offset, &val);
+		if (ret)
+			return ret;
+
+		val = (__force u32)le32_to_cpu(val);
+		cur_cap = FIELD_GET(CAP_CAPID_MASK, val);
+		next_offset = FIELD_GET(CAP_NEXT_CAP_MASK, val);
+		if (cur_cap >= MHI_CAP_ID_MAX)
+			return -ENXIO;
+
+		if (cur_cap == capability)
+			return 0;
+
+		*offset = next_offset;
+	} while (next_offset);
+
+	return -ENXIO;
+}
+
 int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
 {
 	u32 val;

-- 
2.34.1


