Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3921BD7ACF
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2019 18:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbfJOQHL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Oct 2019 12:07:11 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:54011 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbfJOQHL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Oct 2019 12:07:11 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iKPLj-0007jR-I9; Tue, 15 Oct 2019 17:07:03 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iKPLi-0002TI-TD; Tue, 15 Oct 2019 17:07:02 +0100
From:   "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pci: iproc-msi: fix __iomem annotation in decode_msi_hwirq()
Date:   Tue, 15 Oct 2019 17:07:02 +0100
Message-Id: <20191015160702.9457-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix __iomem attribute on msg variable passed to readl() in
the decode_msi_hwirq() function. Fixes the following sparse
warning:

drivers/pci/controller/pcie-iproc-msi.c:301:17: warning: incorrect type in argument 1 (different address spaces)
drivers/pci/controller/pcie-iproc-msi.c:301:17:    expected void const volatile [noderef] <asn:2> *addr
drivers/pci/controller/pcie-iproc-msi.c:301:17:    got unsigned int [usertype] *[assigned] msg

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Andrew Murray <andrew.murray@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com
Cc: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
.. (open list)
---
 drivers/pci/controller/pcie-iproc-msi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-iproc-msi.c b/drivers/pci/controller/pcie-iproc-msi.c
index 0a3f61be5625..3176ad3ab0e5 100644
--- a/drivers/pci/controller/pcie-iproc-msi.c
+++ b/drivers/pci/controller/pcie-iproc-msi.c
@@ -293,11 +293,12 @@ static const struct irq_domain_ops msi_domain_ops = {
 
 static inline u32 decode_msi_hwirq(struct iproc_msi *msi, u32 eq, u32 head)
 {
-	u32 *msg, hwirq;
+	u32 __iomem *msg;
+	u32 hwirq;
 	unsigned int offs;
 
 	offs = iproc_msi_eq_offset(msi, eq) + head * sizeof(u32);
-	msg = (u32 *)(msi->eq_cpu + offs);
+	msg = (u32 __iomem *)(msi->eq_cpu + offs);
 	hwirq = readl(msg);
 	hwirq = (hwirq >> 5) + (hwirq & 0x1f);
 
-- 
2.23.0

