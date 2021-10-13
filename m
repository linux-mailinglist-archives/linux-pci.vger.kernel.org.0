Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C098142B0FD
	for <lists+linux-pci@lfdr.de>; Wed, 13 Oct 2021 02:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235064AbhJMAdu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Oct 2021 20:33:50 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:39758 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234237AbhJMAdu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Oct 2021 20:33:50 -0400
Received: by mail-wr1-f53.google.com with SMTP id r18so2440542wrg.6
        for <linux-pci@vger.kernel.org>; Tue, 12 Oct 2021 17:31:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t1YARcVMucevMKBi2klQIlXW4lDqN6tMjZ3AEQCVYt8=;
        b=k6OL8lh7BH5/beux0trxzIB5SxEne4li3YvBRZMP+Ip3YrGlCxWx2GSS0XARDbWwC8
         ftz06F2UypcLIxYi/PZPtWoPGGAPaXO3d5HZcws4ePATr7yHAwXFJ/29OKsU8G7IGctj
         bXqye5jbI2lFBZwZQqm9YMQhmjAE+QHYeJ17YeX1y6LBwPlsIsea0lAi3ilxsXgP+Api
         Wj55c8+JhJ95L0f3i16kvVeZBFHq4HRD59fbm5P80jQqxmruj0DQVF9S+sPARdA5cvNU
         45ez2hRQp3evhfspBK9/4xbi79GlYByUb4cdv695acRRoH7WlGKTXa4n6zRuWvKfCnI8
         NLxA==
X-Gm-Message-State: AOAM533P61vj67aQNW7gqHP14xA/haXnFO/BYbrHaccuZu20zbAfvC7c
        wmB55EY3Wl+sdTTHX7FKS4s=
X-Google-Smtp-Source: ABdhPJyHegGejRKZ7TdYO+bwRwqrwfJ92PZlnEtjmvg5RHJp6nS3k3unI67dzLDoZ1u8fedSzFLSSQ==
X-Received: by 2002:a05:600c:3393:: with SMTP id o19mr9386749wmp.66.1634085107016;
        Tue, 12 Oct 2021 17:31:47 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id a2sm12147516wru.82.2021.10.12.17.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 17:31:46 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH 1/2] PCI: vmd: Use preferred header files linux/device.h and linux/msi.h
Date:   Wed, 13 Oct 2021 00:31:44 +0000
Message-Id: <20211013003145.1107148-1-kw@linux.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use the preferred generic header files linux/device.h and linux/msi.h
that already include the corresponding asm/device.h and asm/msi.h files,
especially where the headers files linux/msi.h and asm/msi.h where both
included.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/controller/vmd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index a5987e52700e..9609eb911349 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -9,6 +9,7 @@
 #include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/device.h>
 #include <linux/msi.h>
 #include <linux/pci.h>
 #include <linux/pci-acpi.h>
@@ -18,8 +19,6 @@
 #include <linux/rcupdate.h>
 
 #include <asm/irqdomain.h>
-#include <asm/device.h>
-#include <asm/msi.h>
 
 #define VMD_CFGBAR	0
 #define VMD_MEMBAR1	2
-- 
2.33.0

