Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD02328FBF4
	for <lists+linux-pci@lfdr.de>; Fri, 16 Oct 2020 02:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389908AbgJPAMw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Oct 2020 20:12:52 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:51749 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733128AbgJPAMd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Oct 2020 20:12:33 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 48398AEE;
        Thu, 15 Oct 2020 20:12:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 15 Oct 2020 20:12:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        oregontracks.org; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=Wh+eaVuh8oUnO6ln2oiVPAb2Qp/c88cize7vO45F/JM=; b=T+uo1
        QV+5VHA5AokHHM52+hWtIRsaQDjKcnPu/RMvMR6qXZwRjY5ExGIEt5JqZ06Q7J4Z
        bOjDATqEoFt62RoWLUU5YbcwCIYrMkASjULeAPf9LAELH9I/1Zz+Q6C20Wg/zf9Z
        2M0a2folrMO1nPBspLxuz9s0e55BsxQIUFKzO4psZRqr/gynmdPeyyRK/tpHOSsp
        fUa1qhwxctPdWVynBYGa2uvGxxt5/huH36htA2auuiiTelwDKmF+4aHVqEpEUj98
        5Nf8YuFny5klCMfQTTmCIZHq3Holbxg3u5jyaPYp4Cs7b+KBAHOQg0p6yp74oL2g
        NANuFel3QUnFoIHvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=Wh+eaVuh8oUnO6ln2oiVPAb2Qp/c88cize7vO45F/JM=; b=QfBkNKzV
        1XebxRtkrD1YnUH6yx0Pkxusv+yVqV6W/0aHrll8orNAtW4YkSthJd8sQMCPoxpC
        o7vzRSksf8iDclGs4GcLEd/xjctcJ7uLZBZi5419KhQ8UXb1tVBM78Eec2l0U1GL
        Beqq+2WacmCyZvcsH3TOWtW8rU4ENkqbcRu5ktmygb6cV+qraxZ5urB+SMIOs6qS
        5lsWhNl5nTuxVnZspIvTGwrRG25kc4FiCyf9drHeI4/A6fI8QMV2eAEgrqmTNahf
        55odXtkKXmw6w9H4julkyxqgZ7pmzrNNnfdOOWWXNadHXyytgq8673XIuLVQQ7+W
        XUtDWK9FdowbuA==
X-ME-Sender: <xms:b-WIX3YeTh6hZDBeL51-wDQlfk02RGYtBracgPGqExcv-wwmW2259w>
    <xme:b-WIX2YYX8epy2IJhVpLtk4wPzAtK59kggW7NpKCTqHEUPqxQYcEncF6vTQmepsLo
    KjxEyQLFpWIx1jd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrieeggdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefuvggrnhcuggcumfgvlhhlvgihuceoshgvrghnvhhkrdguvghv
    sehorhgvghhonhhtrhgrtghkshdrohhrgheqnecuggftrfgrthhtvghrnhepkefggeektd
    dttdeuffffjeeihfetfffghfdugefhvdeuheeuudelheegleevheefnecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghenucfkphepvdegrddvtddrudegkedrgeelnecuvehluhhsth
    gvrhfuihiivgepieenucfrrghrrghmpehmrghilhhfrhhomhepshgvrghnvhhkrdguvghv
    sehorhgvghhonhhtrhgrtghkshdrohhrgh
X-ME-Proxy: <xmx:b-WIX59f0TwBV2lHoSE5Pd-nXY67vPxZiv2EMx7TzP7FitXYdC1R-A>
    <xmx:b-WIX9r8hU4l8OmeK8rZTihVzpfikEqiNz8Yhqj0k0aXK7QZY-2nxw>
    <xmx:b-WIXypJdDGAyoPwYH3fdQHP2At1MSxWeLoc-GCkjGIH6JHUvxvSHg>
    <xmx:b-WIXyKI950vQAJX4YNjQA9l7xzqBBJoMDPwFcTEEJibmjb-IXA-Sg>
Received: from arch-ashland-svkelley.hsd1.or.comcast.net (c-24-20-148-49.hsd1.or.comcast.net [24.20.148.49])
        by mail.messagingengine.com (Postfix) with ESMTPA id A187B3064680;
        Thu, 15 Oct 2020 20:12:30 -0400 (EDT)
From:   Sean V Kelley <seanvk.dev@oregontracks.org>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v9 11/15] PCI/RCEC: Add pcie_link_rcec() to associate RCiEPs
Date:   Thu, 15 Oct 2020 17:11:09 -0700
Message-Id: <20201016001113.2301761-12-seanvk.dev@oregontracks.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201016001113.2301761-1-seanvk.dev@oregontracks.org>
References: <20201016001113.2301761-1-seanvk.dev@oregontracks.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sean V Kelley <sean.v.kelley@intel.com>

A Root Complex Event Collector terminates error and PME messages from
associated RCiEPs.

Use the RCEC Endpoint Association Extended Capability to identify
associated RCiEPs. Link the associated RCiEPs as the RCECs are enumerated.

Co-developed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Link: https://lore.kernel.org/r/20201002184735.1229220-11-seanvk.dev@oregontracks.org
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/pci/pci.h              |  2 +
 drivers/pci/pcie/portdrv_pci.c |  3 ++
 drivers/pci/pcie/rcec.c        | 94 ++++++++++++++++++++++++++++++++++
 include/linux/pci.h            |  1 +
 4 files changed, 100 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index bc2340971a50..9e43a265c006 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -473,9 +473,11 @@ static inline void pci_dpc_init(struct pci_dev *pdev) {}
 #ifdef CONFIG_PCIEPORTBUS
 void pci_rcec_init(struct pci_dev *dev);
 void pci_rcec_exit(struct pci_dev *dev);
+void pcie_link_rcec(struct pci_dev *rcec);
 #else
 static inline void pci_rcec_init(struct pci_dev *dev) {}
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
index 038e9d706d5f..cdec277cbd62 100644
--- a/drivers/pci/pcie/rcec.c
+++ b/drivers/pci/pcie/rcec.c
@@ -15,6 +15,100 @@
 
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
+	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END) &&
+	    rcec_assoc_rciep(rcec, dev)) {
+		dev->rcec = rcec;
+		pci_dbg(dev, "PME & error events signaled via %s\n",
+			pci_name(rcec));
+	}
+
+	return 0;
+}
+
+static void walk_rcec(int (*cb)(struct pci_dev *dev, void *data),
+		      void *userdata)
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
+ * pcie_link_rcec - Link RCiEP devices associated with RCEC.
+ * @rcec: RCEC whose RCiEP devices should be linked.
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
 void pci_rcec_init(struct pci_dev *dev)
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

