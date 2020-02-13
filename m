Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2E115B76F
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2020 03:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729531AbgBMC74 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Feb 2020 21:59:56 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38733 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729378AbgBMC74 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Feb 2020 21:59:56 -0500
Received: by mail-pg1-f194.google.com with SMTP id d6so2270080pgn.5;
        Wed, 12 Feb 2020 18:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FWL9gVxhHfG18kJOeUk3fD6tEj/BEQbVcbiFy71a6G8=;
        b=IIL6NVQFhgBPqd3xzyM73Ymzd0NxREmAFRHpKjqtuIsN+B3xEFuWU29pDGvgdkkn2P
         ZQ9nCD+p+ESw1phZlEumdMSDlfvOhTQmmDk+cX0eCgOMaNBrD6seyJgOXIZNZ3VNPGfn
         0cBJCkQL2IQVJaNNXFoOVjtPWmnn3/jqhZaWDLU6ty5TuvZTI9DGaSV/k6UdMtbYMtjL
         kw1AEQDUhCqmzw2uMz15tqbjhKceYNZPp++NIShvseX4oogtd8wsa+FAkG4C1t0XYL+O
         JbeL96iAUTbkrt+Y10SBG1bnq5uEVWpW49E5qgwrPDhmNYAGYCFiMFO6I1UUuzYoqZXb
         lkYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FWL9gVxhHfG18kJOeUk3fD6tEj/BEQbVcbiFy71a6G8=;
        b=NA8ISeOTXsAJ2TiYKuJpzaMGftHaIqLs7O54Rt2t27J5/u1QOvYTyQFcKYJznpQX+G
         DYdy1RcPrUdGHzAgHrXQ+IfU8J27WUZu4TGVXut+jYyo1WIYY8Rr2ME2MbirVRcfnoCA
         wA9RGir2OOxcm3NtuCfWTCGTqX2OQqlNh0gGDWjtXKDTaF77Yeh//VMeDSnaVppfYLES
         BuKTZlJOvfCz4HX8Nl4XdIJ5LdGgrdsT8W3V2L9a+12FM+PIVcFoGshcW5JTlAjTgOS6
         gWBisx+qk4b5tYhKgn4rBtKSOhOIHq6om8+kXWvjGKxnO5rHoZ5ylvWXj4TsZyXrYNZc
         gqtQ==
X-Gm-Message-State: APjAAAXaBoqjMg4CkeAEloQDeJYAdZzipa/QbVu1Ocy2ALu4wRy2Qav6
        py0aLCAytwmLElCMRx07rno=
X-Google-Smtp-Source: APXvYqwbqDHzihlVsSPDvVdo8SS90JnUF1N9IWw5udOtAYmfqHcjP5jqpmnQj6HQ7G3RHvmnhJ39kA==
X-Received: by 2002:aa7:9e0b:: with SMTP id y11mr12203202pfq.182.1581562795547;
        Wed, 12 Feb 2020 18:59:55 -0800 (PST)
Received: from localhost.localdomain ([125.130.116.2])
        by smtp.gmail.com with ESMTPSA id 64sm602643pfd.48.2020.02.12.18.59.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Feb 2020 18:59:55 -0800 (PST)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH 3/3] PCI: brcmstb: Drop clk_put when probe fails and remove
Date:   Thu, 13 Feb 2020 11:59:30 +0900
Message-Id: <20200213025930.27943-4-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20200213025930.27943-1-jaedon.shin@gmail.com>
References: <20200213025930.27943-1-jaedon.shin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

devm_clk_get* APIs are device managed and get freed automatically when
the device detaches. so there is no reason to explicitly call clk_put()
in probe or remove functions.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 0e0ca39a680b..3e48d9e238bb 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -972,7 +972,6 @@ static void __brcm_pcie_remove(struct brcm_pcie *pcie)
 	brcm_pcie_turn_off(pcie);
 	brcm_pcie_regulator_disable(pcie);
 	clk_disable_unprepare(pcie->clk);
-	clk_put(pcie->clk);
 }
 
 static int brcm_pcie_remove(struct platform_device *pdev)
-- 
2.21.0

