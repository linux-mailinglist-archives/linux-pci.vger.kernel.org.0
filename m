Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 546E143C894
	for <lists+linux-pci@lfdr.de>; Wed, 27 Oct 2021 13:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241625AbhJ0Lb7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Oct 2021 07:31:59 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:56287 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237421AbhJ0Lb7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Oct 2021 07:31:59 -0400
Received: by mail-wm1-f47.google.com with SMTP id v127so2274488wme.5;
        Wed, 27 Oct 2021 04:29:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gbWuQswWTVQ5Wg/Yf89rody666YL6CcVZyTJbqgR1aw=;
        b=KbAilecw61A15yii5vx6v7tW+vWwnIPzhSH98rldRJNyk3Kkh9B1lEKJoQmCMaGMrU
         l/8nxi//JAxADPp1aokBmvt03Wp8433fgGgl8dP6uCeI0SAp5iOYPetUPWL2H7C+acQM
         wAH8x3X0ERfnuVCcxka//fe1kvx0Pph4hipo6afJf2w+4h43d+YpWx7gqiVj1vuzjMcs
         N15PndWjw+oEMvx4zAO6IRzcWOkM8JBlw0eWmftJskO1Q5nuTUUrLlAsO7hrJlbhm/vn
         1mIdbP/My8PqguGjV4xUjMVLncbuvSbzzBmidJQa1hg4ZXwpl6kusK589+AXmt/ZOVZQ
         zbWQ==
X-Gm-Message-State: AOAM531wUEHaLS8G1TGDw4GRWVopPKIT2HDChqKm4ohPWzIfS+R0FYQx
        avi0qib4qCB42T4Vzi4hL3U=
X-Google-Smtp-Source: ABdhPJw1MlEDdjLLITbfvO9rKXbGZO21TE52uVdIbDZol0QmosqRiwgsxt1yg4w9TTYQxUQ1MrYaiQ==
X-Received: by 2002:a7b:c7d6:: with SMTP id z22mr4976154wmk.65.1635334172793;
        Wed, 27 Oct 2021 04:29:32 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id 3sm3329521wms.5.2021.10.27.04.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 04:29:32 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH linux-next] PCI: qcom-ep: Remove surplus dev_err() when using platform_get_irq_byname()
Date:   Wed, 27 Oct 2021 11:29:31 +0000
Message-Id: <20211027112931.37182-1-kw@linux.com>
X-Mailer: git-send-email 2.33.1
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
  drivers/pci/controller/dwc/pcie-qcom-ep.c:556:2-9: line 556 is redundant because platform_get_irq() already prints an error

Related:
  https://lore.kernel.org/all/20210310131913.2802385-1-kw@linux.com/
  https://lore.kernel.org/all/20200802142601.1635926-1-kw@linux.com/

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 7b17da2f9b3f..cdabd514dcc1 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -552,10 +552,8 @@ static int qcom_pcie_ep_enable_irq_resources(struct platform_device *pdev,
 	int irq, ret;
 
 	irq = platform_get_irq_byname(pdev, "global");
-	if (irq < 0) {
-		dev_err(&pdev->dev, "Failed to get Global IRQ\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 					qcom_pcie_ep_global_irq_thread,
-- 
2.33.1

