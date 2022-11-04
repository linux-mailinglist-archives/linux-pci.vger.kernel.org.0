Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3FD61A2C1
	for <lists+linux-pci@lfdr.de>; Fri,  4 Nov 2022 21:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiKDUyd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Nov 2022 16:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiKDUya (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Nov 2022 16:54:30 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DA11838E;
        Fri,  4 Nov 2022 13:54:28 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id AC3BF5C009A;
        Fri,  4 Nov 2022 16:54:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 04 Nov 2022 16:54:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com.au;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1667595267; x=
        1667681667; bh=lJsdPrNmT8+mD6s1iPhVQ7qYCLCp7h1cNeMluNK4XT4=; b=E
        O6eOBOkVKmYCBEl3HdGVUheKJcMVNMqYzWzy5OoM9/f421xFhaEPsDGf/FfYoleT
        7COY6kt4OFxYjJibQB4KLrvM8CZk/hO5E1L40EIk0cKqU2N8SZYf+dvX8a5dbScz
        JZlF1KyLASTAtMIXvMXk2eCS/gSF+F3SdICdbNJ4PxtdCstb3IPO3rKc8oaNoomM
        TBA8OUhDTIKZjN9Hbty1K4YAno1OA1/zbMpVxsFnwyxAvLHP0Sy54VMVZvaaa/Wn
        4f+ICKW77WDO7dduPDsPWzr/5RpyDeI0bziRHhtiy3g/9Elx2vQIrnCx/iAytstM
        0oppi6LGjUm3pmdj5zFVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1667595267; x=1667681667; bh=lJsdPrNmT8+mD
        6s1iPhVQ7qYCLCp7h1cNeMluNK4XT4=; b=e9E70KT7Ua6gQif8RAr7lQ1yJk4Xh
        wmbs5nxg48WLha1z/Yg0E+DgebkVhvuwPm/WlXnLQUZYBuJAbtyBnlI+eV6JlL1d
        qjyN4X0IqNrRhMFvIbKP+z1zIRtzYWMLzOFMUG4wme0lm1wS9KntQWzwkor4zvgg
        sQNKb60tUEmBUaULO7sPqordbnWztqG/FPNedCUNIM/I0/ryBDYTH2CvKb5+9Z2K
        fuFLx+YYsF8Hquhl+bSvahrc1RMNzEIaJFJtgdoPEJOjOUlA2T55vkYJyf+ELMXl
        BEbRHaRPrjWKlnZooyP/2sb6AnsWECNzIZP1Q7hGD2BdfNkYTD6qvL4JA==
X-ME-Sender: <xms:A3xlYxZXUuaLVPp_MHbir-9adoGbzmuVXBfKpN_emXnAX7sUeMUe7Q>
    <xme:A3xlY4b0iq_W8WSZp9QClKVKWsmJV78H5OP8WvDVHKFBJbM0RtoL-0S8KA5kUdGse
    vtc34XCv8kY3cKRbA>
X-ME-Received: <xmr:A3xlYz_ZwizbfJ1pKI_z4B9iaGvEr2AD_OpvMGCEpCXoenKRGTc2mBUrvGi6Huww1_V1mAGIsPdGUtP5kAMd-dTFliLS9tLM3RTMArgjKpSZwAeppYpZPvvB_BZjKa05>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvddugddufeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhohhhn
    ucfvhhhomhhsohhnuceoghhithesjhhohhhnthhhohhmshhonhdrfhgrshhtmhgrihhlrd
    gtohhmrdgruheqnecuggftrfgrthhtvghrnhepffetgedttdefvddvhfeifedvvdeuveeg
    hedvieffudegudduudehudfhjeekhfevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihht
    sehjohhhnhhthhhomhhsohhnrdhfrghsthhmrghilhdrtghomhdrrghu
X-ME-Proxy: <xmx:A3xlY_qFHEtu_bOuWS3h0ctm5bTyOxhlzJIYUdSFNM1DuRRUBz_LCg>
    <xmx:A3xlY8prPyaIrMN2K_wfvj5u6hZN4P9nLpqaG2MPuUQkwCPNaTiWSQ>
    <xmx:A3xlY1T99k6CDvRHwmwcwR2X4pxU0mv_1BDGaQEU7WM9d2rwyo08Kw>
    <xmx:A3xlYxQNV4MOzYkJ0zZFAWDTv61c2i1f-IhApDDFkSllKDXqY9MaFw>
Feedback-ID: ic081425d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Nov 2022 16:54:23 -0400 (EDT)
From:   John Thomson <git@johnthomson.fastmail.com.au>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
Cc:     linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        John Thomson <git@johnthomson.fastmail.com.au>
Subject: [PATCH 1/2] phy: ralink: mt7621-pci: add sentinel to quirks table
Date:   Sat,  5 Nov 2022 06:52:41 +1000
Message-Id: <20221104205242.3440388-2-git@johnthomson.fastmail.com.au>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221104205242.3440388-1-git@johnthomson.fastmail.com.au>
References: <20221104205242.3440388-1-git@johnthomson.fastmail.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

With mt7621 soc_dev_attr fixed to register the soc as a device,
kernel will experience an oops in soc_device_match_attr

This quirk test was introduced in the staging driver in
commit 9445ccb3714c ("staging: mt7621-pci-phy: add quirks for 'E2'
revision using 'soc_device_attribute'"). The staging driver was removed,
and later re-added in commit d87da32372a0 ("phy: ralink: Add PHY driver
for MT7621 PCIe PHY") for kernel 5.11

Link: https://lore.kernel.org/lkml/26ebbed1-0fe9-4af9-8466-65f841d0b382@app.fastmail.com
Fixes: d87da32372a0 ("phy: ralink: Add PHY driver for MT7621 PCIe PHY")
Signed-off-by: John Thomson <git@johnthomson.fastmail.com.au>
---
 drivers/phy/ralink/phy-mt7621-pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/ralink/phy-mt7621-pci.c b/drivers/phy/ralink/phy-mt7621-pci.c
index 5e6530f545b5..85888ab2d307 100644
--- a/drivers/phy/ralink/phy-mt7621-pci.c
+++ b/drivers/phy/ralink/phy-mt7621-pci.c
@@ -280,7 +280,8 @@ static struct phy *mt7621_pcie_phy_of_xlate(struct device *dev,
 }
 
 static const struct soc_device_attribute mt7621_pci_quirks_match[] = {
-	{ .soc_id = "mt7621", .revision = "E2" }
+	{ .soc_id = "mt7621", .revision = "E2" },
+	{ /* sentinel */ }
 };
 
 static const struct regmap_config mt7621_pci_phy_regmap_config = {
-- 
2.37.2

