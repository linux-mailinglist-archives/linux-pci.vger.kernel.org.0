Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E06C378972
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2019 12:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbfG2KOn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Jul 2019 06:14:43 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33050 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfG2KOm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Jul 2019 06:14:42 -0400
Received: by mail-lf1-f65.google.com with SMTP id x3so41743056lfc.0;
        Mon, 29 Jul 2019 03:14:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yupETfqZ2IUSTjDe+bKCoxhzbaEilz49jRRnCpaPaiM=;
        b=cRhDn/dJ6vQDUryu5X8N4NmMOZdsdiaQJJSOI/HSMQ2CX8DX+npSOXrkzcyT+yeduk
         BX9OsM326pWxtYV9N5xneJlNZWuGBbtS9C7zTWbpfDro8iDGV2NZnRXDeNIl/HkSlsx7
         nFUMZmAgYT88R4HnXSfB4n4thoS7iBnCLTb9W4Zmk31c65Hufury6qIeIiTdPDsmFJJX
         YM/QOX9ocrGiShaXWfqCqAtBMZJRYP5EqrBiGTbnSilFKBbiQPOg9AgOQuEaVvSGTYfn
         +JgzdV04AfMZiX4jburVDZ8ufLr9d4fcfghppzFi4LqfSd/13CQZlA11l40hSZz0xGy3
         FOww==
X-Gm-Message-State: APjAAAWjr0L52nQY77Gc+/PbX7azTCDr1dVFEGH1zxEH/vt0gBHMZOpa
        vRuMrnfghdHDdugfyATMSs4=
X-Google-Smtp-Source: APXvYqyzEX7/b64Ts0QNiQTVUqAu+v61liDsTlqZmJcWAS2uOGiIQr2pUT55zRUw5B/wxq4tvZCIVg==
X-Received: by 2002:ac2:48a5:: with SMTP id u5mr52810601lfg.62.1564395279979;
        Mon, 29 Jul 2019 03:14:39 -0700 (PDT)
Received: from localhost.localdomain (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id y12sm11814834lfy.36.2019.07.29.03.14.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 03:14:39 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Denis Efremov <efremov@linux.com>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] sparc/PCI: Remove HAVE_ARCH_PCI_RESOURCE_TO_USER
Date:   Mon, 29 Jul 2019 13:14:01 +0300
Message-Id: <20190729101401.28068-6-efremov@linux.com>
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
sparc-specific version will automatically override the generic one
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

