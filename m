Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92BD0331D43
	for <lists+linux-pci@lfdr.de>; Tue,  9 Mar 2021 04:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbhCIDBg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Mar 2021 22:01:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbhCIDBO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Mar 2021 22:01:14 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9AAC06174A
        for <linux-pci@vger.kernel.org>; Mon,  8 Mar 2021 19:01:14 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 16so1358118pgo.13
        for <linux-pci@vger.kernel.org>; Mon, 08 Mar 2021 19:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xwRgjZcAZ1ubRMYqNPR3lzpRRMZVD65trB3Jo7QAQDE=;
        b=BpsKsKKEGV4Q8tZLIracC064LXu4EhmpaRab2r/UWWvS6AtqSPN2u15MIzC7N+aUyN
         kFZ8gKGmYVqOTZmZoZ6EkZ8VzQtBzVcG90/alidQ1sfEmuTNV58orapJxrgoVqpUzBGf
         CpO7VXHOB1HO1r4zyxOga8v3TI8587V2hiYgQO1VcTpVK0EMzWWD5MpKo5eawb00DUET
         OykXY4yv6cg/VbggLKVUNURQ8RjLFbu4PuniRyG1F7ejK9Yl1e7KzErgQyTmjc3URmsr
         l6M1dquu5953pAtBDif2JnDbF/8vkVCMjI1Jc2Re8AfPG22q6ox7/kEgybN/JGwgmpmu
         6+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xwRgjZcAZ1ubRMYqNPR3lzpRRMZVD65trB3Jo7QAQDE=;
        b=WgBe08qXPwAVt3CV8sasKQjtaydY1qz1qAFAzKxZj0BcdTRab6vBtbPauov3bzGHkj
         kJne6RUCa4ah4gaBLA+1nkuLlWFWsYjwsUiAgOBkerlhu/0ITTtEzcTnsB46pHle9lKw
         3WC0bqsbJG+XSChv5ihM0H/Ay0gp3J/6fjoDadWk8lclm83gA7AxMDlRvA7iMX86iRg7
         mW3M9bUiOcYBahRaL63kId6mfkeaOK1WTDvXq7ukTStwnGMLSCcDTJY+ovA/vHpBHz3P
         G/ckxAt07fLaVQgFXXBm0a8rV2r3ATwMLi064E4HtQekgunNEqXyG2IlJ9/1TSXelmt/
         1PtA==
X-Gm-Message-State: AOAM532GCMHuY0JOxuNZmk5s3oNUEV2H3Ns5kATPdZVRdXxYk6+oK3YO
        8mApQ97DBa8SavjmKuhDkXH6xw==
X-Google-Smtp-Source: ABdhPJyuSxJJPCTr8ggWaLG5PoVz+cgp0/JSQ3HmniHYtu6KbTJ5qzYIzpa0kF9N+HlOFfEwKQScTA==
X-Received: by 2002:a62:ea09:0:b029:1ee:3bac:8012 with SMTP id t9-20020a62ea090000b02901ee3bac8012mr23555442pfh.35.1615258873988;
        Mon, 08 Mar 2021 19:01:13 -0800 (PST)
Received: from localhost.localdomain ([240e:362:435:6a00:e593:6e0:bfb4:a65f])
        by smtp.gmail.com with ESMTPSA id y24sm3162782pfn.213.2021.03.08.19.01.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Mar 2021 19:01:13 -0800 (PST)
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        jean-philippe <jean-philippe@linaro.org>,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        kw@linux.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v3 1/3] PCI: PASID can be enabled without TLP prefix
Date:   Tue,  9 Mar 2021 11:00:35 +0800
Message-Id: <1615258837-12189-2-git-send-email-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615258837-12189-1-git-send-email-zhangfei.gao@linaro.org>
References: <1615258837-12189-1-git-send-email-zhangfei.gao@linaro.org>
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
index 793d381..88f981b 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -380,7 +380,7 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
 	if (WARN_ON(pdev->pasid_enabled))
 		return -EBUSY;
 
-	if (!pdev->eetlp_prefix_path)
+	if (!pdev->eetlp_prefix_path && !pdev->pasid_no_tlp)
 		return -EINVAL;
 
 	if (!pasid)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 86c799c..1daa943 100644
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
2.9.5

