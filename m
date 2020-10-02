Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C41CD281B3C
	for <lists+linux-pci@lfdr.de>; Fri,  2 Oct 2020 20:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388291AbgJBS4i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Oct 2020 14:56:38 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:41493 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387935AbgJBS4h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Oct 2020 14:56:37 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 648065C0140;
        Fri,  2 Oct 2020 14:48:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 02 Oct 2020 14:48:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        oregontracks.org; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=iOxe6nk3a+qZ/VViUWD1V7pp14CzJsfaUhKJXMIDY9k=; b=gbV/8
        SiA5dPFk866rra6hFcW4UP135XkQgbx5zbDRvraYEqtkFlHICGU6Jux4IOcP16Da
        IiTOqJnkHhMEu2S6fhtSRhcuHzPxtvLcbxV8GpgIyt31DyWD/J5qWkv8p+BPc5sB
        5vAaPqlq0i56eY0Md19eo3Xo/Yo2KZjzumOiPCCP2/f2meeComknCXj8JM8XMdAi
        1GbTkp1O7ymOBsoU5nVlfR//xNX01kRviLuRKUOc7WHScncPPw9XDMWOzCxHHMHy
        91SkoXkkPlY5wRdIadlHXjBIueCTVQEpFabcHO5Kn6tRI4c5uuqSSmwQBLaoIRnS
        6Rm9KL/4X7TaXwCkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=iOxe6nk3a+qZ/VViUWD1V7pp14CzJsfaUhKJXMIDY9k=; b=Xj8STda4
        C+BOICJaIS9XxU5bJ6+QkhRADHcp1sobzgCRnmBVmxJk/+jeT7sTxiLKpEGpWATH
        SV14KLxiFvrCd28d0zS7wkrn6kR/yjPeUomcbo3Pw+bGflEl9v4/bIlJ/NOonGe9
        qwv8lOeUWh1mZkUzXTFeKv0DgBWyJg8UpJ0hM3FPhpIeFXD91PxGzvdpXh92Fjwm
        rNaYTYvlmLtN2C9oz6mWAPW6pCsxDyGHanJ3IglIXZpVIqLHBixM37/6pxFdCsQg
        86K4fMbTb6BZAwjyMeWhSy+J334m1tbnnKMcz6gFFX5fghTRnDtF4htqpU4TmQ8B
        TLNKxEJ6UcNl3Q==
X-ME-Sender: <xms:4XV3X4oAlKy57KJX-X3fMfXhrRTCAjHLbZAMkV5bjF07AiAwh2a8lw>
    <xme:4XV3X-pSruZtRCWY9J5IpdZkca_zVgRmgHGVgKFlVJIEluJsD8mysniH-aDOpknkx
    5KJftucMEffcUKk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeeigdduvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepufgvrghnucggucfmvghllhgvhicuoehsvggrnhhvkhdruggv
    vhesohhrvghgohhnthhrrggtkhhsrdhorhhgqeenucggtffrrghtthgvrhhnpeehkeffte
    eiudeiffelkeelvefftdelhfeitdeigeffleeufedvgfegvdefvedtteenucfkphepvdeg
    rddvtddrudegkedrgeelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepshgvrghnvhhkrdguvghvsehorhgvghhonhhtrhgrtghkshdrohhrgh
X-ME-Proxy: <xmx:4XV3X9PhzykeAOHL2ikLABEz-cx_DbC5n9w3NcGkaBQy0u1kOdFD_g>
    <xmx:4XV3X_4kzv8bpn2JUXscvdEWcz8qW5Z1rw_9RnvtM2EPoJHBhLe6bg>
    <xmx:4XV3X364bboPRxj579jCMjucPzThjALA5YAE3qwPgDmoj5ojotDn8A>
    <xmx:4XV3X6ZrWjNbZMYUSM4zqRh5OMbUfsoaFPtKhwy3A3kQCyi4BaykBQ>
Received: from arch-ashland-svkelley.hsd1.or.comcast.net (c-24-20-148-49.hsd1.or.comcast.net [24.20.148.49])
        by mail.messagingengine.com (Postfix) with ESMTPA id E1F083064686;
        Fri,  2 Oct 2020 14:47:59 -0400 (EDT)
From:   Sean V Kelley <seanvk.dev@oregontracks.org>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v8 05/14] PCI/ERR: Use "bridge" for clarity in pcie_do_recovery()
Date:   Fri,  2 Oct 2020 11:47:26 -0700
Message-Id: <20201002184735.1229220-6-seanvk.dev@oregontracks.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201002184735.1229220-1-seanvk.dev@oregontracks.org>
References: <20201002184735.1229220-1-seanvk.dev@oregontracks.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sean V Kelley <sean.v.kelley@intel.com>

A generic term such as "bridge" may be used for something with
a subordinate bus. The mix of ports would benefit from a use of
the term. Further clarity can be had in pcie_do_recovery()
with use of pci_upstream_bridge() in place of dev->bus->self.
Reverse the pcie_do_recovery() conditional logic and replace
use of "dev" with "bridge".

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/pci/pcie/err.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 950612342f1c..e68ea5243ff2 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -152,20 +152,26 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 {
 	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
 	struct pci_bus *bus;
+	struct pci_dev *bridge;
+	int type;
 
 	/*
-	 * Error recovery runs on all subordinates of the first downstream port.
-	 * If the downstream port detected the error, it is cleared at the end.
+	 * Error recovery runs on all subordinates of the first downstream
+	 * bridge. If the downstream bridge detected the error, it is
+	 * cleared at the end.
 	 */
-	if (!(pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
-	      pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM))
-		dev = dev->bus->self;
-	bus = dev->subordinate;
-
+	type = pci_pcie_type(dev);
+	if (type == PCI_EXP_TYPE_ROOT_PORT ||
+	    type == PCI_EXP_TYPE_DOWNSTREAM)
+		bridge = dev;
+	else
+		bridge = pci_upstream_bridge(dev);
+
+	bus = bridge->subordinate;
 	pci_dbg(dev, "broadcast error_detected message\n");
 	if (state == pci_channel_io_frozen) {
 		pci_walk_bus(bus, report_frozen_detected, &status);
-		status = reset_subordinate_device(dev);
+		status = reset_subordinate_device(bridge);
 		if (status != PCI_ERS_RESULT_RECOVERED) {
 			pci_warn(dev, "subordinate device reset failed\n");
 			goto failed;
@@ -197,9 +203,9 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	pci_dbg(dev, "broadcast resume message\n");
 	pci_walk_bus(bus, report_resume, &status);
 
-	if (pcie_aer_is_native(dev))
-		pcie_clear_device_status(dev);
-	pci_aer_clear_nonfatal_status(dev);
+	if (pcie_aer_is_native(bridge))
+		pcie_clear_device_status(bridge);
+	pci_aer_clear_nonfatal_status(bridge);
 	pci_info(dev, "device recovery successful\n");
 	return status;
 
-- 
2.28.0

