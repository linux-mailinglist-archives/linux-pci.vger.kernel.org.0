Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7964A5FBAA3
	for <lists+linux-pci@lfdr.de>; Tue, 11 Oct 2022 20:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiJKSmd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Oct 2022 14:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiJKSmW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Oct 2022 14:42:22 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5617CB48;
        Tue, 11 Oct 2022 11:42:21 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id r19so623140qtx.6;
        Tue, 11 Oct 2022 11:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jC9v6x5O9g4o36lTWYhNYvUXqkkWlvK03fmUWelD46Y=;
        b=QJXGNK69c45gXxMdpzsU32P1osw4qt8d4ezCrzK7p+V9A9LWM7zYJYKdkJi4RCVhU/
         xlprNjlA0EEFoHkTc98wUvsr0TGnRoDMxZEQNJ/2AVBdNKFGpAKU6W1udWq4eeNdpFpj
         3qLuT1Xli21zAtRxMdp8YsiAtmUKH5nPqzUL8MpDKW4sFAT+30a2U3pzok4z9qJGHjzk
         Lkh/5rsq73Ib6fXEJfZboA1ADYW8kK4sdtBUb1F3qYC8vqmiys/xoge+3oX4Eo0/beDF
         Sg+1iuecagwXvBNWP+pfASw79MbYknWYbyaFHSgHDDdB6bimib1Ir8YC2509qr+R4PaE
         8x3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jC9v6x5O9g4o36lTWYhNYvUXqkkWlvK03fmUWelD46Y=;
        b=x+i03wfxTVLadnNXxVBrvOU6f0Q25OC+G1K+skZriv+jIxTTA3AJUY2+hWivxPFZuo
         LbHRpxRubw9RYt6vBBT+rtcQH4bO+QY+jBslEHjjTbMR4Xx3yeUuGT2SB5wJ1uknxMzg
         X0Af4Y7rFuHP8CypQpghgULMX6WMuHMRgysiIseaczE9a4JB0irxBfelqNij+s/gjwe/
         UJDdbLts6kwZlNqFtmGsMyJY2aXVatpGm+7R1sX6bp1ODMp/HisnWZ2BlS3GRFqmylYe
         SKYbqON/YuP1Cdln29FuzUWe8xQ6ETqYHcwp7AWx9NDAD9SYbtrOHXHyRVIHbNfxYtwV
         RwZQ==
X-Gm-Message-State: ACrzQf1BTH0a0sOgpXviH1tXFzUqaUX760AiwTtHCfYYjo1so5CrkE84
        ctsXtMNvu4p24yL0CU7jy+9LWIPqBDM=
X-Google-Smtp-Source: AMsMyM7LATMcDiFcvI+0/DRZQnhodXci0t2uK77a9y8u6aghVCj0Oo0ASbgemMCgyldZFJrJqqrrHw==
X-Received: by 2002:ac8:5751:0:b0:39c:b848:198f with SMTP id 17-20020ac85751000000b0039cb848198fmr2170312qtx.429.1665513739432;
        Tue, 11 Oct 2022 11:42:19 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id fc8-20020a05622a488800b003938a65479bsm10961732qtb.10.2022.10.11.11.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 11:42:18 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 4/5] PCI: brcmstb: Functions needlessly specified as "inline"
Date:   Tue, 11 Oct 2022 14:42:09 -0400
Message-Id: <20221011184211.18128-5-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221011184211.18128-1-jim2101024@gmail.com>
References: <20221011184211.18128-1-jim2101024@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

A number of inline functions are called rarely and/or are not
time-critical.  Take out the "inline" and let the compiler do its work.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index c7210cec1f58..e3045f1eadbc 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -723,7 +723,7 @@ static void __iomem *brcm7425_pcie_map_bus(struct pci_bus *bus,
 	return base + DATA_ADDR(pcie);
 }
 
-static inline void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val)
+static void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val)
 {
 	u32 tmp, mask =  RGR1_SW_INIT_1_INIT_GENERIC_MASK;
 	u32 shift = RGR1_SW_INIT_1_INIT_GENERIC_SHIFT;
@@ -733,7 +733,7 @@ static inline void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie,
 	writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
 }
 
-static inline void brcm_pcie_bridge_sw_init_set_7278(struct brcm_pcie *pcie, u32 val)
+static void brcm_pcie_bridge_sw_init_set_7278(struct brcm_pcie *pcie, u32 val)
 {
 	u32 tmp, mask =  RGR1_SW_INIT_1_INIT_7278_MASK;
 	u32 shift = RGR1_SW_INIT_1_INIT_7278_SHIFT;
@@ -743,7 +743,7 @@ static inline void brcm_pcie_bridge_sw_init_set_7278(struct brcm_pcie *pcie, u32
 	writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
 }
 
-static inline void brcm_pcie_perst_set_4908(struct brcm_pcie *pcie, u32 val)
+static void brcm_pcie_perst_set_4908(struct brcm_pcie *pcie, u32 val)
 {
 	if (WARN_ONCE(!pcie->perst_reset, "missing PERST# reset controller\n"))
 		return;
@@ -754,7 +754,7 @@ static inline void brcm_pcie_perst_set_4908(struct brcm_pcie *pcie, u32 val)
 		reset_control_deassert(pcie->perst_reset);
 }
 
-static inline void brcm_pcie_perst_set_7278(struct brcm_pcie *pcie, u32 val)
+static void brcm_pcie_perst_set_7278(struct brcm_pcie *pcie, u32 val)
 {
 	u32 tmp;
 
@@ -764,7 +764,7 @@ static inline void brcm_pcie_perst_set_7278(struct brcm_pcie *pcie, u32 val)
 	writel(tmp, pcie->base +  PCIE_MISC_PCIE_CTRL);
 }
 
-static inline void brcm_pcie_perst_set_generic(struct brcm_pcie *pcie, u32 val)
+static void brcm_pcie_perst_set_generic(struct brcm_pcie *pcie, u32 val)
 {
 	u32 tmp;
 
@@ -773,7 +773,7 @@ static inline void brcm_pcie_perst_set_generic(struct brcm_pcie *pcie, u32 val)
 	writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
 }
 
-static inline int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pcie,
+static int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pcie,
 							u64 *rc_bar2_size,
 							u64 *rc_bar2_offset)
 {
-- 
2.17.1

