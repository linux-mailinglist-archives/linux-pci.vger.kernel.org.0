Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94C3F49602D
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jan 2022 14:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380762AbiAUN6R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jan 2022 08:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350790AbiAUN6P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jan 2022 08:58:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F662C061574
        for <linux-pci@vger.kernel.org>; Fri, 21 Jan 2022 05:58:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1BB061768
        for <linux-pci@vger.kernel.org>; Fri, 21 Jan 2022 13:58:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F9D6C340E9;
        Fri, 21 Jan 2022 13:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642773494;
        bh=drIeb53okjVD8/6YcT79Iyn0qNZaI0YaMxW/nQREYGw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=MsoZbRtcYOJh81plZuwP7vglamXIsFBJUJWxMXvB70X2IvVJNuWndRiyLvcsbSQ0S
         MsAw4sKH71wLhQ2DMLzQ18SI2T/I6oVwZAeQDjqqxAAIrdD7Cn5aJJLXVGKNXqCZCa
         PILsCrLAcJYoOFKVCA+tzJDbcDxL2ormNef98ksA39dbR2jdeV3rP8zNxrnQ54m/nP
         JvPAtHVj47VOWH0aGAijIEA/FB8CFErKhlAtBYTD4Xb7P0r2X9fGSKODaqpbx5swZ8
         EahgZ2TMaRlmULI8g0Z2ryhj2fCksN03topZD84Dx9CVi/RW1onZdmBYYoc15SG/nn
         DQqbs0JOSD6EQ==
Received: by pali.im (Postfix)
        id ED2F4857; Fri, 21 Jan 2022 14:58:13 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Martin Mares <mj@ucw.cz>, Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>, linux-pci@vger.kernel.org
Subject: [PATCH pciutils 3/5] libpci: generic: Implement SUBSYS also for PCI_HEADER_TYPE_BRIDGE
Date:   Fri, 21 Jan 2022 14:57:16 +0100
Message-Id: <20220121135718.27172-4-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220121135718.27172-1-pali@kernel.org>
References: <20220121135718.27172-1-pali@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Subsystem ids for PCI Bridges are stored in extended capability
PCI_CAP_ID_SSVID.
---
 lib/generic.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/lib/generic.c b/lib/generic.c
index f4b6918cb55b..2cdb7956754c 100644
--- a/lib/generic.c
+++ b/lib/generic.c
@@ -117,6 +117,30 @@ pci_generic_fill_info(struct pci_dev *d, unsigned int flags)
           d->subsys_id = pci_read_word(d, PCI_SUBSYSTEM_ID);
           done |= PCI_FILL_SUBSYS;
           break;
+        case PCI_HEADER_TYPE_BRIDGE:
+          if (pci_read_word(d, PCI_STATUS) & PCI_STATUS_CAP_LIST)
+            {
+              byte been_there[256];
+              int where, id;
+
+              memset(been_there, 0, 256);
+              where = pci_read_byte(d, PCI_CAPABILITY_LIST) & ~3;
+              while (where && !been_there[where]++)
+                {
+                  id = pci_read_byte(d, where + PCI_CAP_LIST_ID);
+                  if (id == PCI_CAP_ID_SSVID)
+                    {
+                      d->subsys_vendor_id = pci_read_word(d, where + PCI_SSVID_VENDOR);
+                      d->subsys_id = pci_read_word(d, where + PCI_SSVID_DEVICE);
+                      done |= PCI_FILL_SUBSYS;
+                      break;
+                    }
+                  if (id == 0xff)
+                    break;
+                  where = pci_read_byte(d, where + PCI_CAP_LIST_NEXT) & ~3;
+                }
+            }
+          break;
         case PCI_HEADER_TYPE_CARDBUS:
           d->subsys_vendor_id = pci_read_word(d, PCI_CB_SUBSYSTEM_VENDOR_ID);
           d->subsys_id = pci_read_word(d, PCI_CB_SUBSYSTEM_ID);
-- 
2.20.1

