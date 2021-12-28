Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC724809C7
	for <lists+linux-pci@lfdr.de>; Tue, 28 Dec 2021 14:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbhL1N52 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Dec 2021 08:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbhL1N52 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Dec 2021 08:57:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45940C061574;
        Tue, 28 Dec 2021 05:57:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFA4B611FE;
        Tue, 28 Dec 2021 13:57:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB9E6C36AE8;
        Tue, 28 Dec 2021 13:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640699847;
        bh=wTKwgHqynb1jV0gXRuPGbyQPDJc18VLUl0NxL/lHBdg=;
        h=From:To:Cc:Subject:Date:From;
        b=FPfiBPi3ddLuZBJhVN1PB9b54hCBHBy6TZATAEpdov3/VhDqLHBlyZGGB6Yc/3ybc
         FOa4dfvwu+Ff7Re12K6x1BjMYyGNd1OHuTkNkMDhxhKK3P87pZoIxtZ1nUwjqqZzRz
         i3tHdOVr76YPpolws7gJ8EEr8V67sc8aiEqrF9Mw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH] PCI: slot: use default_groups in kobj_type
Date:   Tue, 28 Dec 2021 14:57:22 +0100
Message-Id: <20211228135722.381023-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1188; h=from:subject; bh=wTKwgHqynb1jV0gXRuPGbyQPDJc18VLUl0NxL/lHBdg=; b=owGbwMvMwCRo6H6F97bub03G02pJDImnxQ9JRnA1z+vqyvo98WjQlkshkfxq29X2yxs4Po0/YV55 cndARwwLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAEwk2ZVhut+e5MZ90lvlpvNdF334uf WKiN5Hhnk2s9V3i/97pVlYHStygPlVhe+WQ70A
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There are currently 2 ways to create a set of sysfs files for a
kobj_type, through the default_attrs field, and the default_groups
field.  Move the PCI slot code to use default_groups field which has
been the preferred way since aa30f47cf666 ("kobject: Add support for
default attribute groups to kobj_type") so that we can soon get rid of
the obsolete default_attrs field.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/slot.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index 751a26668e3a..a0c67191a8b9 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -96,11 +96,12 @@ static struct attribute *pci_slot_default_attrs[] = {
 	&pci_slot_attr_cur_speed.attr,
 	NULL,
 };
+ATTRIBUTE_GROUPS(pci_slot_default);
 
 static struct kobj_type pci_slot_ktype = {
 	.sysfs_ops = &pci_slot_sysfs_ops,
 	.release = &pci_slot_release,
-	.default_attrs = pci_slot_default_attrs,
+	.default_groups = pci_slot_default_groups,
 };
 
 static char *make_slot_name(const char *name)
-- 
2.34.1

