Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDA072B304
	for <lists+linux-pci@lfdr.de>; Sun, 11 Jun 2023 19:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjFKRTW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 11 Jun 2023 13:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233530AbjFKRTV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Jun 2023 13:19:21 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 72CBBE5F;
        Sun, 11 Jun 2023 10:19:18 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 0EA1A9200B4; Sun, 11 Jun 2023 19:19:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 0B5499200B3;
        Sun, 11 Jun 2023 18:19:15 +0100 (BST)
Date:   Sun, 11 Jun 2023 18:19:14 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
cc:     Alex Williamson <alex.williamson@redhat.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Stefan Roese <sr@denx.de>, Jim Wilson <wilson@tuliptree.org>,
        David Abdurachmanov <david.abdurachmanov@gmail.com>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 01/14] PCI: pciehp: Rely on `link_active_reporting'
In-Reply-To: <alpine.DEB.2.21.2305310024400.59226@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2305310028150.59226@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2305310024400.59226@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use `link_active_reporting' to determine whether Data Link Layer Link 
Active Reporting is available rather than re-retrieving the capability.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
---
NB this has been compile-tested only with PPC64LE and x86-64
configurations.

No change from v8.

Changes from v7:

- Add Reviewed-by: tag by Lukas Wunner.

- Reorder from 6/7.

No change from v6.

New change in v6.
---
 drivers/pci/hotplug/pciehp_hpc.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

linux-pcie-link-active-reporting-hpc.diff
Index: linux-macro/drivers/pci/hotplug/pciehp_hpc.c
===================================================================
--- linux-macro.orig/drivers/pci/hotplug/pciehp_hpc.c
+++ linux-macro/drivers/pci/hotplug/pciehp_hpc.c
@@ -984,7 +984,7 @@ static inline int pcie_hotplug_depth(str
 struct controller *pcie_init(struct pcie_device *dev)
 {
 	struct controller *ctrl;
-	u32 slot_cap, slot_cap2, link_cap;
+	u32 slot_cap, slot_cap2;
 	u8 poweron;
 	struct pci_dev *pdev = dev->port;
 	struct pci_bus *subordinate = pdev->subordinate;
@@ -1030,9 +1030,6 @@ struct controller *pcie_init(struct pcie
 	if (dmi_first_match(inband_presence_disabled_dmi_table))
 		ctrl->inband_presence_disabled = 1;
 
-	/* Check if Data Link Layer Link Active Reporting is implemented */
-	pcie_capability_read_dword(pdev, PCI_EXP_LNKCAP, &link_cap);
-
 	/* Clear all remaining event bits in Slot Status register. */
 	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
 		PCI_EXP_SLTSTA_ABP | PCI_EXP_SLTSTA_PFD |
@@ -1051,7 +1048,7 @@ struct controller *pcie_init(struct pcie
 		FLAG(slot_cap, PCI_EXP_SLTCAP_EIP),
 		FLAG(slot_cap, PCI_EXP_SLTCAP_NCCS),
 		FLAG(slot_cap2, PCI_EXP_SLTCAP2_IBPD),
-		FLAG(link_cap, PCI_EXP_LNKCAP_DLLLARC),
+		FLAG(pdev->link_active_reporting, true),
 		pdev->broken_cmd_compl ? " (with Cmd Compl erratum)" : "");
 
 	/*
