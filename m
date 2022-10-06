Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD915F70E7
	for <lists+linux-pci@lfdr.de>; Fri,  7 Oct 2022 00:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbiJFWDu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Oct 2022 18:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbiJFWDp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Oct 2022 18:03:45 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EA51142FA;
        Thu,  6 Oct 2022 15:03:43 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a26so7569218ejc.4;
        Thu, 06 Oct 2022 15:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gs9ymlzhHg78SV9AeCxTEe9UU7UvQjNqAP4fEvcWuVo=;
        b=cDvtzJ1+rH2aUDW/MjVaanBqq4xprQ163nM3w0nQS67mWJ8EUWOVoaS7Wl9XbcKOI4
         OU4XdH1S8zjbofM+8kGAp3I54MA+l4SFGmpJSZn5AS17PYIvlDLnZFB/ER+n+w0C/PYo
         7Y8sAoebIFnwjsMUtJEyBzABclMOwjAnEuUW2DVeXuaRX8t2O0AbeBOro9BKp9QpaEBw
         Z4uoma5saX2eK48eG+abHMsqWn1ytkvW/jbehgnFL1q7FplpoSRbm9nrfXd0+cu+jSc8
         RmrPifWxJhEnQIpmSq8YIh1QYyiBl6ilcVqU2gS72q4V98XBoF6/4uWXo5v5rBz+6Jy3
         sGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gs9ymlzhHg78SV9AeCxTEe9UU7UvQjNqAP4fEvcWuVo=;
        b=2XhcAIXZcw7UFmOE1ds8myqjy3XsyeIjEejQFmMZ4hQKeIhKi/OETBCfx1aFhKd3qH
         riHbbqqsJYJGwSWrWY2OCEepRjsC/fSCRx0CV6gtCGvslZMydkOJN7LLWFyoSIlMvyqJ
         dhY8r1PGVDuqHwxz7is6H2nBKjQ2eeuI11BfcILg4h5RQOvPR9WtmWs0obHMTiQrgA2K
         NuWdAetx1X5h58HWShW49VuoR2wfRASZq/zGTcI8akR2w5Q1sqRbvzB+kkHIK14mXGCY
         imSJU2Q8PYW0GgAMwAB5fRDIKnrQsnM5btk2hArQlQf8nwhX0kZRwr0H1OebLe2tIh5d
         NhKA==
X-Gm-Message-State: ACrzQf2Ksxz7BD25rmEGRui8qekh4OGwlfWZApdS6YDqDu72Qbc+3HXw
        7Pj8FRAGoP8oZwJ6z2197nk7I2mJeYA=
X-Google-Smtp-Source: AMsMyM5dtCnFEjRz1leYXttCvnccz2O+6tIP0Hmu/upNBDMJIqo0vffiWQ8Hc3rZamj4iiPGRM0L8Q==
X-Received: by 2002:a17:906:fe49:b0:73d:70c5:1a52 with SMTP id wz9-20020a170906fe4900b0073d70c51a52mr1637528ejb.469.1665093821971;
        Thu, 06 Oct 2022 15:03:41 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id f14-20020a17090631ce00b0078246b1360fsm241484ejf.131.2022.10.06.15.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 15:03:40 -0700 (PDT)
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
Subject: [PATCH v1 4/5] PCI: brcmstb: Functions needlessly specified as "inline"
Date:   Thu,  6 Oct 2022 18:03:20 -0400
Message-Id: <20221006220322.33000-5-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221006220322.33000-1-jim2101024@gmail.com>
References: <20221006220322.33000-1-jim2101024@gmail.com>
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

