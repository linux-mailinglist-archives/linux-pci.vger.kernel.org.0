Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D491E7E43FC
	for <lists+linux-pci@lfdr.de>; Tue,  7 Nov 2023 16:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344189AbjKGPtL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Nov 2023 10:49:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344241AbjKGPsm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Nov 2023 10:48:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014BD1715;
        Tue,  7 Nov 2023 07:48:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BFE2C433C8;
        Tue,  7 Nov 2023 15:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699372083;
        bh=eujyiJtdKwfFERNUN2NAwj4NBo/kOfjVry/q0OZUZuE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ca6SacCiT1PUUlyvRGcf4yyDVZAH/Nj2t7eShVDTIzN7xNvAqi0h4HR2+OixXpKw2
         36kMFJy8YMwZKspCtnFQPdgsk93EdlbusmGlsQJe2wQSStyqVrocgKWeoS4aoDSbKo
         lvVDJkscbbHjm2QWBpZSahOy78CVopHXfhSKZY5cU+I9Q0An/yNBP7Li/3eNYYOiaP
         cTkVm/dhuwWB/esmYiB+H4aCArEN2JNgS16Af32Zascc0ErPiqbgL1yXCqGZBy6lrK
         4jUXYOB059+2n8rhQAa90eYoyL2W7JIfuKfSd5N+R9Hs8QZXxrUsf17EDogdfq3CeL
         lW7ma2AxKb7KQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Nirmoy Das <nirmoy.das@amd.com>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 31/36] PCI: Use FIELD_GET() in Sapphire RX 5600 XT Pulse quirk
Date:   Tue,  7 Nov 2023 10:46:13 -0500
Message-ID: <20231107154654.3765336-31-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107154654.3765336-1-sashal@kernel.org>
References: <20231107154654.3765336-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6
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
index ec43ebfc24a5d..a607f277ccf10 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3755,14 +3755,14 @@ u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar)
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

