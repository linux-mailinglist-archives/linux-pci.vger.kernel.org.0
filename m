Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97210366163
	for <lists+linux-pci@lfdr.de>; Tue, 20 Apr 2021 23:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233882AbhDTVJt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Apr 2021 17:09:49 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:53189 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbhDTVJt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Apr 2021 17:09:49 -0400
Received: by mail-wm1-f54.google.com with SMTP id y204so19607587wmg.2
        for <linux-pci@vger.kernel.org>; Tue, 20 Apr 2021 14:09:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JTRCOmXX1jOykQZsnt0iXQ7ZwVNHOLdtcHQQb1R69D0=;
        b=nA66ybTZr5tss1/AWPsGD9PTRXM162cALXc5LHl3K9c0A+XR1+4/uQ7ogRgVxlMS2L
         IR0WKZJSZGO8+As2Lx4T3YlhkAcPmzckNydpRfd5a8cHtb2GFeTlonV/xzHSr/oMCIba
         DEumFwo9JULxCKzLWhj5hhBylJ3vMcZzfBz5FmsXW8ShgtgSJpgrD+LFpfSJEqO1qdtJ
         Vr/dU82NUNQUeF/R5J2dd+ImZ6WIeSBwDt5i/f914nquqMne+hrSz8em1mprRujXykXO
         +Q6tmOpSMt5nTbV+/Vy+/OAPYlFz44Yul/QN6GyibVz+W2lXLltZC+UXt6kyODFMBcCK
         Ov7w==
X-Gm-Message-State: AOAM531jBgcTcUCu6nR3zTGooDVDj70pzulNo4Ywz9JU7Bh4kqOicLnn
        khW5phjuBzeLfMS1StrN6uM=
X-Google-Smtp-Source: ABdhPJzw5JgDgJXAOvzOFEJsDiiJUG9jUd6moFrO1EgkxsvTbuknAyyRPTI1S6FvrJA+f7k3srN5hQ==
X-Received: by 2002:a1c:35c6:: with SMTP id c189mr6183632wma.127.1618952955413;
        Tue, 20 Apr 2021 14:09:15 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id v8sm229616wrt.71.2021.04.20.14.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 14:09:15 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH] x86/PCI: Remove unused assignment to variable info
Date:   Tue, 20 Apr 2021 21:09:13 +0000
Message-Id: <20210420210913.1137116-1-kw@linux.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The value returned from the alloc_pci_root_info() function that is
assigned to the "info" variable within the loop body is never used for
anything once the loop finishes its run, and it is overridden later
within another loop body where the value returned from the
find_pci_root_info() will be assigned to it.

When the function alloc_pci_root_info() is executed within the body of
the first loop, it would allocate a new struct pci_root_info and then
store pointer to it in a global linked list called "pci_root_infos",
thus the value that the "info" variable would contain after the loop
finishes would reference the struct pci_root_info that was allocated the
last, thus it might not necessarily be of use.

Additionally, the function find_pci_root_info() can be used to find and
retrieve the relevant pci_root_info stored on the aforementioned linked
list.

Since the value of the "info" variable following the first loop is never
used in any meaningful way the assigned can be removed.

Related:
  commit d28e5ac2a07e ("x86/PCI: dynamically allocate pci_root_info for native host bridge drivers")
  commit a10bb128b64f ("x86/PCI: put busn resource in pci_root_info for native host bridge drivers")

Addresses-Coverity-ID: 1222153 ("Unused value")
Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 arch/x86/pci/amd_bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/pci/amd_bus.c b/arch/x86/pci/amd_bus.c
index bfa50e65ef6c..ae744b6a0785 100644
--- a/arch/x86/pci/amd_bus.c
+++ b/arch/x86/pci/amd_bus.c
@@ -126,7 +126,7 @@ static int __init early_root_info_init(void)
 		node = (reg >> 4) & 0x07;
 		link = (reg >> 8) & 0x03;
 
-		info = alloc_pci_root_info(min_bus, max_bus, node, link);
+		alloc_pci_root_info(min_bus, max_bus, node, link);
 	}
 
 	/*
-- 
2.31.0

