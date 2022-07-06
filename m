Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251A45685E9
	for <lists+linux-pci@lfdr.de>; Wed,  6 Jul 2022 12:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbiGFKn1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Jul 2022 06:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbiGFKnY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Jul 2022 06:43:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1654390;
        Wed,  6 Jul 2022 03:43:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CE9261E52;
        Wed,  6 Jul 2022 10:43:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44AFFC341CF;
        Wed,  6 Jul 2022 10:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657104202;
        bh=99roP7FFejJ4tHZj9bNwClVKU/G2TunICeiuDt+0hYc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vQVM0JvSni/qmtb+vV+CpQPqbeOyFsnWG3Osw+0Th+vK0NqSLNKg+N1qsBudC9ccb
         cCZ2YrwQAYFsrTq9VEN8H2e2K6v0QKaEDScGQrAOaqqnXx57l3ojtapiADZ7q90+Ln
         T4KMscRZBU8hOiU7q2FeOsJgN3hDSngSltLiaPyKTvOgl1KGnDVV8fe3re8/KjKIav
         XazxYK7Vw8oYOmPduyKSsQXUnTBK8JhhnfjOWlf8kEm3X5ZSQD8WPpJyX2pjN6e5GN
         sDVbJeWHQXZaii7lpmvq8RkBt/HAgKKR+XtutdUZLigIiwvNbj03i1my8lGmxsAGvw
         oHLpDcT7KVP7w==
Received: by pali.im (Postfix)
        id EFA197BA; Wed,  6 Jul 2022 12:43:21 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Nick Child <nick.child@ibm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] powerpc/pci: Add config option for using all 256 PCI buses
Date:   Wed,  6 Jul 2022 12:43:08 +0200
Message-Id: <20220706104308.5390-6-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220706104308.5390-1-pali@kernel.org>
References: <20220706104308.5390-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

By default on PPC32 are PCI bus numbers unique across all PCI domains.
So system could have only 256 PCI buses independently of available
PCI domains.

This is due to filling DT property pci-OF-bus-map which does not reflect
multi-domain setup.

On all powerpc platforms except chrp and powermac there is no DT property
pci-OF-bus-map anymore and therefore it is possible on non-chrp/powermac
platforms to avoid this limitation of maximal number of 256 PCI buses in
system even on multi-domain setup.

But avoiding this limitation would mean that all PCI and PCIe devices would
be present on completely different BDF addresses as every PCI domain starts
numbering PCI bueses from zero (instead of the last bus number of previous
enumerated PCI domain). Such change could break existing software which
expects fixed PCI bus numbers.

So add a new config option CONFIG_PPC_PCI_BUS_NUM_DOMAIN_DEPENDENT which
enables this change. By default it is disabled. It cause that initial value
of hose->first_busno is zero.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/powerpc/Kconfig         | 11 +++++++++++
 arch/powerpc/kernel/pci_32.c |  6 ++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index be68c1f02b79..f66084bc1dfe 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -370,6 +370,17 @@ config PPC_DCR
 	depends on PPC_DCR_NATIVE || PPC_DCR_MMIO
 	default y
 
+config PPC_PCI_BUS_NUM_DOMAIN_DEPENDENT
+	depends on PPC32
+	depends on !PPC_PMAC && !PPC_CHRP
+	bool "Assign PCI bus numbers from zero individually for each PCI domain"
+	help
+	  By default on PPC32 were PCI bus numbers unique across all PCI domains.
+	  So system could have only 256 PCI buses independently of available
+	  PCI domains. When this option is enabled then PCI bus numbers are
+	  PCI domain dependent and each PCI controller on own domain can have
+	  256 PCI buses, like it is on other Linux architectures.
+
 config PPC_OF_PLATFORM_PCI
 	bool
 	depends on PCI
diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index 2f7284b68f06..433965bf37b4 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -239,7 +239,9 @@ void pcibios_setup_phb_io_space(struct pci_controller *hose)
 static int __init pcibios_init(void)
 {
 	struct pci_controller *hose, *tmp;
+#ifndef CONFIG_PPC_PCI_BUS_NUM_DOMAIN_DEPENDENT
 	int next_busno = 0;
+#endif
 
 	printk(KERN_INFO "PCI: Probing PCI hardware\n");
 
@@ -248,13 +250,17 @@ static int __init pcibios_init(void)
 
 	/* Scan all of the recorded PCI controllers.  */
 	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
+#ifndef CONFIG_PPC_PCI_BUS_NUM_DOMAIN_DEPENDENT
 		if (pci_assign_all_buses)
 			hose->first_busno = next_busno;
+#endif
 		hose->last_busno = 0xff;
 		pcibios_scan_phb(hose);
 		pci_bus_add_devices(hose->bus);
+#ifndef CONFIG_PPC_PCI_BUS_NUM_DOMAIN_DEPENDENT
 		if (pci_assign_all_buses || next_busno <= hose->last_busno)
 			next_busno = hose->last_busno + pcibios_assign_bus_offset;
+#endif
 	}
 
 #if defined(CONFIG_PPC_PMAC) || defined(CONFIG_PPC_CHRP)
-- 
2.20.1

