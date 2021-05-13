Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F13F737F98B
	for <lists+linux-pci@lfdr.de>; Thu, 13 May 2021 16:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234415AbhEMOT6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 May 2021 10:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234334AbhEMOTp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 May 2021 10:19:45 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A12C06175F
        for <linux-pci@vger.kernel.org>; Thu, 13 May 2021 07:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jt1sez6gv8kg6+baNglAhmD6c6XH+eUZPh3hfftngT0=; b=Wlo37D/AoLAJR8/p/2CNAiTFAI
        NIuB3iDejAZkP4w3BqP08cgrNnqxYuyC/85V9ilyGqdRlggKkqDvrRpoqQKp7YyOtMHjtOGgtw5I4
        TtD0cTqGkSqdhdiJ+f0TcSNGO0E4DivMR27Y2dBBJ5dfeE6qh8PvH5+BcdDlocCUDZiuIDDqZoTvj
        n+ZyipFli3Mjuk5tyAql8LQA+uhrCDORRDKVh3zjeKgNeTOLMI5l2vFQ9wy8R99iOOTLUPuBEZUt6
        dnzMR3IW3TcpEC17JJzFSb6UWKD2Z2855rTzzlLPGA4f9w2iLdgtDGoMt/0jFBk62r39/9wQoirva
        NYMrXRWA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:56674 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1lhCAV-0006In-ET; Thu, 13 May 2021 15:18:27 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1lhCAV-0002yb-50; Thu, 13 May 2021 15:18:27 +0100
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: [PATCH] PCI: dynamically map ECAM regions
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1lhCAV-0002yb-50@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date:   Thu, 13 May 2021 15:18:27 +0100
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Attempting to boot 32-bit ARM kernels under QEMU's 3.x virt models
fails when we have more than 512M of RAM in the model as we run out
of vmalloc space for the PCI ECAM regions. This failure will be
silent when running libvirt, as the console in that situation is a
PCI device.

In this configuration, the kernel maps the whole ECAM, which QEMU
sets up for 256 buses, even when maybe only seven buses are in use.
Each bus uses 1M of ECAM space, and ioremap() adds an additional
guard page between allocations. The kernel vmap allocator will
align these regions to 512K, resulting in each mapping eating 1.5M
of vmalloc space. This means we need 384M of vmalloc space just to
map all of these, which is very wasteful of resources.

Fix this by only mapping the ECAM for buses we are going to be using.
In my setups, this is around seven buses in most guests, which is
10.5M of vmalloc space - way smaller than the 384M that would
otherwise be required. This also means that the kernel can boot
without forcing extra RAM into highmem with the vmalloc= argument,
or decreasing the virtual RAM available to the guest.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/pci/ecam.c       | 54 ++++++++++++++++++++++++++++++++++------
 include/linux/pci-ecam.h |  1 +
 2 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/ecam.c b/drivers/pci/ecam.c
