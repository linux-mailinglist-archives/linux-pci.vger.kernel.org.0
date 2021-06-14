Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBE813A5C9A
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jun 2021 07:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbhFNFzV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Jun 2021 01:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbhFNFzS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Jun 2021 01:55:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEFAC061574
        for <linux-pci@vger.kernel.org>; Sun, 13 Jun 2021 22:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=cVdFyFTgDRZiQNUPyJqzLGO89WrACZNf0z33V/nm6K0=; b=tiOggwgHRnOSWgvor1h1uXxZdg
        Hf64lb8jqVgnQwg3aseTw+Dp7obeTqSLSHIIzk89DjNkhwX5ZInMdQlguJtptV/Hkc2I5S8SPX6ym
        6hoblRhKz4RMmqcPXVbmhHdAFSSpqOl754xu6so52e036QVDlTgkCfh+PKfBfJ5/3o/hIdepC6YO6
        zDIxckUorCyN+pTdMH8/xxJlyvgtPlfXl4pC8jAkCHLWxyuGFncZHQwCY0/+bprvYqT/IcKs6obiH
        JLFIzRVHh9JevUpiJyxk2YtiHDd7v5FXD2wxNdE7BIImsL1G0XXTns9BfA4KicuhrekPqdW1+GHIm
        GQFL6jtg==;
