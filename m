Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0F342F53F
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 16:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240244AbhJOObV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 10:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236879AbhJOObU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Oct 2021 10:31:20 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260B8C061570;
        Fri, 15 Oct 2021 07:29:14 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id q2-20020a17090a2e0200b001a0fd4efd49so2914300pjd.1;
        Fri, 15 Oct 2021 07:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dd4Eeu7B1efXH+i1PkiNhhqgZoEGYaZatuZnYiVKcUU=;
        b=Iab+Z9gvwWs+TREOBYg5vi2nqF3HsLIqxvL6zx4U4+9sVWm+NpOSQcg+EPOyozxfym
         BaJbiqQualQhru5j1N4xKazIPPtIund0pZpByX3ZwPFHhWxm3WnztyLWReuy9pU0KG2d
         aPFkK68SU6mC+IzAtUgp0iQg77uvJ6UuXh3IT6IAq21yA3UZSV+6okMGK0yFTkKY8v6m
         eo/GbOyiWPOLRKhGk9YoUBoi1wWx2m7tQ9VEz8Qjmvrpij74VZwtHtYbAZBoIEsGKRkV
         8f89ybDK5ZrIFs930bOv1X0U5ayTYISUmV2L8Txv+1+tU+4roPgc3X1NEKq7ouMXo5SH
         JWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dd4Eeu7B1efXH+i1PkiNhhqgZoEGYaZatuZnYiVKcUU=;
        b=uvfTnqYIzE65hUcJpvD+0m94N1wP0t7CSrlTrAjuAYv5APk4GmsbcVbOUX4Xms/CO2
         xw7aCU1ueJx6Mx5nR+cmSWg/ZArRF9hLX4fENAyLXSdyMYrB0l0ohSOxbOMhLwKbPWfr
         TEri8F2GZpDLxSxSi6AHd7f8NH2O2UurESFzKoYfCMF5YYgEu7XEeCMeDourwrNBgZQD
         yg7Ckf5XSHSxnGtCXfIX/6FXHN2hQL9Ixzp1PkQteiWJ61C8XxKTrwRs66zQoGLVBhb+
         nubYUYk0SGzit7TBCpbKRWR6DcV/Dd3FOjvLNVxUGa6DJ4jvnSfPjpV639FXUMBxyLUf
         Lbdg==
X-Gm-Message-State: AOAM532Zc6vEgNsDvRtKXqTuVjyPKUGWVtBrshLyRvQ0IKQ0Ut5yWl5T
        LClihg6Lgtt3mzz8XL2gB1c=
X-Google-Smtp-Source: ABdhPJw3WSz37viY11jS4RxqgCdqRZ1QweK4V0tpvcvNRzCqQOXYNGbb+Ukcq2I5Z+tCVDnFknytpA==
X-Received: by 2002:a17:90b:3749:: with SMTP id ne9mr28508164pjb.192.1634308153472;
        Fri, 15 Oct 2021 07:29:13 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:4806:9a51:7f4b:9b5c:337a])
        by smtp.gmail.com with ESMTPSA id j12sm5210806pff.127.2021.10.15.07.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 07:29:13 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/24] PCI: Add PCI_ERROR_RESPONSE and it's related definitions
Date:   Fri, 15 Oct 2021 19:58:16 +0530
Message-Id: <4516b02d3c0fe3593a1a9f59bab47e99cdb65f02.1634306198.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634306198.git.naveennaidu479@gmail.com>
References: <cover.1634306198.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

An MMIO read from a PCI device that doesn't exist or doesn't respond
causes a PCI error.  There's no real data to return to satisfy the
CPU read, so most hardware fabricates ~0 data.

Add a PCI_ERROR_RESPONSE definition for that and use it where
appropriate to make these checks consistent and easier to find.

Also add helper definitions SET_PCI_ERROR_RESPONSE and
RESPONSE_IS_PCI_ERROR to make the code more readable.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 include/linux/pci.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index cd8aa6fce204..928c589bb5c4 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -154,6 +154,15 @@ enum pci_interrupt_pin {
 /* The number of legacy PCI INTx interrupts */
 #define PCI_NUM_INTX	4
 
+/*
+ * Reading from a device that doesn't respond typically returns ~0.  A
+ * successful read from a device may also return ~0, so you need additional
+ * information to reliably identify errors.
+ */
+#define PCI_ERROR_RESPONSE			(~0ULL)
+#define SET_PCI_ERROR_RESPONSE(val)	(*val = ((typeof(*val)) PCI_ERROR_RESPONSE))
+#define RESPONSE_IS_PCI_ERROR(val)	(*val == ((typeof(*val)) PCI_ERROR_RESPONSE))
+
 /*
  * pci_power_t values must match the bits in the Capabilities PME_Support
  * and Control/Status PowerState fields in the Power Management capability.
-- 
2.25.1

