Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27EC2733C4
	for <lists+linux-pci@lfdr.de>; Mon, 21 Sep 2020 22:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbgIUUp6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Sep 2020 16:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbgIUUp5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Sep 2020 16:45:57 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D84C061755;
        Mon, 21 Sep 2020 13:45:57 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id s13so834211wmh.4;
        Mon, 21 Sep 2020 13:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9E/JMX1u9DMUuutSlm9kiJDKX4f6Y4qT6IOADWiSiVU=;
        b=LWgNuVhb/ir9Jw9EmxgJOL6qMTGPKiuOJ5BYMHsy4oO8iPOD5LYu+I5NAmJiy5mO3v
         PZZyZTaUn60arUGZB5ggzcRe8NA0D6RkJUUi0eDkKL6RGHhVY/f01hb41xmwaXDL2PA2
         a3eg9q8BmLHeQ0gIC+GFi/2Gn4ZEROsoR4QoWCIdELJ0f4PiiEgRbLs0u7t3yu6/Hc/B
         yOj25tfCH7kz5FCU6SmDCf6QC2OXrfHjg5hCs/qUIz3vF0usTiRbkjjCPG4S06UnZPBW
         4xtvkm6ZXMRB/gdhs8cxm6Q04jLXwcERfG+CQm9qkkATNZDDixVCXievspJjPZLqAGI2
         TtNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9E/JMX1u9DMUuutSlm9kiJDKX4f6Y4qT6IOADWiSiVU=;
        b=tX8hvtjtlRMNhAvFhN/cC9LM1F+FToY8k/hpat0fdr6pEsMlreuIDPAaTS/JwrTU5v
         Q8kKtis3o0dj7OnndyQnSLEBmUzG1gosDBE84dsM2vaCaRZOwryMZHeRxqobUZpBLV4P
         WfTxKoF8Jca3Pd05p9yeyvCEIYQXdcvhxC3EepQhjomhT962MK+V+UteP0s/9nPCQUKI
         W3qbCQNkH+QwAx1KmrQ1TunaVkEAqS6TFwFAtrDv4BAlxgJ8pg5p44FfXCq1oy4U6vDV
         NWZBkfbQBnWorWwBFgi+wsMDGCYM31IgeENzLQ0j2KIWdgxTXaqjZnalFR3kKlSTwehf
         zdxA==
X-Gm-Message-State: AOAM533XF62AECfKJdVBSr2h4dWHTKQSLSWI99zPmLMbAtH9+aGC90R1
        XpjXz9xviyIQiYHhDvvihvlAs3gnCNYQQgVa
X-Google-Smtp-Source: ABdhPJzUu7oX6IPa7VQqGzn9y2wrOaGOqYEWYwmE69lXq28RQqiH/FVIN3BqMIM6zrmbhtuiq1E3Gw==
X-Received: by 2002:a1c:3d44:: with SMTP id k65mr1061112wma.132.1600721156135;
        Mon, 21 Sep 2020 13:45:56 -0700 (PDT)
Received: from localhost.localdomain (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id k8sm22015682wrl.42.2020.09.21.13.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 13:45:55 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
X-Google-Original-From: Alex Dewar <a.dewar@sussex.ac.uk>
Cc:     Alex Dewar <a.dewar@sussex.ac.uk>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Jim Quinlan <jquinlan@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: brcmstb: Add missing if statement
Date:   Mon, 21 Sep 2020 21:45:50 +0100
Message-Id: <20200921204550.29296-1-a.dewar@sussex.ac.uk>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

brcm_pcie_resume() contains a return statement that was presumably
intended to have an "if (ret)" in front of it, otherwise the function
returns prematurely. Fix this.

I don't know if this code was tested or not, but I assume that this bug
means that this driver will not resume properly.

Fixes: ad3d29c77e1e ("PCI: brcmstb: Add control of rescal reset")
Addresses-Coverity: CID 1497099: Control flow issues (UNREACHABLE)
Signed-off-by: Alex Dewar <a.dewar@sussex.ac.uk>
---
 drivers/pci/controller/pcie-brcmstb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 7a3ff4632e7c..cb0c11b7308e 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1154,6 +1154,7 @@ static int brcm_pcie_resume(struct device *dev)
 	clk_prepare_enable(pcie->clk);
 
 	ret = brcm_phy_start(pcie);
+	if (ret)
 		return ret;
 
 	/* Take bridge out of reset so we can access the SERDES reg */
-- 
2.28.0

