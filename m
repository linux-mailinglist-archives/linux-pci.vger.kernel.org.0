Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3522349609E
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jan 2022 15:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235440AbiAUOX4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jan 2022 09:23:56 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58862 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbiAUOX4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jan 2022 09:23:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E454B6160D
        for <linux-pci@vger.kernel.org>; Fri, 21 Jan 2022 14:23:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA68C340E3;
        Fri, 21 Jan 2022 14:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642775035;
        bh=Klw5dhSRcs51iQIRsovc8n92re/IQSrM3/hD0WnxPeM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=GkAZx8DDrOjCjZNZPxP1oBL5H2Z2F2uj0+l90RTomQYmoE9s/6m5+nF8yw53UkS32
         YnoPpT6Ki6OeZlV3fgpYqNzcYIDPLjhNOBK0OJeRKVecEJJHcu+k4804QbS6oFIH4z
         GUivGG15EvgPTEmEzgeWZTHZeARuUaJKHi2FqrriKaiX89+gYHpLOb9FdnQ3jrG9Or
         LnaOvXdRPq4aGbGnUxaRW92lN3oQnw3TyYGDd1xAQcnS3USvDcT+9OPzGq1kAVt70p
         LHE2kzOJgO25UEqxOUXN5iZFioirvisy1xr6QJkPir3y+AThu3feMreVyJFRxdLo1C
         xMVh94cHnVrSg==
Received: by pali.im (Postfix)
        id 1AEACB8A; Fri, 21 Jan 2022 15:23:53 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Martin Mares <mj@ucw.cz>, Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>, linux-pci@vger.kernel.org
Subject: [PATCH pciutils 1/4] libpci: Add new option PCI_FILL_PARENT
Date:   Fri, 21 Jan 2022 15:22:55 +0100
Message-Id: <20220121142258.28170-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220121142258.28170-1-pali@kernel.org>
References: <20220121142258.28170-1-pali@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This change extends libpci and allows providers to fill parent pci_dev.
This is useful to retrieve topology as it is reported by the system itself.
---
 lib/pci.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/pci.h b/lib/pci.h
index c13387e2b4b1..de031f7a416b 100644
--- a/lib/pci.h
+++ b/lib/pci.h
@@ -148,6 +148,7 @@ struct pci_dev {
   u8 prog_if;				/* Programming interface for device_class */
   u8 rev_id;				/* Revision id */
   u16 subsys_vendor_id, subsys_id;	/* Subsystem vendor id and subsystem id */
+  struct pci_dev *parent;		/* Parent device */
 
   /* Fields used internally */
   struct pci_access *access;
@@ -217,6 +218,7 @@ char *pci_get_string_property(struct pci_dev *d, u32 prop) PCI_ABI;
 #define PCI_FILL_REVID		0x00040000
 #define PCI_FILL_SUBSYS		0x00080000
 #define PCI_FILL_DRIVER		0x00100000
+#define PCI_FILL_PARENT		0x00200000
 
 void pci_setup_cache(struct pci_dev *, u8 *cache, int len) PCI_ABI;
 
-- 
2.20.1

