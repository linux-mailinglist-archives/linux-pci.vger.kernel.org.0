Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D120281B39
	for <lists+linux-pci@lfdr.de>; Fri,  2 Oct 2020 20:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387712AbgJBS4g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Oct 2020 14:56:36 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:53025 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387806AbgJBS4g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Oct 2020 14:56:36 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id B4A445C0163;
        Fri,  2 Oct 2020 14:48:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 02 Oct 2020 14:48:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        oregontracks.org; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=9mBueR5mjc2elX0S5GvL5L98HPD3F2dJX6eYncjCuDA=; b=HgMJr
        0sU+KdVq83ivh2Z1ZjpUHSIUBKpQdTU2ekmYMt8xXu5xzVnogtWKah1TbiSyoJVq
        dKEOot0VmQAqkVBRGzTfgxUHFABvsj1Qt0+wt3r+7tOF1bvk7EwFVPQYWvOvHBbN
        2skxhktMoU7skpAZ1ZI2VBxZ5rX7kLs4PFFVcUM2hyG/9hVX6Q5suc72LuEqfbIh
        vAaBxzvqUkwJkRWTwWRJxUjeathpwQY7LW6AKqcK7o1xCk+z4oIMWCigMn5bbvgc
        ufzzdyNbU04mEY/VE6uQo5OmgV6Y6bopfLG1cEt4yFoEKTyiEZbxATTA2yjJj2G7
        AnN87bCypNaw87P/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=9mBueR5mjc2elX0S5GvL5L98HPD3F2dJX6eYncjCuDA=; b=k5oMsFXW
        N35ccTiopYB97PRjC59zmov+ryKeAXtUcVs0oF0ewwbto8VtIuhFeY2GWsqtj5NL
        yYm/iCI7Iok/Pb5IpQhMJKdpTuPXfva1iE8nu+D9uTp5z+CH33fX5mvss1xoCLs7
        rnChu9ZAkyeMTF2DuetSgLg30KwXEG2v8WoCP2cqvrp7TeScyNui+wKXPNCcF4a9
        esM13dpGgbrFglA/yqH8wS0NQ7BsHW+2xlHDOXewa2lGGgXhMw1OfjNR9cmrMzF7
        0MUTaS5r/AL+U+yzmOfad+qvlp6QGle1uFz5Qquw4IGcrFeFgVL2qrOpKUAx53tU
        K9/+zmPxmBci6Q==
X-ME-Sender: <xms:8nV3X7jYPzdQ0_U0hDcfEY8yfokLhhE7aRrN1f26YUI7ut7yG-yWew>
    <xme:8nV3X4CyeoRHHHNxNVtWos36WEIqT_sOTF70EAoZiyMQGWhCklImpjD4YtBKvXxek
    maU1V5NFtOsgtSk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeeigdduvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepufgvrghnucggucfmvghllhgvhicuoehsvggrnhhvkhdruggv
    vhesohhrvghgohhnthhrrggtkhhsrdhorhhgqeenucggtffrrghtthgvrhhnpeehkeffte
    eiudeiffelkeelvefftdelhfeitdeigeffleeufedvgfegvdefvedtteenucfkphepvdeg
    rddvtddrudegkedrgeelnecuvehluhhsthgvrhfuihiivgepuddunecurfgrrhgrmhepmh
    grihhlfhhrohhmpehsvggrnhhvkhdruggvvhesohhrvghgohhnthhrrggtkhhsrdhorhhg
X-ME-Proxy: <xmx:8nV3X7FY_Sn0fPinltUd4k9_nrqQ-zg7_q1uXOOPP1ImIeu31uiuyA>
    <xmx:8nV3X4Q1nQRhVO3I9mcMvWUBjPXgCqHgSLDCIp31wlkCiw8OyNnG3A>
    <xmx:8nV3X4wl-D47sNzU_GtwBFUtbkr4FuJY34p-zcAV5jOugDZK6jIEXw>
    <xmx:8nV3X7zc9WxPVv0xA8L4K2WtQtvQrU28NorN0sMLIDvU4imMMuoq-w>
