Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D675911FC
	for <lists+linux-pci@lfdr.de>; Fri, 12 Aug 2022 16:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238897AbiHLOL2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Aug 2022 10:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237287AbiHLOL2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Aug 2022 10:11:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4B460D1;
        Fri, 12 Aug 2022 07:11:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA633617C9;
        Fri, 12 Aug 2022 14:11:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E20BEC433C1;
        Fri, 12 Aug 2022 14:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660313486;
        bh=BTGirNTJKdOnbxrAivRXR4fKPWdv5EpCDd3Iq4xnpCA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p41Ag3Jsx9Xs+AbvaQ+ME2QzTXDmaMpPLcQWP5IUC+d8vAgBuOG99J/X6qhmRtYu6
         DgTYuQn/Ff3wvS4zKe0nMQM3dPJ0eWnWmUzdkvzscotpLauNKgIo7hBdgzE/ZI9e23
         l9OA7+SiV4xfLbnjJEAUA4Eut+z6nQy1knVxebl/8s4RfiHDNzGidJhyHKDOTmD8tG
         vF+lCRTwDIhG64vdqgD5K7/cYkbt9Ej1zC0i1ci4me/AQy15PETrO1fg1OQB7O0THX
         QZVOwD9ePNt55zWVQQGTb4Fxe4g9oVj6nqZh19pKzta5mCTsriHQatl94kquJA+hFo
         l6/rMaIcxEERg==
Received: by pali.im (Postfix)
        id 40AAC9CF; Fri, 12 Aug 2022 16:11:23 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCI: mvebu: Fix endianity when accessing pci emul bridge members
Date:   Fri, 12 Aug 2022 16:11:15 +0200
Message-Id: <20220812141115.24082-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220812094058.16141-1-pali@kernel.org>
References: <20220812094058.16141-1-pali@kernel.org>
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
Changes in v2:
* Fix parenthesis around le16_to_cpu() calls
---
 drivers/pci/controller/pci-mvebu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 0798ed182a96..b04b9bbe9217 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -587,7 +587,7 @@ static int mvebu_pcie_handle_iobase_change(struct mvebu_pcie_port *port)
 
 	/* Are the new iobase/iolimit values invalid? */
 	if (conf->iolimit < conf->iobase ||
-	    conf->iolimitupper < conf->iobaseupper)
+	    le16_to_cpu(conf->iolimitupper) < le16_to_cpu(conf->iobaseupper))
 		return mvebu_pcie_set_window(port, port->io_target, port->io_attr,
 					     &desired, &port->iowin);
 
@@ -599,10 +599,10 @@ static int mvebu_pcie_handle_iobase_change(struct mvebu_pcie_port *port)
 	 * is the CPU address.
 	 */
 	desired.remap = ((conf->iobase & 0xF0) << 8) |
-			(conf->iobaseupper << 16);
+			(le16_to_cpu(conf->iobaseupper) << 16);
 	desired.base = port->pcie->io.start + desired.remap;
 	desired.size = ((0xFFF | ((conf->iolimit & 0xF0) << 8) |
-			 (conf->iolimitupper << 16)) -
+			 (le16_to_cpu(conf->iolimitupper) << 16)) -
 			desired.remap) +
 		       1;
 
@@ -616,7 +616,7 @@ static int mvebu_pcie_handle_membase_change(struct mvebu_pcie_port *port)
 	struct pci_bridge_emul_conf *conf = &port->bridge.conf;
 
 	/* Are the new membase/memlimit values invalid? */
-	if (conf->memlimit < conf->membase)
+	if (le16_to_cpu(conf->memlimit) < le16_to_cpu(conf->membase))
 		return mvebu_pcie_set_window(port, port->mem_target, port->mem_attr,
 					     &desired, &port->memwin);
 
@@ -626,8 +626,8 @@ static int mvebu_pcie_handle_membase_change(struct mvebu_pcie_port *port)
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

