Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2002989230
	for <lists+linux-pci@lfdr.de>; Sun, 11 Aug 2019 17:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfHKPIx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 11 Aug 2019 11:08:53 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39674 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfHKPIx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Aug 2019 11:08:53 -0400
Received: by mail-wm1-f68.google.com with SMTP id u25so9616438wmc.4;
        Sun, 11 Aug 2019 08:08:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3BYnAF3fY6hZ3+LPNhPGX5fxT42mNry1jIwD9JVWWfw=;
        b=p/TS87t2uY9d4isHZh9fQtc5oKB1LtHY8t+HBDAoexjLfVBpt6bd5/+MsYGzVXyNog
         mhyjnoOF51PAlWHQRpOcMk8AgaWOTsOUr87ja/d7b25YrtbvPv8PzbnbxH0itIrfq+Bi
         uKWJIUOE8mzjaNvlqqO23TU1jpe2+A7mxwqFLN0BvXeoAP5hM4Paf7OgCF+XMV0Qwp24
         P9zkUeocGt0rodSZm/7jjP05zLT2AaAwi5//1FdjfiWONGDf/nH4DK2aFJWEmeT7zTgr
         pUxbkYdU3umZHDmH7ng5ngIrD5u6TsapjPr8HsIxo3JKWP90D/XEvUKFdhkV6zsYUrfR
         OUjQ==
X-Gm-Message-State: APjAAAVakGJKhd5nOyKNTxtQEnn3Ro07u43/E+Ei9KEsAXVPaI8gKHJQ
        xZ0kLKR9B4Nx4lgpyXpVn4E=
X-Google-Smtp-Source: APXvYqwc8f96jo0z4WSjTuSnCue4cUUPxmdy0KXgwVIooKuJdShIIQeZTtsOo5EQUL/2J5tNNfDdbg==
X-Received: by 2002:a1c:2581:: with SMTP id l123mr15817858wml.10.1565536131207;
        Sun, 11 Aug 2019 08:08:51 -0700 (PDT)
Received: from localhost.localdomain (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id y16sm227049408wrg.85.2019.08.11.08.08.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 08:08:50 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Denis Efremov <efremov@linux.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] x86/PCI: Use PCI_STD_NUM_BARS in loops instead of PCI_STD_RESOURCE_END
Date:   Sun, 11 Aug 2019 18:07:58 +0300
Message-Id: <20190811150802.2418-4-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190811150802.2418-1-efremov@linux.com>
References: <20190811150802.2418-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch refactors the loop condition scheme from
'i <= PCI_STD_RESOURCE_END' to 'i < PCI_STD_NUM_BARS'.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 arch/x86/pci/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index 9acab6ac28f5..1e59df041456 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -135,7 +135,7 @@ static void pcibios_fixup_device_resources(struct pci_dev *dev)
 		* resource so the kernel doesn't attempt to assign
 		* it later on in pci_assign_unassigned_resources
 		*/
-		for (bar = 0; bar <= PCI_STD_RESOURCE_END; bar++) {
+		for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
 			bar_r = &dev->resource[bar];
 			if (bar_r->start == 0 && bar_r->end != 0) {
 				bar_r->flags = 0;
-- 
2.21.0

