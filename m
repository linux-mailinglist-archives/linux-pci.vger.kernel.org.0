Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0C9B27F4AF
	for <lists+linux-pci@lfdr.de>; Wed, 30 Sep 2020 23:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731523AbgI3V7C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 17:59:02 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:41823 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731437AbgI3V6p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Sep 2020 17:58:45 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 111F5F96;
        Wed, 30 Sep 2020 17:58:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 30 Sep 2020 17:58:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        oregontracks.org; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=X3bR5tiDpkOMpVFs96Yj2G3znNEwbv7TvDxEB3BfxjA=; b=NLR1j
        JN5aRtc+8s8d+Lt4miX0YSzlJY1cp9ZUP+EQVx7fWmvzsjsGOYYL2UpUSrHYGtpr
        bPm37DZQj3yY7izpeD4MwidWXvg9SHyDZ4EIjlQ2fTMkYoPQnyQZwhoBSDfLZ6R2
        yIlfECLKBMix9jv2e3fqo3YbLSomcpIB0O2gNg7RqGdlKTNu31cyr1CVfYMbfqab
        j08+E7uKbNTu7ahgEFlDu++61LZAPof9KAw4zk+QtZEaKqiDSLWno13Tc9ZaKYSk
        O9IloPSIxglIwzYpiZj/e/8WDc1FZ9Cw+qAl07WlQMOKcqk2WRJrg45O0oVhWCrr
        fuSSb92du4MCGZ54w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=X3bR5tiDpkOMpVFs96Yj2G3znNEwbv7TvDxEB3BfxjA=; b=YjIFo4ZF
        nmMBHBTRnxIRIpzzX8Hi7UpcAor287S77sIYt5/euJFo+dDv+B84VWE03GbKIj3l
        DS0XuCU8479pr4yPTFdPH4CHQ7phRMPHxhIT7Sxyjxwl2GuJXqnjLwJKro8W2khz
        bUqa2yJyDpoxtfErNs34/FGUB3RDbHSfSuA1iAtjORW3ukaK5lxw0mrhrnu9Q4GJ
        f8CSh4OWg4xdOYHr+WbtYVrWHGSTlc88SMT1EprB1iLGFwho3p06/b+uLKe7wr31
        cR3sLOFAMWIMgdgrsIzwbCYApJnKLAAetXeFFcj/1nowRRkChvcOG/O+To5T412F
        TAWELzKBe7Lzig==
X-ME-Sender: <xms:k_90X-A_yL-Yd8vT54EXVo4MGQiWf3UAeM1BzZQInLHob_ATDZoQqw>
    <xme:k_90X4iOHPy_K5Q3ar_h6bgvP8g8H1_mJdwzruuZNrDJ-ekSosjL8jwoqLxAMilEp
    NSmLcbMk8R8xQtq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeefgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefuvggrnhcuggcumfgvlhhlvgihuceoshgvrghnvhhkrdguvghv
    sehorhgvghhonhhtrhgrtghkshdrohhrgheqnecuggftrfgrthhtvghrnhepheekffetie
    duieffleekleevffdtlefhiedtieegffelueefvdfggedvfeevtdetnecukfhppedvgedr
    vddtrddugeekrdegleenucevlhhushhtvghrufhiiigvpeeinecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehsvggrnhhvkhdruggvvhesohhrvghgohhnthhrrggtkhhsrdhorhhg
X-ME-Proxy: <xmx:k_90Xxk490x19o40kDySi7mDfnjFFvV-UCOPQzKlJPx2KRm4emKlbA>
    <xmx:k_90X8zEmIs5rIAwF8iYJU057WA11qUQNjvyIb5WfuvMHFlkmKuvbg>
    <xmx:k_90XzTXLkGxyqtJX3wDjLlZbPZdJiJPrVTwjA8DRUYdLVZaNIo9Gg>
    <xmx:k_90X8TKZsQO5PeCzXfQeOjG4iNg2BCWEQHW3sMWk6Gfmo7QUEBmFQ>
Received: from arch-ashland-svkelley.hsd1.or.comcast.net (c-24-20-148-49.hsd1.or.comcast.net [24.20.148.49])
        by mail.messagingengine.com (Postfix) with ESMTPA id 38ED93280060;
        Wed, 30 Sep 2020 17:58:42 -0400 (EDT)
From:   Sean V Kelley <seanvk.dev@oregontracks.org>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v7 09/13] PCI/RCEC: Add pcie_link_rcec() to associate RCiEPs
Date:   Wed, 30 Sep 2020 14:58:16 -0700
Message-Id: <20200930215820.1113353-10-seanvk.dev@oregontracks.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930215820.1113353-1-seanvk.dev@oregontracks.org>
References: <20200930215820.1113353-1-seanvk.dev@oregontracks.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sean V Kelley <sean.v.kelley@intel.com>

A Root Complex Event Collector provides support for
terminating error and PME messages from associated RCiEPs.

Make use of the RCEC Endpoint Association Extended Capability
to identify associated RCiEPs. Link the associated RCiEPs as
the RCECs are enumerated.

