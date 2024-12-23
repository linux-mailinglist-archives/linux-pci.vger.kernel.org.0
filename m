Return-Path: <linux-pci+bounces-18955-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 254599FAAD0
	for <lists+linux-pci@lfdr.de>; Mon, 23 Dec 2024 07:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08DCD18867A8
	for <lists+linux-pci@lfdr.de>; Mon, 23 Dec 2024 06:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADDC192B60;
	Mon, 23 Dec 2024 06:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PwOt+mBq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA351925A3
	for <linux-pci@vger.kernel.org>; Mon, 23 Dec 2024 06:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734936711; cv=none; b=Em93+e+hS5usen8FlZjK3e2euCxx2js/El/iIbRHmHxGaaeqHk6LbbovJaDEk+xjUQRXivCKHq5rvCbBcBznu+ATK1AznO0j439pLPH+QswWWxsQNhxrb/rHq4GkQsXW3zlETxJlFI7Yut/yBxGrx0l8KK1oO9tnwWufar5IAEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734936711; c=relaxed/simple;
	bh=9iPBkilViQhwzYPPM4sGNw+fIqURUBi25muzZfoAfiY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SEGUu2cn+KF0JPyQjTfXkGDqYJdsuTBEyyJyJnzkBDH/hJO2Kk33P8cWw8fiVWxc8ln/bLT5zFX6JtnrOMarR+LIv1EuIrG8paqPrhk5OFsYPIsf04z9CFnrntOCKmWtTYteFwIhbMhWO4jIKcxKy/Ohd/VizqYvaLWRSLm+UUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PwOt+mBq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BN6Bp9e021186
	for <linux-pci@vger.kernel.org>; Mon, 23 Dec 2024 06:51:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Af5Mt+ubKBOdlLcQnRmqNtqGK3efOnrGl6vcLswMaIA=; b=PwOt+mBqgbowC7Er
	7ZCnO+xMGjbUf+Z2zfgA0EOhdcn/zD4I0i+JmHz2sFxLygn2Sm1LXX2bTDDUG0aJ
	J3CJKCqL/d5ixS3IhVK7kzKwDOy4PB9TJr8x7Ic9oLcNdQ9OKRTHnt+EhRviVmP7
	NfQt7GLfAGv8X9ZwfTSCqhg9KdD/+6Vxhokd2yMia09RYCW5LFfvtnZy71LVw2wK
	pwPFYHXVZahMK1x5Nb/UcBqJoJw0mmy1ezeQyYDlIDLBS7CaiMlqii0AbfcADK3g
	3axP/GCkOwlxIQ4jDqaA8dXGOZOw7XuuYK3lG37W6RrKXM3n0+Hdbnq4ev/uSS5H
	oPqZBw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43q2cm04w0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 23 Dec 2024 06:51:49 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2166855029eso33969125ad.0
        for <linux-pci@vger.kernel.org>; Sun, 22 Dec 2024 22:51:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734936708; x=1735541508;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Af5Mt+ubKBOdlLcQnRmqNtqGK3efOnrGl6vcLswMaIA=;
        b=AnwF2uSQNwghcUeUNf1Udq2f2vsnDVaQy9mfAIOvWPfHKcQE/9J9OQdAjuLNR+l74/
         vwCq/jE4KjMh8Xirqh0QP3VRBgpFL06ZunSjftIp/3Lri7pxIPhbegAkhj3nmbEyR37+
         +h2v6EIj9jkxxXJqf/QP3CNdFyNoz5thbfLlUyw7DujSuKoaQcYtsbKrr63DMJYChzoe
         jFm4o+/jHmMaxVT2Rc1iyRXdecpFyudwOxptwdEZGr7x1pw738cLjzrx3RK8PnUgcAA0
         /HKZepGX60uCt4TK27xFQfj2pqz2dQYkcsoNJofA9wbloyzAvptL2IaMi5efnQrDgui6
         tlpA==
X-Forwarded-Encrypted: i=1; AJvYcCUBHHF65GVJP2tJUvkIi8OhXl0BpSBfq8PoW0TRfzUMJ4KkZPUXoHXI7IktZozeG9u3mKivcwHsHnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtwranSzb8XI/F2nrlVpQEKiY8+XXnMv1S+L6D1UZf7llZfS4g
	bBBvDnVj9PuTYUZwVEEvqA0fUHspZiBFut0fPvDrcHz1kKEYNSCgiSFNeRIdspn39jKBK9cjhzg
	0OUkTqxycssFjUo9Hm8XI1FjzyiNTc1gieBFFqlpxzTgam5kV8TaBaejgjlI=
