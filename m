Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20FC96563D7
	for <lists+linux-pci@lfdr.de>; Mon, 26 Dec 2022 16:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiLZPbl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Dec 2022 10:31:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiLZPbk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Dec 2022 10:31:40 -0500
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7372135;
        Mon, 26 Dec 2022 07:31:38 -0800 (PST)
Received: from localhost.localdomain (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 9281E42832;
        Mon, 26 Dec 2022 15:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1672068697;
        bh=0MdCug5jtApVxCbACAza5eayqP2DubrBGd6UD6PDHQU=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=l2Js2VpTmoMTGvjnbPFLWivfBUPBu2r/d4McFVg49MR6NpOCUJ1qkdwm3n51ExOkf
         dzi3vJI1lHc2Ma2FnBgQTZKhmyOfKVn5a6aD1LBDfxHWRs+xUJQ3Rl/AhX3+iqYB/J
         CC6h9sB4zp933VItC20tE/xhsk9JU9Lrmg9RPqFlJtgRSgUF7G8WwXHxxMxKiZCgtg
         JHdp4WyfUBCcWIE67i3aklMSzCr87Rp/NYTGNLhC++aOg2lMO/Ju17sPbq3wuceK+9
         +r7EenhFLjksUR9qSh8ORprA5ZXNOWsG4xK96a4Mkqtgo7cQXE1OD8fM0LQ+BeYbnm
         xjvxedttKn1Gw==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     bhelgaas@google.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <kbusch@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Stefan Roese <sr@denx.de>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI/portdrv: Avoid enabling AER on Thunderbolt devices
Date:   Mon, 26 Dec 2022 23:30:31 +0800
Message-Id: <20221226153048.1208359-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We are seeing igc ethernet device on Thunderbolt dock stops working
after S3 resume because of AER error, or even make S3 resume freeze:
pcieport 0000:00:1d.0: AER: Multiple Corrected error received: 0000:00:1d.0
pcieport 0000:00:1d.0: PCIe Bus Error: severity=Corrected, type=Transaction Layer, (Receiver ID)
pcieport 0000:00:1d.0:   device [8086:7ab0] error status/mask=00008000/00002000
pcieport 0000:00:1d.0:    [15] HeaderOF
pcieport 0000:00:1d.0: AER: Multiple Uncorrected (Non-Fatal) error received: 0000:00:1d.0
pcieport 0000:00:1d.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
pcieport 0000:00:1d.0:   device [8086:7ab0] error status/mask=00100000/00004000
pcieport 0000:00:1d.0:    [20] UnsupReq               (First)
pcieport 0000:00:1d.0: AER:   TLP Header: 34000000 0a000052 00000000 00000000
pcieport 0000:00:1d.0: AER:   Error of this Agent is reported first
pcieport 0000:04:01.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
pcieport 0000:04:01.0:   device [8086:1136] error status/mask=00300000/00000000
pcieport 0000:04:01.0:    [20] UnsupReq               (First)
pcieport 0000:04:01.0:    [21] ACSViol
pcieport 0000:04:01.0: AER:   TLP Header: 34000000 04000052 00000000 00000000
thunderbolt 0000:05:00.0: AER: can't recover (no error_detected callback)

This supposedly should be fixed by commit c01163dbd1b8 ("PCI/PM: Always disable
PTM for all devices during suspend"), but somehow it doesn't work for
this case.

By dumping the PCI_PTM_CTRL register on resume, it turns out PTM is
already flipped on by either the Thunderbolt dock firmware or the host
BIOS. Writing 0 to PCI_PTM_CTRL yields the same result.

Windows is however not affected by this issue, by using WinDbg's !pci
command, it shows that AER is not enabled for devices connected via
Thunderbolt port, and that's the reason why Windows doesn't exhibit the
issue.

So turn a blind eye on external Thunderbolt devices like Windows does by
disabling AER.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=216850
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/pci/pcie/portdrv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 2cc2e60bcb396..59d00e20e57bf 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -237,7 +237,8 @@ static int get_port_device_capability(struct pci_dev *dev)
 	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
              pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) &&
 	    dev->aer_cap && pci_aer_available() &&
-	    (pcie_ports_native || host->native_aer))
+	    (pcie_ports_native || host->native_aer) &&
+	    !dev_is_removable(&dev->dev))
 		services |= PCIE_PORT_SERVICE_AER;
 #endif
 
-- 
2.34.1

