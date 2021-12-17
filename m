Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 107A1478D29
	for <lists+linux-pci@lfdr.de>; Fri, 17 Dec 2021 15:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236992AbhLQOP2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Dec 2021 09:15:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26409 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234148AbhLQOP1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Dec 2021 09:15:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639750527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NQZDhFTLtRaPlSExzhLdFYaoJlU2cSr6LuWGQ4q5/fA=;
        b=PBZ4tbYAfHORf4Q3s6BgtJp1Zu+THlgvb4ExGpMIPqbrCZYOQPNLfcY/zK0dXEGA399UQz
        IgHVoqiKiTf9W7KVKbk+cyuxFn80QS7p8PzzZKu8mgMYWdG6WWIWCDxyr6EY6ABmQPCBDU
        vM1NpjMjN3MeDznoWBGwoA9Kn6YV0eU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-542-y5bYA3jePBad_y3LX0wnqA-1; Fri, 17 Dec 2021 09:15:24 -0500
X-MC-Unique: y5bYA3jePBad_y3LX0wnqA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE158101F008;
        Fri, 17 Dec 2021 14:15:22 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.193.91])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 33CE257CD2;
        Fri, 17 Dec 2021 14:15:16 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pci@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH resend] PCI: Make the pci_dev_present() stub a static inline
Date:   Fri, 17 Dec 2021 15:15:15 +0100
Message-Id: <20211217141515.379586-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
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
2.33.1

