Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02E36D973A
	for <lists+linux-pci@lfdr.de>; Thu,  6 Apr 2023 14:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236102AbjDFMqu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Apr 2023 08:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237328AbjDFMqr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Apr 2023 08:46:47 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836C383E4;
        Thu,  6 Apr 2023 05:46:41 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id d17so39373944wrb.11;
        Thu, 06 Apr 2023 05:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680785201; x=1683377201;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=luFyciF8uhbYkGPNgpgaiPkjDSnlXlNp/qOa6qT6FH8=;
        b=nS5/rDNLtCzmL3//uFCtGvKctZZkKQgcK55vBT22aAEWLrCOaCGvl/dEggmaUE6AMe
         2PtT/7Br51MXNCCcWURAAmaY+ys8sRgRcBL/zvr0DuF6medxqEQwZMecVebOhEET79+n
         HvM7eiimozHOoSLId0L1OMsSRizTCMsAF/VZwz9q+wrWxCCfS2K8ky4cpdbFaGa7U+oQ
         ecDEAfj79WcU9wHKgolrGUBaRUgOlSptGvOEcxq30kJw/3r5FMks0CL0VykongVUMqX1
         VH/V+szpkYQYJ+nIQ8Tsm64wKvCw1Q7ZgBXUElbX3v6ggVZId3Nm0xgXBuEuhMsCUHps
         dL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680785201; x=1683377201;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=luFyciF8uhbYkGPNgpgaiPkjDSnlXlNp/qOa6qT6FH8=;
        b=1YYHlCB/G9HVg726Vz5OUyPUKOu5DhKQBDtZkOKdftCTnT0QYApwOv0VBbO1nCuIgY
         WvzC3G8pgZVvrB9GhOG6UqlVJgyo95+SuRndH5ays0GNNci35ct7aSA4JqRDHTXrGjzz
         o+/YKbm+fm3Awrg2YT2Bz5cSJpoGgAjy5ufBAPFrpAOqqHA0ySVorPedPaNI7tduDnzD
         ShqSeXNzCPbxhUuZAHxCBxxE8B8eeXw3eHAMb2AHacrq8LiDVAHz/pNNl0nagysFy6VQ
         nDxPf/QTxO7XYqA/8uulLfMipbVr39kOZ+xy7fHpAX7QpjkytmplFiWKbkbyywRk7NNX
         QMnA==
X-Gm-Message-State: AAQBX9fR7t/q30hdizSrHkr+XGzz76HabRm2gr+VCoWO/glzffzRP0WR
        RUgaHzQbhlxZ3iqgpoYbUQQ8UQMh6wo=
X-Google-Smtp-Source: AKy350bnsSUNhwYqeZVXUY4bJ7tb9Vvj4Rr9mIVgnCCCrtQ22Njl76/191eVPYwO2V87SHnsj1zFJQ==
X-Received: by 2002:a5d:6885:0:b0:2c5:5687:5ed5 with SMTP id h5-20020a5d6885000000b002c556875ed5mr7088743wru.18.1680785200854;
        Thu, 06 Apr 2023 05:46:40 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id n10-20020adff08a000000b002c5534db60bsm1686714wro.71.2023.04.06.05.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 05:46:39 -0700 (PDT)
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
Subject: [PATCH v1 3/3] PCI: brcmstb: Allow setting the completion timeout
Date:   Thu,  6 Apr 2023 08:46:24 -0400
Message-Id: <20230406124625.41325-4-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230406124625.41325-1-jim2101024@gmail.com>
References: <20230406124625.41325-1-jim2101024@gmail.com>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since the STB PCIe HW will cause a CPU abort on a completion timeout abort,
we might as well extend the timeout limit.  Further, different devices and
systems may requires a larger or smaller amount for L1SS exit.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 129eee7bdbc1..92d78f4dfaae 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1080,6 +1080,29 @@ static void brcm_config_clkreq(struct brcm_pcie *pcie)
 	writel(clkreq_set, pcie->base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
 }
 
+static void brcm_config_completion_timeout(struct brcm_pcie *pcie)
+{
+	/* TIMEOUT register is two registers before RGR1_SW_INIT_1 */
+	const unsigned int REG_OFFSET = PCIE_RGR1_SW_INIT_1(pcie) - 8;
+	u32 timeout, timeout_msec = 1000;
+	u64 tmp64;
+	int ret;
+
+	ret = of_property_read_u32(pcie->np, "brcm,completion-abort-msecs",
+				   &timeout_msec);
+
+	if (ret && ret != -EINVAL)
+		dev_err(pcie->dev, "bad 'brcm,completion-abort-msecs' prop\n");
+
+	/* Each unit in timeout register is 1/216,000,000 seconds */
+	tmp64 = (u64)216000 * timeout_msec;
+
+	/* Clamp the requested value before writing it */
+	timeout = tmp64 > 0xffffffff ? 0xffffffff : tmp64;
+	timeout = timeout < 0xffff ? 0xffff : timeout;
+	writel(timeout, pcie->base + REG_OFFSET);
+}
+
 static int brcm_pcie_start_link(struct brcm_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
@@ -1110,6 +1133,7 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
 		return -ENODEV;
 	}
 
+	brcm_config_completion_timeout(pcie);
 	brcm_config_clkreq(pcie);
 
 	if (pcie->gen)
-- 
2.17.1

