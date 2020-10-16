Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9C628FBE4
	for <lists+linux-pci@lfdr.de>; Fri, 16 Oct 2020 02:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733101AbgJPAMR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Oct 2020 20:12:17 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:50519 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733099AbgJPAMQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Oct 2020 20:12:16 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id D3118AD8;
        Thu, 15 Oct 2020 20:12:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 15 Oct 2020 20:12:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        oregontracks.org; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=bkw/lS8wGdIJjtilswIrasmXGD0yLnEJKxOlj/ljwcM=; b=FQN0/
        VZbETyf9jSrFJ11nilBUVPh4/vZXtqGaw9f1ugy1pznSU9EaqkxY3uAs4UfGtHQ5
        euAjh+J015aomvlmbAfJY1LtRYYysFEijsIUbxweR/1oxwufx22mJ55mawzS0cLs
        RwNBxx8SoOO+hSDcUgRKyFWtS73ER2ggdb/+VKnfF5L4BNhbDccOcOY1o32q5FHX
        5qzKlMHOd9nRNBYWmSwnSJZRDoyn5vCLNXiauJdlZYNJP40YA3oBuPZU/qcDfmvI
        ULmOUbk77HMSLdGGoUiEwu89mcVGlUSquNw92X4kV5+CLetsaix3MREqSAxHRaio
        /GsPq40WMqWOOjhPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=bkw/lS8wGdIJjtilswIrasmXGD0yLnEJKxOlj/ljwcM=; b=EyMhReCq
        rX3kHFsVQWxI/kS9P45q8p7BstwGOoKgSE2Ta2iZfDIVksz5pTqRZ5kutTHhvtYg
        1/wtgO4mL/a5JpmcmHF+ldomAG19NPD/qhbN2nW0ESe+L7L7/iA99bVdPdIuZI9U
        vNkikiSN1VjYr389L5qO+yTMPH+0IlutSBQkrd6xnsTw5COnRbPHU5yx11rZ0kQg
        REkKxaU3uV5ThziRtaZC6WKq+XNne0gB2rS2vq2jdd+LRQpQn8Aq4y5A4DGWngIc
        DXmKhF1le/TRwHnIvOgYT+HgWDaajdxpSth8rCjw34uu/NSlBtiJpF0cAUp7eXNv
        xcZVELdRcNKdPA==
X-ME-Sender: <xms:X-WIX3Bz12Bfo833VSLTIV4kX_Cz0lIMzq34R8GV141hjfagHHhJyQ>
    <xme:X-WIX9jiqKDIHUXTZEXl-Uh89up9iu1IbaAhrqUEmr-MoXajwmlu-yG0fzg3sVLDI
    q5ycqaQcnSgcitp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrieeggdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefuvggrnhcuggcumfgvlhhlvgihuceoshgvrghnvhhkrdguvghv
    sehorhgvghhonhhtrhgrtghkshdrohhrgheqnecuggftrfgrthhtvghrnhepkefggeektd
    dttdeuffffjeeihfetfffghfdugefhvdeuheeuudelheegleevheefnecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghenucfkphepvdegrddvtddrudegkedrgeelnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgvrghnvhhkrdguvghv
    sehorhgvghhonhhtrhgrtghkshdrohhrgh
X-ME-Proxy: <xmx:X-WIXyn-NorAew1XFe9mu1k-Tx1Y4H5yY6yLsJ2JMs4kZnMcKpS_1w>
    <xmx:X-WIX5x5cmLCe9nKVJ1frNN2fc8KJo8S8hGlMtu_TYhM_6RlSK6TDw>
    <xmx:X-WIX8SzE2QbUk7WR1W7IHsIyyz_eZlPlF1QA639ivz9SbJdEt1aXQ>
    <xmx:X-WIX7GUyD83tPoogRWsajmTqYj5wT1ftR_ImI0v943HW2mtzJAwMQ>
Received: from arch-ashland-svkelley.hsd1.or.comcast.net (c-24-20-148-49.hsd1.or.comcast.net [24.20.148.49])
        by mail.messagingengine.com (Postfix) with ESMTPA id EFC8C3064683;
        Thu, 15 Oct 2020 20:12:13 -0400 (EDT)
From:   Sean V Kelley <seanvk.dev@oregontracks.org>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 01/15] PCI/RCEC: Add RCEC class code and extended capability
Date:   Thu, 15 Oct 2020 17:10:59 -0700
Message-Id: <20201016001113.2301761-2-seanvk.dev@oregontracks.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201016001113.2301761-1-seanvk.dev@oregontracks.org>
References: <20201016001113.2301761-1-seanvk.dev@oregontracks.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

A PCIe Root Complex Event Collector (RCEC) has base class 0x08, sub-class
0x07, and programming interface 0x00.  Add the class code 0x0807 to
identify RCEC devices and add #defines for the RCEC Endpoint Association
Extended Capability.

See PCIe r5.0, sec 1.3.4 ("Root Complex Event Collector") and sec 7.9.10
("Root Complex Event Collector Endpoint Association Extended Capability").

Link: https://lore.kernel.org/r/20201002184735.1229220-2-seanvk.dev@oregontracks.org
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
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
index f9701410d3b5..f6475a9e63d8 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -828,6 +828,13 @@
 #define  PCI_PWR_CAP_BUDGET(x)	((x) & 1)	/* Included in system budget */
 #define PCI_EXT_CAP_PWR_SIZEOF	16
 
+/* Root Complex Event Collector Endpoint Association  */
+#define PCI_RCEC_RCIEP_BITMAP	4	/* Associated Bitmap for RCiEPs */
+#define PCI_RCEC_BUSN		8	/* RCEC Associated Bus Numbers */
+#define  PCI_RCEC_BUSN_REG_VER	0x02	/* Least version with BUSN present */
+#define  PCI_RCEC_BUSN_NEXT(x)	(((x) >> 8) & 0xff)
+#define  PCI_RCEC_BUSN_LAST(x)	(((x) >> 16) & 0xff)
+
 /* Vendor-Specific (VSEC, PCI_EXT_CAP_ID_VNDR) */
 #define PCI_VNDR_HEADER		4	/* Vendor-Specific Header */
 #define  PCI_VNDR_HEADER_ID(x)	((x) & 0xffff)
-- 
2.28.0

