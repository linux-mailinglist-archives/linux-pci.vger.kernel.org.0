Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 881B93C68AE
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jul 2021 04:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbhGMC5x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Jul 2021 22:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233911AbhGMC5w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Jul 2021 22:57:52 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD363C0613E9
        for <linux-pci@vger.kernel.org>; Mon, 12 Jul 2021 19:55:02 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id v18-20020a17090ac912b0290173b9578f1cso1064257pjt.0
        for <linux-pci@vger.kernel.org>; Mon, 12 Jul 2021 19:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hHvZFsl+yZlQ/Pr4GWlb7OT+Q8+Mtz1PncEfszAGO/4=;
        b=xL2f8l71ZqpAAyfDfI9hhdvgUwcUTHm/geBNdVJyUNJV81UG+tUvmwHYDWzuUiJBZC
         S6uwzwzvbNPKOVvzMqiG44cIzr8Y3mzf0nUsHQUQi1+pQ010m3qXE0ZRAQVruEmXhS9C
         y/1uMl1FgApjpudmxjx0Do8vZhzEhT67n9y9QDQTdfHfTFAQQlwF5sv4ka1COa50zc3O
         tJlRcCTXGBUQrB+fVEkoIzHxBlNDbFbAN8KdXLdcIPCMuBgFyf24WvOBtrR10KvWUJQU
         Cuba6EdJSZyKqkO0mxl2AHLmCw0rOmsOGzLCnkhp/beKooKHFnHxi2UsKP7viRez0Ly/
         8pRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hHvZFsl+yZlQ/Pr4GWlb7OT+Q8+Mtz1PncEfszAGO/4=;
        b=Bb2gZt3A+SS3QOVEcOS7VGEBouSYWB4+CtE0xp/Bk1+viAOp4sihMckDalIK6ytmoj
         stAquAavg9SbK3uDaUod1wpzvtIyUcAncvQfLQbAThtg8FyzgpkGeLAKkRIA82InfEuE
         i/oFaOidCNkrFiONHe6rbdGGxDM33aYxJlXo30PJFKpcEHNsYY5nEairrzBYS+rlw9r2
         GZ3xuf+4gBWi9NWlOz6DnCc4YFT2s06r/GPCyr1LMyV4CZdxPVvJn0tdnKwbEN4k5vXM
         qa0q3pfnrlGP15GJTlMO/5gw2KmHa4B4Alo1aThRVu+fcQD1SpYTMfh8WYvnOGnUKO9n
         dcsQ==
X-Gm-Message-State: AOAM533ZTRvQRY5+UHCTqhWwEcXhKVBncHGxTibEhUShDHJcfSn+YYm6
        +6AB2EjcaoybrhbzyBiSMt47bA==
X-Google-Smtp-Source: ABdhPJxT5k27pES33dPx/wwbAfM/B+kMcmGhc4X/+JbcZDv11dX7wjw9Dx0amfAIPMzJrQ1k5sntCw==
X-Received: by 2002:a17:90a:d3ca:: with SMTP id d10mr9931660pjw.35.1626144902276;
        Mon, 12 Jul 2021 19:55:02 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.134])
        by smtp.gmail.com with ESMTPSA id r14sm19303344pgm.28.2021.07.12.19.54.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Jul 2021 19:55:02 -0700 (PDT)
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        jean-philippe <jean-philippe@linaro.org>,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v5 1/3] PCI: PASID can be enabled without TLP prefix
Date:   Tue, 13 Jul 2021 10:54:34 +0800
Message-Id: <1626144876-11352-2-git-send-email-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626144876-11352-1-git-send-email-zhangfei.gao@linaro.org>
References: <1626144876-11352-1-git-send-email-zhangfei.gao@linaro.org>
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
index 6d7d649..c967ad6 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -376,7 +376,7 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
 	if (WARN_ON(pdev->pasid_enabled))
 		return -EBUSY;
 
-	if (!pdev->eetlp_prefix_path)
+	if (!pdev->eetlp_prefix_path && !pdev->pasid_no_tlp)
 		return -EINVAL;
 
 	if (!pasid)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 540b377..28165dc 100644
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

