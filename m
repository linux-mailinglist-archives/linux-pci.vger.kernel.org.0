Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CACC427F4A9
	for <lists+linux-pci@lfdr.de>; Wed, 30 Sep 2020 23:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731485AbgI3V6v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 17:58:51 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:45891 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731424AbgI3V6u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Sep 2020 17:58:50 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 526D7FAC;
        Wed, 30 Sep 2020 17:58:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 30 Sep 2020 17:58:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        oregontracks.org; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=LUGpECjZ/iOeXoPbZCRW8B3Oc8jqNQKw5jp5fb7WAnY=; b=om3vS
        7o36M2qIZPhlkE5Bo0omBnh0JZ7vUxbdjlpbzOiLQfUS7hfy+FBbUcrlClvBejSi
        jM+Z104lli5Z3b1l/F00YNSChgA3/EeY7MqefEoA45I1je4JT6jIYBvqnxYgR6iL
        xz7sAJkmmywq0S8nqVt3eGqkZS9EdjF0nNyzZd9qWs+FclO8CyAcpT0eb81g8Llm
        lQns5eWhFL7i1S3oOq4EpLm3CPxbqYjuSzFxS0Qa2JpAV4IkKELOTM1rQ2wFhsVu
        FPGAwnCcJwLa7/RfCXlo+lQTPiG/xuIf1DAszj8pc+Nzxm4esBumWESLoHcwd1xj
        KbuVpAvlMLnBg+r/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=LUGpECjZ/iOeXoPbZCRW8B3Oc8jqNQKw5jp5fb7WAnY=; b=sjNFSraW
        GEHKOrm5ZROcLj04LsU1NzahcRvNi0q3Svl05lp3MjxD+fGtwPVUbqATPTFArbjF
        RTYl6eHHMzeao+nBRM77VCt8zUW8a236RNaQQIBqv45KxgH79y2KLjGi4S/oWan3
        /Qr8P+wqWQR3oxTG2g8cEC7IuLpaspUkbCuX8WJ+A1xUxQvihprV6B8lGL/SnBNQ
        fZs8wJ12JssLzIKCXvh5pzPpQxjUwL78xl0rKMAV0Oshl+u7SltyXRhqT49lg1IM
        VWDeUVmFdBQzeM63UrP8EQbl62azGFf+CQ6tfWsEfylGTo0/DnTPu605QKP0etM4
        Luudb7VndgWHVA==
X-ME-Sender: <xms:mP90XwezhpUi-fEjaGRLESMinQEqqFia5svvS-SW4kULrglCYUurlw>
    <xme:mP90XyOgnBNoWTHBvco_sgflRkLs6ZIIo4oBhG3gb-_Ltg6A8aI_ZSZww7gP0hyw9
    uzrrxq03MhUlvEU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeefgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefuvggrnhcuggcumfgvlhhlvgihuceoshgvrghnvhhkrdguvghv
    sehorhgvghhonhhtrhgrtghkshdrohhrgheqnecuggftrfgrthhtvghrnhepheekffetie
    duieffleekleevffdtlefhiedtieegffelueefvdfggedvfeevtdetnecukfhppedvgedr
    vddtrddugeekrdegleenucevlhhushhtvghrufhiiigvpedutdenucfrrghrrghmpehmrg
    hilhhfrhhomhepshgvrghnvhhkrdguvghvsehorhgvghhonhhtrhgrtghkshdrohhrgh
X-ME-Proxy: <xmx:mP90Xxj5MwPL2SqTxcnxXZn8-_JgdYH9xtDnAcZ0HjGBzA0l3nbIuQ>
    <xmx:mP90X18L8MX8k5ZfvWQ4EF61Nt8l1mJmQ0zluZYpJRWD6oUq86E8YA>
    <xmx:mP90X8v1QwuJ1AJ13zMl6x0Z8OH60QEVEuBhQ0GlFoHmF2yzUC7i5A>
    <xmx:mP90Xx95StZjt2sPJ4ENvIGOLAQbf0iab9id_bRUnfXtkw8kB9gHvg>
Received: from arch-ashland-svkelley.hsd1.or.comcast.net (c-24-20-148-49.hsd1.or.comcast.net [24.20.148.49])
        by mail.messagingengine.com (Postfix) with ESMTPA id CF1063280063;
        Wed, 30 Sep 2020 17:58:46 -0400 (EDT)
From:   Sean V Kelley <seanvk.dev@oregontracks.org>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v7 12/13] PCI/PME: Add pcie_walk_rcec() to RCEC PME handling
Date:   Wed, 30 Sep 2020 14:58:19 -0700
Message-Id: <20200930215820.1113353-13-seanvk.dev@oregontracks.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930215820.1113353-1-seanvk.dev@oregontracks.org>
References: <20200930215820.1113353-1-seanvk.dev@oregontracks.org>
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
index 50a9522ab07d..487ddce1b12f 100644
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
+	    pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) &&
 	    (pcie_ports_native || host->native_pme)) {
 		services |= PCIE_PORT_SERVICE_PME;
 
-- 
2.28.0