Received: from [2001:4bb8:19b:fdce:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lsfX7-00CdSs-BJ; Mon, 14 Jun 2021 05:53:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     logang@deltatee.com, helgaas@kernel.org
Cc:     linux-pci@vger.kernel.org
Subject: [PATCH] PCI/P2PDMA: simplify distance calculation
Date:   Mon, 14 Jun 2021 07:53:10 +0200
Message-Id: <20210614055310.3960791-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Merge __calc_map_type_and_dist and calc_map_type_and_dist_warn into
calc_map_type_and_dist to simplify the code a bit.  This now means
we add the devfn strings to the acs_buf unconditionallity even if
the buffer is not printed, but that is not a lot of overhead and
keeps the code much simpler.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/pci/p2pdma.c | 190 +++++++++++++++++--------------------------
 1 file changed, 73 insertions(+), 117 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index deb097ceaf41..ca2574debb2d 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -388,79 +388,6 @@ static bool host_bridge_whitelist(struct pci_dev *a, struct pci_dev *b,
 	return false;
 }
 
-static enum pci_p2pdma_map_type
-__calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
-		int *dist, bool *acs_redirects, struct seq_buf *acs_list)
-{
-	struct pci_dev *a = provider, *b = client, *bb;
-	int dist_a = 0;
-	int dist_b = 0;
-	int acs_cnt = 0;
-
-	if (acs_redirects)
-		*acs_redirects = false;
-
-	/*
-	 * Note, we don't need to take references to devices returned by
-	 * pci_upstream_bridge() seeing we hold a reference to a child
-	 * device which will already hold a reference to the upstream bridge.
-	 */
-
-	while (a) {
-		dist_b = 0;
-
-		if (pci_bridge_has_acs_redir(a)) {
-			seq_buf_print_bus_devfn(acs_list, a);
-			acs_cnt++;
-		}
-
-		bb = b;
-
-		while (bb) {
-			if (a == bb)
-				goto check_b_path_acs;
-
-			bb = pci_upstream_bridge(bb);
-			dist_b++;
-		}
-
-		a = pci_upstream_bridge(a);
-		dist_a++;
-	}
-
-	if (dist)
-		*dist = dist_a + dist_b;
-
-	return PCI_P2PDMA_MAP_THRU_HOST_BRIDGE;
-
-check_b_path_acs:
-	bb = b;
-
-	while (bb) {
-		if (a == bb)
-			break;
-
-		if (pci_bridge_has_acs_redir(bb)) {
-			seq_buf_print_bus_devfn(acs_list, bb);
-			acs_cnt++;
-		}
-
-		bb = pci_upstream_bridge(bb);
-	}
-
-	if (dist)
-		*dist = dist_a + dist_b;
-
-	if (acs_cnt) {
-		if (acs_redirects)
-			*acs_redirects = true;
-
-		return PCI_P2PDMA_MAP_THRU_HOST_BRIDGE;
-	}
-
-	return PCI_P2PDMA_MAP_BUS_ADDR;
-}
-
 static unsigned long map_types_idx(struct pci_dev *client)
 {
 	return (pci_domain_nr(client->bus) << 16) |
@@ -502,63 +429,96 @@ static unsigned long map_types_idx(struct pci_dev *client)
  * PCI_P2PDMA_MAP_THRU_HOST_BRIDGE with the distance set to the number of
  * ports per above. If the device is not in the whitelist, return
  * PCI_P2PDMA_MAP_NOT_SUPPORTED.
- *
- * If any ACS redirect bits are set, then acs_redirects boolean will be set
- * to true and their PCI device names will be appended to the acs_list
- * seq_buf. This seq_buf is used to print a warning informing the user how
- * to disable ACS using a command line parameter.  (See
- * calc_map_type_and_dist_warn() below)
  */
 static enum pci_p2pdma_map_type
 calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
-		int *dist, bool *acs_redirects, struct seq_buf *acs_list)
+		int *dist, bool verbose)
 {
-	enum pci_p2pdma_map_type map_type;
+	enum pci_p2pdma_map_type map_type = PCI_P2PDMA_MAP_THRU_HOST_BRIDGE;
+	struct pci_dev *a = provider, *b = client, *bb;
+	bool acs_redirects = false;
+	struct seq_buf acs_list;
+	int acs_cnt = 0;
+	int dist_a = 0;
+	int dist_b = 0;
+	char buf[128];
+
+	seq_buf_init(&acs_list, buf, sizeof(buf));
+
+	/*
+	 * Note, we don't need to take references to devices returned by
+	 * pci_upstream_bridge() seeing we hold a reference to a child
+	 * device which will already hold a reference to the upstream bridge.
+	 */
+	while (a) {
+		dist_b = 0;
 
-	map_type = __calc_map_type_and_dist(provider, client, dist,
-					    acs_redirects, acs_list);
+		if (pci_bridge_has_acs_redir(a)) {
+			seq_buf_print_bus_devfn(&acs_list, a);
+			acs_cnt++;
+		}
 
-	if (map_type == PCI_P2PDMA_MAP_THRU_HOST_BRIDGE) {
-		if (!cpu_supports_p2pdma() &&
-		    !host_bridge_whitelist(provider, client, acs_redirects))
-			map_type = PCI_P2PDMA_MAP_NOT_SUPPORTED;
+		bb = b;
+
+		while (bb) {
+			if (a == bb)
+				goto check_b_path_acs;
+
+			bb = pci_upstream_bridge(bb);
+			dist_b++;
+		}
+
+		a = pci_upstream_bridge(a);
+		dist_a++;
 	}
 
-	if (provider->p2pdma)
-		xa_store(&provider->p2pdma->map_types, map_types_idx(client),
-			 xa_mk_value(map_type), GFP_KERNEL);
+	*dist = dist_a + dist_b;
+	goto map_through_host_bridge;
 
-	return map_type;
-}
+check_b_path_acs:
+	bb = b;
 
-static enum pci_p2pdma_map_type
-calc_map_type_and_dist_warn(struct pci_dev *provider, struct pci_dev *client,
-			    int *dist)
-{
-	struct seq_buf acs_list;
-	bool acs_redirects;
-	char buf[128];
-	int ret;
+	while (bb) {
+		if (a == bb)
+			break;
 
-	seq_buf_init(&acs_list, buf, sizeof(buf));
+		if (pci_bridge_has_acs_redir(bb)) {
+			seq_buf_print_bus_devfn(&acs_list, bb);
+			acs_cnt++;
+		}
 
-	ret = calc_map_type_and_dist(provider, client, dist, &acs_redirects,
-				     &acs_list);
-	if (acs_redirects) {
+		bb = pci_upstream_bridge(bb);
+	}
+
+	*dist = dist_a + dist_b;
+
+	if (!acs_cnt) {
+		map_type = PCI_P2PDMA_MAP_BUS_ADDR;
+		goto done;
+	}
+
+	if (verbose) {
+		acs_list.buffer[acs_list.len-1] = 0; /* drop final semicolon */
 		pci_warn(client, "ACS redirect is set between the client and provider (%s)\n",
 			 pci_name(provider));
-		/* Drop final semicolon */
-		acs_list.buffer[acs_list.len-1] = 0;
 		pci_warn(client, "to disable ACS redirect for this path, add the kernel parameter: pci=disable_acs_redir=%s\n",
 			 acs_list.buffer);
 	}
+	acs_redirects = true;
 
-	if (ret == PCI_P2PDMA_MAP_NOT_SUPPORTED) {
-		pci_warn(client, "cannot be used for peer-to-peer DMA as the client and provider (%s) do not share an upstream bridge or whitelisted host bridge\n",
-			 pci_name(provider));
+map_through_host_bridge:
+	if (!cpu_supports_p2pdma() &&
+	    !host_bridge_whitelist(provider, client, acs_redirects)) {
+		if (verbose)
+			pci_warn(client, "cannot be used for peer-to-peer DMA as the client and provider (%s) do not share an upstream bridge or whitelisted host bridge\n",
+				 pci_name(provider));
+		map_type = PCI_P2PDMA_MAP_NOT_SUPPORTED;
 	}
-
-	return ret;
+done:
+	if (provider->p2pdma)
+		xa_store(&provider->p2pdma->map_types, map_types_idx(client),
+			 xa_mk_value(map_type), GFP_KERNEL);
+	return map_type;
 }
 
 /**
@@ -599,12 +559,8 @@ int pci_p2pdma_distance_many(struct pci_dev *provider, struct device **clients,
 			return -1;
 		}
 
-		if (verbose)
-			map = calc_map_type_and_dist_warn(provider, pci_client,
-							  &distance);
-		else
-			map = calc_map_type_and_dist(provider, pci_client,
-						     &distance, NULL, NULL);
+		map = calc_map_type_and_dist(provider, pci_client, &distance,
+					     verbose);
 
 		pci_dev_put(pci_client);
 
-- 
2.30.2

