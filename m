Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFF37E45C2
	for <lists+linux-pci@lfdr.de>; Tue,  7 Nov 2023 17:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235657AbjKGQSI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Nov 2023 11:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235560AbjKGQRZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Nov 2023 11:17:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60A27DBD;
        Tue,  7 Nov 2023 07:52:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2F3C433C9;
        Tue,  7 Nov 2023 15:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699372351;
        bh=xNizLpN7ywbUmlozKwPe6v+PA26m7PiS6OuQy83f0kw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d5c0a5WzIzBY6T0zWw5NGGGNhS7ZWKI+scqyuVzdGKLZL0NTtu7LTiZHYC/UgJ2oQ
         8zLz+t1CYzcB1M6Iz91iRS1ceSckHdczJ/F4qrDdP/SQl0qV7MGxropXa3ifUUz0R2
         UC1X8Y7twGFefWIZZhGbN1KxzRL5qgyuAsgNzEyi1XaOm08NgLS9rm3ac4TrL80+lB
         SHTrHRpqNBqWDA6APU/hT1m68bFjUi91WKaImcP3sgXiYuZ6gKThcmhqrsNQ0x6x58
         AHGsM4qKIORAPPo5FAUmKbLWAhE4VFAy/8eMsftx73o9fQsl9ff6aPsUwl2i8vxzfI
         ReY6npGPqu6yw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Nirmoy Das <nirmoy.das@amd.com>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 20/22] PCI: Use FIELD_GET() in Sapphire RX 5600 XT Pulse quirk
Date:   Tue,  7 Nov 2023 10:51:29 -0500
Message-ID: <20231107155146.3767610-20-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107155146.3767610-1-sashal@kernel.org>
References: <20231107155146.3767610-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.137
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

[ Upstream commit 04e82fa5951ca66495d7b05665eff673aa3852b4 ]

Use FIELD_GET() to remove dependences on the field position, i.e., the
shift value.  No functional change intended.

Separate because this isn't as trivial as the other FIELD_GET() changes.

See 907830b0fc9e ("PCI: Add a REBAR size quirk for Sapphire RX 5600 XT
Pulse")

Link: https://lore.kernel.org/r/20231010204436.1000644-3-helgaas@kernel.org
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Nirmoy Das <nirmoy.das@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 371ba983b4084..cc3f620b73bd7 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3649,14 +3649,14 @@ u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar)
 		return 0;
 
 	pci_read_config_dword(pdev, pos + PCI_REBAR_CAP, &cap);
-	cap &= PCI_REBAR_CAP_SIZES;
+	cap = FIELD_GET(PCI_REBAR_CAP_SIZES, cap);
 
 	/* Sapphire RX 5600 XT Pulse has an invalid cap dword for BAR 0 */
 	if (pdev->vendor == PCI_VENDOR_ID_ATI && pdev->device == 0x731f &&
-	    bar == 0 && cap == 0x7000)
-		cap = 0x3f000;
+	    bar == 0 && cap == 0x700)
+		return 0x3f00;
 
-	return cap >> 4;
+	return cap;
 }
 EXPORT_SYMBOL(pci_rebar_get_possible_sizes);
 
-- 
2.42.0

