Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3DC6F4A62
	for <lists+linux-pci@lfdr.de>; Tue,  2 May 2023 21:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjEBTb6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 May 2023 15:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjEBTb5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 May 2023 15:31:57 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0B01BF9
        for <linux-pci@vger.kernel.org>; Tue,  2 May 2023 12:31:55 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a7df507c5so8353915276.1
        for <linux-pci@vger.kernel.org>; Tue, 02 May 2023 12:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683055914; x=1685647914;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AKbTyP7qWyNeHiZExqE9j9/ScUY0ln0RZUFZMZiF+PY=;
        b=o4uWpfv0yeRuyDGZ1DHRwaNSFiULXiE03zJYyjiB5bHRoQ774FYtwnmbnB/hGVCuZW
         EuXMJqBck5CyIlgbaBmNT8UOGsLaRWIx5lMtc1IgVXCBRtgJskTQQzs9oFiYzeeNX8Uz
         bV4zMiFJlDGGoa0iBfAXLfbzpgmDRys1T5IOsPUf464/0LQnAUR/jdT7GJsctIvSVmsx
         rOnXf4ml+4arcTKzU7ejd9P1NEy1YhX5p5mSrDOw10K1rJ2hKMnvRZe7fT0xr0urKN/h
         Dm1NhF+u6hnMggrLAtOPxwrqXhZxAeU9gSeo4oGSC3e3YOiRCBFTPdPXablDYsG8ZyH/
         jpDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683055914; x=1685647914;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AKbTyP7qWyNeHiZExqE9j9/ScUY0ln0RZUFZMZiF+PY=;
        b=ZtvQMdniVFDUAtv6mbTkc8bdfV9B7BuVqSKlUeOSCOeRkwrnxzjQSN2+hwQXQiDL8o
         8R9/9X2VZ2HtvUZHrgcFgOrkc6SZxFH2fj3Y6ZKWxJF734oK7Nzpw3FSz90xJGo2XWBJ
         WTkuuh3Kp/lgYJ8cAY+zkiksStEvmHi9GXYeVcjIQbzHAtOTXav7t3cTGxEFDxbDl2EE
         1tJzW7pJneRX7uW0xPf/2f/tqg9ghWAYsDx4aRS1QzoEAOpdO9toRIyc9zIrUwBruRbH
         JQejTzGPo5pTZn5C7aNFRNMsVt2QeTVuJlOy49s+R6PG/FSo+EzEX2LsZYVMuK2vjIMY
         bsRQ==
X-Gm-Message-State: AC+VfDyHrIYMF6G053uuidi6aeNfDmqJC8xDvczu/mH8eVqQZARdzjRX
        XpG1sl/J64B6cLaAZTAKSQHF74b5lFH3hLcAQQ==
X-Google-Smtp-Source: ACHHUZ5J+mOsKqtZWN9zYOomJBijx6MzBtVYkgLBQZpUoIrZRwsKTtwMr0oGUNtQWxz/11NDdp/1nlwO7ybDqtIC8w==
X-Received: from ajaya.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:39b5])
 (user=ajayagarwal job=sendgmr) by 2002:a25:ad9b:0:b0:b78:8bd8:6e77 with SMTP
 id z27-20020a25ad9b000000b00b788bd86e77mr10843815ybi.8.1683055914629; Tue, 02
 May 2023 12:31:54 -0700 (PDT)
Date:   Wed,  3 May 2023 01:01:36 +0530
In-Reply-To: <20230502193140.1062470-1-ajayagarwal@google.com>
Mime-Version: 1.0
References: <20230502193140.1062470-1-ajayagarwal@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230502193140.1062470-2-ajayagarwal@google.com>
Subject: [PATCH v2 1/5] PCI/ASPM: Disable ASPM_STATE_L1 only when class driver
 disables L1 ASPM
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

Currently the aspm driver sets ASPM_STATE_L1 as well as
ASPM_STATE_L1SS bits in aspm_disable when the caller disables L1.
pcie_config_aspm_link takes care that L1ss ASPM is not enabled
if L1 is disabled. ASPM_STATE_L1SS bits do not need to be
explicitly set. The sysfs node store() function, which also
modifies the aspm_disable value, does not set these bits either
when only L1 ASPM is disabled by the user.

Disable ASPM_STATE_L1 only when the caller disables L1 ASPM.

Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
---
Changelog since v1:
 - Better commit message

 drivers/pci/pcie/aspm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 66d7514ca111..5765b226102a 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1095,8 +1095,7 @@ static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
 	if (state & PCIE_LINK_STATE_L0S)
 		link->aspm_disable |= ASPM_STATE_L0S;
 	if (state & PCIE_LINK_STATE_L1)
-		/* L1 PM substates require L1 */
-		link->aspm_disable |= ASPM_STATE_L1 | ASPM_STATE_L1SS;
+		link->aspm_disable |= ASPM_STATE_L1;
 	if (state & PCIE_LINK_STATE_L1_1)
 		link->aspm_disable |= ASPM_STATE_L1_1;
 	if (state & PCIE_LINK_STATE_L1_2)
-- 
2.40.1.495.gc816e09b53d-goog

