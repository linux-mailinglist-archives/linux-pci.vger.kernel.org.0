Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAD184844CE
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jan 2022 16:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234953AbiADPic (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jan 2022 10:38:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234933AbiADPia (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jan 2022 10:38:30 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C3DC061761;
        Tue,  4 Jan 2022 07:38:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A40AACE1938;
        Tue,  4 Jan 2022 15:38:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE2ACC36AEF;
        Tue,  4 Jan 2022 15:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641310706;
        bh=iOvSQ3cr2/obvzVJYtbtVJIt4qlKE0TfvlWcR/y5KNc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ihp68iLoajs9P67lIgANXlBx1wOHuflcmm3mUkvP9jAChN6Gwjq5NdJyXjPeAhyM5
         BM2DuWnjm/4Jafcp/NVk8bsnLDJO1jTE6T92Qkx07VmWEnB30sFJHosLjQB15TlRg3
         8n409X8KThCu+Hiya4sXCKGTJnGLSgvS2MVROM1E8UOK2fmZLbHGs5J7bkYeL9tDjS
         CDsAaZP6kfVPj3xjhHJ2gYlGCFpw0sJ1+t0Ce0hSTp5DBI9RKpH9fUtPsqPYJaE2nt
         xM3u4/yD9hD3Ye+K64w6J+4aP25yp8piVEPqOw5z+N7AfKU8HIV92+zeaQniqCiv19
         bbPNuLteURzQg==
Received: by pali.im (Postfix)
        id 9B1EB284D; Tue,  4 Jan 2022 16:38:23 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/11] PCI: pci-bridge-emul: Make struct pci_bridge_emul_ops as const
Date:   Tue,  4 Jan 2022 16:35:20 +0100
Message-Id: <20220104153529.31647-3-pali@kernel.org>
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

It is read-only constant structure, so properly mark it with const keyword.

Signed-off-by: Pali Rohár <pali@kernel.org>
Acked-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 drivers/pci/controller/pci-aardvark.c | 2 +-
 drivers/pci/controller/pci-mvebu.c    | 2 +-
 drivers/pci/pci-bridge-emul.h         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 62fc55f2ed40..1fa6fe1e022a 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -928,7 +928,7 @@ advk_pci_bridge_emul_pcie_conf_write(struct pci_bridge_emul *bridge,
 	}
 }
 
-static struct pci_bridge_emul_ops advk_pci_bridge_emul_ops = {
+static const struct pci_bridge_emul_ops advk_pci_bridge_emul_ops = {
 	.read_base = advk_pci_bridge_emul_base_conf_read,
 	.write_base = advk_pci_bridge_emul_base_conf_write,
 	.read_pcie = advk_pci_bridge_emul_pcie_conf_read,
diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 68aa94a258ff..2ecc1ab12249 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -709,7 +709,7 @@ mvebu_pci_bridge_emul_pcie_conf_write(struct pci_bridge_emul *bridge,
 	}
 }
 
-static struct pci_bridge_emul_ops mvebu_pci_bridge_emul_ops = {
+static const struct pci_bridge_emul_ops mvebu_pci_bridge_emul_ops = {
 	.read_base = mvebu_pci_bridge_emul_base_conf_read,
 	.write_base = mvebu_pci_bridge_emul_base_conf_write,
 	.read_pcie = mvebu_pci_bridge_emul_pcie_conf_read,
diff --git a/drivers/pci/pci-bridge-emul.h b/drivers/pci/pci-bridge-emul.h
index 49bbd37ee318..0690b6369755 100644
--- a/drivers/pci/pci-bridge-emul.h
+++ b/drivers/pci/pci-bridge-emul.h
@@ -112,7 +112,7 @@ struct pci_bridge_reg_behavior;
 struct pci_bridge_emul {
 	struct pci_bridge_emul_conf conf;
 	struct pci_bridge_emul_pcie_conf pcie_conf;
-	struct pci_bridge_emul_ops *ops;
+	const struct pci_bridge_emul_ops *ops;
 	struct pci_bridge_reg_behavior *pci_regs_behavior;
 	struct pci_bridge_reg_behavior *pcie_cap_regs_behavior;
 	void *data;
-- 
2.20.1

