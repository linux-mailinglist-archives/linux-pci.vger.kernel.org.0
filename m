Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 178D747C862
	for <lists+linux-pci@lfdr.de>; Tue, 21 Dec 2021 21:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234695AbhLUUsB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Dec 2021 15:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbhLUUsB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Dec 2021 15:48:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6110CC061574
        for <linux-pci@vger.kernel.org>; Tue, 21 Dec 2021 12:48:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2B5661798
        for <linux-pci@vger.kernel.org>; Tue, 21 Dec 2021 20:48:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B2E7C36AE8;
        Tue, 21 Dec 2021 20:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640119680;
        bh=GM61AcX2PYOJAm8qFPSE2x9A5Aya0EdwRlieIyLLYsg=;
        h=From:To:Subject:Date:From;
        b=kKsMDIzChbBNlJdlzQb5TDY7BfV/nAUeWhy9A0mXnspanDD8Kmra/7ZA8rBWjSvZ9
         euWunQ7etNTQuaGtycol6vXzJllI+oyDl2W+SLkHZsBrmiDqaKxPmiEEB7mX7TCEJW
         gNJxZABbC1QZLhek2lzt9dEfO2L8LrT5Lkm90Zbh30jOMPbIWHDOEaUsJLcGkEtFJ5
         CSjIGhCl0DgQ395BMpLAd6en3NvGydFgMBsau22zHsbOhd/x/TLocjRAzmwdFVKqT6
         DB4YvaqAeBq8yZtsCgCEq3YtZuN/z6X96JTpInjdiLALsNOG/+MBnPJd57J7pPVEoR
         gIRBwfGJ2Agbw==
Received: by pali.im (Postfix)
        id 3882E778; Tue, 21 Dec 2021 21:47:57 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Martin Mares <mj@ucw.cz>, Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>, linux-pci@vger.kernel.org
Subject: [PATCH pciutils] libpci: Fix intel_sanity_check() function
Date:   Tue, 21 Dec 2021 21:47:50 +0100
Message-Id: <20211221204750.11169-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
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

Fix this issue by properly initializing struct pci_dev d and explicitly set
d->domain to zero in intel_sanity_check() as sanity check is verifying PCI
devices at domain 0.
---
 lib/i386-ports.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/i386-ports.c b/lib/i386-ports.c
index b3b752cb1f3f..b5e09dab6002 100644
--- a/lib/i386-ports.c
+++ b/lib/i386-ports.c
@@ -72,7 +72,9 @@ intel_sanity_check(struct pci_access *a, struct pci_methods *m)
 {
   struct pci_dev d;
 
+  memset(&d, 0, sizeof(d));
   a->debug("...sanity check");
+  d.domain = 0;
   d.bus = 0;
   d.func = 0;
   for (d.dev = 0; d.dev < 32; d.dev++)
-- 
2.20.1

