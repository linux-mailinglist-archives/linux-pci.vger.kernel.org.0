Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574F66FFDAA
	for <lists+linux-pci@lfdr.de>; Fri, 12 May 2023 02:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238815AbjELAKH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 May 2023 20:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjELAKH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 May 2023 20:10:07 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F1E1FEB;
        Thu, 11 May 2023 17:10:05 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 4871641796;
        Fri, 12 May 2023 00:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1683849669;
        bh=uxqAWKUPbR7c0aBs6GBOKeMBFdLKmA+MukXx6becr3E=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=vixwvTjVrg/YI6q79kJpJo0G2YUjVu1J+Mj24FVYhAmYIyrB5OiTV1ScrgxpaR/m9
         cxSuRtQwxdF0E/vpU7RsVGzQEzizK3CHpWKZoxD53DeSKdsRenRym4HbsLztgRyVnM
         M4v3iCl+zWfu9m8bve1J4Y82wd3frjvEszMbVdT3YjZf489WdkAIw/i7foiP4bbdQT
         dwHVtHDpsRjzxGSXjTezOwv3FjKmsC2s4aeiVU9UBYfSXDzP3fR5Xudl2r+Qoe8dvy
         5oVmh/iJKpZ8DuV7BFDnMisQ9Z5BXD8qujKGrIZ3evHlF/EqDQVm3KayMotiDrB0OB
         yu31Qm2ZO76lA==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     bhelgaas@google.com
Cc:     mika.westerberg@linux.intel.com, koba.ko@canonical.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/3] PCI/AER: Disable AER interrupt on suspend
Date:   Fri, 12 May 2023 08:00:13 +0800
Message-Id: <20230512000014.118942-2-kai.heng.feng@canonical.com>
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
spurious wakeup on system suspend. To prevent this, disable the AER interrupt
notification during the system suspend process.

As Per PCIe Base Spec 5.0, section 5.2, titled "Link State Power Management",
TLP and DLLP transmission are disabled for a Link in L2/L3 Ready (D3hot), L2
(D3cold with aux power) and L3 (D3cold) states. So disabling the AER
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
 - Only disable AER IRQ.
 - No more check on PME IRQ#.
 - Use helper.

 drivers/pci/pcie/aer.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 1420e1f27105..9c07fdbeb52d 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1356,6 +1356,26 @@ static int aer_probe(struct pcie_device *dev)
 	return 0;
 }
 
+static int aer_suspend(struct pcie_device *dev)
+{
+	struct aer_rpc *rpc = get_service_data(dev);
+	struct pci_dev *pdev = rpc->rpd;
+
+	aer_disable_irq(pdev);
+
+	return 0;
+}
+
+static int aer_resume(struct pcie_device *dev)
+{
+	struct aer_rpc *rpc = get_service_data(dev);
+	struct pci_dev *pdev = rpc->rpd;
+
+	aer_enable_irq(pdev);
+
+	return 0;
+}
+
 /**
  * aer_root_reset - reset Root Port hierarchy, RCEC, or RCiEP
  * @dev: pointer to Root Port, RCEC, or RCiEP
@@ -1420,6 +1440,8 @@ static struct pcie_port_service_driver aerdriver = {
 	.service	= PCIE_PORT_SERVICE_AER,
 
 	.probe		= aer_probe,
+	.suspend	= aer_suspend,
+	.resume		= aer_resume,
 	.remove		= aer_remove,
 };
 
-- 
2.34.1

