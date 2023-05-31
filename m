Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C2A717E15
	for <lists+linux-pci@lfdr.de>; Wed, 31 May 2023 13:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbjEaLdX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 May 2023 07:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234709AbjEaLdW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 May 2023 07:33:22 -0400
X-Greylist: delayed 2551 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 31 May 2023 04:33:20 PDT
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00826B2
        for <linux-pci@vger.kernel.org>; Wed, 31 May 2023 04:33:20 -0700 (PDT)
Received: from [167.98.27.226] (helo=rainbowdash)
        by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1q4JPh-0071l0-C8; Wed, 31 May 2023 11:50:45 +0100
Received: from ben by rainbowdash with local (Exim 4.96)
        (envelope-from <ben@rainbowdash>)
        id 1q4JPg-001F3p-2t;
        Wed, 31 May 2023 11:50:44 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-pci@vger.kernel.org, bhelgaas@google.com
Cc:     Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>,
        Jude Onyenegecha <jude.onyenegecha@codethink.co.uk>,
        Greentime Hu <greentime.hu@sifive.com>,
        Jeegar Lakhani <jeegar.lakhani@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCHv2] pci: add PCI_EXT_CAP_ID_PL_32GT define
Date:   Wed, 31 May 2023 10:57:13 +0100
Message-Id: <20230531095713.293229-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ben Dooks <ben.dooks@sifive.com>

Add the define for PCI_EXT_CAP_ID_PL_32GT for drivers that
will want this whilst doing Gen5/Gen6 accesses.

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
--
v2:
  - fixed tabs
---
 include/uapi/linux/pci_regs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index dc2000e0fe3a..e5f558d96493 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -738,6 +738,7 @@
 #define PCI_EXT_CAP_ID_DVSEC	0x23	/* Designated Vendor-Specific */
 #define PCI_EXT_CAP_ID_DLF	0x25	/* Data Link Feature */
 #define PCI_EXT_CAP_ID_PL_16GT	0x26	/* Physical Layer 16.0 GT/s */
+#define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical Layer 32.0 GT/s */
 #define PCI_EXT_CAP_ID_DOE	0x2E	/* Data Object Exchange */
 #define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_DOE
 
-- 
2.39.2

