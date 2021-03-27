Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5ACE34B8A2
	for <lists+linux-pci@lfdr.de>; Sat, 27 Mar 2021 18:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhC0RwV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Mar 2021 13:52:21 -0400
Received: from mail-pl1-f170.google.com ([209.85.214.170]:38893 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbhC0RwA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Mar 2021 13:52:00 -0400
Received: by mail-pl1-f170.google.com with SMTP id y2so2438260plg.5;
        Sat, 27 Mar 2021 10:51:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ur7K3fGHlWpBZqyCe+lDFz2C+ADgwckyc1z0zuWsrAI=;
        b=r2P2aJxPSJjnAc5/T/7pwP/Ftpz0qm0ugvWGcCEq3lBzdv4XNGrzYrywF+7FkDHjIg
         8WF17pU4BpEvaUZNt9U4q82DPWHC7wIKxDFRY/aNCDWmpkF9rKtMjr4cPr+kOjdUq2Di
         mw06rKUhnSFJxMXCKUY235YzKx71+cuPGjFo9f/Y1yM56wP3HC1e3hgl/KDdO9ofx54b
         XONPpRp295Fi7P66g2B/1n6P8fqtE7u2YIOEx7eUVDRCsjPn9SYtrlE3zTah36S1amp2
         BSWj3NP74BNMcXTGW+QyBSjdJmwyt8zQgkIrGfr9gQrSJyplwKdmbw8IT6f9xyMby+VD
         8eYg==
X-Gm-Message-State: AOAM532fGPtHAFX59Ubk2X+tKOyrDSsZc4Ii+Cpufaf5tySw6vpqwSNN
        9VNOkJkZLZAbxBV+RJUESbpNUGAeCtI=
X-Google-Smtp-Source: ABdhPJw2ze9pOS5lS7DBRAfeFFkEQrey88gnUAfN+TITGXj4aUP7JxWeTdbSY6ygFBYk4GOvCXWZLA==
X-Received: by 2002:a17:90a:c902:: with SMTP id v2mr19551543pjt.144.1616867519506;
        Sat, 27 Mar 2021 10:51:59 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id c25sm12442043pfo.101.2021.03.27.10.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 10:51:58 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        moritzf@google.com, Moritz Fischer <mdf@kernel.org>,
        Brian Foley <bpfoley@google.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Subject: [PATCH RESEND v2] PCI/IOV: Clarify error message for unbound devices
Date:   Sat, 27 Mar 2021 10:51:40 -0700
Message-Id: <20210327175140.682708-1-mdf@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Be more verbose to disambiguate the error case when trying to configure
SRIOV with no driver bound vs. a driver that does not implement the
SRIOV callback.

Reported-by: Brian Foley <bpfoley@google.com>
Reviewed-by: Krzysztof Wilczyński <kw@linux.com>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
Changes from v1:
- Added Krzysztof's Reviewed-by
---
 drivers/pci/iov.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 4afd4ee4f7f0..f9ecc691daf5 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -304,8 +304,15 @@ static ssize_t sriov_numvfs_store(struct device *dev,
 	if (num_vfs == pdev->sriov->num_VFs)
 		goto exit;
 
+	/* is PF driver loaded */
+	if (!pdev->driver) {
+		pci_info(pdev, "No driver bound to device. Cannot configure SRIOV\n");
+		ret = -ENOENT;
+		goto exit;
+	}
+
 	/* is PF driver loaded w/callback */
-	if (!pdev->driver || !pdev->driver->sriov_configure) {
+	if (!pdev->driver->sriov_configure) {
 		pci_info(pdev, "Driver does not support SRIOV configuration via sysfs\n");
 		ret = -ENOENT;
 		goto exit;
-- 
2.30.2

