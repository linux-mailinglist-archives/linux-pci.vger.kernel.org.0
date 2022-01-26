Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0984049C420
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jan 2022 08:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237687AbiAZHTM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jan 2022 02:19:12 -0500
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:46848
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229550AbiAZHTM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Jan 2022 02:19:12 -0500
Received: from HP-EliteBook-840-G7.. (36-229-235-192.dynamic-ip.hinet.net [36.229.235.192])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id DCD0440079;
        Wed, 26 Jan 2022 07:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643181545;
        bh=SX4Vqv0MgFMMyb7XcP9OdhoHt+rK97CVedkc1Myil8A=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=V5yzv/xZzyNhImNVpfZeU2yjYLYLUXUG6uYiQQ7TzrPwOD9ERqPTsse722i3A2o2R
         ZhOlh7Gxbe8JuuUV+PviTJEdrJhm13Ms4ZYmeDqVD74IUhmHEunrlsKE9uv0Rb/BDn
         MOwRKUMEpK0yBevpyGh30tdrIax1tZ95C5CjAmlGABsho2qHg4I4MOVMXC/faCKR28
         akuehyrMvRYFV9pRRJ4QxYvEBVw9WyLRraKgzXVrd+DR1hZsPG0DucEKzPaDzkEC8N
         CaXhwv6B+kWU/h0aKUFWKQIEKmRrDf+hl1dl2OHA1DIWd1C2X33K0S2TM5F+QVU0Zs
         GjQPKza+6obpg==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     bhelgaas@google.com
Cc:     mika.westerberg@linux.intel.com, koba.ko@canonical.com,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Russell Currey <ruscur@russell.cc>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Lalithambika Krishnakumar <lalithambika.krishnakumar@intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] PCI/AER: Disable AER when link is in L2/L3 ready, L2 and L3 state
Date:   Wed, 26 Jan 2022 15:18:51 +0800
Message-Id: <20220126071853.1940111-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit 50310600ebda ("iommu/vt-d: Enable PCI ACS for platform opt in
hint") enables ACS, and some platforms lose its NVMe after resume from
S3:
[   50.947816] pcieport 0000:00:1b.0: DPC: containment event, status:0x1f01 source:0x0000
[   50.947817] pcieport 0000:00:1b.0: DPC: unmasked uncorrectable error detected
[   50.947829] pcieport 0000:00:1b.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Receiver ID)
[   50.947830] pcieport 0000:00:1b.0:   device [8086:06ac] error status/mask=00200000/00010000
[   50.947831] pcieport 0000:00:1b.0:    [21] ACSViol                (First)
[   50.947841] pcieport 0000:00:1b.0: AER: broadcast error_detected message
[   50.947843] nvme nvme0: frozen state error detected, reset controller

It happens right after ACS gets enabled during resume.

There's another case, when Thunderbolt reaches D3cold:
[   30.100211] pcieport 0000:00:1d.0: AER: Uncorrected (Non-Fatal) error received: 0000:00:1d.0
[   30.100251] pcieport 0000:00:1d.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
[   30.100256] pcieport 0000:00:1d.0:   device [8086:7ab0] error status/mask=00100000/00004000
[   30.100262] pcieport 0000:00:1d.0:    [20] UnsupReq               (First)
[   30.100267] pcieport 0000:00:1d.0: AER:   TLP Header: 34000000 08000052 00000000 00000000
[   30.100372] thunderbolt 0000:0a:00.0: AER: can't recover (no error_detected callback)
[   30.100401] xhci_hcd 0000:3e:00.0: AER: can't recover (no error_detected callback)
[   30.100427] pcieport 0000:00:1d.0: AER: device recovery failed

Since PCIe spec "5.2 Link State Power Management" states that TLP and DLLP
transmission is disabled for a Link in L2/L3 Ready (D3hot), L2 (D3cold with aux
power) and L3 (D3cold), so disable AER to avoid the noises from turning power
rails on/off.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=209149
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=215453
Fixes: 50310600ebda ("iommu/vt-d: Enable PCI ACS for platform opt in hint")
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/pci/pcie/aer.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 9fa1f97e5b270..e4e9d4a3098d7 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1367,6 +1367,22 @@ static int aer_probe(struct pcie_device *dev)
 	return 0;
 }
 
+static int aer_suspend(struct pcie_device *dev)
+{
+	struct aer_rpc *rpc = get_service_data(dev);
+
+	aer_disable_rootport(rpc);
+	return 0;
+}
+
+static int aer_resume(struct pcie_device *dev)
+{
+	struct aer_rpc *rpc = get_service_data(dev);
+
+	aer_enable_rootport(rpc);
+	return 0;
+}
+
 /**
  * aer_root_reset - reset Root Port hierarchy, RCEC, or RCiEP
  * @dev: pointer to Root Port, RCEC, or RCiEP
@@ -1433,12 +1449,15 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 }
 
 static struct pcie_port_service_driver aerdriver = {
-	.name		= "aer",
-	.port_type	= PCIE_ANY_PORT,
-	.service	= PCIE_PORT_SERVICE_AER,
-
-	.probe		= aer_probe,
-	.remove		= aer_remove,
+	.name			= "aer",
+	.port_type		= PCIE_ANY_PORT,
+	.service		= PCIE_PORT_SERVICE_AER,
+	.probe			= aer_probe,
+	.suspend		= aer_suspend,
+	.resume			= aer_resume,
+	.runtime_suspend	= aer_suspend,
+	.runtime_resume		= aer_resume,
+	.remove			= aer_remove,
 };
 
 /**
-- 
2.33.1

