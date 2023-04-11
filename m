Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7756DD900
	for <lists+linux-pci@lfdr.de>; Tue, 11 Apr 2023 13:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjDKLLb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Apr 2023 07:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjDKLLa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Apr 2023 07:11:30 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E62449C
        for <linux-pci@vger.kernel.org>; Tue, 11 Apr 2023 04:11:10 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id u188-20020a2560c5000000b00b8f15f2111dso3000056ybb.4
        for <linux-pci@vger.kernel.org>; Tue, 11 Apr 2023 04:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681211469;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HECeuQBdvQRhBEsgYTKbTTwg6tOb1uM7yGa+73zqdqA=;
        b=as+qG2uonqno7lffKPDNQyHtYtg/2dwfu/zv1Ez6nZmk8roWgVc1bDSZ+j+BZ8g4w5
         gs2VESpdOUmSkn/EiA9Rpd/8gutmzZEaKH6jyiMaa+bIC3E3ZQQXm641eYsvR3Js8FGt
         rMIGD9GI72IQRbiw1PlfHLNlJUhkYTCTAEtxuvV1CeUAbvAJ9y2coi4B+C0fH4rPdj3i
         DiKvtYGwHK2x41wKjPAP5Bo3yNiYEv12zl+Nm6jooCjyjYU2nC0lBEQXX9W24NsNKBVU
         cqKgrQ2a3rpAt2gGr+PjYtvB8hd0+AUsDK30I7CWvqQsqekroVyWLywskph1s81BQ7Ss
         FOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681211469;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HECeuQBdvQRhBEsgYTKbTTwg6tOb1uM7yGa+73zqdqA=;
        b=CpTpadVQqVj5sCrBk2vaCRqDSMUqhpUlu0b2xvSk6xKkrGa1o7GWc1eyQTTgaY0Xg3
         shW0BAEDKPkPLZ3t6pNdEzwRwXAXIEt1G8Tu6VIKpJFivtp7dzosvKyMgcXHNch/PiVR
         asNUjqE8qPRFmwSKegp3zBpYPw76yBuY8MaExmzCHGgp4DXMIBq4SmA/u2FXjKeJNZvm
         ElMvyH9xFA8ZrnCgqjMz48HKan5yERBa2PDogvMrpYrtf+t4BA/4pqqQUFvvkguy11HF
         B3isfxHaarpSR7FslnsO19oee70FBOO/3l1pBsCSlJP17CxAgEKCnPL5t4GY35ID+TBe
         mqkQ==
X-Gm-Message-State: AAQBX9dGv2vyu6DxyKHAt/CQ13w1oMqh3zCTjS9IpDw5YmOuPSyTXmWJ
        bKe0N+QOZi+YuDprPIiqADltn2jEKyD+35b2xw==
X-Google-Smtp-Source: AKy350bVnE7DUZpxorgG/hP+8ar1xmlSZ5U9JyoxRqJajloUYU8gBPAPZNCToe2rpOmgdKF1LZQV0G9z8t5caTROag==
X-Received: from ajaya.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:39b5])
 (user=ajayagarwal job=sendgmr) by 2002:a81:e20a:0:b0:54d:4a49:ba22 with SMTP
 id p10-20020a81e20a000000b0054d4a49ba22mr7301387ywl.7.1681211469259; Tue, 11
 Apr 2023 04:11:09 -0700 (PDT)
Date:   Tue, 11 Apr 2023 16:40:34 +0530
In-Reply-To: <20230411111034.1473044-1-ajayagarwal@google.com>
Mime-Version: 1.0
References: <20230411111034.1473044-1-ajayagarwal@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230411111034.1473044-4-ajayagarwal@google.com>
Subject: [PATCH 3/3] PCI/ASPM: Remove unnecessary ASPM_STATE_L1SS check
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
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently the driver checks if ASPM_STATE_L1SS is supported
before calling aspm_calc_l1ss_info(), only for this function to
return if ASPM_STATE_L1_2_MASK is not supported. Simplify the
logic by directly checking for L1.2 mask.

Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
---
 drivers/pci/pcie/aspm.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 7c9935f331f1..8c45835e8016 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -481,9 +481,6 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
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
 		aspm_calc_l1ss_info(link, parent_l1ss_cap, child_l1ss_cap);
 }
 
-- 
2.40.0.577.gac1e443424-goog

