Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA80425303
	for <lists+linux-pci@lfdr.de>; Thu,  7 Oct 2021 14:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241368AbhJGMap (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Oct 2021 08:30:45 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:43678 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241167AbhJGMao (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Oct 2021 08:30:44 -0400
Received: by mail-wr1-f51.google.com with SMTP id r7so18519114wrc.10
        for <linux-pci@vger.kernel.org>; Thu, 07 Oct 2021 05:28:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MuFi30eEEwL/5PO+lT1Ikojs9mD1FQlwaGnA1x8pqyE=;
        b=P2416lChdXksveP7WXYYJe45GCUUxRdaCrLZPaHJkM09gmPdY6ZNaU5GoZbM+zC2IX
         yPH/2MY7oE6gKk9BNPz3+Gl+UkrbbyzrjJlEMQ0CkFwOzqlQg0t+t0WSAJinFv+SYIAM
         YkjmgmsVBPX0o0MH7NXG8top1yjTql0l5pxInUF4p1/ZzNqL01/DZQIYtItooJCosfLf
         jyQuDJh5nI926ogtRiVMXLZjT/x3Xt1gcJR3QcWECAMEvoysMmDXzpAsCzlBIm9J2lrF
         qoKRFbFKIpPr3Oz5kBBHqZGulpQdJT+Wkjy5fVESaz8I/kiI/YFgNphC74G+ub7PeMPd
         P2jQ==
X-Gm-Message-State: AOAM532g8Pg9JQyuoTe3peUoykfNbRJSHjO/1z8Ahd3rwOLNhdX0AH81
        W/lojBH/ynISkGofxdHgOv4OlYK0z4E=
X-Google-Smtp-Source: ABdhPJxPfrWY0+LxRNWWTLMgnYSFWFr2xDFEiCo6DtMmzp2x5gYh8ktF9cxzMTYTHc1yKt2IyCLZBw==
X-Received: by 2002:a7b:cb08:: with SMTP id u8mr4515765wmj.104.1633609730284;
        Thu, 07 Oct 2021 05:28:50 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id l11sm11749916wms.45.2021.10.07.05.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 05:28:49 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] PCI: visconti: Remove surplus dev_err() when using platform_get_irq_byname()
Date:   Thu,  7 Oct 2021 12:28:48 +0000
Message-Id: <20211007122848.3366-1-kw@linux.com>
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
Changes in v2:
  Remove unused "dev" variable following removal of the dev_err() as
  reported by Intel's CI bot.

 drivers/pci/controller/dwc/pcie-visconti.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-visconti.c b/drivers/pci/controller/dwc/pcie-visconti.c
index a88eab6829bb..50f80f07e4db 100644
--- a/drivers/pci/controller/dwc/pcie-visconti.c
+++ b/drivers/pci/controller/dwc/pcie-visconti.c
@@ -279,13 +279,10 @@ static int visconti_add_pcie_port(struct visconti_pcie *pcie,
 {
 	struct dw_pcie *pci = &pcie->pci;
 	struct pcie_port *pp = &pci->pp;
-	struct device *dev = &pdev->dev;
 
 	pp->irq = platform_get_irq_byname(pdev, "intr");
-	if (pp->irq < 0) {
-		dev_err(dev, "Interrupt intr is missing");
+	if (pp->irq < 0)
 		return pp->irq;
-	}
 
 	pp->ops = &visconti_pcie_host_ops;
 
-- 
2.33.0

