Return-Path: <linux-pci+bounces-23883-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FD7A633C3
	for <lists+linux-pci@lfdr.de>; Sun, 16 Mar 2025 05:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A5C716A189
	for <lists+linux-pci@lfdr.de>; Sun, 16 Mar 2025 04:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162EC18B47D;
	Sun, 16 Mar 2025 04:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DikBVyZW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6893918A6AB
	for <linux-pci@vger.kernel.org>; Sun, 16 Mar 2025 04:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742098179; cv=none; b=r5fGh6AJmaum1p+MKdNAvsY1y+JnDf3BQ1DnslJmZun1TfeaIUigQkI0gSYHq4UoPL5bLOYndyfdyG+V4iqtYlTTAXbaBhUTbUQLlXKN+wmWwEmeXijIvrrEAuwUaB6Ko0wubs+eI8wGRG6drZjLJ98945dcODIh5CIIuiELlmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742098179; c=relaxed/simple;
	bh=Vf5WXRKSe8bkKwPkNi3tieP8dH4brW2HCDlfCESBKTw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EH+ah9Z6fdctmMKRr4w02cNluNLsWEDHhBM1vo7Clcn+wjJ6ZwTQ8DHfCNXo9E+8eS+Xs0xb/bOfUfqF5FctCmfzbJuYmWpBRDrIcZU/kdhfHDfSc0CrWf5uyW1sEgBpruvHHxPuGI0BUUzbJIXS53VTyMlY0jVhKfTGFO5fDjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DikBVyZW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52G2LC02012399
	for <linux-pci@vger.kernel.org>; Sun, 16 Mar 2025 04:09:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BjiWZ8phXn5GvIMbIVKOQIoK9S28Kpb6nyVGje6AKfo=; b=DikBVyZWMW1JTmPW
	Y3LG42KKoHRTZFNLdvOtDeTYtcnFL+CzNWFmTHe85yqOSpfczIy1bAwC+C5pjl21
	tRay65ANrP17pEGiOHA0UP7RjEx1eHlEkd3LupeCDlOJpCq0cIhG58wYSzlbJp/5
	i8tOdgF+cGnQFcFPPw0OCfBu3wChVsZexT5TccQIhRQfHsumO9lihiJ6GIDKjyH9
	F6LurLxCbUKa/eL6Rqy0Ar9gwspZn6Mi+dug38jIwhhgnFzqrJGC0hC4OmF6Pmhe
	SMuPsbD1rgNNsiP6LvfJimRjVGbG4A7EmaYE95Zqq3XBxPOLnXNFyvBbhbNPepNd
	IWezTQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d1u89pce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sun, 16 Mar 2025 04:09:36 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff6943febeso1209728a91.0
        for <linux-pci@vger.kernel.org>; Sat, 15 Mar 2025 21:09:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742098176; x=1742702976;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BjiWZ8phXn5GvIMbIVKOQIoK9S28Kpb6nyVGje6AKfo=;
        b=h883qFLpTWb/ktqk7MYmeUcmqtVzzP0B35iTCcAV399Tglv5f3Pq2EpH13O3aJ6dw/
         nIQXICbua4pr9MLEmP6/lznlnJueDabc9bqwYuv8k+nBr+leXzuieqKVzu+x8ShOJhGd
         wa7lzdRjhPPPILIVRzGjzDvEp6zxZfsZBQKL0FFk7IsjYr/Q0Wc4kls0wi5NCLdxaAZf
         uUDmseyhHQBia5sC1RJPoFv+egoEoOvsFqJw1xCiJGIE0Sb3KxhuRjjhSoYyUhA7HgvU
         hfCMgEAWxDUeuYvuJOSRVOL2x3+msQOL1ZSwyrHaJcMuNqaWRXwPUq79ZAJOztLPsPeu
         cdmA==
X-Forwarded-Encrypted: i=1; AJvYcCW0t08Eyvz6shXJBQq/Mu4o7sZq7w077YKnaf6aAdQeL4lbCFumTBp+1NWpezYjOykAmEn5PlybkJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5tkeBWI5DvmU93uxR6YZOvJDWjRwGvcRKMUAP3K8+iILjZIAU
	eRg2m25IqxskLc8ccKOPs2J/4SRyNkv4TsJWquigtitSVwONVpTRPhlWYM9FiD5egudM/8gNeA0
	vnk9VZEhbCltSND6cPqwZBWcMpL0AE4j/UI34LhUVK8dafaeiU/uAthskNJY=
