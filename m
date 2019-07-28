Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D52BF78174
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2019 22:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfG1UXj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 28 Jul 2019 16:23:39 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33802 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfG1UXj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 28 Jul 2019 16:23:39 -0400
Received: by mail-lf1-f68.google.com with SMTP id b29so33319303lfq.1;
        Sun, 28 Jul 2019 13:23:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TmxcCXhXwRYGEoMeDwlU1eEbMiMpwlUebLffY1+PjIY=;
        b=oMUtxi6UtndDNTCjz6uXnXSX9M5pgpirqAeIFqOgvFnbWCKChxZFDEXgFBzwSfFdD9
         WB+40LZn/MGoRMfUyLKVwD2CDxkdvqut66I0TVSyQoN3fQ5+ogkd7uW9s98wy7DUGF88
         VaUuYcKb1zzaPjsL6ysj1F48l0Rws75pGLc5OlR2FOc56WP2RsDG5xH/PvxZwSFbE4mx
         PZySIIbyMolL/IQREJPkwZbm+Vv7neNcEuqmyW+I/drN1sE0hsjVGwXW7oAKL8b9LMYo
         qzcrdXswV2z7NjFusAf+puIr08OIzKq9aPfvvk8CYa/g9BxAbziEXGQdX81BUhRwLi1a
         dLfw==
X-Gm-Message-State: APjAAAUNrdrfo+HU9DdO2U2fxkjtycdWMyEt5jkapyGHWo2uxplrXO68
        7QlvOY6zWDQOfOzP7cWI9NG0UwgkMv0=
X-Google-Smtp-Source: APXvYqy4tc6P2+nygmsOqGJfB9eo6HqUsR8vGxUbBlbgvplUncOIIe+7IZNT2PiWIjXJFKm92yY20w==
X-Received: by 2002:a05:6512:146:: with SMTP id m6mr49469571lfo.90.1564345417598;
        Sun, 28 Jul 2019 13:23:37 -0700 (PDT)
Received: from localhost.localdomain (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id z17sm12395917ljc.37.2019.07.28.13.23.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jul 2019 13:23:37 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Denis Efremov <efremov@linux.com>, Michal Simek <monstr@monstr.eu>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] microblaze/PCI: Remove HAVE_ARCH_PCI_RESOURCE_TO_USER
Date:   Sun, 28 Jul 2019 23:22:10 +0300
Message-Id: <20190728202213.15550-3-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190728202213.15550-1-efremov@linux.com>
References: <20190728202213.15550-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The function pci_resource_to_user() was turned to a weak one. Thus,
microblase-specific version will automatically override the generic
one and the HAVE_ARCH_PCI_RESOURCE_TO_USER macro should be removed.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 arch/microblaze/include/asm/pci.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/microblaze/include/asm/pci.h b/arch/microblaze/include/asm/pci.h
index 21ddba9188b2..7c4dc5d85f53 100644
--- a/arch/microblaze/include/asm/pci.h
+++ b/arch/microblaze/include/asm/pci.h
@@ -66,8 +66,6 @@ extern pgprot_t	pci_phys_mem_access_prot(struct file *file,
 					 unsigned long size,
 					 pgprot_t prot);
 
-#define HAVE_ARCH_PCI_RESOURCE_TO_USER
-
 /* This part of code was originally in xilinx-pci.h */
 #ifdef CONFIG_PCI_XILINX
 extern void __init xilinx_pci_init(void);
-- 
2.21.0

