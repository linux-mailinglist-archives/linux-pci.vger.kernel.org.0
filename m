Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C50A6281B41
	for <lists+linux-pci@lfdr.de>; Fri,  2 Oct 2020 20:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388317AbgJBS4k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Oct 2020 14:56:40 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33683 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388327AbgJBS4h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Oct 2020 14:56:37 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id EF05F5C013A;
        Fri,  2 Oct 2020 14:47:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 02 Oct 2020 14:47:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        oregontracks.org; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=U8/XHA7xYYbMasOe6r2wYXcREytGZ8ybKr2Q2zebr+Y=; b=Li57r
        0OhbtswFDkcCLTEduCGTemKqBCAOlw5X+oxlATYw0hjb5saFbC9dxxLyd9UH+75h
        zSYBU8x/JT7R1hbwjv4RMZcmjVZK9MzHiBLNNub79XcrP8BFZWzt1tlXsDT+oNMY
        F7llExjS795nieBkR6R+IcI4pmyQpqVyTgn5war5YTP+Uj4KwVTANW2uLSypuydj
        dZpirQCgkZ79JazfLY5c4q+fv9RQOOrBk2ETL9nzCwT/xwjQ+d0MRvUzEhEBJOv5
        UPS7aEKz6Ac6DMhNHHLMC6movGsQMzwQ+MG7Iv+CkJ3R8p50MN0Y+TxUXeAIyI0G
        NRfMZERubhNb/NkzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=U8/XHA7xYYbMasOe6r2wYXcREytGZ8ybKr2Q2zebr+Y=; b=QqFVurkq
        30yLnEpAem6izbTk/GXzSKnItlKf7cuiuP10UXahzxLHT95cIcTNOonOLz5wfWAz
        WivsLdAUaLnWXeIm6lNG14XzIdzZ90KMk9/mngtU/vbF+QCLD761X9t36eAPz97m
        VHcDqD9wF7ZJkQJPbOfBAu+/i+HymFXMQodOSRVb4KI1IWPuUlro/WkGpM/+ZbHc
        x4YL2pXQ7f/Bgz4rM4js6OkWkgZLBIYr2pgDYwrQh9FnQ+0K0/QTSD9vsfcrPTDw
        Ln8mHpfACnaXuLZIKFviPd4DY6IBLkUbg4GwtT8lJoEsiSspKaMgcA1igurxb/q1
        ID8SQwL9XLyW1Q==
X-ME-Sender: <xms:23V3X0adIFwO-QMs-7aBGRV88D3elbziUhZGkKkfzepKGxp4gejP2g>
    <xme:23V3X_b2rX-Knvh4FNdhr0CXmvTC1OyCX3ll8OZNXCbauZRqq8zDMGNhcLXlayyWB
    tsO9kRFKUtYaovP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeeigdduvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepufgvrghnucggucfmvghllhgvhicuoehsvggrnhhvkhdruggv
    vhesohhrvghgohhnthhrrggtkhhsrdhorhhgqeenucggtffrrghtthgvrhhnpeehkeffte
    eiudeiffelkeelvefftdelhfeitdeigeffleeufedvgfegvdefvedtteenucfkphepvdeg
    rddvtddrudegkedrgeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepshgvrghnvhhkrdguvghvsehorhgvghhonhhtrhgrtghkshdrohhrgh
X-ME-Proxy: <xmx:23V3X--CG59RpmnUq4P2IksxLbdQ-Y7tETM40nL-ns8mAfK5uzyAwg>
    <xmx:23V3X-rlkLEwDPWvjR1_hxTIzV_fZXVJnlShMqSvtaR-DHJBBf20uw>
    <xmx:23V3X_rkPeXGGzbuM_EiJN5pRzEWHmKUawCwKo5QmRxbtPSFcjSHig>
    <xmx:23V3X7Iq--CjeuTbSEaEWiUj5Zm7ikOqIkWHhB5ORFsL5ithOE6_ig>
Received: from arch-ashland-svkelley.hsd1.or.comcast.net (c-24-20-148-49.hsd1.or.comcast.net [24.20.148.49])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9F92E3064686;
        Fri,  2 Oct 2020 14:47:53 -0400 (EDT)
From:   Sean V Kelley <seanvk.dev@oregontracks.org>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v8 02/14] PCI/RCEC: Bind RCEC devices to the Root Port driver
Date:   Fri,  2 Oct 2020 11:47:23 -0700
Message-Id: <20201002184735.1229220-3-seanvk.dev@oregontracks.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201002184735.1229220-1-seanvk.dev@oregontracks.org>
References: <20201002184735.1229220-1-seanvk.dev@oregontracks.org>
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

