Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6383F274B74
	for <lists+linux-pci@lfdr.de>; Tue, 22 Sep 2020 23:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgIVVq0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Sep 2020 17:46:26 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:55187 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726652AbgIVVpt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Sep 2020 17:45:49 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id B12F55C01A2;
        Tue, 22 Sep 2020 17:39:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 22 Sep 2020 17:39:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        oregontracks.org; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=/3YNI9RwNvXBtWJflfZhbCKvt5Hdet7iPoTLO1M3xxE=; b=gdiZL
        uosXzngiuea/c7jn0CAQQ4WAAxP3HOzbuBaT1DmcaT79PQ6htBmc8nj2FsVVy29O
        Lag5jFxuUXOMzup0niKXvVxzipFhxOE+jEWVKG/5Ckx9SD6mxe3Y+WLftGERpAuV
        lx7o89X5/dLywqXeYJZnZuvOkO3wI3i5PQJqRk+8iB5MK1eMu38g9tfY25scu3KM
        cyof1gDOeO7BLzV3CpKZsMiqBeiNjr1zIQk2Ly3VhLcRLi9VCjHRfEzx1iSbE+mx
        joeLG4VH36ake09brsyILW0LAdUxlC16Xes3jeiJg4Dhl4WCLBdme6VeO1IUPYTr
        kHDKM9LqbDRSCubcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=/3YNI9RwNvXBtWJflfZhbCKvt5Hdet7iPoTLO1M3xxE=; b=rwSDFviH
        lX1SxgnOlN1Ge+LxLAhYLbiT7j5I+uJPiR9bYqSFu3MS/pvjtAVhpxK5wr+7zaE/
        fQefuh4rkp+dHaqv3dRVw2mDeXSRIWE2Y5VCoJjUy48dL6skjaUmHwxXWNXa7vi5
        Q9zMJtnr1opItLxr2A2FB3lW0r0Z85wB9ZnKlaxN04ogbS+OVIF4zgR4KZQu7Eax
        qWbna2pKmfPHqLvhcnxVmcJh+E2RYCCQ6/H+Xrr/n47lot8nEVFQ0KtNPaowB4fm
        yIw6r5zKr7g20NZ5Goiv39KrkZ4IEOZ6uo+geidVdMmeUfch8J7wl3mKtYQeBh31
        NO6pz2FECV/ZeQ==
X-ME-Sender: <xms:BW9qX2KaMYgFBLOTVEBJz-BDFHv1xDJLnsaX7ph-H2XP9aEoDlPCqQ>
    <xme:BW9qX-LjICTkDS9gieoyjDtZLnY8Ev-IfriyRDOd5lJ44rhh5HObAfJJGZBHZ9v6b
    YYyAp66STppMKNa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeggdduieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepufgvrghnucggucfmvghllhgvhicuoehsvggrnhhvkhdruggv
    vhesohhrvghgohhnthhrrggtkhhsrdhorhhgqeenucggtffrrghtthgvrhhnpeehkeffte
    eiudeiffelkeelvefftdelhfeitdeigeffleeufedvgfegvdefvedtteenucfkphepvdeg
    rddvtddrudegkedrgeelnecuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrg
    hilhhfrhhomhepshgvrghnvhhkrdguvghvsehorhgvghhonhhtrhgrtghkshdrohhrgh
X-ME-Proxy: <xmx:BW9qX2trdvblCk4IqSNjc-a8pFVKJaYJaUvR9cgAXX36uD9cBeivcw>
    <xmx:BW9qX7ZKdWoNtdqTz88PhR3zUL765xzAIf_f6BI_lCdpn0SAL8993w>
    <xmx:BW9qX9YXHKUoqzdGmRdnrwzfPfnIszTQ3NmbiCNMtpyqq6ZW2II1kQ>
    <xmx:BW9qX54q82KVW_7YjGdEmzRm0HQpOyEtlbq443MRyhAJKgSZEWOsjA>
Received: from arch-ashland-svkelley.hsd1.or.comcast.net (c-24-20-148-49.hsd1.or.comcast.net [24.20.148.49])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8144D306467E;
        Tue, 22 Sep 2020 17:39:15 -0400 (EDT)
From:   Sean V Kelley <seanvk.dev@oregontracks.org>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v6 06/10] PCI/RCEC: Add pcie_link_rcec() to associate RCiEPs
Date:   Tue, 22 Sep 2020 14:38:55 -0700
Message-Id: <20200922213859.108826-7-seanvk.dev@oregontracks.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922213859.108826-1-seanvk.dev@oregontracks.org>
References: <20200922213859.108826-1-seanvk.dev@oregontracks.org>
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
---
 drivers/pci/pci.h              |  2 +
 drivers/pci/pcie/portdrv_pci.c |  3 ++
 drivers/pci/pcie/rcec.c        | 96 ++++++++++++++++++++++++++++++++++
 include/linux/pci.h            |  1 +
 4 files changed, 102 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 7b547fc3679a..ddb5872466fb 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -474,9 +474,11 @@ static inline void pci_dpc_init(struct pci_dev *pdev) {}
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
index 519ae086ff41..5630480a6659 100644
--- a/drivers/pci/pcie/rcec.c
+++ b/drivers/pci/pcie/rcec.c
@@ -17,6 +17,102 @@
 
 #include "../pci.h"
 
+struct walk_rcec_data {
+	struct pci_dev *rcec;
+	int (*user_callback)(struct pci_dev *dev, void *data);
+	void *user_data;
+};
+
+static bool rcec_assoc_rciep(struct pci_dev *rcec, struct pci_dev *rciep)
+{
+	unsigned long bitmap = rcec->rcec_ext->bitmap;
+	unsigned int devn;
+
+	/* An RCiEP found on bus in range */
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
+void walk_rcec(int (*cb)(struct pci_dev *dev, void *data), void *userdata)
+{
+	struct walk_rcec_data *rcec_data = userdata;
+	struct pci_dev *rcec = rcec_data->rcec;
+	u8 nextbusn, lastbusn;
+	struct pci_bus *bus;
+	unsigned int bnr;
+
+	if (!rcec->rcec_cap)
+		return;
+
+	/* Walk own bus for bitmap based association */
+	pci_walk_bus(rcec->bus, cb, rcec_data);
+
+	/* Check whether RCEC BUSN register is present */
+	if (rcec->rcec_ext->ver < PCI_RCEC_BUSN_REG_VER)
+		return;
+
+	nextbusn = rcec->rcec_ext->nextbusn;
+	lastbusn = rcec->rcec_ext->lastbusn;
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
+ *
+ */
+void pcie_link_rcec(struct pci_dev *rcec)
+{
+	struct walk_rcec_data rcec_data;
+
+	if (!rcec->rcec_cap)
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
 	u32 rcec, hdr, busn;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 5c5c4eb642b6..ad382a9484ea 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -330,6 +330,7 @@ struct pci_dev {
 #ifdef CONFIG_PCIEPORTBUS
 	u16		rcec_cap;	/* RCEC capability offset */
 	struct rcec_ext *rcec_ext;	/* RCEC cached assoc. endpoint extended capabilities */
+	struct pci_dev  *rcec;          /* Associated RCEC device */
 #endif
 	u8		pcie_cap;	/* PCIe capability offset */
 	u8		msi_cap;	/* MSI capability offset */
-- 
2.28.0

