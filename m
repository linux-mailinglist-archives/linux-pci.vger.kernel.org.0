Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31FB53B50A8
	for <lists+linux-pci@lfdr.de>; Sun, 27 Jun 2021 02:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhF0AmX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 26 Jun 2021 20:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhF0AmW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 26 Jun 2021 20:42:22 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8861CC061574;
        Sat, 26 Jun 2021 17:39:59 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id y4so10764225pfi.9;
        Sat, 26 Jun 2021 17:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4jHYszcKubr0Ej2Ko8nc+ikN0GTCEvzz8hVq8Stfd/I=;
        b=ax31dI1KEc4BWk5NO/dQkCzOD6cllo7IZBubLurqyI35t/x/rUZ9Ex8wYBqwWo4OLb
         Bei77BZKd0DJo+ietUXFf+2ZEPYXaByHhc5r/W7j8sQuDhFcYEKeGSZNw6pDQQkkqPHa
         PQnaQtr21arXdVOKLXchV0u5aWjXHUEphyk0eLaSVLUCu9Zvvjv63kmc9fxG7buAa84B
         zAk7Mk+9IfcDoLOArLwitFgp/v5aY8zuB55AQBOICiv0ZwQ1c/ms6hBLXSErxxms8JgB
         uG9u9yM9igKI0WG1LSojEk+gL0sp3zaDCxoqh/7k2GNg/fgfIYaB+xDj/L2kWrLp5tE6
         MeUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4jHYszcKubr0Ej2Ko8nc+ikN0GTCEvzz8hVq8Stfd/I=;
        b=b/lf70AKgrt+QoPa/hD+78zPSVogPrVxZ+yxP4IsAz/EDjoe7GGk0pcIOuPOvMX3eZ
         BgDyyUHSY168Mh3rdVj13+oX6vJxugL3Dem6aWRuM359bxAjwXDUpcMjfJyyAY3Sr9jK
         JTVHBx3YiVOFaQySBr2zfP5dA3+TiWw5ACGayf7IXgoi/2akTG0AKe03ShdLCcPXUZAo
         e1bvfGFiubbYzzKgh2P/cxa5MLCP/H+AWbt+jHGqoIgcZqXGYa9BtaJODQcXMHTj0wnL
         DoA2d39d2DKJkga4g5Zn7MSCfK5QcY/dPzyhcc0Wets0KS2pFoi+1zBfpL/cZ4cKUaB7
         z+9g==
X-Gm-Message-State: AOAM530syOGLuvrX8ml+1rsTyESbGuO5tgdCJKPng4kV6ucwQmofufXB
        qwbRXU1OInMoxCddoLhL7Q==
X-Google-Smtp-Source: ABdhPJxSNrsgyfYE6zNRvBRAHsfqELt7Bqf4tA7zy545FDcoGCJgaazq9O1jUaAiXOW7r3Qr21YCrg==
X-Received: by 2002:a63:1a5b:: with SMTP id a27mr16765222pgm.427.1624754398247;
        Sat, 26 Jun 2021 17:39:58 -0700 (PDT)
Received: from localhost.localdomain ([154.16.166.176])
        by smtp.gmail.com with ESMTPSA id s9sm9738267pfm.120.2021.06.26.17.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jun 2021 17:39:57 -0700 (PDT)
From:   Shunyong Yang <yang.shunyong@gmail.com>
To:     kishon@ti.com, lorenzo.pieralisi@arm.com, kw@linux.com
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shunyong Yang <yang.shunyong@gmail.com>
Subject: [PATCH] tools: PCI: Zero-initialize param
Date:   Sun, 27 Jun 2021 08:39:37 +0800
Message-Id: <20210627003937.6249-1-yang.shunyong@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The values in param may be random if they are not initialized, which
may cause use_dma flag set even when "-d" option is not provided
in command line. Initializing all members to 0 to solve this.

Signed-off-by: Shunyong Yang <yang.shunyong@gmail.com>
---
 tools/pci/pcitest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
index 0a1344c45213..59bcd6220a58 100644
--- a/tools/pci/pcitest.c
+++ b/tools/pci/pcitest.c
@@ -40,7 +40,7 @@ struct pci_test {
 
 static int run_test(struct pci_test *test)
 {
-	struct pci_endpoint_test_xfer_param param;
+	struct pci_endpoint_test_xfer_param param = {0};
 	int ret = -EINVAL;
 	int fd;
 
-- 
2.17.1

