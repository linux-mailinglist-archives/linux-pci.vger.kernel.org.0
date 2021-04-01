Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5BD352197
	for <lists+linux-pci@lfdr.de>; Thu,  1 Apr 2021 23:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235286AbhDAVWG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Apr 2021 17:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235333AbhDAVWD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Apr 2021 17:22:03 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E17DC061788;
        Thu,  1 Apr 2021 14:22:03 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id s11so2356832pfm.1;
        Thu, 01 Apr 2021 14:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3Svmj4M57E9UEJUPztxJxLaD+qDYLkSPzt9oL2QtC44=;
        b=QdAOl64swAv8QPAkhS3LmoBMm77A/m1F7ZHnm2l6hl7zkTCmQRw6maRV9rcYq2IQYS
         SDu+c5Ia41SWN6rSBDaNecTwacaO+Pq9gHj+ium+lNYkeyUi1Pa4c7ff6LrA8/qJWaHk
         MTXBeFEmdYgSWt2MzNBAj5utjpdWkdVtqlj4HrFWm4NdYESeDlxCx4eNMS3J0hU0fc+L
         lR6YldvvVtve8TN2mJ//NKZ4zSHIUrF6pqjG08HFHz4491EgU9U+OBLy4hhOLEDL2O8w
         wYcHFxaWkSM04kEfVEJk9SncgCAO0nj6LoYJ7s3jvM3bkkO8dmx95pQdycDKCxAKTlNh
         lc0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3Svmj4M57E9UEJUPztxJxLaD+qDYLkSPzt9oL2QtC44=;
        b=IgGy7drOzzrFiIHRHPNGmdmCvvYYFom+byStyYQ3cVAd8ujroPI+WwdhgRpaPcnW6h
         6tIiqApsdQes+zyF/7TIcFrtmDumSMdPSM/vmfPB6wm/KyMp4+rRL8YKpa/lSuh9CFig
         4lnUnvy58lpTg9fvm/lzWoA4BJM6IVaYeuUtZkNDBLi0SFmxlvGcEnYU1qDKPa2RjQ7y
         W+rRijGBDe/cWR2C3Za+AYqIGltJ0S3oqzJVJgiS3eOyx07RLOcJ++VmkQUS7YBA1s0s
         4hCF55pFdY/DaJyNI/iBhXIu9YME7kDO9xreZdnWCJbmb9+zYH13Qxs0JTX0IYy5syRm
         gIeQ==
X-Gm-Message-State: AOAM532KAHdfbo+/WFgwy/rfrIX7JM/ktUiv3FFKcq8ySDyw919V68iV
        UnFAR07hCl9phy7NrzFv7m7AhcVjUHQ=
X-Google-Smtp-Source: ABdhPJwi3QBpg+AUACKEeirWBOo7RVmBvkFoAwhc7TIv+cKY68bgc16eXAS34emUMg33TpkYzsMKDQ==
X-Received: by 2002:aa7:9478:0:b029:1fd:1fc1:bdfe with SMTP id t24-20020aa794780000b02901fd1fc1bdfemr9225842pfq.57.1617312122653;
        Thu, 01 Apr 2021 14:22:02 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id q5sm5926707pfk.219.2021.04.01.14.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 14:22:02 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 4/6] PCI: brcmstb: Do not turn off regulators if EP can wake up
Date:   Thu,  1 Apr 2021 17:21:44 -0400
Message-Id: <20210401212148.47033-5-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210401212148.47033-1-jim2101024@gmail.com>
References: <20210401212148.47033-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If any downstream device may wake up during S2/S3 suspend, we do not want
to turn off its power when suspending.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 58 +++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 1b0de0c7da60..4c79aff66de7 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -193,6 +193,7 @@ static inline void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie,
 static inline void brcm_pcie_perst_set_4908(struct brcm_pcie *pcie, u32 val);
 static inline void brcm_pcie_perst_set_7278(struct brcm_pcie *pcie, u32 val);
 static inline void brcm_pcie_perst_set_generic(struct brcm_pcie *pcie, u32 val);
