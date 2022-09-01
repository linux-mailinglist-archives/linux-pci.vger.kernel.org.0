Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD4B5A9ED7
	for <lists+linux-pci@lfdr.de>; Thu,  1 Sep 2022 20:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbiIASSO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Sep 2022 14:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234392AbiIASSF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Sep 2022 14:18:05 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836367B79B
        for <linux-pci@vger.kernel.org>; Thu,  1 Sep 2022 11:18:02 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id i7-20020a17090adc0700b001fd7ccbec3cso6256270pjv.0
        for <linux-pci@vger.kernel.org>; Thu, 01 Sep 2022 11:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=3DXCPe1BdEtYuRHvCYZXZkquoUJcR5dxO1Uv98IS8Fo=;
        b=Aehod6L+M3ml0QOxN7x+0w3h0/6goHcKiCZebMRRRooSJP64c5JGUMmT0Xs0eXcJQX
         KAebQ+kqsEsjzxwwCuCi+sTSZ9ePGDRJ4Ke8LtzrvIc85ZUFTKXl6caEY+cTLN//OYSf
         0QqAgptsvqA+mNuSroupv9lAYWD/oiajx3bhNgTGjKE+5FJqGpp5hl75V/YPuX9vsEwJ
         H9pYqtwIfWdmAJsRJBDrKwHc/OkPFAj95m1JVMfBleKx9eJGlDea3htyn18Jqhle3msk
         1aFF1ndcoISes5UYjaPU1OELeWO86cea/I3zJ3XNGnx8Nc3DA33tRGi9jv4uXcMiqB7J
         p+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=3DXCPe1BdEtYuRHvCYZXZkquoUJcR5dxO1Uv98IS8Fo=;
        b=FE4HgLP0O4/M3Z0Ch5B79Kzcrq931Fch6CEEhv8JMuDdKVyZrwCHCclJeg7uf5qBRn
         jCxObmebW7bWNiCiOyBU9BRrYQLlXRG39Q2/nZJE1IpY4LYjLFJPi/4h+2CEZ0PLuG91
         AVicV62o0dy+KPoG1obG7I+yqGN/UAVpkcx7bt+CDqEZrvLhoixS3ugL4NPbJuDkNPBN
         VfjLoPpiIkL+vsH0s8uff2wI7MgGPNDqC/xSdtWawk0AK40sS0xmiCfFqKN1mDarxg+T
         wzWhGW0c/5rEGt5E/v1DA6Bp6cCLsIVcQebgLwaVediAuTfco1lC05Q6cyBh5U43ODMu
         TEaA==
X-Gm-Message-State: ACgBeo0MOyCDLpM8czV/GkSdkYG9kgMVlS/kPZH2zO09HlSCcv0OoZCk
        q0HqsA4SEkCjqC+HsGNeBhqz8w==
X-Google-Smtp-Source: AA6agR5k3r5xfxPxjuPBt32QIykPTxBunw1TVl9SKzFPTIijRtI9vvEivAH4/47P1EXXXpyDgDMWRQ==
X-Received: by 2002:a17:903:32d2:b0:172:f62a:2f33 with SMTP id i18-20020a17090332d200b00172f62a2f33mr31495269plr.16.1662056281071;
        Thu, 01 Sep 2022 11:18:01 -0700 (PDT)
Received: from C02F63J9MD6R.bytedance.net ([61.120.150.77])
        by smtp.gmail.com with ESMTPSA id b13-20020a170903228d00b0017519b86996sm6320538plh.218.2022.09.01.11.17.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Sep 2022 11:18:00 -0700 (PDT)
From:   Zhuo Chen <chenzhuo.1@bytedance.com>
To:     fancer.lancer@gmail.com, jdmason@kudzu.us, dave.jiang@intel.com,
        allenbh@gmail.com, bhelgaas@google.com, ruscur@russell.cc,
        oohall@gmail.com, james.smart@broadcom.com,
        dick.kennedy@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     chenzhuo.1@bytedance.com, ntb@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-scsi@vger.kernel.org
Subject: [PATCH 3/3] PCI/AER: Use pci_aer_raw_clear_status() to clear root port's AER error status
Date:   Fri,  2 Sep 2022 02:16:34 +0800
Message-Id: <20220901181634.99591-4-chenzhuo.1@bytedance.com>
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

Statements clearing AER error status in aer_enable_rootport() has the
same function as pci_aer_raw_clear_status(). So we replace them, which
has no functional changes.

Signed-off-by: Zhuo Chen <chenzhuo.1@bytedance.com>
---
 drivers/pci/pcie/aer.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index d2996afa80f6..eb0193f279f2 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1287,12 +1287,7 @@ static void aer_enable_rootport(struct aer_rpc *rpc)
 				   SYSTEM_ERROR_INTR_ON_MESG_MASK);
 
 	/* Clear error status */
-	pci_read_config_dword(pdev, aer + PCI_ERR_ROOT_STATUS, &reg32);
-	pci_write_config_dword(pdev, aer + PCI_ERR_ROOT_STATUS, reg32);
-	pci_read_config_dword(pdev, aer + PCI_ERR_COR_STATUS, &reg32);
-	pci_write_config_dword(pdev, aer + PCI_ERR_COR_STATUS, reg32);
-	pci_read_config_dword(pdev, aer + PCI_ERR_UNCOR_STATUS, &reg32);
-	pci_write_config_dword(pdev, aer + PCI_ERR_UNCOR_STATUS, reg32);
+	pci_aer_raw_clear_status(pdev);
 
 	/*
 	 * Enable error reporting for the root port device and downstream port
-- 
2.30.1 (Apple Git-130)

