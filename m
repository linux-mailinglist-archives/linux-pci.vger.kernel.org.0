Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98EF52EFAD6
	for <lists+linux-pci@lfdr.de>; Fri,  8 Jan 2021 23:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725775AbhAHWID (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Jan 2021 17:08:03 -0500
Received: from mail-pf1-f179.google.com ([209.85.210.179]:40830 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbhAHWID (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Jan 2021 17:08:03 -0500
Received: by mail-pf1-f179.google.com with SMTP id x126so7102194pfc.7;
        Fri, 08 Jan 2021 14:07:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tzkmnWd707SGcOcBxSrShNHuNRrKOfCCZxlFIGOcO4U=;
        b=Lm1jnuvfYQ2/u7DvJMuM5rpO84Dh7PPm+afeaHh0MS5awT/tylylGyKHhBoPuHlbxd
         vN9n8LrsayhQk/rZViqPZDUICYKQLhswMNTPxbUTZNmn/8TH7/kJ3WSxsuLa5AsmNVb1
         JQDJN8eGunA+bq+BuzWMTzRLZ1QlKptiGKnuN+8VahChKUK7qQNaVynLavwT/vxMccHD
         lppT4N8s/WwYwyAcRYybqvIBNdEwHrhWtILxKvq4hZ+Q1w/DzAyPlVRRGJBKnlgYVgLw
         PYgk8db6Kko67iObGMLljNz2+cLxLrm5Vy6fCfpVU4N32uezojKgWQQH5QYGZ0j0/UvV
         Sf7w==
X-Gm-Message-State: AOAM53333cXrx4FtelyVO7r+NDso8ZewcgL4KKueXm1RlpVl/ZgM8jHk
        KRXvQ3qv6dpZOeqvVNm9F2obH0b9iLg=
X-Google-Smtp-Source: ABdhPJyXHxETccaQY3fXU3NaMTFnMe6hVZVzUMx0p7GKSo3W9hupeVNZQmX+4h/ehzNIqV40qp6Rzg==
X-Received: by 2002:a63:6806:: with SMTP id d6mr8931266pgc.205.1610143642277;
        Fri, 08 Jan 2021 14:07:22 -0800 (PST)
Received: from localhost ([2601:647:5b00:1162:1ac0:17a6:4cc6:d1ef])
        by smtp.gmail.com with ESMTPSA id a136sm10494826pfd.149.2021.01.08.14.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 14:07:21 -0800 (PST)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bhelgaas@google.com,
        moritzf@google.com, Moritz Fischer <mdf@kernel.org>,
        Brian Foley <bpfoley@google.com>
Subject: [PATCH] PCI/IOV: Clarify error message for unbound devices
Date:   Fri,  8 Jan 2021 14:06:30 -0800
Message-Id: <20210108220630.10863-1-mdf@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Be more verbose to disambiguate the error case when trying to configure
SRIOV with no driver bound vs. a driver that does not implement the
SRIOV callback.

Reported-by: Brian Foley <bpfoley@google.com>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
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
2.29.2

