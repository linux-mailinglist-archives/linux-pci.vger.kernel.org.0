Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC1D39EE5B
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jun 2021 07:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbhFHFvr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Jun 2021 01:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhFHFvr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Jun 2021 01:51:47 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBA4C061787;
        Mon,  7 Jun 2021 22:49:39 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 5-20020a9d01050000b02903c700c45721so18139552otu.6;
        Mon, 07 Jun 2021 22:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IWfL/IMqwLqFbs476iJcEczTrUNwgxx26bfBJrumYEY=;
        b=BIFHDZRQAOBZkHnHtszMVsQSOdLNWagLf/65IQqHPPbwLYp0jyEghjUO3ktcGUgHGJ
         eXrxXYZq0QwIt9m8XkZDr8RMzRx+8uG75QsJdHdmMaxTNp0nbHrd9+EThzc4bs0jVM3V
         koNRVW4k1t/olIcnp0EWY3V4RXs1n1HYGEfauLH+uvzZm0Km55HbNMSPuwkVd4os14Bh
         tqHEF2yBvnKg1eQus7J6B2QerWzs0OiflYriCG2fSS+BPH24H5K5VpGEwqJ3CD7vtqFU
         z9ILzsNF772M8H5Vj2oMEWo1sWgUSBBy2CdfpcCVMCzlYijS4NdFMk8icgRpiyno1ki8
         7H/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IWfL/IMqwLqFbs476iJcEczTrUNwgxx26bfBJrumYEY=;
        b=FdLNu5FHO9YL+PpsDMFleUcw/2y1Q2Rc0au+yVlYNHRQiUAHTJEDtkL2RQac+VvGMl
         C8WjxWWLGRD4bGfLuNiEbH2LFHTMRQv6pQCa9I9QSwVIbzVHReIFCsAgdL3OEwuONI+e
         JK8NYw8c35YrMv/0UxTfNHuXPvULco/FehTiJwiBRcBXp8XJwBrkwyImLmXbpDj2GCE+
         XBxIpOcqSdoAxjm0AbN+6duNTDh69yGVHKpsUglHqhxGnOvOt5B6KPc3eP475Y9ffPQf
         Ja+Itp3Wyxyal9MXqI5u2jnPEOjXbmwSAJNGsaT8JZ4WxGIrwf8qy3yBoYt2sP3QDaea
         psaw==
X-Gm-Message-State: AOAM530zlCWxGAXu4bhuM0DYfIcztzIdBktpxHg7lF/+kltuZrEA9jgX
        FarwyM867an7BxzndDVSOHM=
X-Google-Smtp-Source: ABdhPJwZ/5kgbXxp41nZkuipN4+f1AbwPcTklIGob0RENGt5lcOhoGinKVumjhQ88O8HIYx64TCG0A==
X-Received: by 2002:a9d:4f0e:: with SMTP id d14mr6532892otl.70.1623131378699;
        Mon, 07 Jun 2021 22:49:38 -0700 (PDT)
Received: from localhost.localdomain (static-198-54-128-46.cust.tzulo.com. [198.54.128.46])
        by smtp.googlemail.com with ESMTPSA id o2sm2489730oom.26.2021.06.07.22.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 22:49:38 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v7 7/8] PCI: Enable NO_BUS_RESET quirk for Nvidia GPUs
Date:   Tue,  8 Jun 2021 11:18:56 +0530
Message-Id: <20210608054857.18963-8-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210608054857.18963-1-ameynarkhede03@gmail.com>
References: <20210608054857.18963-1-ameynarkhede03@gmail.com>
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

