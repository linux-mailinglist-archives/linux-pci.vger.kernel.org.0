Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF8F6F4A66
	for <lists+linux-pci@lfdr.de>; Tue,  2 May 2023 21:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjEBTcR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 May 2023 15:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjEBTcQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 May 2023 15:32:16 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC871BFA
        for <linux-pci@vger.kernel.org>; Tue,  2 May 2023 12:32:15 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-55a2648c164so52486437b3.2
        for <linux-pci@vger.kernel.org>; Tue, 02 May 2023 12:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683055935; x=1685647935;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7L4IKvU9tYU9Cos16TuFcm53YMq6D9FE24ScFVaPPBc=;
        b=mulURLsBcSEkKXk9c89KW7atfFoiJDfg6Fr37a4BcaS52CnmGjaLgc11Mf7aWPIwZ6
         tle3qi2QXnoYWjTWptlLM3Qp7ifMcaVZWppmfI0F0M/g5sBgIpIMlST8l8XmDq0/iYDW
         qo96jme/U/QIrCqW6TlUbcRYU4wG0ryljipf3dYXmZ0bI3rCsFs1mPJoEPQf96qDyFsr
         qpZ0KAEBwHfe56u8CF3cEhevs3JX63gp2V2IBA1GT8ILT+n5bCGoYS1GBX93evmALPGW
         Zj6ff3tQpGVqqokEKBOg4iF6dRT2w1+BCU9fW2trDw0TzxgsZrEh6lGxanzdEf/+cDUi
         y3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683055935; x=1685647935;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7L4IKvU9tYU9Cos16TuFcm53YMq6D9FE24ScFVaPPBc=;
        b=YHw7Xk8HbWz8ohw8drL2Ed+jSzSMMCxhDQgigrnpWJoQWF232pVZkGelYQ/ecbDNrJ
         EW27Gk19oRQY/Z4XpIjEwcKlnbbjGFMiB9xyvtUiCzUrAhF//eqIjypbXn82yUV7kgBH
         +kIYuzlEIR983NKxCqS0jRSmBiA9hUyo0hG0+UiXqHZYOR4WaWWN2MonxWi5c9gfqQK1
         ghmHuxwWJHPkDciAxMr70xW6iHqSKg9WWn5LLR1YN6W3ueQ6agLPIlz5dMxI56wcv2zc
         u1LqPC07hzdtoG7gcI8BCXE3ifCRujqY+PtTrZ6Ei/wr66RLDxQz9iJ6n2bv2fIrIMYk
         pOFQ==
X-Gm-Message-State: AC+VfDwq4J0Ly+COeBxED8r2LVAgdjxUcw3hFlBhjFo/HQNixcvTSMd+
        Q1cs777/NL7TelQ7r8OHXwES1emV9hIfdzgm3Q==
X-Google-Smtp-Source: ACHHUZ7v2YLKwVUEQNlULmw97WRLbvUpDNx0lUTvLt5PKI0cRDfSJZczeZCTpoev5gVfkLbVFHno7I+vD2Q/q3V3pg==
X-Received: from ajaya.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:39b5])
 (user=ajayagarwal job=sendgmr) by 2002:a81:ad20:0:b0:559:d832:df2f with SMTP
 id l32-20020a81ad20000000b00559d832df2fmr7148947ywh.5.1683055935188; Tue, 02
 May 2023 12:32:15 -0700 (PDT)
Date:   Wed,  3 May 2023 01:01:40 +0530
In-Reply-To: <20230502193140.1062470-1-ajayagarwal@google.com>
Mime-Version: 1.0
References: <20230502193140.1062470-1-ajayagarwal@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230502193140.1062470-6-ajayagarwal@google.com>
Subject: [PATCH v2 5/5] PCI/ASPM: Remove unnecessary ASPM_STATE_L1SS check
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

