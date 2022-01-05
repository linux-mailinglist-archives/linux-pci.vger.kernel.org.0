Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191FF484DFB
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jan 2022 07:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiAEGHB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jan 2022 01:07:01 -0500
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:60920
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229543AbiAEGHA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jan 2022 01:07:00 -0500
Received: from HP-EliteBook-840-G7.. (1-171-96-105.dynamic-ip.hinet.net [1.171.96.105])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id DEDEB3F12E;
        Wed,  5 Jan 2022 06:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641362819;
        bh=rkzYQXNy5rSfOPX4/VcFQGCzZzvGgGGcJg/Utakq9Ig=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=RA6vgZ4zAnDV0NxjbpJmu/hejgidurEKb7IflDVHHj+vmOcK1KTwlWQXlhP2xLqXb
         76sMAF/idcSs07qtftBwrawJsHCRZWniMWmMrmVIVtORHkBvuEiLTDNRXjStYwJ/cd
         vNSuc66j5HjlMkxE+B237TQnhkjootj+PstPQups2G1fiKu4XQ8UkGCYPU+n1sx+qR
         VpthRWHnFGlmVadsHyNxtS+3S94eysX9mB3SACwjurURnWAWC02ZjYTibBrJxzGBUC
         uvraEZ7FVQDh6H/DXmHzDdCCEwkYbscFgR0jvcy6K8IT0UknGHDTAPSyxUGw2IAOXW
         Cg5VjbR0Gi68w==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     bhelgaas@google.com
Cc:     mika.westerberg@linux.intel.com, koba.ko@canonical.com,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Lukas Wunner <lukas@wunner.de>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Jan Kiszka <jan.kiszka@siemens.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI/portdrv: Skip enabling AER on external facing ports
Date:   Wed,  5 Jan 2022 14:06:41 +0800
Message-Id: <20220105060643.822111-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Thunderbolt root ports may constantly spew out uncorrected errors
from AER service:
[   30.100211] pcieport 0000:00:1d.0: AER: Uncorrected (Non-Fatal) error received: 0000:00:1d.0
[   30.100251] pcieport 0000:00:1d.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
[   30.100256] pcieport 0000:00:1d.0:   device [8086:7ab0] error status/mask=00100000/00004000
[   30.100262] pcieport 0000:00:1d.0:    [20] UnsupReq               (First)
[   30.100267] pcieport 0000:00:1d.0: AER:   TLP Header: 34000000 08000052 00000000 00000000
[   30.100372] thunderbolt 0000:0a:00.0: AER: can't recover (no error_detected callback)
[   30.100401] xhci_hcd 0000:3e:00.0: AER: can't recover (no error_detected callback)
[   30.100427] pcieport 0000:00:1d.0: AER: device recovery failed

The link may not be reliable on external facing ports, so don't enable
AER on those ports.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=215453
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/pci/pcie/portdrv_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index bda630889f955..d464d00ade8f2 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -219,7 +219,8 @@ static int get_port_device_capability(struct pci_dev *dev)
 
 #ifdef CONFIG_PCIEAER
 	if (dev->aer_cap && pci_aer_available() &&
-	    (pcie_ports_native || host->native_aer)) {
+	    (pcie_ports_native || host->native_aer) &&
+	    !dev->external_facing) {
 		services |= PCIE_PORT_SERVICE_AER;
 
 		/*
-- 
2.33.1

