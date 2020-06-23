Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4364A204B96
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jun 2020 09:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731619AbgFWHs5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Jun 2020 03:48:57 -0400
Received: from smtp.asem.it ([151.1.184.197]:54869 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731585AbgFWHs5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Jun 2020 03:48:57 -0400
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 6.5.2)
        with ESMTP id SG000334881.MSG 
        for <linux-pci@vger.kernel.org>; Tue, 23 Jun 2020 09:48:55 +0200S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 23
 Jun 2020 09:48:52 +0200
Received: from flavio-x.asem.intra (172.16.17.208) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Tue, 23 Jun 2020 09:48:52 +0200
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH v2 1/1] PCI: cadence-ep: Remove obsolete path from comment
Date:   Tue, 23 Jun 2020 09:48:51 +0200
Message-ID: <20200623074851.7832-1-f.suligoi@asem.it>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-SGHeloLookup-Result: pass smtp.helo=webmail.asem.it (ip=172.16.16.44)
X-SGSPF-Result: none (smtp.asem.it)
X-SGOP-RefID: str=0001.0A09020E.5EF1B3E5.0037,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
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
---

v1: - after the suggestion of Bjorn, remove the whole comment line related to
      the wrong path
    - add: Acked-by: Bjorn Helgaas <bhelgaas@google.com>
V2: - change the subject line according to the previous commits of the
      same file
    - remove wrong "Acked-by ..."

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

