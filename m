Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 983D446346A
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 13:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbhK3Mju (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 07:39:50 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35536 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbhK3Mjt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Nov 2021 07:39:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2EAF7B81920
        for <linux-pci@vger.kernel.org>; Tue, 30 Nov 2021 12:36:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF63C53FD0;
        Tue, 30 Nov 2021 12:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638275787;
        bh=7dWtS7IabxxufChgE1lrOYtnRbIhcoqfnxK0McNkq24=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U6lwi/Cm4M3IqAbKRBfcJpuJ3IN3fGMwuCgqP3SuVRIyx8nLqhyzXavOXDyIxFI0N
         UIe/Hqi/jFTgFcBGyoDx05OV6Ljw8JFya7KcyhhntKhwyK5b8YLBr/b0Ve+dqltD1G
         qSXFmHSPi6Cd7pWL0QTOISitgxmdxvvUyp0mzPniOT58EylzGTWQe5s+aj3Il9sBpP
         +jI6AMz5fwrhhP6Y50FpNWpHwY2P6Hy+TGLOLAx2hazgMvNmmONn4rINKHPoQpj6JW
         ZNVNrxTTxOQUqbpI1Il9jrWTh+HXo7bv92Ik+IWSEWJVUBPKrqYibzbCPEgaZ1kHXJ
         qjvRqC0Db7N/g==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     pali@kernel.org, linux-pci@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 01/11] PCI: pci-bridge-emul: Add description for class_revision field
Date:   Tue, 30 Nov 2021 13:36:11 +0100
Message-Id: <20211130123621.23062-2-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211130123621.23062-1-kabel@kernel.org>
References: <20211130123621.23062-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

The current assignment to the class_revision member

  class_revision |= cpu_to_le32(PCI_CLASS_BRIDGE_PCI << 16);

can make the reader think that class is at high 16 bits of the member and
revision at low 16 bits.

In reality, class is at high 24 bits, but the class for PCI Bridge Normal
Decode is PCI_CLASS_BRIDGE_PCI << 8.

Change the assignment and add a comment to make this clearer.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/pci-bridge-emul.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-bridge-emul.c b/drivers/pci/pci-bridge-emul.c
index db97cddfc85e..a4af1a533d71 100644
--- a/drivers/pci/pci-bridge-emul.c
+++ b/drivers/pci/pci-bridge-emul.c
@@ -265,7 +265,11 @@ int pci_bridge_emul_init(struct pci_bridge_emul *bridge,
 {
 	BUILD_BUG_ON(sizeof(bridge->conf) != PCI_BRIDGE_CONF_END);
 
-	bridge->conf.class_revision |= cpu_to_le32(PCI_CLASS_BRIDGE_PCI << 16);
+	/*
+	 * class_revision: Class is high 24 bits and revision is low 8 bit of this member,
+	 * while class for PCI Bridge Normal Decode has the 24-bit value: PCI_CLASS_BRIDGE_PCI << 8
+	 */
+	bridge->conf.class_revision |= cpu_to_le32((PCI_CLASS_BRIDGE_PCI << 8) << 8);
 	bridge->conf.header_type = PCI_HEADER_TYPE_BRIDGE;
 	bridge->conf.cache_line_size = 0x10;
 	bridge->conf.status = cpu_to_le16(PCI_STATUS_CAP_LIST);
-- 
2.32.0

