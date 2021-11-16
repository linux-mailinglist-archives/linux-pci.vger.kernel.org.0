Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B13B4532A9
	for <lists+linux-pci@lfdr.de>; Tue, 16 Nov 2021 14:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233651AbhKPNPv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Nov 2021 08:15:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:33739 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232753AbhKPNPv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Nov 2021 08:15:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637068373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RwSPKdrqQ1q6lDNw8QjTC1fhe5/0qZqa2W6TP7Z0Hsc=;
        b=QL7mTvuKAvkWkqU6vQ3+TIfwB+Fll+wZXOsYjyIJ61MTpfaKOb8gJe+CFyur4oqEktHvmd
        Obt1XxWJEGEm/98YopIrkygD4nr23e9ClkKrT8hEExy6uFKxl48TmnLenDxmURHkM4OkZg
        SFpnTGLRhz7rbarCyE/bG6NnbkcJYP0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-YP6pxUzSOlmNnetxMQ2IjA-1; Tue, 16 Nov 2021 08:12:50 -0500
X-MC-Unique: YP6pxUzSOlmNnetxMQ2IjA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7D74802E64;
        Tue, 16 Nov 2021 13:12:49 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.192.241])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8EECF1F42A;
        Tue, 16 Nov 2021 13:12:48 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pci@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] PCI: Make the pci_dev_present() stub a static inline
Date:   Tue, 16 Nov 2021 14:12:47 +0100
Message-Id: <20211116131247.508424-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Change the pci_dev_present() stub which is used when CONFIG_PCI is not set
from a #define to a static inline stub.

Thix should fix clang -Werror builds failing due to errors like this:

drivers/platform/x86/thinkpad_acpi.c:4475:35:
 error: unused variable 'fwbug_cards_ids' [-Werror,-Wunused-const-variable]

Where fwbug_cards_ids is an array if pci_device_id-s passed to
pci_dev_present() during a quirk check.

Fixing this in include/linux/pci.h should ensure that the same issue is
also fixed in any other drivers hitting the same -Werror issue.

Cc: platform-driver-x86@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Note the commit message says "should fix" because I could not actually
be bothered to verify this. The whole notion of combining:
1. clang
2. -Werror
3. -Wunused-const-variable
Is frankly a bit crazy, causing way too much noise and has already
cost me too much time IMHO.
---
 include/linux/pci.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 18a75c8e615c..7d825637d7ca 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1775,7 +1775,10 @@ static inline struct pci_dev *pci_get_class(unsigned int class,
 					    struct pci_dev *from)
 { return NULL; }
 
-#define pci_dev_present(ids)	(0)
+
+static inline int pci_dev_present(const struct pci_device_id *ids)
+{ return 0; }
+
 #define no_pci_devices()	(1)
 #define pci_dev_put(dev)	do { } while (0)
 
-- 
2.31.1

