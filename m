Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA0DD182213
	for <lists+linux-pci@lfdr.de>; Wed, 11 Mar 2020 20:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731123AbgCKTTb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Mar 2020 15:19:31 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46452 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730807AbgCKTTb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Mar 2020 15:19:31 -0400
Received: by mail-pl1-f193.google.com with SMTP id w12so1524186pll.13;
        Wed, 11 Mar 2020 12:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=02Tw1k2Q38WueLNikGUX0EcXKDMIWen5M9i6gPM5Zj4=;
        b=avwLSbYPrJFeGMWyeeJPgpyMc6eZIgulQvJJACFk8LWJ7HzV7HO8ikUbQSac0O2Soj
         /RjNmGzqh3cSgVBNRF8SWz0kd1JNjiwKtfzfdTlHW6eG09Sf04ZE2X2+P2mBinSoSbEd
         ZtbV8rrBa9wwNAw6uF+WKE5ZC5z+jqKmGAHILwskaowFvMVSkx5YuY+cGwn7VknnDL2a
         JWrihz0fTOXoLdKzTc7yZvZ4/gbWPExseEhqgLuMa3bmlmkHOEe42v5iSpOwJoWoVo1k
         CEbqUOOP4ESOlvpND9fptc3xDLYda6kFYg0dH4XM6NlQYMk5E8nYUFstmTKAQg84fTr4
         BRhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=02Tw1k2Q38WueLNikGUX0EcXKDMIWen5M9i6gPM5Zj4=;
        b=FjCJZsS386js8A+aO8nl0MgDzJ09qJm6dhfOQ97RmhpQU+8zNmI6joLMMnmBFp+I/b
         rdtCGhoFR4/wNHZnMw/aDIf2dt3fR/O/daIdZg0gqe5LTKrNETcQmpNV/Ip7g2V5TtTg
         S/HYBuGVhYmIAOp0fd3HLoN0V8jvr9R/NskoBAhwBarumLXXLJEdLGDa3UnDqQm+hxJ1
         W8BLsz9ggOrNYvOgz808T44EsJ0oDlZ5EkKTT66koF+yqyviiEI4snx0w9nqkeIIXpZm
         NCq8E1fUnKozkqTT2xbe5l/nnb4pEa01gJZvEzDicdDZNaptDHmHkhMieCZpKiDQ+Z7i
         +hQw==
X-Gm-Message-State: ANhLgQ1TqjbMXg5sjMclZxGgvuYrgHmUnY7uomTMwk/pAz5AdnT/wFcw
        aKywOzdx+98kCyk9q9RDSq0=
X-Google-Smtp-Source: ADFU+vtd+b65PXv741B2Xvl/VY102ZDKa3qJON+wOaBSCOeGYGNq4QbLyV54jjgen3Er7PN+hX2uRA==
X-Received: by 2002:a17:902:ab95:: with SMTP id f21mr4077798plr.188.1583954370555;
        Wed, 11 Mar 2020 12:19:30 -0700 (PDT)
Received: from localhost.localdomain ([103.46.201.94])
        by smtp.gmail.com with ESMTPSA id z17sm3792673pff.12.2020.03.11.12.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 12:19:30 -0700 (PDT)
From:   Aman Sharma <amanharitsh123@gmail.com>
Cc:     amanharitsh123@gmail.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH 3/5] pci: handled return value of platform_get_irq correctly
Date:   Thu, 12 Mar 2020 00:49:04 +0530
Message-Id: <9e2c5bf46fe04e27ead8d559425fb97231777ee1.1583952276.git.amanharitsh123@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1583952275.git.amanharitsh123@gmail.com>
References: <cover.1583952275.git.amanharitsh123@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Signed-off-by: Aman Sharma <amanharitsh123@gmail.com>
---
 drivers/pci/controller/pcie-mobiveil.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
index 3a696ca45bfa..fe816a284dd4 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -456,9 +456,9 @@ static int mobiveil_pcie_parse_dt(struct mobiveil_pcie *pcie)
 		pcie->ppio_wins = MAX_PIO_WINDOWS;
 
 	pcie->irq = platform_get_irq(pdev, 0);
-	if (pcie->irq <= 0) {
+	if (pcie->irq < 0) {
 		dev_err(dev, "failed to map IRQ: %d\n", pcie->irq);
-		return -ENODEV;
+		return pcie->irq;
 	}
 
 	return 0;
-- 
2.20.1

