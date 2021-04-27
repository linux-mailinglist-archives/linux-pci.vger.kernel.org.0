Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C02DF36CAA0
	for <lists+linux-pci@lfdr.de>; Tue, 27 Apr 2021 19:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238665AbhD0Rwf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Apr 2021 13:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbhD0Rwe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Apr 2021 13:52:34 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1C4C061574;
        Tue, 27 Apr 2021 10:51:49 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id e2so26995441plh.8;
        Tue, 27 Apr 2021 10:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7XSm6/qzn9duNJgtAGMhBBSTeeaC2tU96ijTiVyfrw0=;
        b=ORiN/zPxZxhdaqsrIGlBT/ur3WfsLynWgmFPyXBf4D0Bm2D0t1Coryt9rFPBawWXNv
         X5hp3Ki0fH75da95sE5A/Fe1DZBMEGTWpTrQU6+BGFVujzcoYjHAwjncxp2B8kfZwz9t
         Ml0tnEqbzAacbRF+flA+YIlbJ6T8hFfea+n4T9KOenJZVmprB2yFehvwtOEfxlQGXm9n
         X3MkwWBjvRzbytfcS0M8thcVtrkM/kD8/Pp3YCBSJWtGUYAPTiqzKI/fiRvRLEX+32g3
         aw9+h+0Q7nQpRjvFi9OAnMsL7hohfAIQuejxsoZqGg+STUagRiRC6lMcaElpBZ7Iettb
         +KHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7XSm6/qzn9duNJgtAGMhBBSTeeaC2tU96ijTiVyfrw0=;
        b=sj8DkBeiAjhGYBV55kHW9ZZaN0J5Uf7vkgxZJnosyKwWIReGVYymwwrVVbz7skPH+v
         kaAXnV1YmFPonX/8r2utjWeXfUO5Ue8EXyNhQxGmcQQYTbaBMWzci065APwrG5raxvUy
         I+piDLJlmHcYpwFTnLGzCFEolUaeW3S+T3QUKhGfAw0/2tMh78eZ5M2KHRsKTamoAn8z
         OxFT8GZVt6X89t3XOwr7kLei2ah3t4c1vuRN6ltbfiId6REL/hCFl/1j8O/CBlhcQXA8
         LH42BH0x5TUW7Yyz52tIXzN47TvTcdwYu6BPWykMO5FdutcJ4ntBO47wiwq/jQIuv50F
         Derg==
X-Gm-Message-State: AOAM532/c8xZRS63X8db/ZyCXH9AX35rVGFeHHe2Jnsn+jlE1aIMoIW2
        HsmgN2q19oqXyuh9AN1n14REzqVb0so=
X-Google-Smtp-Source: ABdhPJyT7HZQNUAXFGxWL8hWisHDSfUuIwmbKZqKOedQH2FPNEW8cz8HwMCds+JC8D7s+KhXGY4TOA==
X-Received: by 2002:a17:90a:f195:: with SMTP id bv21mr6241676pjb.56.1619545909205;
        Tue, 27 Apr 2021 10:51:49 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id h21sm2456833pfo.211.2021.04.27.10.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 10:51:48 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jim Quinlan <jquinlan@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 1/4] PCI: brcmstb: Check return value of clk_prepare_enable()
Date:   Tue, 27 Apr 2021 13:51:36 -0400
Message-Id: <20210427175140.17800-2-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210427175140.17800-1-jim2101024@gmail.com>
References: <20210427175140.17800-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Check for failure of clk_prepare_enable() on device resume.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Fixes: 8195b7417018 ("PCI: brcmstb: Add suspend and resume pm_ops")
---
 drivers/pci/controller/pcie-brcmstb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index e330e6811f0b..4ce1f3a60574 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1161,7 +1161,9 @@ static int brcm_pcie_resume(struct device *dev)
 	int ret;
 
 	base = pcie->base;
-	clk_prepare_enable(pcie->clk);
+	ret = clk_prepare_enable(pcie->clk);
+	if (ret)
+		return ret;
 
 	ret = brcm_phy_start(pcie);
 	if (ret)
-- 
2.17.1

