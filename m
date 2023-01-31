Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34CCF6829AD
	for <lists+linux-pci@lfdr.de>; Tue, 31 Jan 2023 10:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjAaJzz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Jan 2023 04:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbjAaJzw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Jan 2023 04:55:52 -0500
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 28E905B9D;
        Tue, 31 Jan 2023 01:55:51 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.97,259,1669042800"; 
   d="scan'208";a="147983403"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 31 Jan 2023 18:55:48 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 5C6C44001B72;
        Tue, 31 Jan 2023 18:55:48 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com
Cc:     Sergey.Semin@baikalelectronics.ru, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v8 2/6] PCI: designware-ep: Expose dw_pcie_ep_exit() to module
Date:   Tue, 31 Jan 2023 18:55:39 +0900
Message-Id: <20230131095543.1831875-3-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230131095543.1831875-1-yoshihiro.shimoda.uh@renesas.com>
References: <20230131095543.1831875-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Expose dw_pcie_ep_exit() to module.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index f9182f8d552f..95efe14f1036 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -622,6 +622,7 @@ void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
 
 	pci_epc_mem_exit(epc);
 }
+EXPORT_SYMBOL_GPL(dw_pcie_ep_exit);
 
 static unsigned int dw_pcie_ep_find_ext_capability(struct dw_pcie *pci, int cap)
 {
-- 
2.25.1

