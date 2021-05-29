Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7F73394DE6
	for <lists+linux-pci@lfdr.de>; Sat, 29 May 2021 21:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbhE2T1e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 29 May 2021 15:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbhE2T1b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 29 May 2021 15:27:31 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5539BC061763;
        Sat, 29 May 2021 12:25:54 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id q15so5151276pgg.12;
        Sat, 29 May 2021 12:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IWfL/IMqwLqFbs476iJcEczTrUNwgxx26bfBJrumYEY=;
        b=hrM9B0oQ+o1TsEFqlrsfljdnpCyJ40+Nbn4MTHMvNrobuJRIHIwYgsWEAJxwNMhgE0
         5SUdmlDAUPgLyeGx3nr4uwKzgw9pqkmOknGqhLkBHjMr1zAJKKrKoHmpoA9Ajm127O0F
         nwe+LPNVyRWGd90iv44FB9zYzUzJVyqBl0Nz/lkbEBCfCKFKHbJ5puqPgG09Na+9ggJD
         gHJh9H+gTDj4EvRXE0WKHFAI+ZXb/lwzYDexd4jwNkU443CVJtjMQElbE7roZmSQWrj6
         E+2AEpSdxRI2yfNQpahPBMpQpRp/XCgK6o2x9gYfAry9GNdGghYaiRZah6L1F9P5SUps
         ybsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IWfL/IMqwLqFbs476iJcEczTrUNwgxx26bfBJrumYEY=;
        b=aZYyfYhlpaJcSUNo8p3wcQMOf7jprIuQrrDw8rDnjL4kok/gAE1ZQ3pHcnkbI4T32Y
         44NZi9IA1PyPZhiU0Xe2eJAwGSfyk4NMe/zj5aaiqXI4VZ9hBvtwmKL54/m8nF8nKjGC
         o5fFXbnePu8NknAmZId7Cyf1mgO9rfnf4l5XFg8TOMqD+HO5ODqS2LEJUmC5geYhUQ34
         22oHY35CIQbIYx5GkW7usYLO4kXtYEIaHvB9ug8AQKJS4Q+VuGsG0s2WWCBiNjpdMDJR
         jHWK+wQP6ex6ClymCwoJaVs0eKtonPgTzd2BjH47k0+hRyB0sE8EWgmmtfeEezTJQsp8
         eDow==
X-Gm-Message-State: AOAM532nd3/96Bg5MeclOsSfp+/QegStkea+CMIcDNNlrkfKLEwdEKeR
        8GUwz1ZXQILN8l4U48PfZ3A=
X-Google-Smtp-Source: ABdhPJyh+6aY+wJjlfuIfMX8qrwCugaBvQho86c/C3x2Em2HMjcoS0XQLIqq99UMwGi0gwexELrT2g==
X-Received: by 2002:a63:5052:: with SMTP id q18mr15042066pgl.349.1622316353977;
        Sat, 29 May 2021 12:25:53 -0700 (PDT)
Received: from localhost.localdomain ([103.248.31.172])
        by smtp.googlemail.com with ESMTPSA id ge5sm7286754pjb.45.2021.05.29.12.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 12:25:53 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>
Subject: [PATCH v5 6/7] PCI: Enable NO_BUS_RESET quirk for Nvidia GPUs
Date:   Sun, 30 May 2021 00:55:26 +0530
Message-Id: <20210529192527.2708-7-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210529192527.2708-1-ameynarkhede03@gmail.com>
References: <20210529192527.2708-1-ameynarkhede03@gmail.com>
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
index e86cf4a3b..45a8c3caa 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3546,6 +3546,18 @@ static void quirk_no_bus_reset(struct pci_dev *dev)
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

