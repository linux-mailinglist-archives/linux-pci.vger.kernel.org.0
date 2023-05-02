Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58B96F4A64
	for <lists+linux-pci@lfdr.de>; Tue,  2 May 2023 21:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjEBTcH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 May 2023 15:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjEBTcG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 May 2023 15:32:06 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903901FE2
        for <linux-pci@vger.kernel.org>; Tue,  2 May 2023 12:32:05 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b8f324b3ef8so5236826276.0
        for <linux-pci@vger.kernel.org>; Tue, 02 May 2023 12:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683055925; x=1685647925;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OjGj+uU9+T3V55g9RkXA5Hr9eIueNSu8jnz5r8uDglg=;
        b=7pAcOuNoQQuwyjpcVBq9yaubxHt3Wg72udTISOJdOFGzqUAOCkS/npOH2gNCWk1k2/
         YwRUA/BARDv4wWb5NvbKhsm6WcGUOULqQ3dAjYCVoRxc5lmkXwl7m1aby9sd4VNwdgnA
         sYFVf56PCjr6xne5xuqu3rh2C1r2fJZpHPYLWC8E6N1/S/zLjO5yZ72nXaAJNqtQI4fb
         spY8RWldLz307sreaUG5a4rVFT5nTlYBrlB+2pkwTc+KcSjlCZKLFn35/9OIrhMjuIE0
         2EE06wqxPMtLELV5lNR8MDSdxEPmhg5cuofVaviarHtHg1Yf61AUAwL96vZQsavWUGVc
         r2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683055925; x=1685647925;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OjGj+uU9+T3V55g9RkXA5Hr9eIueNSu8jnz5r8uDglg=;
        b=jo80m6fH9YNW0Tb7mAxpgokRmaMS9AogchKm689L4EXcAvvRr7OA/OUbtBS/yz5A3i
         rmFPfNsQNEAjQR4Sn73IxOSLi2TTKdfTWPzOoidkcjr+YrjrUkffIcVuIr4gFy9cqy4D
         pDOSWzHzUrd97wnWUyXRZuU6okoab1vhkwhKKeO4O0/ZzcKhg/6f38QaltWUs0TM7ada
         iOve7dmOohk+mpB69Z8vo4UayfGqRi28ycMH9Po7TUNhZvLDeDaa3nF/riTRmFxyDfrm
         z/rmedytwAYmm7Lfeq91hlw/fWpmYymJ6yiO9wQWC43YuoISlcZHa50RB8vkvnq/aWh8
         sBXQ==
X-Gm-Message-State: AC+VfDzwmWD2GY0/PHY830Hvvd+60N6rGccbf31IqnLiZsLa1YhnOu9v
        1PoGj8QpEn5jfaDe6mMYgTKS7gJjxCTj1TA3bQ==
X-Google-Smtp-Source: ACHHUZ4B7tuEWArY6pfOKLezRsrD1nh24mWdeq9N1fxuZiw922qKscZ150nnqycJpyo6lWEBh3EsqS9VE4PybReDBg==
X-Received: from ajaya.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:39b5])
 (user=ajayagarwal job=sendgmr) by 2002:a25:ac4c:0:b0:b9e:635c:7970 with SMTP
 id r12-20020a25ac4c000000b00b9e635c7970mr2354030ybd.3.1683055924888; Tue, 02
 May 2023 12:32:04 -0700 (PDT)
Date:   Wed,  3 May 2023 01:01:38 +0530
In-Reply-To: <20230502193140.1062470-1-ajayagarwal@google.com>
Mime-Version: 1.0
References: <20230502193140.1062470-1-ajayagarwal@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230502193140.1062470-4-ajayagarwal@google.com>
Subject: [PATCH v2 3/5] PCI/ASPM: Set ASPM_STATE_L1 when driver enables L1ss
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

Currently the aspm driver does not set ASPM_STATE_L1 bit in
aspm_default when the caller requests L1SS ASPM state. This will
lead to pcie_config_aspm_link() not enabling the requested L1SS
state. Set ASPM_STATE_L1 when driver enables L1ss.

Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
---
Changelog since v1:
 - Break down the L1 and L1ss handling into separate patches

 drivers/pci/pcie/aspm.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 4ad0bf5d5838..7c9935f331f1 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1171,14 +1171,15 @@ int pci_enable_link_state(struct pci_dev *pdev, int state)
 		link->aspm_default |= ASPM_STATE_L0S;
 	if (state & PCIE_LINK_STATE_L1)
 		link->aspm_default |= ASPM_STATE_L1;
+	/* L1 PM substates require L1 */
 	if (state & PCIE_LINK_STATE_L1_1)
-		link->aspm_default |= ASPM_STATE_L1_1;
+		link->aspm_default |= ASPM_STATE_L1_1 | ASPM_STATE_L1;
 	if (state & PCIE_LINK_STATE_L1_2)
-		link->aspm_default |= ASPM_STATE_L1_2;
+		link->aspm_default |= ASPM_STATE_L1_2 | ASPM_STATE_L1;
 	if (state & PCIE_LINK_STATE_L1_1_PCIPM)
-		link->aspm_default |= ASPM_STATE_L1_1_PCIPM;
+		link->aspm_default |= ASPM_STATE_L1_1_PCIPM | ASPM_STATE_L1;
 	if (state & PCIE_LINK_STATE_L1_2_PCIPM)
-		link->aspm_default |= ASPM_STATE_L1_2_PCIPM;
+		link->aspm_default |= ASPM_STATE_L1_2_PCIPM | ASPM_STATE_L1;
 	pcie_config_aspm_link(link, policy_to_aspm_state(link));
 
 	link->clkpm_default = (state & PCIE_LINK_STATE_CLKPM) ? 1 : 0;
-- 
2.40.1.495.gc816e09b53d-goog

