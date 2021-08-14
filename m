Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A7A3EC4ED
	for <lists+linux-pci@lfdr.de>; Sat, 14 Aug 2021 22:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbhHNUNE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 14 Aug 2021 16:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233085AbhHNUNB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 14 Aug 2021 16:13:01 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750FCC0613A3;
        Sat, 14 Aug 2021 13:12:31 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id u15so774842plg.13;
        Sat, 14 Aug 2021 13:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ucsCDj86AYMXxFvb/42UJkwESYccMJOVbID7Zllmoc4=;
        b=Tro2C3kNf6ZPK1e9IvISFdUFHW/pPRnKVEFRf+FMucjtWpMxvWE0UF3L8wceHTPF/R
         x5KROgdML+RHz8aN0cUskKCivCNX44+g9mfA7JFUcLNVU+4bqCxAo/O0Tn5PgxlhT9fA
         wnU67skAQPTtsfYWr2x5056d/ZLGA7u4L+467tQlCJunnUWHYFeH0xWXi18ioA6NspZW
         BdFbObkbAgAULw7bPO/hRuVqsQIpjGLcV6eQ5IiXkNZsBLLNt821Uz0+l+8zIJShpe28
         cT6jAR1SwdRgiB23dLqlkXxheInS87QmrZ2UsJVDFuDhAqoBQsjocjU49KhFIV71iB6I
         8PcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ucsCDj86AYMXxFvb/42UJkwESYccMJOVbID7Zllmoc4=;
        b=NB2WULb2sR9M/Y62V1gT1dpP2nYhgImFun7RMP6qONyvYMk5eVf1aRIn6bZe5WrURK
         quHW0s2PfDZHKaLKJi2kgMC7mSOc/u5F2gfALmd8Llpj1LHxSMImv48c4MM5OpGCqxcs
         S4kKE0F5oIUPZi04XIsAxdt671Vs6k3bTgXfpjsG1GoRLANh9zRsXvaStI1fWwae70hl
         2t3XKPgUhrHBIbqL2EuojE5PFrziGP2IL+kY27RNjlWZ1KncglGNCkEJZxTfnOJJJv1B
         3gawp2l+xooCxq7J6dCc2d1Xn8hr3hvX2B91+jPKHrBPiYWh607NtAn0w3aXpO7WUiX+
         +DqQ==
X-Gm-Message-State: AOAM530S41OCHPlDHM0FqImU1vJbOhvwLb/WeEwUywx9IA9nvkifvuox
        VbZwQTEXQj1pqLho+33tjCoRHoHvIBgzsA==
X-Google-Smtp-Source: ABdhPJyviaER+qMFM77GDwYP+Ajn1eSIQ10yOKaP9ai9yygn5anyd8QIhwWnnLmjfk5qBxBdNKHcLg==
X-Received: by 2002:a17:902:a702:b029:12b:aa0f:d553 with SMTP id w2-20020a170902a702b029012baa0fd553mr6904169plq.3.1628971951048;
        Sat, 14 Aug 2021 13:12:31 -0700 (PDT)
Received: from xps.yggdrasil ([49.207.137.16])
        by smtp.gmail.com with ESMTPSA id r14sm6511132pff.106.2021.08.14.13.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Aug 2021 13:12:30 -0700 (PDT)
From:   Aakash Hemadri <aakashhemadri123@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Shuah Khan <skhan@foundation.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] PCI: Prefer IS_ENABLED(CONFIG_HOTPLUG_PCI)
Date:   Sun, 15 Aug 2021 01:42:06 +0530
Message-Id: <0f6a7e20c358ac4d3add6076cc6011166edb1999.1628957100.git.aakashhemadri123@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1628957100.git.aakashhemadri123@gmail.com>
References: <cover.1628957100.git.aakashhemadri123@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix checkpatch.pl WARNING: Prefer IS_ENABLED(CONFIG_HOTPLUG_PCI) over
defined(CONFIG_HOTPLUG_PCI) || defined(CONFIG_HOTPLUG_PCI_MODULE)

Signed-off-by: Aakash Hemadri <aakashhemadri123@gmail.com>
---
 drivers/pci/slot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index a9678589ed23..8d1a983027b7 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -323,7 +323,7 @@ void pci_destroy_slot(struct pci_slot *slot)
 }
 EXPORT_SYMBOL_GPL(pci_destroy_slot);
 
-#if defined(CONFIG_HOTPLUG_PCI) || defined(CONFIG_HOTPLUG_PCI_MODULE)
+#if IS_ENABLED(CONFIG_HOTPLUG_PCI)
 #include <linux/pci_hotplug.h>
 /**
  * pci_hp_create_module_link - create symbolic link to hotplug driver module
-- 
2.32.0

