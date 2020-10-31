Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7BC2A150C
	for <lists+linux-pci@lfdr.de>; Sat, 31 Oct 2020 11:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgJaKB3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 31 Oct 2020 06:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbgJaKB3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 31 Oct 2020 06:01:29 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B248C0613D5
        for <linux-pci@vger.kernel.org>; Sat, 31 Oct 2020 03:01:27 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id w23so4907291wmi.4
        for <linux-pci@vger.kernel.org>; Sat, 31 Oct 2020 03:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5seLUBqyHdRkC0HufEzzMgAPj8ItbVnZqwWCF7PQzyc=;
        b=kRfrXp1he86oJEVT6tn+1fvjzD905+bBcTk75uguij6gSvjatOI0vyAmxNRSioH6Mh
         9amONYJR4uIJS/rCgWRoHSw4tmx/LUu3DU0vxQXQkd6Hg1K60m5idKWBnNUnlurCgbc4
         i5NZEksqUrZcJFdo872Hbhw+EtrXCNPJ7hoGRE5/6pd3yMa7yzhFBiAEdqxNR2B/lI+T
         6YdSTxCMHlQvBpNJ2Uau+t9IUyy8/Zzf4SDLbqy8PwKEQs/3qgmxPbCHpRptLb7/5eEy
         VB9jkrAbX49T1De8n9pPG26E+G1JMd+Rbs4e/uCViZ31373TKMPGXoi2EXu+fGPZBjDt
         L5OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5seLUBqyHdRkC0HufEzzMgAPj8ItbVnZqwWCF7PQzyc=;
        b=iegXM0R8jEa7DlEgqxfW7iznKIVr0ALp2tiooX2Xy2zE4aREJS7AMTg8uv8vTiDxn6
         7x5GVGw360DkezWpWYNRAundCu8il8H3Vl18aOIepa34ygeBj2I3+OYwWpIjH/HLbiJ9
         FXLkYswcmqPzte+u1T3M4e09tx5eCOcIXQn2oYe7ZEz/NV/cKJY3Q0FBlYZzzldN8wHT
         JMI5G5SmcJKeFs+U3Betrm+GEmHTUjA7bp2/VhuuY8YLR0OGqS0yAxWQJSYc9dyjSEAW
         WOL9oqZMQL8uCGCNidxNIqmhGLQJS1LIl/joG9snpCTV9/Uyip5u9ZHfTzhzMbhJB5Sc
         Z1uQ==
X-Gm-Message-State: AOAM533RuvP1CynU6xSe99ATzle7H1SASqYZIYKIMzMz1pSyk8HRGQ2z
        CDWfnDvaacxO6TB4SkRvLAslxELgxFOdVw==
X-Google-Smtp-Source: ABdhPJxObkdTAVYTuuzQ3TfNuueq7KYjKAMwSAB6j3m+Ke9Ex7otcoJYe9m6Q75wMQ2MV4GnI9BMNA==
X-Received: by 2002:a1c:3503:: with SMTP id c3mr7231901wma.43.1604138486138;
        Sat, 31 Oct 2020 03:01:26 -0700 (PDT)
Received: from net.net ([80.121.151.125])
        by smtp.gmail.com with ESMTPSA id d142sm7585318wmd.11.2020.10.31.03.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 03:01:25 -0700 (PDT)
From:   Saheed Olayemi Bolarinwa <refactormyself@gmail.com>
To:     helgaas@kernel.org, linux-pci@vger.kernel.org
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>
Subject: [RFC PATCH] PCI/DPC: Fix info->id initialization in dpc_process_error()
Date:   Sat, 31 Oct 2020 11:01:21 +0100
Message-Id: <20201031100121.21391-1-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: "Saheed O. Bolarinwa" <refactormyself@gmail.com>

In the dpc_process_error() path, the error source ID is obtained
but not stored inside the aer_err_info object. So aer_print_error()
is not aware of the error source if it gets called.

Use the obtained valued to initialise info->id

Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
 drivers/pci/pcie/dpc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index e05aba86a317..9f8698812939 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -223,6 +223,7 @@ void dpc_process_error(struct pci_dev *pdev)
 	else if (reason == 0 &&
 		 dpc_get_aer_uncorrect_severity(pdev, &info) &&
 		 aer_get_device_error_info(pdev, &info)) {
+		info.id = source;
 		aer_print_error(pdev, &info);
 		pci_aer_clear_nonfatal_status(pdev);
 		pci_aer_clear_fatal_status(pdev);
-- 
2.18.4

