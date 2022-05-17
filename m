Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2A55298DB
	for <lists+linux-pci@lfdr.de>; Tue, 17 May 2022 06:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbiEQEib (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 May 2022 00:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiEQEi3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 May 2022 00:38:29 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA5D3B293;
        Mon, 16 May 2022 21:38:27 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 9650A3FF60;
        Tue, 17 May 2022 04:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1652762305;
        bh=dUk5UzPbAaK7id+XUtZylZ2adMIECcKVZu5iTLHqEf8=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=CttwaKjmY6Rb+SwcDC6GP2cJgX6AnpP161M7TDY6Gsd6OqSXEh2ir7hmyWc68ySS/
         0Xiu8Brr4RfCdJv+q/9iiA9Y1lvaDL0fxEbb5/aqDPk/+lpZx3R1HlMaQfH34ngkdT
         Je7svv90dhn86eMG4zVo3qRP+48JOXrEeDzTJ8CZ+iQj/3kMJGLl2N1KuIaejU89oj
         aCW85us93jeVniQSll64foNExtEoG0fakIVaapMYX9zIobm4p79/YRC6POz8tijeDL
         VIHH0v3Qa+oUmzjt0t5Fj4qnmrddC0X8oNXZqHg807cxpvK5uTzfMNmzupJUxWHrls
         cvcYmatj0lTfA==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     bhelgaas@google.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: Clear PCI_STATUS when setting up the device
Date:   Tue, 17 May 2022 12:37:38 +0800
Message-Id: <20220517043738.2308499-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We are seeing Master Abort bit is set on Intel I350 ethernet device and its
root port right after boot, probably happened during BIOS phase:

00:06.0 PCI bridge [0604]: Intel Corporation Device [8086:464d] (rev 05) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-

6e:00.0 Ethernet controller [0200]: Intel Corporation I350 Gigabit Network Connection [8086:1521] (rev 01)
        Subsystem: Intel Corporation Ethernet Server Adapter I350-T2 [8086:00a2]
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-

6e:00.1 Ethernet controller [0200]: Intel Corporation I350 Gigabit Network Connection [8086:1521] (rev 01)
        Subsystem: Intel Corporation Ethernet Server Adapter I350-T2 [8086:00a2]
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-

And the Master Abort bit is cleared after S3.

Since there's no functional impact found, clear the PCI_STATUS to treat
it anew at setting up.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=215989
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/pci/probe.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 17a969942d370..414f659dc8735 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1890,6 +1890,9 @@ int pci_setup_device(struct pci_dev *dev)
 
 	dev->broken_intx_masking = pci_intx_mask_broken(dev);
 
+	/* Clear errors left from system firmware */
+	pci_write_config_word(dev, PCI_STATUS, 0xffff);
+
 	switch (dev->hdr_type) {		    /* header type */
 	case PCI_HEADER_TYPE_NORMAL:		    /* standard header */
 		if (class == PCI_CLASS_BRIDGE_PCI)
-- 
2.34.1

