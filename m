Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3660476E91D
	for <lists+linux-pci@lfdr.de>; Thu,  3 Aug 2023 15:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235956AbjHCNEE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Aug 2023 09:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235902AbjHCNDx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 09:03:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C9F3A9C;
        Thu,  3 Aug 2023 06:03:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8A6961D9B;
        Thu,  3 Aug 2023 13:03:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 044BBC433CD;
        Thu,  3 Aug 2023 13:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691067820;
        bh=CYiX21pmOUK7rEEnhQDAT/C62K8obmFsue9Gjg+mb6c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cnq7UHLCEBYUsJUGlhvdJguedS9wySXaFkacIJV0PtkCVKX985HjaliWvaGQkxUfM
         fv1KudGemze+Q3t78U/hpGG7PAFKjY4wSNee8VHAXJUFaKMv0RrrdTWH4tzEeqFORw
         t+Jb3kFpXCKfMq9qpXdNu1CCLQ+1SAtcVpI4iDoX3wPpLfOehayin+wshak/jnEh9R
         J9AePAthD0XHmBYUhyQPmYvODiGxx/Rr1SjX/s1W0wPGI/qdTH/8oq9LLEgvIPaI2E
         9mnoj34sJC+kPFPgSj/e1KpaJMTNQXKeF6fXV3quCpeOMjZT14OZCNmPsDIQpcK11L
         eve0bqDwmDs3A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     ruanjinjie <ruanjinjie@huawei.com>, Jon Mason <jdmason@kudzu.us>,
        Sasha Levin <sashal@kernel.org>, dave.jiang@intel.com,
        allenbh@gmail.com, lpieralisi@kernel.org, kw@linux.com,
        bhelgaas@google.com, ntb@lists.linux.dev, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 3/5] NTB: EPF: fix possible memory leak in pci_vntb_probe()
Date:   Thu,  3 Aug 2023 09:03:31 -0400
Message-Id: <20230803130333.641625-3-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230803130333.641625-1-sashal@kernel.org>
References: <20230803130333.641625-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.42
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: ruanjinjie <ruanjinjie@huawei.com>

[ Upstream commit 956578e3d397e00d6254dc7b5194d28587f98518 ]

As ntb_register_device() don't handle error of device_register(),
if ntb_register_device() returns error in pci_vntb_probe(), name of kobject
which is allocated in dev_set_name() called in device_add() is leaked.

As comment of device_add() says, it should call put_device() to drop the
reference count that was set in device_initialize()
when it fails, so the name can be freed in kobject_cleanup().

Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
Signed-off-by: Jon Mason <jdmason@kudzu.us>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 8c6931210ac4d..cd985a41c8d65 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1288,6 +1288,7 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return 0;
 
 err_register_dev:
+	put_device(&ndev->ntb.dev);
 	return -EINVAL;
 }
 
-- 
2.40.1

