Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 130EA4378B9
	for <lists+linux-pci@lfdr.de>; Fri, 22 Oct 2021 16:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbhJVOKC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Oct 2021 10:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbhJVOJz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Oct 2021 10:09:55 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138ECC061766;
        Fri, 22 Oct 2021 07:07:38 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id v20so2771167plo.7;
        Fri, 22 Oct 2021 07:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kDRuxXTZJR6dlNhMjzpXR1CtF1FwgepiTBl4EHuvHhs=;
        b=HV8lT2/xwA8f8cEqJQw8e7GChJRSzrCwluVhEGLrpvqiNk8dpaLiC5YEE+AwjZQn68
         NiVdi7dfPblxXo8m5KV/X5xi1CeQt7HqwDq4CdZPSISTms1+1ekp30q3M5wQKurgWD7c
         Ymt9644S+F4lTqRVNPwsVIplI4xD7WoEQBkGyrDw/cHT8L6U7tRxt5CG0BnjDc1LJhQt
         XXpKdXGzfUE+pBUoPaPO6CSDkCXqVSDSpdnufAvhmalozb0Ud457CLl/0SLWw10ys9+G
         7gf/ek1aEbWxe8xSMIcCXYk+we+TsnOD72gOuCjIGGzSFnk37FqgN7A53csJIGxBZbn0
         2Skw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kDRuxXTZJR6dlNhMjzpXR1CtF1FwgepiTBl4EHuvHhs=;
        b=gBbleBumsb/j49+o9VLkV2JKDNHPSxv1O3iTlMkvyOQ1XWEJV6hSdpwOiWPSbLKipx
         hXKMSBRmb3dt1VpB4+KSsp9V8Pq6SX1PG/6PZQ2so2esh8ODJ62K7or7GATHPhHTUuPW
         rWl8xKjh23/f7KNMpNR4E/1nUAHLlHo3I0JTwKqHN0gmfwUgj/+LjllvwRclHX1bnro6
         7lxIEG7OrE7XMOWCnav3X55+5NIeKA1gWH/XUsbEd3tVfTf/w1JYoSPgzZ1CKEQ4yB30
         Ua2dL6M25GzJ3KAt0QnFuYUyLez+9hSsa2+zV4kueJbBasN1s3W6ZWxRqIIQjx/dzXdm
         Y+Xg==
X-Gm-Message-State: AOAM532CGK/P9pjGfkH15fvrVbWj3aHQtAGTixhEKyv3xvosYEn7C7gm
        2bskkp3cE8cl/cq+BL+XmIie9aI1+nCqAA==
X-Google-Smtp-Source: ABdhPJx6mGnQbFIcb5PCo3TZyUYO50WkwimEZ8VOnm7FVbb6DqmQFH5jPTkKOosBn+OsAibbFK8lZw==
X-Received: by 2002:a17:903:120e:b0:138:d732:3b01 with SMTP id l14-20020a170903120e00b00138d7323b01mr11525395plh.21.1634911656887;
        Fri, 22 Oct 2021 07:07:36 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id e12sm9482990pfl.67.2021.10.22.07.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 07:07:36 -0700 (PDT)
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
Subject: [PATCH v5 6/6] PCI: brcmstb: change brcm_phy_stop() to return void
Date:   Fri, 22 Oct 2021 10:06:59 -0400
Message-Id: <20211022140714.28767-7-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211022140714.28767-1-jim2101024@gmail.com>
References: <20211022140714.28767-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We do not use the result of this function so make it void.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 505f74bd1a51..d3e6d9df67b5 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1190,9 +1190,10 @@ static inline int brcm_phy_start(struct brcm_pcie *pcie)
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
@@ -1271,10 +1272,9 @@ static int brcm_pcie_get_regulators(struct brcm_pcie *pcie, struct pci_dev *dev)
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

