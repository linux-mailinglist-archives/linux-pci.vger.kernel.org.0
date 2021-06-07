Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFDD39E689
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jun 2021 20:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbhFGSZw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Jun 2021 14:25:52 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:42550 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbhFGSZv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Jun 2021 14:25:51 -0400
Received: by mail-pg1-f171.google.com with SMTP id i34so8055694pgl.9;
        Mon, 07 Jun 2021 11:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IWfL/IMqwLqFbs476iJcEczTrUNwgxx26bfBJrumYEY=;
        b=t4niVb4NyxkyQjtsiCndAlVFKwNMPVVuC6HsFIwj3dBdzmpr423OuRwwn2qZr+O/t3
         x4PYH0E5CW5CSU+FEXmWq7QZKJmQ03tSIROUrSJ/M+cjWlQx1NFqumi1rf3lwZKWGxGO
         9PBaJtSu0u5eJP6EVO9grTVfeOLaMf5zF3ufn7ZRKxqASBAu9Tusk7Rb8f685CRj20Jc
         VG3qeyPnXuepqRr26Hu7jLK2nq4J2BuwQCztMFlGirVCScY9BDezVWSmTurrtIIo0pCT
         B19y8DzHNpYZ+JcO0/bP0FPIE0tqULvyay/8sMYOmMAw7ZnK0iqDw4QgGzWUibTC27Sg
         yu8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IWfL/IMqwLqFbs476iJcEczTrUNwgxx26bfBJrumYEY=;
        b=ejZGAlVyffLlklTpn/942IQG6u170FObS1lDN12ligyuYiuhesYfPSNUzxAyeuDb0a
         /B6jsc8lGg8FN1R9JuSEkszQANLuMMTStby67p3NrJjUjNqB0G5CcW04tk1Rw8fsqQ5q
         LGLjdZg+2IzYytfFlB0h2SRxMIYuSQ0VGga4aOh5wzbJMoIMMs3UIY2I/4Rn0TIvNNZA
         GBVnVHxp8H4wJvxHhEhNiwALvLwNh80jja5ktQbalw6QYoFqhyv+9ZXbuHy/VczrhG33
         6PWBKqdIALDYBpBheEKx+w2R30JUNMV6jfi5GlSvQguxtsvqKpgJDVwTQSDJYKbDIGUb
         glhA==
X-Gm-Message-State: AOAM532Wk25G0QND/ZMEILHWYfetHvGYw/Im93WK9ZDYu5DLCxd5t8gd
        JP6aYFggpU+jF6xNiVwTXQU=
X-Google-Smtp-Source: ABdhPJy+jgkF8ojBGMdLKOcnpcqCKTBTJcOe0/s5bziiC8emszZ93nSxgbMja9k9wjTTnzO44vwcdQ==
X-Received: by 2002:aa7:97b8:0:b029:2e9:df45:f83f with SMTP id d24-20020aa797b80000b02902e9df45f83fmr18817831pfq.10.1623090166822;
        Mon, 07 Jun 2021 11:22:46 -0700 (PDT)
Received: from localhost.localdomain ([103.200.106.115])
        by smtp.googlemail.com with ESMTPSA id k1sm8687656pfa.30.2021.06.07.11.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 11:22:46 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>
Subject: [PATCH v6 7/8] PCI: Enable NO_BUS_RESET quirk for Nvidia GPUs
Date:   Mon,  7 Jun 2021 23:51:36 +0530
Message-Id: <20210607182137.5794-8-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210607182137.5794-1-ameynarkhede03@gmail.com>
References: <20210607182137.5794-1-ameynarkhede03@gmail.com>
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

