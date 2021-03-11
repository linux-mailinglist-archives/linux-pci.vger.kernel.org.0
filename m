Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 415E033687D
	for <lists+linux-pci@lfdr.de>; Thu, 11 Mar 2021 01:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhCKARm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Mar 2021 19:17:42 -0500
Received: from mail-lf1-f52.google.com ([209.85.167.52]:40102 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbhCKARb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Mar 2021 19:17:31 -0500
Received: by mail-lf1-f52.google.com with SMTP id x4so30010271lfu.7
        for <linux-pci@vger.kernel.org>; Wed, 10 Mar 2021 16:17:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L8bwBr9Pfd7b8SAPZWvFQUsDlwPAHuolYwAQT4bOibQ=;
        b=Dm7dwV65ioG4NCX8/YqCA0ZdxYoCOC9R0kg96L1z4iYf5ya3GahdLb96EUQMpJs9zd
         +GMErUh2Nk5vLbpKhGr4Sa//8zI0g8iGA6gZ0iyApFcyb1O9t2QfDIPDCbd2lYpk083C
         VQAi9dyaWQaQ4/lp44S490zo/RZiODNwiz9tZZH+/pd87NC5R3+IKKYBT2EpcqTcOiTG
         dEvRvY3f6jR7u+SD4ZUt4P5fjEi0hvR4OtKQfPZLCP4KBhBs6PVU3bjPL657/1a3tq7X
         Iw+wXwTcV4QlYmYJCYuoV5m2ehSILXW/KujSFEmkmlo+TYvTmYTIa1mDxOoIHAArGWKJ
         Pfvg==
X-Gm-Message-State: AOAM533USzsRQ1v0zj5CgK38hYmIHAAV4RrU4C+N1vxjDrMqfT8WL0si
        CIJ1GZ4h7noXfN3vhoNR+kM=
X-Google-Smtp-Source: ABdhPJxkEx/i2KtS/JHTkPTMYxauMy0doB82djFET6ilyJnmCv1PoC6pODTjuBwIccgvuDm9EAQsBw==
X-Received: by 2002:a19:c3d5:: with SMTP id t204mr627041lff.216.1615421850708;
        Wed, 10 Mar 2021 16:17:30 -0800 (PST)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id y186sm269332lfc.304.2021.03.10.16.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 16:17:30 -0800 (PST)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Rob Herring <robh@kernel.org>,
        Russell Currey <ruscur@russell.cc>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Sean V Kelley <sean.v.kelley@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Jay Fang <f.fangjian@huawei.com>, linux-pci@vger.kernel.org
Subject: [PATCH 5/8] PCI: Update function name in the kernel-doc
Date:   Thu, 11 Mar 2021 00:17:21 +0000
Message-Id: <20210311001724.423356-5-kw@linux.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210311001724.423356-1-kw@linux.com>
References: <20210311001724.423356-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Update function name in the kernel-doc to match function prototype for
function acpi_pci_check_ejectable(), and resolve build time warning
related to kernel-doc:

  drivers/pci/hotplug/acpi_pcihp.c:167: warning: expecting prototype for
  acpi_pcihp_check_ejectable(). Prototype was for acpi_pci_check_ejectable()
  instead

No change to functionality intended.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/hotplug/acpi_pcihp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/acpi_pcihp.c b/drivers/pci/hotplug/acpi_pcihp.c
index 2750a64cecd3..4fedebf2f8c1 100644
--- a/drivers/pci/hotplug/acpi_pcihp.c
+++ b/drivers/pci/hotplug/acpi_pcihp.c
@@ -157,7 +157,7 @@ static int pcihp_is_ejectable(acpi_handle handle)
 }
 
 /**
- * acpi_pcihp_check_ejectable - check if handle is ejectable ACPI PCI slot
+ * acpi_pci_check_ejectable - check if handle is ejectable ACPI PCI slot
  * @pbus: the PCI bus of the PCI slot corresponding to 'handle'
  * @handle: ACPI handle to check
  *
-- 
2.30.1

