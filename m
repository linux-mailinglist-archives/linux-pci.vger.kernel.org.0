Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2E9249602C
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jan 2022 14:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350745AbiAUN6P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jan 2022 08:58:15 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:48318 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350794AbiAUN6P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jan 2022 08:58:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D30D6175E
        for <linux-pci@vger.kernel.org>; Fri, 21 Jan 2022 13:58:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD476C340E4;
        Fri, 21 Jan 2022 13:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642773494;
        bh=tZD9Kt2oqV3x+ucieG7rcKrQel3qU6fgABWWF2uxhjk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=U+L0GxkwuwxF5tE0jXIbkU3q782FODZ46dpAZtjQ0rw0UGChJhPlJzilwaygZvUpK
         sIn9yw6w6HQasjc/FI4rS6IiGcfSy4YXdQMijPgPLtzeFWHAQu5M/FYK1hMWCSBTxW
         RD2tM5MZYhDhMLHvo1nv0YZClxHNzyXITKSaeTJGMjrjJxkRVb25K0I2Pi09t9xYWR
         an+nHrn0tcrktuhTs8zJWYkwKkClp8Ty8+0ykTv1i/xZfbiytPonof93DAbyyqC39N
         jqimYLvk1MXunO44lkNt6+9Az5luPUCLblWhnwwUTM0JRHR0kRUJWgMCXfhI59S24A
         VFw1CV6I+XFQQ==
Received: by pali.im (Postfix)
        id A203FB8A; Fri, 21 Jan 2022 14:58:11 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Martin Mares <mj@ucw.cz>, Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>, linux-pci@vger.kernel.org
Subject: [PATCH pciutils 1/5] libpci: Add new options for pci_fill_info: PROGIF, REVID and SUBSYS
Date:   Fri, 21 Jan 2022 14:57:14 +0100
Message-Id: <20220121135718.27172-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220121135718.27172-1-pali@kernel.org>
References: <20220121135718.27172-1-pali@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This change extends libpci library and allows providers to fill these
informations (Programming interface, Revision id and Subsystem ids) via
native system APIs, which sometimes may differs from what is stored in PCI
config space.

Programming interface is part of 24-bit Device Class number but apparently
libpci exports only high 16-bit of this number via device_class member.
---
 lib/pci.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/pci.h b/lib/pci.h
index b9fd9bfb9b5b..8c3c11b9ebeb 100644
--- a/lib/pci.h
+++ b/lib/pci.h
@@ -145,6 +145,9 @@ struct pci_dev {
   pciaddr_t bridge_base_addr[4];	/* Bridge base addresses (without flags) */
   pciaddr_t bridge_size[4];		/* Bridge sizes */
   pciaddr_t bridge_flags[4];		/* PCI_IORESOURCE_* flags for bridge addresses */
+  u8 prog_if;				/* Programming interface for device_class */
+  u8 rev_id;				/* Revision id */
+  u16 subsys_vendor_id, subsys_id;	/* Subsystem vendor id and subsystem id */
 
   /* Fields used internally */
   struct pci_access *access;
@@ -210,6 +213,9 @@ char *pci_get_string_property(struct pci_dev *d, u32 prop) PCI_ABI;
 #define PCI_FILL_IOMMU_GROUP	0x4000
 #define PCI_FILL_BRIDGE_BASES	0x8000
 #define PCI_FILL_RESCAN		0x00010000
+#define PCI_FILL_PROGIF		0x00020000
+#define PCI_FILL_REVID		0x00040000
+#define PCI_FILL_SUBSYS		0x00080000
 
 void pci_setup_cache(struct pci_dev *, u8 *cache, int len) PCI_ABI;
 
-- 
2.20.1

