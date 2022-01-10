Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCE72488E50
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jan 2022 02:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238019AbiAJBvN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 Jan 2022 20:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238022AbiAJBvI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 Jan 2022 20:51:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B546C06173F
        for <linux-pci@vger.kernel.org>; Sun,  9 Jan 2022 17:51:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA3A860EC8
        for <linux-pci@vger.kernel.org>; Mon, 10 Jan 2022 01:51:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F30C36B09;
        Mon, 10 Jan 2022 01:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641779466;
        bh=U+5gdDzhlq4s8L5qxgT0t0ey+4zJ/M0bpWaixeVoTGQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UXtckyPnqxgD5x3fOSy28F8c5KEB4k4p9xyd7pNqJ++H6qoTGMhBLE1KQDwP3Qw7e
         Kujb4g/LGEDueEohCnx0OYZCW18fq96aR8T6wZBszjmMil+7oAgHie7SFhO9J/I6M1
         A/E7dUR5SedweRQWLgiXWv5MVsiajpQNFhw/IbC5ctB+NurrFOWE5jSH/YYdIcLhXl
         /CiRP7UKXaWUmHXMGFzUFOMEEEHjT0+QnnkWf/G8085LZINvcGDNMiBkyD1BfcoBlG
         TXsN5+Duk+ys253agg+7uosktiw6Q1WIe42Ll7HAl52OxqY3BQS6nXYp5EnrySwusk
         YyC+jvi23SX5g==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     pali@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 21/23] PCI: aardvark: Drop __maybe_unused from advk_pcie_disable_phy()
Date:   Mon, 10 Jan 2022 02:50:16 +0100
Message-Id: <20220110015018.26359-22-kabel@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220110015018.26359-1-kabel@kernel.org>
References: <20220110015018.26359-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This function is now always used in driver remove method, drop the
__maybe_unused attribute.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 0e3dcd584f7e..360e2e3b3aa6 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1612,7 +1612,7 @@ static int advk_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 		return of_irq_parse_and_map_pci(dev, slot, pin);
 }
 
-static void __maybe_unused advk_pcie_disable_phy(struct advk_pcie *pcie)
+static void advk_pcie_disable_phy(struct advk_pcie *pcie)
 {
 	phy_power_off(pcie->phy);
 	phy_exit(pcie->phy);
-- 
2.34.1

