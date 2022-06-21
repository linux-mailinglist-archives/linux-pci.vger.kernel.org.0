Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B3D552C25
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jun 2022 09:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346706AbiFUHeC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jun 2022 03:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346725AbiFUHd4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jun 2022 03:33:56 -0400
X-Greylist: delayed 1850 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 21 Jun 2022 00:33:54 PDT
Received: from m15112.mail.126.com (m15112.mail.126.com [220.181.15.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 63E146556;
        Tue, 21 Jun 2022 00:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=vqVWY
        KxLNPOQ8YPND8IpZx8BBiAAqVFQ57RBpvxK5+o=; b=aL5DrF7I3O60xxhQoTyOF
        D66p9SZVL226gLdWk9Gd6bJh7sJWDIlqBw+FXiQTkJamWSLrLHnLbaUgqbG5ykxs
        Djvo8IZZDUSfnglfUwbWt6S90zRelCbYBbVju8xcb1jiRhJyW0W7vD4kq7GS7tBE
        t044ULksbVhxCg0TrghDks=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp2 (Coremail) with SMTP id DMmowAC3vwPabLFif+nMDg--.56281S2;
        Tue, 21 Jun 2022 15:01:46 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     marek.vasut+renesas@gmail.com, yoshihiro.shimoda.uh@renesas.com,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com
Cc:     windhl@126.com, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH] pci/controller/pcie-rcar-host: Hold the reference returned by of_find_matching_node
Date:   Tue, 21 Jun 2022 15:01:45 +0800
Message-Id: <20220621070145.4080147-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMmowAC3vwPabLFif+nMDg--.56281S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtFW7GrWxGr1DWr1DXrykGrg_yoWDtwc_uw
        n7uFnrZw4UCrZa9Fn29w1SvFykC34Iqr1qgFWxtFyfCFyxZry5GrsaqryDJas5WF45X34a
        yrWDArWjk347XjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUj7Ks5UUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi7RonF1pEAPundQAAsw
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In rcar_pcie_init(), we need to hold the reference returned by
of_find_matching_node() which is used to call of_node_put() for
refcount balance.

Signed-off-by: Liang He <windhl@126.com>
---
 drivers/pci/controller/pcie-rcar-host.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index 997c4df6a1e7..405ec3d64f30 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -1158,7 +1158,10 @@ static const struct of_device_id rcar_pcie_abort_handler_of_match[] __initconst
 
 static int __init rcar_pcie_init(void)
 {
-	if (of_find_matching_node(NULL, rcar_pcie_abort_handler_of_match)) {
+	struct device_node *np = of_find_matching_node(NULL, rcar_pcie_abort_handler_of_match);
+
+	if (np) {
+		of_node_put(np);
 #ifdef CONFIG_ARM_LPAE
 		hook_fault_code(17, rcar_pcie_aarch32_abort_handler, SIGBUS, 0,
 				"asynchronous external abort");
-- 
2.25.1

