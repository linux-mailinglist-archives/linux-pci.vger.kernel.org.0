Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 006DB27F4A3
	for <lists+linux-pci@lfdr.de>; Wed, 30 Sep 2020 23:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730307AbgI3V6k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 17:58:40 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:57285 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731388AbgI3V6k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Sep 2020 17:58:40 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id AFE7EF94;
        Wed, 30 Sep 2020 17:58:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 30 Sep 2020 17:58:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        oregontracks.org; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=Gn46W4VynhyglZtjFBczR4/VCapNL9FoMNsNVdsQ9bM=; b=AEvK4
        XxvTIr2ew5kmTdcC741Vp5F2CC/uAQCqmcZY8L1Q+3YGKWNlO2BtnkIGdV+baOSc
        41GFcDQCEpms2vmx8hslLuN4iOYOkp9arV2WvBJ08axnJX84u9vTTIPPwhyfXPH8
        EPX1+7nFFX2a5x/f0NWS+Xn7nG5/2/WOdIlIJiov8lKkYTpZ4eQPvFjU7VYPtDfM
        eA7uy9EjggwoOMb4MR2yqZKiGiYURM5YLznPpGZPG9MFfpBtxAYFUn+6LaURAWbs
        D1LgaA8vRutcukneSplJdJk3s2KGgTg+v/CJ1PS1OXsGpf5ZJJxDnyDTuZ+OpGRc
        tpyulDxazLWrXZIZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=Gn46W4VynhyglZtjFBczR4/VCapNL9FoMNsNVdsQ9bM=; b=f79Kv/yJ
        txITnvaFX+znE4pGRKzAZyK4z3kW6Q+zAuKsNQ4yl8Y62DjNMnPWK09Jwe7nQjb8
        pUmBQR+ubwHXaMJNIxWbipwa1L650zxfYgIl16OVMQijor50jPqhJ9upwdP/XG1q
        I57M4RybjoHZw31Yx1Q4EENE57o76HAwf70vRX1lnM/3syzI0zHB0b3W4zrgIrOQ
        OOcCQ3bRdPHzQ5o5SCLbmjxUYdPixqTnOtHrt/nJaSBqjcoYP3eI0hND64BUjCaL
        OJr9FRLXASdCnCG1ZmOqungwRqPRyLVXXO70GD1Ct1EmWSwvPe64NCBCPrfaSvm0
        qRvJIm13YF45zw==
X-ME-Sender: <xms:jv90X-Uzf89ageUBj6Y0sBMYxTF2kko2p7i1MSRt5L4TwY52JvFpQA>
    <xme:jv90X6ny2layz6JgTnZSvJkvPQB3mWrtW6oKf9Bwy6eZYoaAcw2rs9DLP0Dw7yfAZ
    P0BzxELq607V7gu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeefgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefuvggrnhcuggcumfgvlhhlvgihuceoshgvrghnvhhkrdguvghv
    sehorhgvghhonhhtrhgrtghkshdrohhrgheqnecuggftrfgrthhtvghrnhepheekffetie
    duieffleekleevffdtlefhiedtieegffelueefvdfggedvfeevtdetnecukfhppedvgedr
    vddtrddugeekrdegleenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehsvggrnhhvkhdruggvvhesohhrvghgohhnthhrrggtkhhsrdhorhhg
X-ME-Proxy: <xmx:jv90XyaAaepTB234V4qM_delfOvKpfq2FCUqbDpr6I9wwsThAl-D-w>
    <xmx:jv90X1Ug-fMoEjfn3ijGGIffdZQjEvCGLrx-DGvNMyxc4NvkoN4Mgg>
    <xmx:jv90X4nmvnQZtCZtz5GzA1FVCYjJlKB1qnfgBUTC8JQcpSoLaQVi7Q>
    <xmx:jv90XyV5egpXlEDOXfoZMUXerZgA-sCGk4aHX3qc1QS59wrrH8E49Q>
Received: from arch-ashland-svkelley.hsd1.or.comcast.net (c-24-20-148-49.hsd1.or.comcast.net [24.20.148.49])
        by mail.messagingengine.com (Postfix) with ESMTPA id E0D443280063;
        Wed, 30 Sep 2020 17:58:36 -0400 (EDT)
From:   Sean V Kelley <seanvk.dev@oregontracks.org>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v7 05/13] PCI/ERR: Use "bridge" for clarity in pcie_do_recovery()
Date:   Wed, 30 Sep 2020 14:58:12 -0700
Message-Id: <20200930215820.1113353-6-seanvk.dev@oregontracks.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930215820.1113353-1-seanvk.dev@oregontracks.org>
References: <20200930215820.1113353-1-seanvk.dev@oregontracks.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sean V Kelley <sean.v.kelley@intel.com>

The term "dev" is being applied to root ports, switch
upstream ports, switch downstream ports, and the upstream
ports on endpoints. While endpoint upstream ports don't have
subordinate buses, a generic term such as "bridge" may be used
for something with a subordinate bus. The current conditional
logic in pcie_do_recovery() would also benefit from some
simplification with use of pci_upstream_bridge() in place of
dev->bus->self. Reverse the pcie_do_recovery() conditional logic
and replace use of "dev" with "bridge" for greater clarity.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
---
 drivers/pci/pcie/err.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 950612342f1c..c6922c099c76 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -152,16 +152,22 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
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
-- 
2.28.0

