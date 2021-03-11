Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E7B336884
	for <lists+linux-pci@lfdr.de>; Thu, 11 Mar 2021 01:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhCKARm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Mar 2021 19:17:42 -0500
Received: from mail-lj1-f179.google.com ([209.85.208.179]:37107 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhCKARd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Mar 2021 19:17:33 -0500
Received: by mail-lj1-f179.google.com with SMTP id q14so98058ljp.4
        for <linux-pci@vger.kernel.org>; Wed, 10 Mar 2021 16:17:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vnLOt3JRC/SV3REFag8843NSfHwLc7oxyVUfV6PrzHM=;
        b=WeMiqQDfKR1yUr0ES5PlWpN+rOFCCh05ChzAgryPNPEAtR7gFH15BM0lhEWvGGp6si
         jgsRRsQf0DVF66ZEELhB9dOcSkOjo5JnHXrWgiSDMh5zuddNFobPVcBN3xBEUGEGyV4M
         s8R3ooTR4ksoRAW5h1vaGVarqaBaX1DYt+Xz8yvwC7l5vWdmdRuV2Z6XDhbihEma9cpS
         XgZLdCYhRn7t8t/vsmZ6jeGLxrdon0NGV3ivjyVSwmjL9pQOjKZRHaNpj/Va/TSHg2b/
         67D1DAHXtSEYvE2NVOum6YeKrFb/I+HxtlnZy5Ql+3uVBzrYIcrFcJ7qC1hfm8OP/EOV
         sRbA==
X-Gm-Message-State: AOAM531ZPT7nLYtVnFg1qZuFsJkKOSaRhg+5ctPsfSEvqi1yykMVhx5H
        00qtX2vXqE8wvg8J8ecV1so=
X-Google-Smtp-Source: ABdhPJykC9/y545ja/Zr//caW9YiUhWkHvAYeZMoPTHa4mtNr9dZecRkoscyaLby/GrivZlNfYVAgQ==
X-Received: by 2002:a05:651c:387:: with SMTP id e7mr3311183ljp.425.1615421851890;
        Wed, 10 Mar 2021 16:17:31 -0800 (PST)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id y186sm269332lfc.304.2021.03.10.16.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 16:17:31 -0800 (PST)
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
Subject: [PATCH 6/8] PCI: j721e: Fix a non-compliant kernel-doc
Date:   Thu, 11 Mar 2021 00:17:22 +0000
Message-Id: <20210311001724.423356-6-kw@linux.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210311001724.423356-1-kw@linux.com>
References: <20210311001724.423356-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Correct a non-compliant kernel-doc at the top of the pci-j721e.c file,
and resolve build time warning related to kernel-doc:

  drivers/pci/controller/cadence/pci-j721e.c:25: warning: expecting
  prototype for pci(). Prototype was for ENABLE_REG_SYS_2() instead

No change to functionality intended.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/controller/cadence/pci-j721e.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 849f1e416ea5..f1eef67e9526 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/**
+/*
  * pci-j721e - PCIe controller driver for TI's J721E SoCs
  *
  * Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com
-- 
2.30.1

