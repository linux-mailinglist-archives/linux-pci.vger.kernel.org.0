Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C1546F5C5
	for <lists+linux-pci@lfdr.de>; Thu,  9 Dec 2021 22:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbhLIVSN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Dec 2021 16:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbhLIVSI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Dec 2021 16:18:08 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C387C061D5F;
        Thu,  9 Dec 2021 13:14:34 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id 8so6582460pfo.4;
        Thu, 09 Dec 2021 13:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1ejdtBcGu/O1Cxw2YS57FB14hxKmb2vB0wySR/Hf7zE=;
        b=P+EaI414dlrKAt2SUJZUawDH5u9Hkall7tbv2f8N1argny6SjHkSNzI5i3O20hxLPw
         7vbSf9pIQxNiHm+ecRl1DIH5aWTMOBsg2NTzk+wu4M3M3stfw0p46uX2TS9ZdvP55JGU
         eaWrj4a4LjdqNQoFgx1JxCYpSzE4CcAtZwKS3T9NMrZkBgvsuzW0npOmunQuOhihBd+S
         iAJ+rq5D60kg8F8DqUBnaI4GjvhpwOPB3jxaMLLXPO0Z8XIPi0R33v7/bJGNTqA4T42G
         jGqp1NaoD7LLePmrRchsCmM6yACSj9Zc1tYX8cMoNauLXNIlmiDj/sDT6JOkSwNzcufL
         KssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1ejdtBcGu/O1Cxw2YS57FB14hxKmb2vB0wySR/Hf7zE=;
        b=NJLnEB+E7/U8oV+3/f95GnZd7+rjO2dmCUXrexzf2ANsQ6j+W/sExrEB4T8jfbxy+a
         n4SvAG+0q+EGRtOOfREJFohdihvdIdYAAPY/PQE/U0lCi3Z3Vu2sw9XNfjflP6IB5HJe
         c1/0loGMH6uO/Gw5bp48J1JFMM/snhsovXIHriF4On5AdlewHvTW45VN2ca7nkKavVjg
         J7CfRe1OcRGC1OgfumQDqML6Tbs7YxEwESCmZVrgkb8MtjFl2C5LxWSYv976kBJg8TJo
         XV7kTGZDS7C1JwKGu/dTrV7o0hn5EePy51++uLtxollhJmR9dJK4usburyKDmdKnz4Py
         Oz0Q==
X-Gm-Message-State: AOAM5322dIEpdI7111A+gqAeJJyFUz1QvbPkdgVBebNHa+tkSkTa+3k6
        TLkJgC9SI9lFjmrB96DwjIcEpbQKdY8=
X-Google-Smtp-Source: ABdhPJwyhlwJggiRgi7BqXbJk7CM8QL1w7vHCs91o46x2lSJhd/S8prWb7v2FHaHQ4pEeoXNclYBiw==
X-Received: by 2002:a05:6a00:244b:b0:4ad:5852:f41d with SMTP id d11-20020a056a00244b00b004ad5852f41dmr14392033pfj.29.1639084473656;
        Thu, 09 Dec 2021 13:14:33 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id y4sm617800pfi.178.2021.12.09.13.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 13:14:32 -0800 (PST)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v10 7/7] PCI: brcmstb: Do not turn off WOL regulators on suspend
Date:   Thu,  9 Dec 2021 16:14:05 -0500
Message-Id: <20211209211407.8102-8-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211209211407.8102-1-jim2101024@gmail.com>
References: <20211209211407.8102-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If any downstream device can be awoken do not turn off
the regulators as the device will need them on.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 53 ++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 9b4df253e79a..8e5cbf6850cd 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -298,6 +298,7 @@ struct brcm_pcie {
 	void			(*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
 	bool			refusal_mode;
 	struct subdev_regulators *sr;
+	bool			ep_wakeup_capable;
 };
 
 /*
@@ -1166,9 +1167,21 @@ static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
 	pcie->bridge_sw_init_set(pcie, 1);
 }
 
+static int pci_dev_may_wakeup(struct pci_dev *dev, void *data)
+{
+	bool *ret = data;
+
+	if (device_may_wakeup(&dev->dev)) {
+		*ret = true;
+		dev_info(&dev->dev, "disable cancelled for wake-up device\n");
+	}
+	return (int) *ret;
+}
+
 static int brcm_pcie_suspend(struct device *dev)
 {
 	struct brcm_pcie *pcie = dev_get_drvdata(dev);
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
 	int ret;
 
 	brcm_pcie_turn_off(pcie);
@@ -1187,11 +1200,22 @@ static int brcm_pcie_suspend(struct device *dev)
 	}
 
 	if (pcie->sr) {
-		ret = regulator_bulk_disable(pcie->sr->num_supplies, pcie->sr->supplies);
-		if (ret) {
-			dev_err(dev, "Could not turn off regulators\n");
-			reset_control_reset(pcie->rescal);
-			return ret;
+		/*
+		 * Now turn off the regulators, but if at least one
+		 * downstream device is enabled as a wake-up source, do not
+		 * turn off regulators.
+		 */
+		pcie->ep_wakeup_capable = false;
+		pci_walk_bus(bridge->bus, pci_dev_may_wakeup,
+			     &pcie->ep_wakeup_capable);
+		if (!pcie->ep_wakeup_capable) {
+			ret = regulator_bulk_disable(pcie->sr->num_supplies,
+						     pcie->sr->supplies);
+			if (ret) {
+				dev_err(dev, "Could not turn off regulators\n");
+				reset_control_reset(pcie->rescal);
+				return ret;
+			}
 		}
 	}
 	clk_disable_unprepare(pcie->clk);
@@ -1212,10 +1236,21 @@ static int brcm_pcie_resume(struct device *dev)
 		return ret;
 
 	if (pcie->sr) {
-		ret = regulator_bulk_enable(pcie->sr->num_supplies, pcie->sr->supplies);
-		if (ret) {
-			dev_err(dev, "Could not turn on regulators\n");
-			goto err_disable_clk;
+		if (pcie->ep_wakeup_capable) {
+			/*
+			 * We are resuming from a suspend.  In the suspend we
+			 * did not disable the power supplies, so there is
+			 * no need to enable them (and falsely increase their
+			 * usage count).
+			 */
+			pcie->ep_wakeup_capable = false;
+		} else {
+			ret = regulator_bulk_enable(pcie->sr->num_supplies,
+						    pcie->sr->supplies);
+			if (ret) {
+				dev_err(dev, "Could not turn on regulators\n");
+				goto err_disable_clk;
+			}
 		}
 	}
 
-- 
2.17.1

