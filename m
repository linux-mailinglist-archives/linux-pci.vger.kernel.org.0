Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5258B3914A5
	for <lists+linux-pci@lfdr.de>; Wed, 26 May 2021 12:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233921AbhEZKQU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 May 2021 06:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233907AbhEZKQP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 May 2021 06:16:15 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94E3C06175F;
        Wed, 26 May 2021 03:14:42 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d78so555209pfd.10;
        Wed, 26 May 2021 03:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3JYP5XsOiLfJxNy8HHCt4jYw4Wi2NfvdBjfhoJ7nFYY=;
        b=gF00wtVRgT4wKdTpMTzkX9eKMPFJKt6UAuLCwNLqK+kMvboqskwlxyXjufrXnoV+NR
         /rETYCtVzNMFIlJzDczZhBFOf1h4RsUbkHZC2wZuCgdjb8LmuA4OeIfhALtnWorzZdxi
         onVb+h38YQNypQEkQUkby4qObS/SwyuaJVkvXHn5FymAd8LzfHK3U88nl0Z6UGuDoaRP
         dQKsQMxB0vfxWZ+E9Egf9DMtYgp/Z9ItXpDiiStbnWQkwB1BF04NliqaSZdojGi+8+/H
         FYTi3NbvAV/cI7Yg7Ydu5y5dNfckRg4lD2tcc1V2uNPD2hg2sbU+FgincXtWN7LkaEw5
         lzMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3JYP5XsOiLfJxNy8HHCt4jYw4Wi2NfvdBjfhoJ7nFYY=;
        b=HI4z46/x8R2A8RHyPZ11wbNKaCCf3uCvjRYwDN0uT1Xa0dP3O3D/CXpBrpYewF6Bo3
         iBluLBCy9ww1G5KZAoGTN0qtGZw7ejFMjs3rX871j4jUYDvMBiMn0YOcwRcORJTZjh2l
         A9qmVbsu03G3nZwDSh2QNpE7DV9BV1zP1u/55M+RuOZkkqz/9xhNdZ+rtkalR1B1JE3W
         kvHLDg1git9d/rId2Zt1AGDLVHFGEhsU95q1FAeva4aXrWtKi7NCUTSotWI/+wLUvfGb
         n78vG0lY9cLm7VY7YXkfj18DKxVwxDN/BR0WK0kg5t/64QzYW2kHyP7D+CEXYJICwp6X
         Byfg==
X-Gm-Message-State: AOAM5327NKsRXOekH+1gpNaca9DNFWfUQFNAGoF93RT8Xh2uu6wQq7HN
        8uUxxS+B0suWDF0QfHLwDnU=
X-Google-Smtp-Source: ABdhPJzLZ28eGDOMgaRXJGtrPdKLj5xW9LxnSIF+PEECTIg5/LcxClIp4o+wc7El+j7hEfOXc2L7mQ==
X-Received: by 2002:a05:6a00:139a:b029:2e3:db98:9ae3 with SMTP id t26-20020a056a00139ab02902e3db989ae3mr31485744pfg.81.1622024082404;
        Wed, 26 May 2021 03:14:42 -0700 (PDT)
Received: from localhost.localdomain ([103.248.31.164])
        by smtp.googlemail.com with ESMTPSA id c191sm15662614pfc.94.2021.05.26.03.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 03:14:42 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>
Subject: [PATCH v3 6/7] PCI: Enable NO_BUS_RESET quirk for Nvidia GPUs
Date:   Wed, 26 May 2021 15:44:02 +0530
Message-Id: <20210526101403.108721-7-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526101403.108721-1-ameynarkhede03@gmail.com>
References: <20210526101403.108721-1-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Shanker Donthineni <sdonthineni@nvidia.com>

On select platforms, some Nvidia GPU devices do not work with SBR.
Triggering SBR would leave the device inoperable for the current
system boot. It requires a system hard-reboot to get the GPU device
back to normal operating condition post-SBR. For the affected
devices, enable NO_BUS_RESET quirk to fix the issue.

This issue will be fixed in the next generation of hardware.

Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
Reviewed-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/pci/quirks.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 8f47d139c..ceec67342 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3558,6 +3558,18 @@ static void quirk_no_bus_reset(struct pci_dev *dev)
 	dev->dev_flags |= PCI_DEV_FLAGS_NO_BUS_RESET;
 }
 
+/*
+ * Some Nvidia GPU devices do not work with bus reset, SBR needs to be
+ * prevented for those affected devices.
+ */
+static void quirk_nvidia_no_bus_reset(struct pci_dev *dev)
+{
+	if ((dev->device & 0xffc0) == 0x2340)
+		quirk_no_bus_reset(dev);
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
+			 quirk_nvidia_no_bus_reset);
+
 /*
  * Some Atheros AR9xxx and QCA988x chips do not behave after a bus reset.
  * The device will throw a Link Down error on AER-capable systems and
-- 
2.31.1

