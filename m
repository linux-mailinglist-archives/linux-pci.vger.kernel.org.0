Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5DA27F4A1
	for <lists+linux-pci@lfdr.de>; Wed, 30 Sep 2020 23:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731335AbgI3V6i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 17:58:38 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:42179 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731221AbgI3V6f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Sep 2020 17:58:35 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 8ED64F91;
        Wed, 30 Sep 2020 17:58:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 30 Sep 2020 17:58:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        oregontracks.org; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=U8/XHA7xYYbMasOe6r2wYXcREytGZ8ybKr2Q2zebr+Y=; b=Beoos
        qGx79ewYQl+yaY7TIZJCfZX1gnoBhrv2d2PxdXnCk+PrwAb9vj1aAy1rIlBOCxD9
        UBR9jxEGj9KaHKdJtT6eX9/kbZ6bI0czE1xcFEDI+rvOknK7iJZqA83GTguUicK/
        o/QomxRUWmdCbER1VPdDajYJlAOZWEnhcbvMLOpkp53Hj2xVunla2pmX4Mff9mN2
        bFlxatMX4e/FL//8XIlMiR/oCE9J7aqEgy3uIJFToSF5ZcL2IoBCsLXZN42+O4Ev
        zRnETyYQzJ85rnLudGHeyYZZJ3MpKuVOxtUxsA51TJJkSaJTLnFWhXwX8jv5k7xB
        IsXtEkYjETP08cA+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=U8/XHA7xYYbMasOe6r2wYXcREytGZ8ybKr2Q2zebr+Y=; b=Kfhjtp4N
        xVg22wbKF+aB86baHUH0YvlMkVcy4NMcBLm5hXEn1ha+sgVuesG8o3ahXt4zsXI7
        bHpnr7s1vEyNk9C/gSPD63e775uHGXnGLrmbF+wHtDLdGrKorqIzDgsgeiNvA82N
        xS1TggnnL0bNz+sSEb9hBOvLcVYPxM5c4mdLVUaANyYF4hYLxR4ti8LME1LaeFri
        Xj/KEBK5YJp5Lb3RFDvt8JtS5gYc/IjuTSmcHdP/wef65Mpk2s5kRt+KS0/J9ZVQ
        oPFJGu/NmsvpA6hlnT1BtvkGg80Efoh1zotRxJOPmHJ2GxDJr0/tLcsDaLYBq4E7
        SzciTkWLbZU9GA==
X-ME-Sender: <xms:iv90X2slqB8aZOS74kz-dfanEvsjaQ-lw0NMyRsUkOCLKYQshYC5Vg>
    <xme:iv90X7cs0BzJFdA8oAdUpBRDjZr7roa24HLM6b2zkjEkA38tHtGy3Od2zDS_-8n_B
    Afm494MydhL4wqR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeefgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefuvggrnhcuggcumfgvlhhlvgihuceoshgvrghnvhhkrdguvghv
    sehorhgvghhonhhtrhgrtghkshdrohhrgheqnecuggftrfgrthhtvghrnhepheekffetie
    duieffleekleevffdtlefhiedtieegffelueefvdfggedvfeevtdetnecukfhppedvgedr
    vddtrddugeekrdegleenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehsvggrnhhvkhdruggvvhesohhrvghgohhnthhrrggtkhhsrdhorhhg
X-ME-Proxy: <xmx:iv90XxzM4y5ueeHXDx2xreKk8plTR9wkoPLMYgkSKBKbnnB0t3bxyA>
    <xmx:iv90XxN8ElfIPRst9ZWg-IPYPYjXsgZj49fd_5xPCwRKOe_gs9nUxw>
    <xmx:iv90X2-qH8Z0EKlxgemW_kdK3gxw_7kvGjz4ihpV4WVyxMr3mhxVcA>
    <xmx:iv90X7NSisb_fn_VfC9HxOyeHMbXY-q11KhmkUw84dMnm8J023hN1g>
Received: from arch-ashland-svkelley.hsd1.or.comcast.net (c-24-20-148-49.hsd1.or.comcast.net [24.20.148.49])
        by mail.messagingengine.com (Postfix) with ESMTPA id C17A73280059;
        Wed, 30 Sep 2020 17:58:32 -0400 (EDT)
From:   Sean V Kelley <seanvk.dev@oregontracks.org>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v7 02/13] PCI/RCEC: Bind RCEC devices to the Root Port driver
Date:   Wed, 30 Sep 2020 14:58:09 -0700
Message-Id: <20200930215820.1113353-3-seanvk.dev@oregontracks.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930215820.1113353-1-seanvk.dev@oregontracks.org>
References: <20200930215820.1113353-1-seanvk.dev@oregontracks.org>
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
 drivers/pci/pcie/portdrv_pci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

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

