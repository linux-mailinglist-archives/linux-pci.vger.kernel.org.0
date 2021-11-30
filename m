Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F89F463CCE
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 18:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238554AbhK3Rck (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 12:32:40 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:36626 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238731AbhK3Rck (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Nov 2021 12:32:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5DE25B81B13
        for <linux-pci@vger.kernel.org>; Tue, 30 Nov 2021 17:29:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01296C53FCB;
        Tue, 30 Nov 2021 17:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638293359;
        bh=7dWtS7IabxxufChgE1lrOYtnRbIhcoqfnxK0McNkq24=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ryoKgyMEZmrz/QVZgRZz2ZTXN3b4mOGCxliayJFKvqfd8cJ5VZv6Aeigd+gPRAjNS
         cAQQo5Sh4+Uvj0fmmROpJp3XCnZrCade2qCMF6BhRh5/28hRcyYzJikLiRXsUynyQ6
         Lf7q+WfwywBdzF6GWeSn3Dtf3s/t+u7od/WCc3SOcH5AVztM2s5D1rJDBJl5gbtQqn
         XkQ8H18Gh45MxIGxHyz7iksoSuhuNdk5NsmOmtVWCBn4MrH1pu5Tqr+zpa1JL1zoao
         vO0Zlc1POEBzOAnBWSTiluRzUXCBgibZ+XZwaeX1gbAVcN0v1mJowG9DcMrpKjfY9t
         xpFyLTGkIwETA==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     pali@kernel.org, linux-pci@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v4 01/11] PCI: pci-bridge-emul: Add description for class_revision field
Date:   Tue, 30 Nov 2021 18:29:03 +0100
Message-Id: <20211130172913.9727-2-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211130172913.9727-1-kabel@kernel.org>
References: <20211130172913.9727-1-kabel@kernel.org>
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

