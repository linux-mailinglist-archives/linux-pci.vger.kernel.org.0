Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A00B2333D8B
	for <lists+linux-pci@lfdr.de>; Wed, 10 Mar 2021 14:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhCJNTq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Mar 2021 08:19:46 -0500
Received: from mail-wr1-f42.google.com ([209.85.221.42]:33631 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbhCJNTP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Mar 2021 08:19:15 -0500
Received: by mail-wr1-f42.google.com with SMTP id 7so23319721wrz.0
        for <linux-pci@vger.kernel.org>; Wed, 10 Mar 2021 05:19:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7FE/aFUGR4FJTAvdWhgR7s8cfhra8+tchwzJGXoPprw=;
        b=OhDiYvvtrprbweTUNM5c5xl87udBWy2AEtZsc9cZ0NgZvHqhNfEi08iYTGb1F4oiie
         VdR1d+LfIt8TOf4BoFM7tY+XzEak/avwWjOX3iiGyvzRo25yYkzAc/yrMfAmxP/f4Ulc
         KivXFLzW/KEysmvjaFwwie7+sYqZLXxxLyochUzhjXXLrVr1MBSVnwsDsnAF3rtDhgU6
         9Sh/SPKGkqTFfhYqbDxEkqPPdPac10b5lj/JfBcNdfeijdGvF2Ybd1RB/qBJpig1SY6m
         vfUmGp8NDCZsKXMeItxAmaFqael/DUMZ3h9bIHYFpIhBzNY/PulNS/FRInO0sfk0oNLd
         mXPw==
X-Gm-Message-State: AOAM531ar7nHi2eykSBrJL4NM6lwq+XYz08Y+kIYbFqJv/lyE3bu8c3J
        eoEWYu0aikGaeW38nqf2QZc=
X-Google-Smtp-Source: ABdhPJxrsXm71hfXVP623gczvcGXlXW/LSxe6p80c+KDlFBhJqi/AvmB9n32ZC141Ik5Y33ZYMaUBA==
X-Received: by 2002:adf:dc91:: with SMTP id r17mr3492581wrj.293.1615382354643;
        Wed, 10 Mar 2021 05:19:14 -0800 (PST)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id l15sm9087457wme.43.2021.03.10.05.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 05:19:14 -0800 (PST)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Daire McNamara <daire.mcnamara@microchip.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH] PCI: microchip: Remove dev_err() when handing an error from platform_get_irq()
Date:   Wed, 10 Mar 2021 13:19:13 +0000
Message-Id: <20210310131913.2802385-1-kw@linux.com>
X-Mailer: git-send-email 2.30.1
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
  drivers/pci/controller/pcie-microchip-host.c:1027:2-9: line 1027 is
  redundant because platform_get_irq() already prints an error

Related commit caecb05c8000 ("PCI: Remove dev_err() when handing an
error from platform_get_irq()").

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/controller/pcie-microchip-host.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/pcie-microchip-host.c
index 04c19ff81aff..80cef572c904 100644
--- a/drivers/pci/controller/pcie-microchip-host.c
+++ b/drivers/pci/controller/pcie-microchip-host.c
@@ -1023,10 +1023,8 @@ static int mc_platform_init(struct pci_config_window *cfg)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "unable to request IRQ%d\n", irq);
+	if (irq < 0)
 		return -ENODEV;
-	}
 
 	for (i = 0; i < NUM_EVENTS; i++) {
 		event_irq = irq_create_mapping(port->event_domain, i);
-- 
2.30.1

