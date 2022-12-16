Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF3B64EEEA
	for <lists+linux-pci@lfdr.de>; Fri, 16 Dec 2022 17:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbiLPQWF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Dec 2022 11:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbiLPQVh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Dec 2022 11:21:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95752A271;
        Fri, 16 Dec 2022 08:21:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53E1C61FDD;
        Fri, 16 Dec 2022 16:21:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 849D6C433EF;
        Fri, 16 Dec 2022 16:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671207695;
        bh=rf/kiQvV904IrlTYmlNmOzv2wh9Ar7q41y6LIAE+Or8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oi2Et4GfdoQdyzLPIZ1SbYq8/8VIHiwgSJ8mxaRLr6tXw93y0Orz1U8kNwvkiyzax
         jOAwBgAmT3ETkYxFYShh4bNuy1iTF2w4DVjtgOApePWMIPNtXM9RKIJ3VkufRsQDbu
         QjtjhaheDWP8YcIQsOriWOXmytdi5oXNWuV+cHv3aMGGx6YC2yNE1qcjixaTYc5DEI
         ih/tZ0yRxyNr7RfPiO7+kT0vnOgb/UQw0VzCC+RVB4q6P2V+M6ROgnLqwfqaMIAaNY
         zMFEBXK8UOKZZGsmOHfZRASO4yNwtWFJzoRN2Bxh0Jo7k0POhT6WtiPYFMZWCYXVhm
         ah3wEyI9OZmYQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 2/2] PCI: switchtec: Return -EFAULT for copy_to_user() errors
Date:   Fri, 16 Dec 2022 10:21:26 -0600
Message-Id: <20221216162126.207863-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221216162126.207863-1-helgaas@kernel.org>
References: <20221216162126.207863-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

switchtec_dev_read() didn't handle copy_to_user() errors correctly: it
assigned "rc = -EFAULT", but actually returned either "size", -ENXIO, or
-EBADMSG instead.

Update the failure cases to unlock mrpc_mutex and return -EFAULT directly.

Fixes: 080b47def5e5 ("MicroSemi Switchtec management interface driver")
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/switch/switchtec.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index d7ae84070e29..0ac9d4488210 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -606,16 +606,16 @@ static ssize_t switchtec_dev_read(struct file *filp, char __user *data,
 	rc = copy_to_user(data, &stuser->return_code,
 			  sizeof(stuser->return_code));
 	if (rc) {
-		rc = -EFAULT;
-		goto out;
+		mutex_unlock(&stdev->mrpc_mutex);
+		return -EFAULT;
 	}
 
 	data += sizeof(stuser->return_code);
 	rc = copy_to_user(data, &stuser->data,
 			  size - sizeof(stuser->return_code));
 	if (rc) {
-		rc = -EFAULT;
-		goto out;
+		mutex_unlock(&stdev->mrpc_mutex);
+		return -EFAULT;
 	}
 
 	stuser_set_state(stuser, MRPC_IDLE);
-- 
2.25.1

