Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8C11FE475
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jun 2020 04:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730205AbgFRCSZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Jun 2020 22:18:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:51554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727864AbgFRBTj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Jun 2020 21:19:39 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B2BA206F1;
        Thu, 18 Jun 2020 01:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443178;
        bh=l0bHPfHKCL3ItJDm5/fi6/ksjpwNSpa2/4PkF1yxV/Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HDE7/GdniWAw5imWOmQS+1NzyqTTwMFQGVXtUrgQulGxYqmG1AXr2BTEB29MBEu7V
         Idp6qAE9FCiUmezzpAwb6ht9XR6IZ4tGQjBH6Vn62cVevX3O8gOmEvDKfYztg7yCi+
         nyihJ5RG4MQiipxmsXvABy1nyhdGhfcLoUm1IMy0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Sasha Levin <sashal@kernel.org>,
        linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 141/266] PCI: Fix pci_register_host_bridge() device_register() error handling
Date:   Wed, 17 Jun 2020 21:14:26 -0400
Message-Id: <20200618011631.604574-141-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618011631.604574-1-sashal@kernel.org>
References: <20200618011631.604574-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rob Herring <robh@kernel.org>

[ Upstream commit 1b54ae8327a4d630111c8d88ba7906483ec6010b ]

If device_register() has an error, we should bail out of
pci_register_host_bridge() rather than continuing on.

Fixes: 37d6a0a6f470 ("PCI: Add pci_register_host_bridge() interface")
Link: https://lore.kernel.org/r/20200513223859.11295-1-robh@kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/probe.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index d3033873395d..e1e61b9dd066 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -867,9 +867,10 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 		goto free;
 
 	err = device_register(&bridge->dev);
-	if (err)
+	if (err) {
 		put_device(&bridge->dev);
-
+		goto free;
+	}
 	bus->bridge = get_device(&bridge->dev);
 	device_enable_async_suspend(bus->bridge);
 	pci_set_bus_of_node(bus);
-- 
2.25.1

