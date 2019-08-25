Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 183939C660
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2019 00:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbfHYWKo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 25 Aug 2019 18:10:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45326 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728931AbfHYWKo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 25 Aug 2019 18:10:44 -0400
Received: by mail-wr1-f67.google.com with SMTP id q12so13416869wrj.12;
        Sun, 25 Aug 2019 15:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FSDaDPkwEDuhPwyp2tph1yu0z2JTeSJAZvKVpXGb/b4=;
        b=SYfe+LJIQxIUY6Yzw/uCtw32IfYh2xzQJidH53o0SLmHNQ5dydIffPk8LaV57MYJNV
         Xw6qt1/cj6rKvtgyDtEAucFnyqUUD8UyqIf/GBd+EsPHKqCeMho6m50+VWdZC6yPxZ9F
         6eqRJqKID8EzRkDjNhqICdBr81EnHMBsXQK+vhGQkjC8dzFqNLYGRWhnCQcNMHctC07s
         SpqNLcDV4J66Jojgl45FpM/zbdNCbiWqSB45kUYXWwpv+pXDmqSD5UU5w6m6lYujfEJn
         qJvTmp0YJITbS4Vd4vON/cG9sk+9aboYrmw9WBfNlgBh8P8dvA0XxN8z5dGVesQWmfnL
         xWQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=FSDaDPkwEDuhPwyp2tph1yu0z2JTeSJAZvKVpXGb/b4=;
        b=XM6aQKFLIc1wKpq+TNIBOXZLvwS1bsrE6455SDTkTXMWPy+507I+e+niUL9nZMPgbC
         6+GH5ALUNS0CcNQJAmAcsAiWMVoFhxmHrdDxGjcvMtBrIaRRXgsr62S/XvjgIkZenOWm
         f7NC8dXRYAntEs3pN/gM7P0KdPvBQoyC874w5h8OwZEC9ldqp1Onu/UCA1VWyEgKtmSG
         crr1LSkVloFZtLYpV0xA3ROFQgV+B6ChbqeyAyWLl9L4uGqLvy/tIBreoVvrG6sTQxN6
         hOETYQ/J8LCJVuOxFaiyGeDED0EWcJuLbYo/rI5KzzUs+CyoRFbSyVAlJ4DEN4XPKJfH
         lCJQ==
X-Gm-Message-State: APjAAAX4cw3eb3j8rmbs+yDH//a4wnOuQ9DSH8zT9JrslxvZEZFpFO1x
        P64yGsy0u4fTjY4eRsEXFwA=
X-Google-Smtp-Source: APXvYqxiGvZXVlVu/JaE0UslanWEGQOGDzHXiV60bRr5wjvX3RTgu5+0YA/diKHUOXLRsZzWY1BtPw==
X-Received: by 2002:a5d:4a11:: with SMTP id m17mr18371554wrq.40.1566771042170;
        Sun, 25 Aug 2019 15:10:42 -0700 (PDT)
Received: from localhost.localdomain (ip5b4096c3.dynamic.kabel-deutschland.de. [91.64.150.195])
        by smtp.gmail.com with ESMTPSA id r5sm8544562wmh.35.2019.08.25.15.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2019 15:10:41 -0700 (PDT)
From:   Krzysztof Wilczynski <kw@linux.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] PCI: mediatek: Remove surplus return from a void function
Date:   Mon, 26 Aug 2019 00:10:39 +0200
Message-Id: <20190825221039.6977-1-kw@linux.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove unnecessary empty return statement at the
end of a void function mtk_pcie_intr_handler() in
the drivers/pci/controller/pcie-mediatek.c.

The surplus return statement was added as part of
the work in commit 42fe2f91b4eb ("PCI: mediatek:
Implement chained IRQ handling setup").

Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
---
 drivers/pci/controller/pcie-mediatek.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 3eaa7081ab2a..626a7c352dfd 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -635,8 +635,6 @@ static void mtk_pcie_intr_handler(struct irq_desc *desc)
 	}
 
 	chained_irq_exit(irqchip, desc);
-
-	return;
 }
 
 static int mtk_pcie_setup_irq(struct mtk_pcie_port *port,
-- 
2.22.1

