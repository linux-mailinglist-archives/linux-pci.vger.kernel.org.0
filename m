Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688F55642C4
	for <lists+linux-pci@lfdr.de>; Sat,  2 Jul 2022 22:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiGBUsA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 2 Jul 2022 16:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGBUr5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 2 Jul 2022 16:47:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5B7D102;
        Sat,  2 Jul 2022 13:47:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E55360C23;
        Sat,  2 Jul 2022 20:47:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A01B1C34114;
        Sat,  2 Jul 2022 20:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656794876;
        bh=DYzJ1goiNkBYGegk5UjQGf+afUBnQNpUSQSvWj//SSw=;
        h=From:To:Cc:Subject:Date:From;
        b=gZxsFi6w2zEz9+OMqY868hgJ0bC/A6vA+B8ngJOBxFTaJwAWmbWChllfn8A1EW7v5
         20Q1ta7aDYN4MJ60A+JUQZJBDfgs1zzsK/KK+aM07d7OaEe0lrPbbLhWTjRSzDXax9
         fndL5EzfCeMVDNkjoE8vO+JQQcdrQyG4QhCajEkQ0lxvVgx8TjIIvOzarFZyAKbLfF
         eU4yn0O0fa18Vqf4Bny1fjQAD9DuB4LEo9AcMjxHWKtKpCvqsrv6a0NCDGm1rvcXB2
         5gxv/l7gQHx8LV8rWfFlpkObgIlINZd6NFQIm0EdCyB0TWptPRV36QtL9BdtYRf8op
         kzIwpHAnxcjNw==
Received: by pali.im (Postfix)
        id 66E858B8; Sat,  2 Jul 2022 22:47:52 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rob Herring" <robh+dt@kernel.org>, "Andrew Lunn" <andrew@lunn.ch>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: Assign PCI domain by ida_alloc()
Date:   Sat,  2 Jul 2022 22:47:37 +0200
Message-Id: <20220702204737.7719-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Replace assignment of PCI domain from atomic_inc_return() to ida_alloc().

Use two IDAs, one for static domain allocations (those which are defined in
device tree) and second for dynamic allocations (all other).

During removal of root bus / host bridge release also allocated domain id.
So released id can be reused again, for example in situation when
dynamically loading and unloading native PCI host bridge drivers.

This change also allows to mix static device tree assignment and dynamic by
kernel as all static allocations are reserved in dynamic pool.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
Idea of this patch comes from the following discussion:
https://lore.kernel.org/linux-pci/20210412123936.25555-1-pali@kernel.org/t/#u
---
 drivers/pci/pci.c    | 102 +++++++++++++++++++++++++------------------
 drivers/pci/probe.c  |   5 +++
 drivers/pci/remove.c |   6 +++
 include/linux/pci.h  |   1 +
 4 files changed, 72 insertions(+), 42 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index cfaf40a540a8..b263abfbe6d5 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6762,60 +6762,71 @@ static void pci_no_domains(void)
 }
 
 #ifdef CONFIG_PCI_DOMAINS_GENERIC
-static atomic_t __domain_nr = ATOMIC_INIT(-1);
+static DEFINE_IDA(pci_domain_nr_static_ida);
+static DEFINE_IDA(pci_domain_nr_dynamic_ida);
 
