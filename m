Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825BD614591
	for <lists+linux-pci@lfdr.de>; Tue,  1 Nov 2022 09:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiKAISw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Nov 2022 04:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiKAISv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Nov 2022 04:18:51 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1358913E3F
        for <linux-pci@vger.kernel.org>; Tue,  1 Nov 2022 01:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1667290730; x=1698826730;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VxmOCBHt2Q4/KSgdaoSHMuS+Z0XKovciEuh7B9eatWE=;
  b=Bmxey7znivWlSHF59l/QQiQ9f6+wAa0LVsg4obe36eCSz81Tx0PROAmb
   GVlllr4mj0ipt3EM6fQFg10ItoIP1Xivnp+Ho/j29mbqZnJeZy3BCoxS3
   vLD4dNob3wcWGcbGpPxtbDWwwfnRdUzqf8pjeoPjQ0iqi+yU0TgF0Z5fu
   HaLZDar+QQ+lxT9gyUjmo2VWWMA0J6NM6520zVlWmiz/DPUgFfgUwQOqm
   V/3T2x8DXs9eC97iaL6O5jOR0UiaO27XgTDR9UnsUYPsm4eQA+bYafJho
   pJeQJv3uKYo2lPy2j9b8QAEnAXeHN7k/a8IrBf5UDagTW8v37hOkT2PtJ
   w==;
X-IronPort-AV: E=Sophos;i="5.95,230,1661810400"; 
   d="scan'208";a="27082943"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 01 Nov 2022 09:18:48 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 01 Nov 2022 09:18:48 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 01 Nov 2022 09:18:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1667290728; x=1698826728;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VxmOCBHt2Q4/KSgdaoSHMuS+Z0XKovciEuh7B9eatWE=;
  b=J2siX6eU4ySCCaqZN3Vr581xX4T6spebMbMA4cZ+MhAQvJAdhM56hmM0
   jkmuQ8ar9G5AQ+/3fQ1G98/IdqBRwFJvl/q1KxFEJeoQ1xCXYkz+DFmu/
   TbtcjexWriajy2BOvNjhd2F9pFWyThZ1lQRy4Ebd8JUIOKg6GTQ00ReJL
   Cm0PwuJ+M81BjKKpIZoPIgPf0LX08/wGdVKB/qci37U923KO3o9Wrw3LY
   VmLlkc+V6njN5JjVWZgMmqAYTqwQt7LTDE3VYWLelCebWtrbfjhWaqfCD
   Nt9+QQvMZ/mv/rAUCCCKpMtJ+xR07LVyYIrsGO1Cx1bQEg+Bq/672Nk1a
   A==;
X-IronPort-AV: E=Sophos;i="5.95,230,1661810400"; 
   d="scan'208";a="27082942"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 01 Nov 2022 09:18:47 +0100
Received: from steina-w.tq-net.de (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id A21EE280056;
        Tue,  1 Nov 2022 09:18:47 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH 1/1] PCI: dwc: reduce log severity level if no link came up
Date:   Tue,  1 Nov 2022 09:18:44 +0100
Message-Id: <20221101081844.265264-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit 14c4ad125cf9 ("PCI: dwc: Log link speed and width if it comes up")
changed the severity from info to error. If no device is attached this
error always is recorded which is not an error in this case.

Fixes: 14c4ad125cf9 ("PCI: dwc: Log link speed and width if it comes up")
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 9e4d96e5a3f5a..432aead68d1fd 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -448,7 +448,7 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
 	}
 
 	if (retries >= LINK_WAIT_MAX_RETRIES) {
-		dev_err(pci->dev, "Phy link never came up\n");
+		dev_info(pci->dev, "Phy link never came up\n");
 		return -ETIMEDOUT;
 	}
 
-- 
2.34.1