X-Gm-Gg: ASbGncsQuo4sCJOO+mn/bl6rz+al7NGevRH9Y8dFfXG0oVrhGQnKz+SO8VLq4mekrpd
	119yj6RoqU02urnKy+nOsYjgY5AMkX2EI2ObCKAzyfuRO97yPYIearJQFvlNpmoYUshopqxIwpz
	PleZFWkVGBG7VLgJX70aCXUR87kBmVTqOUK1Usf8OmazPvH+0LoS8/X08EexB7DnhCYUW6B1IOq
	nsrq/1Eelsk7xY96dKbOLtdFv1EOy+bGRnJTwtacAiZv+Q/1Tk7tRA3ojY1z+TYJ2ZwSvkRWb/Q
	jr542sGbTbLNXTcQiYunlScFmZJpP8mKIYLqywEbbpfurKdL7wI=
X-Received: by 2002:a17:90b:568c:b0:2ff:556f:bf9 with SMTP id 98e67ed59e1d1-3015211e77emr9378166a91.4.1742098175790;
        Sat, 15 Mar 2025 21:09:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpxdwyme8KoKtPhwKD++kCMtUzmx2P4sIFKMDkag5tMvi/6pF1x3XIwxkD7MXlNc1WKVwxFA==
X-Received: by 2002:a17:90b:568c:b0:2ff:556f:bf9 with SMTP id 98e67ed59e1d1-3015211e77emr9378132a91.4.1742098175401;
        Sat, 15 Mar 2025 21:09:35 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30153bc301esm3490438a91.49.2025.03.15.21.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 21:09:35 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sun, 16 Mar 2025 09:39:04 +0530
Subject: [PATCH v8 4/4] PCI: dwc: Add support for configuring lane
 equalization presets
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250316-preset_v6-v8-4-0703a78cb355@oss.qualcomm.com>
References: <20250316-preset_v6-v8-0-0703a78cb355@oss.qualcomm.com>
In-Reply-To: <20250316-preset_v6-v8-0-0703a78cb355@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_mrana@quicinc.com, quic_vbadigan@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742098148; l=4863;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=Vf5WXRKSe8bkKwPkNi3tieP8dH4brW2HCDlfCESBKTw=;
 b=Pz7WkgxvMuX5UL9txYDwfTz6oJAxGk2zoimjpd2MBBSoIR/EyDHRJq7SRU3gBK0AOm8q0VU0J
 bNk4lP60Lz7AXg4zUwe5KESCPDyDzfhY4i3aJFx8iBYHQ7rKVoq9O1r
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: ZADUi8BSwwLVAc3GbWjLg0-_qIfMbdt8
X-Authority-Analysis: v=2.4 cv=c42rQQ9l c=1 sm=1 tr=0 ts=67d64f00 cx=c_pps a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=S-wDCh2AgS0RhsWIeBgA:9 a=QEXdDO2ut3YA:10
 a=yWgB78FVKKW44gG2z5Yz:22 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: ZADUi8BSwwLVAc3GbWjLg0-_qIfMbdt8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-16_01,2025-03-14_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 malwarescore=0
 impostorscore=0 mlxlogscore=999 priorityscore=1501 suspectscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503160029

PCIe equalization presets are predefined settings used to optimize
signal integrity by compensating for signal loss and distortion in
high-speed data transmission.

Based upon the number of lanes and the data rate supported, write
the preset data read from the device tree in to the lane equalization
control registers.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 60 +++++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h      |  3 ++
 include/uapi/linux/pci_regs.h                     |  3 ++
 3 files changed, 66 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index dd56cc02f4ef..7c6e6a74383b 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -507,6 +507,10 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	if (pci->num_lanes < 1)
 		pci->num_lanes = dw_pcie_link_get_max_link_width(pci);
 
