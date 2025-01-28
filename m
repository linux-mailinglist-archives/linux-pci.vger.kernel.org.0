Return-Path: <linux-pci+bounces-20446-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AE1A2077D
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 10:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 992EC1661B8
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 09:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45ED19F43A;
	Tue, 28 Jan 2025 09:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XvdLifm6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B27919F41B
	for <linux-pci@vger.kernel.org>; Tue, 28 Jan 2025 09:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738057093; cv=none; b=mqnw04IDiRJeq0YJF5ju6uP6Uuf8iIqL8PZ+12b/SfIZ9r1+itQLhHUaBtlM/pwepBh3HC3hadBzJXP7e2Kav9wfeZvp70u4Yaf1CduM7NN9xLO+hU75V4JFWbhp61hX7eP6iZGmXoGcJBaqn71ehgh95GmhJtOaUGCnPvUkiIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738057093; c=relaxed/simple;
	bh=3GLMUInncPOildJhljSbunLgceyGqCV+SYyFKStTklU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Um6dwn5+InqS2fZzhooIuDSqYukD949I/R9EBL6/twMPxPmM5C+a86+wEtk9Sa3pu04rqdXWX2AEBAXssXrt4Ngnba5JSbEpMBh9jR0/zVxOXmTD8sEadfBcQZsN0CAvsUdgufWFWJnozjF+x47oR0IbSJHqYAYV4tcqZCjGvlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XvdLifm6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50S9RO2w008536
	for <linux-pci@vger.kernel.org>; Tue, 28 Jan 2025 09:38:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FUrEH7Zbq+Pqz4jtLHT1pz98odHEPBPyhXjpsIUNdUw=; b=XvdLifm6hdkZZgUm
	Z++MN/OnbClWT7V1EH8JGrevC8WJ1ndhOHMqKCZbU8UT4UypWDXqt3JLDUcDa/bA
	BShHgqypAsDh+jA9+lwUtj8aVJNXliSH7hGMfZyKHYAI5kv2giRuQjH6JCU/nBXQ
	7IjZSt0s3K9D1OthlQOoC3gYz+epTH6JVZwo0P2QPMjql+z+muezyGIQ5sw+RyFk
	ExfJkGSizh83EOb4OjlYztIJKNxuK66+jCPxUbuc20H/RCCTmY3D5G+KKr3lfAiN
	5ncs5+GOWYXmBll5sxwkWYNYtADHEI1MjKbyBfXVJ+LYgHW7jOfX2KWKRXfgp2y9
	wmJ6MQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44ed5g9wtr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 28 Jan 2025 09:38:10 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2efa74481fdso11079069a91.1
        for <linux-pci@vger.kernel.org>; Tue, 28 Jan 2025 01:38:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738057090; x=1738661890;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FUrEH7Zbq+Pqz4jtLHT1pz98odHEPBPyhXjpsIUNdUw=;
        b=in0voQ38BpACF4OKBZFCITymj0VE5mBrUGtd7CHJMsoxerKJe/BVdcRBRQIOCAM3oY
         LfovSvX5f36OiwqMPpjGie1aoYbFB+65fHBxmv5j2GfnalTMfbN3tU7gJldlIbNus5zU
         c8yYYhnhMwgmNMyePpSv4jf8EIz+iravzun+0/f+KFw9vhLGkHWRA4YrVolrsGjZCAgN
         OWUylObKAwOYb0fJXM9Gir/2sgdITs6hQOyYmJ3RTfilOKHhAsNRDKA5XPsJHJukMYik
         og2T0gFxh/VwOY2tYBQMKbStoMYQxGRw1OU0lrYUzfh+2qlu5kAp6dlKypTuGVxqsw5l
         Lrow==
X-Forwarded-Encrypted: i=1; AJvYcCWVBVlA6lm34zq4C/Yp2RaVOqjJUQmiD659y3rvDQzl1ku1gSu3EK71Hg4Hyouj7XpyLIRmp0Lr3o4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+ov1+UDJ6R3LIvbwkTSmDobRH0RZVmWn+x7MQoeRKMi3xiq4n
	b8HAyn0rWbLWdIyFcUUaX3iQe9Gea91ERpwVZdj27BnSB3DVEA54e4Noxuqng4wCxTfyCAu9hhH
	MySae3yaqmlJ4bQTUnclkTiDZaS88WKCG++PZ+37Nv0HSTEf40cC1vkteLb4ewEqTfBg=
X-Gm-Gg: ASbGncvVDdLKxI2PDjsLYnQWD+NZZ12O8E86Jnn5mu4NBF0S1KYbjjUTjSn6UId/FSj
	IM8SyzWJHRUx96YTA298j6ddOsPxgrZOp/BdPpmhu8bECIJQDDr92Qgo5Bz3Kx6kAv8rJbgoMej
	/Mj/SzpvEOXItEt+bBzHmII84uE23/3VGtXwIGVEUfca1srqblDVzK/I/hsUBxl1ip5JyvUzKOD
	/5ky5FPpGqk1kTDIChwpxe8+GXsc0rop+dxYcyxQc7kBYUyD5ZSsbEr77A+L+OOXAm3TFfSyV+B
	+TgH4PvFasTPRn17Do7wp1W7v4uBuwH3rfE/LS1z
