Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0D3D429691
	for <lists+linux-pci@lfdr.de>; Mon, 11 Oct 2021 20:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234208AbhJKSOI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Oct 2021 14:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234137AbhJKSOI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Oct 2021 14:14:08 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BF8C061570;
        Mon, 11 Oct 2021 11:12:08 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id pi19-20020a17090b1e5300b0019fdd3557d3so576434pjb.5;
        Mon, 11 Oct 2021 11:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iKrtrnYSDksMWdgmUznUR/Q64gwdi8mvvQO4UVqOm9E=;
        b=NQPnwh11904uP3h5MegadAiUsEzmbr+NUC4xCBkOzr+acrFXxgnv0RNH7jFvtGanJO
         cBm3WB/xAM+YFWw287it0yRRp3GQf9P9YtTaV4emKba4RjNycwNAHbPLJWdbCy6AFboo
         wx1h+1QQEH8pblTlSf2sG1gOLY1347ErCVOeLsziBXFTWdfwacXEtaMZGrm6Cz7cXtIT
         r4fxsDhs6CBh3LMFrMY1esGlZV5A593L2X8rc6D1w3karLOqVBcqPlGU2CxfW4E18HJo
         8HQOL3ivDL3Zg+gO5ymn8arHG4w8Ls7u5F9UIFzKokeyMim/pCB6kU1GfC0jfHCidAT/
         nIIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iKrtrnYSDksMWdgmUznUR/Q64gwdi8mvvQO4UVqOm9E=;
        b=aI8sF0LeMZIRqHDtoa56fCMSvpS+c2EaDDuwOiTJQ/O+7UieR43wjsQQaIGxZdXIsB
         j+SklPbz3SIpEwYpW0h6it8HjHt2Uv7krucWzFJtaoTpEjetFlZqHCPevFIz8v1GCHFg
         wtLzjBZGvAXeljq+uHx0qE9ErkfNAitRjVuhz83l/oStbCVTpzOwThq16UjrIVsEuiYB
         zaxH/gyVUpgzUxSe6X3AXxi1BKEFCYDIdp1tBytyEXKg3CV558AoqVyYjTq3gwHq/9wx
         y/ntFvwjdEfDEBZwQr5mINk8T4Rup+SC+jopGA7oOE0pRUKpMxfpX+bUIfmBwe2rQg2y
         HCHw==
X-Gm-Message-State: AOAM531WIkyGTZB/0vp27MmeKEPuiSHcLyDI4ndolOtqWLx0IFiYU/en
        IgGfvqdrySGhYb8+E6dkWVw=
X-Google-Smtp-Source: ABdhPJyOTFBZTe7riUZlUFC2nl/siIMfDTnUL5JGaxiyNZmPOd0W33SnqGWyjMYbUnoJELtkDWBwqA==
X-Received: by 2002:a17:90a:e552:: with SMTP id ei18mr518809pjb.239.1633975927732;
        Mon, 11 Oct 2021 11:12:07 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:9f95:848b:7cc8:d852:ad42])
        by smtp.gmail.com with ESMTPSA id r130sm8508875pfc.89.2021.10.11.11.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 11:12:07 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH 20/22] PCI: keystone: Use PCI_ERROR_RESPONSE to specify hardware error
Date:   Mon, 11 Oct 2021 23:41:52 +0530
Message-Id: <01c86d23327e28ee6d09daa01538f1a12f9e4d11.1633972263.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1633972263.git.naveennaidu479@gmail.com>
References: <cover.1633972263.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Include PCI_ERROR_RESPONSE along with 0xffffffff in the comment to
specify a hardware error. This helps finding where MMIO read error
occurs easier to find.

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 865258d8c53c..25b11610b500 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -748,8 +748,8 @@ static int ks_pcie_config_legacy_irq(struct keystone_pcie *ks_pcie)
 #ifdef CONFIG_ARM
 /*
  * When a PCI device does not exist during config cycles, keystone host gets a
- * bus error instead of returning 0xffffffff. This handler always returns 0
- * for this kind of faults.
+ * bus error instead of returning 0xffffffff (PCI_ERROR_RESPONSE).
+ * This handler always returns 0 for this kind of faults.
  */
 static int ks_pcie_fault(unsigned long addr, unsigned int fsr,
 			 struct pt_regs *regs)
-- 
2.25.1

