Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42BF4BD105
	for <lists+linux-pci@lfdr.de>; Sun, 20 Feb 2022 20:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238446AbiBTTes (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 20 Feb 2022 14:34:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244650AbiBTTeq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 20 Feb 2022 14:34:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7264506C
        for <linux-pci@vger.kernel.org>; Sun, 20 Feb 2022 11:34:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5061CB80DC3
        for <linux-pci@vger.kernel.org>; Sun, 20 Feb 2022 19:34:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1342AC340F0;
        Sun, 20 Feb 2022 19:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645385662;
        bh=fFrammgIGWV3o2s10EDgmhBAtxm6N/iwx66psFgf3/c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OFsG1rvi7Ud98SMtfrjjGHm+F8zAAzQFEGe5acD/VwCuyis4pRfiZYrXe/BqV8tWC
         PhOyn9vw1U2HHOCHdS9d+wHORDmi9WLEA8OoLXEV8nJR6JnudHOEyphUuxda4CyPTD
         OmnsXTosfXwItDfJ1xzYClBla+k5JeqlLtBTIPGZ940GfzgXUi5n5w6doSQ6iMlRoo
         hdk5gQxNGTPYWcbKEsumC6i4uo/qOJhbchYLvKY9D9id7lEmVHRTYCqGUAZhz3JPwe
         a5FxxSnjrHzoXDtKc5JIaOJgz5ex8ZVOB0rG6MlFYvJGv1eDpYxbTeH7KleJv82cdM
         TS1MeOqk9rcFw==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Marc Zyngier <maz@kernel.org>, pali@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 13/18] arm64: dts: armada-3720-turris-mox: Define slot-power-limit-milliwatt for PCIe
Date:   Sun, 20 Feb 2022 20:33:41 +0100
Message-Id: <20220220193346.23789-14-kabel@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220220193346.23789-1-kabel@kernel.org>
References: <20220220193346.23789-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

PCIe Slot Power Limit on Turris Mox is 10W.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
index 04da07ae4420..6dca28d7f764 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
@@ -135,6 +135,7 @@ &pcie0 {
 	pinctrl-0 = <&pcie_reset_pins &pcie_clkreq_pins>;
 	status = "okay";
 	reset-gpios = <&gpiosb 3 GPIO_ACTIVE_LOW>;
+	slot-power-limit-milliwatt = <10000>;
 	/*
 	 * U-Boot port for Turris Mox has a bug which always expects that "ranges" DT property
 	 * contains exactly 2 ranges with 3 (child) address cells, 2 (parent) address cells and
-- 
2.34.1

