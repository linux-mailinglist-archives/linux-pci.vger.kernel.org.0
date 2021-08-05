Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB1703E1043
	for <lists+linux-pci@lfdr.de>; Thu,  5 Aug 2021 10:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239495AbhHEI3Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Aug 2021 04:29:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:44526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239448AbhHEI3W (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Aug 2021 04:29:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C0AA6105A;
        Thu,  5 Aug 2021 08:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628152149;
        bh=PXKl7KMyp7SLlsXgaxi3qGWK1QDFQApdkdN/A03yZq4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N/mCiZWdZanEJLQArYEgGe0ZP3oJVB72D0XLbep1VHeBPl1kKXu4Nr8AK3OttYSlZ
         awlT+wDjhCwtc9l9K9L3eIP5Tp/Cw0XumsnG1P7Ml8wwcakIL/IBXhzRMk2UfuSO8J
         gWVQYG5Dgb6q2pqnNV+e7btj48s9Fn8YxS31UGEmrW38QcBES1+k0qe42FvhLOi2wm
         Wda1m37Fob0XR3zNGn5PHIbFaHI7jD1IdguZ4DwRM6fYwvz4Vht5VVX7Umapv0KdjE
         s9cvGxRi8W8NlqChYdPIHIXVQukon8KVBUazU6nruumsY5KkW+dMdqPDD9ust0YXXW
         Ov/kaI/Q8Pxxg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mBYkP-001Dub-Vb; Thu, 05 Aug 2021 10:29:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 3/3] PCI: of: Add some debug printks to track problems with of_node setup
Date:   Thu,  5 Aug 2021 10:29:00 +0200
Message-Id: <c4f873203f8811b8657fc4a01cd1410977e68b84.1628151761.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1628151760.git.mchehab+huawei@kernel.org>
References: <cover.1628151760.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In order to be able to identify why some of_nodes are not created,
we need to add some debug prints.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/pci/of.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index b6fa3bd46ae6..7b8c2b87eb25 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -18,6 +18,9 @@
 #ifdef CONFIG_PCI
 void pci_set_of_node(struct pci_dev *dev)
 {
+	dev_dbg(&dev->dev, "%s: of_node: %pOF\n",
+		__func__, dev->bus->dev.of_node);
+
 	if (!dev->bus->dev.of_node)
 		return;
 	dev->dev.of_node = of_pci_find_child_device(dev->bus->dev.of_node,
@@ -41,12 +44,16 @@ void pci_set_bus_of_node(struct pci_bus *bus)
 		node = pcibios_get_phb_of_node(bus);
 	} else {
 		node = of_node_get(bus->self->dev.of_node);
-		if (!node)
+		if (!node) {
 			node = of_node_get(bus->self->dev.parent->of_node);
+			dev_dbg(&bus->dev, "%s: use of_node of the parent",
+				__func__);
+		}
 		if (node && of_property_read_bool(node, "external-facing"))
 			bus->self->external_facing = true;
 	}
 
+	dev_dbg(&bus->dev, "%s: of_node: %pOF\n", __func__, node);
 	bus->dev.of_node = node;
 
 	if (bus->dev.of_node)
-- 
2.31.1

