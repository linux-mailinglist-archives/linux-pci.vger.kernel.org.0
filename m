Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9E6A2C7BE9
	for <lists+linux-pci@lfdr.de>; Mon, 30 Nov 2020 00:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgK2XIf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 29 Nov 2020 18:08:35 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43275 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbgK2XIe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 29 Nov 2020 18:08:34 -0500
Received: by mail-wr1-f67.google.com with SMTP id s8so13044292wrw.10
        for <linux-pci@vger.kernel.org>; Sun, 29 Nov 2020 15:08:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ff6pKCmLg5oT72OgCOHiIPYU12IbKoKvOXqEEVgg4cU=;
        b=BQSY1Wx1OF/kE0yEuF9Lx4nr2X8eBJWZTTBJxignI/KtQlrvbzEc+RZDzHwJTWEpKS
         7VEcXjoF2LwbKMf3iV2PAKVJFNS0sMuc4KMJOohQOSlueRJnPU6YE67lqR1g/mxS/PAw
         pmi7DhhiPb9NZjRVVMHS62p9XJQ4EGNlJkWS4TxFeKhNIcn538aPD3RnN5BuwS1KRJeq
         eIcP4zbDzGW670X2HGemuGDyiSweERli4g02DjqF+NoYxf1sNArOvt0Bb8ahrGMIcenz
         szu4R8HZjJoMD0xKnBE2x+mrK2Q6c2aWOUdyTDAB50skbMF4qt4fvEGVyFd49ZyK3c1W
         89OQ==
X-Gm-Message-State: AOAM532fjcdOpk+iKv/VL8jedrsHPK3nm9e+JfLTxN6wANITCqqU2lB/
        c+7qCdFdFgrJytuNeTIZKjM=
X-Google-Smtp-Source: ABdhPJzHI72BcK2gh0kFjWjYjgwPhW5lYayUpFmk6eoZtDqknP6gOkv3hmwsP0YHAvHXiiV7ZOzodw==
X-Received: by 2002:adf:f9c5:: with SMTP id w5mr24603230wrr.69.1606691272550;
        Sun, 29 Nov 2020 15:07:52 -0800 (PST)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id d2sm24831005wrn.43.2020.11.29.15.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 15:07:52 -0800 (PST)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Rob Herring <robh@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Will Deacon <will@kernel.org>,
        Robert Richter <rrichter@marvell.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Toan Le <toan@os.amperecomputing.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-rockchip@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH v6 4/5] PCI: vmd: Update type of the __iomem pointers
Date:   Sun, 29 Nov 2020 23:07:42 +0000
Message-Id: <20201129230743.3006978-5-kw@linux.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201129230743.3006978-1-kw@linux.com>
References: <20201129230743.3006978-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use "void __iomem" instead "char __iomem" pointer type when working with
the accessor functions (with names like readb() or writel(), etc.) to
better match a given accessor function signature where commonly the
address pointing to an I/O memory region would be a "void __iomem"
pointer.

Related:
  https://lwn.net/Articles/102232/

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/controller/vmd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 1361a79bd1e7..59fa9a94860f 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -95,7 +95,7 @@ struct vmd_dev {
 	struct pci_dev		*dev;
 
 	spinlock_t		cfg_lock;
-	char __iomem		*cfgbar;
+	void __iomem		*cfgbar;
 
 	int msix_count;
 	struct vmd_irq_list	*irqs;
@@ -326,7 +326,7 @@ static void vmd_remove_irq_domain(struct vmd_dev *vmd)
 	}
 }
 
-static char __iomem *vmd_cfg_addr(struct vmd_dev *vmd, struct pci_bus *bus,
+static void __iomem *vmd_cfg_addr(struct vmd_dev *vmd, struct pci_bus *bus,
 				  unsigned int devfn, int reg, int len)
 {
 	unsigned int busnr_ecam = bus->number - vmd->busn_start;
@@ -346,7 +346,7 @@ static int vmd_pci_read(struct pci_bus *bus, unsigned int devfn, int reg,
 			int len, u32 *value)
 {
 	struct vmd_dev *vmd = vmd_from_bus(bus);
-	char __iomem *addr = vmd_cfg_addr(vmd, bus, devfn, reg, len);
+	void __iomem *addr = vmd_cfg_addr(vmd, bus, devfn, reg, len);
 	unsigned long flags;
 	int ret = 0;
 
@@ -381,7 +381,7 @@ static int vmd_pci_write(struct pci_bus *bus, unsigned int devfn, int reg,
 			 int len, u32 value)
 {
 	struct vmd_dev *vmd = vmd_from_bus(bus);
-	char __iomem *addr = vmd_cfg_addr(vmd, bus, devfn, reg, len);
+	void __iomem *addr = vmd_cfg_addr(vmd, bus, devfn, reg, len);
 	unsigned long flags;
 	int ret = 0;
 
-- 
2.29.2

