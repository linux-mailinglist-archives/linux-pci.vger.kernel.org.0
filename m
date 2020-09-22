Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452FB274B61
	for <lists+linux-pci@lfdr.de>; Tue, 22 Sep 2020 23:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgIVVpv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Sep 2020 17:45:51 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:54193 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726738AbgIVVpu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Sep 2020 17:45:50 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id D183C5C01C0;
        Tue, 22 Sep 2020 17:39:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 22 Sep 2020 17:39:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        oregontracks.org; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=j3FGmFi/UuXMsj6wckdtZKcMOyX7nubPO/gaqFMWzMY=; b=gzQhl
        YAeq45uQe3rcdkFA4byrZaHv5LV+2mn8yPh8dU4vZclE/2Ijt+VnGJTZ+N1DnpZW
        w745a1LGCq18N2jHaWkTZBoVXxqNxKa9Fvri+7jaeC0cULhtfaQ0V4p33SHaS6T1
        DRby1UOldwLlCWLBTjfVtaS22BuSH4+TEbcPXFi5Dj/Q9uuZ4+F78E8LAskEtgqB
        vDMW4S1ghFx3IsEFOyslfW3FZWa18IjfP0bsEADWOMFubuWj7Zv+bsHUkbhJRIl3
        8vuoybqlUge2Lo/3LhjJKiq5WmYV/u++c6c31XZ5UAvamey0/51AUyNSiOZ+QoyE
        EtvglTVdCzRVppIQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=j3FGmFi/UuXMsj6wckdtZKcMOyX7nubPO/gaqFMWzMY=; b=O5qosg7k
        +GBRqCRmzgfBRSFZTtDwnSZn8jqpV5/fQ9A2ks8+w7bOeDDae1UmJxEFHdyfz/jb
        FAdSbeX6FFCR51KmvShN/0k+3VkYWIA1Cr6kgyar203OxKr8wiQIph3VjNO/s7ZI
        WR1+2XxwvPLFF4GuiZfPT5lJAAvsvI15wb9PeUkQtmw9d7XrrqGKQpGbEPe3NjjC
        cIqor+QvWfRjFqr3XbLAAPLZm8pJ/EIJoSR16UUY81dl424YCbb1nup7zDliKdpe
        XRw3AbjOl2/TePeNmcoe8Br7Ogzd0azMcWqdTDsp09O+QE94hfN0lwy2PgQv+r64
        hF6fhFpFl6sPxA==
X-ME-Sender: <xms:DW9qX_xAjLog79qr85SXxunAdVxJMMIrfnXMRvhNlds2iIas5oLsOw>
    <xme:DW9qX3QvYCizR-fOq64EmNrkseot56c57w_B_eAIm61r-UaTfo-Mnyik1JORw-0MT
    eCjvY1pcGqmVTmP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeggdduieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepufgvrghnucggucfmvghllhgvhicuoehsvggrnhhvkhdruggv
    vhesohhrvghgohhnthhrrggtkhhsrdhorhhgqeenucggtffrrghtthgvrhhnpeehkeffte
    eiudeiffelkeelvefftdelhfeitdeigeffleeufedvgfegvdefvedtteenucfkphepvdeg
    rddvtddrudegkedrgeelnecuvehluhhsthgvrhfuihiivgepieenucfrrghrrghmpehmrg
    hilhhfrhhomhepshgvrghnvhhkrdguvghvsehorhgvghhonhhtrhgrtghkshdrohhrgh
X-ME-Proxy: <xmx:DW9qX5XE5umScrnIdeiBL3PtdAaVeGOxcuQ3fnVRreP9nBIJmdUS-Q>
    <xmx:DW9qX5j9HqBMPRA84x7jUC_85la3wMm8u5v5FJxCrh8QQ0qsvHS18g>
    <xmx:DW9qXxBObNlR96gDfsy6nkQamX-duNwzXYotm291nbX2JOglJZ5krw>
    <xmx:DW9qX7B-xPN61wbEeYKP6d0bxAVDRjG1JRKyH_bKsmgk7emEtrp1rw>
Received: from arch-ashland-svkelley.hsd1.or.comcast.net (c-24-20-148-49.hsd1.or.comcast.net [24.20.148.49])
        by mail.messagingengine.com (Postfix) with ESMTPA id A787E3064674;
        Tue, 22 Sep 2020 17:39:23 -0400 (EDT)
From:   Sean V Kelley <seanvk.dev@oregontracks.org>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v6 09/10] PCI/PME: Add pcie_walk_rcec() to RCEC PME handling
Date:   Tue, 22 Sep 2020 14:38:58 -0700
Message-Id: <20200922213859.108826-10-seanvk.dev@oregontracks.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922213859.108826-1-seanvk.dev@oregontracks.org>
References: <20200922213859.108826-1-seanvk.dev@oregontracks.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sean V Kelley <sean.v.kelley@intel.com>

The Root Complex Event Collectors(RCEC) appear as peers of Root Ports
and also have the PME capability. As with AER, there is a need to be
able to walk the RCiEPs associated with their RCEC for purposes of
acting upon them with callbacks. So add RCEC support through the use
of pcie_walk_rcec() to the current PME service driver and attach the
PME service driver to the RCEC device.

Co-developed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
---
 drivers/pci/pcie/pme.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

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
-- 
2.28.0

