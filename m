Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A20D274B6E
	for <lists+linux-pci@lfdr.de>; Tue, 22 Sep 2020 23:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgIVVqM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Sep 2020 17:46:12 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:43199 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726656AbgIVVpu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Sep 2020 17:45:50 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id F11735C0163;
        Tue, 22 Sep 2020 17:39:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 22 Sep 2020 17:39:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        oregontracks.org; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=60ObtFMRbOqSH+jpltMHZEFuEG9irVX3w3dTkwyG97g=; b=cmK4z
        AXLwMVwaQMT457gBc46n3kyZrv03p3qRJuX9F7CxpeSDZHKx21PfogkhyPEmUIja
        bGMzj2qAW6uk/gzq6ih7yiNxGqdjGi94M/3D78wM0gEp90KmHNjYz0bOL5sWTeIP
        C5ifj3IMCtDVx40C3Nltf5JnCvUeOhXGUOs6TWWeo5R5CYZ7kXLXqIdXxWXgvVsz
        3sWoBhInW98RywKZ0/f1gCeUJDeLvejKN9NhruxGr+hGiLHbmwTxrWHOFhWT0pG4
        XFrznyuWZkVaw6KjWsEGhK7A0nR0DoY2Chvri/Pfnms2FT21AbrvQtqzNq87TDVR
        Dw/m12/ZRSrk7DIIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=60ObtFMRbOqSH+jpltMHZEFuEG9irVX3w3dTkwyG97g=; b=kSqwx3NY
        UkVvJrtAaOixDTM/CecThZn+NxIN+nY8PV6235tdb+89Atku0oXwDgLzAGCvyPiI
        VX+0jSwOImJv4ihlgKY9xNq5QYDEK6/JG2jY9e+Bh1KiOixwH7dsSxu+kmfQ9vk8
        1L+11UD4Q7xWZNO3I4Sc2Z9OHffbbe3gWH2xx1++637X5WOBcqQjkYo9zSlHoFDj
        cMpxEBWV3ylz44K9EJoV939Y0sNn7HIoM4Q2HP5kg4Ke+i2z7eM3EHuMY7OtAnGi
        UA+Cg1ea9QUrXGefwt1W7w5qlsjjjAdf260IJGFqn/wNJSYnbBtrr4OT9BsNJ1SS
        P/B+Kud56IBdYQ==
X-ME-Sender: <xms:-m5qXyf-wjns22LkZoCXEGoqJGQlYbEF7aKb_deHNvmsLsTV53hgxg>
    <xme:-m5qX8NcRy6CR2h0ULgWu5pNUKwviG3iaOJ0mdcwkolc-4PmHkL8xj8lFf98YG0aA
    cCumO4eZq6Z9SZc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeggdduieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepufgvrghnucggucfmvghllhgvhicuoehsvggrnhhvkhdruggv
    vhesohhrvghgohhnthhrrggtkhhsrdhorhhgqeenucggtffrrghtthgvrhhnpeehkeffte
    eiudeiffelkeelvefftdelhfeitdeigeffleeufedvgfegvdefvedtteenucfkphepvdeg
    rddvtddrudegkedrgeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepshgvrghnvhhkrdguvghvsehorhgvghhonhhtrhgrtghkshdrohhrgh
X-ME-Proxy: <xmx:-m5qXzgJ3mbiJSjgSYmmoq-dUkrM-op6HXXsHA0Hhl2k9g1UJdRWtQ>
    <xmx:-m5qX_-oVZ1jQyjqLEbudtILZSGqrAVaPC9WhRIoL8FS1tR7mJYOYA>
    <xmx:-m5qX-vSpRw3O1b3bYEZpHpr02LvcXgvhJM-Q3hyOyjAgxZ2emosKA>
    <xmx:-m5qXyg7mKUH2H1qnxqXlXrj55fvORPcVkkNrwd_NXLhmuo8jrsKjQ>
Received: from arch-ashland-svkelley.hsd1.or.comcast.net (c-24-20-148-49.hsd1.or.comcast.net [24.20.148.49])
        by mail.messagingengine.com (Postfix) with ESMTPA id AD619306467D;
        Tue, 22 Sep 2020 17:39:05 -0400 (EDT)
From:   Sean V Kelley <seanvk.dev@oregontracks.org>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 01/10] PCI/RCEC: Add RCEC class code and extended capability
Date:   Tue, 22 Sep 2020 14:38:50 -0700
Message-Id: <20200922213859.108826-2-seanvk.dev@oregontracks.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922213859.108826-1-seanvk.dev@oregontracks.org>
References: <20200922213859.108826-1-seanvk.dev@oregontracks.org>
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