Received: from arch-ashland-svkelley.hsd1.or.comcast.net (c-24-20-148-49.hsd1.or.comcast.net [24.20.148.49])
        by mail.messagingengine.com (Postfix) with ESMTPA id 033ED306468A;
        Fri,  2 Oct 2020 14:48:16 -0400 (EDT)
From:   Sean V Kelley <seanvk.dev@oregontracks.org>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v8 13/14] PCI/PME: Add pcie_walk_rcec() to RCEC PME handling
Date:   Fri,  2 Oct 2020 11:47:34 -0700
Message-Id: <20201002184735.1229220-14-seanvk.dev@oregontracks.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201002184735.1229220-1-seanvk.dev@oregontracks.org>
References: <20201002184735.1229220-1-seanvk.dev@oregontracks.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sean V Kelley <sean.v.kelley@intel.com>

Root Complex Event Collectors (RCEC) appear as peers of Root Ports
and also have the PME capability. As with AER, there is a need to be
able to walk the RCiEPs associated with their RCEC for purposes of
acting upon them with callbacks. So add RCEC support through the use
of pcie_walk_rcec() to the current PME service driver and attach the
PME service driver to the RCEC device.

Co-developed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
---
 drivers/pci/pcie/pme.c          | 15 +++++++++++----
 drivers/pci/pcie/portdrv_core.c |  8 ++++----
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
index 6a32970bb731..87799166c96a 100644
--- a/drivers/pci/pcie/pme.c
+++ b/drivers/pci/pcie/pme.c
@@ -310,7 +310,10 @@ static int pcie_pme_can_wakeup(struct pci_dev *dev, void *ign)
 static void pcie_pme_mark_devices(struct pci_dev *port)
 {
 	pcie_pme_can_wakeup(port, NULL);
-	if (port->subordinate)
+
+	if (pci_pcie_type(port) == PCI_EXP_TYPE_RC_EC)
+		pcie_walk_rcec(port, pcie_pme_can_wakeup, NULL);
+	else if (port->subordinate)
 		pci_walk_bus(port->subordinate, pcie_pme_can_wakeup, NULL);
 }
 
@@ -320,10 +323,15 @@ static void pcie_pme_mark_devices(struct pci_dev *port)
  */
 static int pcie_pme_probe(struct pcie_device *srv)
 {
-	struct pci_dev *port;
+	struct pci_dev *port = srv->port;
 	struct pcie_pme_service_data *data;
 	int ret;
 
+	/* Limit to Root Ports or Root Complex Event Collectors */
+	if ((pci_pcie_type(port) != PCI_EXP_TYPE_RC_EC) &&
+	    (pci_pcie_type(port) != PCI_EXP_TYPE_ROOT_PORT))
+		return -ENODEV;
+
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
@@ -333,7 +341,6 @@ static int pcie_pme_probe(struct pcie_device *srv)
 	data->srv = srv;
 	set_service_data(srv, data);
 
-	port = srv->port;
 	pcie_pme_interrupt_enable(port, false);
 	pcie_clear_root_pme_status(port);
 
@@ -445,7 +452,7 @@ static void pcie_pme_remove(struct pcie_device *srv)
 
 static struct pcie_port_service_driver pcie_pme_driver = {
 	.name		= "pcie_pme",
-	.port_type	= PCI_EXP_TYPE_ROOT_PORT,
+	.port_type	= PCIE_ANY_PORT,
 	.service	= PCIE_PORT_SERVICE_PME,
 
 	.probe		= pcie_pme_probe,
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 50a9522ab07d..99769c636775 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -234,11 +234,11 @@ static int get_port_device_capability(struct pci_dev *dev)
 #endif
 
 	/*
-	 * Root ports are capable of generating PME too.  Root Complex
-	 * Event Collectors can also generate PMEs, but we don't handle
-	 * those yet.
+	 * Root ports and Root Complex Event Collectors are capable
+	 * of generating PME.
 	 */
-	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT &&
+	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
+	     pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) &&
 	    (pcie_ports_native || host->native_pme)) {
 		services |= PCIE_PORT_SERVICE_PME;
 
-- 
2.28.0