-static int pci_get_new_domain_nr(void)
+static void of_pci_reserve_static_domain_nr(void)
 {
-	return atomic_inc_return(&__domain_nr);
+	struct device_node *np;
+	int domain_nr;
+
+	for_each_node_by_type(np, "pci") {
+		domain_nr = of_get_pci_domain_nr(np);
+		if (domain_nr < 0)
+			continue;
+		/*
+		 * Permanently allocate domain_nr in dynamic_ida
+		 * to prevent it from dynamic allocation.
+		 */
+		ida_alloc_range(&pci_domain_nr_dynamic_ida,
+				domain_nr, domain_nr, GFP_KERNEL);
+	}
 }
 
 static int of_pci_bus_find_domain_nr(struct device *parent)
 {
-	static int use_dt_domains = -1;
-	int domain = -1;
+	static bool static_domains_reserved = false;
+	int domain_nr;
 
-	if (parent)
-		domain = of_get_pci_domain_nr(parent->of_node);
+	/* On the first call scan device tree for static allocations. */
+	if (!static_domains_reserved) {
+		of_pci_reserve_static_domain_nr();
+		static_domains_reserved = true;
+	}
+
+	if (parent) {
+		/*
+		 * If domain is in DT then allocate it in static IDA.
+		 * This prevent duplicate static allocations in case
+		 * of errors in DT.
+		 */
+		domain_nr = of_get_pci_domain_nr(parent->of_node);
+		if (domain_nr >= 0)
+			return ida_alloc_range(&pci_domain_nr_static_ida,
+					       domain_nr, domain_nr,
+					       GFP_KERNEL);
+	}
 
 	/*
-	 * Check DT domain and use_dt_domains values.
-	 *
-	 * If DT domain property is valid (domain >= 0) and
-	 * use_dt_domains != 0, the DT assignment is valid since this means
-	 * we have not previously allocated a domain number by using
-	 * pci_get_new_domain_nr(); we should also update use_dt_domains to
-	 * 1, to indicate that we have just assigned a domain number from
-	 * DT.
-	 *
-	 * If DT domain property value is not valid (ie domain < 0), and we
-	 * have not previously assigned a domain number from DT
-	 * (use_dt_domains != 1) we should assign a domain number by
-	 * using the:
-	 *
-	 * pci_get_new_domain_nr()
-	 *
-	 * API and update the use_dt_domains value to keep track of method we
-	 * are using to assign domain numbers (use_dt_domains = 0).
-	 *
-	 * All other combinations imply we have a platform that is trying
-	 * to mix domain numbers obtained from DT and pci_get_new_domain_nr(),
-	 * which is a recipe for domain mishandling and it is prevented by
-	 * invalidating the domain value (domain = -1) and printing a
-	 * corresponding error.
+	 * If domain was not specified in DT then choose free id from dynamic
+	 * allocations. All domain numbers from DT are permanently in dynamic
+	 * allocations to prevent assigning them to other DT nodes without
+	 * static domain.
 	 */
-	if (domain >= 0 && use_dt_domains) {
-		use_dt_domains = 1;
-	} else if (domain < 0 && use_dt_domains != 1) {
-		use_dt_domains = 0;
-		domain = pci_get_new_domain_nr();
-	} else {
-		if (parent)
-			pr_err("Node %pOF has ", parent->of_node);
-		pr_err("Inconsistent \"linux,pci-domain\" property in DT\n");
-		domain = -1;
+	return ida_alloc(&pci_domain_nr_dynamic_ida, GFP_KERNEL);
 	}
+}
 
-	return domain;
+static void of_pci_bus_release_domain_nr(struct pci_bus *bus, struct device *parent)
+{
+	if (bus->domain_nr < 0)
+		return;
+
+	/* Release domain from ida in which was it allocated. */
+	if (of_get_pci_domain_nr(parent->of_node) == bus->domain_nr)
+		ida_free(&pci_domain_nr_static_ida, bus->domain_nr);
+	else
+		ida_free(&pci_domain_nr_dynamic_ida, bus->domain_nr);
 }
 
 int pci_bus_find_domain_nr(struct pci_bus *bus, struct device *parent)
@@ -6823,6 +6834,13 @@ int pci_bus_find_domain_nr(struct pci_bus *bus, struct device *parent)
 	return acpi_disabled ? of_pci_bus_find_domain_nr(parent) :
 			       acpi_pci_bus_find_domain_nr(bus);
 }
+
+void pci_bus_release_domain_nr(struct pci_bus *bus, struct device *parent)
+{
+	if (!acpi_disabled)
+		return;
+	of_pci_bus_release_domain_nr(bus, parent);
+}
 #endif
 
 /**
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 17a969942d37..12092d238403 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -906,6 +906,8 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 		bus->domain_nr = pci_bus_find_domain_nr(bus, parent);
 	else
 		bus->domain_nr = bridge->domain_nr;
+	if (bus->domain_nr < 0)
+		goto free;
 #endif
 
 	b = pci_find_bus(pci_domain_nr(bus), bridge->busnr);
@@ -1030,6 +1032,9 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	device_del(&bridge->dev);
 
 free:
+#ifdef CONFIG_PCI_DOMAINS_GENERIC
+	pci_bus_release_domain_nr(bus, parent);
+#endif
 	kfree(bus);
 	return err;
 }
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 4c54c75050dc..0145aef1b930 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -160,6 +160,12 @@ void pci_remove_root_bus(struct pci_bus *bus)
 	pci_remove_bus(bus);
 	host_bridge->bus = NULL;
 
+#ifdef CONFIG_PCI_DOMAINS_GENERIC
+	/* Release domain_nr if it was dynamically allocated */
+	if (host_bridge->domain_nr == PCI_DOMAIN_NR_NOT_SET)
+		pci_bus_release_domain_nr(bus, host_bridge->dev.parent);
+#endif
+
 	/* remove the host bridge */
 	device_del(&host_bridge->dev);
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 81a57b498f22..6c7f27e62bcc 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1723,6 +1723,7 @@ static inline int acpi_pci_bus_find_domain_nr(struct pci_bus *bus)
 { return 0; }
 #endif
 int pci_bus_find_domain_nr(struct pci_bus *bus, struct device *parent);
+void pci_bus_release_domain_nr(struct pci_bus *bus, struct device *parent);
 #endif
 
 /* Some architectures require additional setup to direct VGA traffic */
-- 
2.20.1

