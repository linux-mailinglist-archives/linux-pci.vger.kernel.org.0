Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 650443BA928
	for <lists+linux-pci@lfdr.de>; Sat,  3 Jul 2021 17:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbhGCPPp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 3 Jul 2021 11:15:45 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:36782 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbhGCPPp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 3 Jul 2021 11:15:45 -0400
Received: by mail-lf1-f44.google.com with SMTP id d16so23856445lfn.3
        for <linux-pci@vger.kernel.org>; Sat, 03 Jul 2021 08:13:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cNlKcnCbf+U9MYL6Tec0SeQijh0GE4vaKksfFp6LR00=;
        b=jYXphEwwu1ZOeopxSjv8j9/qP1LN6boV5pdQ7YugyjtmblS96qhNp7rQPmLaAcJEed
         XjoETt/Sv5xNsApmUpQWqm01vOQ+/tluVvP9UBTljRyQa3pdIpLosVhj+rCHWXT5K5Nv
         bo26PdNODOsJUDvfJDRHnDcLp9bR19e0NhPecMo1ehaDRzBbLDNkdsJi4mFTitHHyqEB
         PfXeGNZcuTsU0ud1ky6QxG71l92uW6YHt0KPGkZaF3lsAS0RXotvhPKw3kmy03Kju2Q8
         vhefQ33ISAOHeqDOLYPpi0gLsU0Codsk++3HBquoY7tHBNS7LqsvKUm0+YRqzoDO0e/C
         GiRA==
X-Gm-Message-State: AOAM533edG21Dz4dayq60u2rwF+wpBDkGDnvgLWzCwzok2JPegF+kjIQ
        ZQvWoIkcB3xTlfCxKS/v/9k=
X-Google-Smtp-Source: ABdhPJyNUz9oqR3m7d9EcsTihaXJum064mwNQTq7KBIFgp9VmGalJfqatTUu7MOeiAI+aLjRMxU2xg==
X-Received: by 2002:ac2:4ecd:: with SMTP id p13mr3562303lfr.351.1625325190608;
        Sat, 03 Jul 2021 08:13:10 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id p18sm715980ljj.56.2021.07.03.08.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jul 2021 08:13:10 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        Scott Branden <sbranden@broadcom.com>,
        Scott Murray <scott@spiteful.org>,
        Tom Joseph <tjoseph@cadence.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: [PATCH 3/5] PCI: cadence: Add missing kernel-doc for struct cdns_pcie members
Date:   Sat,  3 Jul 2021 15:13:04 +0000
Message-Id: <20210703151306.1922450-3-kw@linux.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210703151306.1922450-1-kw@linux.com>
References: <20210703151306.1922450-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add missing documentation for the members "dev", "phy_count", "phy" and
"link" of the struct cdns_pcie, and also remove surplus member "bus".

Thus resolve build time warnings related to kernel-doc:

  drivers/pci/controller/cadence/pcie-cadence.h:281: warning: Function parameter or member 'dev' not described in 'cdns_pcie'
  drivers/pci/controller/cadence/pcie-cadence.h:281: warning: Function parameter or member 'phy_count' not described in 'cdns_pcie'
  drivers/pci/controller/cadence/pcie-cadence.h:281: warning: Function parameter or member 'phy' not described in 'cdns_pcie'
  drivers/pci/controller/cadence/pcie-cadence.h:281: warning: Function parameter or member 'link' not described in 'cdns_pcie'

No change to functionality intended.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/controller/cadence/pcie-cadence.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index 254d2570f8c9..e118c650bbf9 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -263,8 +263,11 @@ struct cdns_pcie_ops {
  * struct cdns_pcie - private data for Cadence PCIe controller drivers
  * @reg_base: IO mapped register base
  * @mem_res: start/end offsets in the physical system memory to map PCI accesses
+ * @dev: the PCI device
  * @is_rc: tell whether the PCIe controller mode is Root Complex or Endpoint.
- * @bus: In Root Complex mode, the bus number
+ * @phy_count: number of supported PHY devices
+ * @phy: list of pointers to specific PHY control blocks
+ * @link: list of pointers to corresponding device link representations
  * @ops: Platform specific ops to control various inputs from Cadence PCIe
  *       wrapper
  */
-- 
2.32.0

