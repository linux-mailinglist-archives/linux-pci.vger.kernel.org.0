Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0F6C78177
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2019 22:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfG1UXq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 28 Jul 2019 16:23:46 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37032 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfG1UXq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 28 Jul 2019 16:23:46 -0400
Received: by mail-lj1-f193.google.com with SMTP id z28so2220094ljn.4;
        Sun, 28 Jul 2019 13:23:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mhScrfvzfJHOaoJ1E3ndJMrRVW60NNkjG9R46Biny8M=;
        b=fF/FQdQ9xKIHaxOeRyQg02ZFBRSbODaQ0vz5FilulUrA04s8L0pObp5WwiLfAwzmhq
         91ZSO71QJe/4d8GJVBb5IcJJGb9MgG6J1sBlfIe/bojjAe3bLfPj4dYgRrVjxHVUNDLn
         kRmKXTGEESa3e9iRtUl1fKYDMztcaVxLDN3q2jYPfNotx4u2wtPqqU/NCdLMEKbNEndZ
         0FulmPzMw9mjYa9Oaym710dXqle0l7vuRHYW10OHDPu9OE40IFKow0bHU7CK6IAy5X1g
         aDJuER9EgKKgcTAK4C+T/7GmwA96QZb2uEnZeITdQgFTzfaQVkmPwZ/6t9jLtWcnN0JF
         +2XA==
X-Gm-Message-State: APjAAAWuDOoKqDCQBMYZ3UpAxvhBmaJcOHbyUnrbKUuf3fyXp97ZTo32
        4bEQNF2A4d+kv7JOXHxDv0M=
X-Google-Smtp-Source: APXvYqyV1b8TXU6HxTOLiYBaGSCR3P+vLbqv4kmmZNGnZWYQLhF2jZROOmBKr1QIOxMTOl4u9lCHeQ==
X-Received: by 2002:a2e:9dd7:: with SMTP id x23mr57267840ljj.160.1564345423752;
        Sun, 28 Jul 2019 13:23:43 -0700 (PDT)
Received: from localhost.localdomain (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id z17sm12395917ljc.37.2019.07.28.13.23.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jul 2019 13:23:43 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Denis Efremov <efremov@linux.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] mips/PCI: Remove HAVE_ARCH_PCI_RESOURCE_TO_USER
Date:   Sun, 28 Jul 2019 23:22:11 +0300
Message-Id: <20190728202213.15550-4-efremov@linux.com>
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
mips-specific version will automatically override the generic one
and the HAVE_ARCH_PCI_RESOURCE_TO_USER macro should be removed.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 arch/mips/include/asm/pci.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/include/asm/pci.h b/arch/mips/include/asm/pci.h
index 436099883022..6f48649201c5 100644
--- a/arch/mips/include/asm/pci.h
+++ b/arch/mips/include/asm/pci.h
@@ -108,7 +108,6 @@ extern unsigned long PCIBIOS_MIN_MEM;
 
 #define HAVE_PCI_MMAP
 #define ARCH_GENERIC_PCI_MMAP_RESOURCE
-#define HAVE_ARCH_PCI_RESOURCE_TO_USER
 
 /*
  * Dynamic DMA mapping stuff.
-- 
2.21.0

