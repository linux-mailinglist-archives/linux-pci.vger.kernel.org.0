Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0075EC5D5
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 16:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbiI0OUF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 10:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbiI0OTz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 10:19:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6157A9C7CF
        for <linux-pci@vger.kernel.org>; Tue, 27 Sep 2022 07:19:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67346B81C14
        for <linux-pci@vger.kernel.org>; Tue, 27 Sep 2022 14:19:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F230C43140;
        Tue, 27 Sep 2022 14:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664288379;
        bh=KM7YvgpO+UoAIHJk/hRytiOdqT/ZECH6OH4Q6FHzez0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=teEhsWgbobaikerL8AsyjDVebRRuy1OKMa5kaiXisqa9mzu1QiacchdRoOZuhGjXT
         0ZaM+sXG24taFwg+5ywuDKU2ai0vjZ1+jKfHdCLPJyKbNGZdS+4zffc2SFqfpjDr6F
         RNIG+RCqldF9J4JzWxekQjnP13/P/3QZuQZUIVOhS+LmTNpfpcSfSVHyu9f+XYrhE5
         u5nBUquKdflZ4ACu2X9bypC0yczwi5kOt5om2Ayqv/oTGoW+9BK0nzNi8qfjQNuZgM
         4ff7nImnC4i+1h7GqmnVrcI7EqpXXNAPUB2PGbwVeZu+OV2W2b5FO+kFabvXzmi9W/
         dIgmub4+ReuCw==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>, pali@kernel.org,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 04/10] arm64: dts: armada-3720-turris-mox: Define slot-power-limit-milliwatt for PCIe
Date:   Tue, 27 Sep 2022 16:19:20 +0200
Message-Id: <20220927141926.8895-5-kabel@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220927141926.8895-1-kabel@kernel.org>
References: <20220927141926.8895-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index ada164d423f3..5d2b221dbd96 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
@@ -136,6 +136,7 @@ &pcie0 {
 	pinctrl-0 = <&pcie_reset_pins &pcie_clkreq_pins>;
 	status = "okay";
 	reset-gpios = <&gpiosb 3 GPIO_ACTIVE_LOW>;
+	slot-power-limit-milliwatt = <10000>;
 	/*
 	 * U-Boot port for Turris Mox has a bug which always expects that "ranges" DT property
 	 * contains exactly 2 ranges with 3 (child) address cells, 2 (parent) address cells and
-- 
2.35.1

