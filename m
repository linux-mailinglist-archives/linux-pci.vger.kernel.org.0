Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E47383F09BD
	for <lists+linux-pci@lfdr.de>; Wed, 18 Aug 2021 18:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhHRQ6o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Aug 2021 12:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbhHRQ6n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Aug 2021 12:58:43 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23F8C061764;
        Wed, 18 Aug 2021 09:58:07 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id o20so4187769oiw.12;
        Wed, 18 Aug 2021 09:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YHiyP8NzEy58+Z+7tVFCTiv5LvRgvaNEfl1HIoWAXzI=;
        b=iybBwr9w8ORfy+BMxsYXntANhHHp/2t21+w/pjnA6EDy6w/MYgwh6hB9Gd2VvKasi0
         dGPCxnJFSpP1emoj9huuqKJSy/bYRpQPJrF7W+mm6wxBrCdWDYJToX+Bm4luzvpiaOga
         RKlJIFTwlgUmcr9pjPGZCw/xoVEcShEts9aYXmljxV2RBZwX1bGxxIC+w/J7eFuvKeSZ
         giHP/DjHJLhV2+PENrAlb+xFkvx2XoDr6DGy2KCZRojHrBPA1z/kjlbWCF8xURYMS8d1
         L1inF5Wm3cFthy2ICmRD/dr53bPMgPhYdlsgphVhdrpld6pYcPnuOL29dIk/0SMkaSZb
         5H7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YHiyP8NzEy58+Z+7tVFCTiv5LvRgvaNEfl1HIoWAXzI=;
        b=CRID/7esOi5CVW/ai4xIQW+VBEK22yvwQuaSOtIV7QwOqW5QDLV8Vo/gQCbx7hsBYV
         HcLvhoVD0xafiabcZkhXSwrRNyxAUVOamX8wO7CPGfda02K48nQDAdP+9UUkpLapAeA9
         flxHeLKEuM1ArihKTo7WgdvWMUnlvkACagv5V/aTrPwZZs76DJMMxT3etNF/t8rVLJKT
         DaKpftbLmLVSao2Uv1AVcYliQpfaffWUs01PX+h8HVZyJj+Ew9FUiNQs2x0WvUdehqqK
         Y1t1Z6MJdkkSAKRTYxzmpOAZsecf0rgXru8VUhwdz6zXCsy2XzJiX0DoAF0C6GadTXiL
         uHwA==
X-Gm-Message-State: AOAM5302mVQQNQatvqbq3QalsGxIkzIti9qPRc3w+eE4qhu2qMO0k+94
        zKDQaGk7zu3yggE/OSSGEX8=
X-Google-Smtp-Source: ABdhPJwVTPIB5dzrFLoB5c4YXf4XuZqseUZg/4t+a1d6poikxsJfPA0AXaVZMY8YMAynvScGckidBw==
X-Received: by 2002:aca:4b03:: with SMTP id y3mr8156528oia.72.1629305887188;
        Wed, 18 Aug 2021 09:58:07 -0700 (PDT)
Received: from vaslot-XPS-8930 (2603-8081-2340-02f5-dc15-49e0-e88f-845f.res6.spectrum.com. [2603:8081:2340:2f5:dc15:49e0:e88f:845f])
        by smtp.gmail.com with ESMTPSA id v11sm129505oto.22.2021.08.18.09.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 09:58:06 -0700 (PDT)
From:   Vishal Aslot <os.vaslot@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vishal Aslot <os.vaslot@gmail.com>
Subject: [PATCH] PCI: ibmphp: Fix double unmap of io_mem
Date:   Wed, 18 Aug 2021 11:57:51 -0500
Message-Id: <20210818165751.591185-1-os.vaslot@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ebda_rsrc_controller() calls iounmap(io_mem) on the error path. It's
caller, ibmphp_access_ebda() also calls iounmap(io_mem) on good and
error paths. Removing the iounmap(io_mem) invocation inside
ebda_rsrc_controller().

Signed-off-by: Vishal Aslot <os.vaslot@gmail.com>
---

Why am I fixing this?
I found this clean up item in drivers/pci/hotplug/TODO [lines 43-44]
and decided to fix it. This is my 2nd patch ever in linux so my
apologies for any style issues. I am very teachable. :)

 drivers/pci/hotplug/ibmphp_ebda.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pci/hotplug/ibmphp_ebda.c b/drivers/pci/hotplug/ibmphp_ebda.c
index 11a2661dc062..7fb75401ad8a 100644
--- a/drivers/pci/hotplug/ibmphp_ebda.c
+++ b/drivers/pci/hotplug/ibmphp_ebda.c
@@ -714,8 +714,7 @@ static int __init ebda_rsrc_controller(void)
 		/* init hpc structure */
 		hpc_ptr = alloc_ebda_hpc(slot_num, bus_num);
 		if (!hpc_ptr) {
-			rc = -ENOMEM;
-			goto error_no_hpc;
+			return -ENOMEM;
 		}
 		hpc_ptr->ctlr_id = ctlr_id;
 		hpc_ptr->ctlr_relative_id = ctlr;
@@ -910,8 +909,6 @@ static int __init ebda_rsrc_controller(void)
 	kfree(tmp_slot);
 error_no_slot:
 	free_ebda_hpc(hpc_ptr);
-error_no_hpc:
-	iounmap(io_mem);
 	return rc;
 }
 
-- 
2.27.0

