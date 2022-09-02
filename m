Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470505AB48D
	for <lists+linux-pci@lfdr.de>; Fri,  2 Sep 2022 16:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236445AbiIBO6W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Sep 2022 10:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236453AbiIBO5r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Sep 2022 10:57:47 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DCA627C;
        Fri,  2 Sep 2022 07:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662128565; x=1693664565;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R3HtVnqEsyT5IIIglu00zj/GyzVDepT1pc5XEOwby8Y=;
  b=o07NoKWN2AlBJbBISl+HniGD/Uumaf/aJn0/yXj+fpAS8dZIBN+FQpDU
   fK7c62sqXgTD2wCm/ipfbNKj3YjGeFBOSA3CyvtMeaZB019KWQTL+1DaA
   dkEoVF/734dtBo8uj8/5o0wa5dwgQ0j6uo5GSXdVuToMMAEF1LEAMpIx4
   32J1hGjnclqoGvtEa3wCTW8siZn7tFfxcGwMn1L6Ak8RRdWNvUhA7aW9q
   b/7ieoOoMOfVzWo//AY2tVqbSav+QCtfB3Mn+Mbu2rQkB5nFveL0eBvBX
   J19ANzihAeGU2piksrBR6Xe8Kg3cbnaj+aR1Ns05BGZBS8PyeQM59ogq6
   g==;
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="175388545"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Sep 2022 07:22:44 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 2 Sep 2022 07:22:43 -0700
Received: from daire-X570.emdalo.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Fri, 2 Sep 2022 07:22:39 -0700
From:   <daire.mcnamara@microchip.com>
To:     <aou@eecs.berkeley.edu>, <bhelgaas@google.com>,
        <conor.dooley@microchip.com>, <devicetree@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <kw@linux.com>,
        <linux-pci@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <lpieralisi@kernel.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <robh+dt@kernel.org>, <robh@kernel.org>
CC:     <cyril.jean@microchip.com>, <padmarao.begari@microchip.com>,
        <heinrich.schuchardt@canonical.com>,
        <david.abdurachmanov@gmail.com>,
        "Daire McNamara" <daire.mcnamara@microchip.com>
Subject: [PATCH v1 4/4] of: PCI: tidy up logging of ranges containing configuration space type
Date:   Fri, 2 Sep 2022 15:22:02 +0100
Message-ID: <20220902142202.2437658-5-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220902142202.2437658-1-daire.mcnamara@microchip.com>
References: <20220902142202.2437658-1-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Daire McNamara <daire.mcnamara@microchip.com>

PCI ranges can contain addresses where phys.high part can have a type
of 0, signifying 'configuration space'.  Change
devm_of_pci_get_host_bridge_resources() to print 'CFG' instead of 'err'
for a PCI range containing such a 'configuration space' type.

Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
---
 drivers/pci/of.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 196834ed44fe..d782ad8c7dce 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -319,6 +319,8 @@ static int devm_of_pci_get_host_bridge_resources(struct device *dev,
 			range_type = "IO";
 		else if ((range.flags & IORESOURCE_TYPE_BITS) == IORESOURCE_MEM)
 			range_type = "MEM";
+		else if ((range.flags & IORESOURCE_TYPE_BITS) == 0)
+			range_type = "CFG";
 		else
 			range_type = "err";
 		dev_info(dev, "  %6s %#012llx..%#012llx -> %#012llx\n",
-- 
2.25.1

