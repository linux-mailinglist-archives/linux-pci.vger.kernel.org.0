Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98BA947C1FA
	for <lists+linux-pci@lfdr.de>; Tue, 21 Dec 2021 15:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238712AbhLUO4w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Dec 2021 09:56:52 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38056 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238697AbhLUO4u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Dec 2021 09:56:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30FBAB8172E;
        Tue, 21 Dec 2021 14:56:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3909C36AEB;
        Tue, 21 Dec 2021 14:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640098607;
        bh=QKua9WgN49q+Sz5vAXpEygIK8zQDaGYklGosEd8el0I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j5qIL7hJn3PnjTem3tU/WrYcC63sG+E+IRLEbKfcTjR6eWwyPt5HjKX2wVlSd7bef
         uS848wT/gLFOaD+gKrT8xgw0odIKfoRfbMF8N6tSPqA7yHG/U9GyByATnwNYGYqe1m
         XA/IVlAYvQIo40XfBAbTsABWtNFSvbyfOdiAnnG55CSQOiFtCx8N7noa/xEJ5T4cNp
         37sJnygGc6btafthtB4APDxgYXgUHbwmNIg6agxxu89rXHKIIc6raP/fhaXQkGJdBI
         BdLXjf506rc0cJZWkVFN6/4zOx9nREEmueILrigu2sYkF+g3CAEzqhK8R8dXZF1JFt
         oa6FaoRoHKg6Q==
Received: by pali.im (Postfix)
        id A428F284E; Tue, 21 Dec 2021 15:18:12 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        "Rob Herring" <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] PCI: pci-bridge-emul: Make struct pci_bridge_emul_ops as const
Date:   Tue, 21 Dec 2021 15:14:46 +0100
Message-Id: <20211221141455.30011-3-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211221141455.30011-1-pali@kernel.org>
References: <20211221141455.30011-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

It is read-only constant structure, so properly mark it with const keyword.

Signed-off-by: Pali Rohár <pali@kernel.org>
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

