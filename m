Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFB677C374
	for <lists+linux-pci@lfdr.de>; Tue, 15 Aug 2023 00:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbjHNW33 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Aug 2023 18:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbjHNW3Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Aug 2023 18:29:24 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBE01718
        for <linux-pci@vger.kernel.org>; Mon, 14 Aug 2023 15:29:24 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d6ac5db336eso1823067276.2
        for <linux-pci@vger.kernel.org>; Mon, 14 Aug 2023 15:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692052163; x=1692656963;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RcDIHEJOfIIWu/ve0ihwsZwkiAHO9c4r9RpAYPgPp0Q=;
        b=nijWK+10BpOOGjaNzFF/ySkAzQyd1bpPMAfTFZ15CB3RONAkpICnZD9HkZuF0WDOdr
         GmWZDXkttlQgwIrweQ06htMhP1y5c4dLLYcFiXhr2DYygC4CPaLl+lXkCBPRFGdQyA3Y
         s0zI+dAdAYnKv6EAMUSqioCW8e6SUoVkxKzh/BalivDSLxU2tVRr4qXnh5FjJ1xE2yPt
         a40o8fKsSE0Y9fz5Eo6vn5qAG36WTiaG55mlMnja0ivOXsUFnoJ6U8R5a08Thl6oiixp
         tuICWzWVtM21YVHhiB6Q48LsBlDn/7IG53hgwDBPDI0W6fINqvXu2McNcBRTy83aW9hk
         5vcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692052163; x=1692656963;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RcDIHEJOfIIWu/ve0ihwsZwkiAHO9c4r9RpAYPgPp0Q=;
        b=CiAPOplnpaG/awtGGJLfHMkx35p6iEBwbJ+/mpir1Pi2zpdVeQVmtuqOaHXZVsf0f+
         aS+WqFzP3M/TtOe/yBQFHqt7AYU1wpKV65RE1wtZLW3mdtKui6+keWhVTzvctyQXdpNg
         M4hDiqq6rOCKmjN8FmuYLDIVq+j1mCG33y9PXEtveJe+oyOXRfOdKrDFRkXbly8VbfFp
         vZDjnk41KoDOGFe8OB/o0ddSizDol9pzDOl3lqS+diboBdu0SpS/80sxJLLAmuP1S/MZ
         4v9lbZiElqFhFlcxIjb0K39OqhWJAi8fDxFUr+dY3WsBntPEYvVjB7lgmVsucZOoJuTM
         Cqqg==
X-Gm-Message-State: AOJu0YyCnCybvcBQDW+872Ht+Q3QRj1ywEdVkckKbxO2r/5OeLou/Fb0
        Z49v5yEsMlp4KAJ0qft4mLkC7rFeLhLtqnC7Hg==
X-Google-Smtp-Source: AGHT+IFOorN5wnUKQMgqROu8nIpxAopwbZ9DVt7NA03X2ZwvhZWl7WSRhbOBwhQ2hjOiEXxNdv8EMmqvUlMFUGlkFQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:4c7:b0:d5d:511b:16da with
 SMTP id v7-20020a05690204c700b00d5d511b16damr152077ybs.2.1692052163298; Mon,
 14 Aug 2023 15:29:23 -0700 (PDT)
Date:   Mon, 14 Aug 2023 22:29:22 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAMGq2mQC/x3N0QrCMAyF4VcZuTawzYnOV5FdhDTTQG1KOoow9
 u5WLz/4OWeHIq5S4N7t4FK1qKWG4dQBvyg9BTU0w9iP5/42TFhNAwbXKl4wsyJb2txiFP+x9dm NMUfaVvM3UqCJeKaZrhdoq9ll1c//8bEcxxf6NaK4gQAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692052162; l=1795;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=toFi8SLwCRTpw1/0M43OmJYYHtAj7TdhUp1prlUqvx0=; b=U3QTlDMvdylVxAWgbG3pK732X8XyFTgIFb66Bd2VJBtoqOoT1q9iVC/u9LcAgyIsk9+LM9r9F
 EJcOv89AN5mAXhCnqYlgISVYhs9mDM/pbsSB1w8FWz7dQcfdDIwtpq1
X-Mailer: b4 0.12.3
Message-ID: <20230814-void-drivers-pci-controller-pcie-iproc-platform-v1-1-81a121607851@google.com>
Subject: [PATCH] PCI: iproc: fix -Wvoid-pointer-to-enum-cast warning
From:   Justin Stitt <justinstitt@google.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "=?utf-8?q?Krzysztof_Wilczy=C5=84ski?=" <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When building with clang 18 I see the following warning:
|       drivers/pci/controller/pcie-iproc-platform.c:55:15: warning: cast to smaller
|                integer type 'enum iproc_pcie_type' from 'const void *' [-Wvoid-pointer-to-enum-cast]
|          55 |         pcie->type = (enum iproc_pcie_type) of_device_get_match_data(dev);

This is due to the fact that `of_device_get_match_data` returns a void*
while `enum iproc_pcie_type` has the size of an int. This leads to
truncation and possible data loss.

Link: https://github.com/ClangBuiltLinux/linux/issues/1910
Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: There is likely no data loss occurring here since `enum
iproc_pcie_type` has only a few fields enumerated from 0. Definitely not
enough to cause data loss from pointer-width to int-width.
---
 drivers/pci/controller/pcie-iproc-platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-iproc-platform.c b/drivers/pci/controller/pcie-iproc-platform.c
index acdc583d2980..83cbc95f4384 100644
--- a/drivers/pci/controller/pcie-iproc-platform.c
+++ b/drivers/pci/controller/pcie-iproc-platform.c
@@ -52,7 +52,7 @@ static int iproc_pltfm_pcie_probe(struct platform_device *pdev)
 	pcie = pci_host_bridge_priv(bridge);
 
 	pcie->dev = dev;
-	pcie->type = (enum iproc_pcie_type) of_device_get_match_data(dev);
+	pcie->type = (uintptr_t) of_device_get_match_data(dev);
 
 	ret = of_address_to_resource(np, 0, &reg);
 	if (ret < 0) {

---
base-commit: 2ccdd1b13c591d306f0401d98dedc4bdcd02b421
change-id: 20230814-void-drivers-pci-controller-pcie-iproc-platform-ada4ac9a9a75

Best regards,
--
Justin Stitt <justinstitt@google.com>

