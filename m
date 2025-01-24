Return-Path: <linux-pci+bounces-20333-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8ACA1B4B6
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2025 12:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ED151883419
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2025 11:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCC221C179;
	Fri, 24 Jan 2025 11:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jY85dQoY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84E321B181
	for <linux-pci@vger.kernel.org>; Fri, 24 Jan 2025 11:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737717807; cv=none; b=ZqnG9S7u2ETglxsyJTKIR6PeFe8JrQ3+ctVMtg/elOPh0tkF1/ibs3E6EbDXSSCSH38YsJnwyf+ck7U5OMy9Yqdtrhv6HWdfFCAXY5iwg+gSbdnujFA6KZDqXFeKRzFouIy9S0LnmWKHMCiuBE8ttTqbHgKvzXHt8oGOR8K9CZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737717807; c=relaxed/simple;
	bh=aAQ+D093YPpgryfubEJA4YQRIxQgMZqUwYCwdO3dLmA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HDNnbPmKVUF+gfCYU7+nIaiD08G5ttQAfhlcLWOXD7+8Eb6iK9h2+XRONlbpVWyscxi81p+xiYHSMwHi06gQB9oPnDL6yjuAZ1h3sJHVd1N4HWYOGVjd+QHeTVsQgXTeC5EZcRMSVpAJzQoxJI8RDutx52ckdESacSRFDsoSZkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jY85dQoY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50OAkq16008021
	for <linux-pci@vger.kernel.org>; Fri, 24 Jan 2025 11:23:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iDG9cPvoCK8z7X2aaaeCh0RKjsgrck+iVE1+Sq1KuNQ=; b=jY85dQoY1iihLG9Z
	VN0RjJswK9xU36xn5wzhEL1JDkC12+wKM/pO5kmNnZk+TK0wqjoEog+C1iIz63ux
	OZjPYcsVBH0IJZ5w7f0Dsherwz2Mgsr9jikMhkxblCviGJ86QVSX3EFCoQFsiFJE
	yd4I+RHRse3byQGJVWIqXd7mlOLVi8HhiEcw+VF06Vnk8i67AARI6URwDLNaFczv
	CXmCRhZeX0e/RqKlOhKOpXexsU3wfgQvnXa09qTXnadEjpZRSbsJmx/fu8XeYK9B
	nvt3tnHQW9imFId4Eqf98EDOcckQocwKDFm289KH2sRVb9Ygs60CLqVceodDFmHb
	e2yMnQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44c9djg4d6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 24 Jan 2025 11:23:24 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-216405eea1fso41289055ad.0
        for <linux-pci@vger.kernel.org>; Fri, 24 Jan 2025 03:23:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737717803; x=1738322603;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iDG9cPvoCK8z7X2aaaeCh0RKjsgrck+iVE1+Sq1KuNQ=;
        b=sv+UNagwJkWtHyHZq9VBVMi47/The48cpTvdTu9Is2xvpZQ1y/oYuNnZNjX9kbujg7
         Lbd7icN3r+78AvCh2Pud4b9w2onSr9OXTk+VfUKbz64lAqEnjdFZ/Rv0W3IrD3krSy9U
         BqNaVUoGO4VG7vfVj0vJ88deA8JWJmi/HKAsw6n987LFDfSJmbqDcERdWbjKs9ujNTWC
         gtvgdp+WGk87C5pFtK9mC3nvwpmdknlHW/eZIMfvzkttx0SbOZu+SgOu33JNP1ycWE6f
         DqvPUZX9BZX+Hn14iMV08B2ktvaJ2HYf2uK0ztc8UDAroHSlQOIWMiz8rEuLbMtEKNri
         lK2w==
