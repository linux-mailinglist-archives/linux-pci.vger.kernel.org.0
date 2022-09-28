Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193205EDC86
	for <lists+linux-pci@lfdr.de>; Wed, 28 Sep 2022 14:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbiI1MZx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Sep 2022 08:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233468AbiI1MZw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Sep 2022 08:25:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F65E8E4E7;
        Wed, 28 Sep 2022 05:25:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4FB70B82038;
        Wed, 28 Sep 2022 12:25:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E0DC433C1;
        Wed, 28 Sep 2022 12:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664367949;
        bh=HxjRtE7qJ8SnB2Cpy1WN7fiG48wE2ef95Ior+9SMHi4=;
        h=From:To:Cc:Subject:Date:From;
        b=Gj8g8FWku3S4xd/aAMVTwd8KkXul7xp8os0OiiVAQPp6zUgyDZ1yO8uZxf+u62zCy
         KcLg0SlFxKpGmUTmm4iDmdSsqWBCBLEvC5yxtWgnrkVPSmHJsZDv+MhpkRPf+ETn12
         FZ4Yy9Wx2VfT/SJaM7Hyu5jfJHsqOkoBh5uHujOJflYbGI8wgQ2XUt2tmeACjF9tM/
         w1XYwZKey4RlFd1D+onFB6SsuCnU/aeb+zfArpNwLsRBeE0JIgooF4pU5bzMW4buue
         rNI8i41FWhxvfX4+FIOea1iCKey876bzV/3No+gPZfBJTfm0F93e1LCL2ZJ2BcFcX9
         90tYdOEdUIP1w==
Received: by pali.im (Postfix)
        id BFA207DE; Wed, 28 Sep 2022 14:25:45 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: ixp4xx: Use PCI_CONF1_ADDRESS() macro
Date:   Wed, 28 Sep 2022 14:25:39 +0200
Message-Id: <20220928122539.15116-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
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

Simplify pci-ixp4xx.c driver code and use new PCI_CONF1_ADDRESS() macro for
accessing PCI config space.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/controller/pci-ixp4xx.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pci-ixp4xx.c b/drivers/pci/controller/pci-ixp4xx.c
index 654ac4a82beb..c83b5ae0b017 100644
--- a/drivers/pci/controller/pci-ixp4xx.c
+++ b/drivers/pci/controller/pci-ixp4xx.c
@@ -188,12 +188,13 @@ static u32 ixp4xx_config_addr(u8 bus_num, u16 devfn, int where)
 	/* Root bus is always 0 in this hardware */
 	if (bus_num == 0) {
 		/* type 0 */
-		return BIT(32-PCI_SLOT(devfn)) | ((PCI_FUNC(devfn)) << 8) |
-			(where & ~3);
+		return (PCI_CONF1_ADDRESS(0, 0, PCI_FUNC(devfn), where) &
+			~PCI_CONF1_ENABLE) | BIT(32-PCI_SLOT(devfn));
 	} else {
 		/* type 1 */
-		return (bus_num << 16) | ((PCI_SLOT(devfn)) << 11) |
-			((PCI_FUNC(devfn)) << 8) | (where & ~3) | 1;
+		return (PCI_CONF1_ADDRESS(bus_num, PCI_SLOT(devfn),
+					  PCI_FUNC(devfn), where) &
+			~PCI_CONF1_ENABLE) | 1;
 	}
 }
 
-- 
2.20.1

