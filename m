Return-Path: <linux-pci+bounces-43791-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C9ACE665B
	for <lists+linux-pci@lfdr.de>; Mon, 29 Dec 2025 11:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0EC8F301193C
	for <lists+linux-pci@lfdr.de>; Mon, 29 Dec 2025 10:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661832F83B7;
	Mon, 29 Dec 2025 10:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dR8+G2Ot";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ToBjh6wO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EC92F39A1
	for <linux-pci@vger.kernel.org>; Mon, 29 Dec 2025 10:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767004983; cv=none; b=F+oL3SSmrgiPlii8HPGGAYLSqZahqNVlkioBIZb9mO5o0qAX7/U7fJ4/cosxnz6i5AKYdTRUfDgnqcPqX6GcTssqalQB32IafPa7xyRuq7rL7Do0/H+Kfi3h/v422bYjLlhzseGfluSygf16C0JILqvTqDKZwDqNlxQF7UGWreQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767004983; c=relaxed/simple;
	bh=hUoI9bnVtJsUGfvg2BaMO4nB7gpZPlLk6e7RaaGAyq0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rCAvuQSxa0UdGxJZJ5s0sxxt941UBa9VMlHDY3lA7ZdtSyU+OrvrSxwLBzoP1XLxwnot2Ryi5Fv+9sRJQCJl+ltoP5gDrl6SyWD9Fyd/15ERPW2zBYsxmK7L5KOGIJ65aM2AWjTFyiYwsFTyTD+Tauwv8/FCT792M0LRpo1DFX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dR8+G2Ot; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ToBjh6wO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BTAS3uT3697474
	for <linux-pci@vger.kernel.org>; Mon, 29 Dec 2025 10:43:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n+AJFwEI+sbiPk8ABgsu6UQdCuUqwsgPHB05A+dmaTQ=; b=dR8+G2OtP/rMcTjN
	4xIkfO8avBMwnEwQxClRs9H0MZMXdMrmqvMw+3cSIPe1Iw0m+qTTeBPSsFpSDPf8
	0id50iVQNLINo8AhHE/H6F1aezd4nQnSUfEAeMrAYvTPGnEYYh+SxjOE/n2lU/eC
	y5g7iu3qYCnso5Eqqnetg8n161NvBMV/eY2dH9O0WIA2lT3aWvwSmdYxUGf5ultl
	xY3B8kgGtjReSWyz2oneRcwZwGsnlSoTdDK1frpiDX01rz/ETGuETWBjVlmF073j
	JJ77bKFuO8LLsIBckm04GHL1nl2jxYMRV8MAN4d3FYDO2fcHJs9tq51Ex+0gVehq
	kjaEzQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bbc8ysc3k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 29 Dec 2025 10:42:59 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a09845b7faso135761105ad.3
        for <linux-pci@vger.kernel.org>; Mon, 29 Dec 2025 02:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767004979; x=1767609779; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n+AJFwEI+sbiPk8ABgsu6UQdCuUqwsgPHB05A+dmaTQ=;
        b=ToBjh6wOB5gcddtH/w72TY4svvUHVkkglV0AS8W9Wmklfa7fSlN9p7nFmyTOvWHOXC
         DyxoVFPWXl1TFKXOef4jacPNyrd4MQPZyulhRYtp/1sjflwT/A7X/bG5L4yJyeGOp9O4
         Pp1W5brJu7kE/lm2najbFfJueDpZxxHzlTW7UrVYTg5p8cDNxxwZYa1OhrA4ZIRaiLP3
         yi3oWqf8IjGVXAJf77SNlcTmMkuzbQXxohiFN9oi0qAy+ShK0AOdgVN/wRxV5nehVB54
         LUUoO8p0WHvDUvbtcrBcoKzLGxBx5ONnGvthSOJfJCBePoc7iFOYCLVB/HQcFZLR0eh0
         oq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767004979; x=1767609779;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n+AJFwEI+sbiPk8ABgsu6UQdCuUqwsgPHB05A+dmaTQ=;
        b=VLSojmsNutYXJ019iQcLHBBhaL5JUDGrsFHYro4zeFav6aghrl6JXKCaZA1J0C6/Qn
         TKxnWJW07xVXP6uP7KxfpJ8iKuIfPjlzOFw8knnE8yOU6ZBqnMU+tBtLo0meLO6lLmQH
         DoYT15+y2KqvrwMJzifvOosAXyh9ghAmqTjGZ2pK5rOY8cj/dUjzq+br8Qo5x7k338ho
         v4gKt4UHfx7AWzYFNqMgWm+KZ2jumAsc1Rb+ISgS4H+J7HcyAf+QMwHBB+SjtVL7lFlw
         h0IGE3Z8fr44KE9ZrglLccfSI3cJsqW4geSoT4+yRT7Wnjai6jktCyVUJQ10n6eqOOKQ
         zaLA==