X-Forwarded-Encrypted: i=1; AJvYcCW/T9xfbqRmXktLXWNYPZrfD3k0sZ9fu99p0FICCCSZC4cTnkIC/g61ZY7rYK/ZpRhU8uB4cQ8kUsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlCOKwhlc8QQG5il04NHvqdpc0FhAbrPBo30Xpd0uayzPA+xLE
	MhDnxXlahGqY3uTLEUAThzDdERYkucX4kmc9xe37ihCO6QkV6ybTu9t5R1WOkXRym4Arwwj6IZa
	S9jPhsnVAckEtHbghlpQEottM7OGw6XWgacLocelfTAD1qEjXhoRMB9nyT3Y=
X-Gm-Gg: ASbGncuuVllB2vkcnYBvM7U9sKRW/YlvDqyBLMyqPFmLgmbSl7uZbbTh0mvj2xwKFFS
	8FcwZG9VFBM7RHmY3CM6PqaVtbWJSQjB4wmP5u2fn/nJwUVW2ndNu79iu5Daee7eV7CnUva9cSh
	HNptZvgZvgMqssMJOOIA/eiKzqPNF8be+xqsGS5VCGcgZBjmLTSwrNoWMyfZAzgmzHncXJgQYmb
	KwwoT+rNw8hzY0BmSE8j9MWWzMb8Ctm+G9Hfd4ISCjqnINjM1gcd4D4rF8RjhQeDZH7ONyo1cCu
	JF03SMqQxlhpGurS6+Z0fqdGA4oVLw==
X-Received: by 2002:a17:902:eccd:b0:216:410d:4c67 with SMTP id d9443c01a7336-21c355c8efbmr494063045ad.41.1737717803177;
        Fri, 24 Jan 2025 03:23:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFNcJImFw4UsAKq5Do4gBFlgHd9ffTPhv64PVSXU5XRkZR6vPBecdycKhiJ4wLS04GjTnsMOA==
X-Received: by 2002:a17:902:eccd:b0:216:410d:4c67 with SMTP id d9443c01a7336-21c355c8efbmr494062655ad.41.1737717802771;
        Fri, 24 Jan 2025 03:23:22 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da414cc20sm14025385ad.165.2025.01.24.03.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 03:23:22 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Fri, 24 Jan 2025 16:52:50 +0530
Subject: [PATCH v4 4/4] PCI: dwc: Add support for configuring lane
 equalization presets
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250124-preset_v2-v4-4-0b512cad08e1@oss.qualcomm.com>
References: <20250124-preset_v2-v4-0-0b512cad08e1@oss.qualcomm.com>
In-Reply-To: <20250124-preset_v2-v4-0-0b512cad08e1@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737717776; l=4571;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=aAQ+D093YPpgryfubEJA4YQRIxQgMZqUwYCwdO3dLmA=;
 b=zCquekUDbmf6cUZgPiq91xAlARj7f0SrBOVKD9h7yHqvGVwQ4bbjaXOJlFfJEa9ac27BiOr/E
 j+BC9Oj5Gv5BW5Si3aH7b6v13mKdWRMRXkIAHpJtElNMyPS4taqzWpp
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: rOdjT3ckhQt2xuunnvyddcOigrQ02DhH
X-Proofpoint-ORIG-GUID: rOdjT3ckhQt2xuunnvyddcOigrQ02DhH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_04,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501240083

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
index 2cd0acbf9e18..eced862fb8dd 100644
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
+	if (speed >= PCIE_SPEED_8_0GT && pp->presets.eq_presets_8gts[0] != 0xff)
+		dw_pcie_program_presets(pci, PCI_EXT_CAP_ID_SECPCI, PCI_SECPCI_LE_CTRL,
+					0x2, (u8 *)pp->presets.eq_presets_8gts, pci->num_lanes);
+
+	/* For data rate of 16 GT/S each lane equalization control is 8bits wide */
+	if (speed >= PCIE_SPEED_16_0GT &&
+	    pp->presets.eq_presets_Ngts[EQ_PRESET_TYPE_16GTS][0] != 0xff)
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


