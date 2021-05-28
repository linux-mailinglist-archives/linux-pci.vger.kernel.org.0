Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E67D0394625
	for <lists+linux-pci@lfdr.de>; Fri, 28 May 2021 19:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236316AbhE1REf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 May 2021 13:04:35 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50627 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236746AbhE1REb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 May 2021 13:04:31 -0400
Received: from 1.general.khfeng.us.vpn ([10.172.68.174] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1lmfsm-0005lN-NG; Fri, 28 May 2021 17:02:49 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     bhelgaas@google.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        kernel test robot <lkp@intel.com>,
        linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] PCI: Add const type for comparison function parameter
Date:   Sat, 29 May 2021 01:02:42 +0800
Message-Id: <20210528170242.1564038-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit 4f0f586bf0c8 ("treewide: Change list_sort to use const pointers")
added const on parameter "struct list_head *".

So add const to match the type.

Fixes: 276b15de5287 ("PCI: Coalesce host bridge contiguous apertures")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/pci/probe.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index bf58e5dd1d82..bd862b612633 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -875,7 +875,8 @@ static void pci_set_bus_msi_domain(struct pci_bus *bus)
 	dev_set_msi_domain(&bus->dev, d);
 }
 
-static int res_cmp(void *priv, struct list_head *a, struct list_head *b)
+static int res_cmp(void *priv, const struct list_head *a,
+		   const struct list_head *b)
 {
 	struct resource_entry *entry1, *entry2;
 
-- 
2.31.1

