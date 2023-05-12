Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934E16FFDC5
	for <lists+linux-pci@lfdr.de>; Fri, 12 May 2023 02:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239291AbjELAPH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 May 2023 20:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjELAPG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 May 2023 20:15:06 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26696199;
        Thu, 11 May 2023 17:15:05 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 980A64179B;
        Fri, 12 May 2023 00:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1683849674;
        bh=3BPzMXXBFs6fLOYxOkArjjMcNB35OJnLugmMxdqyF3I=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=krTNOjENq0W8Mw1vYRI/+NhDl9OOYXbclhVOJ0xUJxxO7XWx5PtLW+wE2CemlXfK8
         +Bt1RCru26m761ZzEWag8gwEaJlkhxF5GNRtrlUzXUArp0di4sd6jzW04vVD4zbJEf
         +lhhtMYeU2QPmVuUTKzLIxsHn/hwAh+ZP88eLnyDwiFgK+W26Jt7U8AS9Dog+R+4cV
         O72BrVUnPJ/Gq/QfDDxWoySb2ttdgJ308XQPWO6hWYIA0j4YZkPvyuBaDVaO6Cn7qt
         eEWPKpAWMGsdgR1ntIyVUTNEz0Oq+Te332xF1S7885V4zhUGdUV7QM6oQve6KbfXl8
         41cEiRj7I29NA==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     bhelgaas@google.com
Cc:     mika.westerberg@linux.intel.com, koba.ko@canonical.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/3] PCI/DPC: Disable DPC interrupt during suspend
Date:   Fri, 12 May 2023 08:00:14 +0800
Message-Id: <20230512000014.118942-3-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230512000014.118942-1-kai.heng.feng@canonical.com>
References: <20230512000014.118942-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIe services that share an IRQ with PME, such as AER or DPC, may cause a
spurious wakeup on system suspend. Since DPC depends on AER to work, disable
DPC interrupt notification during the system suspend process as AER interrupt
notification is already disabled by previous patch.

As Per PCIe Base Spec 5.0, section 5.2, titled "Link State Power Management",
TLP and DLLP transmission are disabled for a Link in L2/L3 Ready (D3hot), L2
(D3cold with aux power) and L3 (D3cold) states. So disabling the DPC
notification during suspend and re-enabling them during the resume process
should not affect the basic functionality.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216295
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v6:
v5:
 - Wording.

v4:
v3:
 - No change.

v2:
 - Only disable DPC IRQ.
 - No more check on PME IRQ#.

 drivers/pci/pcie/dpc.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 3ceed8e3de41..d2d845c20438 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -384,6 +384,30 @@ static int dpc_probe(struct pcie_device *dev)
 	return status;
 }
 
+static int dpc_suspend(struct pcie_device *dev)
+{
+	struct pci_dev *pdev = dev->port;
+	u16 ctl;
+
+	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, &ctl);
+	ctl &= ~PCI_EXP_DPC_CTL_INT_EN;
+	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, ctl);
+
+	return 0;
+}
+
+static int dpc_resume(struct pcie_device *dev)
+{
+	struct pci_dev *pdev = dev->port;
+	u16 ctl;
+
+	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, &ctl);
+	ctl |= PCI_EXP_DPC_CTL_INT_EN;
+	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, ctl);
+
+	return 0;
+}
+
 static void dpc_remove(struct pcie_device *dev)
 {
 	struct pci_dev *pdev = dev->port;
@@ -399,6 +423,8 @@ static struct pcie_port_service_driver dpcdriver = {
 	.port_type	= PCIE_ANY_PORT,
 	.service	= PCIE_PORT_SERVICE_DPC,
 	.probe		= dpc_probe,
+	.suspend	= dpc_suspend,
+	.resume		= dpc_resume,
 	.remove		= dpc_remove,
 };
 
-- 
2.34.1

