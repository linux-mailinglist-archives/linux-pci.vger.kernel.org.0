Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A927A6F20DD
	for <lists+linux-pci@lfdr.de>; Sat, 29 Apr 2023 00:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346865AbjD1Wff (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Apr 2023 18:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346547AbjD1Wfb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Apr 2023 18:35:31 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D04749D2;
        Fri, 28 Apr 2023 15:35:19 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1a6bc48aec8so3909125ad.2;
        Fri, 28 Apr 2023 15:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682721319; x=1685313319;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=soSZ2SRcxkgwO6bRCgJ7t3tsyaulOFN/8ZMK9B68Z4o=;
        b=cqMzvh19jnoipsC+X8oNLX6h03W5oevo5LyC8x31tSxe1fyOjrADCqD4XhPQ9ytN2m
         WwikptL1oi9hYiGuOr10dTeODrfI7HlcwagUq2kxUxZ+i1k2A6/qP8e9uulYY7RH6tBd
         O4d0maGA3SyB5Gm+E0DhRGGqCCi+GcoEZItiZpgvc1aRxpYLkHrhNMMINYWUSWIfgYol
         XSzWAiQb8MsGLB6WkljcwlmXuAhAafk69stum9UkuebsAKaeh3kbgPKKGbgAlYrcK/dN
         xo961KahNe9Fb2IeWfROSEg/TmNQ7wEylOoSHObHeYsr9kvjThoRcUPg4wzTny4k1E6x
         h5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682721319; x=1685313319;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=soSZ2SRcxkgwO6bRCgJ7t3tsyaulOFN/8ZMK9B68Z4o=;
        b=H81oH1owO75D67ZwacoARVYUgwBJHWZlJv10RfyZasAVB4mMBl88C8AIZXQmRcXEu2
         sOvHF707hUEwGXug4BxH9j+pBB+3EA9YiSQ1JDxvTXbp/jHP2bR9rBsbMcJoLjiGwRzZ
         NbcjBhNP5FtptgQcHpybxdXcLyBiNB+FaE7/MvDh883nP3F1p9U8L+O9zW4MxCC+H0M1
         wBLcIzXLiDFdDJ6Oat5D+kCST7McqBqmnAGikiEn8DzNGjZ9zrOz09GMbza4JtKWnfba
         h6ix5y4C7DhCgE0sRqfg88vF9Yadc/sEVP6dLTr7SafhCbWnU92+dzSlPsB+NRzM7LHG
         K+PA==
X-Gm-Message-State: AC+VfDwaoH81BpnaLmecsvZkk9bnRbsxPEP31OOszgYfe1gunYex1Pbw
        YeG90HLXlW/LE2TxIur4c2uVeGnEXiM=
X-Google-Smtp-Source: ACHHUZ4PiExedhiiNp0qLo/UOua0tCni9cce60v18358xqFHAGRhITwr+7v6IRsdRkdk0+e5MUialg==
X-Received: by 2002:a17:902:b20e:b0:1a1:d366:b085 with SMTP id t14-20020a170902b20e00b001a1d366b085mr6517084plr.21.1682721318911;
        Fri, 28 Apr 2023 15:35:18 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id j8-20020a170902690800b001a1b66af22fsm13657847plk.62.2023.04.28.15.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 15:35:18 -0700 (PDT)
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
Subject: [PATCH v4 4/5] PCI: brcmstb: Don't assume 2711 bootloader leaves PERST# asserted
Date:   Fri, 28 Apr 2023 18:34:58 -0400
Message-Id: <20230428223500.23337-5-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230428223500.23337-1-jim2101024@gmail.com>
References: <20230428223500.23337-1-jim2101024@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The current PCIe driver assumes PERST# is asserted when probe() is invoked.
The reasons are as follows:

(1) One Broadcom SOC (7278) causes a panic if the PERST# register is
    written during this time window.

(2) If PERST# is deasserted at Linux probe() time, experience and QA
    suspend/resume tests have shown that some endpoint devices fail if the
    PERST# is pulsed (deasserted => asserted => deasserted) quickly in this
    fashion, even though the timing is in accordance with their datasheets.

(3) Keeping things in reset tends to save power, if for some reason the
    PCIe driver is not yet present.

Broadcom STB and CM SOCs bootloaders always have PERST# asserted at probe()
time.  This is not necessarily the case for the 2711/RPi bootloader.  In
addition, there is a failing test case [1] that may be caused by a
deasserted PERST#.  Finally, Raspian version of Linux does assert PERST# at
probe() time.

So, for 2711/RPi SOCs, do what Raspian does and assert PERST#.

[1] https://lore.kernel.org/linux-pci/20230411165919.23955-1-jim2101024@gmail.com/T/#m39ebab8bc2827b2304aeeff470a6c6a58f46f987

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index c2cb683447ac..c486f4b979cc 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -884,6 +884,11 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 
 	/* Reset the bridge */
 	pcie->bridge_sw_init_set(pcie, 1);
+
+	/* Ensure that PERST# is asserted; some bootloaders may deassert it. */
+	if (pcie->type == BCM2711)
+		pcie->perst_set(pcie, 1);
+
 	usleep_range(100, 200);
 
 	/* Take the bridge out of reset */
-- 
2.17.1

