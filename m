Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 457597817B
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2019 22:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfG1UXx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 28 Jul 2019 16:23:53 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45541 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfG1UXw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 28 Jul 2019 16:23:52 -0400
Received: by mail-lj1-f196.google.com with SMTP id m23so56400472lje.12;
        Sun, 28 Jul 2019 13:23:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m1dkv1fL9t+ahIakB73GOcwrhvmXWbJ2pT65iz/Psl0=;
        b=N924Cf3+3Xbl8ncBrnWEXZOGj26qk1w0p2v8WD7uD3ESAM3wnz3+lIjB5ewaJuRFXi
         vkMoNtl5NlCpvnj7ZKnAsTAKVwnwAKnJDFsvaI3/nmvBfkFAeRHFUhfeOLiEaVwT44AZ
         p3cKLX9Sty2hJyoCU8NmsVTdYaZ5Xlg0kB9VOYcsehBNwsyqcI8RrYK66qSwf9ZkgHTQ
         URD/Lj0nmUxAObL45PqwNJlvnuMfhFkJd3tFlraH9QCq9TvyiCT0GFOSZOD4Gs2HZpOl
         hru/HW1bjeJEbm/mA4pvFZbKL9X6KwcbAGL1q+oG6l95xj8tBHSNW9nsJJzhD3TIq1K4
         6PhQ==
X-Gm-Message-State: APjAAAV7IggEfEcvmuFPH5SP7lFl0i7y4PWZEHnm0eHPPXSDGVzpQ2/+
        Q8mFGaJs0tgJFEWemvG85Ss=
X-Google-Smtp-Source: APXvYqwhfdoAmC6IiLBsYN6c2rcVP4rf0o/sF/FOKJ7n1U+e3SCfMTsC8NubRRj+XXAvVAzPK/LzGA==
X-Received: by 2002:a05:651c:1105:: with SMTP id d5mr11872101ljo.161.1564345430539;
        Sun, 28 Jul 2019 13:23:50 -0700 (PDT)
Received: from localhost.localdomain (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id z17sm12395917ljc.37.2019.07.28.13.23.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jul 2019 13:23:50 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Denis Efremov <efremov@linux.com>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] spark/PCI: Remove HAVE_ARCH_PCI_RESOURCE_TO_USER
Date:   Sun, 28 Jul 2019 23:22:13 +0300
Message-Id: <20190728202213.15550-6-efremov@linux.com>
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
spark-specific version will automatically override the generic one
and the HAVE_ARCH_PCI_RESOURCE_TO_USER macro should be removed.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 arch/sparc/include/asm/pci.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/sparc/include/asm/pci.h b/arch/sparc/include/asm/pci.h
index cfec79bb1831..4deddf430e5d 100644
--- a/arch/sparc/include/asm/pci.h
+++ b/arch/sparc/include/asm/pci.h
@@ -38,8 +38,6 @@ static inline int pci_proc_domain(struct pci_bus *bus)
 #define arch_can_pci_mmap_io()	1
 #define HAVE_ARCH_PCI_GET_UNMAPPED_AREA
 #define get_pci_unmapped_area get_fb_unmapped_area
-
-#define HAVE_ARCH_PCI_RESOURCE_TO_USER
 #endif /* CONFIG_SPARC64 */
 
 #if defined(CONFIG_SPARC64) || defined(CONFIG_LEON_PCI)
-- 
2.21.0

