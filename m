Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71EF468B0B0
	for <lists+linux-pci@lfdr.de>; Sun,  5 Feb 2023 16:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjBEPtl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 5 Feb 2023 10:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjBEPtY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 5 Feb 2023 10:49:24 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C2961F4B0;
        Sun,  5 Feb 2023 07:49:13 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 97BD39200C0; Sun,  5 Feb 2023 16:49:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 910D59200BF;
        Sun,  5 Feb 2023 15:49:12 +0000 (GMT)
Date:   Sun, 5 Feb 2023 15:49:12 +0000 (GMT)
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
Subject: [PATCH v6 4/7] powerpc/eeh: Rely on `link_active_reporting'
In-Reply-To: <alpine.DEB.2.21.2302022022230.45310@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2302051441470.33812@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2302022022230.45310@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use `link_active_reporting' to determine whether Data Link Layer Link 
Active Reporting is available rather than re-retrieving the capability.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
NB this has been compile-tested only with a PPC64LE configuration.

New change in v6.
---
 arch/powerpc/kernel/eeh_pe.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

linux-pcie-link-active-reporting-eeh.diff
Index: linux-macro/arch/powerpc/kernel/eeh_pe.c
===================================================================
--- linux-macro.orig/arch/powerpc/kernel/eeh_pe.c
+++ linux-macro/arch/powerpc/kernel/eeh_pe.c
@@ -671,9 +671,8 @@ static void eeh_bridge_check_link(struct
 	eeh_ops->write_config(edev, cap + PCI_EXP_LNKCTL, 2, val);
 
 	/* Check link */
-	eeh_ops->read_config(edev, cap + PCI_EXP_LNKCAP, 4, &val);
-	if (!(val & PCI_EXP_LNKCAP_DLLLARC)) {
-		eeh_edev_dbg(edev, "No link reporting capability (0x%08x) \n", val);
+	if (!edev->pdev->link_active_reporting) {
+		eeh_edev_dbg(edev, "No link reporting capability\n");
 		msleep(1000);
 		return;
 	}
