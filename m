Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A36DD1D2228
	for <lists+linux-pci@lfdr.de>; Thu, 14 May 2020 00:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbgEMWjC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 May 2020 18:39:02 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:41985 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbgEMWjC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 May 2020 18:39:02 -0400
Received: by mail-oi1-f176.google.com with SMTP id i13so22916087oie.9
        for <linux-pci@vger.kernel.org>; Wed, 13 May 2020 15:39:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YFDjgxs27nYHCHzwO71zxN+I8MJuYDHW9dIJBotLcbA=;
        b=JhtfCOwRcD6G1dSs524Rbt9Gtc3wzrjCbyQMCRiWQvA7Papbqjmiu5XJ2nZEM7jPok
         9yyh1RVw6DJ3Pl7x4/LEzCtudoM5znB8N/v8U9YLnlg5MYv3I7FChYQEYIchFqQz0SGp
         DtpDpIBmPUzGvbwjO80QP+HElpYyUTcL/k1r+hT+AuFMxQRBAmvFA1kzXNkgQj04TPg5
         osyyWY1SWMyBv22f1URjgVFT2Jt3Au1XdK11zGPzMP4ilOag7WLSoGppGvDXlD2McLlV
         sJctrd/qod9jiIjjc1GLx+YuScgvIT0Vq6K47nj7e2JapHx3I8Xh0B4qSwMdS/7IlUIb
         ngKg==
X-Gm-Message-State: AGi0PuaxsVxbjPSq73xz4vevn9/Y1PltLg2/z2+a2fLl3Gp7N1T3yIul
        tuvHwUvdv03vCjWQ6DuOWA==
X-Google-Smtp-Source: APiQypJciYid00iJK8xn399+omlFBvasWoVGcrtwDb9M/pf8jD1fqoznZc1yh06zMg42thTVXlseug==
X-Received: by 2002:aca:ec51:: with SMTP id k78mr29754238oih.114.1589409540953;
        Wed, 13 May 2020 15:39:00 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id s13sm6406090oic.27.2020.05.13.15.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 15:39:00 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/2] PCI: Fix pci_register_host_bridge() device_register() error handling
Date:   Wed, 13 May 2020 17:38:58 -0500
Message-Id: <20200513223859.11295-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If device_register() has an error, we should bail out of
pci_register_host_bridge() rather than continuing on.

Fixes: 37d6a0a6f470 ("PCI: Add pci_register_host_bridge() interface")
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/probe.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 77b8a145c39b..e21dc71b1907 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -909,9 +909,10 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 		goto free;
 
 	err = device_register(&bridge->dev);
-	if (err)
+	if (err) {
 		put_device(&bridge->dev);
-
+		goto free;
+	}
 	bus->bridge = get_device(&bridge->dev);
 	device_enable_async_suspend(bus->bridge);
 	pci_set_bus_of_node(bus);
-- 
2.20.1

