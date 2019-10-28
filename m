Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1909E763A
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2019 17:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732848AbfJ1QdF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Oct 2019 12:33:05 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40140 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730772AbfJ1QdE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Oct 2019 12:33:04 -0400
Received: by mail-oi1-f193.google.com with SMTP id r27so228794oij.7;
        Mon, 28 Oct 2019 09:33:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j3Ah2aSYwS6QKWxODjjePSbvkaLsSgyNAd22qZoET50=;
        b=n38zr9xaRKZugpH2aX0lfR6TKORg1G4uBUb8RnzJQrRgDGdiGStjMY9lMHtN+33N7z
         8VhDp/7fhCco9ijUsEjmTswnTFz4rlCP0GuksBiJNhuw+qp+9AfYi3fe/eNrL2pSKeag
         rs0tyFfSdwbxDSuZJCmXPOgM1rTqiOJtt/HiwPM2B9y5EjKCedJ//m1vCFxH1EE/vGFr
         JhkYEBEGg+p5QgXjOWFGTSALGbZ8VYkWadLUdGsLbYxQDI7K4HO0jJPeMTm6ZwCogxMg
         Kgklkn7mrKQr6YonHh01l8VZoKvHYBlRekLeYKj8KToiEfxpBexw2JYhqjO6HMmZbY1x
         0hOg==
X-Gm-Message-State: APjAAAUx0X1mplzbtg0pNljWfvdQFtV7NTxPnSp0izMNmIFWRjmjAA1L
        8s6aUvj5wOzhMGRvOPq7rQ==
X-Google-Smtp-Source: APXvYqwuOiD/nmPOHXYnO+kSRC+y2SQfGQt3XIG25A6vcuKK0nySh6ol8d3kQ/rCmlmUWRTvYzgC5g==
X-Received: by 2002:a54:4601:: with SMTP id p1mr106186oip.113.1572280383192;
        Mon, 28 Oct 2019 09:33:03 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id e186sm354991oia.47.2019.10.28.09.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 09:33:02 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        Christoph Hellwig <hch@infradead.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Ley Foon Tan <lftan@altera.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Ray Jui <rjui@broadcom.com>, rfi@lists.rocketboards.org,
        Ryder Lee <ryder.lee@mediatek.com>,
        Scott Branden <sbranden@broadcom.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Horman <horms@verge.net.au>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Toan Le <toan@os.amperecomputing.com>,
        Tom Joseph <tjoseph@cadence.com>, Will Deacon <will@kernel.org>
Subject: [PATCH v3 02/25] PCI: Export pci_parse_request_of_pci_ranges()
Date:   Mon, 28 Oct 2019 11:32:33 -0500
Message-Id: <20191028163256.8004-3-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191028163256.8004-1-robh@kernel.org>
References: <20191028163256.8004-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci_parse_request_of_pci_ranges() is missing a module export, so add it.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Andrew Murray <andrew.murray@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/of.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 36891e7deee3..f3da49a31db4 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -530,6 +530,7 @@ int pci_parse_request_of_pci_ranges(struct device *dev,
 	pci_free_resource_list(resources);
 	return err;
 }
+EXPORT_SYMBOL_GPL(pci_parse_request_of_pci_ranges);
 
 #endif /* CONFIG_PCI */
 
-- 
2.20.1

