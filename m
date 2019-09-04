Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21C5BA8B9F
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2019 21:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733077AbfIDQDu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Sep 2019 12:03:50 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39067 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731693AbfIDQDu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Sep 2019 12:03:50 -0400
Received: by mail-lf1-f68.google.com with SMTP id l11so16396287lfk.6
        for <linux-pci@vger.kernel.org>; Wed, 04 Sep 2019 09:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qdkpjv/bZ2lIEk5X+tFdEgL+mJhBRPFpnDdvWwMX9Xc=;
        b=N8gFXNfwqngfpITkERemx7Ltu0Dlkimbs/trkm5uy96D6tIWPHX+pNnCgQH1JxBihu
         IUrf7jLBw1JFSWWDRnalf9mB+yNxxdG069bZzIjwJ4zwb/qe7WxIcKRgxPPfGKgR6AGk
         4cnEy7ibBSOP6zo70HU5OxGp7HUKh81yvJsJ2YsMSEHK6/LXkPSokNqCrVMYSD3+bB4e
         kS75lVIGNArGDrvZt0feVALLQxuzWS+xVJQxen3vpDfiaItT/4Y+cy1RBN1sxFZ96kAI
         E9/nkH2UsoZHaIdiXJmDlCysFakZHUVnixHRNlY6m99sKIXP1K2Iej7CxYqjC5k4ZoQJ
         d98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qdkpjv/bZ2lIEk5X+tFdEgL+mJhBRPFpnDdvWwMX9Xc=;
        b=G99xnJ10S/CDpcjZwk1aahauQPq0pJ6yHCmu3+6vLLo1DV7UE0XBUxpZ5v6EDkmIrj
         ttTOR1JlVLYLM3XD9ISdG68xayLr2j36/kBAG9qUIm9VLd5PrslaCaXXfC1fdQsPD2BM
         T0GC6k6HZXEPJ2xKvWEBQnbjMmITi0Ccg3Q5oDeMh/kQPzOPb+C5Ad0sgVpEvbwbUNtW
         /qBgPvRExD8d9a6Qs8pLbcof4IRG2p48EsROHBh7VYGDnkdJsTRnEsZB5WA3igkNMGak
         v8BB2pBKwHqUJnMGhoNpLUIETmH+6abNeMolufaY4bOX0Mjxbl0wetXTGK3ZwMttFGkp
         oldA==
X-Gm-Message-State: APjAAAXGrTJYegCRSYJ92GA1noYj4MxBcCEVIM9TXiUK8AZKU0MIOxkM
        k5j9CwnqVW41HRRMpuaSgoKuhNnIW5E=
X-Google-Smtp-Source: APXvYqxcl6N2Os+hsM2CmBabXDD2UjVXYfZOm8va/9JhvYkTJcOmfYODnBTLkrUxHpBd/2Gc/balpg==
X-Received: by 2002:a19:6549:: with SMTP id c9mr3188567lfj.99.1567613027790;
        Wed, 04 Sep 2019 09:03:47 -0700 (PDT)
Received: from localhost.localdomain (ua-84-219-138-247.bbcust.telenor.se. [84.219.138.247])
        by smtp.gmail.com with ESMTPSA id r8sm556064lfm.71.2019.09.04.09.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 09:03:47 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: dwc: fix find_next_bit() usage
Date:   Wed,  4 Sep 2019 18:03:38 +0200
Message-Id: <20190904160339.2800-1-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

find_next_bit() takes a parameter of size long, and performs arithmetic
that assumes that the argument is of size long.

Therefore we cannot pass a u32, since this will cause find_next_bit()
to read outside the stack buffer and will produce the following print:
BUG: KASAN: stack-out-of-bounds in find_next_bit+0x38/0xb0

Fixes: 1b497e6493c4 ("PCI: dwc: Fix uninitialized variable in dw_handle_msi_irq()")
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index d3156446ff27..45f21640c977 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -78,7 +78,8 @@ static struct msi_domain_info dw_pcie_msi_domain_info = {
 irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
 {
 	int i, pos, irq;
-	u32 val, num_ctrls;
+	unsigned long val;
+	u32 status, num_ctrls;
 	irqreturn_t ret = IRQ_NONE;
 
 	num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
@@ -86,14 +87,14 @@ irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
 	for (i = 0; i < num_ctrls; i++) {
 		dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_STATUS +
 					(i * MSI_REG_CTRL_BLOCK_SIZE),
-				    4, &val);
-		if (!val)
+				    4, &status);
+		if (!status)
 			continue;
 
 		ret = IRQ_HANDLED;
+		val = status;
 		pos = 0;
-		while ((pos = find_next_bit((unsigned long *) &val,
-					    MAX_MSI_IRQS_PER_CTRL,
+		while ((pos = find_next_bit(&val, MAX_MSI_IRQS_PER_CTRL,
 					    pos)) != MAX_MSI_IRQS_PER_CTRL) {
 			irq = irq_find_mapping(pp->irq_domain,
 					       (i * MAX_MSI_IRQS_PER_CTRL) +
-- 
2.21.0

