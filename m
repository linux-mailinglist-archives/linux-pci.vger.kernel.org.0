Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7446E73100F
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jun 2023 09:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjFOHFT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Jun 2023 03:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbjFOHFR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Jun 2023 03:05:17 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0491189;
        Thu, 15 Jun 2023 00:05:15 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 4C95D40269;
        Thu, 15 Jun 2023 07:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686812712;
        bh=JQEHjRZJS7f+wPWPTWCz0/KyMNju+7pW2sGQ4+QglqI=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=E++pMoFjUUcROaBFf25crp9Mxsq8B72w+rwc+mkdmRkPcXI3Q4YJXn8JJ+Unc4s48
         HXi1nrw6K/Muvna1tm+QxQvk+2jbn0lJ4XKHQGtj+frRs/5SjSnKpkYQj66AyKmefz
         34vkLHq9tuVBpCWv+RwspT++MyWomxuGJ8nVGYhuMjBu9eGrXYDufe/YBHefgIToP1
         8qgE/trMc3ngPZH+NZzsP0TYATUzY42+52l0CkiEitKWaup5Sfq0Wbw0TL9CYSng+n
         5ZTXJN8xJozGPOT2U0GDULzSzQ98YvElFYqCFwIlZKVYIs3gN8B9iFmp37ngI7usZJ
         +m0k+WU8vJCRg==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     bhelgaas@google.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Michael Bottini <michael.a.bottini@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI/ASPM: Enable ASPM on external PCIe devices
Date:   Thu, 15 Jun 2023 15:04:20 +0800
Message-Id: <20230615070421.1704133-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
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

When a PCIe device is hotplugged to a Thunderbolt port, ASPM is not
enabled for that device. However, when the device is plugged preboot,
ASPM is enabled by default.

The disparity happens because BIOS doesn't have the ability to program
ASPM on hotplugged devices.

So enable ASPM by default for external connected PCIe devices so ASPM
settings are consitent between preboot and hotplugged.

On HP Thunderbolt Dock G4, enable ASPM can also fix BadDLLP error:
pcieport 0000:00:1d.0: AER: Corrected error received: 0000:07:04.0
pcieport 0000:07:04.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Receiver ID)
pcieport 0000:07:04.0:   device [8086:0b26] error status/mask=00000080/00002000
pcieport 0000:07:04.0:    [ 7] BadDLLP

The root cause is still unclear, but quite likely because the I225 on
the dock supports PTM, where ASPM timing is precalculated for the PTM.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217557
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/pci/pcie/aspm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 66d7514ca111..613b0754c9bb 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -119,7 +119,9 @@ static int policy_to_aspm_state(struct pcie_link_state *link)
 		/* Enable Everything */
 		return ASPM_STATE_ALL;
 	case POLICY_DEFAULT:
-		return link->aspm_default;
+		return dev_is_removable(&link->downstream->dev) ?
+			link->aspm_capable :
+			link->aspm_default;
 	}
 	return 0;
 }
-- 
2.34.1

