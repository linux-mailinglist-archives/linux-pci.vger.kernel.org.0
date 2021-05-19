Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74EDB389A32
	for <lists+linux-pci@lfdr.de>; Thu, 20 May 2021 01:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbhESX5f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 May 2021 19:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbhESX5e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 May 2021 19:57:34 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE41C061574;
        Wed, 19 May 2021 16:56:12 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id q15so10569909pgg.12;
        Wed, 19 May 2021 16:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JNMQiBUZJXJ3UxQ2xkL0KPsN3/Hv3HAfTP43B6QlmJU=;
        b=DqHxukMa5VU3tYERMgbbJuvKGXE07lSus/5TqPuBWlszSptPZs13grMg70c47berPu
         7Fl0s/OMldkxDA0bRdymTTAA+npmKYYIGCRfSfPAjvfKtKW2Sl2hii41oep87ZU/Up/S
         ZQKqcjwxDFOYXda+UprCLyyfv7IVT95/IBDIDRxc0174nF7MAvUc/oYfNaXeW3QGeknN
         ACYTO3wqBhympTZ8ygIHDpzk6kFfAeaGhh6cpaVdAXp0OmGiKHx1oIRdXr+NXrqifJJ/
         x4EQ9VT1z4+hXehnx82w4zxqi1a7Bzj4ztjbENar+5ObIBJWrl3h7Ofiq/xPaWgzmCWI
         U+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JNMQiBUZJXJ3UxQ2xkL0KPsN3/Hv3HAfTP43B6QlmJU=;
        b=sAOAjgvupJtBkGLoa+bF2iOIaXQzrIuuN7zBZAxove07VA2aqZDsoUPN/uwb2FyKvA
         HLXpihRXctbbMKF6JqA6MGE8I/heXa8vw7IsqAhlXIcCpxIJdmt6OKzucgdEU2uoYsWP
         i0FoYo4irPOIbAmHhuEr+Uwu4vte9KmAtrviu1f+pQ5OtYx5ARbuFr3ljW2BDiQ+Q9ms
         wWuhpcmTJHL7nn/YIQS+CRIJrm4KuBdOik6poiUzttToNkBB6MO8nGJxrw4CM6ZFJV8t
         paMnaFMwHvBaujVlxw67kbcxO5duslaucpye0JaVRsKQtuVCSMv9TBWrDriv3AOr4lHW
         tYYA==
X-Gm-Message-State: AOAM531/9RDKqY8ZnRMiZUyl9+Gi6U7pv89b1vRfdOF/xm2jcyFqobo0
        QyDyn5ec4u0m7d35R9yt4Gw=
X-Google-Smtp-Source: ABdhPJwN0cRMlSFzgP6WkzbRtqX6a6E7f8eUcAFNhAfjm5HJfya2n6REMjACn4roKy9Ne+kBxShXng==
X-Received: by 2002:a63:36c1:: with SMTP id d184mr1672616pga.47.1621468572051;
        Wed, 19 May 2021 16:56:12 -0700 (PDT)
Received: from localhost.localdomain ([94.140.8.39])
        by smtp.googlemail.com with ESMTPSA id z12sm397670pfk.45.2021.05.19.16.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 16:56:11 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com, raphael.norwitz@nutanix.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, sdonthineni@nvidia.com
Subject: [PATCH RESEND v2 7/7] PCI: Enable NO_BUS_RESET quirk for Nvidia GPUs
Date:   Thu, 20 May 2021 05:24:26 +0530
Message-Id: <20210519235426.99728-8-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210519235426.99728-1-ameynarkhede03@gmail.com>
References: <20210519235426.99728-1-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Shanker Donthineni <sdonthineni () nvidia ! com>

On select platforms, some Nvidia GPU devices do not work with SBR.
Triggering SBR would leave the device inoperable for the current
system boot. It requires a system hard-reboot to get the GPU device
back to normal operating condition post-SBR. For the affected
devices, enable NO_BUS_RESET quirk to fix the issue.

This issue will be fixed in the next generation of hardware.

Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
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

