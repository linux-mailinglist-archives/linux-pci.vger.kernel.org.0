Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90F2E3EA94F
	for <lists+linux-pci@lfdr.de>; Thu, 12 Aug 2021 19:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234537AbhHLRRr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Aug 2021 13:17:47 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:54839 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234899AbhHLRRp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Aug 2021 13:17:45 -0400
Received: by mail-wm1-f52.google.com with SMTP id g138so5039875wmg.4
        for <linux-pci@vger.kernel.org>; Thu, 12 Aug 2021 10:17:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qi3OR67SAq3fUw8wqhj8a2q70c4e8cOFtASlxxpzWak=;
        b=tx7AC94Qwt0nac2ka3EZ0Z7G5+lBBOhrlmdieI6UtQatMvHMXooSYdt+HlTqo/UNsV
         /18vhOtIvqXPrp7VVQHPXzmewNiPkxF8dtxDlDYBDz/fxH5wfyX8DKjx+XLZqBXwZTvb
         ptAY8SUde84PHCChH6s82PVaMyP7BdYnNReQgToTuzjmxVOgiRpJG1INSYUZZaUA+3Hm
         TQ8VCJebNV77QGGPNC8QN/MSyYaTgxS2vKhVur0iYSg7IEpARpdClfK5Iqb4ChYO83C7
         S3bArDDyuKIJO2bNJUxahO9cmdpct7K0ERb9z89bAYIcZ0fGsh4nSuUNNsKDujmI8XLk
         lvrw==
X-Gm-Message-State: AOAM532B3cRE8hvq/YJbn/CWagv+snUAJL3brN+Ofh0efVuejnliamyV
        ChaXn4Puou0mITlKx/YQS0U=
X-Google-Smtp-Source: ABdhPJwNzAJpXOvs+ZZP/wImZb04nFbnh8y15+9hr4Rl9vLdbI65+1TYory+UqqoLdUNkg5ZSkGiHQ==
X-Received: by 2002:a1c:150:: with SMTP id 77mr5179271wmb.90.1628788639246;
        Thu, 12 Aug 2021 10:17:19 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id l9sm3499512wro.92.2021.08.12.10.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 10:17:18 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v2] x86/pci: Add missing forward declaration for pci_numachip_init()
Date:   Thu, 12 Aug 2021 17:17:17 +0000
Message-Id: <20210812171717.1471243-1-kw@linux.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

At the moment, the function pci_numachip_init() is defined in the
numachip.c file, but lacks matching forward declaration causing the
following sparse and compile time warnings:

  arch/x86/pci/numachip.c:108:12: warning: no previous prototype for function 'pci_numachip_init' [-Wmissing-prototypes]
  arch/x86/pci/numachip.c:108:12: warning: symbol 'pci_numachip_init' was not declared. Should it be static?

Thus, add missing include of asm/numachip/numachip.h that includes the
missing forward declaration.  This will resolve the aforementioned
warnings.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 arch/x86/pci/numachip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/pci/numachip.c b/arch/x86/pci/numachip.c
index 01a085d9135a..4f0147d4e225 100644
--- a/arch/x86/pci/numachip.c
+++ b/arch/x86/pci/numachip.c
@@ -12,6 +12,7 @@
 
 #include <linux/pci.h>
 #include <asm/pci_x86.h>
+#include <asm/numachip/numachip.h>
 
 static u8 limit __read_mostly;
 
-- 
2.32.0

