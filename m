Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 153147896B
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2019 12:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbfG2KOg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Jul 2019 06:14:36 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36328 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfG2KOg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Jul 2019 06:14:36 -0400
Received: by mail-lf1-f66.google.com with SMTP id q26so41681835lfc.3;
        Mon, 29 Jul 2019 03:14:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TmxcCXhXwRYGEoMeDwlU1eEbMiMpwlUebLffY1+PjIY=;
        b=HWioYTFXekM3wEsxeMggM8LTqCjOmuGnAlfVYr28d1I9tseRen9NBlQZMwslqqYUGN
         wsYfLEy86WLXT2bccXqyh8ai35sVjLJ4JQNoOWg1NTcnFE9vEqJO01TjF4GgHQOh6Tw+
         ENNIO2resVRih8TY5U86Bi17JU5mtp2y9zsmykvCjcYzmIujDBANYYO/E3pCEOYlLG/r
         goa9eK+4Zh2mGLeDkep0PWEMbp3upTERBNWZCHDa0pQb90ER9qjywTWcOL1QAx/xurk2
         DLX5JX47sL5nYia1hDUDte4ruqH/hvbKDBc+M8ICDlTuZxBXwu5q1PKh1/L7s+6/0S3S
         MBqA==
X-Gm-Message-State: APjAAAV0GtM4fJVBJuZcOC7kMlaQUcKGPlIxdM7zxAue0TXeS8OeYvxA
        BwbeQEeVmb1GUzTJXP/cjUo=
X-Google-Smtp-Source: APXvYqw0Cu+Xf6R15+Xv9Wzlg3NjXnpW+b+moVSWt5i+0ri2j5GzuRv5Gxey0YhFLKx3hSjrMGvJKA==
X-Received: by 2002:ac2:4d1c:: with SMTP id r28mr49442744lfi.159.1564395274249;
        Mon, 29 Jul 2019 03:14:34 -0700 (PDT)
Received: from localhost.localdomain (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id y12sm11814834lfy.36.2019.07.29.03.14.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 03:14:33 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Denis Efremov <efremov@linux.com>, Michal Simek <monstr@monstr.eu>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] microblaze/PCI: Remove HAVE_ARCH_PCI_RESOURCE_TO_USER
Date:   Mon, 29 Jul 2019 13:13:58 +0300
Message-Id: <20190729101401.28068-3-efremov@linux.com>
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

