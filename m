Return-Path: <linux-pci+bounces-28737-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCDDAC97CE
	for <lists+linux-pci@lfdr.de>; Sat, 31 May 2025 00:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C94491BC6AD3
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 22:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE77028C2C8;
	Fri, 30 May 2025 22:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KL4sA+P3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658A328C03D
	for <linux-pci@vger.kernel.org>; Fri, 30 May 2025 22:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748644850; cv=none; b=h80e63x8thdgC68EiNUYScxfbR5Uu49pys8LfPHxoWGdQAydF80fYiZqNl9wgpx27IVWrukEKokhFujWi2mWnnMhgZKrFCx0RDv2f4dRm/A9g8x37osw9vtcd8acPcy9JWZrMANlMCbzQJ5SW5/zTt61WuE09CL4+XfOrGo/Cas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748644850; c=relaxed/simple;
	bh=BGvgbn1BZa2sYB+McU5CilQTpp9thj8nlJpUAkHvvj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aclOq/MSxq6NJmz3jUJ81cZZoWhSTLfKzonaBdoWlX5olFFDbmL0rrMkWiLhL4n2CHU9ifsRzGiwMCknpYmvlLKnOExQza0vqpIWFSf8LfjCQfAqvg3XG+70X1MnckCefOft+bMBHsIdgzCU/DtMfimPK+LK0xW5tI7i6n3+aY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KL4sA+P3; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-234b9dfb842so25045605ad.1
        for <linux-pci@vger.kernel.org>; Fri, 30 May 2025 15:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1748644848; x=1749249648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=meW30IDDO+azkqeYGaD+b0CQRVW934zmu7s9bUahNtU=;
        b=KL4sA+P3BA3y5VWJ+T58sFUDlaPxR/njNqDm8lMORDIfjHEvnr7ITHWJ0h0KqpOhiZ
         qlcJCWQduGtQPyV+ZH6EwX1ErSO1LD2ByO4YAN1EgUu/MGqricAraSv6BIoLhnXCvkRA
         HsEzeMXpH7EAqQ1PV25xRdb61mD2ITb2cb+Ms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748644848; x=1749249648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=meW30IDDO+azkqeYGaD+b0CQRVW934zmu7s9bUahNtU=;
        b=pibPqamu7w/nIBxozLLd+8CGhuaGzMYNwi88iRhAAWgU6sLZgORqKsuCR+ptfsdZGO
         PF/FiXI/5z2Up8npvwaYEIkFlvRSYWy5nmevygRTZRpmH6hyehFEo/RocBGaRGftuDFT
         fIuXyEQBSCjDKxeqTgx/bLzjXhAvQk7Xc6d/uZmEy3WWUhcWpShAnrV41fO4UI4kZaPu
         KVgU6B6YL4aOh+XxOndZmy0Tw6oaYmpalNvdloyIQgaygi/LQ/QnxEAI9crYN3KfZxLZ
         6m+vI65GyBjCwLLTyNg4T2KUQgeULDY4izm5n7QUaNH2ZCQ9iOu+DNLs8ET/M203Cweq
         /Lig==
X-Gm-Message-State: AOJu0Yw9GAU+heWQ5Xf8TsMyW07h7KbLU+KEjSEY7XOnlFuWU1dDKPC0
	lhHTBQPt/Hvrvux5qyO4RxO/7Esw30KAL7MS4IiZROJxLBqvlynLMQk3XTaemOASk53FhNAMBbO
	4OzhRktf9wRU9uutSnBA3l9FSJ8qjcerIcqQHxVZVYGUqMxMrV8u5pN9szSM6tMuupJupmJ5V6d
	bl/E0nze3qum9ziW4YIxLRyl/TLDJGxXYK3o8A3XlbezpTR7FZTrWT
X-Gm-Gg: ASbGncsuZ8Vo3AnjmH2RQ2efEDUQZGCC4AVrOhSkD9pmoNxMFIBL3hjmpBgoiB8m7Hf
	XANOyOCm30lsR3BqO4oWlH4YnCp5o7B4ckcs8I5LP3q56ymI9HaBvSPDpuXbcGG5z9ypbyNhcbZ
	1sanXw8lrGFczobOBcyoWLET0ueXRZiRZWH8DcgapLhP5Vzllr6cdIIzw69rDSC8AwIEGrcy2rY
	e8SjDhdCbSltcZbfXPcsI3E7MXHRTbZlpJ23SMdjiEtvT4fdACPkXxdRNF2jp7NyHX3Qj2ehi6S
	BLDSpe0E7pQUQGIsn3XIQXyB7i7dKw/Lr4+1/GMum3MaG1zwodq4gFWiAqLpWG0AUchzXfEywlD
	lAr3fUTBYgF9p4Hb4BzfcRlGF2XKbGyNtZYoMX4P8RA==
