Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88F7342B1E3
	for <lists+linux-pci@lfdr.de>; Wed, 13 Oct 2021 03:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235271AbhJMBQS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Oct 2021 21:16:18 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:46814 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233371AbhJMBQR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Oct 2021 21:16:17 -0400
Received: by mail-lf1-f41.google.com with SMTP id i24so4174885lfj.13
        for <linux-pci@vger.kernel.org>; Tue, 12 Oct 2021 18:14:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vVhLOeILl0ueBtj/XaMQtGA78s7pXK4nt3NOyI7EX+U=;
        b=3JHhtab0gNZvXyreAeM+9fK/1u2r3WC5NkOjs0fH/q9rxmDHPnsgetZPGTLm3k9O66
         tUHJ794ExCqRE8dVjIxDoTfcib73bP+/4IiAtaT7T/dxAqKsWStKJ0qsjja+OOVO0RTn
         P/aHR++CZlhahREmeNqscPtzfhgOFsMeF6NUqk8jj2o8R48lcypglr1oO6NsA8Xxxc0e
         NP4v+jdZrvaRmhYkV6m7rR5oMYlCbvKfMUtFBuZ7VqLkPk/oOSFqtgEVhDsfZai/Q6Xw
         Syth4MLyt7WZsB31x4qQ1qd1J09K7y7SCIY+Zj2PR5nf1TJIREot9SrpmsJQUk4JZheM
         jPaw==
X-Gm-Message-State: AOAM533HILQQKpBVXFzKjgejcvEoy8BY7U3YKd0d6BTw6fXDPkGI1P9c
        TvcBOyUtycNQzl851xd7/Rg/V2CMyRc=
X-Google-Smtp-Source: ABdhPJzO4oVHsNA0jPLehh4fvYTxY8se0Jxhrg04fnf5nYyLuQGUlCQE12emjAfd7DK6+8FiaE8E4A==
X-Received: by 2002:a05:6512:3e02:: with SMTP id i2mr36425585lfv.163.1634087654276;
        Tue, 12 Oct 2021 18:14:14 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id k16sm1173144lfo.219.2021.10.12.18.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 18:14:13 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org
Subject: [PATCH] PCI: cpqphp: Format if-statement code block correctly
Date:   Wed, 13 Oct 2021 01:14:12 +0000
Message-Id: <20211013011412.1110829-1-kw@linux.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The if-statement code block as seen in the cpqhp_s

The code block related to the if-statement in cpqhp_set_irq() is
somewhat awkwardly formatted making the code hard to read.

Thus, update the code to match preferred code formatting style.

No change to functionality intended.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/hotplug/cpqphp_pci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/cpqphp_pci.c b/drivers/pci/hotplug/cpqphp_pci.c
index 1b2b3f3b648b..9038039ad6db 100644
--- a/drivers/pci/hotplug/cpqphp_pci.c
+++ b/drivers/pci/hotplug/cpqphp_pci.c
@@ -189,8 +189,10 @@ int cpqhp_set_irq(u8 bus_num, u8 dev_num, u8 int_pin, u8 irq_num)
 		/* This should only be for x86 as it sets the Edge Level
 		 * Control Register
 		 */
-		outb((u8) (temp_word & 0xFF), 0x4d0); outb((u8) ((temp_word &
-		0xFF00) >> 8), 0x4d1); rc = 0; }
+		outb((u8)(temp_word & 0xFF), 0x4d0);
+		outb((u8)((temp_word & 0xFF00) >> 8), 0x4d1);
+		rc = 0;
+	}
 
 	return rc;
 }
-- 
2.33.0

