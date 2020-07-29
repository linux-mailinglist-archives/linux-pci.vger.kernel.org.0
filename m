Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBFE2325EC
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jul 2020 22:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgG2UMi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jul 2020 16:12:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:49556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726628AbgG2UMi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Jul 2020 16:12:38 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EAF82082E;
        Wed, 29 Jul 2020 20:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596053557;
        bh=dpUFo+a7/by7OwDh4oaNLD2JZxAldvHdSI9yKa6o100=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u5hfMepN9W0v/k26zsPusjpaQvmgqzu/qmFRniCFc3nXSh6q2z8YSEHAphIirZOJ3
         0MQSpl4R3vQtQ18+8uNWs72Yy3PLkdmUXSVcPb0/3dHiiXaxLxPt3RPjnUx0KgEL96
         FHVFaa3FAQJHaaJvBlclZI2uTm1iSxV26RQKabeI=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Michal Simek <michal.simek@xilinx.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v3 1/6] PCI: Fix kerneldoc
Date:   Wed, 29 Jul 2020 22:12:19 +0200
Message-Id: <20200729201224.26799-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200729201224.26799-1-krzk@kernel.org>
References: <20200729201224.26799-1-krzk@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix W=1 compile warnings (invalid kerneldoc):

    drivers/pci/ats.c:196: warning: Function parameter or member 'pdev' not described in 'pci_enable_pri'
    drivers/pci/ats.c:196: warning: Function parameter or member 'reqs' not described in 'pci_enable_pri'
    drivers/pci/of.c:262: warning: Function parameter or member 'ib_resources' not described in 'devm_of_pci_get_host_bridge_resources'
    drivers/pci/pci-pf-stub.c:20: warning: cannot understand function prototype: 'const struct pci_device_id pci_pf_stub_whitelist[] = '
    drivers/pci/setup-bus.c:62: warning: Function parameter or member 'min_align' not described in 'add_to_list'
    drivers/pci/vc.c:188: warning: Excess function parameter 'name' description in 'pci_vc_do_save_buffer'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/pci/ats.c         | 3 ++-
 drivers/pci/of.c          | 2 ++
 drivers/pci/pci-pf-stub.c | 2 +-
 drivers/pci/setup-bus.c   | 1 +
 drivers/pci/vc.c          | 1 -
 5 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index b761c1f72f67..2e1073052509 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -188,7 +188,8 @@ void pci_pri_init(struct pci_dev *pdev)
 
 /**
  * pci_enable_pri - Enable PRI capability
- * @ pdev: PCI device structure
+ * @pdev: PCI device structure
+ * @reqs: outstanding requests
  *
  * Returns 0 on success, negative value on error
  */
diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 22727fc9558d..d9621a603702 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -243,6 +243,8 @@ EXPORT_SYMBOL_GPL(of_pci_check_probe_only);
  * @busno: bus number associated with the bridge root bus
  * @bus_max: maximum number of buses for this bridge
  * @resources: list where the range of resources will be added after DT parsing
+ * @ib_resources: list where the range of inbound resources (with addresses
+ *                from 'dma-ranges' will be added after DT parsing
  * @io_base: pointer to a variable that will contain on return the physical
  * address for the start of the I/O range. Can be NULL if the caller doesn't
  * expect I/O ranges to be present in the device tree.
diff --git a/drivers/pci/pci-pf-stub.c b/drivers/pci/pci-pf-stub.c
index ef293e735c55..a0b2bd6c918a 100644
--- a/drivers/pci/pci-pf-stub.c
+++ b/drivers/pci/pci-pf-stub.c
@@ -9,7 +9,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 
-/**
+/*
  * pci_pf_stub_whitelist - White list of devices to bind pci-pf-stub onto
  *
  * This table provides the list of IDs this driver is supposed to bind
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 4d870ed89385..3951e02b7ded 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -55,6 +55,7 @@ static void free_list(struct list_head *head)
  * @dev:	Device to which the resource belongs
  * @res:	Resource to be tracked
  * @add_size:	Additional size to be optionally added to the resource
+ * @min_align:	Minimum memory window alignment
  */
 static int add_to_list(struct list_head *head, struct pci_dev *dev,
 		       struct resource *res, resource_size_t add_size,
diff --git a/drivers/pci/vc.c b/drivers/pci/vc.c
index 5486f8768c86..5fc59ac31145 100644
--- a/drivers/pci/vc.c
+++ b/drivers/pci/vc.c
@@ -172,7 +172,6 @@ static void pci_vc_enable(struct pci_dev *dev, int pos, int res)
  * @dev: device
  * @pos: starting position of VC capability (VC/VC9/MFVC)
  * @save_state: buffer for save/restore
- * @name: for error message
  * @save: if provided a buffer, this indicates what to do with it
  *
  * Walking Virtual Channel config space to size, save, or restore it
-- 
2.17.1

