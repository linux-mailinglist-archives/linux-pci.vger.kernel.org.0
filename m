Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4C472A889B
	for <lists+linux-pci@lfdr.de>; Thu,  5 Nov 2020 22:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgKEVML (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Nov 2020 16:12:11 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41874 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732284AbgKEVMK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Nov 2020 16:12:10 -0500
Received: by mail-ot1-f66.google.com with SMTP id n15so2770910otl.8
        for <linux-pci@vger.kernel.org>; Thu, 05 Nov 2020 13:12:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6joTqsvyj5X+/mMckRYOhYHQCTeXTFX8sI/b999CKSE=;
        b=cA1/Gz2IMpBLmhvEWRei+OcA4j/JXgldIRqCodEEjHUdLxLvk4dYNSloApGfGxKzcF
         /fp6VAN1Tn0vjC7N3L1JTrG9O33BmpdFg6U3XwWdXHlaDWiDh+gHA6bqfK/Se9Qf5lfl
         ebRu/qtLa2xzZlnYxAt1ivlTruVIQsXQhVC97Lz1sSMdMtLc5xDQQQnkMrYiLVp3RtMN
         zjToJ7PKdGlAgkC/eq+3XRIMx3E5bcvgV8JOxr29kca+SCBYcExb8vWbUWCWdD9nYGSf
         /2x65Kz3TXXfXy1b7YJ2we3mUM98wToEVrB4UrmUPP5kh1fIYjLmOPXauJxvpexBVMvq
         XJIg==
X-Gm-Message-State: AOAM5331gGmeYWmWu517Zr1U/OeMa12LwGBABuh1C6ZQcZLkCA2xQdc8
        5+Ik6IGbqxoUupNbjr0BN7ttg/XyKZt+
X-Google-Smtp-Source: ABdhPJy703tWPiNw+Qqc8ucrmYgfKgqd7wtzHksUUpAdBdq/hY3pvYUxigfqVa2L2+navOGrdkxvaw==
X-Received: by 2002:a9d:550a:: with SMTP id l10mr2713270oth.357.1604610729465;
        Thu, 05 Nov 2020 13:12:09 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id z19sm622549ooi.32.2020.11.05.13.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 13:12:08 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 05/16] PCI: dwc: Ensure all outbound ATU windows are reset
Date:   Thu,  5 Nov 2020 15:11:48 -0600
Message-Id: <20201105211159.1814485-6-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201105211159.1814485-1-robh@kernel.org>
References: <20201105211159.1814485-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Layerscape driver clears the ATU registers which may have been
configured by the bootloader. Any driver could have the same issue
and doing it for all drivers doesn't hurt, so let's move it into the
common DWC code.

Cc: Minghuan Lian <minghuan.Lian@nxp.com>
Cc: Mingkai Hu <mingkai.hu@nxp.com>
Cc: Roy Zang <roy.zang@nxp.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: linuxppc-dev@lists.ozlabs.org
Acked-by: Jingoo Han <jingoohan1@gmail.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pci-layerscape.c       | 14 --------------
 drivers/pci/controller/dwc/pcie-designware-host.c |  5 +++++
 2 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
index f24f79a70d9a..53e56d54c482 100644
--- a/drivers/pci/controller/dwc/pci-layerscape.c
+++ b/drivers/pci/controller/dwc/pci-layerscape.c
@@ -83,14 +83,6 @@ static void ls_pcie_drop_msg_tlp(struct ls_pcie *pcie)
 	iowrite32(val, pci->dbi_base + PCIE_STRFMR1);
 }
 
-static void ls_pcie_disable_outbound_atus(struct ls_pcie *pcie)
-{
-	int i;
-
-	for (i = 0; i < PCIE_IATU_NUM; i++)
-		dw_pcie_disable_atu(pcie->pci, i, DW_PCIE_REGION_OUTBOUND);
-}
-
 static int ls1021_pcie_link_up(struct dw_pcie *pci)
 {
 	u32 state;
@@ -136,12 +128,6 @@ static int ls_pcie_host_init(struct pcie_port *pp)
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct ls_pcie *pcie = to_ls_pcie(pci);
 
-	/*
-	 * Disable outbound windows configured by the bootloader to avoid
-	 * one transaction hitting multiple outbound windows.
-	 * dw_pcie_setup_rc() will reconfigure the outbound windows.
-	 */
-	ls_pcie_disable_outbound_atus(pcie);
 	ls_pcie_fix_error_response(pcie);
 
 	dw_pcie_dbi_ro_wr_en(pci);
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index cde45b2076ee..265a48f1a0ae 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -534,6 +534,7 @@ static struct pci_ops dw_pcie_ops = {
 
 void dw_pcie_setup_rc(struct pcie_port *pp)
 {
+	int i;
 	u32 val, ctrl, num_ctrls;
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 
@@ -583,6 +584,10 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 		PCI_COMMAND_MASTER | PCI_COMMAND_SERR;
 	dw_pcie_writel_dbi(pci, PCI_COMMAND, val);
 
+	/* Ensure all outbound windows are disabled so there are multiple matches */
+	for (i = 0; i < pci->num_viewport; i++)
+		dw_pcie_disable_atu(pci, i, DW_PCIE_REGION_OUTBOUND);
+
 	/*
 	 * If the platform provides its own child bus config accesses, it means
 	 * the platform uses its own address translation component rather than
-- 
2.25.1

