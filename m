Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5C6378976
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2019 12:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbfG2KOj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Jul 2019 06:14:39 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34429 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfG2KOj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Jul 2019 06:14:39 -0400
Received: by mail-lf1-f67.google.com with SMTP id b29so34404212lfq.1;
        Mon, 29 Jul 2019 03:14:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mhScrfvzfJHOaoJ1E3ndJMrRVW60NNkjG9R46Biny8M=;
        b=PQD+V2vmqKcBSfcY8EVrs38RSYxD5piYNtIZwlBCZHv/BVlbTXFrhOlTryU8OJA19O
         Lwvwgnoiz0Jv4+HJiarR+WD0ASmjg9lKsTDFhOdpGOjgGIzKUWu7SeIJTyoN2FEE6T8R
         YgL8hqxOomX67cljEdplzU1doZ209G4kbTek/zv8dQT//s/Ukm1wAF7R/v6v1eUqI/5g
         QivOwT0GWD9LjLSvXSXCXUNy1m/uqVP7Yzg0kkXVYeD/hmgCvDfRWBcGOzWg38BrCEv1
         nhO0UrKIPTjfsTrqmEBOX4FRjIOqawAbNZdJ4Nsb6CN52f012OE9VW7yU5Ny/maxUdGg
         OpeQ==
X-Gm-Message-State: APjAAAVsW1981ZuhwbG0x+E423ie5fKBMoYGqmA/Ep+YVVgWJJ4RXlIm
        3yh3P3Kqr7dG5Y/IKiZiuVw=
X-Google-Smtp-Source: APXvYqyFV/z2+4qtK/3ETW+F11Zp0K4FKj2kFJkLCRVUOtY6mp6T14WvUEmJPMKi1FbaBLxNl25GSw==
X-Received: by 2002:a19:f806:: with SMTP id a6mr37949567lff.102.1564395276889;
        Mon, 29 Jul 2019 03:14:36 -0700 (PDT)
Received: from localhost.localdomain (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id y12sm11814834lfy.36.2019.07.29.03.14.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 03:14:36 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Denis Efremov <efremov@linux.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] mips/PCI: Remove HAVE_ARCH_PCI_RESOURCE_TO_USER
Date:   Mon, 29 Jul 2019 13:13:59 +0300
Message-Id: <20190729101401.28068-4-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190729101401.28068-1-efremov@linux.com>
References: <20190729101401.28068-1-efremov@linux.com>
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

