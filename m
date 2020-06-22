Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0EFE203310
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jun 2020 11:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbgFVJPZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Jun 2020 05:15:25 -0400
Received: from smtp.asem.it ([151.1.184.197]:62611 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbgFVJPZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Jun 2020 05:15:25 -0400
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 6.5.2)
        with ESMTP id SG000332222.MSG 
        for <linux-pci@vger.kernel.org>; Mon, 22 Jun 2020 11:15:23 +0200S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 22
 Jun 2020 11:15:20 +0200
Received: from flavio-x.asem.intra (172.16.17.208) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Mon, 22 Jun 2020 11:15:20 +0200
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH v1 1/1] pci: controller: cadence: fix wrong path in comment
Date:   Mon, 22 Jun 2020 11:15:20 +0200
Message-ID: <20200622091520.9336-1-f.suligoi@asem.it>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-SGHeloLookup-Result: pass smtp.helo=webmail.asem.it (ip=172.16.16.44)
X-SGSPF-Result: none (smtp.asem.it)
X-SGOP-RefID: str=0001.0A09020E.5EF076A9.0066,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This comment still refers to the old driver pathname,
when all PCI drivers were located directly under the
drivers/pci directory.

Anyway the function name itself is enough, so we can
remove the overabundant path reference.

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---

v1: - after the suggestion of Bjorn, remove the whole comment line related to
      the wrong path
    - add: Acked-by: Bjorn Helgaas <bhelgaas@google.com>

 drivers/pci/controller/cadence/pcie-cadence-ep.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index 1c15c8352125..690eefd328ea 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -276,7 +276,6 @@ static int cdns_pcie_ep_send_legacy_irq(struct cdns_pcie_ep *ep, u8 fn, u8 intx)
 	cdns_pcie_ep_assert_intx(ep, fn, intx, true);
 	/*
 	 * The mdelay() value was taken from dra7xx_pcie_raise_legacy_irq()
-	 * from drivers/pci/dwc/pci-dra7xx.c
 	 */
 	mdelay(1);
 	cdns_pcie_ep_assert_intx(ep, fn, intx, false);
-- 
2.17.1

