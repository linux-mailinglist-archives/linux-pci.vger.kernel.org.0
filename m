Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F33281B3D
	for <lists+linux-pci@lfdr.de>; Fri,  2 Oct 2020 20:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387688AbgJBS4i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Oct 2020 14:56:38 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:46257 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388321AbgJBS4h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Oct 2020 14:56:37 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 8AD005C0114;
        Fri,  2 Oct 2020 14:47:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 02 Oct 2020 14:47:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        oregontracks.org; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=sXU2mMj241EpiiCcqsuur0tkuJtqxuKBseWszyh/a9c=; b=gBblj
        ySLx6V5DKR0N39C4frpz8GVRPpqXtM5UiLCooTmLbfheHdNYEwRiHx19vHT6bRhd
        N5FY2tTHfOhyT8zIk16RrScsw4qN63dxjWMfHJyKuDHcmE3kFaLyzkueRoxA3q1k
        YW8g8c9SLnEZQfRJ5wPokcRyWmVDS64E97L1eSXXYGv/KzgEalTEkesTXXvDmffC
        KqtKLkyMHs0A81/8toXL+azvTdIZHcjtDm/ag34oM+m4i4gd+TAwhYrAYcVtZNcb
        WU9ofVA0C5IyF0dAKsJk/A0Jc+7eCpxnqtOuFrXdR8VA7gbTfTFEn+OXn+gYedEX
        SIYXVYw7rvhHpYNww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=sXU2mMj241EpiiCcqsuur0tkuJtqxuKBseWszyh/a9c=; b=LeWF0jhD
        9dzRysunuM7s/QL/lrhO90ONjmyYSAQJMlROy0ohSv2L9prV6mPN87gLvxZ7SHwc
        WzIMopBWTm/cRJJWQW/Ee4U0l1cc6ktt0dMIANMhYKZengx0nHOcfbL2HsVZk6wH
        tw+874QL80s+ok7Xu6ymRxB/45150gdUsAC0bs5FVrRL5zsGLolYBDzuw8xPV5xP
        k2KkUtgrUCzMqGj9dWuY9ll1PXEVwe68ku3nb6yucbvK0qRpKo0MgagheEO7L2BE
        UNrVPTjEN0yGT8Bv5Xtd3fiC9iqWwMiV1PgOC9tb9YJKyFsgAQHxIyuL51ToDvZh
        Xa064ANLJHWTqg==
X-ME-Sender: <xms:2XV3X6xcb_suRKjT-yzsvm1d2bdAs_90RJGZXvOmT8BAeMtKcrVLDA>
    <xme:2XV3X2QZM_ruO11j1EDEDyGsiqj22AQhdeTlJCSAzJrNlWObGZ2r4Iuda-52bF5nf
    2O7h7ZUXrjtdQAY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeeigdduvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepufgvrghnucggucfmvghllhgvhicuoehsvggrnhhvkhdruggv
    vhesohhrvghgohhnthhrrggtkhhsrdhorhhgqeenucggtffrrghtthgvrhhnpeehkeffte
    eiudeiffelkeelvefftdelhfeitdeigeffleeufedvgfegvdefvedtteenucfkphepvdeg
    rddvtddrudegkedrgeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepshgvrghnvhhkrdguvghvsehorhgvghhonhhtrhgrtghkshdrohhrgh
X-ME-Proxy: <xmx:2XV3X8X_IYhwZCYv-ucGSFUEal8itu88cOv9aSMZmuP3Jf9WnqfZMA>
    <xmx:2XV3XwhRxGa4AqALiOFf86RAVhicZMSeTRnm24K5JSH5fWFuRBYNqQ>
    <xmx:2XV3X8B0BwJs9VxseOjHHiF8hZf3TAiu0qVTXMQ-Ydi9808zKlnvpw>
    <xmx:2XV3X-1EXd_GIaZF0HUXfgGpQqAvmnVEaKN8wo__4yt8fH750ByMxA>
Received: from arch-ashland-svkelley.hsd1.or.comcast.net (c-24-20-148-49.hsd1.or.comcast.net [24.20.148.49])
        by mail.messagingengine.com (Postfix) with ESMTPA id B985A3064686;
        Fri,  2 Oct 2020 14:47:51 -0400 (EDT)
From:   Sean V Kelley <seanvk.dev@oregontracks.org>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 01/14] PCI/RCEC: Add RCEC class code and extended capability
Date:   Fri,  2 Oct 2020 11:47:22 -0700
Message-Id: <20201002184735.1229220-2-seanvk.dev@oregontracks.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201002184735.1229220-1-seanvk.dev@oregontracks.org>
References: <20201002184735.1229220-1-seanvk.dev@oregontracks.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

A PCIe Root Complex Event Collector (RCEC) has the base class 0x08,
sub-class 0x07, and programming interface 0x00. Add the class code
0x0807 to identify RCEC devices and add the defines for the RCEC
Endpoint Association Extended Capability.

See PCI Express Base Specification, version 5.0-1, section "1.3.4
Root Complex Event Collector" and section "7.9.10 Root Complex
Event Collector Endpoint Association Extended Capability"

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/linux/pci_ids.h       | 1 +
 include/uapi/linux/pci_regs.h | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 1ab1e24bcbce..d8156a5dbee8 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -81,6 +81,7 @@
 #define PCI_CLASS_SYSTEM_RTC		0x0803
 #define PCI_CLASS_SYSTEM_PCI_HOTPLUG	0x0804
 #define PCI_CLASS_SYSTEM_SDHCI		0x0805
+#define PCI_CLASS_SYSTEM_RCEC		0x0807
 #define PCI_CLASS_SYSTEM_OTHER		0x0880
 
 #define PCI_BASE_CLASS_INPUT		0x09
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index f9701410d3b5..f335f65f65d6 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -828,6 +828,13 @@
 #define  PCI_PWR_CAP_BUDGET(x)	((x) & 1)	/* Included in system budget */
 #define PCI_EXT_CAP_PWR_SIZEOF	16
 
+/* Root Complex Event Collector Endpoint Association  */
+#define PCI_RCEC_RCIEP_BITMAP	4	/* Associated Bitmap for RCiEPs */
+#define PCI_RCEC_BUSN		8	/* RCEC Associated Bus Numbers */
+#define  PCI_RCEC_BUSN_REG_VER	0x02	/* Least capability version that BUSN present */
+#define  PCI_RCEC_BUSN_NEXT(x)	(((x) >> 8) & 0xff)
+#define  PCI_RCEC_BUSN_LAST(x)	(((x) >> 16) & 0xff)
+
 /* Vendor-Specific (VSEC, PCI_EXT_CAP_ID_VNDR) */
 #define PCI_VNDR_HEADER		4	/* Vendor-Specific Header */
 #define  PCI_VNDR_HEADER_ID(x)	((x) & 0xffff)
-- 
2.28.0

