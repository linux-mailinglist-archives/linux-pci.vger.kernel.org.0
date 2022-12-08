Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482E66475E7
	for <lists+linux-pci@lfdr.de>; Thu,  8 Dec 2022 20:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiLHTD4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Dec 2022 14:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiLHTDy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Dec 2022 14:03:54 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B108F08C;
        Thu,  8 Dec 2022 11:03:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6A2BBCE26AE;
        Thu,  8 Dec 2022 19:03:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 620F3C433D2;
        Thu,  8 Dec 2022 19:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670526230;
        bh=jsOes6lsRyJazCweN98/1MgbRRFwiPjB2+BoIczXWYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ijpaKxol/3D/9TYbutUyVgpLUxAAf/CtPSIyaX9QItG1FQ3vRihbFKsxDlVS0iLtd
         g3kFzLH3ZuVBRYR6eqgm/zEbfbR6ICQqzG0HleivG1UjUVnloDS/vAOmJF6+YE3sdz
         hu6rtAKZPpdTcXjnsfKSm6+8NiZSJAkxDFX1AwYWPo0PU4gUGz3OlTg9Skg8c8pPil
         w/aVRGj5TR+xGyy3nFF4elE4Jal9T3UakDc+ZD4fCa7dB1QZ1WzhBk8GV3WC3D6YaA
         8AKbJgOw4yBbyXOq39wlfNg5z40QQP4MN4Bb6qs9L6/gYGJF6mKxCgvlxMWD0S0r88
         0n+OcJknwu9lw==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Florent DELAHAYE <kernelorg@undead.fr>,
        Konrad J Hambrick <kjhambrick@gmail.com>,
        Matt Hansen <2lprbe78@duck.com>,
        =?UTF-8?q?Benoit=20Gr=C3=A9goire?= <benoitg@coeus.ca>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        mumblingdrunkard@protonmail.com, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 2/4] PCI: Skip allocate_resource() if too little space available
Date:   Thu,  8 Dec 2022 13:03:39 -0600
Message-Id: <20221208190341.1560157-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221208190341.1560157-1-helgaas@kernel.org>
References: <20221208190341.1560157-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

pci_bus_alloc_from_region() allocates MMIO space by iterating through all
the resources available on the bus.  The available resource might be
reduced if the caller requires 32-bit space or we're avoiding BIOS or E820
areas.

Don't bother calling allocate_resource() if we need more space than is
available in this resource.  This prevents some pointless and annoying
messages about avoided areas.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Hans de Goede <hdegoede@redhat.com>
---
 drivers/pci/bus.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 3cef835b375f..83ae838ceb5f 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -197,6 +197,10 @@ static int pci_bus_alloc_from_region(struct pci_bus *bus, struct resource *res,
 
 		max = avail.end;
 
+		/* Don't bother if available space isn't large enough */
+		if (size > max - min_used + 1)
+			continue;
+
 		/* Ok, try it out.. */
 		ret = allocate_resource(r, res, size, min_used, max,
 					align, alignf, alignf_data);
-- 
2.25.1

