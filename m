Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4096965DD9D
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jan 2023 21:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240202AbjADUWp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Jan 2023 15:22:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240278AbjADUWc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Jan 2023 15:22:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8713033D43;
        Wed,  4 Jan 2023 12:22:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2630161820;
        Wed,  4 Jan 2023 20:22:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62837C433D2;
        Wed,  4 Jan 2023 20:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672863750;
        bh=YwYZS1JBu2OO/OiLJWxi02BQaXs0otqCdVOkHYwmz4c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k11Z5mb6auR2CbTEjGjeiQL6dYHiPZkomIt4y0tI3WLZys2HxCHeRanLW7WSQtwKn
         mxekBTdZ95mpxD6o4TgGoH2crtBSdCw6PsY28+W0qF5YlRWUx8Q+uJw2QLuQ653eZ2
         fACLAbO+sVQNCSTafyFZBc1MaIEHg0W/FrXIgSfZ6aIKc3wckVg4NvWCp7/BzTe6Y1
         oyMke2MGMuMcHmqylFrXMO+XA4p6wHncjl6flrLPMNZhIjxRQzIaMZDPQ0jB7XXho4
         nF2BzF4H/g0u+EXwLYIAyl7NQAOqc+6g+YonaZPPG6gesHX02dWxHQqxZZeDaVlmp6
         Tb9aZ+dqwfAVA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 2/2] PCI: switchtec: Return -EFAULT for copy_to_user() errors
Date:   Wed,  4 Jan 2023 14:22:23 -0600
Message-Id: <20230104202223.1091085-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230104202223.1091085-1-helgaas@kernel.org>
References: <20230104202223.1091085-1-helgaas@kernel.org>
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
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/switch/switchtec.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index d7ae84070e29..3d6f17ff2429 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -606,21 +606,20 @@ static ssize_t switchtec_dev_read(struct file *filp, char __user *data,
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
 
-out:
 	mutex_unlock(&stdev->mrpc_mutex);
 
 	if (stuser->status == SWITCHTEC_MRPC_STATUS_DONE ||
-- 
2.25.1

