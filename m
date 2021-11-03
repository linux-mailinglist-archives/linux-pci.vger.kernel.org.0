Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1EF44489F
	for <lists+linux-pci@lfdr.de>; Wed,  3 Nov 2021 19:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbhKCSwp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Nov 2021 14:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbhKCSwj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Nov 2021 14:52:39 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EC6C061208;
        Wed,  3 Nov 2021 11:50:02 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id g184so3156891pgc.6;
        Wed, 03 Nov 2021 11:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qT6D8z9EWM5nbqoODMsf6pYhfTqAM6D4oAkvj8nPzI4=;
        b=kT4+I28b80Hx+pwNuGDFDshF/1eR9612Hjb09D99u7P60J+2XEhPtO0SwamVqVk8qy
         mAiTjhfhFBsH2uf7SaucFkvYpHbA+Z3bMa51gajLIy7b27EZIU8av3Ymya58ye9Zfxg4
         jSl2eACif4DN1bi/QVqpIGb3IbxRJ8cclPEk67g3RcpLHW0LOsjJyrfuCZUOvi9gRYAj
         lPcijjwKa/fl2PbmCJ7kdzOIAwouBXNVt6H7C6TgKD56oeXIpUrfsrzfpdcBCbOOZHz3
         GnnFxfNEIr+BsIL6moW7Q0YKDAG2wjhdDknObRBgjnG//MTG9TKG4xRkxGq3gnSAi3vT
         Kmuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qT6D8z9EWM5nbqoODMsf6pYhfTqAM6D4oAkvj8nPzI4=;
        b=SEfFaE44fxtaZrpExKDyZQc3vVoJYkc95b5dzyudHBzGbF7KfT0P/seOxcZWquewNk
         CqUhFpLMmfPCDIb41P4EbmUsmwxnG5SNbtfR6f1Vq0h5wrThGiSy1IrNUTE5fT+dBy0M
         KVRc8lGDMttfAfxozfX700htTgwzgEMxxmNars5uiZ8qs+fGSRvcsBhNXhAUpb1gvdJw
         c4nqBqI/N1GaqfWvrbMNkPXm2tQ7i5R51gWsyoLKf7Auv8AsMQToOsMi9ugYvfGztvNF
         uJrsMTscON0NGeAYae7LtnjRI0XB4lVMHroRJH/1x9uKkl2I7yiiYqkvzzc6k/QLU4hr
         bXNw==
X-Gm-Message-State: AOAM531fD+WtWbjQgjTtxXi119Fw0FcH35YEAuCXU/XJc2lMd/wdKlrI
        1IHEx9QVpyUj7SJ00Sw4/4S+os3M2I+kYg==
X-Google-Smtp-Source: ABdhPJy+7EOGlv8SCRA+dshz00FJ/GQ3infaDey2A4rnwN3sb7znxUN4xm8S3OhuxlKNlU27ryNIew==
X-Received: by 2002:a05:6a00:21c2:b0:44c:fa0b:f72 with SMTP id t2-20020a056a0021c200b0044cfa0b0f72mr46346157pfj.13.1635965402040;
        Wed, 03 Nov 2021 11:50:02 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id j6sm2379065pgq.0.2021.11.03.11.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 11:50:01 -0700 (PDT)
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
Subject: [PATCH v7 7/7] PCI: brcmstb: Change brcm_phy_stop() to return void
Date:   Wed,  3 Nov 2021 14:49:37 -0400
Message-Id: <20211103184939.45263-8-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211103184939.45263-1-jim2101024@gmail.com>
References: <20211103184939.45263-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We do not use the result of this function so make it void.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 9aadb0eccfff..5eabbd72e5b8 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1200,9 +1200,10 @@ static inline int brcm_phy_start(struct brcm_pcie *pcie)
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
@@ -1273,10 +1274,9 @@ static int brcm_pcie_get_regulators(struct brcm_pcie *pcie, struct device *dev)
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