X-Gm-Message-State: AOJu0YxMnd3NYYjAUY/XwcxDUbU8qdiX7toe0RsmNcjmOyC0lx+bPW5J
	iGEdMBnKg49F2Ex3iypMqy122/aTHb0EIKlDQ1GYx71YkA1dkE+3HqeQ8rDK2Ta2yX3C6c9D2Ih
	mxIGFQAMhZswr9qYGsYODmO6wJJfT6NeEIFieR6Skh2DYkFq2AYNz4TjfP3LD4QU=
X-Gm-Gg: AY/fxX79Xf+XYBY2y5FMTVn3mJEtWpufKaFb71uifc/haXZTy1q78EqyTx+dLODyqy8
	7zXo+ZUfZUtC29uWMKTcA5A+dVNHL9MyJIo1kx3a/QNdkhuaXTyhy+QubPc/eFsPqANM0u/qIDN
	irf3itl4rS9/ZFwGWh85vkpLrbnxkEY/l3bWG1wPYqCxNx8Ut8fOiQjvwWp4oBfLkSYU9SsCSjx
	i5VaGaNqzavL+ZDX/Uuiv7R6c6jSHDojYDMprTYgoTxD0c77udwV/ijOXZYrfqd0SgiyOKoK/0x
	CFJnZoM/2iXFXBwILbsFEiy15tUptslMZRlaoU2SRWpODnukbYGZ6h0G5t7zR+2+voworSaMwB2
	hAyOMaXepIkeHvXfk1L39PIUeVyxNiKUR/kgoRubOu+jr
X-Received: by 2002:a17:903:2301:b0:294:f6b4:9a42 with SMTP id d9443c01a7336-2a2f21fad06mr240902115ad.9.1767004979121;
        Mon, 29 Dec 2025 02:42:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFK2JAXp6jiF2G/SzUfcNJxYSaeUtWfOmyekVWWyTt9ngR/qKufhrxqS8eoLKj8J3oZe9EZ1A==
X-Received: by 2002:a17:903:2301:b0:294:f6b4:9a42 with SMTP id d9443c01a7336-2a2f21fad06mr240902045ad.9.1767004978627;
        Mon, 29 Dec 2025 02:42:58 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d4cbb7sm273412365ad.59.2025.12.29.02.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 02:42:58 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 29 Dec 2025 16:12:43 +0530
Subject: [PATCH v2 3/3] PCI: dwc: Fix missing iATU setup when ECAM is
 enabled
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251229-ecam_io_fix-v2-3-41a0e56a6faa@oss.qualcomm.com>
References: <20251229-ecam_io_fix-v2-0-41a0e56a6faa@oss.qualcomm.com>
In-Reply-To: <20251229-ecam_io_fix-v2-0-41a0e56a6faa@oss.qualcomm.com>
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, macro@orcam.me.uk,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767004963; l=6757;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=hUoI9bnVtJsUGfvg2BaMO4nB7gpZPlLk6e7RaaGAyq0=;
 b=al7P/isFpZ/QZO+wz6kSBvOg0aA9uGmCPSM7TZqUgYJZyWxrnrqXTee00SHNwLnddKcMUnGnb
 xOruE3dzhOtAqDNrmjL9O850mKsqGk8a1tqbYNrUx5Oou9fovrH2Au9
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDA5OSBTYWx0ZWRfX7wkeW7PJhbXj
 KYjusydYuQ2HwI2hvA+CLEv8Wk0KCuvp5/K+W/qCLnWb31P1P/wksXYgFY4CqgEvXkEDl1m7k7j
 gbFP5ZMDHxvS44tbWxBR5IXDl8wRE8qnfuLfqh0JepoBDWhzbgiv/YejmFsxaRpfppJv+34y85w
 mDz/vDldb45nGtRTQizZPm3tYkKIZtUzFBQEd73rkdzx8O5bb3GApE+K2Ptfo7r2GXS62MyR5sn
 FvqAybQCS8rsfFHnAbm1E1DGErnzo/KxjCnc6tAwA9SIBy/Iz1TP5sr4KWdshAZmdvGWfcEz2cS
 alvsBIq9GiuRkjaka/X2z2zI/10msFsQtV19UiC4YoGMIOBv3pWAQcMu+J+eE/VCK3ZNUwjZdtw
 fcVH0afuyn3ITHrybJ8eEKVio4zcIuUrq5X+/Or/Dml84njKWG6Y5JLlbX9ceyHPAtNtuZD2EQ4
 CFs/Kj4FulgjZ5jPWQA==
