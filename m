Return-Path: <linux-pci+bounces-38966-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3592BFAB14
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 09:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11860483DD3
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 07:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3872FD69A;
	Wed, 22 Oct 2025 07:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WVg9qXjo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F24B2FD684
	for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2025 07:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761119538; cv=none; b=IxTrK3C4dpu8P/Yxz3yV9n8QNcM2JkwKN7/XuBTP/Oa594nnjixwY/zEAZYDdWmRt5SY1cvA5mjkglXG7TfhEFUALB2rN5AtlYtFWfZvhuIWBwRS5PDzAvE5J7cgiJDEH/5fffPrcuf+mPIB448QL1yVs4wT8QA6hLBkt7mTeBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761119538; c=relaxed/simple;
	bh=FPPlpLkszDfLj/huk9G6D1NresYhSMQaWaal3M8cqFs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HnrT89xGlqCV5qjGE4+gS3pqQC84A7bQre+/dPkm7JnWsb5/zZnjMReq8Kf+qr9XwzK2aaGRH6780FWMr0jOXxmc05B0E1cU22ckZFScRRiYvkz5Ti9iPbnHxID8Fdx8f6h3rQjfVWyaF4YT/7xZQAbLPNjj94o8TvizaaZvtvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WVg9qXjo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M2nK48032407
	for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2025 07:52:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1XhTQViaV/X39Anyp8PIXrWuoocdYUl600DmjKTyrwo=; b=WVg9qXjovDTGU7zR
	N/3nbr54qtCPkA0QVCqhggOOIU1SlVHrVhcVFQUrD7J1VQbqT0HwJJCXSpwit5i/
	FSr5E+nGEAGyfpzQ1kUE/Y9vk2NJZBWytzXlL9Rn0My4E+SVsLn0D/zV04fcVKqn
	iCo3XUWf17t4Jm68knN6ZHrcRIKwH36o9U1Wcale4v2KJVwET/lDRDlkTYVp/e5J
	DoOVXWMbSN6nBki2vYOQhJX77Ayff5K9V+hzNzDinAxMYiXN3wwz+XtKvzAhTckk
	RvH0LoO0F+TW+DI2uqnK5fotvboLOOIsl/mPyNZqr11SCR7Cm3OSxa8eltw2tngC
	tVt9fw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v42kbkcv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2025 07:52:15 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2930e6e2c03so2828145ad.3
        for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2025 00:52:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761119535; x=1761724335;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1XhTQViaV/X39Anyp8PIXrWuoocdYUl600DmjKTyrwo=;
        b=jJP+QskSu1CzaEKwWsB2udWCkRjfHBhWZvkMe/VZ3WHLNzMmBqSjQU7PKP7DWNBasA
         aqaTNLEIhGieswwylNLbtu3tuzPY+CUimhX6l5s9U4JxyCnhnS7pftt71KPc6dkr5pbD
         WyN1/Vboe+Kic85x2GV4RdsWY2KVmE3d4fE0Zg5KFh8aQWwvvcMJfmGlKkq9yk0NX8hZ
         KLzUJJN6eDWPHoMgsSBMKbNjcKnIo/croUVxlw7/D/0ejeD+2ceEFvAad6hGtCpyUugi
         nFgEXU3q0903O9WKmsu0+5lxi/rfWHbTvXbcFxPdTEqwX9rWOVhTzH19kqYhTnBRk4OS
         eHvw==
X-Gm-Message-State: AOJu0YwMrjsI9oC568IXyVobuKGarzs5LJnKGrDDgyl50j+vw+dcEm33
	sVJAO8npLXc6Br5OtSagSpcUmPHd1G+lLQL27cH40pECvWj1uoFmupTh+JqyX5rTHKjgkSh2iHS
	S/Fh3KfXXIhysE/QllGzf/fMBHKQnLy7MnLcr0vmZJom1xX13kWHzdG0AZcz7Q6g=
X-Gm-Gg: ASbGncvip1ykrdI2RGU4bpAdA9ZagzcRejCTEUx/ZXTmtTrpjfG+JZecAI8X5m7PG6k
	eKaDVetn4G/F07pB50Endz+b4jswoDhXzAmY7O0eaMzUBvn4gC74BanVUJbmV9T4lJSDmMKiNF9
	+ubey6R3oWB0+WEVwEKfgTF7aSPbSdL0Mw+jT2/wMOWDITT5fbPwEIRUMe4ChYXaKTG9dSzUnmv
	IjethH25V8e2Q3qKzYjdPgAGKYy4hzjOhEM9F8nJe5mlSzSdwi5l4X1uoHEy9H4I9A4cbrdq+30
	XNsgG17AH15g7s4aMJE+/x5h5AjOge7HBfrXNI5n/nA0nIzZvvqLaaHBQezhS2z6h7qlPxzNM8S
	cTCx5xbAtn/X8mwq27IkdaHUMD60t9HBxlg==
X-Received: by 2002:a17:902:c942:b0:290:c5c8:9419 with SMTP id d9443c01a7336-290cb65b8e4mr250331585ad.48.1761119534676;
        Wed, 22 Oct 2025 00:52:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGqlXT6fObHhgr1D2s85s+Pv0yavAO6a7DXv5jdQ3toDjpK+j4sVXiG3YIRDD8cQ3vqXRO0Q==
X-Received: by 2002:a17:902:c942:b0:290:c5c8:9419 with SMTP id d9443c01a7336-290cb65b8e4mr250331255ad.48.1761119534226;
        Wed, 22 Oct 2025 00:52:14 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fe2c2sm130962275ad.79.2025.10.22.00.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 00:52:13 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 13:22:00 +0530
