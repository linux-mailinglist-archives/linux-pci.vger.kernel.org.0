Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA450274B69
	for <lists+linux-pci@lfdr.de>; Tue, 22 Sep 2020 23:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgIVVqA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Sep 2020 17:46:00 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:37515 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726766AbgIVVpu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Sep 2020 17:45:50 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 06E735C019B;
        Tue, 22 Sep 2020 17:39:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 22 Sep 2020 17:39:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        oregontracks.org; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=+sr537zUzkNZ08T7g6GAZ8QzpLM3Aku5oaznajxJOXQ=; b=Skh6L
        qOf0JrUgVAQ66CNYW/C+XXnUW+d1ZfElX9PqoyRGUSL0bOnfKxB8yhtIIQCyOieq
        wYrOI6UOvaCWbILzYs3cXLrsh0+7sPVDPbDed2TgaZdJFDn9jVJ4NahqZXWF07O3
        DXI3ZOVC/ErgTXt9VaA2LMUrJ5rgU0pIbOxJyF1bfTDVECE2zzLeXFb+4pcYWLde
        QZ6hpmjOdOcfifbeCWOE/0ZRnzAnQboBEOQnIQvIGVFo9SdqfTDOEbv1BrYJvKim
        l8cO8J65k/xBM7KgjTWsAsSuU4oo4uWlEbaM10mhyJb6tMWeHkUvoxz7k2HX26+j
        pfGUy1A4DT4JwnyNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=+sr537zUzkNZ08T7g6GAZ8QzpLM3Aku5oaznajxJOXQ=; b=jq+hKRKz
        kKbHOjZhqgVR6kvJ723am0JnT3ErI+lQ++3pBe0ffJCk+8ar1fP4Afd8bLzqjyXN
        YPEURZ1IMlY/EM1jNKM7vAlALU/XQrntYXKaR1vo2Ldqz3Zxq/G5kbVWBwGa/NHc
        956yX56moFon2sp9yUVQjIfq92w+/CMH0hVoZImdCKkJznDmkRM6Mfc9//7VU3g7
        pK6nAGFAzXCzvdpEeAAI3fIVMwKQuEOizY9rzXfS0gfg9xvinwUhrELBu3KOqoYD
        Dn8Ymb4xp7t0LhPGn5EyTTdpN8V5NvuHFbjfKoLrrB1/4I9aHPK5bLbonFswial7
        UK5EgBXiM2Ywjg==
X-ME-Sender: <xms:_G5qXzqntKWC1RFkiGT0JAgFboOX_vYgRhPMBJfb1nCE2XSXHDJVbQ>
    <xme:_G5qX9prl5m5BfljxBNP1wqzYeStqduQ2FQejhTd9PTfXyiRFBIeypprsqC8Xzfzs
    E56xjnErPrTBU_O>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeggdduieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepufgvrghnucggucfmvghllhgvhicuoehsvggrnhhvkhdruggv
    vhesohhrvghgohhnthhrrggtkhhsrdhorhhgqeenucggtffrrghtthgvrhhnpeehkeffte
    eiudeiffelkeelvefftdelhfeitdeigeffleeufedvgfegvdefvedtteenucfkphepvdeg
    rddvtddrudegkedrgeelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepshgvrghnvhhkrdguvghvsehorhgvghhonhhtrhgrtghkshdrohhrgh
X-ME-Proxy: <xmx:_G5qXwMgt-AGvHKwbJfzxYu5_1c88DiwAtfDpnYvm-IwSmXno9dWKw>
    <xmx:_G5qX26_YpbUKDf2QquQ2RZXDckVVfgTqY0091zNiBIwSSh37LvY-Q>
    <xmx:_G5qXy4atNlOe5j6NNplpbytGqGVitJeEow2qMW90iPgPkjnUvmuMA>
    <xmx:_W5qX5age7_RNikkQdhaFBcdy2zNc4dP0diCs4wWOQUaujhvm5QuVg>
Received: from arch-ashland-svkelley.hsd1.or.comcast.net (c-24-20-148-49.hsd1.or.comcast.net [24.20.148.49])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9B85F3064610;
        Tue, 22 Sep 2020 17:39:07 -0400 (EDT)
From:   Sean V Kelley <seanvk.dev@oregontracks.org>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v6 02/10] PCI/RCEC: Bind RCEC devices to the Root Port driver
Date:   Tue, 22 Sep 2020 14:38:51 -0700
Message-Id: <20200922213859.108826-3-seanvk.dev@oregontracks.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922213859.108826-1-seanvk.dev@oregontracks.org>
References: <20200922213859.108826-1-seanvk.dev@oregontracks.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

If a Root Complex Integrated Endpoint (RCiEP) is implemented, errors may
optionally be sent to a corresponding Root Complex Event Collector (RCEC).
Each RCiEP must be associated with no more than one RCEC. Interface errors
are reported to the OS by RCECs.

For an RCEC (technically not a Bridge), error messages "received" from
associated RCiEPs must be enabled for "transmission" in order to cause a
System Error via the Root Control register or (when the Advanced Error
Reporting Capability is present) reporting via the Root Error Command
register and logging in the Root Error Status register and Error Source
Identification register.

Given the commonality with Root Ports and the need to also support AER
and PME services for RCECs, extend the Root Port driver to support RCEC
devices through the addition of the RCEC Class ID to the driver
structure.

Co-developed-by: Sean V Kelley <sean.v.kelley@intel.com>
Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/pci/pcie/portdrv_core.c | 8 ++++----
 drivers/pci/pcie/portdrv_pci.c  | 5 ++++-
 2 files changed, 8 insertions(+), 5 deletions(-)

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
 
diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 3a3ce40ae1ab..4d880679b9b1 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -106,7 +106,8 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
 	if (!pci_is_pcie(dev) ||
 	    ((pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT) &&
 	     (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM) &&
-	     (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM)))
+	     (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM) &&
+	     (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_EC)))
 		return -ENODEV;
 
 	status = pcie_port_device_register(dev);
@@ -195,6 +196,8 @@ static const struct pci_device_id port_pci_ids[] = {
 	{ PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x00), ~0) },
 	/* subtractive decode PCI-to-PCI bridge, class type is 060401h */
 	{ PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x01), ~0) },
+	/* handle any Root Complex Event Collector */
+	{ PCI_DEVICE_CLASS(((PCI_CLASS_SYSTEM_RCEC << 8) | 0x00), ~0) },
 	{ },
 };
 
-- 
2.28.0