X-Received: by 2002:a17:90b:3a05:b0:2ee:ed1c:e451 with SMTP id 98e67ed59e1d1-2f782cb083dmr66476747a91.15.1738057089779;
        Tue, 28 Jan 2025 01:38:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELjHRrH1DA2cW0F8TVuPax9KYYfQkpneMo280DA/WRw8LZiZvNU1VaNAFZkLi0rVseiSnFJQ==
X-Received: by 2002:a17:90b:3a05:b0:2ee:ed1c:e451 with SMTP id 98e67ed59e1d1-2f782cb083dmr66476710a91.15.1738057089391;
        Tue, 28 Jan 2025 01:38:09 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa456absm9749501a91.2.2025.01.28.01.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 01:38:09 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Tue, 28 Jan 2025 15:07:42 +0530
Subject: [PATCH v5 4/4] PCI: dwc: Add support for configuring lane
 equalization presets
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-preset_v2-v5-4-4d230d956f8c@oss.qualcomm.com>
References: <20250128-preset_v2-v5-0-4d230d956f8c@oss.qualcomm.com>
In-Reply-To: <20250128-preset_v2-v5-0-4d230d956f8c@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        konrad.dybcio@oss.qualcomm.com, quic_mrana@quicinc.com,
        quic_vbadigan@quicinc.com, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738057065; l=4585;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=3GLMUInncPOildJhljSbunLgceyGqCV+SYyFKStTklU=;
 b=qHlTKa0AShwpSvWJ0qQN32ORdr062CGGFRcChgoEZ8X80dOO2an4W+V5v0gBffldkbho0I3ft
 aM6ldVc1rWYCq+xQBO2VU3MUGj5Tp6915hOeu4LdWlKiHLAshFKZ3Ur
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: 6gIR97_c3JcarmcLqa-kSEQyAbFeSHBF
X-Proofpoint-ORIG-GUID: 6gIR97_c3JcarmcLqa-kSEQyAbFeSHBF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_03,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 impostorscore=0 clxscore=1015 spamscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501280074

PCIe equalization presets are predefined settings used to optimize
signal integrity by compensating for signal loss and distortion in
high-speed data transmission.

Based upon the number of lanes and the data rate supported, write
the preset data read from the device tree in to the lane equalization
control registers.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 41 +++++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h      |  3 ++
 include/uapi/linux/pci_regs.h                     |  3 ++
 3 files changed, 47 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 2cd0acbf9e18..f458b4c70053 100644
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
@@ -802,6 +806,42 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 	return 0;
 }
 
+static void dw_pcie_program_presets(struct dw_pcie *pci, u8 cap_id, u8 lane_eq_offset,
+				    u8 lane_reg_size, u8 *presets, u8 num_lanes)
+{
+	u32 cap;
+	int i;
+
+	cap = dw_pcie_find_ext_capability(pci, cap_id);
+	if (!cap)
+		return;
+
+	/*
+	 * Write preset values to the registers byte-by-byte for the given
+	 * number of lanes and register size.
+	 */
+	for (i = 0; i < num_lanes * lane_reg_size; i++)
+		dw_pcie_writeb_dbi(pci, cap + lane_eq_offset + i, presets[i]);
+}
+
+static void dw_pcie_config_presets(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	enum pci_bus_speed speed = pcie_link_speed[pci->max_link_speed];
+
+	/* For data rate of 8 GT/S each lane equalization control is 16bits wide */
+	if (speed >= PCIE_SPEED_8_0GT && pp->presets.eq_presets_8gts[0] != PCI_EQ_RESV)
+		dw_pcie_program_presets(pci, PCI_EXT_CAP_ID_SECPCI, PCI_SECPCI_LE_CTRL,
+					0x2, (u8 *)pp->presets.eq_presets_8gts, pci->num_lanes);
+
+	/* For data rate of 16 GT/S each lane equalization control is 8bits wide */
+	if (speed >= PCIE_SPEED_16_0GT &&
+	    pp->presets.eq_presets_Ngts[EQ_PRESET_TYPE_16GTS][0] != PCI_EQ_RESV)
+		dw_pcie_program_presets(pci, PCI_EXT_CAP_ID_PL_16GT, PCI_PL_16GT_LE_CTRL,
+					0x1, pp->presets.eq_presets_Ngts[EQ_PRESET_TYPE_16GTS],
+					pci->num_lanes);
+}
+
 int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -855,6 +895,7 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
 		PCI_COMMAND_MASTER | PCI_COMMAND_SERR;
 	dw_pcie_writel_dbi(pci, PCI_COMMAND, val);
 
+	dw_pcie_config_presets(pp);
 	/*
 	 * If the platform provides its own child bus config accesses, it means
 	 * the platform uses its own address translation component rather than
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 500e793c9361..b12b33944df4 100644
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
@@ -379,6 +381,7 @@ struct dw_pcie_rp {
 	bool			use_atu_msg;
 	int			msg_atu_index;
 	struct resource		*msg_res;
+	struct pci_eq_presets	presets;
 };
 
 struct dw_pcie_ep_ops {
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 12323b3334a9..68fc8873bc60 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1118,6 +1118,9 @@
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


