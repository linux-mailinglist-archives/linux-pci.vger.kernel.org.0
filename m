Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C62B665781
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jan 2023 10:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbjAKJbq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Jan 2023 04:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbjAKJbP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jan 2023 04:31:15 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD275F97
        for <linux-pci@vger.kernel.org>; Wed, 11 Jan 2023 01:30:00 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id 17so16212318pll.0
        for <linux-pci@vger.kernel.org>; Wed, 11 Jan 2023 01:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CLqjgQrYV/9llu7u0zTqMyy4KVzHPwgJKEC2KvdEJPw=;
        b=RDzgpLUd5Xcg7GvUnBDuVYvgMfa+ZtbdTgw5u82L39SljrpFWmAHsoGskA5tTNKnBP
         tW0V2Bvp4f70P/V5ebyUz1Bg0smxTwKmgu0f+IVXwApAiFwNfmGq1gF0OMfiinbKUmkM
         nIqkE/x5KBc9BINUhYkC0moJ444xcFMJLauP412Ps2DHGKRecVLtwp+uejIiu0STpaoQ
         uD/13CbC/MmIGNaK/tHE0NHV8pEnswEh9lv+ALi3fnhJS0Wv+uYlToTVHrWEDp2EhR8y
         v6F9As/tRFaJHZJAWEUi5H/k7MUPDcH3bXxJDho1zyMdjSV237HwT3WUPiSvBqdHgAKq
         sQyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CLqjgQrYV/9llu7u0zTqMyy4KVzHPwgJKEC2KvdEJPw=;
        b=Wz0b+p4Tpx9zN0q8yDJmSUuKJXuTynwEwExuh3m2RZQHDNeP6+1yDl3+2ZW4t93cMK
         xC3VuZCkvVGNaNVjkm8QxD0FggmGHNtUshivKbebgtLN8HntkXfZhkEIgs7DyM5Twq2R
         idSKOLMuz2jjaOj1VaYSyPmEd9dWYE5YSjWvvGX7bUskS+jZ2srX/DzmNt1GZzvvY+bj
         3PkPF4ue3qstDIr6cJSlEYalE8bjk28Nn26640JDKHCl0TNIqC/ONOmPETAGguqnbzzb
         em4pIhQrbKuwhe12CEY3tUu6zjvjcdwMyj5B3BUhkUCL3VwhI19/hWB82yAjxu24d/mA
         9dDQ==
X-Gm-Message-State: AFqh2kqng7PEcsUa5ca8LuaQctoa2AGPTfh4EEqINPF7PymwVQuMFNov
        76lk3OQhp39wGmjYLrBwq5dmKplRsEwHcQ==
X-Google-Smtp-Source: AMrXdXsSAZcNUALeF6TLdkKPqpItXTEDu+eGkP1+vSYM8jy8CPIoG+gLMc7WLR1zzh1xj7AGUKjkPQ==
X-Received: by 2002:a05:6a20:4996:b0:9d:efbf:6607 with SMTP id fs22-20020a056a20499600b0009defbf6607mr75235227pzb.21.1673429399197;
        Wed, 11 Jan 2023 01:29:59 -0800 (PST)
Received: from AHUANG12-3ZHH9X.lenovo.com (220-143-163-101.dynamic-ip.hinet.net. [220.143.163.101])
        by smtp.gmail.com with ESMTPSA id t21-20020a635355000000b0049f5da82b12sm7805605pgl.93.2023.01.11.01.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 01:29:58 -0800 (PST)
From:   Adrian Huang <adrianhuang0701@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Adrian Huang <adrianhuang0701@gmail.com>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Adrian Huang <ahuang12@lenovo.com>,
        Jon Derrick <jonathan.derrick@linux.dev>
Subject: [PATCH v2 1/1] PCI: vmd: Avoid acceidental enablement of window when zeroing config space of VMD root ports
Date:   Wed, 11 Jan 2023 17:29:11 +0800
Message-Id: <20230111092911.8039-1-adrianhuang0701@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Adrian Huang <ahuang12@lenovo.com>

Commit 6aab5622296b ("PCI: vmd: Clean up domain before enumeration")
clears PCI configuration space of VMD root ports. However, the host OS
cannot boot successfully with the following error message:

  vmd 0000:64:05.5: PCI host bridge to bus 10000:00
  ...
  vmd 0000:64:05.5: Bound to PCI domain 10000
  ...
  DMAR: VT-d detected Invalidation Queue Error: Reason f
  DMAR: VT-d detected Invalidation Time-out Error: SID ffff
  DMAR: VT-d detected Invalidation Completion Error: SID ffff
  DMAR: QI HEAD: UNKNOWN qw0 = 0x0, qw1 = 0x0
  DMAR: QI PRIOR: UNKNOWN qw0 = 0x0, qw1 = 0x0
  DMAR: Invalidation Time-out Error (ITE) cleared

The root cause is that memset_io() clears prefetchable memory base/limit
registers and prefetchable base/limit 32 bits registers sequentially. This
might enable prefetchable memory if the device disables prefetchable memory
originally. Here is an example (before memset_io()):

  PCI configuration space for 10000:00:00.0:
  86 80 30 20 06 00 10 00 04 00 04 06 00 00 01 00
  00 00 00 00 00 00 00 00 00 01 01 00 00 00 00 20
  00 00 00 00 01 00 01 00 ff ff ff ff 75 05 00 00
  00 00 00 00 40 00 00 00 00 00 00 00 00 01 02 00

So, prefetchable memory is ffffffff00000000-575000fffff, which is disabled.
Here is the quote from section 7.5.1.3.9 of PCI Express Base 6.0 spec:

  The Prefetchable Memory Limit register must be programmed to a smaller
  value than the Prefetchable Memory Base register if there is no
  prefetchable memory on the secondary side of the bridge.

When memset_io() clears prefetchable base 32 bits register, the
prefetchable memory becomes 0000000000000000-575000fffff, which is enabled.
This behavior (accidental enablement of window) causes that config accesses
get routed to the wrong place, and the access content of PCI configuration
space of VMD root ports is 0xff after invoking memset_io() in
vmd_domain_reset():

  10000:00:00.0 PCI bridge: Intel Corporation Sky Lake-E PCI Express Root Port A (rev ff) (prog-if ff)
          !!! Unknown header type 7f
  00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
  ...
  f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

  10000:00:01.0 PCI bridge: Intel Corporation Sky Lake-E PCI Express Root Port B (rev ff) (prog-if ff)
          !!! Unknown header type 7f
  00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
  ...
  f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

To fix the issue, prefetchable limit upper 32 bits register needs to be
cleared firstly. This also adheres to the implementation of
pci_setup_bridge_mmio_pref(). Please see the function for detail.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=216644
Fixes: 6aab5622296b ("PCI: vmd: Clean up domain before enumeration")
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>
Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
Reviewed-by: Jon Derrick <jonathan.derrick@linux.dev>
---
Changes since v1:
  - Changed subject per Bjorn's suggestion

 drivers/pci/controller/vmd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 769eedeb8802..e520aec55b68 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -526,6 +526,9 @@ static void vmd_domain_reset(struct vmd_dev *vmd)
 				     PCI_CLASS_BRIDGE_PCI))
 					continue;
 
+				/* Clear the upper 32 bits of PREF limit. */
+				memset_io(base + PCI_PREF_LIMIT_UPPER32, 0, 4);
+
 				memset_io(base + PCI_IO_BASE, 0,
 					  PCI_ROM_ADDRESS1 - PCI_IO_BASE);
 			}
-- 
2.31.1

