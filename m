Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75FF590E48
	for <lists+linux-pci@lfdr.de>; Fri, 12 Aug 2022 11:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237564AbiHLJlX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Aug 2022 05:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiHLJlW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Aug 2022 05:41:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD80F832C1;
        Fri, 12 Aug 2022 02:41:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 88855B82381;
        Fri, 12 Aug 2022 09:41:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065F7C433C1;
        Fri, 12 Aug 2022 09:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660297279;
        bh=55Efb2gdzPjhW+qOIM5Dyr4neXhJPdJKwm88KVCVi50=;
        h=From:To:Cc:Subject:Date:From;
        b=mvbs34zQ+bawuchqVsh6v9z0FLxlCScGVfyftyUSFVrxxxKKdmVobpjOisREaxnIK
         Y0IBKU9aHHcdj397eDM4ZR7e5l2ivB3TgOcO1wweWv16K2wy+CqBrKdbu98RDFl1nF
         J/n68PgZQIEl2TEG4Q9Dc8UuC01BCM74V4vz+xGgr7WS7lv6PjsR4rgmwCJTi04whQ
         JbigfVIEXzSLWYMwcGOZgECeV73s3TwMglkGKzJA8WppfyWPICSWXcj3TKEcPE5Z/2
         hqc5+n0K9AzT6PP6VXQXxKt1svQ8DhIr5PNzuAdDfiwsIPNtnkYCmR1rhqRcAeQkCp
         GUULC9xVN37rA==
Received: by pali.im (Postfix)
        id 396B09CF; Fri, 12 Aug 2022 11:41:16 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: mvebu: Fix endianity when accessing pci emul bridge members
Date:   Fri, 12 Aug 2022 11:40:58 +0200
Message-Id: <20220812094058.16141-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI emul bridge members iolimitupper, iobaseupper, memlimit and membase are
of type __le16, so correctly access these members via le16_to_cpu() macros.

Fixes: 4ded69473adb ("PCI: mvebu: Propagate errors when updating PCI_IO_BASE and PCI_MEM_BASE registers")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/controller/pci-mvebu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index c1ffdb06c971..00ea0836b81a 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -523,7 +523,7 @@ static int mvebu_pcie_handle_iobase_change(struct mvebu_pcie_port *port)
 
 	/* Are the new iobase/iolimit values invalid? */
 	if (conf->iolimit < conf->iobase ||
-	    conf->iolimitupper < conf->iobaseupper)
+	    le16_to_cpu(conf->iolimitupper) < le16_to_cpu(conf->iobaseupper))
 		return mvebu_pcie_set_window(port, port->io_target, port->io_attr,
 					     &desired, &port->iowin);
 
@@ -535,10 +535,10 @@ static int mvebu_pcie_handle_iobase_change(struct mvebu_pcie_port *port)
 	 * is the CPU address.
 	 */
 	desired.remap = ((conf->iobase & 0xF0) << 8) |
-			(conf->iobaseupper << 16);
+			le16_to_cpu(conf->iobaseupper << 16);
 	desired.base = port->pcie->io.start + desired.remap;
 	desired.size = ((0xFFF | ((conf->iolimit & 0xF0) << 8) |
-			 (conf->iolimitupper << 16)) -
+			 le16_to_cpu(conf->iolimitupper << 16)) -
 			desired.remap) +
 		       1;
 
@@ -552,7 +552,7 @@ static int mvebu_pcie_handle_membase_change(struct mvebu_pcie_port *port)
 	struct pci_bridge_emul_conf *conf = &port->bridge.conf;
 
 	/* Are the new membase/memlimit values invalid? */
-	if (conf->memlimit < conf->membase)
+	if (le16_to_cpu(conf->memlimit) < le16_to_cpu(conf->membase))
 		return mvebu_pcie_set_window(port, port->mem_target, port->mem_attr,
 					     &desired, &port->memwin);
 
@@ -562,8 +562,8 @@ static int mvebu_pcie_handle_membase_change(struct mvebu_pcie_port *port)
 	 * window to setup, according to the PCI-to-PCI bridge
 	 * specifications.
 	 */
-	desired.base = ((conf->membase & 0xFFF0) << 16);
-	desired.size = (((conf->memlimit & 0xFFF0) << 16) | 0xFFFFF) -
+	desired.base = ((le16_to_cpu(conf->membase) & 0xFFF0) << 16);
+	desired.size = (((le16_to_cpu(conf->memlimit) & 0xFFF0) << 16) | 0xFFFFF) -
 		       desired.base + 1;
 
 	return mvebu_pcie_set_window(port, port->mem_target, port->mem_attr, &desired,
-- 
2.20.1

