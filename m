Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F65F702335
	for <lists+linux-pci@lfdr.de>; Mon, 15 May 2023 07:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjEOFPL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 May 2023 01:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbjEOFPJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 May 2023 01:15:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B6F26A4
        for <linux-pci@vger.kernel.org>; Sun, 14 May 2023 22:15:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACB6C61EE0
        for <linux-pci@vger.kernel.org>; Mon, 15 May 2023 05:15:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F684C433A4;
        Mon, 15 May 2023 05:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684127704;
        bh=/oILAAeilRAmuYSY0Ik478ra+mYMbRgCHkGJ/573uO0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Bo0/mqpw12oSvi9ZdTEX4HMiH4Bm60J0qkA3IILENSXwhqDmQl9BVXdspRMk4N/0x
         k/OP14/6INfmGk5GrHPJNhZMA8f36xk6Isz2cDWBjZ+8m5CHAkEu+/b8/k31UdBNHT
         qmTM/3KwUto/Fi6NGg1VgGMj3/xl59o58SHhfFl/EDsk1sUeKka3nihlfBUIdh112P
         0LYEbfItzUwZciS2KwJADXqN5+/eUkmIzgCcoe5iXBJSjS/gKRUkjwhiCkMznpjlCd
         e2kkf7YXhfZqzqE/PRs3Z92ZZmbIjnt50er7LJ33Vtr6cimxQ0Can3owwJjwdOGkHv
         z0bQnfYm8uuXg==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/2] PCI: endpoint: Add kdoc description of pci_epf_type_add_cfs()
Date:   Mon, 15 May 2023 14:15:00 +0900
Message-Id: <20230515051500.574127-3-dlemoal@kernel.org>
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

Restore an improve the kdoc function description for
pci_epf_type_add_cfs() that was removed with commit
893f14fed7d3 ("PCI: endpoint: Move pci_epf_type_add_cfs() code").

Fixes: 893f14fed7d3 ("PCI: endpoint: Move pci_epf_type_add_cfs() code")
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/endpoint/pci-ep-cfs.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index d8a6abe2c31c..15e17a661875 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -509,6 +509,24 @@ static const struct config_item_type pci_epf_type = {
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
+ * Return: NULL if the function driver
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

