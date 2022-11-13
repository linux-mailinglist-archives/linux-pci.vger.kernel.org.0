Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6BA626E73
	for <lists+linux-pci@lfdr.de>; Sun, 13 Nov 2022 09:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbiKMILj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 13 Nov 2022 03:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiKMILi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 13 Nov 2022 03:11:38 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDBD12AA5;
        Sun, 13 Nov 2022 00:11:37 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id h193so7777505pgc.10;
        Sun, 13 Nov 2022 00:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NKEdlXKlhh8Fv9eCZRHeljCdkyO6M1oLq2jA10seMio=;
        b=MDdVMUnasgiqp/CJyMI4RXpe9a+F/4UEZNmrvaPvBuk/eMc9JHJEwCOxeg0PIjGtp8
         8673DiquvL2q7rrHFvG2LCObz8ZNQNs4q2Fdd6JlVzbPs3dXyLO4C8mqQjf7M+5a4bGH
         gAqUii6PimQwn5ChUX0kc7AhWrACS2qMt9xn6f2OHUGLDpuzCQ/4439rEeh8N0wijL5n
         nOoC6e69Y02LBo6b9/ANudk/A3qWojeHFjmE+rLEymaH/moexFEkGwscO+YM1SK2kTTj
         2cXCRExFYVapX9YqG8viOlQ1CyC4F1wx1SuWpdcD5ymy6fO261LhhxZuPubNoQK3RXW8
         E6ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NKEdlXKlhh8Fv9eCZRHeljCdkyO6M1oLq2jA10seMio=;
        b=EutqFyAHn3tiBAHZ0i1SKuYhtdxlYM7Y+8mfTPedVFkmRIVfsWLeKVu7ikzXuHMlXM
         UnsHe+zXMzTdORBZTamDDZHi60sAymNO40sLz3MNSugl6dRZVo+wphTbll8aKG44Ma5L
         K1n0jz/rndQZ57Z4lkrrT/olbtijGFKkkrgn/FATn+efIgzz+iDX++3kcdRW155SnrNp
         QBnv0163GCR0ZB3RUi94pdbS8aLj/Z3b3fsgUwrnLRYeryv/EpvZNSHsRX2hPsbGNx7m
         +ufqX01ggEZxa0x3WZ1r3RNpaSFz16NCGFXGiIacZsOVmllzhGZBfok9sUI83f6LrI6T
         qNxw==
X-Gm-Message-State: ANoB5pkyzudKO3p1Yy/LiZ1vW70y3pACtRxx9ONbye/s8QdjmXBWdMr5
        uq4UlQdzygc7WJkP4gGHPzQ=
X-Google-Smtp-Source: AA0mqf7btm3NibOglPkCmgO7gpwr3Ma+FqdlE6kJYB1gIIvmOAgeBO+DOJ3pKuVbB9BYbpc9SfDMHw==
X-Received: by 2002:a63:1b52:0:b0:44e:74d0:e843 with SMTP id b18-20020a631b52000000b0044e74d0e843mr8010928pgm.95.1668327097197;
        Sun, 13 Nov 2022 00:11:37 -0800 (PST)
Received: from junjun.localdomain ([1.83.223.231])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090341c900b0017a0668befasm2390267ple.124.2022.11.13.00.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 00:11:36 -0800 (PST)
From:   Harry Song <jundongsong1@gmail.com>
To:     helgaas@kernel.org
Cc:     bhelgaas@google.com, gustavo.pimentel@synopsys.com,
        jingoohan1@gmail.com, jundongsong1@gmail.com, kw@linux.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lpieralisi@kernel.org, robh@kernel.org
Subject: [PATCH V2] PCI: dwc: Warn about invalid 'max-link-speed' from DT
Date:   Sun, 13 Nov 2022 16:10:06 +0800
Message-Id: <20221113081006.3624-1-jundongsong1@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

of_pci_get_max_link_speed() may return a negative value,
causing the controller to not set the speed correctly.
Add a warning in case the driver engineer misses it.

Signed-off-by: Harry Song <jundongsong1@gmail.com>
---

 V2: Change the description of the subject line;
     Remove unnecessary "unlikely";

 Thanks for your comment, V1 is this one:
 https://lore.kernel.org/lkml/20221110213239.GA672651@bhelgaas/

 drivers/pci/controller/dwc/pcie-designware-ep.c   | 5 ++++-
 drivers/pci/controller/dwc/pcie-designware-host.c | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 83ddb1902..19892e939 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -739,8 +739,11 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 		return -ENOMEM;
 	ep->outbound_addr = addr;
 
-	if (pci->link_gen < 1)
+	if (pci->link_gen < 1) {
 		pci->link_gen = of_pci_get_max_link_speed(np);
+		if (pci->link_gen < 0)
+			dev_warn(dev, "Invalid to get max-link-speed from DT\n");
+	}
 
 	epc = devm_pci_epc_create(dev, &epc_ops);
 	if (IS_ERR(epc)) {
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 39f3b37d4..42633ec8c 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -429,8 +429,11 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 		pp->io_base = pci_pio_to_address(win->res->start);
 	}
 
-	if (pci->link_gen < 1)
+	if (pci->link_gen < 1) {
 		pci->link_gen = of_pci_get_max_link_speed(np);
+		if (pci->link_gen < 0)
+			dev_warn(dev, "Invalid to get max-link-speed from DT\n");
+	}
 
 	/* Set default bus ops */
 	bridge->ops = &dw_pcie_ops;
-- 
2.25.1

