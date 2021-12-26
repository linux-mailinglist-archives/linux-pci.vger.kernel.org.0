Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B1747F96D
	for <lists+linux-pci@lfdr.de>; Sun, 26 Dec 2021 23:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234746AbhLZWrT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 26 Dec 2021 17:47:19 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:42078 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234729AbhLZWrT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 26 Dec 2021 17:47:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9E0560E17
        for <linux-pci@vger.kernel.org>; Sun, 26 Dec 2021 22:47:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E30D6C36AE8;
        Sun, 26 Dec 2021 22:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640558838;
        bh=oRabUiyLCcQ/aJz5HYD2V+SpSEZKExXrnFhBJFCLUP4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=olCIiuTwpZud/ylFO9kvGbB6JHJFKPGZCZGvBzyKGjW8ygnqjGrK1wQistBUpv8rx
         JyLVSzYMPIC8Bmu2hyiFI9zvTWcmZbGgyVPEp8DXwvIRVgnFWRnuyGlpPPMrCRD+V1
         SrERtYhhXSSj+nUQbszVfVBnvHU9hh2hXAPhPKwKfkq4hX7CtwGCzkdhPW2Vq0tfK2
         fa0ejcED8YRMtWCPKXLGBYBVbagwmfnxEB1y/1Z+FaLpaZaY59fmGFGH8YndK4xDwr
         +KA/ZGdS8g05vRkdsB4Jstc0K8V7i1WwuJ+Erf3S2KUVKo8Km4gl+x+CwAQYZeWs0X
         rUk9fv8J1eS2Q==
Received: by pali.im (Postfix)
        id A7F529D0; Sun, 26 Dec 2021 23:47:15 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Martin Mares <mj@ucw.cz>, Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>, linux-pci@vger.kernel.org
Subject: [PATCH v2 pciutils] libpci: Fix intel_sanity_check() function
Date:   Sun, 26 Dec 2021 23:47:03 +0100
Message-Id: <20211226224703.20445-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <mj+md-20211226.215029.60895.albireo@ucw.cz>
References: <mj+md-20211226.215029.60895.albireo@ucw.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Function intel_sanity_check() calls conf1_read() which access d->domain
field. But intel_sanity_check() does not initialize this field and so
conf1_read() access some random data on stack.

Tests showed that intel_sanity_check() always fails as in d->domain is
stored some non-zero number.

Fix this issue by zeroing struct pci_dev d in intel_sanity_check() as
sanity check is verifying PCI devices at domain 0.
---
v2: Remove explicit set of d->domain to zero.
---
 lib/i386-ports.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/i386-ports.c b/lib/i386-ports.c
index b3b752cb1f3f..2f90aa4cee0a 100644
--- a/lib/i386-ports.c
+++ b/lib/i386-ports.c
@@ -72,6 +72,7 @@ intel_sanity_check(struct pci_access *a, struct pci_methods *m)
 {
   struct pci_dev d;
 
+  memset(&d, 0, sizeof(d));
   a->debug("...sanity check");
   d.bus = 0;
   d.func = 0;
-- 
2.20.1

