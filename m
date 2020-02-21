Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFC65166DD3
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2020 04:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729696AbgBUDhD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Feb 2020 22:37:03 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:33203 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729691AbgBUDhD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Feb 2020 22:37:03 -0500
Received: by mail-pj1-f66.google.com with SMTP id m7so1764832pjs.0;
        Thu, 20 Feb 2020 19:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MQI6dN+4PBzk1/anoQEUjOXCECLTTq4y88gpWsBl5rw=;
        b=WeHM7b1NSXrCkGyfOu5li5dmhsi+Y/ROL1MK21RIJYJuu2i4jXqwQYNj0n2kJuX2FZ
         gH8wNpV+1bbKjwA5j5C8IXC1E9/Ze0q6JoPMDjkdv74l5hzLeoMJgvtAa8kiZX7dCkZL
         D1XfhSASo03xavGFUO35gZehvuUmBpvapLXqTN6MSOuGpdtwqQbvyqnbYVhjB46DXbWD
         oqcPovL1HZJvs6cB1YmfcEQr695WDFhSc1yt7lPvTuGbRN1b7ykFTn7fhCkQFmCFJNiA
         gVYrWQBpqmWUx8M0diyxEpfhqnVwXa4O3bgGmTSc8XKs2JqNA/NZzDljcxUc53j+jmXc
         2/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MQI6dN+4PBzk1/anoQEUjOXCECLTTq4y88gpWsBl5rw=;
        b=qTMEbrGMlgvrlsfxVcY1kul7h77sjpNAFYf+7dLfOy5yIST8VsBevkIJ2Ll71kFpOr
         GkV7wcuBmyW5kto2efIQ0kyEMnHulp6NehNwFE/Jh/vkF79W///Z++Cgys4QCnz8HZpz
         GqDDhLF8PsLfB+mjvd7cNPkunSod45wOD3uPXDagDfDhPwSryAxSiPWpxUfL4Vg/Hl4o
         HKHkwKYBYozoXmj9G0AkH40nVLOk+DhsOnDPyBw4V5bjs5QTnTDJwTp9YWfw8klA1uZT
         sp+/wdmfSy+oU5JHyk3HngtQExSHvOZeMFoOC9luInkxzhI+CME/yz9iO2wOzlhJTJSk
         F/WA==
X-Gm-Message-State: APjAAAXV41PMmqW4lEqjsqYWWnRwkQoJHb04A/7T4NOe9PTUl8EdIMuP
        EEu/7FsdGtSL6FO91ojChDs=
X-Google-Smtp-Source: APXvYqykvUoLlW7NO8euEPeHez45sGEO4baJDRrs1oZO/OYTsr1gvou/USM/aUTtuuyFqcaqzHZrSA==
X-Received: by 2002:a17:90a:d804:: with SMTP id a4mr533465pjv.11.1582256222369;
        Thu, 20 Feb 2020 19:37:02 -0800 (PST)
Received: from localhost.localdomain ([125.130.116.2])
        by smtp.gmail.com with ESMTPSA id d4sm781340pjz.12.2020.02.20.19.36.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Feb 2020 19:37:02 -0800 (PST)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Mark Brown <broonie@kernel.org>
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
Subject: [PATCH v2 2/2] PCI: brcmstb: Drop clk_put when probe fails and remove
Date:   Fri, 21 Feb 2020 12:36:40 +0900
Message-Id: <20200221033640.55163-3-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20200221033640.55163-1-jaedon.shin@gmail.com>
References: <20200221033640.55163-1-jaedon.shin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

devm_clk_get* APIs are device managed and get freed automatically when
the device detaches. so there is no reason to explicitly call clk_put()
in probe or remove functions.

Fixes: c0452137034b ("PCI: brcmstb: Add Broadcom STB PCIe host
controller driver")
Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/pci/controller/pcie-brcmstb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 8968ef7fa55d..cbb587eb8d39 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -903,7 +903,6 @@ static void __brcm_pcie_remove(struct brcm_pcie *pcie)
 	brcm_pcie_turn_off(pcie);
 	regulator_bulk_disable(pcie->num_vregs, pcie->vreg_bulk);
 	clk_disable_unprepare(pcie->clk);
-	clk_put(pcie->clk);
 }
 
 static int brcm_pcie_remove(struct platform_device *pdev)
-- 
2.21.0

