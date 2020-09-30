Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC4D327F49F
	for <lists+linux-pci@lfdr.de>; Wed, 30 Sep 2020 23:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731198AbgI3V6f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 17:58:35 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:44103 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728721AbgI3V6e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Sep 2020 17:58:34 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 2564CFAC;
        Wed, 30 Sep 2020 17:58:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 30 Sep 2020 17:58:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        oregontracks.org; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=60ObtFMRbOqSH+jpltMHZEFuEG9irVX3w3dTkwyG97g=; b=KChRX
        o87qb3qkryfcR3SowvOTcHHlGWMYbWMXwUhhBjzGu8FOeE+JynwlPNHy6hyGveub
        8YGLqaky2YYWN8/HJIez69b14fVmgG+sWUHwpvth7kQ62/QgzXHIisovIXMLBAdx
        ayuVqXelBfp6x2jZ2T0fihujHlFv5LFlxaxKkMQbXerGgv7FANr+coOPbgyiUJLM
        QJF+yAy9ZurGSfUrx/ln/a1KHF229Q377HXPAfk2+7Bmmv6tev05EH+enuCCQRh0
        8oV7UmZJdZeIi2BqnMmtKkXwD7cS2NND8CHnF7rS3HjC+xWe2PjDe5MAHa1lQAJ/
        GpQzlkOVOWmPd0iPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=60ObtFMRbOqSH+jpltMHZEFuEG9irVX3w3dTkwyG97g=; b=ezZNqi+p
        ifUiDwrl+QkIl5R3KaUth8q9ZotI/t1Yfq3gQh4/KxaPmhMKwxjAZRf9M5cSQyTc
        /aDssxEllOWtoPbpmjmA8h1yt3kkAaQWygE5R9j6d2LbMT5L6hayZ96xYaSGQeWN
        CadeD9sAg8h3erY7UVNUWzcrSXPbWnBBxYLnPjskiXIubF3OiU83pYM6N7kJFOcQ
        FIk+vinjnfTlKepdGxjN63ip6H2gQghnsp/Fz5T7JQq4aL4KSBfK4moI0C+V7yrT
        RtJQOygmXREHzAbahhzfrWzBopyeKVrPGs/hNoMzJwMIqIiNa073nCV4FpGdFBvL
        ArIiuOBS5Ty3uw==
X-ME-Sender: <xms:iP90X_itD6YVQml01Do2peUrPnRLsnA7E4nJfJrUKLyPRSeUINyipA>
    <xme:iP90X8D-j4PyJ-UBMkwNZfkdo4T2HgzRZOOxL8D719NYrxwxw4IPmRWpP0dgnmg-I
    CuGapZhPdFkIl8y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeefgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefuvggrnhcuggcumfgvlhhlvgihuceoshgvrghnvhhkrdguvghv
    sehorhgvghhonhhtrhgrtghkshdrohhrgheqnecuggftrfgrthhtvghrnhepheekffetie
    duieffleekleevffdtlefhiedtieegffelueefvdfggedvfeevtdetnecukfhppedvgedr
    vddtrddugeekrdegleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehsvggrnhhvkhdruggvvhesohhrvghgohhnthhrrggtkhhsrdhorhhg
X-ME-Proxy: <xmx:iP90X_FPkLNn1E0yHLoc-Fz_HgUjwZi9jlt5dphtv8M05Kk93G-bdQ>
    <xmx:iP90X8T7UxE1gFML-KkSZai2S7lvyNeO9d0ZYbwVSYOxyWrXst9xZA>
    <xmx:iP90X8wO6CFCE2jQSEsuDQVGBLpsYjLAhdgXULVx91qQaUDRg8ZRdQ>
    <xmx:iP90XzmBJMmK_R_RNYU5nOZUKK4ig4oVK4vEdVzg2h62W43vvo3X_A>
Received: from arch-ashland-svkelley.hsd1.or.comcast.net (c-24-20-148-49.hsd1.or.comcast.net [24.20.148.49])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0FC87328005E;
        Wed, 30 Sep 2020 17:58:30 -0400 (EDT)
From:   Sean V Kelley <seanvk.dev@oregontracks.org>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 01/13] PCI/RCEC: Add RCEC class code and extended capability
Date:   Wed, 30 Sep 2020 14:58:08 -0700
Message-Id: <20200930215820.1113353-2-seanvk.dev@oregontracks.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930215820.1113353-1-seanvk.dev@oregontracks.org>
References: <20200930215820.1113353-1-seanvk.dev@oregontracks.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

A PCIe Root Complex Event Collector(RCEC) has the base class 0x08,
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

