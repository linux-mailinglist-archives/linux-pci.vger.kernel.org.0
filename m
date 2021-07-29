Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEFB33DAFF4
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jul 2021 01:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235254AbhG2XiK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jul 2021 19:38:10 -0400
Received: from mail-pl1-f169.google.com ([209.85.214.169]:45866 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234448AbhG2XiK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jul 2021 19:38:10 -0400
Received: by mail-pl1-f169.google.com with SMTP id k1so8806013plt.12
        for <linux-pci@vger.kernel.org>; Thu, 29 Jul 2021 16:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y/JkeTo435+LRPpnF2QQ8YSozs7CUc/A/f0oWhjMXgM=;
        b=mzk+m44NPgzjUjo8awFeMnr7UTCzkgvt3MOnTZAAedxCJTLOWMRLqA62FMSf7WpGQy
         pNIQ9LeMenAc35TXdOhLE/6EUFgQlcg2OuhnuKOuNUhvbqYDv9WikraULAHgA9w3Ij1q
         YTyqQ3ZSHUqkhYOImLsmipaMjGvknlodZrQsvIi1BB+Bwe5PXidsHJ5zpbU9kKlzcIsW
         jzD2723SMpGPocDW39mfxZZSBWJtAXrbHme6K3mSvEdMtq7lXtZOFuSmXvoxzCRpBP/I
         3fvaqUuN6mWEsl0R4qbW80SwEhuZuqDRDnWhjBDY4YJPdlAHNtU597wGgM0aOIOmxAVH
         /YrQ==
X-Gm-Message-State: AOAM533s8+9+QbPYXJGwIJ/L5EICGchY/mllLs2u6dfzwsLhB6siXHrh
        zFSZlK/cjFjwjZvPxBduOr8=
X-Google-Smtp-Source: ABdhPJzZzutiYPljQVTbytPr5zrlPKiUvIkIlBDJR0S/W3LI0UZd8jD1koy/Hh49F8oOiXbWfgNyxw==
X-Received: by 2002:a17:90a:6a0e:: with SMTP id t14mr7906143pjj.19.1627601886585;
        Thu, 29 Jul 2021 16:38:06 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id k4sm4446831pjs.55.2021.07.29.16.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 16:38:06 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org
Subject: [PATCH 2/2] PCI: syscall: Change type of err variable from long to int
Date:   Thu, 29 Jul 2021 23:37:55 +0000
Message-Id: <20210729233755.1509616-2-kw@linux.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210729233755.1509616-1-kw@linux.com>
References: <20210729233755.1509616-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pciconfig_read syscall uses an err variable is currently declared as
long and even though it matches the function signature as generated by
the SYSCALL_DEFINEx() macro is a bit wasteful as the syscall returns
a handful of simple error codes.

Thus, change the err value type from long to int to lower the storage
requirements and also align it with the pciconfig_write syscall.

Related:
  commit ef9e4005cbaf ("PCI: Align checking of syscall user config accessors")

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/syscall.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/syscall.c b/drivers/pci/syscall.c
index b842af1e06b8..525f16caed1d 100644
--- a/drivers/pci/syscall.c
+++ b/drivers/pci/syscall.c
@@ -19,8 +19,7 @@ SYSCALL_DEFINE5(pciconfig_read, unsigned long, bus, unsigned long, dfn,
 	u8 byte;
 	u16 word;
 	u32 dword;
-	long err;
-	int cfg_ret;
+	int err, cfg_ret;
 
 	err = -EPERM;
 	if (!capable(CAP_SYS_ADMIN))
-- 
2.32.0

