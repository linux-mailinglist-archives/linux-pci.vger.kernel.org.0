Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8402F9BA5
	for <lists+linux-pci@lfdr.de>; Mon, 18 Jan 2021 10:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388067AbhARJAV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Jan 2021 04:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388118AbhARJAP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Jan 2021 04:00:15 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3635C0613CF
        for <linux-pci@vger.kernel.org>; Mon, 18 Jan 2021 00:59:34 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id w14so777828pfi.2
        for <linux-pci@vger.kernel.org>; Mon, 18 Jan 2021 00:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JIq7RDv9ZduOIf2xDTZK09tmM6htJCuoCrhfyUxsHGw=;
        b=NISd+UTasi5Sks0nho6Uzscj9Iy0GPN3fEysCVXs1071D6aohYv4/qA6mlB0bepEI8
         BFo58YJCpmiaoy2SC+ptr2EW52Z8o52k4Zf1UrXBF2V1WhHd118Qkrhn0KXvGHtO2Y+5
         hm9pDzNlooguBzC8hWZiZPqFrDrxmh4Qf+ygL4EhHiuqWps5rtydfWsE2R3e+Q4EXj1Q
         5Jqj6XX2zXtkyuL9S2Yjhet/q1LfDy4eRAXvfLyCF/zk6uVJdFKPQRRvf95Lki8EdAPT
         urA77p8muWnM4/kFmHGIWCeV7ybQcqtpfgE6vX0yzaMdsWNJgJ4Srs8ZyGZTQ7G3QuqQ
         oDHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JIq7RDv9ZduOIf2xDTZK09tmM6htJCuoCrhfyUxsHGw=;
        b=TOb2EiSzrQeCeUCiD5Afhw9wT7OeL0R6T6SzNUBAmnidiHF8plEEH8vs4Ih5xfVCto
         5rYklZ0t9V5Gu6s9cQeKkpiYVFeGX4Vxss4vqpGc9q7JI4xwbqUw5dyXzZghiMjE9L/g
         xQ8YP37HKTKopaSJcV9YhGUVmXGRAIQLIiVyTKYGPDgsrS3jubZXkkvx223WYh+bHyam
         5ODpRjHqpP9vMx8A/4yg3nH9wd3cLlanphwzdHBQuiWYOnSAsIP8ryhy6XT4x9X7IaC0
         wjHdhK9ftatkU721l5ekPsDk6ADIIxLknGXk4dR49PFP0s6LZjOk2oQbzmn71GjzkRB4
         feXw==
X-Gm-Message-State: AOAM532s0fw1DoVyb52S6dwfcjaSNBgK9V4otwys8tTEKL3zV0O6sV5q
        14gMGqz3SeSTemdQlSwWmWbvsg==
X-Google-Smtp-Source: ABdhPJwop+OvT/bRS6+durGsDdke/jqoVJEIHFu2bEiAb8wLtOLRkNPT1d7Eug7cfXclAG2AUOtuEQ==
X-Received: by 2002:a62:aa06:0:b029:19d:f4d3:335e with SMTP id e6-20020a62aa060000b029019df4d3335emr25377411pff.60.1610960374472;
        Mon, 18 Jan 2021 00:59:34 -0800 (PST)
Received: from localhost.localdomain ([240e:362:42c:4800:8459:4fa0:20cc:1141])
        by smtp.gmail.com with ESMTPSA id c23sm16087162pgc.72.2021.01.18.00.59.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2021 00:59:33 -0800 (PST)
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        jean-philippe <jean-philippe@linaro.org>,
        kenneth-lee-2012@foxmail.com, wangzhou1@hisilicon.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v2 1/3] PCI: PASID can be enabled without TLP prefix
Date:   Mon, 18 Jan 2021 16:58:34 +0800
Message-Id: <1610960316-28935-2-git-send-email-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1610960316-28935-1-git-send-email-zhangfei.gao@linaro.org>
References: <1610960316-28935-1-git-send-email-zhangfei.gao@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

A PASID-like feature is implemented on AMBA without using TLP prefixes
and these devices have PASID capability though not supporting TLP.
Adding a pasid_no_tlp bit for "PASID works without TLP prefixes" and
pci_enable_pasid() checks pasid_no_tlp as well as eetlp_prefix_path.

Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/pci/ats.c   | 2 +-
 include/linux/pci.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index e36d601..b67b1b1 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -386,7 +386,7 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
 	if (WARN_ON(pdev->pasid_enabled))
 		return -EBUSY;
 
-	if (!pdev->eetlp_prefix_path)
+	if (!pdev->eetlp_prefix_path && !pdev->pasid_no_tlp)
 		return -EINVAL;
 
 	if (!pasid)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index f1f26f8..ac1c735 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -388,6 +388,7 @@ struct pci_dev {
 					   supported from root to here */
 	u16		l1ss;		/* L1SS Capability pointer */
 #endif
+	unsigned int	pasid_no_tlp:1;		/* PASID works without TLP Prefix */
 	unsigned int	eetlp_prefix_path:1;	/* End-to-End TLP Prefix */
 
 	pci_channel_state_t error_state;	/* Current connectivity state */
-- 
2.7.4

