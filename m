Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA02E446F98
	for <lists+linux-pci@lfdr.de>; Sat,  6 Nov 2021 18:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbhKFR5y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 Nov 2021 13:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234172AbhKFR5x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 Nov 2021 13:57:53 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F591C061746;
        Sat,  6 Nov 2021 10:55:11 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id m14so44030250edd.0;
        Sat, 06 Nov 2021 10:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=poWzBna8Q7V3exJi/2cqueSy7kuer5ibESKko9F1UGU=;
        b=TxcsTb0hrfxRWgz1/VF8bnHUjl2ULNpjx13h9QUrjMXNn81LcG3YbiFX+TfneOSCOM
         oFCHAIlTV97d/R0dCwbvdO6kMJKXE64xfHI4b3Nq/2pHIFJovWyRYNSwOcrkymqXcGjm
         KcyE3t9VXSdINE+clSjyQFRsGmb/iUZWL+X/j+Ra+Bsu6eClfxRlhQKLfY+2l7mCFh5Y
         dBde0BTHCjUjy14AYBv1RajiRDzTN5oyJdf9feBNraFEdcVw7h9j4HeXuSdg2xhKOhtv
         BiHJdBmrVsFmYzKeadN5ZTfWVJtt9iuRpSyuBlEUrBmsq/K1vakKmX5s4XBBe4LtahZx
         EaUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=poWzBna8Q7V3exJi/2cqueSy7kuer5ibESKko9F1UGU=;
        b=Bo1+ublbofOG9lf4nSxSWBnGc6rIfrsPjs/hQNajVnOInNP38KzhPaQ5FXFdsTVoPm
         YteisiByRSQLPoSROhr7XzMIXX4FxSGsMvV5nON/Oa7vAwWpMYxRy57JPDFiXEUadk8T
         dbtbf3S/OTmatC89XVIQRrvsfCVDFakj3ooNSENHHNaU91px4iQklgN9pjSDxlW0E0gv
         JQH4FhL7FsxfbP/2h/kX8O70aOF0s7a4esTLNJm1OB1xwkHYbdJpx+nH/p7r6T7JWlRk
         7aYL2vH1bTqT75CRPZr6p0+oZgE+JM+aNrVoM+CenYDAsylbN9onG66X/j1YWPjnfPl8
         3vuA==
X-Gm-Message-State: AOAM533WOnLnoF5Q2iytg+SNN0GOc/VuDYyP9iA8C3EnWMe2vJidubR1
        vDIGBJbxsiRh28QIIYC7LQdb5gTpmA4=
X-Google-Smtp-Source: ABdhPJxcmnz3lN4m3IBTPNedKEAsozptNqGCJkwjgKauE2s6D2VOeiGH8Jr5Jc3s3ZenL9NFxk0brg==
X-Received: by 2002:a17:907:c1d:: with SMTP id ga29mr42619925ejc.180.1636221310148;
        Sat, 06 Nov 2021 10:55:10 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:109:9f0:f6a6:7fbe:807a:e1cc])
        by smtp.googlemail.com with ESMTPSA id 25sm6542848edw.19.2021.11.06.10.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 10:55:09 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Bolarinwa O. Saheed" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 4/5] PCI/ASPM: Remove struct pcie_link_state.downstream
Date:   Sat,  6 Nov 2021 18:55:02 +0100
Message-Id: <20211106175503.27178-5-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211106175503.27178-1-refactormyself@gmail.com>
References: <20211106175503.27178-1-refactormyself@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: "Bolarinwa O. Saheed" <refactormyself@gmail.com>

Information on the downstream component is cached in
struct pcie_link_state.downstream it obtained within
alloc_pcie_link_state() by calling pci_function_0()

 - remove *downstream* from the struct pcie_link_state.
 - replaces references to pcie_link_state.downstream with
   a call to pci_function_0(pdev->subordinate).

Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
 drivers/pci/pcie/aspm.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 90c7a0b379f4..12623556f750 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -48,7 +48,6 @@ struct aspm_latency {
 
 struct pcie_link_state {
 	struct pci_dev *pdev;		/* Upstream component of the Link */
-	struct pci_dev *downstream;	/* Downstream component, function 0 */
 	struct list_head sibling;	/* node in link_list */
 
 	/* ASPM state */
@@ -462,7 +461,8 @@ static void pci_clear_and_set_dword(struct pci_dev *pdev, int pos,
 static void aspm_calc_l1ss_info(struct pcie_link_state *link,
 				u32 parent_l1ss_cap, u32 child_l1ss_cap)
 {
-	struct pci_dev *child = link->downstream, *parent = link->pdev;
+	struct pci_dev *parent = link->pdev;
+	struct pci_dev *child = pci_function_0(link->pdev->subordinate);
 	u32 val1, val2, scale1, scale2;
 	u32 t_common_mode, t_power_on, l1_2_threshold, scale, value;
 	u32 ctl1 = 0, ctl2 = 0;
@@ -552,7 +552,8 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
 
 static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 {
-	struct pci_dev *child = link->downstream, *parent = link->pdev;
+	struct pci_dev *parent = link->pdev;
+	struct pci_dev *child = pci_function_0(link->pdev->subordinate);
 	u32 parent_lnkcap, child_lnkcap;
 	u16 parent_lnkctl, child_lnkctl;
 	u32 parent_l1ss_cap, child_l1ss_cap;
@@ -694,7 +695,8 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
 {
 	u32 val, enable_req;
-	struct pci_dev *child = link->downstream, *parent = link->pdev;
+	struct pci_dev *parent = link->pdev;
+	struct pci_dev *child = pci_function_0(link->pdev->subordinate);
 
 	enable_req = (link->aspm_enabled ^ state) & state;
 
@@ -753,7 +755,8 @@ static void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val)
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

