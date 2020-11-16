Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15D522B4B94
	for <lists+linux-pci@lfdr.de>; Mon, 16 Nov 2020 17:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729849AbgKPQqG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Nov 2020 11:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbgKPQqG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Nov 2020 11:46:06 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29A7C0613CF;
        Mon, 16 Nov 2020 08:46:05 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id m125so12937392wmm.3;
        Mon, 16 Nov 2020 08:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UxQzYGybcAbsNf4mOByFctsQCkAbGLdmDSJjJAk7FOc=;
        b=ApjATx2it5+m4cfmlx0/VFH1Oix0L++GsWH3Jt951tXd10nY70CorcEPPaThqVwWq2
         fT2KrKebl0yOldf6DdUpGgrLiqTVNpk4tX6KlUyc3MF9pA/q7SqaWjFKfsoaf5Ghpf3G
         aTjxKGeKkEstLxdXSpCtFzxmxLtHEJ1yqW3x6Zhk/GJkqThe99sW+lSiU6akIXRajDxZ
         CZ9wURHzr3MzVIsdgwxywUTOXYQxALvzAqY55X95MbLNue3E2/U1BacyiTlQUBnT+Tp9
         cdwkt5T8eWDclJkOVlbL5ZoyNnN82zAUovBKn2MFl+k2H9gyvT9uAHD0aWVn/K0q0V1e
         iOGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UxQzYGybcAbsNf4mOByFctsQCkAbGLdmDSJjJAk7FOc=;
        b=YHmOvQcNhQl2FJuNrAbEV+i9NH/2qWeaVf29uikpYm8fWG8nN7ZzIT/2skGlyTLvuc
         H6Z2qmrb4e4atnVWkbXxTcacF5qjwCf5CHxXYtV+MdE/yatskZH0DGoBPVLptkoZVVdi
         gmhZBw5z7CpEcKgEtJZS4UkbghL8ThDaEmvgtxCjkym++uxx6l1FpcxkdO3uN3Pz0eHj
         xEze964911w2l5LTYjDmvND8ngu41x/x5XPT+h2Ge2CGIlo7/mMksjpp42vjnZJwgUKw
         7P5oNdxoYjVlSD1xsWwEWV7Fh9f0q8q62uxcUdOKFbUTK8pBW3q1irPIlkJO0OwcpLRd
         MRJw==
X-Gm-Message-State: AOAM5315MdxuypGa9gCy5aiX8INMe1FT4rpF65C2yviRjTRPycBfZWVC
        yRIbDNQHWAqmPuZEUu8QhaQ=
X-Google-Smtp-Source: ABdhPJwD1s7s/I8WEIMIvIvEQxdYCZHJSKfLtVGLhAA/ktz7sT7W5D/wq39cv78EJFhYAfeMr8CHIg==
X-Received: by 2002:a1c:9ec9:: with SMTP id h192mr16265589wme.8.1605545164609;
        Mon, 16 Nov 2020 08:46:04 -0800 (PST)
Received: from localhost.localdomain (host-92-5-241-147.as43234.net. [92.5.241.147])
        by smtp.gmail.com with ESMTPSA id g23sm20465568wmh.21.2020.11.16.08.46.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Nov 2020 08:46:04 -0800 (PST)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-safety@lists.elisa.tech,
        linux-pci@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] PCI: dwc: kirin: Use PTR_ERR_OR_ZERO
Date:   Mon, 16 Nov 2020 16:44:03 +0000
Message-Id: <20201116164403.25289-1-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Coccinelle suggested using PTR_ERR_OR_ZERO() and looking at the code,
we can use PTR_ERR_OR_ZERO() instead of checking IS_ERR() and then
doing 'return 0'.

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/pci/controller/dwc/pcie-kirin.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index d0a6a2dee6f5..cf1379a8b950 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -138,10 +138,8 @@ static long kirin_pcie_get_clk(struct kirin_pcie *kirin_pcie,
 		return PTR_ERR(kirin_pcie->apb_sys_clk);
 
 	kirin_pcie->pcie_aclk = devm_clk_get(dev, "pcie_aclk");
-	if (IS_ERR(kirin_pcie->pcie_aclk))
-		return PTR_ERR(kirin_pcie->pcie_aclk);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(kirin_pcie->pcie_aclk);
 }
 
 static long kirin_pcie_get_resource(struct kirin_pcie *kirin_pcie,
@@ -169,10 +167,8 @@ static long kirin_pcie_get_resource(struct kirin_pcie *kirin_pcie,
 
 	kirin_pcie->sysctrl =
 		syscon_regmap_lookup_by_compatible("hisilicon,hi3660-sctrl");
-	if (IS_ERR(kirin_pcie->sysctrl))
-		return PTR_ERR(kirin_pcie->sysctrl);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(kirin_pcie->sysctrl);
 }
 
 static int kirin_pcie_phy_init(struct kirin_pcie *kirin_pcie)
-- 
2.11.0

