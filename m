Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2FB3B97C3
	for <lists+linux-pci@lfdr.de>; Thu,  1 Jul 2021 22:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbhGAUqg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jul 2021 16:46:36 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:43606 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhGAUqg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Jul 2021 16:46:36 -0400
Received: by mail-lj1-f180.google.com with SMTP id f13so10257676ljp.10
        for <linux-pci@vger.kernel.org>; Thu, 01 Jul 2021 13:44:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iVS1NuRQOjDJx0zHL86NloP+4ltmCaJEZU9LmlzJl70=;
        b=BPHhabjIkw1LqeiDQJPSU/Wfgk7Yc3GTvVFKNBHnGp8WYMcsRsAUcHr66nZwSUGc6O
         CG9RNjYgq2MqJpoq9jcYl3m5n+et2jbE1Jk2btOxsO8NybCfJh0hRnrOKZ3q5bJFtLXK
         K8HMDNaAdFR5m/SNfbxaNMTYFMoSKk7gICC05kBKZaqbrW37w5y//bG6/zNAdUjicnub
         S/H+Cw2C2VaQkD/98eUVFaVd8jZuG/GIPn3ytCWuLlgU6a+c5Fo6Grpdf5PUaIjZVh7b
         t05+H5k0sxobzy6pcC2FsGCD6+IKWeAjZrNdqDMa5QfjBTJgctdBcMjN5DTJjNvHVozN
         PsKw==
X-Gm-Message-State: AOAM530I3PyenF4e82yMWAcSEV3fXANZTYwHt5TBWnwjqJzW9aPQwV8k
        R/wC7iS0+twl2bQrL86GBYQ=
X-Google-Smtp-Source: ABdhPJxPjttGkitm9boSf7BhGN32AdPEJM6o9g14HbYXUz3SqqvQHZLSPPSBHc4jwawNaMO5/arCxA==
X-Received: by 2002:a2e:9010:: with SMTP id h16mr1084171ljg.118.1625172244445;
        Thu, 01 Jul 2021 13:44:04 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id w8sm69942lfq.27.2021.07.01.13.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 13:44:03 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Jesper Nilsson <jesper.nilsson@axis.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH v2 2/2] PCI: artpec6: Remove local code block from within switch statement
Date:   Thu,  1 Jul 2021 20:44:01 +0000
Message-Id: <20210701204401.1636562-2-kw@linux.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210701204401.1636562-1-kw@linux.com>
References: <20210701204401.1636562-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

At the moment, the switch statement in the artpec6_pcie_probe() has
a local code block where the local variable "val" is defined and
immediately used by the artpec6_pcie_readl() within this local scope.

This extra code block adds brackets at the same indentation level as the
switch statement itself which can hinder readability of the code.

Thus, move the variable "val" declaration and definition at the top of
the function where other variables are already present, and remove the
extra code block from within the select statement.  This also is the
preferred style in the PCI tree.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/controller/dwc/pcie-artpec6.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
index 739871bece75..c91fc1954432 100644
--- a/drivers/pci/controller/dwc/pcie-artpec6.c
+++ b/drivers/pci/controller/dwc/pcie-artpec6.c
@@ -384,6 +384,7 @@ static int artpec6_pcie_probe(struct platform_device *pdev)
 	const struct artpec_pcie_of_data *data;
 	enum artpec_pcie_variants variant;
 	enum dw_pcie_device_mode mode;
+	u32 val;
 
 	match = of_match_device(artpec6_pcie_of_match, dev);
 	if (!match)
@@ -432,9 +433,7 @@ static int artpec6_pcie_probe(struct platform_device *pdev)
 		if (ret < 0)
 			return ret;
 		break;
-	case DW_PCIE_EP_TYPE: {
-		u32 val;
-
+	case DW_PCIE_EP_TYPE:
 		if (!IS_ENABLED(CONFIG_PCIE_ARTPEC6_EP))
 			return -ENODEV;
 
@@ -445,7 +444,6 @@ static int artpec6_pcie_probe(struct platform_device *pdev)
 		pci->ep.ops = &pcie_ep_ops;
 
 		return dw_pcie_ep_init(&pci->ep);
-	}
 	default:
 		dev_err(dev, "INVALID device type %d\n", artpec6_pcie->mode);
 	}
-- 
2.32.0

