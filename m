Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB29754E9B
	for <lists+linux-pci@lfdr.de>; Sun, 16 Jul 2023 14:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjGPMsN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 16 Jul 2023 08:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGPMsN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 16 Jul 2023 08:48:13 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 22BE390
        for <linux-pci@vger.kernel.org>; Sun, 16 Jul 2023 05:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=TzJxTJVSbFZLywPUD7
        xYKknQJ9N08DslYYzIKzNspXk=; b=dD+DHrNkNfYVgcffncVYFth16yL8Gar//e
        S1txs++1tNzD0gip3PsCwfvWDbnmrg6ph70tJGhxKzHw9fI2jojO/QZVcLD2onq2
        tknuQGGOwqw4ivOdsUDlkHJOxp7LBvy19E4ONtbaNuCaMGPf2qsLZFvIiUbaJLDK
        ahtBDQTe0=
Received: from localhost.localdomain (unknown [202.112.113.212])
        by zwqz-smtp-mta-g5-0 (Coremail) with SMTP id _____wCnNtru5rNk71vLAQ--.27573S4;
        Sun, 16 Jul 2023 20:47:59 +0800 (CST)
From:   Yuanjun Gong <ruc_gongyuanjun@163.com>
To:     Yuanjun Gong <ruc_gongyuanjun@163.com>,
        Yue Wang <yue.wang@Amlogic.com>, linux-pci@vger.kernel.org
Subject: [PATCH 1/1] pci: add a return value check
Date:   Sun, 16 Jul 2023 20:47:40 +0800
Message-Id: <20230716124740.4777-1-ruc_gongyuanjun@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wCnNtru5rNk71vLAQ--.27573S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw47uF43ZrWUuF15Ww47twb_yoWfGFg_ur
        9ruFn7ArsrGr95Cr9rKw4xZFyay3Z5ZF18G3WrtF13ZFyYgw1qqF48ZrZxAFy5Gr10yFZx
        Arn5tF4SkF17GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRRRpB3UUUUU==
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: 5uxfsw5rqj53pdqm30i6rwjhhfrp/xtbBSQCu5VaEH3a+MAAAs3
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

devm_add_action_or_reset() may fail, therefore, a check to the
return value of devm_add_action_or_reset() is added before return.

Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
---
 drivers/pci/controller/dwc/pci-meson.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index c1527693bed9..8b8a2df4ee62 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -187,9 +187,11 @@ static inline struct clk *meson_pcie_probe_clock(struct device *dev,
 		return ERR_PTR(ret);
 	}
 
-	devm_add_action_or_reset(dev,
+	ret = devm_add_action_or_reset(dev,
 				 (void (*) (void *))clk_disable_unprepare,
 				 clk);
+	if (ret)
+		return ERR_PTR(ret);
 
 	return clk;
 }
-- 
2.17.1