X-Authority-Analysis: v=2.4 cv=cP7tc1eN c=1 sm=1 tr=0 ts=69525b33 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=BcPKCTjPAAAA:8 a=EUspDBNiAAAA:8
 a=opeatF3ZsncwF_PLLlkA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=MNXww67FyIVnWKX2fotq:22
X-Proofpoint-ORIG-GUID: HUqoDXiOfwjlSd0AbwO1GjVdEhwMRB8w
X-Proofpoint-GUID: HUqoDXiOfwjlSd0AbwO1GjVdEhwMRB8w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_03,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512290099

When ECAM is enabled, the driver skipped calling dw_pcie_iatu_setup()
before configuring ECAM iATU entries. This left IO and MEM outbound
windows unprogrammed, resulting in broken IO transactions. Additionally,
dw_pcie_config_ecam_iatu() was only called during host initialization,
so ECAM-related iATU entries were not restored after suspend/resume,
leading to failures in configuration space access

To resolve these issues, the ECAM iATU configuration is moved into
dw_pcie_setup_rc(). At the same time, dw_pcie_iatu_setup() is invoked
when ECAM is enabled.

Rename msg_atu_index to ob_atu_index to track the next available outbound
iATU index for ECAM and MSG TLP windows. Furthermore, an error check is
added in dw_pcie_prog_outbound_atu() to avoid programming beyond
num_ob_windows.

Fixes: f6fd357f7afb ("PCI: dwc: Prepare the driver for enabling ECAM mechanism using iATU 'CFG Shift Feature'")
Reported-by: Maciej W. Rozycki <macro@orcam.me.uk>
Closes: https://lore.kernel.org/all/alpine.DEB.2.21.2511280256260.36486@angie.orcam.me.uk/
Tested-by: Maciej W. Rozycki <macro@orcam.me.uk>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 41 ++++++++++++++---------
 drivers/pci/controller/dwc/pcie-designware.c      |  3 ++
 drivers/pci/controller/dwc/pcie-designware.h      |  2 +-
 3 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 88b6ace0607e97bf6dd6bf7886baaa13bf267e6e..cb1b5b2a2fe61eb5901e57a60f8f333b1c3e766b 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -430,10 +430,10 @@ static int dw_pcie_config_ecam_iatu(struct dw_pcie_rp *pp)
 	/*
 	 * Root bus under the host bridge doesn't require any iATU configuration
 	 * as DBI region will be used to access root bus config space.
-	 * Immediate bus under Root Bus, needs type 0 iATU configuration and
+	 * Immediate bus under Root Bus needs type 0 iATU configuration and
 	 * remaining buses need type 1 iATU configuration.
 	 */
-	atu.index = 0;
+	atu.index = pci->ob_atu_index;
 	atu.type = PCIE_ATU_TYPE_CFG0;
 	atu.parent_bus_addr = pp->cfg0_base + SZ_1M;
 	/* 1MiB is to cover 1 (bus) * 32 (devices) * 8 (functions) */
@@ -443,6 +443,8 @@ static int dw_pcie_config_ecam_iatu(struct dw_pcie_rp *pp)
 	if (ret)
 		return ret;
 
+	pci->ob_atu_index++;
+
 	bus_range_max = resource_size(bus->res);
 
 	if (bus_range_max < 2)
@@ -455,7 +457,13 @@ static int dw_pcie_config_ecam_iatu(struct dw_pcie_rp *pp)
 	atu.size = (SZ_1M * bus_range_max) - SZ_2M;
 	atu.ctrl2 = PCIE_ATU_CFG_SHIFT_MODE_ENABLE;
 
