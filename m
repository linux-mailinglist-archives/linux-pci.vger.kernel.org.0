Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38315685EA
	for <lists+linux-pci@lfdr.de>; Wed,  6 Jul 2022 12:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbiGFKnb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Jul 2022 06:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbiGFKn3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Jul 2022 06:43:29 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6575BC26;
        Wed,  6 Jul 2022 03:43:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9AA54CE1EC5;
        Wed,  6 Jul 2022 10:43:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B45D9C341CB;
        Wed,  6 Jul 2022 10:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657104200;
        bh=2i4XkrOKAvEY4kt51QJGqvVCb9gTrdzZN17RM/W6jF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TZJK5VfYPdeR1Bn+XOMd6WXnxO+p3Wr5Bkgn4nhjE12pygsUgOZm9OQPMRFZ89lRz
         /ANQlCA3A0g0e5heGDCD8RPkJWPGRetnO6riSnQJsZrPrS5d0VcPpv0ajMBul6+uXT
         NXrs7B/+KIgl2mtB1Q0MQNHiSsoddXThcz21pCrxjUOqzBbXK/ijF5TkASq7HCCjPz
         5LRww1QlBmHfiXnoJC8+Q+ij/jH0AVXusYUwQZKOsW/uHC4dcJwKblCnpUUHd88J8e
         x8XiPQwwj4RpiL/X9meTKljxp0ZjR+/OayZ8BBT6Sb0KRW4lBU06os1I0e2mWKNobu
         xJJLkaQS+12kQ==
Received: by pali.im (Postfix)
        id 3BFC07F1; Wed,  6 Jul 2022 12:43:18 +0200 (CEST)
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
Subject: [PATCH 1/5] powerpc/pci: Hide pci_device_from_OF_node() for non-powermac code
Date:   Wed,  6 Jul 2022 12:43:04 +0200
Message-Id: <20220706104308.5390-2-pali@kernel.org>
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

Function pci_device_from_OF_node() is used only in powermac code.
So hide it from all other platforms as it is unsed.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/powerpc/include/asm/pci-bridge.h | 2 ++
 arch/powerpc/kernel/pci_32.c          | 2 ++
 arch/powerpc/kernel/pci_64.c          | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index c85f901227c9..98156932a1f5 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -170,8 +170,10 @@ static inline struct pci_controller *pci_bus_to_host(const struct pci_bus *bus)
 	return bus->sysdata;
 }
 
+#ifdef CONFIG_PPC_PMAC
 extern int pci_device_from_OF_node(struct device_node *node,
 				   u8 *bus, u8 *devfn);
+#endif
 #ifndef CONFIG_PPC64
 
 extern void pci_create_OF_bus_map(void);
diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index 5a174936c9a0..c3b91fb62a71 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -154,6 +154,7 @@ pcibios_make_OF_bus_map(void)
 }
 
 
+#ifdef CONFIG_PPC_PMAC
 /*
  * Returns the PCI device matching a given OF node
  */
@@ -193,6 +194,7 @@ int pci_device_from_OF_node(struct device_node *node, u8 *bus, u8 *devfn)
 	return -ENODEV;
 }
 EXPORT_SYMBOL(pci_device_from_OF_node);
+#endif
 
 /* We create the "pci-OF-bus-map" property now so it appears in the
  * /proc device tree
diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 19b03ddf5631..0c7cfb9fab04 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -286,6 +286,7 @@ int pcibus_to_node(struct pci_bus *bus)
 EXPORT_SYMBOL(pcibus_to_node);
 #endif
 
+#ifdef CONFIG_PPC_PMAC
 int pci_device_from_OF_node(struct device_node *np, u8 *bus, u8 *devfn)
 {
 	if (!PCI_DN(np))
@@ -294,3 +295,4 @@ int pci_device_from_OF_node(struct device_node *np, u8 *bus, u8 *devfn)
 	*devfn = PCI_DN(np)->devfn;
 	return 0;
 }
+#endif
-- 
2.20.1

