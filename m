Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE84B418075
	for <lists+linux-pci@lfdr.de>; Sat, 25 Sep 2021 10:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235794AbhIYIse (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 25 Sep 2021 04:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235079AbhIYIsY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Sep 2021 04:48:24 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6BAC061570;
        Sat, 25 Sep 2021 01:46:49 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id i23so34655415wrb.2;
        Sat, 25 Sep 2021 01:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7J/eKw85aOccYjSVMNGJibIwRKQiWh9ftrBZOBFy2g8=;
        b=TH1lvqPI5Wu0X6zAw/ADa05wm4/08lgsLaffdzbJD/hVw7xIE7cKD84HUkuVFkkP0J
         YtIAqQGpexosa0d323h5/PEE9czxilaHrtemk0pbCLfuO4OpT2/69uwxraez8axJMz0O
         TRil2Eqc57lk4TbjpxBy0UOvE3q/sI4DlTKzO+ZVnmXrTijSGDJ0a43K50HmjgD+CKPp
         s2kR8FfMdNMxa8VjyX4gSHitjKP/6+MRwdKZgczblrXNRWsLb3io7DNWkcqNCeeVe7PU
         c2sHVYKaFu8UtjBsFplFg3EUpeD8m0H3xvano+Ch41gjUoS/IvTZbsnPmXAHdl8C/lkI
         oWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7J/eKw85aOccYjSVMNGJibIwRKQiWh9ftrBZOBFy2g8=;
        b=v1Wk4vvo7Yc4ECfiDTPK/hEJWU0lwgeV0QyCOXEvaPrbZrFx1Qq+qdsS9MVaBz8sa2
         ChTMNHd6sbtRIQL/Zqz4h93RYEJkgKnEGWiq67prpRsJtOH0a3e1rx+uR4QYlNMtnI6m
         h7mmflo8k4KLU4hXpNMfoAfGD17ceoNweIj0fjMOwJeb1uNXntnucGH7KSQGwbg5otoq
         6jj6swEsarHaugUj06gQtVWZlqH4UZ4tHWuQxjPUhquoPH1TyYXYrD1ke98XlMqpqQEf
         Kc17/mIq7fz4s93WI6xNQ4B/bJ8oaQe4M+BftPAbb8rg+pt/J7q57GuLsfFKhKI5WN99
         +9sQ==
X-Gm-Message-State: AOAM531peXgZy1ZbYxT2FcOJtOgMey3qPFgtz2irfGdjQDGDOXgtgO0n
        Yb+Q1z1Pxb6H0ub5lPRM6MY=
X-Google-Smtp-Source: ABdhPJwuVOqIQBjcBSCQWuS1vJce4ZX/Ly4UDRWJE94+zyyFnornpcUREkh3OAOu2o63wgKNseoM/w==
X-Received: by 2002:a05:6000:184e:: with SMTP id c14mr15982534wri.242.1632559608227;
        Sat, 25 Sep 2021 01:46:48 -0700 (PDT)
Received: from localhost.localdomain (252.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.252])
        by smtp.gmail.com with ESMTPSA id y9sm17222997wmj.36.2021.09.25.01.46.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Sep 2021 01:46:47 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     tsbogend@alpha.franken.de
Cc:     robh@kernel.org, arnd@arndb.de, catalin.marinas@arm.com,
        Liviu.Dudau@arm.com, bhelgaas@google.com, matthias.bgg@gmail.com,
        gregkh@linuxfoundation.org, linux-mips@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-staging@lists.linux.dev,
        neil@brown.name, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] PCI: Allow architecture-specific pci_remap_iospace()
Date:   Sat, 25 Sep 2021 10:46:39 +0200
Message-Id: <20210925084642.5642-5-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210925084642.5642-1-sergio.paracuellos@gmail.com>
References: <20210925084642.5642-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci_remap_iospace() was originally meant as an architecture specific helper
but it moved into generic code after all architectures had the same
requirements. MIPS has different requirements so it should not be shared.

The way for doing this will be using a macro 'pci_remap_iospace' defined
for those architectures that need a special treatment. Hence, put core API
function inside preprocesor conditional code for 'pci_remap_iospace'
definition.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/pci/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ce2ab62b64cf..0ec57bb01a88 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4123,6 +4123,7 @@ unsigned long __weak pci_address_to_pio(phys_addr_t address)
  * architectures that have memory mapped IO functions defined (and the
  * PCI_IOBASE value defined) should call this function.
  */
+#ifndef pci_remap_iospace
 int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
 {
 #if defined(PCI_IOBASE) && defined(CONFIG_MMU)
@@ -4146,6 +4147,7 @@ int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
 #endif
 }
 EXPORT_SYMBOL(pci_remap_iospace);
+#endif
 
 /**
  * pci_unmap_iospace - Unmap the memory mapped I/O space
-- 
2.25.1

