Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2FB684CCD
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2019 15:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388172AbfHGNVn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Aug 2019 09:21:43 -0400
Received: from shell.v3.sk ([90.176.6.54]:42164 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388059AbfHGNVn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Aug 2019 09:21:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 2C065CE936;
        Wed,  7 Aug 2019 15:21:28 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id SzZ9YSBTi9mQ; Wed,  7 Aug 2019 15:21:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id F35F1CE949;
        Wed,  7 Aug 2019 15:21:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id eCep9nSFWp-x; Wed,  7 Aug 2019 15:21:19 +0200 (CEST)
Received: from furthur.local (ip-37-188-233-8.eurotel.cz [37.188.233.8])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 5387BCE936;
        Wed,  7 Aug 2019 15:21:11 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Jiri Kosina <trivial@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] PCI: OF: fix a trivial typo in a doc comment
Date:   Wed,  7 Aug 2019 15:20:49 +0200
Message-Id: <20190807132049.10304-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Diverged from what the code does with commit 530210c7814e ("of/irq: Repla=
ce
of_irq with of_phandle_args").

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/pci/of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index bc7b27a28795d..36891e7deee34 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -353,7 +353,7 @@ EXPORT_SYMBOL_GPL(devm_of_pci_get_host_bridge_resourc=
es);
 /**
  * of_irq_parse_pci - Resolve the interrupt for a PCI device
  * @pdev:       the device whose interrupt is to be resolved
- * @out_irq:    structure of_irq filled by this function
+ * @out_irq:    structure of_phandle_args filled by this function
  *
  * This function resolves the PCI interrupt for a given PCI device. If a
  * device-node exists for a given pci_dev, it will use normal OF tree
--=20
2.21.0

