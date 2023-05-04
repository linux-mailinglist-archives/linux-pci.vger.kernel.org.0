Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29FF76F699F
	for <lists+linux-pci@lfdr.de>; Thu,  4 May 2023 13:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjEDLNh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 May 2023 07:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjEDLNg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 May 2023 07:13:36 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8304D1FC4
        for <linux-pci@vger.kernel.org>; Thu,  4 May 2023 04:13:35 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-559c416b024so2523367b3.1
        for <linux-pci@vger.kernel.org>; Thu, 04 May 2023 04:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683198815; x=1685790815;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VZTg8YSU09x/TXpR8rBIyBBy9InhsQZVM6s+v85AAEk=;
        b=cj8Luu6jMlKLRDhfSPHC5uICu+23pbqOZ/2sFrp9zUQQge2MjKr4NM8tUwHmAczjbY
         5iUWdnrTypI3TsMnThwPd0ykqnPhP9s4AVbokUnarJE6rVMsf2YvpW2J6d2g5YPSMwpV
         9tGKgjku2cAX7uyA+n3Kl9uBWIHfv0ps+eBYdwWhZMC+106/Wn+Re3KIpjm695dzKps2
         aOvuVe8pj1e2jNqBaAss22g0oFPO4IWDwW2UgjawOw5p6FLCEiA1ylxO9HzP5U0aP/sp
         QChiIxeZPyIeEJswvJxeRw6ya0e3F7WNjs5qkyfU5zRIWUWCiszMDvw2yGU0exO75I27
         7czA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683198815; x=1685790815;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VZTg8YSU09x/TXpR8rBIyBBy9InhsQZVM6s+v85AAEk=;
        b=dhreEVYjxXliol7kJG27cUt/8Da/7G1R+54+a5ZddRZLKsNNuhPhs0XTj53fRlsaaw
         x6MR01YzbYwYj/M5VFhXeVgubidBcDPJVY8ov57y5l31nK3rI4ldlKpjadbMTCMnJXdC
         1NW/dTK44O7LprjMQhAya+vAOj5qNKE32KWwgZzFR5sMdssI1heqyHA07U0+rgU3cA9o
         S8QFBH8z8lSWsU/cGQO73d7+zujd7yqf+ECwBoSVK7jaq6pvg5d1dMpMORqAYBjwzJXs
         xS/zexv38NE/HJ4t7Ct90U3Wj8Xyf7NVE8d+yS5GrjqH4dd9DIaDtw5v1Mo2D6/gl3/i
         7Seg==
X-Gm-Message-State: AC+VfDxYq4ljDjEZJIzQMPX4WR7sqFz7kyammxEK/+J5xpnlxnvLd6Wb
        T0CP1UbGUiJYYvdY72JqCEmNGi1gIj+kYjgf1w==
X-Google-Smtp-Source: ACHHUZ5C13M4c1gxRubfPt6t4oAUYlpzRWI7JAOF/kAzlt5Afkb5tepOX73rEbGXnUjvJqCrKlGt/FP6EEpBGpp+7g==
X-Received: from ajaya.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:39b5])
 (user=ajayagarwal job=sendgmr) by 2002:a25:2d27:0:b0:b9a:696a:770f with SMTP
 id t39-20020a252d27000000b00b9a696a770fmr15223014ybt.13.1683198814795; Thu,
 04 May 2023 04:13:34 -0700 (PDT)
Date:   Thu,  4 May 2023 16:43:01 +0530
In-Reply-To: <20230504111301.229358-1-ajayagarwal@google.com>
Mime-Version: 1.0
References: <20230504111301.229358-1-ajayagarwal@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230504111301.229358-6-ajayagarwal@google.com>
Subject: [PATCH v3 5/5] PCI/ASPM: Remove unnecessary ASPM_STATE_L1SS check
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

Currently the driver checks if ASPM_STATE_L1SS is supported
before calling aspm_calc_l12_info(), only for this function to
return if ASPM_STATE_L1_2_MASK is not supported. Simplify the
logic by directly checking for L1.2 mask.

Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
---
Changelog since v2:
 - None

Changelog since v1:
 - Rebase on top of the L1.2 function rename patch

 drivers/pci/pcie/aspm.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index db7c369a0544..e89091cba356 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -481,9 +481,6 @@ static void aspm_calc_l12_info(struct pcie_link_state *link,
 	u32 pctl1, pctl2, cctl1, cctl2;
 	u32 pl1_2_enables, cl1_2_enables;
 
-	if (!(link->aspm_support & ASPM_STATE_L1_2_MASK))
-		return;
-
 	/* Choose the greater of the two Port Common_Mode_Restore_Times */
 	val1 = (parent_l1ss_cap & PCI_L1SS_CAP_CM_RESTORE_TIME) >> 8;
 	val2 = (child_l1ss_cap & PCI_L1SS_CAP_CM_RESTORE_TIME) >> 8;
@@ -616,7 +613,7 @@ static void aspm_l1ss_init(struct pcie_link_state *link)
 	if (parent_l1ss_ctl1 & child_l1ss_ctl1 & PCI_L1SS_CTL1_PCIPM_L1_2)
 		link->aspm_enabled |= ASPM_STATE_L1_2_PCIPM;
 
-	if (link->aspm_support & ASPM_STATE_L1SS)
+	if (link->aspm_support & ASPM_STATE_L1_2_MASK)
 		aspm_calc_l12_info(link, parent_l1ss_cap, child_l1ss_cap);
 }
 
-- 
2.40.1.495.gc816e09b53d-goog

