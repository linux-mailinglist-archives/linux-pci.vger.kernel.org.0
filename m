Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462E553A742
	for <lists+linux-pci@lfdr.de>; Wed,  1 Jun 2022 15:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354032AbiFAN7X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Jun 2022 09:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354075AbiFAN6y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Jun 2022 09:58:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F0B8A06F;
        Wed,  1 Jun 2022 06:55:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1CC85B81AEA;
        Wed,  1 Jun 2022 13:55:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D226C341C0;
        Wed,  1 Jun 2022 13:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654091728;
        bh=g0u/pd5I5cajoFlJAmHmEkUnMh+QPi0LxEXCIF7xBjo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XtAjYIhgXfRGyyMhXFXUap1rzz57EVW70Y4wkEWEt5UwkTOdQjaY1yfuynXLRduD2
         Mco2AHoIvsc8caHmdofH5rmxSc85ETDPPtxpxBpJSTOOm5rClrTaqU/jdVpyWceFxg
         PxvdTzP2wLQabnwssUStFHvyuhSOYfMj8ThGG04JcS6KpUFJ/+5NP95dmffTHYjsyF
         +UZFQQPOs5ZBhmUsA9apheegQweDRK2zu6AOCQ+BALFq1KxRAtxUg72LTtUKo2zIa5
         v3kb6DKBx+ALj9icDMMY4IYuyR9WhsFicb0QoF4VEOrL+kc3R0Z0vjyVR5MPQpV9SY
         d/OPcuIivuYlA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yicong Yang <yangyicong@hisilicon.com>,
        Jay Zhou <jianjay.zhou@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.17 30/48] PCI: Avoid pci_dev_lock() AB/BA deadlock with sriov_numvfs_store()
Date:   Wed,  1 Jun 2022 09:54:03 -0400
Message-Id: <20220601135421.2003328-30-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220601135421.2003328-1-sashal@kernel.org>
References: <20220601135421.2003328-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Yicong Yang <yangyicong@hisilicon.com>

[ Upstream commit a91ee0e9fca9d7501286cfbced9b30a33e52740a ]

The sysfs sriov_numvfs_store() path acquires the device lock before the
config space access lock:

  sriov_numvfs_store
    device_lock                 # A (1) acquire device lock
    sriov_configure
      vfio_pci_sriov_configure  # (for example)
        vfio_pci_core_sriov_configure
          pci_disable_sriov
            sriov_disable
              pci_cfg_access_lock
                pci_wait_cfg    # B (4) wait for dev->block_cfg_access == 0

Previously, pci_dev_lock() acquired the config space access lock before the
device lock:

  pci_dev_lock
    pci_cfg_access_lock
      dev->block_cfg_access = 1 # B (2) set dev->block_cfg_access = 1
    device_lock                 # A (3) wait for device lock

Any path that uses pci_dev_lock(), e.g., pci_reset_function(), may
deadlock with sriov_numvfs_store() if the operations occur in the sequence
(1) (2) (3) (4).

Avoid the deadlock by reversing the order in pci_dev_lock() so it acquires
the device lock before the config space access lock, the same as the
sriov_numvfs_store() path.

[bhelgaas: combined and adapted commit log from Jay Zhou's independent
subsequent posting:
https://lore.kernel.org/r/20220404062539.1710-1-jianjay.zhou@huawei.com]
Link: https://lore.kernel.org/linux-pci/1583489997-17156-1-git-send-email-yangyicong@hisilicon.com/
Also-posted-by: Jay Zhou <jianjay.zhou@huawei.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pci.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d25122fbe98a..1af69e298ac3 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5113,19 +5113,19 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
 
 void pci_dev_lock(struct pci_dev *dev)
 {
-	pci_cfg_access_lock(dev);
 	/* block PM suspend, driver probe, etc. */
 	device_lock(&dev->dev);
+	pci_cfg_access_lock(dev);
 }
 EXPORT_SYMBOL_GPL(pci_dev_lock);
 
 /* Return 1 on successful lock, 0 on contention */
 int pci_dev_trylock(struct pci_dev *dev)
 {
-	if (pci_cfg_access_trylock(dev)) {
-		if (device_trylock(&dev->dev))
+	if (device_trylock(&dev->dev)) {
+		if (pci_cfg_access_trylock(dev))
 			return 1;
-		pci_cfg_access_unlock(dev);
+		device_unlock(&dev->dev);
 	}
 
 	return 0;
@@ -5134,8 +5134,8 @@ EXPORT_SYMBOL_GPL(pci_dev_trylock);
 
 void pci_dev_unlock(struct pci_dev *dev)
 {
-	device_unlock(&dev->dev);
 	pci_cfg_access_unlock(dev);
+	device_unlock(&dev->dev);
 }
 EXPORT_SYMBOL_GPL(pci_dev_unlock);
 
-- 
2.35.1

