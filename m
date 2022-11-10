Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C16C624AFD
	for <lists+linux-pci@lfdr.de>; Thu, 10 Nov 2022 20:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbiKJTxe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Nov 2022 14:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbiKJTxc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2022 14:53:32 -0500
Received: from resdmta-h1p-028597.sys.comcast.net (resdmta-h1p-028597.sys.comcast.net [IPv6:2001:558:fd02:2446::d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDBA47336
        for <linux-pci@vger.kernel.org>; Thu, 10 Nov 2022 11:53:19 -0800 (PST)
Received: from resomta-h1p-027912.sys.comcast.net ([96.102.179.201])
        by resdmta-h1p-028597.sys.comcast.net with ESMTP
        id tCeRofXGGwwPvtDZYoNduH; Thu, 10 Nov 2022 19:50:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=comcastmailservice.net; s=20211018a; t=1668109848;
        bh=Way0DAlL2ACj9a+XKDlJAFMBT/Xv2jTSB4J5Mymp4EY=;
        h=Received:Received:From:To:Subject:Date:Message-Id:MIME-Version:
         Xfinity-Spam-Result;
        b=Jd6DCUAG1EkFhnB4AtYmQsa2gV+f9s1dU+Qe29DVxNiCCp1H1JKQ325+arJXxBaP5
         rM0o/eaJ35AcKCpgUsZ4GYYiXedDt3XPoBojxGbI9WXoPzAB+2Hu5W+f+p/OJSYE2m
         WugCtQmLeouW7Qdni7pvejpSQfID/9HWDqZ7B8JSyoxyosJpHZ4QPPdmPTRp+wzgJs
         hZgCi2xhs8qxi1uwIEYWFaOdIq+4tomSW5ii12obDBNy3x8BlCKQjNR/75A/AcSRLs
         oaua5iy6WkCNy9i8wKIa7VmQPCjdygtLARKu1ZNzpkYoYt/5fIw9hwSR4ep6BQ3F2E
         GSQcsqLRQKaGw==
Received: from jderrick-mobl4.amr.corp.intel.com ([71.205.181.50])
        by resomta-h1p-027912.sys.comcast.net with ESMTPA
        id tDZ4oZTHiVTvltDZDoklht; Thu, 10 Nov 2022 19:50:28 +0000
X-Xfinity-VAAS: gggruggvucftvghtrhhoucdtuddrgedvgedrfeeggddufeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuvehomhgtrghsthdqtfgvshhipdfqfgfvpdfpqffurfetoffkrfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhgrthhhrghnucffvghrrhhitghkuceojhhonhgrthhhrghnrdguvghrrhhitghksehlihhnuhigrdguvghvqeenucggtffrrghtthgvrhhnpedtteeljeffgfffveehhfetveefuedvheevffffhedtjeeuvdevgfeftddtheeftdenucfkphepjedurddvtdehrddukedurdehtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehjuggvrhhrihgtkhdqmhhosghlgedrrghmrhdrtghorhhprdhinhhtvghlrdgtohhmpdhinhgvthepjedurddvtdehrddukedurdehtddpmhgrihhlfhhrohhmpehjohhnrghthhgrnhdruggvrhhrihgtkheslhhinhhugidruggvvhdpnhgspghrtghpthhtohepkedprhgtphhtthhopehvihguhigrshesnhhvihguihgrrdgtohhmpdhrtghpthhtohepmhgrnhhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlohhrvghniihordhpihgvrhgrlhhishhisegrrhhmrdgtohhmpdhrtghpthhtohephhgvlhhgrggrsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
 hugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsseifuhhnnhgvrhdruggvpdhrtghpthhtohepphgrlhhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhnrghthhgrnhdruggvrhhrihgtkheslhhinhhugidruggvvh
X-Xfinity-VMeta: sc=-100.00;st=legit
From:   Jonathan Derrick <jonathan.derrick@linux.dev>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>, Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Jonathan Derrick <jonathan.derrick@linux.dev>
Subject: [PATCH v2 1/7] PCI: Allow for indirecting capability registers
Date:   Thu, 10 Nov 2022 12:50:09 -0700
Message-Id: <20221110195015.207-2-jonathan.derrick@linux.dev>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221110195015.207-1-jonathan.derrick@linux.dev>
References: <20221110195015.207-1-jonathan.derrick@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_PASS,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Allow another driver to provide alternative operations when doing
capability register reads and writes. The intention is to have
pcie_bridge_emul provide alternate handlers for the Slot Capabilities, Slot
Control, and Slot Status registers. Alternate handlers can return > 0 if
unhandled, errno on error, or 0 on success. This could potentially be
used to handle quirks in a different manner.

Signed-off-by: Jonathan Derrick <jonathan.derrick@linux.dev>
---
 drivers/pci/access.c | 29 +++++++++++++++++++++++++++++
 include/linux/pci.h  | 11 +++++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 708c7529647f..dbfea6824bd4 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -424,6 +424,17 @@ int pcie_capability_read_word(struct pci_dev *dev, int pos, u16 *val)
 		return ret;
 	}
 
+	if (dev->caps_rw_ops) {
+		u32 reg;
+		ret = dev->caps_rw_ops->read(dev, pos, 4, &reg);
+		if (!ret) {
+			*val = reg & 0xffff;
+			return ret;
+		} else if (ret < 0) {
+			return ret;
+		}
+	}
+
 	/*
 	 * For Functions that do not implement the Slot Capabilities,
 	 * Slot Status, and Slot Control registers, these spaces must
@@ -459,6 +470,12 @@ int pcie_capability_read_dword(struct pci_dev *dev, int pos, u32 *val)
 		return ret;
 	}
 
+	if (dev->caps_rw_ops) {
+		ret = dev->caps_rw_ops->read(dev, pos, 4, val);
+		if (ret <= 0)
+			return ret;
+	}
+
 	if (pci_is_pcie(dev) && pcie_downstream_port(dev) &&
 	    pos == PCI_EXP_SLTSTA)
 		*val = PCI_EXP_SLTSTA_PDS;
@@ -475,6 +492,12 @@ int pcie_capability_write_word(struct pci_dev *dev, int pos, u16 val)
 	if (!pcie_capability_reg_implemented(dev, pos))
 		return 0;
 
+	if (dev->caps_rw_ops) {
+		int ret = dev->caps_rw_ops->write(dev, pos, 2, val);
+		if (ret <= 0)
+			return ret;
+	}
+
 	return pci_write_config_word(dev, pci_pcie_cap(dev) + pos, val);
 }
 EXPORT_SYMBOL(pcie_capability_write_word);
@@ -487,6 +510,12 @@ int pcie_capability_write_dword(struct pci_dev *dev, int pos, u32 val)
 	if (!pcie_capability_reg_implemented(dev, pos))
 		return 0;
 
+	if (dev->caps_rw_ops) {
+		int ret = dev->caps_rw_ops->write(dev, pos, 4, val);
+		if (ret <= 0)
+			return ret;
+	}
+
 	return pci_write_config_dword(dev, pci_pcie_cap(dev) + pos, val);
 }
 EXPORT_SYMBOL(pcie_capability_write_dword);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2bda4a4e47e8..ff47ef83ab38 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -311,6 +311,15 @@ struct pci_vpd {
 	u8		cap;
 };
 
+/*
+ * Capability reads/write redirect
+ * Returns 0, errno, or > 0 if unhandled
+ */
+struct caps_rw_ops {
+	int (*read)(struct pci_dev *dev, int pos, int len, u32 *val);
+	int (*write)(struct pci_dev *dev, int pos, int len, u32 val);
+};
+
 struct irq_affinity;
 struct pcie_link_state;
 struct pci_sriov;
@@ -523,6 +532,8 @@ struct pci_dev {
 
 	/* These methods index pci_reset_fn_methods[] */
 	u8 reset_methods[PCI_NUM_RESET_METHODS]; /* In priority order */
+
+	struct caps_rw_ops *caps_rw_ops;
 };
 
 static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
-- 
2.30.2

