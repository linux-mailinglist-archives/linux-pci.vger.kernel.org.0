Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D496FBABB
	for <lists+linux-pci@lfdr.de>; Tue,  9 May 2023 00:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbjEHWCF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 May 2023 18:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234303AbjEHWBo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 May 2023 18:01:44 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9A98A7A;
        Mon,  8 May 2023 15:01:35 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-75785057afeso128971485a.3;
        Mon, 08 May 2023 15:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683583294; x=1686175294;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pCt3fs/yt+9j4nJyZEyIyBbz3ydO6tgld+CtAn09VxI=;
        b=O66dAvPPs2CQpnu+jPSBwMhFwMizGeRGvwdwnC/tapuHPzrY6ubNibVBXz8X3zLEPM
         vzeOUPnjE1agVfmXqrMbUBB6+wW3pZLz0zpVBJybj/JEyGRkdws//wa77Qj6oyYk9kvd
         mWh+LZMZ5bSQgAKc7lBQG+LKVNYleJRiNKTEn9tSA0sIxIXgZziFcMoVG3Pgg8CYkPUr
         WmxgAbcVKclCjP4N7MBsnawEzH6A/dW4gaKFOPKwCcadbLQWyY+liMJxgRBajGRQOmnr
         jsbVlCshTvjd6fYZK34vYLbdCJETIVVcswi0HcRi2UzVMAWbdX+AExVD9U1EBkNVSIf1
         OoaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683583294; x=1686175294;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pCt3fs/yt+9j4nJyZEyIyBbz3ydO6tgld+CtAn09VxI=;
        b=gyq8nIH4Wcpi//wWjHNHGO979eSv2xh0KdAddInDRlQioo5swRUsWY1TBmWQ8jF6VN
         SdTplSXb5/IoG916jhW4Z/biX6GmrZyTqfb8+RqfGSmHldeOzR4D7H+nB1br+v1DORKN
         NJoZeAnT82TY3MEBcIA5RkDJThSH0xDaWDeMlmM4/dOieq3dK9xrR8Ou0W+XH/BkZEXj
         2rCp/wLQXouitESTdoLnxHoA8rysdfDZCJAWoPu7uVjvNJzEX/cPK1VpeoKsO42ym3kN
         tWaQkCEkgNH1VG6HfNswKfJguAP6IZYdXg/uj+kK9STuVMgEtQ2bMn3YHCewaMzG1/Yn
         BWvA==
X-Gm-Message-State: AC+VfDzh2ZmLeOfKz/of5HHTHPtebwCwvm/vle2hbGZ9DFPsfal0QMHN
        O67S92LPIcp+s7d7ze8Ndi38yye+4vY=
X-Google-Smtp-Source: ACHHUZ7xSK+QevIq0p3hBj+58HTRkq4ohElRL00PBCdMCP3uGE82Ms/affum43cqE0BMUDlwa6q98g==
X-Received: by 2002:ac8:5cd2:0:b0:3ef:4c4b:7e1e with SMTP id s18-20020ac85cd2000000b003ef4c4b7e1emr17619302qta.29.1683583294692;
        Mon, 08 May 2023 15:01:34 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id e11-20020ac8010b000000b003d7e923736asm3315176qtg.6.2023.05.08.15.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 15:01:34 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 5/5] PCI: brcmstb: Remove stale comment
Date:   Mon,  8 May 2023 18:01:25 -0400
Message-Id: <20230508220126.16241-6-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230508220126.16241-1-jim2101024@gmail.com>
References: <20230508220126.16241-1-jim2101024@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

A comment says that Multi-MSI is not supported by the driver.
A past commit [1] added this feature, so the comment is
incorrect and is removed.

[1] commit 198acab1772f22f2 ("PCI: brcmstb: Enable Multi-MSI")

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 7b698a9a851e..acd478edbe2f 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -449,7 +449,6 @@ static struct irq_chip brcm_msi_irq_chip = {
 };
 
 static struct msi_domain_info brcm_msi_domain_info = {
-	/* Multi MSI is supported by the controller, but not by this driver */
 	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
 		   MSI_FLAG_MULTI_PCI_MSI),
 	.chip	= &brcm_msi_irq_chip,
-- 
2.17.1

