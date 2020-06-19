Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0674F2013BF
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jun 2020 18:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390372AbgFSQDX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Jun 2020 12:03:23 -0400
Received: from smtp.asem.it ([151.1.184.197]:51896 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392127AbgFSPLj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Jun 2020 11:11:39 -0400
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 6.5.2)
        with ESMTP id SG000330192.MSG 
        for <linux-pci@vger.kernel.org>; Fri, 19 Jun 2020 17:11:36 +0200S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 19
 Jun 2020 17:11:35 +0200
Received: from flavio-x.asem.intra (172.16.17.208) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 19 Jun 2020 17:11:35 +0200
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH 1/1] pci: controller: cadence: fix wrong path in comment
Date:   Fri, 19 Jun 2020 17:11:34 +0200
Message-ID: <20200619151134.29893-1-f.suligoi@asem.it>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-SGHeloLookup-Result: pass smtp.helo=webmail.asem.it (ip=172.16.16.44)
X-SGSPF-Result: none (smtp.asem.it)
X-SGOP-RefID: str=0001.0A090215.5EECD5A8.0047,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

All native pci drivers are in drivers/pci/controller,
but this comment still refers to the old pathname,
when all pci drivers were located directly under the
drivers/pci directory.

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---
 drivers/pci/controller/cadence/pcie-cadence-ep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index 1c15c8352125..2a48b34ff249 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -276,7 +276,7 @@ static int cdns_pcie_ep_send_legacy_irq(struct cdns_pcie_ep *ep, u8 fn, u8 intx)
 	cdns_pcie_ep_assert_intx(ep, fn, intx, true);
 	/*
 	 * The mdelay() value was taken from dra7xx_pcie_raise_legacy_irq()
-	 * from drivers/pci/dwc/pci-dra7xx.c
+	 * from drivers/pci/controller/dwc/pci-dra7xx.c
 	 */
 	mdelay(1);
 	cdns_pcie_ep_assert_intx(ep, fn, intx, false);
-- 
2.17.1

