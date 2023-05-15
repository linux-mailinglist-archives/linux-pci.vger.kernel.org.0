Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45CB702645
	for <lists+linux-pci@lfdr.de>; Mon, 15 May 2023 09:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238964AbjEOHoB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 May 2023 03:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238984AbjEOHn4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 May 2023 03:43:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC67D1716
        for <linux-pci@vger.kernel.org>; Mon, 15 May 2023 00:43:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B1A362054
        for <linux-pci@vger.kernel.org>; Mon, 15 May 2023 07:43:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1015C4339E;
        Mon, 15 May 2023 07:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684136631;
        bh=zq74GLTtxaMbIW2qeewUKkTcMDqKu83mrO2Ai9/vSfg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=UY/IMu7Z6Vh/IBqpL5IH/bVAa7DexlG0SDUeNLk83NtleNcAYZwnFYsZPyTbGxCNo
         H9a3c4V0bliTjwKb3RjxAEtzZKljwPQcT8/4hmgiIQnSNeyhC/36fXwVZGkRa35jl9
         FDwoGif3JO/MO/+mD2jkEi1zwOL49Ab6O8CWTO9M/mRuTzHcAzi21vfp5pE5ScWeY6
         jFM0renmBLb3BDMmGF0BZixs6vznPC6j+9DIMhshT+n/wCfHnC3u4Q3X6JzpznGcVg
         uoWN7QR9S3/5K6kTe3KfWAg+Tp81zG2ye7lv9aZ28Cbbe0BA48sH193vIDMTr/2V4S
         C5y4HLbG8PpuA==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 1/2] PCI: endpoint: Improve pci_epf_type_add_cfs()
Date:   Mon, 15 May 2023 16:43:47 +0900
Message-Id: <20230515074348.595704-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515074348.595704-1-dlemoal@kernel.org>
References: <20230515074348.595704-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci_epf_type_add_cfs() should not be called with an unbound EPF device,
that is, an epf device with epf->driver not set. For such case, replace
the NULL return in pci_epf_type_add_cfs() with a clear ERR_PTR(-ENODEV)
pointer error return.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/endpoint/pci-ep-cfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index 0fb6c376166f..0bf5be986e9b 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -516,7 +516,7 @@ static struct config_group *pci_epf_type_add_cfs(struct pci_epf *epf,
 
 	if (!epf->driver) {
 		dev_err(&epf->dev, "epf device not bound to driver\n");
-		return NULL;
+		return ERR_PTR(-ENODEV);
 	}
 
 	if (!epf->driver->ops->add_cfs)
-- 
2.40.1