-	return dw_pcie_prog_outbound_atu(pci, &atu);
+	ret = dw_pcie_prog_outbound_atu(pci, &atu);
+	if (ret)
+		return ret;
+
+	pci->ob_atu_index++;
+
+	return 0;
 }
 
 static int dw_pcie_create_ecam_window(struct dw_pcie_rp *pp, struct resource *res)
@@ -630,14 +638,6 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	if (ret)
 		goto err_free_msi;
 
-	if (pp->ecam_enabled) {
-		ret = dw_pcie_config_ecam_iatu(pp);
-		if (ret) {
-			dev_err(dev, "Failed to configure iATU in ECAM mode\n");
-			goto err_free_msi;
-		}
-	}
-
 	/*
 	 * Allocate the resource for MSG TLP before programming the iATU
 	 * outbound window in dw_pcie_setup_rc(). Since the allocation depends
@@ -942,7 +942,7 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 		dev_warn(pci->dev, "Ranges exceed outbound iATU size (%d)\n",
 			 pci->num_ob_windows);
 
-	pp->msg_atu_index = ++i;
+	pci->ob_atu_index = ++i;
 
 	i = 0;
 	resource_list_for_each_entry(entry, &pp->bridge->dma_ranges) {
@@ -1084,14 +1084,23 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
 	/*
 	 * If the platform provides its own child bus config accesses, it means
 	 * the platform uses its own address translation component rather than
-	 * ATU, so we should not program the ATU here.
+	 * ATU, so we should not program the ATU here. If ECAM is enabled,
+	 * config space access goes through ATU, so set up ATU here.
 	 */
-	if (pp->bridge->child_ops == &dw_child_pcie_ops) {
+	if (pp->bridge->child_ops == &dw_child_pcie_ops || pp->ecam_enabled) {
 		ret = dw_pcie_iatu_setup(pp);
 		if (ret)
 			return ret;
 	}
 
+	if (pp->ecam_enabled) {
+		ret = dw_pcie_config_ecam_iatu(pp);
+		if (ret) {
+			dev_err(pci->dev, "Failed to configure iATU in ECAM mode\n");
+			return ret;
+		}
+	}
+
 	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0);
 
 	/* Program correct class for RC */
@@ -1113,7 +1122,7 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
 	void __iomem *mem;
 	int ret;
 
-	if (pci->num_ob_windows <= pci->pp.msg_atu_index) {
+	if (pci->num_ob_windows <= pci->ob_atu_index) {
 		dev_err(pci->dev, "No available iATU enteries\n");
 		return -ENOSPC;
 	}
@@ -1127,7 +1136,7 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
 	atu.routing = PCIE_MSG_TYPE_R_BC;
 	atu.type = PCIE_ATU_TYPE_MSG;
 	atu.size = resource_size(pci->pp.msg_res);
-	atu.index = pci->pp.msg_atu_index;
+	atu.index = pci->ob_atu_index;
 
 	atu.parent_bus_addr = pci->pp.msg_res->start - pci->parent_bus_offset;
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index c644216995f69cbf065e61a0392bf1e5e32cf56e..f9f3c2f3532e0d0e9f8e4f42d8c5c9db68d55272 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -476,6 +476,9 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
 	u32 retries, val;
 	u64 limit_addr;
 
+	if (atu->index > pci->num_ob_windows)
+		return -ENOSPC;
+
 	limit_addr = parent_bus_addr + atu->size - 1;
 
 	if ((limit_addr & ~pci->region_limit) != (parent_bus_addr & ~pci->region_limit) ||
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index e995f692a1ecd10130d3be3358827f801811387f..efbcc141a26e179cb2e4acf6d2d19d75535ddb91 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -424,7 +424,6 @@ struct dw_pcie_rp {
 	raw_spinlock_t		lock;
 	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
 	bool			use_atu_msg;
-	int			msg_atu_index;
 	struct resource		*msg_res;
 	bool			use_linkup_irq;
 	struct pci_eq_presets	presets;
@@ -502,6 +501,7 @@ struct dw_pcie {
 	resource_size_t		atu_phys_addr;
 	size_t			atu_size;
 	resource_size_t		parent_bus_offset;
+	int			ob_atu_index;
 	u32			num_ib_windows;
 	u32			num_ob_windows;
 	u32			region_align;

-- 
2.34.1


