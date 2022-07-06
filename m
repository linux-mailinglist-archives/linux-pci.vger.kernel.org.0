Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0FFA568567
	for <lists+linux-pci@lfdr.de>; Wed,  6 Jul 2022 12:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbiGFKWq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Jul 2022 06:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233150AbiGFKWW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Jul 2022 06:22:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7732925C70;
        Wed,  6 Jul 2022 03:22:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C07661DFC;
        Wed,  6 Jul 2022 10:22:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B26C341C0;
        Wed,  6 Jul 2022 10:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657102940;
        bh=5RJNNFRIVghvmdUSW6GuwgiuwsPcvqMprUl9pG2CXAs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TIRgolfAO2xEEw7akxf7//984YrubOnA0R8bW1OE6XDQJxiyw+77sZBa1fj+WlZv/
         d/URcRVv6rQHA/wtyn33AP0T/phtAXwwyN7ngWhcLsFwIEGav9gYP8NfrevZb7BoBL
         UWgm3BUAAFRH4nTqmYvQN8DuJZiq0Vc+L1t4fgQT/ygCtrvDZT7+zYgocVUtPRcA/v
         JgDC1x558eTV5Nxj+9PGYjGyAGRiZYI/2K3QP9PJ3g3uDJh7sdJwKatBBqd+tItnaG
         p0vJmPNOcCj2d0DU2FijgNMNRafXxWCVTQyoNfiP8Kd9+MHrdm8e4zJNXUbY4mG5a8
         oxIF+7fqD69zg==
Received: by pali.im (Postfix)
        id C570A7F1; Wed,  6 Jul 2022 12:22:17 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Guowen Shan <gshan@redhat.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] powerpc/pci: Prefer PCI domain assignment via DT 'linux,pci-domain' and alias
Date:   Wed,  6 Jul 2022 12:21:48 +0200
Message-Id: <20220706102148.5060-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220706102148.5060-1-pali@kernel.org>
References: <20220706102148.5060-1-pali@kernel.org>
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

Other Linux architectures use DT property 'linux,pci-domain' for specifying
fixed PCI domain of PCI controller specified in Device-Tree.

And lot of Freescale powerpc boards have defined numbered pci alias in
Device-Tree for every PCIe controller which number specify preferred PCI
domain.

So prefer usage of DT property 'linux,pci-domain' (via function
of_get_pci_domain_nr()) and DT pci alias (via function of_alias_get_id())
on powerpc architecture for assigning PCI domain to PCI controller.

Fixes: 63a72284b159 ("powerpc/pci: Assign fixed PHB number based on device-tree properties")
Signed-off-by: Pali Rohár <pali@kernel.org>
---
Changes in v2:
* New patch
---
 arch/powerpc/kernel/pci-common.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 7f959df34833..0715d74855b3 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -78,10 +78,25 @@ static int get_phb_number(struct device_node *dn)
 
 	/*
 	 * Try fixed PHB numbering first, by checking archs and reading
-	 * the respective device-tree properties. Firstly, try powernv by
-	 * reading "ibm,opal-phbid", only present in OPAL environment.
+	 * the respective device-tree properties. Firstly, try reading
+	 * standard "linux,pci-domain", then try reading "ibm,opal-phbid"
+	 * (only present in powernv OPAL environment), then try device-tree
+	 * alias and as the last try to use lower bits of "reg" property
+	 * (only if CONFIG_PPC_PCI_DOMAIN_FROM_OF_REG is enabled).
 	 */
-	ret = of_property_read_u64(dn, "ibm,opal-phbid", &prop);
+	ret = of_get_pci_domain_nr(dn);
+	if (ret >= 0) {
+		prop = ret;
+		ret = 0;
+	}
+	if (ret)
+		ret = of_property_read_u64(dn, "ibm,opal-phbid", &prop);
+	if (ret)
+		ret = of_alias_get_id(dn, "pci");
+	if (ret >= 0) {
+		prop = ret;
+		ret = 0;
+	}
 	if (ret && IS_ENABLED(CONFIG_PPC_PCI_DOMAIN_FROM_OF_REG)) {
 		u32 prop_32;
 		ret = of_property_read_u32_index(dn, "reg", 1, &prop_32);
@@ -95,10 +110,7 @@ static int get_phb_number(struct device_node *dn)
 	if ((phb_id >= 0) && !test_and_set_bit(phb_id, phb_bitmap))
 		return phb_id;
 
-	/*
-	 * If not pseries nor powernv, or if fixed PHB numbering tried to add
-	 * the same PHB number twice, then fallback to dynamic PHB numbering.
-	 */
+	/* If everything fails then fallback to dynamic PHB numbering. */
 	phb_id = find_first_zero_bit(phb_bitmap, MAX_PHBS);
 	BUG_ON(phb_id >= MAX_PHBS);
 	set_bit(phb_id, phb_bitmap);
-- 
2.20.1

