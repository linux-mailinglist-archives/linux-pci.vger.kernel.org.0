Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23704182218
	for <lists+linux-pci@lfdr.de>; Wed, 11 Mar 2020 20:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731161AbgCKTTn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Mar 2020 15:19:43 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41693 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730807AbgCKTTm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Mar 2020 15:19:42 -0400
Received: by mail-pg1-f193.google.com with SMTP id b1so1712040pgm.8;
        Wed, 11 Mar 2020 12:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6tx20opC58CZx8EHUzpcUW3v0td0yDhkgy01mmgvT1k=;
        b=CozuzMqFhVkFE6pdK3cIh6s0uXsG2lK7hYQy5IVZtcQmUzBEAvs4Pb139yfhgUcRa9
         N2kLzQ5SjJ4V/dJTw7i+GKo/N1pv+gZxM58WXszNGBoQKI+uMjTkQV8zbt4kF/2vH6H5
         NJvfcNhZFERyJC3It01naJmHSsln6g6kKl1vzNrulqq5LAHF4wgNhbVyandZgnizxIO/
         cJgnDsnDD40sItIySZNC+HviwpK2K4wwHsgCEN7CPG5wC+lgXKwLhWQretoqWOKfhmxk
         PpPlksn5E6jm5/jvgOte7D5wpDz3s+voxXT0SDhgnRs5al+E5xvjKdYFYNU988j+8gtz
         FAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6tx20opC58CZx8EHUzpcUW3v0td0yDhkgy01mmgvT1k=;
        b=jIgFx/QtIYgwYFdeAPXgprbyjO6ZrfFL18SiaZN7X3f53cLMpFBKGnbi3BbaqIit/q
         pESNyh+pD4zSV/ki3TfG4XNqjXcR4zK/Iaow357Sgk96YXhozYMom6HiR9DWTAecja9+
         HDenUvmU04XVTT7arLGBXyF8Ti+JRWuF0EI6CL6gsfkbAztA+Ga2mDkrP6OzatVDYLuV
         OobbN9jH4LGZZNBGe2W8uRhB8Prp2H0HrUq90AyToV5L6h6l8YZGhl91TGthxTjnHHMD
         LHG9BLv6lQPoENukIjQnBEjrFnE+nROWMlBeY66gY32ifrLx7Vh50A8brWNDX7aEXXQJ
         F4ww==
X-Gm-Message-State: ANhLgQ2VoxplZqDbwY3Gec1BAri3q1OXmFf8f+hErz3fh0TCJCr3Aq6u
        IDJkKIejlVGJpoHFrKSq/kM=
X-Google-Smtp-Source: ADFU+vuIATg8TgONqQwj07uaBbQTUtMOLI517xnn/BWXZKYW/0G/Tlqgwm379phb/QVQVuzVzgf6SQ==
X-Received: by 2002:aa7:90cc:: with SMTP id k12mr2456493pfk.94.1583954381475;
        Wed, 11 Mar 2020 12:19:41 -0700 (PDT)
Received: from localhost.localdomain ([103.46.201.94])
        by smtp.gmail.com with ESMTPSA id z17sm3792673pff.12.2020.03.11.12.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 12:19:41 -0700 (PDT)
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
Subject: [PATCH 5/5] pci: added check for return value of platform_get_irq
Date:   Thu, 12 Mar 2020 00:49:06 +0530
Message-Id: <a36999aa5c567c65ddfaf0b54406e8583343a510.1583952276.git.amanharitsh123@gmail.com>
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
 drivers/pci/controller/pcie-mediatek.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index cb982891b22b..ebfa7d5a4e2d 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -651,6 +651,9 @@ static int mtk_pcie_setup_irq(struct mtk_pcie_port *port,
 	}
 
 	port->irq = platform_get_irq(pdev, port->slot);
+	if (port->irq < 0)
+		return port->irq;
+
 	irq_set_chained_handler_and_data(port->irq,
 					 mtk_pcie_intr_handler, port);
 
-- 
2.20.1

