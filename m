Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A83794403C4
	for <lists+linux-pci@lfdr.de>; Fri, 29 Oct 2021 22:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbhJ2UG3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Oct 2021 16:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbhJ2UGS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Oct 2021 16:06:18 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C6FC0613B9;
        Fri, 29 Oct 2021 13:03:47 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id v1-20020a17090a088100b001a21156830bso11427540pjc.1;
        Fri, 29 Oct 2021 13:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dR5goGjRH+faRSi6+pkacTGlwe5Jw734C5Ek8o+kxiM=;
        b=EO5UYp4d9BPAHCW1iVC6CevixytvZOW1wSqpJwVRSt21Xo3bykzvIiwMLlmnORyFEB
         3iE6CBm7HdlZmceoiKQ6PhLdfV8n99raNFrZuvhpnlMlHbngfcHHPTqjcvVKjqdXnkr0
         hOSSMjttoN0fULRdSKM3wC54QGW0x16arz1I12bIZnFIYrtOPfl11dD3MKPj5u1k3Qs7
         yiaElWlN2u85si9nIDIl7MMdE1bpI8A/RlT7kAkK2qS/RYAAy2dO8y8rhB+Q53kDwQ2J
         mDbml3aLhSdbF2/NIusE9vsh7pKje8XDQEZDXsmOBdj0S2dX397i8F2XtSLkg/+HNAgd
         jN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dR5goGjRH+faRSi6+pkacTGlwe5Jw734C5Ek8o+kxiM=;
        b=bQk6hWsr6ZaueCQ+9ofrYrO5cRd86CX2CSV6UaDSlgBe6HCKVMFWX2IdV/gYriCtQY
         tep2EV0tgD2CvefltnuNE0B6GPUIR6zmaQi/EO9pvSvRigYCWa0AzsDHtGi4N2VHIAlY
         GhvXCDLsq8pCeQZYwFt9PQumYfNaVPe5WIxH1jiMCjCuQQGGQLs9PQPuS3U/w/EXsFxO
         zcZpInnKipftEcNY+Mw/mHQsuxY2vWYZWx2Wz9czpzvHzkH9A7xHcznB0UbEiTezMb8N
         YsRBLdLCMUaiZe1M44AQo5jJHa+lx1gwyt1Wj/5rJjWy61Q0vpQ/+mIvEB+5itl46OUf
         WaEg==
X-Gm-Message-State: AOAM532wH8vtSz2ab3wIbnGat3RIhZuI0zwx+O+SQStG6kOhCpxTSQnA
        KofGMPfSlc2xlA9M03ZKn6Rd8NdGyvsdIw==
X-Google-Smtp-Source: ABdhPJxfHPZGaIHFIxsk4OqGM5oJw5NQuLdc00Tn5tag40VnL4M5tQXeStlEaSC90MV8JJb1Te1gcA==
X-Received: by 2002:a17:90a:4e42:: with SMTP id t2mr13798887pjl.108.1635537823599;
        Fri, 29 Oct 2021 13:03:43 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id j16sm8775041pfj.16.2021.10.29.13.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 13:03:43 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 9/9] PCI: brcmstb: change brcm_phy_stop() to return void
Date:   Fri, 29 Oct 2021 16:03:17 -0400
Message-Id: <20211029200319.23475-10-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211029200319.23475-1-jim2101024@gmail.com>
References: <20211029200319.23475-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We do not use the result of this function so make it void.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 18b9f7c97864..c1f8fdb89cec 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1196,9 +1196,10 @@ static inline int brcm_phy_start(struct brcm_pcie *pcie)
 	return pcie->rescal ? brcm_phy_cntl(pcie, 1) : 0;
 }
 
-static inline int brcm_phy_stop(struct brcm_pcie *pcie)
+static inline void brcm_phy_stop(struct brcm_pcie *pcie)
 {
-	return pcie->rescal ? brcm_phy_cntl(pcie, 0) : 0;
+	if (pcie->rescal)
+		brcm_phy_cntl(pcie, 0);
 }
 
 static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
@@ -1281,10 +1282,9 @@ static int brcm_pcie_get_regulators(struct brcm_pcie *pcie, struct pci_dev *dev)
 static int brcm_pcie_suspend(struct device *dev)
 {
 	struct brcm_pcie *pcie = dev_get_drvdata(dev);
-	int ret;
 
 	brcm_pcie_turn_off(pcie);
-	ret = brcm_phy_stop(pcie);
+	brcm_phy_stop(pcie);
 	reset_control_rearm(pcie->rescal);
 	clk_disable_unprepare(pcie->clk);
 
-- 
2.17.1

