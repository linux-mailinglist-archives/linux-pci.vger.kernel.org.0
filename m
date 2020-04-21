Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1161B2C8D
	for <lists+linux-pci@lfdr.de>; Tue, 21 Apr 2020 18:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgDUQXC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Apr 2020 12:23:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:47334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbgDUQXC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 21 Apr 2020 12:23:02 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 592D0206E9;
        Tue, 21 Apr 2020 16:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587486181;
        bh=UHH9at8D1Z/pR7y2rSeoDzjm6FnMn4MWdgGhRmyn2Wo=;
        h=From:To:Cc:Subject:Date:From;
        b=P/aSNSGkqCKk4dkvR+x377Ya2+2pbayvilRcRXwiyg86zKktM3EhttZ6A0ncrTbAH
         /WFc31kMV0P+FdZJ3rzR11WzB6j0UMZdn/pleO58C/wFa5VxtrByoLYzIrEdPrig+o
         ujDDRYzgQr9+ZLrpTbNCPY7RVUdxXSOgBDQPvB/U=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     christian.koenig@amd.com, bhelgaas@google.com, jon@solid-run.com,
        wasim.khan@nxp.com, Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] PCI: allow pci_resize_resource() to be used on devices on the root bus
Date:   Tue, 21 Apr 2020 18:22:56 +0200
Message-Id: <20200421162256.26887-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When resizing a BAR, pci_reassign_bridge_resources() is invoked to
bring the bridge windows of parent bridges in line with the new BAR
assignment.

This assumes that the device whose BAR is being resized lives on a
subordinate bus, but this is not necessarily the case. A device may
live on the root bus, in which case dev->bus->self is NULL, and
passing a NULL pci_dev pointer to pci_reassign_bridge_resources()
will cause it to crash.

So let's make the call to pci_reassign_bridge_resources() conditional
on whether dev->bus->self is non-NULL in the first place.

Fixes: 8bb705e3e79d84e7 ("PCI: Add pci_resize_resource() for resizing BARs")
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/pci/setup-res.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index d8ca40a97693..d21fa04fa44d 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -439,10 +439,11 @@ int pci_resize_resource(struct pci_dev *dev, int resno, int size)
 	res->end = res->start + pci_rebar_size_to_bytes(size) - 1;
 
 	/* Check if the new config works by trying to assign everything. */
-	ret = pci_reassign_bridge_resources(dev->bus->self, res->flags);
-	if (ret)
-		goto error_resize;
-
+	if (dev->bus->self) {
+		ret = pci_reassign_bridge_resources(dev->bus->self, res->flags);
+		if (ret)
+			goto error_resize;
+	}
 	return 0;
 
 error_resize:
-- 
2.17.1

