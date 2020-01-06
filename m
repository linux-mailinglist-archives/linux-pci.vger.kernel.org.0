Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE2B131828
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2020 20:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgAFTDp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jan 2020 14:03:45 -0500
Received: from ale.deltatee.com ([207.54.116.67]:54796 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726659AbgAFTDm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Jan 2020 14:03:42 -0500
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ioXf9-0005m4-NN; Mon, 06 Jan 2020 12:03:41 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ioXf9-0000e7-0r; Mon, 06 Jan 2020 12:03:39 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Kelvin.Cao@microchip.com, Eric Pilmore <epilmore@gigaio.com>,
        Doug Meyer <dmeyer@gigaio.com>,
        Wesley Sheng <wesley.sheng@microchip.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Mon,  6 Jan 2020 12:03:26 -0700
Message-Id: <20200106190337.2428-2-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200106190337.2428-1-logang@deltatee.com>
References: <20200106190337.2428-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, epilmore@gigaio.com, dmeyer@gigaio.com, Kelvin.Cao@microchip.com, wesley.sheng@microchip.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_NO_TEXT autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 01/12] PCI/switchtec: Use dma_set_mask_and_coherent()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Wesley Sheng <wesley.sheng@microchip.com>

Use dma_set_mask_and_coherent() instead of dma_set_coherent_mask() as
the switchtec hardware fully supports 64bit addressing and we should
set both the streaming and coherent masks the same.

Fixes: aff614c6339c ("switchtec: Set DMA coherent mask")
Signed-off-by: Wesley Sheng <wesley.sheng@microchip.com>
[logang@deltatee.com: reworked commit message]
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/switch/switchtec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 88091bbfe77f..2bf670977b9c 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -1349,7 +1349,7 @@ static int switchtec_init_pci(struct switchtec_dev *stdev,
 	if (rc)
 		return rc;
 
-	rc = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64));
+	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
 	if (rc)
 		return rc;
 
-- 
2.20.1

