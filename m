Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01859417CD4
	for <lists+linux-pci@lfdr.de>; Fri, 24 Sep 2021 23:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348530AbhIXVNY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Sep 2021 17:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348458AbhIXVNW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Sep 2021 17:13:22 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA51C061613;
        Fri, 24 Sep 2021 14:11:48 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id w29so31101914wra.8;
        Fri, 24 Sep 2021 14:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rUTZvUNb/aRTjaMs08BG0O3uRLaU29RyM+PhYifid0Y=;
        b=pMUpUCMmarp0nIvy/TkK/WPQKudmfB/DVvWODbDkTzappLn5QaaHIheHmc4jfp8SgH
         7tj8S8kb/Q2x3uo1ey8ylSpwqj9VJOAQPAonbA2wA6adYLGY3B9iTnHHuxmxpZ0axNru
         Sb6mYWHYzPW6QQXTDfnwfnEkgmpyVjMUwnroPQ3ek8ofELcoje8ktQzgvL+pAyVKfAOG
         tCirQbmwG61xE8hFnZt88YE4AaGW6b+pL7BrpO6v+itKx9WmCTpxfOyKRLdSz9C1czwb
         oAqxMIexTN/QgGMRAdQGqqPPiNyPpSD7p7HCmHnhubxNL1c5vJx8E0xep9RMcMK7AyXq
         MdYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rUTZvUNb/aRTjaMs08BG0O3uRLaU29RyM+PhYifid0Y=;
        b=K/wOvj83ACAKZu05KchvjY7kWAnfSlpwg1PaWf4kvHNgQJyN6WOuxE6+GoXKjIB/KG
         kcXEt8XQbdTg4FDCcgBalv2fRrjssU1Q4EW8e5acs5RZP20Ce3U+dOqIlfwgjg+XePIh
         iXV2XQoe2tMo8Y8jmx/egg9vjQe+gdlStR2+0HZDZ09a4PjuM+jlZpvG0xFCiScy7QdZ
         Yrajr/oprabs7CurHAFwWzqXeMTyAxOVucqs9pUaFPGo23RVqrHfCj685bV12eQV6U3o
         njZ2nMpPSAkPVqWO43I0eO+e8Lwvmu1NwyxvDpi8vwCExqh0Y/yORpFltEKlsM/2h/zQ
         DEQQ==
X-Gm-Message-State: AOAM532jA6xLYHmLMeOYggtPLVndYmCIYaQCvngRgPjQUL5lrIeA5bYa
        KjhDTqNuhPg36v5MxCEPVQY=
X-Google-Smtp-Source: ABdhPJzobyLQ43Z6C9NxnIkf5NvAfYzc3Ak1ecVF83cMaXbnY8A9vPPzsvVBDCRpBlZUJjMdmLT6vw==
X-Received: by 2002:a1c:3b43:: with SMTP id i64mr4023029wma.170.1632517907585;
        Fri, 24 Sep 2021 14:11:47 -0700 (PDT)
Received: from localhost.localdomain (252.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.252])
        by smtp.gmail.com with ESMTPSA id y64sm10344297wmc.38.2021.09.24.14.11.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Sep 2021 14:11:47 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     tsbogend@alpha.franken.de
Cc:     robh@kernel.org, arnd@arndb.de, catalin.marinas@arm.com,
        Liviu.Dudau@arm.com, bhelgaas@google.com, matthias.bgg@gmail.com,
        gregkh@linuxfoundation.org, linux-mips@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-staging@lists.linux.dev,
        neil@brown.name, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] MIPS: implement architecture dependent 'pci_remap_iospace()'
Date:   Fri, 24 Sep 2021 23:11:38 +0200
Message-Id: <20210924211139.3477-6-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210924211139.3477-1-sergio.paracuellos@gmail.com>
References: <20210924211139.3477-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

To make PCI IO work we need to properly virtually map IO cpu physical address
and set this virtual address as the address of the first PCI IO port which
is set using function 'set_io_port_base()'.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 arch/mips/include/asm/pci.h | 2 ++
 arch/mips/pci/pci-generic.c | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/mips/include/asm/pci.h b/arch/mips/include/asm/pci.h
index 9ffc8192adae..35270984a5f0 100644
--- a/arch/mips/include/asm/pci.h
+++ b/arch/mips/include/asm/pci.h
@@ -20,6 +20,8 @@
 #include <linux/list.h>
 #include <linux/of.h>
 
+#define pci_remap_iospace pci_remap_iospace
+
 #ifdef CONFIG_PCI_DRIVERS_LEGACY
 
 /*
diff --git a/arch/mips/pci/pci-generic.c b/arch/mips/pci/pci-generic.c
index 95b00017886c..877ec9d6a614 100644
--- a/arch/mips/pci/pci-generic.c
+++ b/arch/mips/pci/pci-generic.c
@@ -46,3 +46,12 @@ void pcibios_fixup_bus(struct pci_bus *bus)
 {
 	pci_read_bridge_bases(bus);
 }
+
+int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
+{
+	size_t size = (res->end - res->start) + 1;
+	unsigned long vaddr = (unsigned long)ioremap(phys_addr, size);
+
+	set_io_port_base(vaddr);
+	return 0;
+}
-- 
2.25.1

