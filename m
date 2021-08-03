Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27EDA3DF724
	for <lists+linux-pci@lfdr.de>; Tue,  3 Aug 2021 23:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbhHCV5L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Aug 2021 17:57:11 -0400
Received: from mail-il1-f182.google.com ([209.85.166.182]:44589 "EHLO
        mail-il1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbhHCV5K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Aug 2021 17:57:10 -0400
Received: by mail-il1-f182.google.com with SMTP id i13so8963310ilm.11
        for <linux-pci@vger.kernel.org>; Tue, 03 Aug 2021 14:56:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yn4O9xEl6ru3rpDSJ+8kj55TrJUZvu9sqWFIWkVC+Pg=;
        b=c12MSABvtrr4Uh6JRu8VRLw8ESgF2bNhcmnxOji28EA9RLXvkRUN7pQVFW1+38mpB5
         I8BIkTHvRKZGKS0Nw76TDTRKDnGqgrlULvj75TbSbUWAGp8IQBgPIHrNtkwPnhgx2TlA
         +hO7nuuIylsqBNcvmYMm5nh3SQJfHXbOGhNRd+/PxjtSP6JWbUhwL/Se6wz+snEUoIoN
         hX3VjBJUU/R4XAYntGzVbIrW8Xl78d77oEuZf1ZUMt/i+0Ta1I1jU7Tsn2b73NGTDVUr
         GlreATlSMMN9K0EW3AI/EKuYnvyZqXgGazIFiA727ggHKmt651+mMtjNIlz4Rkl8gLL0
         uGIA==
X-Gm-Message-State: AOAM532W9+tOnwHpckl+rmHgDtIL5kYELfKqKdvb7Nv3bbumOTAU6DgD
        FowPJxEMgf5HxUJFs+3GbQ==
X-Google-Smtp-Source: ABdhPJwNKianj0C+7zTvckxnhOj3b3Q0ZNocwW6PPcIY+xaavptFIG5JGlf3uP6IUcaPevqtQBZUPw==
X-Received: by 2002:a92:ca8f:: with SMTP id t15mr1052313ilo.262.1628027819042;
        Tue, 03 Aug 2021 14:56:59 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.248])
        by smtp.googlemail.com with ESMTPSA id r24sm221635ioa.31.2021.08.03.14.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 14:56:58 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Roman Bacik <roman.bacik@broadcom.com>,
        Bharat Gooty <bharat.gooty@broadcom.com>,
        Abhishek Shah <abhishek.shah@broadcom.com>,
        Jitendra Bhivare <jitendra.bhivare@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 1/2] PCI: of: Don't fail devm_pci_alloc_host_bridge() on missing 'ranges'
Date:   Tue,  3 Aug 2021 15:56:55 -0600
Message-Id: <20210803215656.3803204-1-robh@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit 669cbc708122 ("PCI: Move DT resource setup into
devm_pci_alloc_host_bridge()") made devm_pci_alloc_host_bridge() fail on
any DT resource parsing errors, but Broadcom iProc uses
devm_pci_alloc_host_bridge() on BCMA bus devices that don't have DT
resources. In particular, there is no 'ranges' property. Fix iProc by
making 'ranges' optional.

If 'ranges' is required by a platform, there's going to be more errors
latter on if it is missing.

Fixes: 669cbc708122 ("PCI: Move DT resource setup into devm_pci_alloc_host_bridge()")
Reported-by: Rafał Miłecki <zajec5@gmail.com>
Cc: Srinath Mannam <srinath.mannam@broadcom.com>
Cc: Roman Bacik <roman.bacik@broadcom.com>
Cc: Bharat Gooty <bharat.gooty@broadcom.com>
Cc: Abhishek Shah <abhishek.shah@broadcom.com>
Cc: Jitendra Bhivare <jitendra.bhivare@broadcom.com>
Cc: Ray Jui <ray.jui@broadcom.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index a143b02b2dcd..d84381ce82b5 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -310,7 +310,7 @@ static int devm_of_pci_get_host_bridge_resources(struct device *dev,
 	/* Check for ranges property */
 	err = of_pci_range_parser_init(&parser, dev_node);
 	if (err)
-		goto failed;
+		return 0;
 
 	dev_dbg(dev, "Parsing ranges property...\n");
 	for_each_of_pci_range(&parser, &range) {
-- 
2.30.2

