Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C64D340D520
	for <lists+linux-pci@lfdr.de>; Thu, 16 Sep 2021 10:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235374AbhIPIxf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Sep 2021 04:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235334AbhIPIxe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Sep 2021 04:53:34 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B85C061574;
        Thu, 16 Sep 2021 01:52:13 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id t6so13945937edi.9;
        Thu, 16 Sep 2021 01:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=09cvxho43RAWdblupxJRryaRtzV/elqF+nv7ifw9kQ8=;
        b=CvN7rj/255EtHNvJmNTL5+s29obenwbnR6jVfAG7usXquvZcNVqdItUsW7lzShm9wy
         oYk56u81zKoS3Ss8usoY9SGx8R/xI3C8OXFIvvxl2UKdFrBsAcT4FT3MYhpchJfqXsL6
         Ysw/SEC7pMMafjA+yp+iixxujQHEOKs1fHnVPavirRUfjzbShG85cM/nb7FYLyy3P/14
         ruv98vAqUL3zTFqIh6gZN87lF8ZQ0uOljIPKCdXGOrf+WHTkx8nznSGIY+2OkUAfSYBS
         6j7iWjO1/kHdHztIG75t68poO9lBYULv9FkFhTeW9Ay2Sbu/CCvjjgB4Y9iv4P+RlBDb
         aMNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=09cvxho43RAWdblupxJRryaRtzV/elqF+nv7ifw9kQ8=;
        b=7Nd6aQttrqgFYe90MUNzZDH8ZTFzS1aIJk+jIVPGHSE8DC0KELJX9/FA9Cgu52T7fV
         XBJZSAlTp7hsGBHaRumwaUm8MLiGV6yhntS7B4WRVo3B+1UpfXKk7tk6k5tn9xtAe0qH
         U3awurvNv78fqUzFAWudZ9RqE29R3bVTIU4mytJNXnsP7bpjYKXes9Db7P0VCacALkNo
         EZzPv8ZDJKs8Rssb3Cxr/0l4dhszoLQHAtnN9qkw4K+7K6KWHBih6v8JEUch7YxqRJCj
         uZGmK687wjI61gExgMSbHTNRije2qs7AKfGoMJWwxQDOL8sY1gJBmFf83i/QhDaPzXUn
         wKeg==
X-Gm-Message-State: AOAM530rAQFF0YGGBlOLTkxBFDJl7f/pWUGKewYZWNZi7wZib3MKK3xz
        gO3hnG7dulbwpuBvXd/oPlMgYjooCfAHjw==
X-Google-Smtp-Source: ABdhPJxF0TXr0A/pXX0ZXBozjDCGrvgkDMWhk/s5M0fGeRDj18rkNg9UC7znguF+MgWv5csOeEVIBQ==
X-Received: by 2002:a17:906:d1d1:: with SMTP id bs17mr4932081ejb.198.1631782332570;
        Thu, 16 Sep 2021 01:52:12 -0700 (PDT)
Received: from localhost.localdomain (catv-176-63-0-115.catv.broadband.hu. [176.63.0.115])
        by smtp.googlemail.com with ESMTPSA id t24sm1112961edr.84.2021.09.16.01.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 01:52:12 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Bolarinwa O. Saheed" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com
Subject: [RFC PATCH 3/4] PCI/ASPM: Remove struct pcie_link_state.downstream
Date:   Thu, 16 Sep 2021 10:52:05 +0200
Message-Id: <20210916085206.2268-4-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210916085206.2268-1-refactormyself@gmail.com>
References: <20210916085206.2268-1-refactormyself@gmail.com>
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
index 8772a4ea4365..516a6f07ac6e 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -48,7 +48,6 @@ struct aspm_latency {
 
 struct pcie_link_state {
 	struct pci_dev *pdev;		/* Upstream component of the Link */
-	struct pci_dev *downstream;	/* Downstream component, function 0 */
 	struct list_head sibling;	/* node in link_list */
 
 	/* ASPM state */
@@ -452,7 +451,8 @@ static void pci_clear_and_set_dword(struct pci_dev *pdev, int pos,
 static void aspm_calc_l1ss_info(struct pcie_link_state *link,
 				u32 parent_l1ss_cap, u32 child_l1ss_cap)
 {
-	struct pci_dev *child = link->downstream, *parent = link->pdev;
+	struct pci_dev *parent = link->pdev;
+	struct pci_dev *child = pci_function_0(link->pdev->subordinate);
 	u32 val1, val2, scale1, scale2;
 	u32 t_common_mode, t_power_on, l1_2_threshold, scale, value;
 	u32 ctl1 = 0, ctl2 = 0;
@@ -542,7 +542,8 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
 
 static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 {
-	struct pci_dev *child = link->downstream, *parent = link->pdev;
+	struct pci_dev *parent = link->pdev;
+	struct pci_dev *child = pci_function_0(link->pdev->subordinate);
 	u32 parent_lnkcap, child_lnkcap;
 	u16 parent_lnkctl, child_lnkctl;
 	u32 parent_l1ss_cap, child_l1ss_cap;
@@ -684,7 +685,8 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
 {
 	u32 val, enable_req;
-	struct pci_dev *child = link->downstream, *parent = link->pdev;
+	struct pci_dev *parent = link->pdev;
+	struct pci_dev *child = pci_function_0(link->pdev->subordinate);
 
 	enable_req = (link->aspm_enabled ^ state) & state;
 
@@ -743,7 +745,8 @@ static void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val)
 static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
 {
 	u32 upstream = 0, dwstream = 0;
-	struct pci_dev *child = link->downstream, *parent = link->pdev;
+	struct pci_dev *parent = link->pdev;
+	struct pci_dev *child = pci_function_0(link->pdev->subordinate);
 	struct pci_bus *linkbus = parent->subordinate;
 
 	/* Enable only the states that were not explicitly disabled */
@@ -871,7 +874,6 @@ static struct pcie_link_state *alloc_pcie_link_state(struct pci_dev *pdev)
 
 	INIT_LIST_HEAD(&link->sibling);
 	link->pdev = pdev;
-	link->downstream = pci_function_0(pdev->subordinate);
 
 	list_add(&link->sibling, &link_list);
 	pdev->link_state = link;
-- 
2.20.1

