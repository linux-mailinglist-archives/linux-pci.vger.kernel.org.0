Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59C75281B3B
	for <lists+linux-pci@lfdr.de>; Fri,  2 Oct 2020 20:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387935AbgJBS4i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Oct 2020 14:56:38 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:55031 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387688AbgJBS4h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Oct 2020 14:56:37 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 58BBC5C0158;
        Fri,  2 Oct 2020 14:48:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 02 Oct 2020 14:48:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        oregontracks.org; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=t0uKDJq27vNzBDRDYM5SRRTTNMGSpWZb8xaUcJWhNTE=; b=cnTiJ
        BVT1d4QW9PJljrBNDph95tvHP3LKwR/DiOMqa2LxcHi1FzUPZPr53+u+7In4cwD9
        Bgx4/zZUi4P07JM5HlhZCR6eaCPn1AODGhSlpptW+sEFl89I9hchxlNPFK69zZr3
        JZcqIbj3meHYGy0Pkf98O4TFwSJHT2XYNkPuKwvo7LsDy47QMnUUrwWuZF9ttk8G
        va/i7eWv+SoGYLP4m13rWkXqEyheueKgouu/HlEdxIf2AA9yVlwiD43oTTn1Q4aq
        ovd4DPzP/eebWuwKVTEbdwNZ40iA7iOxi8yNvbtDsLb+JAPQB5WGMQ5QQ10LUeSy
        yEcZ6IoPIhsTrZLmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=t0uKDJq27vNzBDRDYM5SRRTTNMGSpWZb8xaUcJWhNTE=; b=gpX9yEma
        Yf5dL33U0PeouLffE60/vhSGG2fowJWug8sD4TkE5zprE/hDH/6BtbY1JlOSX9Y2
        ASbtlGixXRKw7mkTe2kKKRU5l0soOuQXaCnj48S6Wy338BO32ORRosHS5Dia0dNY
        B4ER6uFCY2KyTEl8B0t0crzue+A9NzMyHBBXXNX33bpbll87OxAbtapnEa6vLqBf
        diu3s4jq4H5z5U31/ubwbLixCSHVa7ZwdUEIqb170UyJy/GwikZq16e+rTeqsArp
        KPtB0lP/mQuLIzvQUWCPKpa3fV7kE0UpH5al4Sad4ZJ/ZugXdxysnubjzefp1rKb
        ylwtJvhSwn6t6A==
X-ME-Sender: <xms:7HV3X0t_WYrAybfvLU95GzUnn9Mr5Ed9Oo7Xy2tq3b-c8F6olxlhWw>
    <xme:7HV3XxexkvvrZtqdAPUTuJXU0Mh95qUL57O16ux40lSE4xi-GUlZvBhUzlxUqKv0J
    oDeDBXoOc5P1z4D>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeeigdduvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepufgvrghnucggucfmvghllhgvhicuoehsvggrnhhvkhdruggv
    vhesohhrvghgohhnthhrrggtkhhsrdhorhhgqeenucggtffrrghtthgvrhhnpeehkeffte
    eiudeiffelkeelvefftdelhfeitdeigeffleeufedvgfegvdefvedtteenucfkphepvdeg
    rddvtddrudegkedrgeelnecuvehluhhsthgvrhfuihiivgepkeenucfrrghrrghmpehmrg
    hilhhfrhhomhepshgvrghnvhhkrdguvghvsehorhgvghhonhhtrhgrtghkshdrohhrgh
X-ME-Proxy: <xmx:7HV3X_xoJBMm6NC94fYLuuWeGSqdBKfSy-8YxHgPfYKUtKhhUUn55Q>
    <xmx:7HV3X3OHBnK0cYIfOrwS1O8I1sNajzy91DKZH-3CfHYyiptgqXaB0g>
    <xmx:7HV3X0_CwD5s7MnLuul8--Chc7Zxiur69qOHfYPBHzmoZJC2FrFn_A>
    <xmx:7HV3XxOvdtah3x6fFlDkoOMcD4x7x5hqAFoGn5j8vEr8IpK20iTzQw>
Received: from arch-ashland-svkelley.hsd1.or.comcast.net (c-24-20-148-49.hsd1.or.comcast.net [24.20.148.49])
        by mail.messagingengine.com (Postfix) with ESMTPA id CA89F3064688;
        Fri,  2 Oct 2020 14:48:10 -0400 (EDT)
From:   Sean V Kelley <seanvk.dev@oregontracks.org>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v8 10/14] PCI/RCEC: Add pcie_link_rcec() to associate RCiEPs
Date:   Fri,  2 Oct 2020 11:47:31 -0700
Message-Id: <20201002184735.1229220-11-seanvk.dev@oregontracks.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201002184735.1229220-1-seanvk.dev@oregontracks.org>
References: <20201002184735.1229220-1-seanvk.dev@oregontracks.org>
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
index 98ec87ef780d..ea5716d48b68 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -473,9 +473,11 @@ static inline void pci_dpc_init(struct pci_dev *pdev) {}
 #ifdef CONFIG_PCIEPORTBUS
 int pci_rcec_init(struct pci_dev *dev);
 void pci_rcec_exit(struct pci_dev *dev);
+void pcie_link_rcec(struct pci_dev *rcec);
 #else
 static inline int pci_rcec_init(struct pci_dev *dev) { return 0; }
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

