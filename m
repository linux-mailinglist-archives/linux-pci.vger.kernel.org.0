Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A04624B00
	for <lists+linux-pci@lfdr.de>; Thu, 10 Nov 2022 20:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiKJTxh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Nov 2022 14:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbiKJTxc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2022 14:53:32 -0500
Received: from resdmta-h1p-028597.sys.comcast.net (resdmta-h1p-028597.sys.comcast.net [IPv6:2001:558:fd02:2446::d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBDA4876B
        for <linux-pci@vger.kernel.org>; Thu, 10 Nov 2022 11:53:19 -0800 (PST)
Received: from resomta-h1p-027912.sys.comcast.net ([96.102.179.201])
        by resdmta-h1p-028597.sys.comcast.net with ESMTP
        id t6rzofAFOwwPvtDZYoNduM; Thu, 10 Nov 2022 19:50:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=comcastmailservice.net; s=20211018a; t=1668109848;
        bh=zccPbXOs+Je83CkegCNzQLUUfDjEU/+RJ69WLlkTgqU=;
        h=Received:Received:From:To:Subject:Date:Message-Id:MIME-Version:
         Xfinity-Spam-Result;
        b=uwSnCEFGMYmYTLR0v1pyiI3AmVjuQb4WmLo5iG7dW3tnavD0UI6rBA8UhnUu5uaXZ
         V6M69kun0e6IejQaVyOed8ax6kznH8ckki2Yx+aRX9zAOfAXZPT7K3tJE0ln1dbQ31
         WlCquJDELMi2jTt6XeVYEO2LDsLPRyLY3DcZ0sWOmKDaBqBfFYEgTq/M2uU4CjHSUU
         9yw21qpZy1dosVLJvU6otraw38F5+KFdvf8HkVdzFJx2H26DaGRQJM9enfMIL3B4pi
         IKq6MYAwPLEZLxMA3Iu2mTkPupdN1IzIP+oFmIU192kz6mc4WgRhckGeNv5vvv3Shb
         RZYwsQox+dqhA==
Received: from jderrick-mobl4.amr.corp.intel.com ([71.205.181.50])
        by resomta-h1p-027912.sys.comcast.net with ESMTPA
        id tDZ4oZTHiVTvltDZIokliE; Thu, 10 Nov 2022 19:50:32 +0000
X-Xfinity-VAAS: gggruggvucftvghtrhhoucdtuddrgedvgedrfeeggddufeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuvehomhgtrghsthdqtfgvshhipdfqfgfvpdfpqffurfetoffkrfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhgrthhhrghnucffvghrrhhitghkuceojhhonhgrthhhrghnrdguvghrrhhitghksehlihhnuhigrdguvghvqeenucggtffrrghtthgvrhhnpedtteeljeffgfffveehhfetveefuedvheevffffhedtjeeuvdevgfeftddtheeftdenucfkphepjedurddvtdehrddukedurdehtdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhephhgvlhhopehjuggvrhhrihgtkhdqmhhosghlgedrrghmrhdrtghorhhprdhinhhtvghlrdgtohhmpdhinhgvthepjedurddvtdehrddukedurdehtddpmhgrihhlfhhrohhmpehjohhnrghthhgrnhdruggvrhhrihgtkheslhhinhhugidruggvvhdpnhgspghrtghpthhtohepkedprhgtphhtthhopehvihguhigrshesnhhvihguihgrrdgtohhmpdhrtghpthhtohepmhgrnhhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlohhrvghniihordhpihgvrhgrlhhishhisegrrhhmrdgtohhmpdhrtghpthhtohephhgvlhhgrggrsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
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
Subject: [PATCH v2 5/7] PCI: pci-bridge-emul: Provide a helper to set behavior
Date:   Thu, 10 Nov 2022 12:50:13 -0700
Message-Id: <20221110195015.207-6-jonathan.derrick@linux.dev>
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

Add a handler to set behavior of a PCI or PCIe register. Add the
appropriate enums to specify the register's Read-Only, Read-Write, and
Write-1-to-Clear behaviors.

Signed-off-by: Jonathan Derrick <jonathan.derrick@linux.dev>
---
 drivers/pci/pci-bridge-emul.c | 19 +++++++++++++++++++
 drivers/pci/pci-bridge-emul.h | 10 ++++++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/pci/pci-bridge-emul.c b/drivers/pci/pci-bridge-emul.c
index 9334b2dd4764..3c1a683ece66 100644
--- a/drivers/pci/pci-bridge-emul.c
+++ b/drivers/pci/pci-bridge-emul.c
@@ -46,6 +46,25 @@ struct pci_bridge_reg_behavior {
 	u32 w1c;
 };
 
+void pci_bridge_emul_set_reg_behavior(struct pci_bridge_emul *bridge,
+				      bool pcie, int reg, u32 val,
+				      enum pci_bridge_emul_reg_behavior type)
+{
+	struct pci_bridge_reg_behavior *behavior;
+
+	if (pcie)
+		behavior = &bridge->pcie_cap_regs_behavior[reg / 4];
+	else
+		behavior = &bridge->pci_regs_behavior[reg / 4];
+
+	if (type == PCI_BRIDGE_EMUL_REG_BEHAVIOR_RO)
+		behavior->ro = val;
+	else if (type == PCI_BRIDGE_EMUL_REG_BEHAVIOR_RW)
+		behavior->rw = val;
+	else /* PCI_BRIDGE_EMUL_REG_BEHAVIOR_W1C */
+		behavior->w1c = val;
+}
+
 static const
 struct pci_bridge_reg_behavior pci_regs_behavior[PCI_STD_HEADER_SIZEOF / 4] = {
 	[PCI_VENDOR_ID / 4] = { .ro = ~0 },
diff --git a/drivers/pci/pci-bridge-emul.h b/drivers/pci/pci-bridge-emul.h
index 2a0e59c7f0d9..b2401d58518c 100644
--- a/drivers/pci/pci-bridge-emul.h
+++ b/drivers/pci/pci-bridge-emul.h
@@ -72,6 +72,12 @@ struct pci_bridge_emul;
 typedef enum { PCI_BRIDGE_EMUL_HANDLED,
 	       PCI_BRIDGE_EMUL_NOT_HANDLED } pci_bridge_emul_read_status_t;
 
+enum pci_bridge_emul_reg_behavior {
+	PCI_BRIDGE_EMUL_REG_BEHAVIOR_RO,
+	PCI_BRIDGE_EMUL_REG_BEHAVIOR_RW,
+	PCI_BRIDGE_EMUL_REG_BEHAVIOR_W1C,
+};
+
 struct pci_bridge_emul_ops {
 	/*
 	 * Called when reading from the regular PCI bridge
@@ -161,4 +167,8 @@ int pci_bridge_emul_conf_read(struct pci_bridge_emul *bridge, int where,
 int pci_bridge_emul_conf_write(struct pci_bridge_emul *bridge, int where,
 			       int size, u32 value);
 
+void pci_bridge_emul_set_reg_behavior(struct pci_bridge_emul *bridge,
+				      bool pcie, int reg, u32 val,
+				      enum pci_bridge_emul_reg_behavior type);
+
 #endif /* __PCI_BRIDGE_EMUL_H__ */
-- 
2.30.2

