Return-Path: <linux-pci+bounces-44319-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6CDD070F3
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 05:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66B7D301A1A5
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 04:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB142C08D5;
	Fri,  9 Jan 2026 04:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQs0BSM0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2DD2561A7
	for <linux-pci@vger.kernel.org>; Fri,  9 Jan 2026 04:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767931709; cv=none; b=aUzcGc1D02GiIgcSL70mVTwbZE8cHkuXIDwkh76AXO2k6zKtmapY5u9BXSzAtZ/XmEawywAEQEmsQOOvPFVo+aAVgS7X+o8Asa0vr0FhKRZz2Q3h1O+sw6GGnctfyF2e04kTKUmtPTIKcJATZK/F8b6+JjV9J6bbAtyf/Ge0kOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767931709; c=relaxed/simple;
	bh=2mcRdk8NIW4UsXr59JY8Y3kTFZlEmbKvPrEyHwut2sM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f6V9k/2A62Xb2S0mbTYjWHoOWT4ZF/QJae6JMru2EiiiOZ8n++AQDGFT7f9sM29sv9nGDOnDOMJGbYojkffvSa548LyxQykxb9BYTTI2C4kbLvD0x1rp4Weallv42pHid8igJBPbotc4qA3/kC2Dx2laFhuDz3rxl7A5Swu2ykU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQs0BSM0; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-122008d4054so825088c88.1
        for <linux-pci@vger.kernel.org>; Thu, 08 Jan 2026 20:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767931707; x=1768536507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EDDoKbdnv2trjkmUU76X6syGqHliuOylCy3tou2sxDA=;
        b=CQs0BSM0x5ruIDzfr10tqUzYXPrloRdEoczmHeusM//rh4RchUVwfQkxmK6BU1I1C3
         ZuRmvx3AR+KmNsgbu1UqlP1+GFH6ehSOBq4TOV0/5DWuejxwzvfma3Pazy/M4qi+qQKa
         Psl0dG/0bhsiZePXCV26haeI2mgMpjq7is9ApPGLRKD+EG0qkJ6U/VN/O0P2rb9YL7ld
         aqUWqfLgDIHsvBn25BXYHT8qS+GjgGoSMTEH2NzrPDeueW9YfMAGfRIC8ddnMuWpvhKI
         QSHX4x+Cj5PNiFl75HCZjGJv46iGP0UAqdxvV1bbTtqlbDccF9xgpJS6Juv8i648towK
         6gyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767931707; x=1768536507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDDoKbdnv2trjkmUU76X6syGqHliuOylCy3tou2sxDA=;
        b=LmWHi0tO+z1W6T2wVTBlJaZRI05K0sYcHoY8X5dt19FNtFXjM6tMCQBzvux9zN6iLk
         gIZ3FrtIxXPuQcAw+4Wg0wBkAXroG7elikx2AUzRqCMao+aXaGUT+nI5mhid/mSwkwhp
         nGDqlTz2iWpxlJF6URtmUBLnbDl3Ufr5v4FR+LQp+ClFgIKeT6HlwX/WRzvvgt1sYrKI
         Fe/U79XzaFiesRDii1+BSQuW6iVgp10Ov3uDbHzMFb3t6BN/Pz6c7ZC52bRjhqXr3i/k
         ZhOlaepjkjaToDDp9xJ83lv793L1Q7EL3kk1X9RXLgk89M3RK+6xm2U9zK+iuyV93S69
         PQYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpU3DTFBwm+sCUhVdW8WBs4+PTrSGEIaCrIGKo9w+9+2LBOekyqmQ6rYami9ZIdHq93o9X8gOmWnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBmlm6UEKyLTUdc0pfeU4XdUwufN/y7REFsYJ6ehdK+N/o1Nyk
	lhMCrT2HlQ1YQj21W+bzKugYJYZBWtIiQR/DsKKN8ok14GSADflBuNJc
