Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09DD264E094
	for <lists+linux-pci@lfdr.de>; Thu, 15 Dec 2022 19:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiLOSV4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Dec 2022 13:21:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiLOSVv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Dec 2022 13:21:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C90046660;
        Thu, 15 Dec 2022 10:21:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 096D0B81C34;
        Thu, 15 Dec 2022 18:21:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F59FC433D2;
        Thu, 15 Dec 2022 18:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671128508;
        bh=1f7os4xVJq22jqG8ELql3guTBTtv0Z9Z/m2XWhn4W8o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LdfqgnlKJyMcTPNdQoZ6UxUpZ4Iv+vdbt7Ewp9advVoG0C3pF5kFCHFg21m1z4CE4
         KqHjIEbjHcWwcRLq4v9acL2ly6sHJVxTtJlB5xYbvNKtF8Snv+9Ion9HA5Ed4NUZXx
         51Tq37zfUAuxiNsRK4iGTfEYzhqQWWwNi9/nE3/49MxDjhCJbpXI+1roK+4waHgE2k
         LcUwaBzMPL7rLqLR1UWigY0n7kBbcRtsdrERkDE7ZY17BC1J8v9oiT4TF4qFY77Xtq
         y/+tdBidN75WgEyi1LMcZkHFwpatj16egwCjFlEMi4I/9Tz17wAMnqKwdIJsbF0Lth
         +E6CVMERgHMoA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/2] PCI: switchtec: Remove useless assignments in switchtec_dev_read()
Date:   Thu, 15 Dec 2022 12:21:40 -0600
Message-Id: <20221215182140.129559-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221215182140.129559-1-helgaas@kernel.org>
References: <20221215182140.129559-1-helgaas@kernel.org>
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

Some switchtec_dev_read() error cases assign to "rc", then branch to "out".
But the code at "out" never uses "rc".  Drop the useless assignments.  No
functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/switch/switchtec.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index d7ae84070e29..c04c7ee35184 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -605,18 +605,14 @@ static ssize_t switchtec_dev_read(struct file *filp, char __user *data,
 
 	rc = copy_to_user(data, &stuser->return_code,
 			  sizeof(stuser->return_code));
-	if (rc) {
-		rc = -EFAULT;
+	if (rc)
 		goto out;
-	}
 
 	data += sizeof(stuser->return_code);
 	rc = copy_to_user(data, &stuser->data,
 			  size - sizeof(stuser->return_code));
-	if (rc) {
-		rc = -EFAULT;
+	if (rc)
 		goto out;
-	}
 
 	stuser_set_state(stuser, MRPC_IDLE);
 
-- 
2.25.1