X-Gm-Gg: ASbGncsSg1XML8Jj/QFI4SNGKWJ1KiXnKlPw5ZnvBht4d1lk88TdWNmpfMCHyBWOECG
	sC0idk8pQ314VVgwr8JJuKLV/tGvIwVaqC1V/HfL9/Qwl2Fje9yXIclFf78jvIar6idPIACYot/
	l7unCQG2kLQn/NHGoa7zpzcP9yfIHKlYaH1KkTJDFLREhMsrwzKezU6Q4svntF+kSrv0Iq4FrFJ
	QlQzDQTh/OInU/S2c+Dem2GnnHDUAOoIFfm6TQ0VvJEoTdHdYLDkm4At8FTgrAmt+iQgimTPrx0
	oQPxx8ori1VyRBCz
X-Received: by 2002:a17:902:f550:b0:215:a04a:89d5 with SMTP id d9443c01a7336-219e6e859d8mr146177755ad.2.1734936708267;
        Sun, 22 Dec 2024 22:51:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEk8WqNVvkHrK7paVwQxUN5NMRNU3kN7hnEse7CjQZ60CfVOf6MFP4KpKXQ+8mcS0z/A+N3cg==
X-Received: by 2002:a17:902:f550:b0:215:a04a:89d5 with SMTP id d9443c01a7336-219e6e859d8mr146177455ad.2.1734936707863;
        Sun, 22 Dec 2024 22:51:47 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f4413sm66570155ad.172.2024.12.22.22.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2024 22:51:47 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 23 Dec 2024 12:21:17 +0530
Subject: [PATCH v3 4/4] PCI: dwc: Add support for configuring lane
 equalization presets
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241223-preset_v2-v3-4-a339f475caf5@oss.qualcomm.com>
References: <20241223-preset_v2-v3-0-a339f475caf5@oss.qualcomm.com>
In-Reply-To: <20241223-preset_v2-v3-0-a339f475caf5@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734936683; l=4481;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=9iPBkilViQhwzYPPM4sGNw+fIqURUBi25muzZfoAfiY=;
 b=gS2BejIAVW4y1KKMIVp945bWdoLFPZUKUzHejFKMdxOxL4KXiwMNODLhU/6WZDUojv79IDOZJ
 xqAL0kAce8eBeR6yhG4Z0jRojKIQ0Lu9ZjMoE0Mp05Q7jGZQ80kpyD8
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: 20EK5JIftrhJA3b6pnJeTwfmxsB3TFm5
X-Proofpoint-ORIG-GUID: 20EK5JIftrhJA3b6pnJeTwfmxsB3TFm5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 lowpriorityscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412230059

PCIe equalization presets are predefined settings used to optimize
signal integrity by compensating for signal loss and distortion in
high-speed data transmission.

Based upon the number of lanes and the data rate supported, read the
devicetree property and write it in to the lane equalization control
registers.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 39 +++++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h      |  3 ++
 include/uapi/linux/pci_regs.h                     |  3 ++
 3 files changed, 45 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 2cd0acbf9e18..22d3d350918e 100644
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
@@ -802,6 +806,40 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
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
+	if (speed >= PCIE_SPEED_8_0GT && pp->presets.eq_presets_8gts)
+		dw_pcie_program_presets(pci, PCI_EXT_CAP_ID_SECPCI, PCI_SECPCI_LE_CTRL,
+					0x2, pp->presets.eq_presets_8gts, pci->num_lanes);
+
+	/* For data rate of 16 GT/S each lane equalization control is 8bits wide */
+	if (speed >= PCIE_SPEED_16_0GT && pp->presets.eq_presets_16gts)
+		dw_pcie_program_presets(pci, PCI_EXT_CAP_ID_PL_16GT, PCI_PL_16GT_LE_CTRL,
+					0x1, pp->presets.eq_presets_16gts, pci->num_lanes);
+}
+
 int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -855,6 +893,7 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
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


