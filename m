Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 556D83B9662
	for <lists+linux-pci@lfdr.de>; Thu,  1 Jul 2021 21:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhGATTP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jul 2021 15:19:15 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:53821 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhGATTO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Jul 2021 15:19:14 -0400
Received: by mail-wm1-f45.google.com with SMTP id w13so5202495wmc.3
        for <linux-pci@vger.kernel.org>; Thu, 01 Jul 2021 12:16:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kQF8cLAtr4vueW7JSMUMX/IBfK/Lv//HrORl0QoGClk=;
        b=coYfnQVLpoUTEY25ES3Es3QAHyC1riLi1DeTecOfSVXt54jiPpLDiFluDN1MC7PSal
         6erWnyywnXFw0SvWOtrSgyHzv/uYG/VhVzSuG5AFnyVUKvtJBa8EGV0E4p5BSYaAdG26
         4lR0js7j2SwoLaStVEyocy6kuNlbOmvJnN9h2AoWfOnWUcVy4Fxzql9ZZi8bOQt+8cCY
         emONCI164SlbzkDKIGM1QN3VT0+c7HwDJBdCpPBd6mGm/kBTRNJid3GtngxiMOWq9D7I
         LzpV7V4zeRSiBM22gCqdsDIXB6yZqDqUCe9NzDL4ILhwCkGfeRWOqaxG88kh76AU6wsW
         vccQ==
X-Gm-Message-State: AOAM5330loGMSwOiEUxlDocyYdasHTj4G6Y88YQkDWjIB31q7EXWyymM
        DOH+/YeHPZUrR8wcy3pamWU=
X-Google-Smtp-Source: ABdhPJwCnjKs+5W8DJyB5J6LDav2hzmvfNV/EDDEHJrZNEWjCCEFi2ftpaXZCRr2/9lpBT9rgjW1tA==
X-Received: by 2002:a05:600c:354f:: with SMTP id i15mr1297082wmq.101.1625167002277;
        Thu, 01 Jul 2021 12:16:42 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id p15sm778956wmq.43.2021.07.01.12.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 12:16:41 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Jesper Nilsson <jesper.nilsson@axis.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH] PCI: artpec6: Remove surplus break statement after return
Date:   Thu,  1 Jul 2021 19:16:40 +0000
Message-Id: <20210701191640.1493543-1-kw@linux.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

As part of code refactoring completed in the commit a0fd361db8e5 ("PCI:
dwc: Move "dbi", "dbi2", and "addr_space" resource setup into common
code") the function artpec6_add_pcie_ep() has been removed and the call
to the dw_pcie_ep_init() has been moved into artpec6_pcie_probe().

This change left a break statement behind that is not needed any more as
as the function artpec6_pcie_probe() return immediately after making
a call to dw_pcie_ep_init().

Thus remove this surplus break statement that became a dead code.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/controller/dwc/pcie-artpec6.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
index 597c282f586c..739871bece75 100644
--- a/drivers/pci/controller/dwc/pcie-artpec6.c
+++ b/drivers/pci/controller/dwc/pcie-artpec6.c
@@ -445,7 +445,6 @@ static int artpec6_pcie_probe(struct platform_device *pdev)
 		pci->ep.ops = &pcie_ep_ops;
 
 		return dw_pcie_ep_init(&pci->ep);
-		break;
 	}
 	default:
 		dev_err(dev, "INVALID device type %d\n", artpec6_pcie->mode);
-- 
2.32.0

