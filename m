Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD0D6BCA87
	for <lists+linux-pci@lfdr.de>; Thu, 16 Mar 2023 10:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjCPJPz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Mar 2023 05:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjCPJPy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Mar 2023 05:15:54 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0805AB4D;
        Thu, 16 Mar 2023 02:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1678958152; x=1710494152;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vNBKUCn+oSOubieZrKRWxbCHp3w8zx3bOHe3umDYycw=;
  b=aDstGSYayo0Uez0xz1sw0mJ3Zqsb7qmgeec3GwAjf4CrwsAexESBYOmY
   g3bHZzzp7UF5oaEt2shEP1QWlVYmJ7Lbf3NVg3FwhBMAsKCC0rxSnqAeA
   rr2xllU+6Wl5NsEKyGPfeLQnF3zoaHHnPqpzKyjdgYpa2qsEfaVNkNuCN
   zyDp/4GfrGpAnAdwvUl02v9So1ymvO7CuT0NAm2sQo8kYiIxiGDFRncl2
   BgcwgHn3KgLjoxvazMUPTtwT2tBztIvjR/ELUB1I0TEcS2Qb8LEvNk1CU
   YP3uC9Cicaq8zpKkHr4OnbTJe5NjjQcs4G8Q66Cdletojg6hUq0X59Nlj
   A==;
X-IronPort-AV: E=Sophos;i="5.98,265,1673910000"; 
   d="scan'208";a="29730469"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 16 Mar 2023 10:15:49 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 16 Mar 2023 10:15:49 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 16 Mar 2023 10:15:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1678958149; x=1710494149;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vNBKUCn+oSOubieZrKRWxbCHp3w8zx3bOHe3umDYycw=;
  b=Q4h+tnXTJvDIjbGBHT/Ri4SboGxaSMFFTAKh3SM6/NJITqg1XKuptYgu
   uylJwGqVYU72CEntyARNxePw7usmJe/tVkeZxi2LRwME08vlUR2pd9plL
   dWSOO6uXdpTNzE5zZdlFULRiW6ZSPbhflJHlYpxIc2gBfz7N2sYtiFrXM
   DOxKI455z4K+HsfXemK1CAjflfZq9TJEPF/giHWpIakZ9Eg+AboZsaynQ
   NlZZykyNugPQ1zyhMFaSxKKvux59jnSYcy8GhvBPheLFTLQtbRKPd41iG
   0EiV7t581d3yLbTXSF5cb0ATY2RCv78yI86/JjvRegx6WouKHezC2RZkB
   w==;
X-IronPort-AV: E=Sophos;i="5.98,265,1673910000"; 
   d="scan'208";a="29730468"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 16 Mar 2023 10:15:49 +0100
Received: from steina-w.tq-net.de (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 3ABF8280056;
        Thu, 16 Mar 2023 10:15:49 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Korneliusz Osmenda <korneliuszo@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: [PATCH v2 1/1] Guard pci_create_sysfs_dev_files with atomic value
Date:   Thu, 16 Mar 2023 10:15:40 +0100
Message-Id: <20230316091540.494366-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Korneliusz Osmenda <korneliuszo@gmail.com>

On Gateworks Ventana there is a number of PCI devices and:
  - imx6_pcie_probe takes longer than start of late init
  - pci_sysfs_init sets up flag sysfs_initialized
  - pci_sysfs_init initializes already found devices
  - imx6_pcie_probe tries to reinitialize device

Link: https://bugzilla.kernel.org/show_bug.cgi?id=215515

Signed-off-by: Korneliusz Osmenda <korneliuszo@gmail.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/pci/pci-sysfs.c | 6 ++++++
 include/linux/pci.h     | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index dd0d9d9bc509..998e44716b6f 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1497,6 +1497,9 @@ int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
 	if (!sysfs_initialized)
 		return -EACCES;
 
+	if (atomic_cmpxchg(&pdev->sysfs_init_cnt, 0, 1) == 1)
+		return 0;		/* already added */
+
 	return pci_create_resource_files(pdev);
 }
 
@@ -1511,6 +1514,9 @@ void pci_remove_sysfs_dev_files(struct pci_dev *pdev)
 	if (!sysfs_initialized)
 		return;
 
+	if (atomic_cmpxchg(&pdev->sysfs_init_cnt, 1, 0) == 0)
+		return;		/* already removed */
+
 	pci_remove_resource_files(pdev);
 }
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index b50e5c79f7e3..024313a7a90a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -467,6 +467,8 @@ struct pci_dev {
 	pci_dev_flags_t dev_flags;
 	atomic_t	enable_cnt;	/* pci_enable_device has been called */
 
+	atomic_t	sysfs_init_cnt;	/* pci_create_sysfs_dev_files has been called */
+
 	u32		saved_config_space[16]; /* Config space saved at suspend time */
 	struct hlist_head saved_cap_space;
 	int		rom_attr_enabled;	/* Display of ROM attribute enabled? */
-- 
2.34.1

