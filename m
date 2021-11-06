Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF281446FA6
	for <lists+linux-pci@lfdr.de>; Sat,  6 Nov 2021 18:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbhKFR7J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 Nov 2021 13:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233407AbhKFR7H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 Nov 2021 13:59:07 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAA9C061714;
        Sat,  6 Nov 2021 10:56:26 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id r12so44752598edt.6;
        Sat, 06 Nov 2021 10:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3h30cY2ZC1huP0EMgM5FS83vEMXGDQzOBr2MExkq4aI=;
        b=mdLx/I0xdAZRgq2bYmMSfDC0Sc4CmjriBkzB+nh67PONr/3rzE5saq/xmCTogau4Xq
         k6Hi3iMsnc9I4BPDW7rPLLlwJXP1P317OPY9mG+pQXymBf719YlZ9uGM7Lpd8rozY+As
         P9+4lzUKVAeDXSbTVo4F3aI7ZS49SgoaEs914bVaRjaAKzkEV2P+mDTtnEDKf44eyJ3D
         +HhEsCQF/JHDLS2fZ33oOhmRMU86n5REPLtM2Uh9KEI7TH9dC783eHSB7iqZWPZw2tYg
         i3SNSFn2kjiqbLtY9QA4wxjLsCIRgZ1Q24i1ldMYhbCafn0XtYgYAKfujIMs/SMBx8dc
         X8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3h30cY2ZC1huP0EMgM5FS83vEMXGDQzOBr2MExkq4aI=;
        b=vs5ftvkZgZVs2uTxbGQc0VrQbQliCJH6i1JvB5c5K0E0ELY1rCdWm6m1sST3OvitEN
         cIKYpYE9u7FHkTsGPNt2KPo5sWfpwXSvmiOsBeILFIHFkU7g8lPUJhB+rCCMtCeo8TUH
         N6j9pzEMtq6vmwJJ34/pRVoz0tzB53Piw99f4Ahp+whbUWiC6l0/cPbx6qxm4za8Xkoa
         0w8Lq6QGrVpPWe5LKFQvP7nthygC4NWt+usJW8m8qy5mPL0cslsLP3M62bmnDv4M00i+
         UWaSOgCAtjQI8fbBUPSfnTUJHblpoOvrSnifF6g+6DMzR1Rx/tM3IFy3wRinZ/FJWUW9
         e+zw==
X-Gm-Message-State: AOAM531vfdtEj0hbFh2hnfJZ330I70Wvutmz6g8sbtwMD17U3XHBtKce
        QlP9BT8djUyLviPzaZLMxVHL6X5wMVI=
X-Google-Smtp-Source: ABdhPJzTF/odkyputIhjKzRBnge/gj3JRDDW0pOst049Oc1WQk6xqH5UsEG3JMajyrFo9rDiy4SbkQ==
X-Received: by 2002:a17:906:aecf:: with SMTP id me15mr17708145ejb.351.1636221384973;
        Sat, 06 Nov 2021 10:56:24 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:109:9f0:f6a6:7fbe:807a:e1cc])
        by smtp.googlemail.com with ESMTPSA id z2sm5802224ejb.41.2021.11.06.10.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 10:56:24 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 1/2] PCI/ASPM: Never enable ASPM for insane devices
Date:   Sat,  6 Nov 2021 18:56:20 +0100
Message-Id: <20211106175621.28250-2-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211106175621.28250-1-refactormyself@gmail.com>
References: <20211106175621.28250-1-refactormyself@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

aspm_attr_store_common() makes it possible to clear the disable bits
even for devices that fails pcie_aspm_sanity_check().

 - Extend the if condition in aspm_attr_store_common() to screen out
   insane devices.

Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
 drivers/pci/pcie/aspm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 013a47f587ce..72cb17489e88 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1225,7 +1225,7 @@ static ssize_t aspm_attr_store_common(struct device *dev,
 	down_read(&pci_bus_sem);
 	mutex_lock(&aspm_lock);
 
-	if (state_enable) {
+	if (state_enable && !pcie_aspm_sanity_check(pdev)) {
 		link->aspm_disable &= ~state;
 		/* need to enable L1 for substates */
 		if (state & ASPM_STATE_L1SS)
-- 
2.20.1