X-Google-Smtp-Source: AGHT+IGL4F0Y7fvmsQ/3UEqROCzrPd3eOAG4Vh0WKC1WvYBSk1U1yO1TsWce/E4di6e9o+pfZ3ki5g==
X-Received: by 2002:a17:902:d4c1:b0:234:8eeb:d82d with SMTP id d9443c01a7336-23528de8f60mr78383255ad.19.1748644848195;
        Fri, 30 May 2025 15:40:48 -0700 (PDT)
Received: from stbsrv-and-02.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cf523esm33109385ad.170.2025.05.30.15.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 15:40:47 -0700 (PDT)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	bcm-kernel-feedback-list@broadcom.com,
	jim2101024@gmail.com,
	james.quinlan@broadcom.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] PCI: brcmstb: Use "num-lanes" DT property if present
Date: Fri, 30 May 2025 18:40:33 -0400
Message-ID: <20250530224035.41886-3-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250530224035.41886-1-james.quinlan@broadcom.com>
References: <20250530224035.41886-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By default, we use automatic HW negotiation to ascertain the number of
lanes of the PCIe connection.  If the "num-lanes" DT property is present,
assume that the chip's built-in capability information is incorrect or
undesired, and use the specified value instead.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index e19628e13898..79fc6d00b7bc 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -46,6 +46,7 @@
 #define  PCIE_RC_CFG_PRIV1_ID_VAL3_CLASS_CODE_MASK	0xffffff
 
 #define PCIE_RC_CFG_PRIV1_LINK_CAPABILITY			0x04dc
+#define  PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_MAX_LINK_WIDTH_MASK	0x1f0
 #define  PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK	0xc00
 
 #define PCIE_RC_CFG_PRIV1_ROOT_CAP			0x4f8
@@ -55,6 +56,9 @@
 #define PCIE_RC_DL_MDIO_WR_DATA				0x1104
 #define PCIE_RC_DL_MDIO_RD_DATA				0x1108
 
+#define PCIE_RC_PL_REG_PHY_CTL_1			0x1804
+#define  PCIE_RC_PL_REG_PHY_CTL_1_REG_P2_POWERDOWN_ENA_NOSYNC_MASK	0x8
+
 #define PCIE_RC_PL_PHY_CTL_15				0x184c
 #define  PCIE_RC_PL_PHY_CTL_15_DIS_PLL_PD_MASK		0x400000
 #define  PCIE_RC_PL_PHY_CTL_15_PM_CLK_PERIOD_MASK	0xff
@@ -1072,7 +1076,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	void __iomem *base = pcie->base;
 	struct pci_host_bridge *bridge;
 	struct resource_entry *entry;
-	u32 tmp, burst, aspm_support;
+	u32 tmp, burst, aspm_support, num_lanes, num_lanes_cap;
 	u8 num_out_wins = 0;
 	int num_inbound_wins = 0;
 	int memc, ret;
@@ -1180,6 +1184,26 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 		PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK);
 	writel(tmp, base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
 
+	/* 'tmp' still holds the contents of PRIV1_LINK_CAPABILITY */
+	num_lanes_cap = u32_get_bits(tmp, PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_MAX_LINK_WIDTH_MASK);
+	num_lanes = 0;
+	/*
+	 * Use automatic num-lanes HW negotiation by default.  If the
+	 * "num-lanes" DT property is present, assume that the chip's
+	 * built-in link width capability information is
+	 * incorrect/undesired and use the specified value instead.
+	 */
+	if (!of_property_read_u32(pcie->np, "num-lanes", &num_lanes) &&
+	    num_lanes && num_lanes <= 4 && num_lanes_cap != num_lanes) {
+		u32p_replace_bits(&tmp, num_lanes,
+			PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_MAX_LINK_WIDTH_MASK);
+		writel(tmp, base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
+		tmp = readl(base + PCIE_RC_PL_REG_PHY_CTL_1);
+		u32p_replace_bits(&tmp, 1,
+			PCIE_RC_PL_REG_PHY_CTL_1_REG_P2_POWERDOWN_ENA_NOSYNC_MASK);
+		writel(tmp, base + PCIE_RC_PL_REG_PHY_CTL_1);
+	}
+
 	/*
 	 * For config space accesses on the RC, show the right class for
 	 * a PCIe-PCIe bridge (the default setting is to be EP mode).
-- 
2.43.0


