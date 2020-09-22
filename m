Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D86C274B81
	for <lists+linux-pci@lfdr.de>; Tue, 22 Sep 2020 23:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgIVVt3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Sep 2020 17:49:29 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:38329 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726563AbgIVVt3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Sep 2020 17:49:29 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 6544C5C006C;
        Tue, 22 Sep 2020 17:49:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 22 Sep 2020 17:49:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        oregontracks.org; h=from:to:cc:subject:date:message-id
        :mime-version:content-transfer-encoding; s=fm1; bh=60ObtFMRbOqSH
        +jpltMHZEFuEG9irVX3w3dTkwyG97g=; b=BM0LsxjTDUQHhXibNNn5smtgebdRD
        ylXJ6DeqJ3E1iznqU7XnxD14IpMCSELoVLJabC6f0yIslrCBKWkRwrU+TUaiMCEq
        e+PjphFwoPwFxeX4v+3Ee3/32nwGQgAGe/Vtn/vdvEZDwbglf5Y9ZFEmyQTaT8HE
        jWRIJU7uqmDKy7E0qg9mFzlKLbx+aGLdZ003CYltRAgLlvjtKO0+dRzAr48q5APC
        aYZeb0ldnTP+4mNnHFuZVlS196nDbv+WVhW1gOqNLnF5UQwv8ZsB01Z8RLq3I0bE
        8NrfZB0cL3q9ZxNvWoj9E+yHtoaF/OJKcDLexvyQ6eVk1rcm2003XicKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=60ObtFMRbOqSH+jpl
        tMHZEFuEG9irVX3w3dTkwyG97g=; b=bOYuflQ1nWHb4fNfHHMI7swDPXajgX1dY
        ihW4CCERtwUHqMqSu5eGTW6tNvpJ4WPvQsxjtrW1lCo0E22TwAU42eYPe1flbJVe
        Jt/Nf3EgUZtw+5MRhdVKI8+WIFvHL/YnMvaycu2w6vAUcW+Y5Lf+9ZX1ZUysiNCG
        tVsZQYQPCamr/ODWJiqLmoUqano8GookbrSxm3uo08/aq+RnuShLLN4s2oB9zV/P
        h1l14yliwG6fPD1sgk0BR7vDxulvsUJiGRtae6yfpkJGD64/j1GGDsliWH7q5oku
        zRoiAPMWn/r3x4B7L7748hAzNjXZYnDMjtwWUzavEN2QNFZvaPVLw==
X-ME-Sender: <xms:aHFqX4ryTXH0Ycqildsf1KOPecaPDD5DSvFyqcUEsDe-PN-7dBTDWQ>
    <xme:aHFqX-pcRtHKtOWICCPVzXdhlhf4VwJUArCFVHNeB3UbRQ2nVbvtbg3TKElpTSXOo
    V64btHwUsg0TvHF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudehgddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpefuvggrnhcuggcumfgvlhhlvgihuceoshgvrghnvhhkrdguvghvseho
    rhgvghhonhhtrhgrtghkshdrohhrgheqnecuggftrfgrthhtvghrnhepffeltdeuiefhhe
    elhfegfeehjeevgfetvefhfeehfffhueduvdduffefkeetiedunecukfhppedvgedrvddt
    rddugeekrdegleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsvggrnhhvkhdruggvvhesohhrvghgohhnthhrrggtkhhsrdhorhhg
X-ME-Proxy: <xmx:aHFqX9MjiN2B37zaPD0HdACXV0aCoOXYOXzdsFDrgdTxFtj2xFAAiw>
    <xmx:aHFqX_4-jugSxtTmiFK8-1UWo6XeKS4EiR3lZQv6RKlBAe-w_nrXSg>
    <xmx:aHFqX37KlGMayYzKMVq3dBGMqEiRctkEgglr3j7E8hcJhVVI6M8peg>
    <xmx:aHFqX0sOpbKRTqBbHt_4o5ag9E98LKuIUzxjAH5B-P624H6t0O3FlQ>
Received: from arch-ashland-svkelley.hsd1.or.comcast.net (c-24-20-148-49.hsd1.or.comcast.net [24.20.148.49])
        by mail.messagingengine.com (Postfix) with ESMTPA id 968843280060;
        Tue, 22 Sep 2020 17:49:26 -0400 (EDT)
From:   Sean V Kelley <seanvk.dev@oregontracks.org>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 01/10] PCI/RCEC: Add RCEC class code and extended capability
Date:   Tue, 22 Sep 2020 14:49:23 -0700
Message-Id: <20200922214923.109905-1-seanvk.dev@oregontracks.org>
X-Mailer: git-send-email 2.28.0
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

