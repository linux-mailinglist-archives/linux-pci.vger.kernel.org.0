Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A816E7FF0
	for <lists+linux-pci@lfdr.de>; Wed, 19 Apr 2023 18:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbjDSQ54 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Apr 2023 12:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbjDSQ5w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Apr 2023 12:57:52 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA316A5B;
        Wed, 19 Apr 2023 09:57:49 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id k36-20020a17090a4ca700b0024770df9897so709937pjh.4;
        Wed, 19 Apr 2023 09:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681923468; x=1684515468;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KlHfoAK9yIIL7Skn5B+cEJbm8dBEJYFGzxR8exxzgXQ=;
        b=KVIQLBweAYzHj6hS8d/wilTnBhpIhn18sY5eE3kol7cHpljcyg86jTo/QSaOkcu8Zl
         WwBH0XbZJJWueitQHGknmJN9Fc+FQqU1qIMa4u4PoNggCijba+hrNJHfrQo8sLzTfCIu
         EOjzKDmrVcJdVfWPGyexif9+m/dYK+vr1GCxXnqqlQEJ3IBgvcsAHQFUYcUvN24PQnKi
         7iAwTygC1R/YH9muQQwTNo+1EG7PVYjwW2f25of7+xW7UhypQPGdlxwxkO325IR6MsFk
         +iwIjtPp95xx1KzrHb4hE3rK9zLRYLwZbPVa86E45MY5/G3sQzAWCBF0nRQFHShUhLyX
         x/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681923468; x=1684515468;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KlHfoAK9yIIL7Skn5B+cEJbm8dBEJYFGzxR8exxzgXQ=;
        b=h2nJ2RLujKs7i26mkS0LhiXudy+r7Q6m1JYpCcW8+e0h02HXPdpSBQB91X0OVeqU6k
         Nnbq7MTqGodP8ZjHhcZV0t1kF7fMXz+gsJWACIG0d0wo+e69H2GpNSVr4MPWJ/mWksk3
         0coCXWd0rS3niTefBphUnMCHTd+E8SliGR8FPPI0dxxO8h1o4Y7kGwaYLD/sIS/qsQia
         vyZWS1VRgYu4Smf+5S2zP5KZLG2B6BMI9WYTjU7lWAbjSHNA5Ce0xlxMFfyBLrSrwyQw
         G/jDvmk+2LgykcsQ2WIcLPW5I1H8OptEtCBS4wuH5V6ok+v3qrgONlapYfs4rWCSDkEQ
         4uzw==
X-Gm-Message-State: AAQBX9cag0OcPBsWovcvoUXMRt7/1h2ek85tRuqjWl2DRhTzQ9aMC863
        kvZUKTcHnxhfgE2gxDNIqH5kOvZaTx4=
X-Google-Smtp-Source: AKy350a4OyCN32Ls8VfkflZ5PT8f/xGszucmE3yE7L4d/DfuLQjto9TH9jnMqeP6hzC27uioac+drQ==
X-Received: by 2002:a05:6a20:94ca:b0:ef:1d4e:cf3e with SMTP id ht10-20020a056a2094ca00b000ef1d4ecf3emr4341775pzb.50.1681923468421;
        Wed, 19 Apr 2023 09:57:48 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id s9-20020aa78d49000000b005abc30d9445sm11188135pfe.180.2023.04.19.09.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 09:57:48 -0700 (PDT)
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
Subject: [PATCH v3 3/3] PCI: brcmstb: Set PCIe transaction completion timeout
Date:   Wed, 19 Apr 2023 12:57:20 -0400
Message-Id: <20230419165721.29533-4-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230419165721.29533-1-jim2101024@gmail.com>
References: <20230419165721.29533-1-jim2101024@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since the STB PCIe HW will cause a CPU abort on a PCIe transaction
completion timeout abort, we might as well extend the default timeout
limit.  Further, different devices and systems may requires a larger or
smaller amount commensurate with their L1SS exit time, so the property
"brcm,completion-timeout-us" may be used to set a custom timeout value.

Tested-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 30 +++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index c4b076ea5180..c2cb683447ac 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1080,6 +1080,35 @@ static void brcm_config_clkreq(struct brcm_pcie *pcie)
 	writel(clkreq_set, pcie->base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
 }
 
+static void brcm_config_completion_timeout(struct brcm_pcie *pcie)
+{
+	/* TIMEOUT register is two registers before RGR1_SW_INIT_1 */
+	const char *fmt = "brcm,completion-timeout-us clamped to region [%u..%u]\n";
+	const unsigned int REG_OFFSET = PCIE_RGR1_SW_INIT_1(pcie) - 8;
+	const u32 timeout_us_min = 16;
+	const u32 timeout_us_max = 19884107;
+	u32 timeout_us = 1000000; /* Our default, 1 second */
+	int rval, ret;
+
+	ret = of_property_read_u32(pcie->np, "brcm,completion-timeout-us",
+				   &timeout_us);
+	if (ret && ret != -EINVAL)
+		dev_err(pcie->dev, "malformed/invalid 'brcm,completion-timeout-us'\n");
+
+	/* If needed, clamp the requested timeout value and issue a warning */
+	if (timeout_us < timeout_us_min) {
+		timeout_us = timeout_us_min;
+		dev_warn(pcie->dev, fmt, timeout_us_min, timeout_us_max);
+	} else if (timeout_us > timeout_us_max) {
+		timeout_us = timeout_us_max;
+		dev_warn(pcie->dev, fmt, timeout_us_min, timeout_us_max);
+	}
+
+	/* Each unit in timeout register is 1/216,000,000 seconds */
+	rval = 216 * timeout_us;
+	writel(rval, pcie->base + REG_OFFSET);
+}
+
 static int brcm_pcie_start_link(struct brcm_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
@@ -1110,6 +1139,7 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
 		return -ENODEV;
 	}
 
+	brcm_config_completion_timeout(pcie);
 	brcm_config_clkreq(pcie);
 
 	if (pcie->gen)
-- 
2.17.1

