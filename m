Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55E873A3A86
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jun 2021 05:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbhFKDxg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Jun 2021 23:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhFKDxf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Jun 2021 23:53:35 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6305CC061574
        for <linux-pci@vger.kernel.org>; Thu, 10 Jun 2021 20:51:24 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id n12so1357734pgs.13
        for <linux-pci@vger.kernel.org>; Thu, 10 Jun 2021 20:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=wkd+psqbxttkDtNMuavQIcbFyZNe+XjsMd8VM7sojkI=;
        b=JE3Ka7tzFc86cVsvB8jDnClacgUNXr8fr7M5bfL86aoyBQTPxUZSC4+jzCWP/GjsYG
         Y/05AKjPYV/OGQxQCbP9TJLaKvQE5g3Di6k9LkUVA3nxmGnyCIOXzCKw7GEI/nqvxs0o
         8VdeX7skBNzJcjawD84AhVUFW3Raoy2hhkXzi8+9mCCXb9VxHueEEyobN4ShgqjOaF7c
         MwbFzvOCsTmjs7dv3ieBDdoBvJDVW/kB8R07aNgCzcOtxaa+9n9iHp8qI0MFIs4gnv5/
         boJQmapv6vXP+XO+Lrc5h8UpfViRqnhexKwWM/0MqR0/OqBFvI0KraVHMcmgtrWeA3a3
         0CDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wkd+psqbxttkDtNMuavQIcbFyZNe+XjsMd8VM7sojkI=;
        b=ZVSokrcYULfkBKpACUjNSxnLMFfnL6mdaelsOzwqCphSvz/x1q1zJ5A4mjP544XReE
         jRhpJ8bqBrGp60bqdM+JOzKpirCafmuzAPlXOnXJLfDvKqWnlVJRtCPGVj/aa24+DQjR
         vEsxvPLt6qvcwdK5B84vGFmQ1LMVI27hr94qqA1e1MXTETm7f3pZIQD/Q7JI/KpmPHhX
         3ggQnDjUTimma565leBgfF21zug6/1Xu745f11FqHw4iX/1ibrREa6wAwuEI/7vQi5Nh
         PmDhQDHWPKMia+OhgxpT0LsOVzHfzREgkN7ik8jaCK3JTG+i8lD/PtmDjytZqlb8Utxj
         K0aQ==
X-Gm-Message-State: AOAM533zwZxxF/59ta+KapOo6wgiPlvLoZVV3UDcvENmF3RQIOCpl76X
        LiLMV+LXD/o7NBiCgTocnN78hw==
X-Google-Smtp-Source: ABdhPJxaRJdzooBXF+rIKkLISjncPrqsB+/j/AV6w+YPi8Nos9bRbP6hkuiTkZI1pGFg/vOxEfQ0uQ==
X-Received: by 2002:a63:1453:: with SMTP id 19mr1589790pgu.270.1623383483960;
        Thu, 10 Jun 2021 20:51:23 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id n37sm3565593pfv.47.2021.06.10.20.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 20:51:23 -0700 (PDT)
From:   Shunsuke Mie <mie@igel.co.jp>
Cc:     mie@igel.co.jp, Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: endpoint: Fix use after free in pci_epf_remove_cfs()
Date:   Fri, 11 Jun 2021 12:50:44 +0900
Message-Id: <20210611035044.87639-1-mie@igel.co.jp>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

All of entries are freed in a loop, however, the freed entry is accessed
by list_del() after the loop.

Fixes: ef1433f ("PCI: endpoint: Create configfs entry for each pci_epf_device_id table entry")
Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
 drivers/pci/endpoint/pci-epf-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index e9289d10f822..538e902b0ba6 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -202,8 +202,10 @@ static void pci_epf_remove_cfs(struct pci_epf_driver *driver)
 		return;
 
 	mutex_lock(&pci_epf_mutex);
-	list_for_each_entry_safe(group, tmp, &driver->epf_group, group_entry)
+	list_for_each_entry_safe(group, tmp, &driver->epf_group, group_entry) {
+		list_del(&group->group_entry);
 		pci_ep_cfs_remove_epf_group(group);
+	}
 	list_del(&driver->epf_group);
 	mutex_unlock(&pci_epf_mutex);
 }
-- 
2.17.1

