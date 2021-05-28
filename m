Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9395F3943DA
	for <lists+linux-pci@lfdr.de>; Fri, 28 May 2021 16:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236623AbhE1OKC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 May 2021 10:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236573AbhE1OJ6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 May 2021 10:09:58 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95635C06174A;
        Fri, 28 May 2021 07:08:23 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id g24so2588538pji.4;
        Fri, 28 May 2021 07:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3JYP5XsOiLfJxNy8HHCt4jYw4Wi2NfvdBjfhoJ7nFYY=;
        b=tUliXJXbMmG/pH8QpmThjV+2lRvC3rsw5IZsYmZozdvlmUxvEkQZwQEz6eter9Qe0H
         QPzUchiCRgwlDAwjN9IOGRTzvGXk3prGPj/+Qg5alh38Ap/AsfXgNL+2O+KADAPJiael
         9vT1fTrt++3sR3yMX6Sq60M4fBoMFHooLO6ROHumSPv9glLwmkz9raM19dTZZVWGkvkf
         OV+aZGuGTj6BwnnDm1kXH3n74HGtKtKQThnW4VOHTyCCVSUGM/M8KduGHJ5ZD/Uhm/QO
         cvPxuASfa+YlbTjzyQ4Ajqm4o1kGK/I8kbylolglTVw0jAxI+wB+Ld+71SVytAbTmWSl
         F9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3JYP5XsOiLfJxNy8HHCt4jYw4Wi2NfvdBjfhoJ7nFYY=;
        b=PlC24n/9/1ywVD2A0g+pyah8aehd0Gr98dFH3OiVGAhazRmXL8/w4eDzl/hycvVkNb
         mh/A4rJ0JRES9nMcrHNCHRKU2e+KqjXNqN0j/aM702TMgUNdzk8ZZgZPwiFozdknE/AO
         nWXBt6X8eLew2QvAKCeL/ZdHSWgkzzkttjBSuqpfzQja8shGXc1N+NzfdjE1F07LCRJb
         eVygFiqSrVUaOz0N5ukZZ0rlFAv8jOueZOVN34FIz/tcZepqn6AyFgqOwyVUqZ0k3YZq
         dmV1GWO6Pu03Ni4JgHJzATOU+142zez5/94OkxFfYQNGx5lqHRZhzpI1gtMQoJeqqj/m
         Ajnw==
X-Gm-Message-State: AOAM530Bg6j3BBOrAOf1liFVJ+fIcGKo3lPWyjka3jFX6B3VjrM5WADJ
        jDhWI7KxkNnDQnZdM9Gb3mA=
X-Google-Smtp-Source: ABdhPJwI31Xx6M47HXYNvDg7dl4oW7DLRRnIdWwF0Ubp78Fe/uQuJ3nvoTUfdvkwvuKqtXSEa+mA8Q==
X-Received: by 2002:a17:902:ba88:b029:ee:f232:d13a with SMTP id k8-20020a170902ba88b02900eef232d13amr8467668pls.44.1622210903181;
        Fri, 28 May 2021 07:08:23 -0700 (PDT)
Received: from localhost.localdomain ([103.248.31.164])
        by smtp.googlemail.com with ESMTPSA id j3sm4607841pfe.98.2021.05.28.07.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 07:08:22 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>
Subject: [PATCH v4 6/7] PCI: Enable NO_BUS_RESET quirk for Nvidia GPUs
Date:   Fri, 28 May 2021 19:37:54 +0530
Message-Id: <20210528140755.7044-7-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210528140755.7044-1-ameynarkhede03@gmail.com>
References: <20210528140755.7044-1-ameynarkhede03@gmail.com>
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

