Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65F123DAFF3
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jul 2021 01:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234878AbhG2XiI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jul 2021 19:38:08 -0400
Received: from mail-pj1-f52.google.com ([209.85.216.52]:44548 "EHLO
        mail-pj1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234448AbhG2XiI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jul 2021 19:38:08 -0400
Received: by mail-pj1-f52.google.com with SMTP id e2-20020a17090a4a02b029016f3020d867so11865407pjh.3
        for <linux-pci@vger.kernel.org>; Thu, 29 Jul 2021 16:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=czfwimJC2Qqp4h3gtTtuU27/KqvNQcct0k1X3sUzr98=;
        b=ra8ryIpVRssalTgFJ4bcFhknyJFH4xq0zte8PjdczG88zIVGOB5cpRm1/pnIouldXv
         16JZcgKxYlLn9Li1LpQQkh5IptaDQwYFGnivDwBMod2d+IyCumE/81X5Du0nRVynQfc8
         xwNZdSpVjtZw7j4D83lw2Y27QFkxCV8aB1Gk98FEUbzJq5S0RCMfYHkiFiVgwR5cBKkM
         /NZiA4kTvZGtoSdgpJaJfrTu6E+5Ey3jVcOKw/7OlXgmcee09oKxYLgPF8DWKIut4/FC
         ToMlZS5xB4rm5gyemW5ktQwiq06U1L5Huo2kTeu4soJ0uPhGqcjmOnr/DNYpONr9VG9w
         45Tw==
X-Gm-Message-State: AOAM530J76rQ+gWntBM9e4YceS0H+ANXhiXP1GaZw3w9qXdqSBv5rK1e
        MtB/QuifG7NLriBUNgFBV+k=
X-Google-Smtp-Source: ABdhPJz4yiIOVkIYZnkbqNlwMkqKXGIFFWfEbx0jJ9PuHPRVN9Wt9G+gDgPY66UerK9tlM7tpWlu9w==
X-Received: by 2002:a63:1053:: with SMTP id 19mr1935963pgq.395.1627601883437;
        Thu, 29 Jul 2021 16:38:03 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id k4sm4446831pjs.55.2021.07.29.16.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 16:38:03 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org
Subject: [PATCH 1/2] PCI: syscall: Set the ~0 value on access failure
Date:   Thu, 29 Jul 2021 23:37:54 +0000
Message-Id: <20210729233755.1509616-1-kw@linux.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pciconfig_read syscall has a special provision to handle users that
don't check the return value for a possible error code and rely solely
on checking for the value of ~0 to be set as a result of the PCI
configuration read failure.

The commit e4585da22ad0 ("pci syscall.c: Switch to refcounting API")
changed this semantic of setting the results to the value of ~0 to
indicate read error concerning CAP_SYS_ADMIN capability flag validation.
After this commit, the syscall would simply return -EPERM early should
the user does not have the required permissions.  This changes the
original behaviour which might not be something that the users of this
syscall expect, especially since some of the problematic users do not
check the return code whatsoever.

Thus, restore the original behaviour of setting the results to a value
of ~0 on read failure to include the capabilities check.

Fixes: e4585da22ad0 ("pci syscall.c: Switch to refcounting API")
Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/syscall.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/syscall.c b/drivers/pci/syscall.c
index 8b003c890b87..b842af1e06b8 100644
--- a/drivers/pci/syscall.c
+++ b/drivers/pci/syscall.c
@@ -22,8 +22,9 @@ SYSCALL_DEFINE5(pciconfig_read, unsigned long, bus, unsigned long, dfn,
 	long err;
 	int cfg_ret;
 
+	err = -EPERM;
 	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
+		goto error;
 
 	err = -ENODEV;
 	dev = pci_get_domain_bus_and_slot(0, bus, dfn);
-- 
2.32.0

