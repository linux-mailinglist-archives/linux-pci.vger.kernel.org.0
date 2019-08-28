Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4A82A03C3
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 15:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfH1Nx1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 09:53:27 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53795 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfH1Nx0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2019 09:53:26 -0400
Received: by mail-wm1-f68.google.com with SMTP id 10so145750wmp.3;
        Wed, 28 Aug 2019 06:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=plD+U4OvjrYOKzQ6oSYh9TJp58BExko+i26dUsMFbeg=;
        b=Va6yPQwZ+88Bvnq4I3HEtLD3cD9u04oSgJCgRuznJEvMXVPKfJ7HkDxyRYJ55VNbR0
         UQ7vkk9bF0R+zmiLb0D4/V8YyLYkD2/soBEWfZxLzn2UyzZsr+IOjAGv7mc7C2E7UZgb
         eXCzjD+iU2yN/WLv1gSzaN7jCYD78pAz34IHdGYwWhzjVkIUryBqKxyjUU31QJjijfcy
         +OtVMP3r6nK509N+eJUkoQ+wcMvycU+mE3AqcdONpfm73bsvhxy1fGYBLQeVlKZwTXQC
         MCONnGZzLXV4/O5kIAeVT2O0pJU9o3qyJKn8Xl4ATKofhFTSSjpETwbOJ0ygMi3linXO
         Tb9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=plD+U4OvjrYOKzQ6oSYh9TJp58BExko+i26dUsMFbeg=;
        b=NNAi6Ez7J3Y39QzU7Vn6R96d8xl67HMDtfxenqiHxRDIR897bLuCP1243hYs3+afgJ
         3zp0Znmw5oJS0jGPFXp25mVNcdOJgWfQcR7fpnt7X0gTuFar9FTFCoYzVFJcz8Fz9NEe
         cPqQDE4K4McoplxlkyhPMNgAi4pKdSLWDVr6gatl5boNRly1Jw4FTrYqbrDtPz3eVvKB
         Yd3QzErDX8aMr5UyFc1n2DObWxU1RxcWNfMdgyk/h+ClJXNzkkkm+CP72h0NyQtCKjT8
         5wYGBdgEDmfVLNwiCbmp2H/aR2W3M8a1I+vj+IwpS3FVHdyOU6+5sTz7STeLmL4Gya3v
         0IrQ==
X-Gm-Message-State: APjAAAUK4jtwQRLfRYS/Zn956RynS5kyH9U68vEWvincEvWcT3jeE0Kv
        I70g7vLdVV/ErtuZcZJ7ZLnqYMgc1bM9Og==
X-Google-Smtp-Source: APXvYqzSIvLd0r1JejO7RzegjYLYXNJNBpoNkCrdhViUbUydhzpfXu5seZgNG09JGaJ5eQxktoFUpw==
X-Received: by 2002:a05:600c:48b:: with SMTP id d11mr5180877wme.55.1567000404508;
        Wed, 28 Aug 2019 06:53:24 -0700 (PDT)
Received: from localhost.localdomain (ip5b4096c3.dynamic.kabel-deutschland.de. [91.64.150.195])
        by smtp.gmail.com with ESMTPSA id f13sm624529wrq.3.2019.08.28.06.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 06:53:23 -0700 (PDT)
From:   Krzysztof Wilczynski <kw@linux.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Daniel J Blueman <daniel@numascale.com>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] x86/PCI: Correct warnings about missing or incorrect SPDX license headers.
Date:   Wed, 28 Aug 2019 15:53:22 +0200
Message-Id: <20190828135322.10370-1-kw@linux.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20190819060624.17305-1-kw@linux.com>
References: <20190819060624.17305-1-kw@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add the missing "SPDX-License-Identifier" license header
to the arch/x86/pci/numachip.c (use the GPL-2.0 identifier
derived using the comment mentioning license from the
top of the file), and remove license boilerplate as per
a similar commit 8cfab3cf63cf ("PCI: Add SPDX GPL-2.0 to
replace GPL v2 boilerplate").

Correct existing SPDX license header in the files
drivers/pci/controller/pcie-cadence.h and
drivers/pci/controller/pcie-rockchip.h to use
correct comment style as per the section 2 "Style"
of the "Linux kernel licensing rules" (see:
Documentation/process/license-rules.rst).

Both changes will resolve the following checkpatch.pl
script warning:

WARNING: Missing or malformed SPDX-License-Identifier tag in line 1

Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
---
Changes in v2:
  Update wording and mention checkpatch.pl script warnings.
  Add two C header files to which the fix also applies.

 arch/x86/pci/numachip.c                | 5 +----
 drivers/pci/controller/pcie-cadence.h  | 2 +-
 drivers/pci/controller/pcie-rockchip.h | 2 +-
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/pci/numachip.c b/arch/x86/pci/numachip.c
index 2e565e65c893..01a085d9135a 100644
--- a/arch/x86/pci/numachip.c
+++ b/arch/x86/pci/numachip.c
@@ -1,8 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
  * Numascale NumaConnect-specific PCI code
  *
  * Copyright (C) 2012 Numascale AS. All rights reserved.
diff --git a/drivers/pci/controller/pcie-cadence.h b/drivers/pci/controller/pcie-cadence.h
index ae6bf2a2b3d3..f1cba3931b99 100644
--- a/drivers/pci/controller/pcie-cadence.h
+++ b/drivers/pci/controller/pcie-cadence.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (c) 2017 Cadence
 // Cadence PCIe controller driver.
 // Author: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index 8e87a059ce73..53e4f9e59624 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Rockchip AXI PCIe controller driver
  *
-- 
2.22.1