Co-developed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/pci/pci.h              |  2 +
 drivers/pci/pcie/portdrv_pci.c |  3 ++
 drivers/pci/pcie/rcec.c        | 91 ++++++++++++++++++++++++++++++++++
 include/linux/pci.h            |  1 +
 4 files changed, 97 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index efea170805fa..ef60a78a1861 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -473,9 +473,11 @@ static inline void pci_dpc_init(struct pci_dev *pdev) {}
 #ifdef CONFIG_PCIEPORTBUS
 int pci_rcec_init(struct pci_dev *dev);
 void pci_rcec_exit(struct pci_dev *dev);
+void pcie_link_rcec(struct pci_dev *rcec);
 #else
 static inline int pci_rcec_init(struct pci_dev *dev) {return 0;}
 static inline void pci_rcec_exit(struct pci_dev *dev) {}
+static inline void pcie_link_rcec(struct pci_dev *rcec) {}
 #endif
 
 #ifdef CONFIG_PCI_ATS
diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 4d880679b9b1..dbeb0155c2c3 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -110,6 +110,9 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
 	     (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_EC)))
 		return -ENODEV;
 
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)
+		pcie_link_rcec(dev);
+
 	status = pcie_port_device_register(dev);
 	if (status)
 		return status;
diff --git a/drivers/pci/pcie/rcec.c b/drivers/pci/pcie/rcec.c
index da02b0af442d..9ba74d8064e9 100644
--- a/drivers/pci/pcie/rcec.c
+++ b/drivers/pci/pcie/rcec.c
@@ -15,6 +15,97 @@
 
 #include "../pci.h"
 
+struct walk_rcec_data {
+	struct pci_dev *rcec;
+	int (*user_callback)(struct pci_dev *dev, void *data);
+	void *user_data;
+};
+
+static bool rcec_assoc_rciep(struct pci_dev *rcec, struct pci_dev *rciep)
+{
+	unsigned long bitmap = rcec->rcec_ea->bitmap;
+	unsigned int devn;
+
+	/* An RCiEP found on a different bus in range */
+	if (rcec->bus->number != rciep->bus->number)
+		return true;
+
+	/* Same bus, so check bitmap */
+	for_each_set_bit(devn, &bitmap, 32)
+		if (devn == rciep->devfn)
+			return true;
+
+	return false;
+}
+
+static int link_rcec_helper(struct pci_dev *dev, void *data)
+{
+	struct walk_rcec_data *rcec_data = data;
+	struct pci_dev *rcec = rcec_data->rcec;
+
+	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END) && rcec_assoc_rciep(rcec, dev)) {
+		dev->rcec = rcec;
+		pci_dbg(dev, "PME & error events reported via %s\n", pci_name(rcec));
+	}
+
+	return 0;
+}
+
+static void walk_rcec(int (*cb)(struct pci_dev *dev, void *data), void *userdata)
+{
+	struct walk_rcec_data *rcec_data = userdata;
+	struct pci_dev *rcec = rcec_data->rcec;
+	u8 nextbusn, lastbusn;
+	struct pci_bus *bus;
+	unsigned int bnr;
+
+	if (!rcec->rcec_ea)
+		return;
+
+	/* Walk own bus for bitmap based association */
+	pci_walk_bus(rcec->bus, cb, rcec_data);
+
+	nextbusn = rcec->rcec_ea->nextbusn;
+	lastbusn = rcec->rcec_ea->lastbusn;
+
+	/* All RCiEP devices are on the same bus as the RCEC */
+	if (nextbusn == 0xff && lastbusn == 0x00)
+		return;
+
+	for (bnr = nextbusn; bnr <= lastbusn; bnr++) {
+		/* No association indicated (PCIe 5.0-1, 7.9.10.3) */
+		if (bnr == rcec->bus->number)
+			continue;
+
+		bus = pci_find_bus(pci_domain_nr(rcec->bus), bnr);
+		if (!bus)
+			continue;
+
+		/* Find RCiEP devices on the given bus ranges */
+		pci_walk_bus(bus, cb, rcec_data);
+	}
+}
+
+/**
+ * pcie_link_rcec - Link RCiEP devices associating with RCEC.
+ * @rcec     RCEC whose RCiEP devices should be linked.
+ *
+ * Link the given RCEC to each RCiEP device found.
+ */
+void pcie_link_rcec(struct pci_dev *rcec)
+{
+	struct walk_rcec_data rcec_data;
+
+	if (!rcec->rcec_ea)
+		return;
+
+	rcec_data.rcec = rcec;
+	rcec_data.user_callback = NULL;
+	rcec_data.user_data = NULL;
+
+	walk_rcec(link_rcec_helper, &rcec_data);
+}
+
 int pci_rcec_init(struct pci_dev *dev)
 {
 	struct rcec_ea *rcec_ea;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2290439e8bc0..e546b16b13c1 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -330,6 +330,7 @@ struct pci_dev {
 #endif
 #ifdef CONFIG_PCIEPORTBUS
 	struct rcec_ea	*rcec_ea;	/* RCEC cached endpoint association */
+	struct pci_dev  *rcec;          /* Associated RCEC device */
 #endif
 	u8		pcie_cap;	/* PCIe capability offset */
 	u8		msi_cap;	/* MSI capability offset */
-- 
2.28.0

