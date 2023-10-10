Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4887C41C5
	for <lists+linux-pci@lfdr.de>; Tue, 10 Oct 2023 22:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343715AbjJJUot (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Oct 2023 16:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343770AbjJJUos (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Oct 2023 16:44:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFF294;
        Tue, 10 Oct 2023 13:44:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49463C433C7;
        Tue, 10 Oct 2023 20:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696970687;
        bh=oX9EO48DOGu50ALvL0FYfxc5TiflrGjNP6ANRfmI9nU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dcp3Ta1ofBM/0hVvBvQbyhk73p/llhkdXpQaTl1ZjbgsdgaaoEmhzgGWOnkhv6Qe5
         Xer7iep60LI6bO6zzWTJ34UHf8Fk15BdG+WOEEO7IA13mVNGzSF8kUlhHh/agRKMuq
         NS26PXFgBE3R4TDGJ0qvUynINjbx3Zo/Va0BTbruZ7kCZ3vS5bVq7R5nBJA8dW//Wo
         Vnnu5lskieJpGXUYtWzQiejyyaUc37rHZ9AaD29ewJjV4QAfe0bAjlwLMe/BhCYpV5
         V55Ks1gx7/eD/5s/KTOFbUsKnbzkPCHG78UlYNsDCDybtqO+/AyRaVf+67Kf/FQDEN
         TG3LDBJAHorAg==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Nirmoy Das <nirmoy.das@amd.com>
Subject: [PATCH 02/10] PCI: Use FIELD_GET() in Sapphire RX 5600 XT Pulse quirk
Date:   Tue, 10 Oct 2023 15:44:28 -0500
Message-Id: <20231010204436.1000644-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010204436.1000644-1-helgaas@kernel.org>
References: <20231010204436.1000644-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Use FIELD_GET() to remove dependences on the field position, i.e., the
shift value.  No functional change intended.

Separate because this isn't as trivial as the other FIELD_GET() changes.

See 907830b0fc9e ("PCI: Add a REBAR size quirk for Sapphire RX 5600 XT
Pulse")

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/pci/pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 848c9ee65d7f..5dc6e7cdfb71 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3751,14 +3751,14 @@ u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar)
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
2.34.1