index d2a1920bb055..1c40d2506aef 100644
--- a/drivers/pci/ecam.c
+++ b/drivers/pci/ecam.c
@@ -32,7 +32,7 @@ struct pci_config_window *pci_ecam_create(struct device *dev,
 	struct pci_config_window *cfg;
 	unsigned int bus_range, bus_range_max, bsz;
 	struct resource *conflict;
-	int i, err;
+	int err;
 
 	if (busr->start > busr->end)
 		return ERR_PTR(-EINVAL);
@@ -50,6 +50,7 @@ struct pci_config_window *pci_ecam_create(struct device *dev,
 	cfg->busr.start = busr->start;
 	cfg->busr.end = busr->end;
 	cfg->busr.flags = IORESOURCE_BUS;
+	cfg->bus_shift = bus_shift;
 	bus_range = resource_size(&cfg->busr);
 	bus_range_max = resource_size(cfgres) >> bus_shift;
 	if (bus_range > bus_range_max) {
@@ -77,13 +78,6 @@ struct pci_config_window *pci_ecam_create(struct device *dev,
 		cfg->winp = kcalloc(bus_range, sizeof(*cfg->winp), GFP_KERNEL);
 		if (!cfg->winp)
 			goto err_exit_malloc;
-		for (i = 0; i < bus_range; i++) {
-			cfg->winp[i] =
-				pci_remap_cfgspace(cfgres->start + i * bsz,
-						   bsz);
-			if (!cfg->winp[i])
-				goto err_exit_iomap;
-		}
 	} else {
 		cfg->win = pci_remap_cfgspace(cfgres->start, bus_range * bsz);
 		if (!cfg->win)
@@ -129,6 +123,44 @@ void pci_ecam_free(struct pci_config_window *cfg)
 }
 EXPORT_SYMBOL_GPL(pci_ecam_free);
 
+static int pci_ecam_add_bus(struct pci_bus *bus)
+{
+	struct pci_config_window *cfg = bus->sysdata;
+	unsigned int bsz = 1 << cfg->bus_shift;
+	unsigned int busn = bus->number;
+	phys_addr_t start;
+
+	if (!per_bus_mapping)
+		return 0;
+
+	if (busn < cfg->busr.start || busn > cfg->busr.end)
+		return -EINVAL;
+
+	busn -= cfg->busr.start;
+	start = cfg->res.start + busn * bsz;
+
+	cfg->winp[busn] = pci_remap_cfgspace(start, bsz);
+	if (!cfg->winp[busn])
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void pci_ecam_remove_bus(struct pci_bus *bus)
+{
+	struct pci_config_window *cfg = bus->sysdata;
+	unsigned int busn = bus->number;
+
+	if (!per_bus_mapping || busn < cfg->busr.start || busn > cfg->busr.end)
+		return;
+
+	busn -= cfg->busr.start;
+	if (cfg->winp[busn]) {
+		iounmap(cfg->winp[busn]);
+		cfg->winp[busn] = NULL;
+	}
+}
+
 /*
  * Function to implement the pci_ops ->map_bus method
  */
@@ -167,6 +199,8 @@ EXPORT_SYMBOL_GPL(pci_ecam_map_bus);
 /* ECAM ops */
 const struct pci_ecam_ops pci_generic_ecam_ops = {
 	.pci_ops	= {
+		.add_bus	= pci_ecam_add_bus,
+		.remove_bus	= pci_ecam_remove_bus,
 		.map_bus	= pci_ecam_map_bus,
 		.read		= pci_generic_config_read,
 		.write		= pci_generic_config_write,
@@ -178,6 +212,8 @@ EXPORT_SYMBOL_GPL(pci_generic_ecam_ops);
 /* ECAM ops for 32-bit access only (non-compliant) */
 const struct pci_ecam_ops pci_32b_ops = {
 	.pci_ops	= {
+		.add_bus	= pci_ecam_add_bus,
+		.remove_bus	= pci_ecam_remove_bus,
 		.map_bus	= pci_ecam_map_bus,
 		.read		= pci_generic_config_read32,
 		.write		= pci_generic_config_write32,
@@ -187,6 +223,8 @@ const struct pci_ecam_ops pci_32b_ops = {
 /* ECAM ops for 32-bit read only (non-compliant) */
 const struct pci_ecam_ops pci_32b_read_ops = {
 	.pci_ops	= {
+		.add_bus	= pci_ecam_add_bus,
+		.remove_bus	= pci_ecam_remove_bus,
 		.map_bus	= pci_ecam_map_bus,
 		.read		= pci_generic_config_read32,
 		.write		= pci_generic_config_write,
diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
index 65d3d83015c3..944da75ff25c 100644
--- a/include/linux/pci-ecam.h
+++ b/include/linux/pci-ecam.h
@@ -55,6 +55,7 @@ struct pci_ecam_ops {
 struct pci_config_window {
 	struct resource			res;
 	struct resource			busr;
+	unsigned int			bus_shift;
 	void				*priv;
 	const struct pci_ecam_ops	*ops;
 	union {
-- 
2.20.1

