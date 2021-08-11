Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 620AF3E9B4E
	for <lists+linux-pci@lfdr.de>; Thu, 12 Aug 2021 01:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbhHKXrI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Aug 2021 19:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbhHKXrH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Aug 2021 19:47:07 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EB3C061765;
        Wed, 11 Aug 2021 16:46:43 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id bo18so6354069pjb.0;
        Wed, 11 Aug 2021 16:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nYwCxQJ9/49X2zOi88wvf0V9m4gUqdeY1chCL4IkZO4=;
        b=aOatYWRwElPP6ZXSdCZSyUhtbaghDH/JrKjaLWQsDElEiJWHm4XQP7WBs4ISYqHB7J
         Hf4o1W+HM5Yl8Lx5fj0WXPdJxQ8oyFF67Nbx2oz/h1yHnvdXiSZRDi3A/mphMSazT0az
         DPD4H2Da7MNg6GufC5JFZ3rzZpGTdLvvcuBE7oZ89jNFVq6X+ier9kloRmcMooJTCYbf
         1Vc2PwBwz63/I5dQTe/TBgfHumS1Neyhk89cTewrfWT4moFuZF3qYBhCN0B8xnLw+H5Z
         HiGiSBWhpg3nii0cQonrzlk+yqAPW6viczAEhQLlXcC3IsRbHWi3aXNGg0d5JZ7XK1MT
         i0ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nYwCxQJ9/49X2zOi88wvf0V9m4gUqdeY1chCL4IkZO4=;
        b=eZWdEmUWDLNHgeebZC5FPFXOBK2lHuzXDSLabpPSFsoio6Xlg48fe+hmz8+E1q+0DQ
         iay8nYohFSLfP46zc0PpvFw8BQyuvIq0EqUjtPre5XaKAXZFhAikF5K3gU6+jcA4jj5P
         UKhk+vnGFHkSXPM9Z5eazc+nIjyO+cuB7sfdyfFPNW90xETY1Iqk25rZGwh4tX+HlIpe
         QWsXsyI7RCGvpAcp03ZGiPTrojH5o8Z/nEEL9xDU0Po+ikqjr0jVqhzzq5HJCkP0Tj/T
         2H4VsonH1EKwNoPeVXITYJBZelS8Wf3ZVfnjBHOE/n5M9iskjjy0ToVBaD1KemYHAyPN
         oCqw==
X-Gm-Message-State: AOAM533ddmrFxb2zyp7sNqVR2D0Uh5ohK+DX6Y1cYi0M4qYULCUeQ070
        gTqSNO3UqH/bTJdF/tI7Sm8=
X-Google-Smtp-Source: ABdhPJymMZJQEXJ6i/YvE3tP05Tin9dZz072nwdOhv1eKu+lLq8CDjMLVcMxDlOBiXsCtGy0ACkb+w==
X-Received: by 2002:a17:90a:df14:: with SMTP id gp20mr11043265pjb.33.1628725602917;
        Wed, 11 Aug 2021 16:46:42 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:6006:a148:ab4a:57a2:9e36:2395])
        by smtp.googlemail.com with ESMTPSA id v20sm734361pgi.39.2021.08.11.16.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 16:46:42 -0700 (PDT)
From:   Utkarsh Verma <utkarshverma294@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Utkarsh Verma <utkarshverma294@gmail.com>
Subject: [PATCH] PCI: Remove duplicate #ifdef in pci_try_set_mwi()
Date:   Thu, 12 Aug 2021 05:16:01 +0530
Message-Id: <20210811234601.341947-1-utkarshverma294@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove the unnecessary #ifdef PCI_DISABLE_MWI, because pci_set_mwi()
performs the same check.

Signed-off-by: Utkarsh Verma <utkarshverma294@gmail.com>
---
 drivers/pci/pci.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index aacf575c15cf..7d4c7c294ef2 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4456,11 +4456,7 @@ EXPORT_SYMBOL(pcim_set_mwi);
  */
 int pci_try_set_mwi(struct pci_dev *dev)
 {
-#ifdef PCI_DISABLE_MWI
-	return 0;
-#else
 	return pci_set_mwi(dev);
-#endif
 }
 EXPORT_SYMBOL(pci_try_set_mwi);
 
-- 
2.25.1

