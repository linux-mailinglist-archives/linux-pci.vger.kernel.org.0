Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B14303B97EC
	for <lists+linux-pci@lfdr.de>; Thu,  1 Jul 2021 23:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbhGAVF1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jul 2021 17:05:27 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:36422 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhGAVF0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Jul 2021 17:05:26 -0400
Received: by mail-lf1-f44.google.com with SMTP id d16so14220087lfn.3
        for <linux-pci@vger.kernel.org>; Thu, 01 Jul 2021 14:02:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JE6sI1cXi9IoYmq2Jf3nI0zQd5U5PWje0uxRZUNbQZY=;
        b=tsjCqqRVGRHjll+hgVIyZvD2xPqJGkTw3xWIxVnRISofmWzEkXgcsQoinLTbNgnG9q
         NP/PXXuNERdQg8RNmH3gS0aYn3uGmmfagPL8GolH6HklMCX3b02HnSThrloQjLFhqAJO
         qhBfYGBNVv5soOMctltQRArE3n3yDfi6XnwRrNmUaLUZCdEOO+w9NiHH0euwBRf2CTj2
         v4k6xdY9T6ciywOMpR9DxoeEbztyonofBYxRRl2lQIrXgmz6tDY7RqSAQ1X2sp6+rIEm
         s1rUyXhufvQBg3xGOdiLvVX2W5ylAD4ctwtZmORZ4dw9lp5Q7tX6WAHe89lGAHK9LdUU
         P/rQ==
X-Gm-Message-State: AOAM530gxpFjBMCkRz1Jy+Q7fYDXAfYSgaP3CSCi2Kd1asHK6l1FIvm6
        NJXxGGJRDwqXIJnI4xw+XLU=
X-Google-Smtp-Source: ABdhPJwd/vc5UfafJqN5CCMYGBinKTkl1VjKUD7L0aakEih9zH6usEE+Hhz9EiQELu2soXrTnQ0gTg==
X-Received: by 2002:ac2:4f89:: with SMTP id z9mr1218811lfs.46.1625173374134;
        Thu, 01 Jul 2021 14:02:54 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id f21sm72175lfk.212.2021.07.01.14.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 14:02:53 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Jingoo Han <jingoohan1@gmail.com>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH] PCI: dwc: Remove surplus break statement after return
Date:   Thu,  1 Jul 2021 21:02:52 +0000
Message-Id: <20210701210252.1638709-1-kw@linux.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

As part of code refactoring completed in the commit a0fd361db8e5 ("PCI:
dwc: Move "dbi", "dbi2", and "addr_space" resource setup into common
code") the function dw_plat_add_pcie_ep() has been removed and the call
to the dw_pcie_ep_init() has been moved into dw_plat_pcie_probe().

This change left a break statement behind that is not needed any more as
as the function dw_plat_pcie_probe() returns immediately after making
a call to dw_pcie_ep_init().

Thus remove this surplus break statement that became a dead code.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/controller/dwc/pcie-designware-plat.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
index 9b397c807261..8851eb161a0e 100644
--- a/drivers/pci/controller/dwc/pcie-designware-plat.c
+++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
@@ -164,7 +164,6 @@ static int dw_plat_pcie_probe(struct platform_device *pdev)
 
 		pci->ep.ops = &pcie_ep_ops;
 		return dw_pcie_ep_init(&pci->ep);
-		break;
 	default:
 		dev_err(dev, "INVALID device type %d\n", dw_plat_pcie->mode);
 	}
-- 
2.32.0

