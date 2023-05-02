Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07FB6F4A63
	for <lists+linux-pci@lfdr.de>; Tue,  2 May 2023 21:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjEBTcC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 May 2023 15:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjEBTcB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 May 2023 15:32:01 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FF01BF9
        for <linux-pci@vger.kernel.org>; Tue,  2 May 2023 12:32:00 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9dcfade347so5700916276.2
        for <linux-pci@vger.kernel.org>; Tue, 02 May 2023 12:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683055919; x=1685647919;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gwJUylU4tx2YBYWLpswcUDBipNDG8GjX+zB/YTSAsRo=;
        b=awEZO+qiQQ/Q9PJg/D8xSgR/SLOxEPypra28/HovU3g/gjU0GO5lUBlIJBs8dUmQRX
         nfe3SaTC8ADcQZnfxkMojymqledGwFz4aToFhZ7oPo8AD4OjMlkZiYBcBKb//Ir16jYI
         Xn/V0UbLISaLEbEI8s6qIIdSOT/mHXtxvffm7fO+s8f2f1bUBHUIRPsi8dOYz+0J3yV/
         vjYQmeagQD1JOr1ceiRUQRaT4z+ukl8/T9PnsevmMaXdP9T1UKRbv1LniCXP8EMGS0Du
         DmA6/TxEGn/DYWax9n0tKo9vO4ZrBSITyEB99cgm6nCjfZ5vEF9PASeI8loHoDHoVvUA
         rHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683055919; x=1685647919;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gwJUylU4tx2YBYWLpswcUDBipNDG8GjX+zB/YTSAsRo=;
        b=Sfx7r36mLzEo3m80uNPQxBzOhDoVln2hMGl0/S60SZXqgEeEPw5tQsckF6lRS4WH20
         nrohvKMyVxGPCG7NoTHNzEPzXI/nwnrkCFXGbYZtrIovbKgvR5UqZ8B6xaVSOtPJj5OH
         0Snm72CrhFJOZ9zs3nDTdmUPvRUavAfB6ZJwFkvLmkIO6sK2VIu4T8gvUIZWAzWqGZvR
         a5eqiMrNpBTM3aV6Zfkb0h1aT1h3OYzexy2SEidiCYaJo5RnPx4D9zx27u4/JOLMnuFN
         KusbiSJvXoXJgCs0PbP/V/e+755J6pYhG8ByvI+wkmZwUitK4slsSAiSmpin1Ow5SxTE
         t6xg==
X-Gm-Message-State: AC+VfDydVBMHQpgYrs3mjrUhMM0nX1y8ypvkr7viGmrgVYEPgsw/XB/o
        K2GoaXyveNfvbvagEY1jvh2FJkEoAiPJWFJncg==
X-Google-Smtp-Source: ACHHUZ4vw2y1tj3KoswA2EHsJV2aHNWsSGUnuHcsX+VjT9gXOODHCJIvz6nTvqAIGd3B0ZHDPXF4H+Nh+j4doaynaQ==
X-Received: from ajaya.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:39b5])
 (user=ajayagarwal job=sendgmr) by 2002:a25:403:0:b0:b9e:7d81:4b91 with SMTP
 id 3-20020a250403000000b00b9e7d814b91mr1017275ybe.9.1683055919721; Tue, 02
 May 2023 12:31:59 -0700 (PDT)
Date:   Wed,  3 May 2023 01:01:37 +0530
In-Reply-To: <20230502193140.1062470-1-ajayagarwal@google.com>
Mime-Version: 1.0
References: <20230502193140.1062470-1-ajayagarwal@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230502193140.1062470-3-ajayagarwal@google.com>
Subject: [PATCH v2 2/5] PCI/ASPM: Set ASPM_STATE_L1 only when driver enables L1.0
From:   Ajay Agarwal <ajayagarwal@google.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Nikhil Devshatwar <nikhilnd@google.com>,
        Manu Gautam <manugautam@google.com>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Michael Bottini <michael.a.bottini@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, Ajay Agarwal <ajayagarwal@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently the core driver sets ASPM_STATE_L1 as well as
ASPM_STATE_L1SS when the caller wants to enable just L1.0.
This is incorrect. Fix this by setting the ASPM_STATE_L1 bit
only when the caller wishes to enable L1.0.

Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
---
Changelog since v1:
 - Break down the L1 and L1ss handling into separate patches

 drivers/pci/pcie/aspm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 5765b226102a..4ad0bf5d5838 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1170,8 +1170,7 @@ int pci_enable_link_state(struct pci_dev *pdev, int state)
 	if (state & PCIE_LINK_STATE_L0S)
 		link->aspm_default |= ASPM_STATE_L0S;
 	if (state & PCIE_LINK_STATE_L1)
-		/* L1 PM substates require L1 */
-		link->aspm_default |= ASPM_STATE_L1 | ASPM_STATE_L1SS;
+		link->aspm_default |= ASPM_STATE_L1;
 	if (state & PCIE_LINK_STATE_L1_1)
 		link->aspm_default |= ASPM_STATE_L1_1;
 	if (state & PCIE_LINK_STATE_L1_2)
-- 
2.40.1.495.gc816e09b53d-goog