+static bool brcm_pcie_link_up(struct brcm_pcie *pcie);
 
 static const char * const supplies[] = {
 	"vpcie12v-supply",
@@ -304,22 +305,65 @@ struct brcm_pcie {
 	void			(*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
 	struct regulator_bulk_data supplies[PCIE_BRCM_MAX_EP_REGULATORS];
 	unsigned int		num_supplies;
+	bool			ep_wakeup_capable;
 };
 
-static int brcm_set_regulators(struct brcm_pcie *pcie, bool on)
+static int pci_dev_may_wakeup(struct pci_dev *dev, void *data)
 {
+	bool *ret = data;
+
+	if (device_may_wakeup(&dev->dev)) {
+		*ret = true;
+		dev_dbg(&dev->dev, "disable cancelled for wake-up device\n");
+	}
+	return (int) *ret;
+}
+
+enum {
+	TURN_OFF,		/* Turn regulators off, unless an EP is wakeup-capable */
+	TURN_OFF_ALWAYS,	/* Turn regulators off, no exceptions */
+	TURN_ON,		/* Turn regulators on, unless pcie->ep_wakeup_capable */
+};
+
+static int brcm_set_regulators(struct brcm_pcie *pcie, int how)
+{
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
 	struct device *dev = pcie->dev;
 	int ret;
 
 	if (!pcie->num_supplies)
 		return 0;
-	if (on)
+	if (how == TURN_ON) {
+		if (pcie->ep_wakeup_capable) {
+			/*
+			 * We are resuming from a suspend.  In the
+			 * previous suspend we did not disable the power
+			 * supplies, so there is no need to enable them
+			 * (and falsely increase their usage count).
+			 */
+			pcie->ep_wakeup_capable = false;
+			return 0;
+		}
+	} else if (how == TURN_OFF) {
+		/*
+		 * If at least one device on this bus is enabled as a
+		 * wake-up source, do not turn off regulators.
+		 */
+		pcie->ep_wakeup_capable = false;
+		if (bridge->bus && brcm_pcie_link_up(pcie)) {
+			pci_walk_bus(bridge->bus, pci_dev_may_wakeup, &pcie->ep_wakeup_capable);
+			if (pcie->ep_wakeup_capable)
+				return 0;
+		}
+	}
+
+	if (how == TURN_ON)
 		ret = regulator_bulk_enable(pcie->num_supplies, pcie->supplies);
 	else
 		ret = regulator_bulk_disable(pcie->num_supplies, pcie->supplies);
 	if (ret)
 		dev_err(dev, "failed to %s EP regulators\n",
-			on ? "enable" : "disable");
+			how == TURN_ON ? "enable" : "disable");
 	return ret;
 }
 
@@ -1206,7 +1250,7 @@ static int brcm_pcie_suspend(struct device *dev)
 	brcm_phy_stop(pcie);
 	clk_disable_unprepare(pcie->clk);
 
-	return brcm_set_regulators(pcie, false);
+	return brcm_set_regulators(pcie, TURN_OFF);
 }
 
 static int brcm_pcie_resume(struct device *dev)
@@ -1221,7 +1265,7 @@ static int brcm_pcie_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	ret = brcm_set_regulators(pcie, true);
+	ret = brcm_set_regulators(pcie, TURN_ON);
 	if (ret)
 		return ret;
 
@@ -1261,7 +1305,7 @@ static void __brcm_pcie_remove(struct brcm_pcie *pcie)
 	brcm_phy_stop(pcie);
 	reset_control_assert(pcie->rescal);
 	clk_disable_unprepare(pcie->clk);
-	brcm_set_regulators(pcie, false);
+	brcm_set_regulators(pcie, TURN_OFF_ALWAYS);
 }
 
 static int brcm_pcie_remove(struct platform_device *pdev)
@@ -1360,7 +1404,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 		goto fail;
 	}
 
-	ret = brcm_set_regulators(pcie, true);
+	ret = brcm_set_regulators(pcie, TURN_ON);
 	if (ret)
 		goto fail;
 
-- 
2.17.1

