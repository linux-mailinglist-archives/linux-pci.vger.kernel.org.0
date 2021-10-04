Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D4C42116C
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 16:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbhJDOeA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 10:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234355AbhJDOd7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Oct 2021 10:33:59 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBFAC061745;
        Mon,  4 Oct 2021 07:32:09 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 187so10250288pfc.10;
        Mon, 04 Oct 2021 07:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0szOl/Q5keJYQjPtxy9YApfb7ftHWXnTXQ4eoRdC7oM=;
        b=pLLpF53rMpH5/A7/bwhuxbyqP7dsK8RKStqv6dM0EiiTl1kYYJ+recaGGFdxvdoQcG
         iG0yrmHu8cI5ybElXwmZ/Li8ASBMgvJU7l8b+JLI/CmZh3iUZjMfHxH6yEpCXj9W6poj
         YMEm6ExoFv7SfGqQ5wNFvmv+8Of/DWxVEy9joxo4UzKQxEix4DBz96lX/HXcf2iudDET
         GIHHH3aY2qUCNYRWz5Rn60Rumeb7R+dNCeQVOWR7JmbJsvAXNVZPZgONe+dn8EYwR642
         /QJZcJYPPTiIpWYP0TlBhKKKvCEHjQXcdYzVWFSnAjZ6R9oZjS/0QlUzRhRUuy05/Kt5
         5bOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0szOl/Q5keJYQjPtxy9YApfb7ftHWXnTXQ4eoRdC7oM=;
        b=N4PNP3EL8a4E9HbzOC19xeXiOBNESin/7ULd7/94RwPJPI0FvLaVlbZQhyQsDHqFP6
         bEHqG8+UuBhvZil7a0CaTxibA5ThEhc7ZbnMixDqKQOvX4Pmn5hbSERUo8EXVkSCqy0O
         qT37lnnv6VPP1YMFvwYc2KF1yZ4h5/mc6Sfhv32bi9UDZEs4aYwpcDXHNN7BLfIjZP4O
         Q0sBQOjNa2EU4Op/lN1ULw09ngz39xxMCaSJ3ifMvC9pwycd6yQPlwOhvySw/3IMDfuu
         sAsmrBw2/+hE36jUWAtiiUyhItn1Wx1dIJ++xaRJIm1n8/FMowe8uF4zp9LuL+iGzsRa
         wz9Q==
X-Gm-Message-State: AOAM532W/Nx5qdn+Wyz5j/a2DyoeUi8nDn99io9Hl0HyC3gKKt/aaoJm
        V6c+c5CT8iZ73EFk+TW2ic8=
X-Google-Smtp-Source: ABdhPJxFCAiiCJc0ybJMUg0sN9X07vAED02uknYV73wOyF+NN4kbj55q82FwpHbKazV8QK7IrjgFnQ==
X-Received: by 2002:a63:d814:: with SMTP id b20mr11311918pgh.268.1633357929468;
        Mon, 04 Oct 2021 07:32:09 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:e8f0:c2a7:3579:5fe8:31d9])
        by smtp.gmail.com with ESMTPSA id q3sm14489146pgf.18.2021.10.04.07.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 07:32:09 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 3/8] PCI/DPC: Initialize info->id in dpc_process_error()
Date:   Mon,  4 Oct 2021 19:59:59 +0530
Message-Id: <d6e7eabf4fcf80b454dbcec507b3553448fcc95a.1633357368.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1633357368.git.naveennaidu479@gmail.com>
References: <cover.1633357368.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In the dpc_process_error() path, info->id isn't initialized before being
passed to aer_print_error(). In the corresponding AER path, it is
initialized in aer_isr_one_error().

The error message shown during Coverity Scan is:

  Coverity #1461602
  CID 1461602 (#1 of 1): Uninitialized scalar variable (UNINIT)
  8. uninit_use_in_call: Using uninitialized value info.id when calling aer_print_error.

Initialize the "info->id" before passing it to aer_print_error()

Fixes: 8aefa9b0d910 ("PCI/DPC: Print AER status in DPC event handling")
Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/pcie/dpc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index c556e7beafe3..df3f3a10f8bc 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -262,14 +262,14 @@ static int dpc_get_aer_uncorrect_severity(struct pci_dev *dev,
 
 void dpc_process_error(struct pci_dev *pdev)
 {
-	u16 cap = pdev->dpc_cap, status, source, reason, ext_reason;
+	u16 cap = pdev->dpc_cap, status, reason, ext_reason;
 	struct aer_err_info info;
 
 	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
-	pci_read_config_word(pdev, cap + PCI_EXP_DPC_SOURCE_ID, &source);
+	pci_read_config_word(pdev, cap + PCI_EXP_DPC_SOURCE_ID, &info.id);
 
 	pci_info(pdev, "containment event, status:%#06x source:%#06x\n",
-		 status, source);
+		 status, info.id);
 
 	reason = (status & PCI_EXP_DPC_STATUS_TRIGGER_RSN) >> 1;
 	ext_reason = (status & PCI_EXP_DPC_STATUS_TRIGGER_RSN_EXT) >> 5;
-- 
2.25.1

