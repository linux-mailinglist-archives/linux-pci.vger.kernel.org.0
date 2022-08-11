Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A5759066A
	for <lists+linux-pci@lfdr.de>; Thu, 11 Aug 2022 20:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235891AbiHKSkr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Aug 2022 14:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235888AbiHKSkq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Aug 2022 14:40:46 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB26E2B1A3
        for <linux-pci@vger.kernel.org>; Thu, 11 Aug 2022 11:40:44 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id b9-20020a170902d50900b0016f0342a417so11936335plg.21
        for <linux-pci@vger.kernel.org>; Thu, 11 Aug 2022 11:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=mtBgBOU+VmnH7pWxeMXp2NFGHFR9AtO9bHxsGX8CxYk=;
        b=aRrfZ3uIY2oExMKgXew+0/7DIVuyZEv0YCRdFmB0rrJs5NDlschOTM6h1hgPROBEGq
         pIRHTvmopk31k8omZuKbWsoWYCtPlJIuqACoiRNuC69/HSXuly/9QaHTOHVZP5A7mEqf
         6n9l6MAY/tD3etm8n+FjxQ4jZo1OG3gq+Loty0+SBt+K6MymY2gBfaK7vpJUVtnGMxzk
         RfW0nOxmNbuFLGLjjGizR3+bb4i/EWOEnqK/TsDnW1NsRMeJw9QupQ6DYzyAUEGxR+O7
         tqkMMh5yd2cEsYEHzRqoz0IfyUUxqqkJ27/lS7W/6ufiaSwetUzI6byqkCQubKcanwcv
         FWbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=mtBgBOU+VmnH7pWxeMXp2NFGHFR9AtO9bHxsGX8CxYk=;
        b=24UUoArzoRXh+6npCXrVKmAQkEIp6uiqrsHJSVFafVFIvaif4ZSx+sWTYX0TTHxT2l
         FSB2EWADrHHp3acxl7ASkLi4Lnpih0wOgKQbbdLjx+BaBJwlqRgyWtAvS67eBsxZ5QSS
         qTz5Ea+rgEfuR2OJaHkOfu1nmPRGhcN1e9LKSsri2QGlVSMEcL4ry8ShQFtwPP4bJ7/h
         lixW+YWTDQpixsKfweuOsTGuOWKa7Mm8oApf9nb8ZbgtsxJM3Yn/XLnzVzAOoOpMxnjx
         UY+ETXx4UY+3dW7OUX0Z02Z5LgkpVPQMSxzXfNRYXxASYkM68uW7SG895CFzz+92Evan
         HiwA==
X-Gm-Message-State: ACgBeo31elAFNc46qSBWtswrx9OmLTZxXDs2PwEqXiqI4AQ0tA7UpFDO
        2ofG3hWQO5RuwD8H5aZOl+mclnWx6aC/Tldl4y0=
X-Google-Smtp-Source: AA6agR761TkfSRWps8RSK2h035rykG9I4qj4f0+lF0QXQpT2kRQxZC4YFJt+a9+PCKXcOUZKSwK2UdCAV4otpCx8Hjs=
X-Received: from wmcvicker.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5ebe])
 (user=willmcvicker job=sendgmr) by 2002:a17:903:2286:b0:16e:ef47:4013 with
 SMTP id b6-20020a170903228600b0016eef474013mr531363plh.120.1660243244311;
 Thu, 11 Aug 2022 11:40:44 -0700 (PDT)
Date:   Thu, 11 Aug 2022 18:40:01 +0000
Message-Id: <20220811184001.2512121-1-willmcvicker@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v1] PCI/PM: Switch D3Hot delay to use usleep_range
From:   Will McVicker <willmcvicker@google.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     kernel-team@android.com, Sajid Dalvi <sdalvi@google.com>,
        Will McVicker <willmcvicker@google.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sajid Dalvi <sdalvi@google.com>

Since the PCI spec requires a 10ms D3Hot delay (defined by
PCI_PM_D3HOT_WAIT) and a few of the PCI quirks update the D3Hot delay up
to 20ms, let's switch from msleep to usleep_range to improve the delay
accuracy.

This patch came from Sajid Dalvi <sdalvi@google.com> in the Pixel 6
kernel tree [1]. Testing on a Pixel 6, found that the 10ms delay for
the Exynos PCIe device was on average delaying for 19ms when the spec
requires 10ms. Switching from msleep to uslseep_delay therefore
decreases the resume time on a Pixel 6 on average by 9ms.

[1] https://android.googlesource.com/kernel/gs/+/18a8cad68d8e6d50f339a716a18295e6d987cee3

Signed-off-by: Sajid Dalvi <sdalvi@google.com>
Signed-off-by: Will McVicker <willmcvicker@google.com>
---
 drivers/pci/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 95bc329e74c0..5ae5b3c4dc9b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -72,7 +72,8 @@ static void pci_dev_d3_sleep(struct pci_dev *dev)
 		delay = pci_pm_d3hot_delay;
 
 	if (delay)
-		msleep(delay);
+		usleep_range(delay * USEC_PER_MSEC,
+			     (delay + 2) * USEC_PER_MSEC);
 }
 
 bool pci_reset_supported(struct pci_dev *dev)

base-commit: 2ae08b36c06ea8df73a79f6b80ff7964e006e9e3
-- 
2.37.1.559.g78731f0fdb-goog