X-Gm-Gg: AY/fxX6e4wrbWAI6SmNDPrRHLIHv5K1950BCdoQb3SKsK6YrUUC+nx/PWpzZkyzmRhC
	mFwoRngpiS8nyET1xa4+l2dzKS/jzxmMMT04h4jvpPmYJQkdRDVmfq2P0MyAZUoCSGPvuRqFuFz
	wkHJQMJwOxsrT/UzDyxlQHFuw619SxEmRvzsqksw+Off2WF37SNK3NCJUNjP6LKJs/YBIDtqjJy
	vn1CuZHEYw8rlCYwoh3lH9jhOXAaLmoC16Fx2ijmI/F4u0zVrpTsniCB87qSGGfOH0imbIBL0F/
	1yaA2oeBpvVKWBqBVHyMGtnxZxAF1at61nnb6WFTuyMcPJ/tu1yPa8i50f/ZsdYTiqljFU0oJYN
	q1KTqWtsq894H6Lcft5SH+1TtrffAuwLaeqlmj8hNvEgh+t9S9Xp/xKfw/T8iXD4/SfHdFNNe4n
	QM3GXnhvip+Q==
X-Google-Smtp-Source: AGHT+IHYEyj9/7o+tBP0yDD4Xk/5DkC3757Xe2hVibZ6VY5BlbkB0VR0LKgl6GAvoD4FVDJZvGGtvQ==
X-Received: by 2002:a05:7022:3d04:b0:119:e569:f86a with SMTP id a92af1059eb24-121f85f242fmr7240325c88.7.1767931707386;
        Thu, 08 Jan 2026 20:08:27 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f248c239sm12869881c88.9.2026.01.08.20.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 20:08:26 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>
Cc: Han Gao <rabenda.cn@gmail.com>,
	linux-pci@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Han Gao <gaohan@iscas.ac.cn>
Subject: [PATCH] PCI/sophgo: Avoid L0s and L1 on Sophgo 2044 PCIe Root Ports
Date: Fri,  9 Jan 2026 12:07:53 +0800
Message-ID: <20260109040756.731169-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM
states for devicetree platforms") force enable ASPM on all device tree
platform, the SG2044 root port breaks as it advertises L0s and L1
capabilities without supporting it.

Mask the L0s and L1 Support advertised in Link Capabilities
in the LINKCAP register SG2044 Root Ports, so the framework
won't try to enable those states.

Fixes: 3309df45e6b5 ("riscv: dts: sophgo: sg2044: add PCIe device support for SG2044")
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Tested-by: Han Gao <gaohan@iscas.ac.cn>
---
Change from original patch:
1. use driver to mask the ASPM advertisement

Separate from the folloing patch
- https://lore.kernel.org/all/20251225100530.1301625-1-inochiama@gmail.com
---
 drivers/pci/controller/dwc/pcie-sophgo.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-sophgo.c b/drivers/pci/controller/dwc/pcie-sophgo.c
index ad4baaa34ffa..044088898819 100644
--- a/drivers/pci/controller/dwc/pcie-sophgo.c
+++ b/drivers/pci/controller/dwc/pcie-sophgo.c
@@ -161,6 +161,22 @@ static void sophgo_pcie_msi_enable(struct dw_pcie_rp *pp)
 	raw_spin_unlock_irqrestore(&pp->lock, flags);
 }

+static void sophgo_pcie_disable_l0s_l1(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	u32 offset, val;
+
+	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+
+	dw_pcie_dbi_ro_wr_en(pci);
+
+	val = dw_pcie_readl_dbi(pci, PCI_EXP_LNKCAP + offset);
+	val &= ~(PCI_EXP_LNKCAP_ASPM_L0S | PCI_EXP_LNKCAP_ASPM_L1);
+	dw_pcie_writel_dbi(pci, PCI_EXP_LNKCAP + offset, val);
+
+	dw_pcie_dbi_ro_wr_dis(pci);
+}
+
 static int sophgo_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	int irq;
@@ -171,6 +187,8 @@ static int sophgo_pcie_host_init(struct dw_pcie_rp *pp)

 	irq_set_chained_handler_and_data(irq, sophgo_pcie_intx_handler, pp);

+	sophgo_pcie_disable_l0s_l1(pp);
+
 	sophgo_pcie_msi_enable(pp);

 	return 0;
--
2.52.0


