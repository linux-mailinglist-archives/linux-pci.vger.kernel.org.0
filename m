Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8331336883
	for <lists+linux-pci@lfdr.de>; Thu, 11 Mar 2021 01:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbhCKARm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Mar 2021 19:17:42 -0500
Received: from mail-lj1-f182.google.com ([209.85.208.182]:40248 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhCKARe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Mar 2021 19:17:34 -0500
Received: by mail-lj1-f182.google.com with SMTP id e2so82901ljo.7
        for <linux-pci@vger.kernel.org>; Wed, 10 Mar 2021 16:17:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QLZENbJQtmVGcctaPup6m6pSUGnrpLqtTIGTnn/p2nM=;
        b=MCAT3Yflh/c2xZbqu/ZtNtm9QeEdIIV/QTR2M6fTQE52Qr75VceCQdF5+ZlB4iII7q
         jABymP6GBiLKE7oPWeLl8/arCrKbvYbnoquodUpme5o/7fAhRXNzVHKHub1aR1lEch3n
         5JkRl882dXVz2UqdGtguaKug12xvsRg+8ubKbJ+ixMFOt3ojXKAX3rFAoYhvDI7gyfR3
         zRmc3QZbeuhu5otwWLsTyFzep0wXzMR2cNfcoHsRTrlkizRmkHr279z6jQUDQwOyQkAL
         We7dWxz8dJRgCvpeg+uK+j6BXiKmNTKswVpewyRiibaswevvZqYy5M5zH6hrwyFMU5Ib
         5dYg==
X-Gm-Message-State: AOAM531isX4UURACACjozU4LT4z/BPQK6v1jUjILxDlzoHAfAN2Y9o+r
        B4jpzFhLlRbKpRx4kGv1SDA=
X-Google-Smtp-Source: ABdhPJwhyjM+FAGn4pZP2S/Gi6bQwMNNT1qwUW9HP4jRBhdLjLD6a8/P3p3Fc5iwib7x8dyz/rcUdA==
X-Received: by 2002:a2e:9012:: with SMTP id h18mr3338382ljg.139.1615421853436;
        Wed, 10 Mar 2021 16:17:33 -0800 (PST)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id y186sm269332lfc.304.2021.03.10.16.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 16:17:32 -0800 (PST)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Rob Herring <robh@kernel.org>,
        Russell Currey <ruscur@russell.cc>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Sean V Kelley <sean.v.kelley@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Jay Fang <f.fangjian@huawei.com>, linux-pci@vger.kernel.org
Subject: [PATCH 7/8] PCI: dwc: Remove surplus and document missing function parameters
Date:   Thu, 11 Mar 2021 00:17:23 +0000
Message-Id: <20210311001724.423356-7-kw@linux.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210311001724.423356-1-kw@linux.com>
References: <20210311001724.423356-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add missing documentation for the parameters "ks_pcie", "bus"
and "pci" of the ks_pcie_set_dbi_mode(), ks_pcie_clear_dbi_mode(),
ks_pcie_v3_65_add_bus() and ks_pcie_link_up() functions and resolve
build time warnings related to kernel-doc:

  drivers/pci/controller/dwc/pci-keystone.c:356: warning: Function
  parameter or member 'ks_pcie' not described in 'ks_pcie_set_dbi_mode'

  drivers/pci/controller/dwc/pci-keystone.c:375: warning: Function
  parameter or member 'ks_pcie' not described in
  'ks_pcie_clear_dbi_mode'

  drivers/pci/controller/dwc/pci-keystone.c:456: warning: Function
  parameter or member 'bus' not described in 'ks_pcie_v3_65_add_bus'

  drivers/pci/controller/dwc/pci-keystone.c:493: warning: Function
  parameter or member 'pci' not described in 'ks_pcie_link_up'

  drivers/pci/controller/dwc/pci-keystone.c:615: warning: Excess
  function parameter 'irq' description in 'ks_pcie_legacy_irq_handler'

No change to functionality intended.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 53aa35cb3a49..6745e69b7020 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -346,8 +346,9 @@ static const struct irq_domain_ops ks_pcie_legacy_irq_domain_ops = {
 };
 
 /**
- * ks_pcie_set_dbi_mode() - Set DBI mode to access overlaid BAR mask
- * registers
+ * ks_pcie_set_dbi_mode() - Set DBI mode to access overlaid BAR mask registers
+ * @ks_pcie: A pointer to the keystone_pcie structure which holds the KeyStone
+ *	     PCIe host controller driver information.
  *
  * Since modification of dbi_cs2 involves different clock domain, read the
  * status back to ensure the transition is complete.
@@ -367,6 +368,8 @@ static void ks_pcie_set_dbi_mode(struct keystone_pcie *ks_pcie)
 
 /**
  * ks_pcie_clear_dbi_mode() - Disable DBI mode
+ * @ks_pcie: A pointer to the keystone_pcie structure which holds the KeyStone
+ *	     PCIe host controller driver information.
  *
  * Since modification of dbi_cs2 involves different clock domain, read the
  * status back to ensure the transition is complete.
@@ -449,6 +452,7 @@ static struct pci_ops ks_child_pcie_ops = {
 
 /**
  * ks_pcie_v3_65_add_bus() - keystone add_bus post initialization
+ * @bus: A pointer to the PCI bus structure.
  *
  * This sets BAR0 to enable inbound access for MSI_IRQ register
  */
@@ -488,6 +492,8 @@ static struct pci_ops ks_pcie_ops = {
 
 /**
  * ks_pcie_link_up() - Check if link up
+ * @pci: A pointer to the dw_pcie structure which holds the DesignWare PCIe host
+ *	 controller driver information.
  */
 static int ks_pcie_link_up(struct dw_pcie *pci)
 {
@@ -605,7 +611,6 @@ static void ks_pcie_msi_irq_handler(struct irq_desc *desc)
 
 /**
  * ks_pcie_legacy_irq_handler() - Handle legacy interrupt
- * @irq: IRQ line for legacy interrupts
  * @desc: Pointer to irq descriptor
  *
  * Traverse through pending legacy interrupts and invoke handler for each. Also
-- 
2.30.1

