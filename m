Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2EF702646
	for <lists+linux-pci@lfdr.de>; Mon, 15 May 2023 09:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239050AbjEOHoC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 May 2023 03:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238763AbjEOHn5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 May 2023 03:43:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85205128
        for <linux-pci@vger.kernel.org>; Mon, 15 May 2023 00:43:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1204662059
        for <linux-pci@vger.kernel.org>; Mon, 15 May 2023 07:43:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80C8C4339C;
        Mon, 15 May 2023 07:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684136632;
        bh=MHnMnTxBeN4VAqR3hDETaMoq34uhvQbWlrG6LruptBQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=PKyzkaVHyiC1Xd/Jf1XBDaA/W8/TnbJJkspFvcby8d++4xHtlWSLnaUzMR6j3LjaE
         +2wkz0/k5yRTES1GY4A7pSBMSj+/hrOOYd2jCSZmfkET2woPVb/LVKSX8ZwGhAnhq7
         wWXnio0boEnKLJ/if/MQIcOGaX1nZVepCO+xgF7ch9hNn5O5NWkLN2sBO/pgt7O9WA
         q1HOqFQ4UI4kE/D12bC6UZ4V4RghUHGUAIOuO8Vttr1JQlUigvmJh8jCajfqntp5B4
         9VNd3xXKCtMTE8fPUt9kMAZPssLn/QA1UFglweb+NHy0X9BgB5JK1ffMlaeXURK5V4
         mQu66tDpEP9KQ==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 2/2] PCI: endpoint: Add kdoc description of pci_epf_type_add_cfs()
Date:   Mon, 15 May 2023 16:43:48 +0900
Message-Id: <20230515074348.595704-3-dlemoal@kernel.org>
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

Restore an improve the kdoc function description for
pci_epf_type_add_cfs() that was removed with commit
893f14fed7d3 ("PCI: endpoint: Move pci_epf_type_add_cfs() code").

Fixes: 893f14fed7d3 ("PCI: endpoint: Move pci_epf_type_add_cfs() code")
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/endpoint/pci-ep-cfs.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index 0bf5be986e9b..be042c3f50b5 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -509,6 +509,22 @@ static const struct config_item_type pci_epf_type = {
 	.ct_owner	= THIS_MODULE,
 };
 
+/**
+ * pci_epf_type_add_cfs() - Help function drivers to expose function specific   
+ *                          attributes in configfs
+ * @epf: the EPF device that has to be configured using configfs
+ * @group: the parent configfs group (corresponding to entries in
+ *         pci_epf_device_id)
+ *
+ * Invoke to expose function specific attributes in configfs.
+ *
+ * Return: A pointer to a config_group structure or NULL if the function driver
+ * does not have anything to expose (attributes configured by user) or if the
+ * the function driver does not implement the add_cfs() method.
+ *
+ * Returns an error pointer if this function is called for an unbound EPF device
+ * or if the EPF driver add_cfs() method fails.
+ */
 static struct config_group *pci_epf_type_add_cfs(struct pci_epf *epf,
 						 struct config_group *group)
 {
-- 
2.40.1

