Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94ADF4043EF
	for <lists+linux-pci@lfdr.de>; Thu,  9 Sep 2021 05:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347663AbhIID1d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Sep 2021 23:27:33 -0400
Received: from smtpbg704.qq.com ([203.205.195.105]:39129 "EHLO
        smtpproxy21.qq.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1350270AbhIID07 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Sep 2021 23:26:59 -0400
X-QQ-mid: bizesmtp31t1631157944tj67lzfz
Received: from localhost.localdomain (unknown [121.228.85.104])
        by esmtp6.qq.com (ESMTP) with 
        id ; Thu, 09 Sep 2021 11:25:29 +0800 (CST)
X-QQ-SSF: 01400000002000E0K000B00A0000000
X-QQ-FEAT: LE7C6P2vL8QdlG8W6D6RCL8Ec8cTgXKmpKclyKe1pLXCGz+7XNwPR8eZ8au5H
        16qVc8hW6IQotYPtAZeH1zSmcNA4W1+YwTHWn5kn2wh4jwCBuDVKlc2t/wpA6LNPeIQEjS1
        i5LPEqxu6YY30hbmVr4qvniOY/6MgsW2Fb1/RofqT2Iusb8izJznCHDURyv1tviUo0Etuxl
        Bqw6aduAsPmdD2iORFdwF5/UC1qnFFL6YxPreT1ib1FDPQhtEjnnbvre2ni9neFlZZK5DZs
        2NUo04riinuLSneGM3WJvuoTAD+0MuTv+MBn4kg/Yb6jjSP30Lz5us/53tkJ+p85dVFBekm
        Nfs6F82uImaKucOUaI=
X-QQ-GoodBg: 2
From:   Wang Lu <wanglu@dapustor.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wang Lu <wanglu@dapustor.com>
Subject: [PATCH] PCI/P2PDMA: fix the wrong dma address calculation when map sg
Date:   Thu,  9 Sep 2021 11:25:28 +0800
Message-Id: <20210909032528.24517-1-wanglu@dapustor.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:dapustor.com:qybgforeign:qybgforeign5
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The bus offset is bus address - physical address,
so the calculation in __pci_p2pdma_map_sg should be:
bus address = physical address + bus offset.

Signed-off-by: Wang Lu <wanglu@dapustor.com>
---
 drivers/pci/p2pdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 50cdde3e9a8b..327882638b30 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -874,7 +874,7 @@ static int __pci_p2pdma_map_sg(struct pci_p2pdma_pagemap *p2p_pgmap,
 	int i;
 
 	for_each_sg(sg, s, nents, i) {
-		s->dma_address = sg_phys(s) - p2p_pgmap->bus_offset;
+		s->dma_address = sg_phys(s) + p2p_pgmap->bus_offset;
 		sg_dma_len(s) = s->length;
 	}
 
-- 
2.17.1



