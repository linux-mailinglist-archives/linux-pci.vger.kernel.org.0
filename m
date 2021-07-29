Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3880A3DB000
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jul 2021 01:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235181AbhG2XlO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jul 2021 19:41:14 -0400
Received: from mail-pj1-f51.google.com ([209.85.216.51]:54972 "EHLO
        mail-pj1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbhG2XlO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jul 2021 19:41:14 -0400
Received: by mail-pj1-f51.google.com with SMTP id b6so12504522pji.4
        for <linux-pci@vger.kernel.org>; Thu, 29 Jul 2021 16:41:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P3K18C89hIZPoek7GLHXlQrAl8c1dvgUPX/lpdSvEYs=;
        b=awxHQWHq27CTggwpzot8GQy4Ux7b81IKhMI8lZil6ficwYf1vye7D+vKBrOhD/O//o
         ogo9O1Cvyesj+X4svEhhD2RJt1YKZilg4UR0VUaTIuMsWEYv+gSgEDWVPz2zhTALA0u3
         7NPyQf00zTTpQBjFPsiWO89BWZNlu/mB8VsBKNgkC8ylsUWJ3CbcG4lRCeBbGD0uZZAc
         +jY6mgiBHaONZrRT6RXvXKNhsq2ZT5bW8v6sQrFgwoEPDwQkVtn30EpgNNSyxytsU7FK
         y4b+Bdo4NzqC32Pkv5AMFySze8pMVMzcuw/P/gUGMEZY/amUA2hFgtShv1f8/obXiZBg
         vwFQ==
X-Gm-Message-State: AOAM530cYMthKtTxj/amzEpIRJOtk9rY4gvSBpdx8BB5aGHx1YqF0o0Y
        ORVpSXZrzSjasifzeie1AZw=
X-Google-Smtp-Source: ABdhPJwdIBffBEGFUr0pY7cdwec/T39RG6EgKQj3GdlLDqmzUsLuHtRHgfrI4Z5I56ofdMq6J+4wUQ==
X-Received: by 2002:a63:f501:: with SMTP id w1mr5905017pgh.57.1627602070160;
        Thu, 29 Jul 2021 16:41:10 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id j13sm5298966pgp.29.2021.07.29.16.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 16:41:09 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH] x86/pci: Add missing forward declaration for pci_numachip_init()
Date:   Thu, 29 Jul 2021 23:40:59 +0000
Message-Id: <20210729234059.1509820-1-kw@linux.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

At the moment, the function pci_numachip_init() is defined in the
numachip.c file.  Since this function has users outside of this file,
add missing foward declaration to the pci_x86.h file.

This resolves the following sparse and compile time warning:

  arch/x86/pci/numachip.c:108:12: warning: no previous prototype for function 'pci_numachip_init' [-Wmissing-prototypes]
  arch/x86/pci/numachip.c:108:12: warning: symbol 'pci_numachip_init' was not declared. Should it be static?

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 arch/x86/include/asm/pci_x86.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
index 490411dba438..906f40cae3fc 100644
--- a/arch/x86/include/asm/pci_x86.h
+++ b/arch/x86/include/asm/pci_x86.h
@@ -50,6 +50,10 @@ enum pci_bf_sort_state {
 	pci_dmi_bf,
 };
 
+/* numachip.c */
+
+int pci_numachip_init(void);
+
 /* pci-i386.c */
 
 void pcibios_resource_survey(void);
-- 
2.32.0

