Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1433041E5AD
	for <lists+linux-pci@lfdr.de>; Fri,  1 Oct 2021 03:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349760AbhJABSM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Sep 2021 21:18:12 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:39926 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350757AbhJABSM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Sep 2021 21:18:12 -0400
Received: by mail-wr1-f42.google.com with SMTP id d26so12860861wrb.6
        for <linux-pci@vger.kernel.org>; Thu, 30 Sep 2021 18:16:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RQiSJdCX0tlMnA3Q7WCH9Xmfl+JtRrBqDMyYICSkAbo=;
        b=5ce2rn9ghYfty1K0Ard1nMFKMWkDbRo1Lkj1PtEKOUNDCGwUa9m2VLz5hj9b+3UHzZ
         kORDjKaq8wE4CUpjUhZo9r4AT25g4D/ivkRoh+OgNKN77fST7UiOEwTktC0M5YQdMdFZ
         GbqfEW4ipdzrvUEdHg6gb7t3Q3QzeiC9XYILvxVJ5SOAAon1Mk8oruMBegpQu1XRXa+W
         YbOEYmm2uWXIMw/DFGeHf0+MA/gsj9wb1WbyG30eNCYSKxmWCdEcfT+suAiHbbtpKbB3
         KUYX8RRJKqMZNW6z/zNhQHH+22vRJ79KP9WJQA7MA6eR2QT+bc5TcUyFOjAFTOQa2n3w
         QFEQ==
X-Gm-Message-State: AOAM533CL7ef41PNyE7gOOV/Do6THQ3z4e3yh5rJXDhhBwXxGH6WCaP1
        cIGp/WwrCi2aI7ZLTV8/YQI=
X-Google-Smtp-Source: ABdhPJwJHiwe6vHkBlQrFnGM5Qik5kVAk8M2QlgWYmNtSKfhtb08Ck/KIvvcO3jLGbCBHBhoz+Zq+w==
X-Received: by 2002:a5d:684f:: with SMTP id o15mr9632187wrw.268.1633050988181;
        Thu, 30 Sep 2021 18:16:28 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id q9sm3629217wrx.4.2021.09.30.18.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 18:16:27 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] PCI: visconti: Remove surplus dev_err() when using platform_get_irq_byname()
Date:   Fri,  1 Oct 2021 01:16:26 +0000
Message-Id: <20211001011626.132286-1-kw@linux.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There is no need to call the dev_err() function directly to print a
custom message when handling an error from either the platform_get_irq()
or platform_get_irq_byname() functions as both are going to display an
appropriate error message in case of a failure.

This change is as per suggestions from Coccinelle, e.g.,
  drivers/pci/controller/dwc/pcie-visconti.c:286:2-9: line 286 is redundant because platform_get_irq() already prints an error

Related:
  https://lore.kernel.org/all/20210310131913.2802385-1-kw@linux.com/
  https://lore.kernel.org/all/20200802142601.1635926-1-kw@linux.com/

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/controller/dwc/pcie-visconti.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-visconti.c b/drivers/pci/controller/dwc/pcie-visconti.c
index a88eab6829bb..076da46726a7 100644
--- a/drivers/pci/controller/dwc/pcie-visconti.c
+++ b/drivers/pci/controller/dwc/pcie-visconti.c
@@ -282,10 +282,8 @@ static int visconti_add_pcie_port(struct visconti_pcie *pcie,
 	struct device *dev = &pdev->dev;
 
 	pp->irq = platform_get_irq_byname(pdev, "intr");
-	if (pp->irq < 0) {
-		dev_err(dev, "Interrupt intr is missing");
+	if (pp->irq < 0)
 		return pp->irq;
-	}
 
 	pp->ops = &visconti_pcie_host_ops;
 
-- 
2.33.0

