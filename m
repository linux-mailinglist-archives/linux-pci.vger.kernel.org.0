Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 857138FEEE
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2019 11:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbfHPJ0P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Aug 2019 05:26:15 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38356 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbfHPJ0P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Aug 2019 05:26:15 -0400
Received: by mail-wm1-f66.google.com with SMTP id m125so3508112wmm.3;
        Fri, 16 Aug 2019 02:26:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KXsrIoNvOcPMUtNmShEj3wf+mDCBfSR89zIxU2/p+Yg=;
        b=ZgiV/7j9bYI39v7P2L0AaPSYevwGRrGRSCmf6WofGoBQG8LauGVdn4OYSSZQLdagOv
         tVHtTOB22QwQxr5tXdLGwTIIhwvvCryQRPDnG/+6qoHHwBsXbEcnxCKar/4xJA6Wkdtk
         EY53kREPOd0QGmEV8qoIe+BQukWW6Yu7f35h4J/FZtgb3Not4iK4WOVxQ4XZhV9aD1OL
         RTa9BEeRLkS2nl74o5hCnbE3smUY4i9oRdqrPAI2Zg1/tBaXxT9YnsFoMfS6/wG2UREj
         wEo912kKFAIvTcycFiAcQ4A2qswSAtk38a+rBM5CfL9jGdT59Sj2PJv7SML4xLO0a6dm
         ysBQ==
X-Gm-Message-State: APjAAAUt4nKzZUnGG4GgTfZyPKXovrFq2OTitApYllNp0hxSvqHAySYe
        POrnN7kwo35WM3qTA4+P6u0=
X-Google-Smtp-Source: APXvYqxYf7RljwLr3IkqjenWAlZMEq5Ux5Hc488Jt0Y920RYCpAFdA0+1VkjuEtUcJ+lF5u3sXhkxg==
X-Received: by 2002:a1c:a584:: with SMTP id o126mr6446587wme.147.1565947573088;
        Fri, 16 Aug 2019 02:26:13 -0700 (PDT)
Received: from localhost.localdomain (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id q20sm16521138wrc.79.2019.08.16.02.26.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2019 02:26:12 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Denis Efremov <efremov@linux.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/10] x86/PCI: Loop using PCI_STD_NUM_BARS
Date:   Fri, 16 Aug 2019 12:24:30 +0300
Message-Id: <20190816092437.31846-4-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190816092437.31846-1-efremov@linux.com>
References: <20190816092437.31846-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Refactor loops to use 'i < PCI_STD_NUM_BARS' instead of
'i <= PCI_STD_RESOURCE_END'.

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

