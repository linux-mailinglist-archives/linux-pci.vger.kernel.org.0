Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F335166569D
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jan 2023 09:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjAKI7H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Jan 2023 03:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235915AbjAKI6H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jan 2023 03:58:07 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5BF11C05
        for <linux-pci@vger.kernel.org>; Wed, 11 Jan 2023 00:58:02 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id cf18so28774083ejb.5
        for <linux-pci@vger.kernel.org>; Wed, 11 Jan 2023 00:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dIR2xDCwvSRKEc84pnvuLnDAA2EO2M8cMUOrk8Csn0U=;
        b=BXsnxd+cMQ/xma/iDDej0ALq3kPfbTTTd34E+TACOAlzUKnW6PEjk6yTIVHo9bqpe7
         O07eGYVjd/qkKtA1XbFAM7mRU2BOMIACAhyAV4tIuJGpCx25wox2NQQnChfit0oCvsYd
         djKypzpeZQWQ6nV7aCAagNoiuNnd4ReHPfDsh1ObkJSgmFX/119GFTYbV8aicehvPy8N
         5iK/dCxhLvo2/V3y8bY/MnCbAuzeKlIsSxhk0UMb/avSp8w1BeJj4oedH2v3o4pZ3Pa8
         JN8Z5+NjwfgSv6XxuJbzvQ+HuP/HaKKSCu6OANom/KJ05imfHALFPGOQ09ZQwv43+iC9
         +K/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dIR2xDCwvSRKEc84pnvuLnDAA2EO2M8cMUOrk8Csn0U=;
        b=1to+UJI8TqE/69uValFn5LWUj4chRX5wezJsh5zJARkuvFixciQJtCLYJadAWGHw4k
         1/lkQl7HouT1vU7FkSW/NKLz39cC0qD+47B8L+Rz3mrTdbQ5RCrkmy/wEoHuwmtHRzq3
         RhUzthfEIfXaEu4v9JaL/jDLsACPM9Kw7sTWGXnaseEthOGORMSpp+7Y3YYro59crLMp
         jqNnhC6waApGeam93UzddPOmHkoMf0B/CZHglc8kpo56pALkVsNplguJSHYgRAnEfEWm
         4YDh6Eg9vGTGAHTKGpRP3bTU07WUfDRaORhknnv+4E3vOfggx10uALWDisdY7Oaf4UkM
         wOWg==
X-Gm-Message-State: AFqh2kot9uHGH7X1dNkTK9Y4UpJ020X4QJXUO2npb1A37tav1+Jp4/T5
        RIIgZG4KmnwkpcTUaYJABfik28hOXG4=
X-Google-Smtp-Source: AMrXdXtRbgeYkoDTeSk1rSKq3NZtKgegFgH1kQ8tUDVJRCx2R6OTApbtDSuA2oiCuqdT1nXMgw5kxA==
X-Received: by 2002:a17:907:6f18:b0:837:3ed3:9c2b with SMTP id sy24-20020a1709076f1800b008373ed39c2bmr68164923ejc.5.1673427481069;
        Wed, 11 Jan 2023 00:58:01 -0800 (PST)
Received: from EliteBook.fritz.box ([2a02:908:1256:79a0:752d:cd68:6cff:3acf])
        by smtp.gmail.com with ESMTPSA id 10-20020a170906218a00b0073d796a1043sm5825110eju.123.2023.01.11.00.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 00:58:00 -0800 (PST)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     linux-pci@vger.kernel.org
Cc:     =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Tony Zhu <tony.zhu@intel.com>, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH] PCI: revert "Enable PASID only when ACS RR & UF enabled on upstream path"
Date:   Wed, 11 Jan 2023 09:57:45 +0100
Message-Id: <20230111085745.401710-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This reverts commit 201007ef707a8bb5592cd07dd46fc9222c48e0b9.

It's correct that the PCIe fabric routes Memory Requests based on the
TLP address, but enabling the PASID mapping doesn't necessary mean that
Memory Requests will have a PASID associated with them.

The alternative is ATS which lets the device resolve the PASID+addr pair
before a memory request is made into a routeable TLB address through the
TA. Those resolved addresses are then cached on the device instead of
in the IOMMU TLB.

So the assumption that you mandatory need ACS to enabled PASID handling
on a device is simply not correct, we need to take ATS into account as
well.

The patch caused failures with AMDs integrated GPUs because some of them
only enable ATS but not ACS.

For now just revert the patch until this is completely solved.

CC: Jason Gunthorpe <jgg@nvidia.com>
CC: Kevin Tian <kevin.tian@intel.com>
CC: Lu Baolu <baolu.lu@linux.intel.com>
CC: Bjorn Helgaas <bhelgaas@google.com>
CC: Tony Zhu <tony.zhu@intel.com>
CC: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Christian König <christian.koenig@amd.com>
Bug: https://bugzilla.kernel.org/show_bug.cgi?id=216865
---
 drivers/pci/ats.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index f9cc2e10b676..c967ad6e2626 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -382,9 +382,6 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
 	if (!pasid)
 		return -EINVAL;
 
-	if (!pci_acs_path_enabled(pdev, NULL, PCI_ACS_RR | PCI_ACS_UF))
-		return -EINVAL;
-
 	pci_read_config_word(pdev, pasid + PCI_PASID_CAP, &supported);
 	supported &= PCI_PASID_CAP_EXEC | PCI_PASID_CAP_PRIV;
 
-- 
2.25.1

