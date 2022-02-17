Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C404BA633
	for <lists+linux-pci@lfdr.de>; Thu, 17 Feb 2022 17:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243355AbiBQQkZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Feb 2022 11:40:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243351AbiBQQkY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Feb 2022 11:40:24 -0500
X-Greylist: delayed 365 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Feb 2022 08:40:07 PST
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15002B31AD;
        Thu, 17 Feb 2022 08:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1645116004;
        bh=vZHyIaB0slu3WY2+M5adIWUPjoqNW/g6UPXYOZPH+W0=;
        h=From:To:Cc:Subject:Date;
        b=e5RJKxd851Xv+y82Ccip64yzIUAI3cAf22Vd0225ImPYpk8oqgV4T8CKRi9EVCFp6
         XTilB8Y2PQ0qsHN3/OtTUaxEXe2nyazqQSOBjWgnqH76yYjKeSvpl3bddcP84UQiyv
         hHdY7sKG3B+v3ts5w8sAK+sOoH6hoAExlKoTxaa0=
Received: from localhost.localdomain ([218.197.153.188])
        by newxmesmtplogicsvrszc9.qq.com (NewEsmtp) with SMTP
        id 81DBFECA; Fri, 18 Feb 2022 00:32:29 +0800
X-QQ-mid: xmsmtpt1645115549t0wnhrx3m
Message-ID: <tencent_CA4766945C568E210AA2701525957F041007@qq.com>
X-QQ-XMAILINFO: MpO6L0LObisWdGDmM3VSWCKvJsFc6smgvimLPwIWMErLSncFgHXfLbE4sEhSOa
         P9y3hLZ1tlwsHt5Raloh5SLWbUPV6D9zU2sfAbqXmsoE1ASbNO58Tg7oDro7mm6XB4osedgpwPHF
         ECXEVZWvEu62xrVea7uvUzSqHnPRkV7axY52IW9lwezdOK2FWSN15PTY5I7zNpx1NoQbOtjZCZ4e
         mQ02m4o4R6UW2q/MCx92uD1c1YEIsW3/y9Ahcei/lL8F9f8HlJ5xY8n2BlVGAJcfcdcu1Pb5qj6q
         db4J7HbN+qnRL9MuaQqXONArGRVfO/Nifuv0KfcadnlYD9hIi7P4UIhsH0eyHICO45yKFHXfZwqz
         XxBS2gLqPq+k67jndYCePnDkpnnmQ1D32dpXW90cPbLHDDSsJHkZEIM9kP9S2XDe7bqwxco59hqz
         UsnrjXnSLCyZ8JaTt37HB+uAQcTVE+HB5UPHTZ6hbazOurXYbrvFyGivjE7To6xgmOvch3AlMgVJ
         rckeXpGMpIrZq4CoApSFUURXXBJSc6HDvEz3Ht0CsgkFEzo+UaI42K59KFSgUKgasnjdpQZJCkTy
         lwGt0xDRFVzBxrcKhDgtWWQhzHvE0/aIts1tHqIRn3akVSMhLXgyK/PrqgubC03CQXF87CawYMZ9
         4uTqcnb3Yki33Lyvdj3Y40wVls8zkVQl/Vy2GwgynOT9DpcD1DMm9ds7AAMzQp/Bgiube49swzqs
         Ct6wTRQttInxW4Dtr+BI/CYvrSiobKMiZU6ipnBX0eBzUniAN446Shn5L2vKZtIZrJ369CYkJtra
         30vNuHWr38oR5rD7u8O/G0E4OAjMOEU+GRCgjYhdVR3LEP88zmomuMcvB7TNgSl1AZ+wSItyxVQL
         vSB+s7U9Q4DZXBREK6TLc=
From:   xkernel.wang@foxmail.com
To:     kishon@ti.com
Cc:     lorenzo.pieralisi@arm.com, kw@linux.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH] PCI: endpoint: functions/pci-epf-test: fix a potential memory leak
Date:   Fri, 18 Feb 2022 00:31:24 +0800
X-OQ-MSGID: <20220217163123.1314-1-xkernel.wang@foxmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

In pci_epf_test_write(), there is an error path does not properly
release 'buf' which is allocated by kzalloc(). It is better to release
it by changing the target label of goto statement.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 90d84d3..41227dd 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -441,7 +441,7 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
 		if (!epf_test->dma_supported) {
 			dev_err(dev, "Cannot transfer data using DMA\n");
 			ret = -EINVAL;
-			goto err_map_addr;
+			goto err_dma_map;
 		}
 
 		src_phys_addr = dma_map_single(dma_dev, buf, reg->size,
-- 
