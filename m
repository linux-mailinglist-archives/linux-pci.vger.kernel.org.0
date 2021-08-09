Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC79F3E3ED0
	for <lists+linux-pci@lfdr.de>; Mon,  9 Aug 2021 06:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbhHIEYr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Aug 2021 00:24:47 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:45426
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229483AbhHIEYq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Aug 2021 00:24:46 -0400
Received: from HP-EliteBook-840-G7.. (1-171-221-113.dynamic-ip.hinet.net [1.171.221.113])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 10DEE3F044;
        Mon,  9 Aug 2021 04:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628483065;
        bh=rNTKmk2f1FxpFVDQvfWr910vGJV6I98CEVlT78OYqBE=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=TUHQykpM0pxI6F8Cq4R0iDbUXHb9/c46e6JafcYChga/jtxDXltw+/m/H7l6grPn5
         xoVetVE+Jq3Z9JcZ+smqUeTj/TgJAvC2uHaLeDqTa7J2UpWCHbPvZxNFIJbhO4W6xF
         6RWF8IFAyNX0z/WpeuEb1GsqE1M8YJajx+P7OdTPU7B+Jux1Agu3owmL6rP8Optowq
         0Eo/HWShE3+QFaU1XIJc8YxgsUlcqndKSssbCeyjdUjY0i+MB0kglKV9i50GHU7XRC
         0/uS19cjV2fzhZcMVVootW/DjcrCk7+YGqTQw87jeoyBg4zXCgt0snSiqCfArVsl/A
         59FyswxOkgX1Q==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     bhelgaas@google.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Sean V Kelley <sean.v.kelley@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Keith Busch <kbusch@kernel.org>,
        linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] PCI/portdrv: Disallow runtime suspend when waekup is required but PME service isn't supported
Date:   Mon,  9 Aug 2021 12:24:12 +0800
Message-Id: <20210809042414.107430-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210713075726.1232938-1-kai.heng.feng@canonical.com>
References: <20210713075726.1232938-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some platforms cannot detect ethernet hotplug once its upstream port is
runtime suspended because PME isn't enabled in _OSC. The issue can be
workarounded by "pcie_ports=native".

The vendor confirmed that the PME in _OSC is disabled intentionally for
stability issues on the other OS, so we should also honor the PME
setting here.

Disallow port runtime suspend when any child device requires wakeup, so
pci_pme_list_scan() can still read the PME status from the devices
behind the port.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=213873
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/pci/pcie/portdrv_pci.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index c7ff1eea225a..e693d243c90d 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -59,14 +59,30 @@ static int pcie_port_runtime_suspend(struct device *dev)
 	return pcie_port_device_runtime_suspend(dev);
 }
 
+static int pcie_port_wakeup_check(struct device *dev, void *data)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	if (!pdev)
+		return 0;
+
+	return pdev->wakeup_prepared;
+}
+
 static int pcie_port_runtime_idle(struct device *dev)
 {
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	if (!pcie_port_find_device(pdev, PCIE_PORT_SERVICE_PME) &&
+	    device_for_each_child(dev, NULL, pcie_port_wakeup_check))
+		return -EBUSY;
+
 	/*
 	 * Assume the PCI core has set bridge_d3 whenever it thinks the port
 	 * should be good to go to D3.  Everything else, including moving
 	 * the port to D3, is handled by the PCI core.
 	 */
-	return to_pci_dev(dev)->bridge_d3 ? 0 : -EBUSY;
+	return pdev->bridge_d3 ? 0 : -EBUSY;
 }
 
 static const struct dev_pm_ops pcie_portdrv_pm_ops = {
-- 
2.31.1

