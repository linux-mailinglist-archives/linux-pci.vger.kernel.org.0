Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7315377A22
	for <lists+linux-pci@lfdr.de>; Mon, 10 May 2021 04:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhEJCbk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 May 2021 22:31:40 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:36754 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbhEJCbj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 May 2021 22:31:39 -0400
Received: by mail-ed1-f47.google.com with SMTP id u13so16895361edd.3
        for <linux-pci@vger.kernel.org>; Sun, 09 May 2021 19:30:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qgH58BAOymX/GqbeUamZa2hFOuXJqDwbXTCnQb9+5EM=;
        b=ZUOxoC81xktmfgGiiTNomd6ZW1mjGkpg0KFkcBRXnEEUkWdSsciFUN8vtwe4nuhEdX
         EjM8yPpChNhc6lZ+b/+XSkBKyRRmiW3O1ToPEGGr6Iyw39sTytY2VwBXICspgdAcj0PS
         5YfPrtEX7g8vY1DUaaUw8+4yH7EOvUygCHbOsii7jycj8/vRNO2DuRDSpbqKo2GdWWaX
         QgNmc5goph9GLuHursGCFeWW5u1BiTCyAGzDG7UY0vJ35HWSSuSuAZ0A/KHbrHcj0JjV
         xK1/2ztktHKp6NFIxe/fnC2Q2zHn2e3pBKdhmKb6k4nUbBhJaE6+MlKIx3ZuWzGJzyjQ
         rEIA==
X-Gm-Message-State: AOAM530jtwi8n/ZOy03wkyD413uh4PuPMqUSiQBIzSZt7BnwBnQ2Ku+8
        BKWxFDFZpehRyWRcpe79Xu0=
X-Google-Smtp-Source: ABdhPJxoipCH5UocZZt+ENwCy+aLiX58y4aHPPfgTjQ/s7QNDUSvVzbHBdwa1Sdmm3aOVg19/kAYBg==
X-Received: by 2002:a05:6402:120c:: with SMTP id c12mr26504611edw.98.1620613834203;
        Sun, 09 May 2021 19:30:34 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id x18sm8261172eju.45.2021.05.09.19.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 19:30:33 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] PCI: mobiveil: Remove unused readl and writel functions
Date:   Mon, 10 May 2021 02:30:32 +0000
Message-Id: <20210510023032.3063932-1-kw@linux.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCIe host controller driver for Layerscape 4th generation SoC was
added in the commit d29ad70a813b ("PCI: mobiveil: Add PCIe Gen4 RC
driver for Layerscape SoCs").

At this time two static functions were introduced that appear to
currently have no users.  Since nothing is using neither of these
functions at the moment they can be safely removed.

This resolves the following build time warnings:

  drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c:45:19: warning: unused function 'ls_pcie_g4_lut_readl' [-Wunused-function]
  drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c:50:20: warning: unused function 'ls_pcie_g4_lut_writel' [-Wunused-function]

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 .../pci/controller/mobiveil/pcie-layerscape-gen4.c    | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c b/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
index ee0156921ebc..306950272fd6 100644
--- a/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
+++ b/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
@@ -42,17 +42,6 @@ struct ls_pcie_g4 {
 	int irq;
 };
 
-static inline u32 ls_pcie_g4_lut_readl(struct ls_pcie_g4 *pcie, u32 off)
-{
-	return ioread32(pcie->pci.csr_axi_slave_base + PCIE_LUT_OFF + off);
-}
-
-static inline void ls_pcie_g4_lut_writel(struct ls_pcie_g4 *pcie,
-					 u32 off, u32 val)
-{
-	iowrite32(val, pcie->pci.csr_axi_slave_base + PCIE_LUT_OFF + off);
-}
-
 static inline u32 ls_pcie_g4_pf_readl(struct ls_pcie_g4 *pcie, u32 off)
 {
 	return ioread32(pcie->pci.csr_axi_slave_base + PCIE_PF_OFF + off);
-- 
2.31.1

