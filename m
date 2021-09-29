Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A8341BBD7
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 02:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243523AbhI2ApO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Sep 2021 20:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243474AbhI2ApL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Sep 2021 20:45:11 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044E7C06161C;
        Tue, 28 Sep 2021 17:43:31 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id dj4so1954870edb.5;
        Tue, 28 Sep 2021 17:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QaYBospqkyo2zoksyaVVuoRPJ/AmIkrCvWCzRt0IhxI=;
        b=NrgCUBmtDbxItfr92PjOrh9SvkpI4uBP8JeDq8mUeUi5g4jmIdZEl9wB5N4ujUeF7Z
         ChWlryubPWETX2yW+LFnDNrvg9emu+yYGlGoiw1dSNV5upu3Kf6gtTB+mYGmDk+f1iLa
         QdqkSJkavjmbs1NkLlLZc2ucjbcft+YvlBOC7RSmbsT0JTTGq/82sZLBfx/1k5Y6W3PV
         uYrsgByv2XZ1FBzrjmXwZvNcUZzBLf83qDbtx8C+7DVh2FDh9Vwb8f1iOwUul6qVf+TW
         efrl1sr/G5Wfa9JqF5GF3QmfpO7VT7EX28XquM8cjneHwUaXI/KJboTo1l4X+Yw7y6wH
         iLlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QaYBospqkyo2zoksyaVVuoRPJ/AmIkrCvWCzRt0IhxI=;
        b=HK2CcczWuRimWl9ZUiKW9UvU6sLpa0V1RgLUF1fUEd9IltzzNwRKb7vniz6Vhs249V
         wT2QT+R+IY+754aWVcrWC5F3M2+d4zXZm6HIc3IUx2l5GXAQCalZYUKol1mhsOVbiPbY
         LTLvq/1Elu11T0bIy1/DuFPZUsfjrxEOFQSz0ARcEy2mwVFYGb5xF4m4BxcxTygJb3ev
         AFQ0/Eor0GNpk/ZE6JS/H9IPW2HHnjlIxmLYTcdCcXXj7nSOfg5pMFVLW9q4EaKVDs5D
         oMeUDDmeY6XsooH8c2mYgP4blbNHiwS0jGG8WIrhkfFl8Rg94G85QmebFZB6YayVdRAq
         eYOQ==
X-Gm-Message-State: AOAM530SGceaLF4c1EH4V0MRy8C9YsA8uhbBEBDivHQkvj4/gnRVLLbl
        f7yX3WdUr7uo++8RZbFwLB8=
X-Google-Smtp-Source: ABdhPJyfIjT01g+qOs6toDr9np44G3SJFNMui1dFBA9izMfN76KUhMtWsTIaZS7PfFxtOH/Y5b1X6w==
X-Received: by 2002:a17:906:1ec9:: with SMTP id m9mr10304099ejj.115.1632876209661;
        Tue, 28 Sep 2021 17:43:29 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:10f:c9f0:35c7:3af0:a197:61d0])
        by smtp.googlemail.com with ESMTPSA id u16sm358489ejy.14.2021.09.28.17.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 17:43:29 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Bolarinwa O. Saheed" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 3/4] PCI/ASPM: Remove struct pcie_link_state.downstream
Date:   Wed, 29 Sep 2021 02:43:14 +0200
Message-Id: <20210929004315.22558-4-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210929004315.22558-1-refactormyself@gmail.com>
References: <20210929004315.22558-1-refactormyself@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: "Bolarinwa O. Saheed" <refactormyself@gmail.com>

Information on the downstream component is cached in
struct pcie_link_state.downstream it obtained within
alloc_pcie_link_state() by calling pci_function_0()

This patch:
 - removes *downstream* from *struct pcie_link_state*.
 - replaces references to pcie_link_state.downstream with
   a call to pci_function_0(pdev->subordinate).

Signed-off-by: Bolarinwa O. Saheed <refactormyself@gmail.com>
---
 drivers/pci/pcie/aspm.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index ad78aaeea444..56d4fe7d50b5 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -48,7 +48,6 @@ struct aspm_latency {
 
 struct pcie_link_state {
 	struct pci_dev *pdev;		/* Upstream component of the Link */
-	struct pci_dev *downstream;	/* Downstream component, function 0 */
 	struct list_head sibling;	/* node in link_list */
 
 	/* ASPM state */
@@ -460,7 +459,8 @@ static void pci_clear_and_set_dword(struct pci_dev *pdev, int pos,
 static void aspm_calc_l1ss_info(struct pcie_link_state *link,
 				u32 parent_l1ss_cap, u32 child_l1ss_cap)
 {
-	struct pci_dev *child = link->downstream, *parent = link->pdev;
+	struct pci_dev *parent = link->pdev;
+	struct pci_dev *child = pci_function_0(link->pdev->subordinate);
 	u32 val1, val2, scale1, scale2;
 	u32 t_common_mode, t_power_on, l1_2_threshold, scale, value;
 	u32 ctl1 = 0, ctl2 = 0;
@@ -550,7 +550,8 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
 
 static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 {
-	struct pci_dev *child = link->downstream, *parent = link->pdev;
+	struct pci_dev *parent = link->pdev;
+	struct pci_dev *child = pci_function_0(link->pdev->subordinate);
 	u32 parent_lnkcap, child_lnkcap;
 	u16 parent_lnkctl, child_lnkctl;
 	u32 parent_l1ss_cap, child_l1ss_cap;
@@ -692,7 +693,8 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
 {
 	u32 val, enable_req;
-	struct pci_dev *child = link->downstream, *parent = link->pdev;
+	struct pci_dev *parent = link->pdev;
+	struct pci_dev *child = pci_function_0(link->pdev->subordinate);
 
 	enable_req = (link->aspm_enabled ^ state) & state;
 
@@ -751,7 +753,8 @@ static void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val)
 static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
 {
 	u32 upstream = 0, dwstream = 0;
-	struct pci_dev *child = link->downstream, *parent = link->pdev;
+	struct pci_dev *parent = link->pdev;
+	struct pci_dev *child = pci_function_0(link->pdev->subordinate);
 	struct pci_bus *linkbus = parent->subordinate;
 
 	/* Enable only the states that were not explicitly disabled */
@@ -879,7 +882,6 @@ static struct pcie_link_state *alloc_pcie_link_state(struct pci_dev *pdev)
 
 	INIT_LIST_HEAD(&link->sibling);
 	link->pdev = pdev;
-	link->downstream = pci_function_0(pdev->subordinate);
 
 	list_add(&link->sibling, &link_list);
 	pdev->link_state = link;
-- 
2.20.1

