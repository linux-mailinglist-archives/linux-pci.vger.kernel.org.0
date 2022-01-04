Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A86534844D5
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jan 2022 16:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234986AbiADPig (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jan 2022 10:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234957AbiADPid (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jan 2022 10:38:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3417BC061761;
        Tue,  4 Jan 2022 07:38:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5C97614CF;
        Tue,  4 Jan 2022 15:38:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B87C36AF2;
        Tue,  4 Jan 2022 15:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641310712;
        bh=xxyZnGOuH63mToYeFJtMrqvVZxip4BN1x7ap3lhZeHA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BS0s+Z26wLT5UtAOTKS7r2L2eShBR7d099GDOIG09ymgvHAXOdP/3MA7zVXYsckTC
         bLYbOYH0jfGZNJxAjDxp0XojSI55IQTjJv5kxt3LcjIy6lumb33kc/74X94U0pVocl
         MWmNyywDVS01UQLQlCg2qaQh17yGZ9qxCABrrfO40FVuSogkQEBFkC3BxZqZm4ZLQW
         znP28m4nbBfolVseQuC8+CVtpj59eBqERZCMhWOriXMKIba/Wi9Ll2l2BXlvYCPd3t
         0KNE9fwa01enLlH8TXibPVN9PylSuU27Krc/GvzXW1EhzleTYuqgTX6b8DWYSDGXHL
         r8XPSeZMixjvQ==
Received: by pali.im (Postfix)
        id BFFE096B; Tue,  4 Jan 2022 16:38:31 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/11] PCI: mvebu: Update comment for PCI_EXP_LNKCTL register on emulated bridge
Date:   Tue,  4 Jan 2022 16:35:28 +0100
Message-Id: <20220104153529.31647-11-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220104153529.31647-1-pali@kernel.org>
References: <20211221141455.30011-1-pali@kernel.org>
 <20220104153529.31647-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Logic and code for clearing PCI_EXP_LNKCTL_CLKREQ_EN bit is correct, but
comment describing it is misleading. PCI_EXP_LNKCTL_CLKREQ_EN bit should be
hardwired to zero but mvebu hw allows to change it.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/controller/pci-mvebu.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 1aac65977b97..dffa330de174 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -663,10 +663,9 @@ mvebu_pci_bridge_emul_pcie_conf_write(struct pci_bridge_emul *bridge,
 
 	case PCI_EXP_LNKCTL:
 		/*
-		 * If we don't support CLKREQ, we must ensure that the
-		 * CLKREQ enable bit always reads zero.  Since we haven't
-		 * had this capability, and it's dependent on board wiring,
-		 * disable it for the time being.
+		 * PCIe requires that the Enable Clock Power Management bit
+		 * is hard-wired to zero for downstream ports but HW allows
+		 * to change it.
 		 */
 		new &= ~PCI_EXP_LNKCTL_CLKREQ_EN;
 
-- 
2.20.1

