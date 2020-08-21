Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D095124D914
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 17:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgHUPv3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Aug 2020 11:51:29 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:23946 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbgHUPv1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Aug 2020 11:51:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1598025087; x=1629561087;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mMfyeCMSGaXRjB0JFBU0lC28bZQxam9wWm7w0OU2PK4=;
  b=K8Kgv433aQuhaAtSctp3+v/oVcddgQdkHEK5W78URTEIjOE9Vx8/E5yv
   PVrBiFg8W1eFArvl20sIfFUHfNZXZ2oowC0zIY2yXdPnOBsTU/p5AlpUZ
   aHyBugHSIzxu/zlLEYDV+IOV1ZwfLT3rD6kImg0CcirB1/mkrTW2+tRGo
   0=;
X-IronPort-AV: E=Sophos;i="5.76,337,1592870400"; 
   d="scan'208";a="49341840"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 21 Aug 2020 15:51:25 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com (Postfix) with ESMTPS id 38E05A2300;
        Fri, 21 Aug 2020 15:51:23 +0000 (UTC)
Received: from EX13D01UWA002.ant.amazon.com (10.43.160.74) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 21 Aug 2020 15:51:22 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13d01UWA002.ant.amazon.com (10.43.160.74) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 21 Aug 2020 15:51:21 +0000
Received: from dev-dsk-csbisa-2a-37939146.us-west-2.amazon.com (172.19.34.216)
 by mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Fri, 21 Aug 2020 15:51:22 +0000
Received: by dev-dsk-csbisa-2a-37939146.us-west-2.amazon.com (Postfix, from userid 800212)
        id 56BC5903A; Fri, 21 Aug 2020 15:51:21 +0000 (UTC)
Date:   Fri, 21 Aug 2020 15:51:21 +0000
From:   Clint Sbisa <csbisa@amazon.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Jiri Kosina <trivial@kernel.org>
CC:     Clint Sbisa <csbisa@amazon.com>,
        Benjamin Herrenschmidt <benh@amazon.com>,
        Ali Saidi <alisaidi@amazon.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] PCI: Trivial comment fixup for PCI mmap ifdefs
Message-ID: <20200821155121.nzxjeeoze4h5pone@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The else/endif comments for pci_{create,remove}_resource_files were
not updated in commit f719582435afe9c7985206e42d804ea6aa315d33 ("PCI:
Add pci_mmap_resource_range() and use it for ARM64").

Signed-off-by: Clint Sbisa <csbisa@amazon.com>
---
 drivers/pci/pci-sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 6d78df981d41..cfc67b208616 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1196,10 +1196,10 @@ static int pci_create_resource_files(struct pci_dev *pdev)
 	}
 	return 0;
 }
-#else /* !HAVE_PCI_MMAP */
+#else /* ! (defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)) */
 int __weak pci_create_resource_files(struct pci_dev *dev) { return 0; }
 void __weak pci_remove_resource_files(struct pci_dev *dev) { return; }
-#endif /* HAVE_PCI_MMAP */
+#endif /* defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOURCE) */
 
 /**
  * pci_write_rom - used to enable access to the PCI ROM display
-- 
2.23.3

