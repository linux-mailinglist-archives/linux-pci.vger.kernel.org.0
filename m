Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5E55A9ED2
	for <lists+linux-pci@lfdr.de>; Thu,  1 Sep 2022 20:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234174AbiIASR7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Sep 2022 14:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234256AbiIASR4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Sep 2022 14:17:56 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E251E7B79B
        for <linux-pci@vger.kernel.org>; Thu,  1 Sep 2022 11:17:54 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 78so3636240pgb.13
        for <linux-pci@vger.kernel.org>; Thu, 01 Sep 2022 11:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=zI/BTKFXJXbsFO1kxQzveFTmwvhlHGn8PgFA+S1jres=;
        b=lbGN4Kp3lRbdgZAgZthVUQrgacQyY9T1ORf4+IRNyEdsR08hfaasoXVs5DtXtNjkTt
         wTxeqEsp7RBY+UWH7L93OCDfVRg9a1qSh9cBwhtS4I6Er4mCMCBHZU5JSui19cnXXiig
         44oPiVPAXmom3N3thvuWvMaOvOfbAWjPKiQSDzINje0Iw3JqQRthMh0s8MIbff5OnpvO
         N9tS9ZKZ0SL5YyBB3QM4IjwgO1zAcad5VDu0Kunmmzc158kOPOqoqYiZnKQaU3pCner0
         QYRlE7l5InBZMbljno6S49tduW45wREpYyIuNPHbDZ1EkbLBhOg8Xve56z8sFCfzHqVq
         iV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=zI/BTKFXJXbsFO1kxQzveFTmwvhlHGn8PgFA+S1jres=;
        b=dwsvULuiivFIN8cMqIBV12zWyRqz7iHLSEJimIRWB/GV0bkXcIyhEyO0FaA6dhAoC0
         iHGyUnJFsx/ejsv4lSbxGe8o3dOY26wwTK0UL5etg8Mn9wVCS17yUHiriEljkCX8OPSC
         DGKLMdyoXjsl1v5brsNED/YPhu3Zn4f44hMIbPbrMWy4FO6yLcu79RNwbkymwruSH2e9
         gbKgyNTjJcnPvrB+a4or/W2qGkOba17NWhDmnUdlYloBcQ3fsGREsbuE00lQj884rtUc
         M8+HEzAnnAU4KjvXEQPrDelre2ROKmIrTXVK4qGKf52sfXMfmQdw7r6TLBeWqUXLE48O
         +WJQ==
X-Gm-Message-State: ACgBeo3T4lJ/xhc4wHTKCv5woiKf8bwqlQIDcYuOK+NjeMI0v8NBjMgx
        4WfX8MH6B6DWQklS7v5YqMuptA==
X-Google-Smtp-Source: AA6agR7kM8iGzccwGQ6iMySe4S2grbdHOsy/itfUuKWXsnekyj0x05dNeHnyQVuTcw2HeZHUxsgADQ==
X-Received: by 2002:a05:6a00:88a:b0:53a:b7a0:ea3a with SMTP id q10-20020a056a00088a00b0053ab7a0ea3amr9698501pfj.21.1662056274006;
        Thu, 01 Sep 2022 11:17:54 -0700 (PDT)
Received: from C02F63J9MD6R.bytedance.net ([61.120.150.77])
        by smtp.gmail.com with ESMTPSA id b13-20020a170903228d00b0017519b86996sm6320538plh.218.2022.09.01.11.17.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Sep 2022 11:17:53 -0700 (PDT)
From:   Zhuo Chen <chenzhuo.1@bytedance.com>
To:     fancer.lancer@gmail.com, jdmason@kudzu.us, dave.jiang@intel.com,
        allenbh@gmail.com, bhelgaas@google.com, ruscur@russell.cc,
        oohall@gmail.com, james.smart@broadcom.com,
        dick.kennedy@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     chenzhuo.1@bytedance.com, ntb@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-scsi@vger.kernel.org
Subject: [PATCH 2/3] PCI/ERR: Clear fatal status in pcie_do_recovery()
Date:   Fri,  2 Sep 2022 02:16:33 +0800
Message-Id: <20220901181634.99591-3-chenzhuo.1@bytedance.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220901181634.99591-1-chenzhuo.1@bytedance.com>
References: <20220901181634.99591-1-chenzhuo.1@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When state is pci_channel_io_frozen in pcie_do_recovery(),
the severity is fatal and fatal status should be cleared.
So we add pci_aer_clear_fatal_status().

Since pcie_aer_is_native() in pci_aer_clear_fatal_status()
and pci_aer_clear_nonfatal_status() contains the function of
'if (host->native_aer || pcie_ports_native)', so we move them
out of it.

Signed-off-by: Zhuo Chen <chenzhuo.1@bytedance.com>
---
 drivers/pci/pcie/err.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 0c5a143025af..e0a8ade4c3fe 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -243,10 +243,14 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	 * it is responsible for clearing this status.  In that case, the
 	 * signaling device may not even be visible to the OS.
 	 */
-	if (host->native_aer || pcie_ports_native) {
+	if (host->native_aer || pcie_ports_native)
 		pcie_clear_device_status(dev);
+
+	if (state == pci_channel_io_frozen)
+		pci_aer_clear_fatal_status(dev);
+	else
 		pci_aer_clear_nonfatal_status(dev);
-	}
+
 	pci_info(bridge, "device recovery successful\n");
 	return status;
 
-- 
2.30.1 (Apple Git-130)