+	ret = of_pci_get_equalization_presets(dev, &pp->presets, pci->num_lanes);
+	if (ret)
+		goto err_free_msi;
+
 	/*
 	 * Allocate the resource for MSG TLP before programming the iATU
 	 * outbound window in dw_pcie_setup_rc(). Since the allocation depends
@@ -808,6 +812,61 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 	return 0;
 }
 
+static void dw_pcie_program_presets(struct dw_pcie_rp *pp, enum pci_bus_speed speed)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	u8 lane_eq_offset, lane_reg_size, cap_id;
+	u8 *presets;
+	u32 cap;
+	int i;
+
+	if (speed == PCIE_SPEED_8_0GT) {
+		presets = (u8 *)pp->presets.eq_presets_8gts;
+		lane_eq_offset =  PCI_SECPCI_LE_CTRL;
+		cap_id = PCI_EXT_CAP_ID_SECPCI;
+		/* For data rate of 8 GT/S each lane equalization control is 16bits wide*/
+		lane_reg_size = 0x2;
+	} else if (speed == PCIE_SPEED_16_0GT) {
+		presets = pp->presets.eq_presets_Ngts[EQ_PRESET_TYPE_16GTS - 1];
+		lane_eq_offset = PCI_PL_16GT_LE_CTRL;
+		cap_id = PCI_EXT_CAP_ID_PL_16GT;
+		lane_reg_size = 0x1;
+	} else {
+		return;
+	}
+
+	if (presets[0] == PCI_EQ_RESV)
+		return;
+
+	cap = dw_pcie_find_ext_capability(pci, cap_id);
+	if (!cap)
+		return;
+
+	/*
+	 * Write preset values to the registers byte-by-byte for the given
+	 * number of lanes and register size.
+	 */
+	for (i = 0; i < pci->num_lanes * lane_reg_size; i++)
+		dw_pcie_writeb_dbi(pci, cap + lane_eq_offset + i, presets[i]);
+}
+
+static void dw_pcie_config_presets(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	enum pci_bus_speed speed = pcie_link_speed[pci->max_link_speed];
+
+	/*
+	 * Lane equalization needs to be perfomed for all data rates
+	 * the controller supports and for all supported lanes.
+	 */
+
+	if (speed >= PCIE_SPEED_8_0GT)
+		dw_pcie_program_presets(pp, PCIE_SPEED_8_0GT);
+
+	if (speed >= PCIE_SPEED_16_0GT)
+		dw_pcie_program_presets(pp, PCIE_SPEED_16_0GT);
+}
+
 int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -861,6 +920,7 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
 		PCI_COMMAND_MASTER | PCI_COMMAND_SERR;
 	dw_pcie_writel_dbi(pci, PCI_COMMAND, val);
 
+	dw_pcie_config_presets(pp);
 	/*
 	 * If the platform provides its own child bus config accesses, it means
 	 * the platform uses its own address translation component rather than
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 61d1fb6b437b..30ae8d3f4282 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -25,6 +25,8 @@
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
 
+#include "../../pci.h"
+
 /* DWC PCIe IP-core versions (native support since v4.70a) */
 #define DW_PCIE_VER_365A		0x3336352a
 #define DW_PCIE_VER_460A		0x3436302a
@@ -381,6 +383,7 @@ struct dw_pcie_rp {
 	int			msg_atu_index;
 	struct resource		*msg_res;
 	bool			use_linkup_irq;
+	struct pci_eq_presets	presets;
 };
 
 struct dw_pcie_ep_ops {
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 3445c4970e4d..2cd20170adb4 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1140,6 +1140,9 @@
 #define PCI_DLF_CAP		0x04	/* Capabilities Register */
 #define  PCI_DLF_EXCHANGE_ENABLE	0x80000000  /* Data Link Feature Exchange Enable */
 
+/* Secondary PCIe Capability 8.0 GT/s */
+#define PCI_SECPCI_LE_CTRL	0x0c /* Lane Equalization Control Register */
+
 /* Physical Layer 16.0 GT/s */
 #define PCI_PL_16GT_LE_CTRL	0x20	/* Lane Equalization Control Register */
 #define  PCI_PL_16GT_LE_CTRL_DSP_TX_PRESET_MASK		0x0000000F

-- 
2.34.1