Subject: [PATCH v2 1/2] PCI: dwc: Fix ECAM enablement when used with vendor
 drivers
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-ecam_fix-v2-1-e293b9d07262@oss.qualcomm.com>
References: <20251022-ecam_fix-v2-0-e293b9d07262@oss.qualcomm.com>
In-Reply-To: <20251022-ecam_fix-v2-0-e293b9d07262@oss.qualcomm.com>
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Ron Economos <re@w6rz.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761119527; l=3184;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=FPPlpLkszDfLj/huk9G6D1NresYhSMQaWaal3M8cqFs=;
 b=uN/3l2SCGQPO7zxgVFtEl7qZ1QV32AyKSorVhSrZUlAabqbmVIrMdvtG1a4tyU6XQywyr8J0s
 eeOrhLz6yziBsLjSRO5ndXRi+0t507j5jlJg4dYjjJs+YoPjNj4I8I7
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: lgWBCgrMJanrYCx4M3A7UXAqPAC9UMjP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAzMSBTYWx0ZWRfXzkQfJbRHwbEW
 ueT/pIMLvLlRjUPuQ+Vau9jAiAX49Q5jQrJLevPc2IyrZZCPsqy4dt1+jNhay4QdypXy/6oB6qf
 4TbUC8J/qCugfA/osUpV8xPCrCD2j3Xv7dNXZGtiUeUubvHzwO7bH5HAirkmk1kprCkOdABqfWU
 R5mZhPINuK1s/ilU4Y+WOJiuLN2O2bdkrrvzlRwNCw6epZ3w6JlydRLJz79bdC2QpFQ2mUvfOhg
 Aachi5Mo16Ulj35Mwh4dhDO3tUHpTy325zXtVWJBNJjk713AUGR7oA7JaZ9RViuQU+gbWX7pEB7
 8GcTf9nPKV0/aTzRj21rwJhtitCkX7mSU7Uq4EhYUwa3Dqd6QjTsBmUHsLbKBv9reyhfILuuvAR
 YJNXrb/mbVdShADMYxac7slwmhqsUQ==
X-Authority-Analysis: v=2.4 cv=QYNrf8bv c=1 sm=1 tr=0 ts=68f88d2f cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=HaFmDPmJAAAA:8 a=EUspDBNiAAAA:8 a=h4B-02p0z56_JbXvspoA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=nmWuMzfKamIsx3l42hEX:22
X-Proofpoint-ORIG-GUID: lgWBCgrMJanrYCx4M3A7UXAqPAC9UMjP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180031

When the vendor configuration space is 256MB aligned, the DesignWare
PCIe host driver enables ECAM access and sets the DBI base to the start
of the config space. This causes vendor drivers to incorrectly program
iATU regions, as they rely on the DBI address for internal accesses.

To fix this, avoid overwriting the DBI base when ECAM is enabled.
Instead, introduce a custom ECAM PCI ops implementation that accesses
the DBI region directly for root bus and uses ECAM for other buses.

Fixes: f6fd357f7afb ("PCI: dwc: Prepare the driver for enabling ECAM mechanism using iATU 'CFG Shift Feature'")
Reported-by: Ron Economos <re@w6rz.net>
Closes: https://lore.kernel.org/all/eac81c57-1164-4d74-a1b4-6f353c577731@w6rz.net/
Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
Tested-by: Ron Economos <re@w6rz.net>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 28 +++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 20c9333bcb1c4812e2fd96047a49944574df1e6f..7d95d8ec9f8190dbde80283db78ca74925532d2e 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -23,6 +23,7 @@
 #include "pcie-designware.h"
 
 static struct pci_ops dw_pcie_ops;
+static struct pci_ops dw_pcie_ecam_ops;
 static struct pci_ops dw_child_pcie_ops;
 
 #define DW_PCIE_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS		| \
@@ -471,9 +472,6 @@ static int dw_pcie_create_ecam_window(struct dw_pcie_rp *pp, struct resource *re
 	if (IS_ERR(pp->cfg))
 		return PTR_ERR(pp->cfg);
 
-	pci->dbi_base = pp->cfg->win;
-	pci->dbi_phys_addr = res->start;
-
 	return 0;
 }
 
@@ -529,7 +527,7 @@ static int dw_pcie_host_get_resources(struct dw_pcie_rp *pp)
 		if (ret)
 			return ret;
 
-		pp->bridge->ops = (struct pci_ops *)&pci_generic_ecam_ops.pci_ops;
+		pp->bridge->ops = &dw_pcie_ecam_ops;
 		pp->bridge->sysdata = pp->cfg;
 		pp->cfg->priv = pp;
 	} else {
@@ -842,12 +840,34 @@ void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus, unsigned int devfn,
 }
 EXPORT_SYMBOL_GPL(dw_pcie_own_conf_map_bus);
 
+static void __iomem *dw_pcie_ecam_conf_map_bus(struct pci_bus *bus, unsigned int devfn, int where)
+{
+	struct pci_config_window *cfg = bus->sysdata;
+	struct dw_pcie_rp *pp = cfg->priv;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+
+	if (bus == pp->bridge->bus) {
+		if (PCI_SLOT(devfn) > 0)
+			return NULL;
+
+		return pci->dbi_base + where;
+	}
+
+	return pci->dbi_base + where;
+}
+
 static struct pci_ops dw_pcie_ops = {
 	.map_bus = dw_pcie_own_conf_map_bus,
 	.read = pci_generic_config_read,
 	.write = pci_generic_config_write,
 };
 
+static struct pci_ops dw_pcie_ecam_ops = {
+	.map_bus = dw_pcie_ecam_conf_map_bus,
+	.read = pci_generic_config_read,
+	.write = pci_generic_config_write,
+};
+
 static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);

-- 
2.34.1


