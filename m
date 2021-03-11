Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50CAF33687F
	for <lists+linux-pci@lfdr.de>; Thu, 11 Mar 2021 01:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbhCKARm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Mar 2021 19:17:42 -0500
Received: from mail-lj1-f173.google.com ([209.85.208.173]:41001 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhCKAR3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Mar 2021 19:17:29 -0500
Received: by mail-lj1-f173.google.com with SMTP id t9so78777ljt.8
        for <linux-pci@vger.kernel.org>; Wed, 10 Mar 2021 16:17:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t2becTOHhnpDLLCNKLhd3Mi2zYpwApKxhajyRI9f9S8=;
        b=gtWKjygKo++thwZVfLY7pQjx+sAnIq/kuLbUH+G6rscQqV6MfeW32+nWBs7A6qbQ6c
         vUDAMHaqpWMHJSYaniONDdl7swSQuXH7iXVpKJu+hPUGDIiDWEpbPIgfcUJYyIip+g0v
         zmJs2ELHb0phStYWInf20TPtVyPAUjl1BfWwgZcky2caqvf4aDuk3EcxcZVhtIM3duh4
         4vns+iUA4SPj8HlGRiq2vW+sR2B5/1zn/N6LFx2wuD522gqJ2hQzvDkiifyJ/Q2wgXdY
         6pqf8PKspworb4zNhKP6ZjO/R/RM0pPL1UgjICNfoHX9d07lujRnv8iMhccggGOgKjJf
         RpFA==
X-Gm-Message-State: AOAM531rctbhvR4LdSEwq+3T4rqhsHfeT/VVsRyibOd+NX9e8WYK9pRp
        sjkZzNkp4bI9X9MirROV/5s=
X-Google-Smtp-Source: ABdhPJybTgPwdtEY8gmUe1zneRabsnGbJ8sgmMsqJoqrHDxq9e9lOAXOO6q1ag3LE0xiKR3gDpcNGQ==
X-Received: by 2002:a2e:8111:: with SMTP id d17mr3202656ljg.337.1615421848459;
        Wed, 10 Mar 2021 16:17:28 -0800 (PST)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id y186sm269332lfc.304.2021.03.10.16.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 16:17:28 -0800 (PST)
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
Subject: [PATCH 3/8] PCI/PME: Update function name in the kernel-doc
Date:   Thu, 11 Mar 2021 00:17:19 +0000
Message-Id: <20210311001724.423356-3-kw@linux.com>
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
function pcie_pme_init(), and resolve build time warning related to
kernel-doc:

  drivers/pci/pcie/pme.c:469: warning: expecting prototype for
  pcie_pme_service_init(). Prototype was for pcie_pme_init() instead

No change to functionality intended.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/pcie/pme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
index 3fc08488d65f..1d0dd77fed3a 100644
--- a/drivers/pci/pcie/pme.c
+++ b/drivers/pci/pcie/pme.c
@@ -463,7 +463,7 @@ static struct pcie_port_service_driver pcie_pme_driver = {
 };
 
 /**
- * pcie_pme_service_init - Register the PCIe PME service driver.
+ * pcie_pme_init - Register the PCIe PME service driver.
  */
 int __init pcie_pme_init(void)
 {
-- 
2.30.1

