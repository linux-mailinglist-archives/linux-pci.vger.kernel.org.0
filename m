Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549FB5685E7
	for <lists+linux-pci@lfdr.de>; Wed,  6 Jul 2022 12:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbiGFKnZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Jul 2022 06:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbiGFKnY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Jul 2022 06:43:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC89B49;
        Wed,  6 Jul 2022 03:43:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5515861E54;
        Wed,  6 Jul 2022 10:43:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D47C341D0;
        Wed,  6 Jul 2022 10:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657104202;
        bh=j5IOHlX255HFSnaMvWUb7Q8STsC+hRHhN52ol+fdQ2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tatURPUrAkHQIf+OcPOWiC9vJNvtxd9rvTQGIhwklmkCYBo2rzlpzyZCzdzB1Aiy2
         AXxFRkxOKMd+vRdIjysrVF2IWc8DWZUOFQ96DwcjKHdGvNG3/auFx91IeORHMSwKCS
         1GAk/jB75OIuOWU8Khm/96Hg+qbBpQYP0w4qtUegp7aAGsIfypGvioRP0juTktdTc3
         bAbRzpwS/Cs8sP+tFhM9XsJnO/lAjU1MekIWk0ostbGadOJ67BRItfha/TJ/6wVoiY
         9EWus6IwgsTmkHRSCebFHqPaX619oDqt5CnD9RwuoOahAlHhszNtYEV10hirpZ3ERk
         2XDJjyFrnnWMw==
Received: by pali.im (Postfix)
        id 1CDAD825; Wed,  6 Jul 2022 12:43:20 +0200 (CEST)
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
Subject: [PATCH 3/5] powerpc/pci: Hide pci_create_OF_bus_map() for non-chrp code
Date:   Wed,  6 Jul 2022 12:43:06 +0200
Message-Id: <20220706104308.5390-4-pali@kernel.org>
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

Function pci_create_OF_bus_map() is used only in chrp code.
So hide it from all other platforms as it is unsed.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/powerpc/include/asm/pci-bridge.h | 2 ++
 arch/powerpc/kernel/pci_32.c          | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 98156932a1f5..e18c95f4e1d4 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -176,7 +176,9 @@ extern int pci_device_from_OF_node(struct device_node *node,
 #endif
 #ifndef CONFIG_PPC64
 
+#ifdef CONFIG_PPC_CHRP
 extern void pci_create_OF_bus_map(void);
+#endif
 
 #else	/* CONFIG_PPC64 */
 
diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index df981294df29..3291af89cea4 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -194,6 +194,7 @@ int pci_device_from_OF_node(struct device_node *node, u8 *bus, u8 *devfn)
 EXPORT_SYMBOL(pci_device_from_OF_node);
 #endif
 
+#ifdef CONFIG_PPC_CHRP
 /* We create the "pci-OF-bus-map" property now so it appears in the
  * /proc device tree
  */
@@ -218,6 +219,7 @@ pci_create_OF_bus_map(void)
 		of_node_put(dn);
 	}
 }
+#endif
 
 void pcibios_setup_phb_io_space(struct pci_controller *hose)
 {
-- 
2.20.1

