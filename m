Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D240A640FDB
	for <lists+linux-pci@lfdr.de>; Fri,  2 Dec 2022 22:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbiLBVS4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Dec 2022 16:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234041AbiLBVSv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Dec 2022 16:18:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33E97046F;
        Fri,  2 Dec 2022 13:18:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 505F6623C0;
        Fri,  2 Dec 2022 21:18:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 809A1C433D7;
        Fri,  2 Dec 2022 21:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670015928;
        bh=jsOes6lsRyJazCweN98/1MgbRRFwiPjB2+BoIczXWYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hHcSTLEU0se8MLHfKx412OkDrWWRGjN1mwbgjdtwhjAg9ONVOxHbB5dUE1EoK2VCG
         uUWJmcgCzJU6WmOFB9UZR8u0mN+Ptaqs0AbVVQ03qEBUXb6LMmrt0pz31DzlNfoaCB
         JTCtFbZDVp3Kp1BFCQ77CEfhK61B4ufWOuCvdKcFXqlSOwE3k3PUlR98fOLiwYh36m
         ZJetJFy3D2FBjUzjyajNfGq47D5CAW7D6RrXQlXC0SaBfLMwXGE4KRzFv9qfq9uDWZ
         NMmLqx4mCX8rNUxlWIf8mr1Ov1knSLExOVf2e9W9jHMPWGoLH3ErzySppAjn+sSHCy
         3cg562HdjPOeg==
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
Subject: [PATCH 2/4] PCI: Skip allocate_resource() if too little space available
Date:   Fri,  2 Dec 2022 15:18:36 -0600
Message-Id: <20221202211838.1061278-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221202211838.1061278-1-helgaas@kernel.org>
References: <20221202211838.1061278-1-helgaas@kernel.org>
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

