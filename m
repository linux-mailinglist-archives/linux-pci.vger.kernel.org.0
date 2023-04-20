Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B00F6E87B6
	for <lists+linux-pci@lfdr.de>; Thu, 20 Apr 2023 03:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjDTB7V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Apr 2023 21:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjDTB7V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Apr 2023 21:59:21 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5895170A;
        Wed, 19 Apr 2023 18:59:19 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 916A741ABE;
        Thu, 20 Apr 2023 01:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1681955958;
        bh=uRHcymisTbjiBf6eWzZPbcaSHTQevSe81zNyL32cDvU=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=krhyCaDJJrOGxSCNeq+hJJTpAxyQFFwUMA2ajAcje1eWMWOYGhKUx8gX0DFmexjgQ
         eu+Ev/aQ722WUrCSYAWPcJmMDQT2X4LivX+s29pQ3+B9iHmVTAOae+vSMdna+auxxk
         8JoqAKfLAzo0U47lVkqVO4coAIC9iLP1+2tvGKhZzkiyEhsnzlGIAjeSQ1CsCBFIYZ
         1RRzty+DF0uQxrcNatimBPx6ZOCbUxgjMSG2KmDV6w48G/C0zWLHRLkzwmHKsfidYl
         yCxpIPknuP76Kjy5xnZmJbIZ/tTNVMd1zzFvWTddHNCRdT0L22eFHwE+vpZPJ7ctkQ
         BTdaSqoDLunxw==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     bhelgaas@google.com
Cc:     mika.westerberg@linux.intel.com, koba.ko@canonical.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] PCI: Keep AER status in pci_restore_state()
Date:   Thu, 20 Apr 2023 09:58:27 +0800
Message-Id: <20230420015830.309845-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When AER is using the same IRQ as PME, AER interrupt is treated as a
wakeup event and it can disrupt system suspend process.

If that happens, the system will report it's woken up by PME IRQ without
indicating any AER error since AER status is cleared on resume.

So keep the AER status so users can know the system is woken up by AER
instead of PME.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2:
 - New patch.

 drivers/pci/pci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7a67611dc5f4..71aead00fc20 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1778,7 +1778,6 @@ void pci_restore_state(struct pci_dev *dev)
 	pci_restore_dpc_state(dev);
 	pci_restore_ptm_state(dev);
 
-	pci_aer_clear_status(dev);
 	pci_restore_aer_state(dev);
 
 	pci_restore_config_space(dev);
-- 
2.34.1

