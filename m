Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60015702332
	for <lists+linux-pci@lfdr.de>; Mon, 15 May 2023 07:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbjEOFPK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 May 2023 01:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjEOFPF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 May 2023 01:15:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDD42123
        for <linux-pci@vger.kernel.org>; Sun, 14 May 2023 22:15:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1A7461EDB
        for <linux-pci@vger.kernel.org>; Mon, 15 May 2023 05:15:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93018C433A0;
        Mon, 15 May 2023 05:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684127703;
        bh=I+FlmAZHxucXxyYndU/XgMZ65CFM9NS6FjERKxyWGY0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Dc6A3aRSE+LCIqczhhuqrDo7tFyrkqEumQ8iEIDB5+XmUf1HiKcG8gkBRl/j+SK0e
         bs0NvCTz8tRzR0o64b/KP0J7sa7g0pdsMPxX42Ajk3Y6eGtd39HKq+7qtyXp8ngPYl
         SN+60IOxGyUTXAVqXXS/bqxihizLibtC/xGn5XSqirKs7QviLflhkOl7UHqcBIgl6J
         H+sGb1k8zHchWldR/IhFM3EXMxiAG6Q8GiIAMzaMY7/72lrlJRarP+JSAh1j4MO7M3
         AyYcEDTKa9zvQQv7zrqQbNN0VptireXCd7n2C2yDtsshgilz19+9J44w4q9wYo3ZcD
         +Aq4BRdG5VaYQ==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/2] PCI: endpoint: Improve pci_epf_type_add_cfs()
Date:   Mon, 15 May 2023 14:14:59 +0900
Message-Id: <20230515051500.574127-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515051500.574127-1-dlemoal@kernel.org>
References: <20230515051500.574127-1-dlemoal@kernel.org>
MIME-Version: 1.0
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

pci_epf_type_add_cfs() should not be called with an unbound EPF device,
that is, an epf device with epf->driver not set. For such case, replace
the NULL return in pci_epf_type_add_cfs() with a clear ERR_PTR(-EINVAL)
error return.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/endpoint/pci-ep-cfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index 0fb6c376166f..d8a6abe2c31c 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -516,7 +516,7 @@ static struct config_group *pci_epf_type_add_cfs(struct pci_epf *epf,
 
 	if (!epf->driver) {
 		dev_err(&epf->dev, "epf device not bound to driver\n");
-		return NULL;
+		return ERR_PTR(-EINVAL);
 	}
 
 	if (!epf->driver->ops->add_cfs)
-- 
2.40.1

