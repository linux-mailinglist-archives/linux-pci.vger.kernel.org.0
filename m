Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC70D77DC
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2019 16:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732279AbfJOOBF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Oct 2019 10:01:05 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:48988 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732170AbfJOOBF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Oct 2019 10:01:05 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iKNNk-00041o-Nn; Tue, 15 Oct 2019 15:01:00 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iKNNk-0004rj-A5; Tue, 15 Oct 2019 15:01:00 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: sysfs: remove pci_bridge_groups and pcie_dev_groups
Date:   Tue, 15 Oct 2019 15:00:59 +0100
Message-Id: <20191015140059.18660-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pci_bridge_groups and pcie_dev_groups objects are
not exported and not used at-all, so remove them to
fix the following warnings from sparse:

drivers/pci/pci-sysfs.c:1546:30: warning: symbol 'pci_bridge_groups' was not declared. Should it be static?
drivers/pci/pci-sysfs.c:1555:30: warning: symbol 'pcie_dev_groups' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/pci/pci-sysfs.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 793412954529..f7028cf3649a 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1543,20 +1543,10 @@ static const struct attribute_group pci_bridge_group = {
 	.attrs = pci_bridge_attrs,
 };
 
-const struct attribute_group *pci_bridge_groups[] = {
-	&pci_bridge_group,
-	NULL,
-};
-
 static const struct attribute_group pcie_dev_group = {
 	.attrs = pcie_dev_attrs,
 };
 
-const struct attribute_group *pcie_dev_groups[] = {
-	&pcie_dev_group,
-	NULL,
-};
-
 static const struct attribute_group pci_dev_hp_attr_group = {
 	.attrs = pci_dev_hp_attrs,
 	.is_visible = pci_dev_hp_attrs_are_visible,
-- 
2.23.0

