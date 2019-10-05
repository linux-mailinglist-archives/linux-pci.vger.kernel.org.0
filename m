Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEEADCC741
	for <lists+linux-pci@lfdr.de>; Sat,  5 Oct 2019 03:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfJEBts (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Oct 2019 21:49:48 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34530 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbfJEBts (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Oct 2019 21:49:48 -0400
Received: by mail-pg1-f195.google.com with SMTP id y35so4761992pgl.1
        for <linux-pci@vger.kernel.org>; Fri, 04 Oct 2019 18:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=QsfvGFuRohKr1l6pObvG2zaoMC/SPwYl/b1JcIlr95c=;
        b=AoBRZZiyqE2wu0IBRSVdfsYjxtvIDFc3OFQ3/Q68YAZySmonyeEsWhuaR4uILfkOUz
         b+xjnizRVuvqQXE0M9iRa9q+5fph3BCYk0aEg8NDiT1gc0Fg4rjpz/W1vu9aTgWcTZYH
         MWKAdMtkoJULfy5aZXPyw+7pb6rIDJ8a2nmUez/mFCUwzR7Au5yef+mzhLaCowgzdKvR
         yx2ziB6ARAWAap2YmLIIhYtiusy3Ko7oayx7bguSzUNQT7fKBQqgoiO7YUTsqvMNiSMQ
         IIQ4Ufne5uaSTeJsdft2L3TdI6B4Aw8zP6AyL+a3Ln5OsGmrTtKJ6Nan+B/dKGHYunI+
         wcYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QsfvGFuRohKr1l6pObvG2zaoMC/SPwYl/b1JcIlr95c=;
        b=tDumT4hH6FPqXZJGCwlFQP+HXORhaaQZ94LpC6L4sL7Z8JVXd12pXZDaAYb3l9typ+
         9ITu5Mq+z9hYnNzLbRerWt2P9wVgFyewbcOhCJmtaXZ8ebyHdtvn5ZYaaxHOifjGjRs0
         zK6mtpXplFvsTxFChMdIn5/nCR7VY0+mhIb9x4WGFRy1w3DQnUXmO/mNSM4mqwVTQOoC
         ZF7c8Bfv5TbTtqZAyGM2UzFUJ04RLRLcfacOZKlFF6gTxvDWoJO1TEDlYGn7K++7rLIP
         tK6a2SoXm0AoRKSUCAuOyQiEy/UzWnIMc7zmZD6W/4ueCTdLl3/YGZtdMhAEvwphzZtA
         8oyQ==
X-Gm-Message-State: APjAAAUeGbhPSwhI6JzKp7j3pMl58/vrYJueiJpHfQ29fsMa+chQ+zVF
        gB4TLcFbc4DYkquKg0a+7yD7fg==
X-Google-Smtp-Source: APXvYqzZ5yXKAtja0JWgYFKJLxEwtSMznwcaM9dAht2NSa3+keiDxwDqMaNqRGVqvLI/hLm52rHI8A==
X-Received: by 2002:a63:705b:: with SMTP id a27mr18180320pgn.136.1570240187537;
        Fri, 04 Oct 2019 18:49:47 -0700 (PDT)
Received: from nuc7.sifive.com ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id b185sm7529508pfg.14.2019.10.04.18.49.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 04 Oct 2019 18:49:46 -0700 (PDT)
From:   Alan Mikhak <alan.mikhak@sifive.com>
X-Google-Original-From: Alan Mikhak < alan.mikhak@sifive.com >
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        kishon@ti.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        palmer@sifive.com, paul.walmsley@sifive.com
Cc:     Alan Mikhak <alan.mikhak@sifive.com>
Subject: [PATCH] PCI: endpoint: cast the page number to phys_addr_t
Date:   Fri,  4 Oct 2019 18:49:37 -0700
Message-Id: <1570240177-8934-1-git-send-email-alan.mikhak@sifive.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Alan Mikhak <alan.mikhak@sifive.com>

Modify pci_epc_mem_alloc_addr() to cast the variable 'pageno'
from type 'int' to 'phys_addr_t' before shifting left. This
cast is needed to avoid treating bit 31 of 'pageno' as the
sign bit which would otherwise get sign-extended to produce
a negative value. When added to the base address of PCI memory
space, the negative value would produce an invalid physical
address which falls before the start of the PCI memory space.

Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
---
 drivers/pci/endpoint/pci-epc-mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/pci-epc-mem.c b/drivers/pci/endpoint/pci-epc-mem.c
index 2bf8bd1f0563..d2b174ce15de 100644
--- a/drivers/pci/endpoint/pci-epc-mem.c
+++ b/drivers/pci/endpoint/pci-epc-mem.c
@@ -134,7 +134,7 @@ void __iomem *pci_epc_mem_alloc_addr(struct pci_epc *epc,
 	if (pageno < 0)
 		return NULL;
 
-	*phys_addr = mem->phys_base + (pageno << page_shift);
+	*phys_addr = mem->phys_base + ((phys_addr_t)pageno << page_shift);
 	virt_addr = ioremap(*phys_addr, size);
 	if (!virt_addr)
 		bitmap_release_region(mem->bitmap, pageno, order);
-- 
2.7.4

