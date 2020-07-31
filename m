Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C773F234522
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jul 2020 14:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733051AbgGaMCb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 Jul 2020 08:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733045AbgGaMC2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 31 Jul 2020 08:02:28 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C15C06174A;
        Fri, 31 Jul 2020 05:02:28 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id q4so18972215edv.13;
        Fri, 31 Jul 2020 05:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iuQy8w3jTC6B7f+e5+v+su2hWV/K85XhH+2elaMKuus=;
        b=mX+NGt0GAao51iB7oaEfO5+Btfka8TE/iCN9cnpXnNXnPfsggcBwStFE9SJ7n5EFNY
         jdMFPXe/UGbl0eBCTUV/gPshZTOV/RtMC0+K0sWnHYgY8gJr334m9IIIelnNoSDq6RAm
         PPvOdXtA4osZ4abuOYMB1Irc9HnBU7cxU0kwk0eejbhv9hq6X3XyYT4inmGtiS53gIgR
         ZiZb/sRX3OSs5GpMMr80sJDOqSQ8YpXdt51eHE3GJ5JtzQOMS1cw+lx/A6r33aMSGKLo
         Q/lJ4lkI9ut0SlODtbMP5L4nvqXTGYkyAPQ/6BgtdlGRVhRdb2rl8Cp163guf8Cg6IdL
         Uw7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iuQy8w3jTC6B7f+e5+v+su2hWV/K85XhH+2elaMKuus=;
        b=rZLLBlUgaa8jQyxbwhIT2jYYDu0jxAa89iNxPebzv8Jxf3Uoopms+cvUayua2VLBrE
         2PoLM7FPx1u/Y+LuqkaCj7xL+kYeLulIN499lHw4z4jNDfNzh8mjVjZGTnYQ8MslPa3H
         HC0ksFxwobEkg5xBSugL9yFdqVIHpB2uDILoTSQRzb8NvLS9J6ANgfdna46r0rdGySXU
         Lqsz/sY6fI4MbGRUabW2ovzszzaqmadq2cL0AtPurmQ/eqPTjwkPp1iD3LQKSRer3smf
         VKZmZ6anf6+gnD7XjBFTeQI7wurd45O2JU/ghOEP8o2aGruZ2n0ckUOJ2oCy6KqqHejY
         1/bA==
X-Gm-Message-State: AOAM533QiQly+xk4eDI06s3OaZIqR6kz0NXaEGjVZqqDfAKLjw4V2o1n
        hESwG0mYYbpUrLtMZhK1tKDytSLBAICrMQ==
X-Google-Smtp-Source: ABdhPJzSf08P3jMuQU718EQhoumM6CT4AGAq2dZFlEfSRpdPJLSq+0WSaj54UAXLkHWN8FeZq8vKKg==
X-Received: by 2002:aa7:ce91:: with SMTP id y17mr3587091edv.105.1596196946844;
        Fri, 31 Jul 2020 05:02:26 -0700 (PDT)
Received: from net.saheed (95C84E0A.dsl.pool.telekom.hu. [149.200.78.10])
        by smtp.gmail.com with ESMTPSA id j5sm9091734ejk.87.2020.07.31.05.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 05:02:26 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH v4 07/12] PCI/ACPI: Check if pcie_capability_read_*() reads ~0
Date:   Fri, 31 Jul 2020 13:02:35 +0200
Message-Id: <20200731110240.98326-8-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200731110240.98326-1-refactormyself@gmail.com>
References: <20200731110240.98326-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On failure pcie_capability_read_*() sets it's last parameter, val
to 0. However, with Patch 12/12, it is possible that val is set
to ~0 on failure. This would introduces a bug because
(x & x) == (~0 & x).

Since ~0 is an invalid value in here,

Add extra check for ~0 in the if condition to ensure success or
failure.

Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
 drivers/pci/pci-acpi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 7224b1e5f2a8..873b005947e4 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -253,7 +253,7 @@ static bool pcie_root_rcb_set(struct pci_dev *dev)
 		return false;
 
 	pcie_capability_read_word(rp, PCI_EXP_LNKCTL, &lnkctl);
-	if (lnkctl & PCI_EXP_LNKCTL_RCB)
+	if ((lnkctl != (u16)~0) && (lnkctl & PCI_EXP_LNKCTL_RCB))
 		return true;
 
 	return false;
@@ -797,7 +797,7 @@ bool pciehp_is_native(struct pci_dev *bridge)
 		return false;
 
 	pcie_capability_read_dword(bridge, PCI_EXP_SLTCAP, &slot_cap);
-	if (!(slot_cap & PCI_EXP_SLTCAP_HPC))
+	if ((slot_cap == (u32)~0) || !(slot_cap & PCI_EXP_SLTCAP_HPC))
 		return false;
 
 	if (pcie_ports_native)
-- 
2.18.4

