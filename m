Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2C6B3C853E
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jul 2021 15:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbhGNN1L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Jul 2021 09:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbhGNN1L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Jul 2021 09:27:11 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A208AC06175F;
        Wed, 14 Jul 2021 06:24:19 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id t9so2405268pgn.4;
        Wed, 14 Jul 2021 06:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MpnZuAZbCMOKMEatsZAK8Y5LMoNjSwV6AcaoXKKiInY=;
        b=mVexPQFTpgcXN+cSnUxlF8X8+lezKlCXKV5PIOPEjCZyrZW7Sb5marUrAv50Hvs8X6
         nkeyAlXLdPaMVz8MhRucXnuG53sduUibzltKg9pXG9xg1SIIoYglFEz+YeRmxQm1MUoq
         e6I/3NQWxX0WiOXk5eUxCvKXphecG7W5XMpAaKsGUznn01M5eaAsuRziUXjIe3sokReQ
         yShxM6NSVFmjMCwP8De2KtUr/+5CfZKLq4LpRdmBz2d0RkUewwe2HaLnr5PH/eWV5XVe
         jEhIA0kFpXx2c5qvPs8ZkXCxcXZ6bMr124OjtaX3ywFDv8GfZvLYY4Pgg/qx63mqxmm/
         fTUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MpnZuAZbCMOKMEatsZAK8Y5LMoNjSwV6AcaoXKKiInY=;
        b=k01lgiusN9VCqxEIbaevbto4KVmAvd2IjVoPc7PWD6qAMpbTmQY0DGlThXIZHf1hTu
         GdbxfnGmgAM1ZoqhHhTXPA3NgHxe+E01KrErE7JEwZ08FL7aaf4eCsOYA8O8hCuNtUSL
         J2m2EalMhQYgDLMyeRDhgsej/X5pOsR3fr42YHVc6pEG3krI5B9cNcxOYW98afcUcDrm
         28M/ogAUiR6GbRQRL54cJWitCqKQmKobUbJ6s9MogJ4MJR1JMNjcFKRagQ0NopMdedZH
         560cxJOgrfAnCTPvDDx1J5B/SrfL8jQiif52pYanK4xvH9ceZ9oEyCobwZn1/GPfjdsC
         4O1g==
X-Gm-Message-State: AOAM530zfMy0tGN6e8YW2gpI4auS/LRuFxHwgF6xDl5lQuuMfIn04nYc
        fypsIK94CiMcT7ohT7ybSw==
X-Google-Smtp-Source: ABdhPJyiRY03+Cyoo5h5GQHVwjyLKPK/nRsfU908t52MAocbJmK9HtlK/tZj6QdSAJu18vEoUm0wLA==
X-Received: by 2002:aa7:820d:0:b029:2f1:d22d:f21d with SMTP id k13-20020aa7820d0000b02902f1d22df21dmr10059594pfi.7.1626269058873;
        Wed, 14 Jul 2021 06:24:18 -0700 (PDT)
Received: from localhost.localdomain ([85.203.23.47])
        by smtp.gmail.com with ESMTPSA id w2sm2305161pjq.5.2021.07.14.06.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 06:24:18 -0700 (PDT)
From:   Shunyong Yang <yang.shunyong@gmail.com>
To:     bhelgaas@google.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
        kw@linux.com, leon@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shunyong Yang <yang.shunyong@gmail.com>
Subject: [PATCH v2] tools: PCI: Zero-initialize param
Date:   Wed, 14 Jul 2021 21:23:31 +0800
Message-Id: <20210714132331.5200-1-yang.shunyong@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The values in param may be random if they are not initialized, which
may cause use_dma flag set even when "-d" option is not provided
in command line. Initializing all members to 0 to solve this.

Signed-off-by: Shunyong Yang <yang.shunyong@gmail.com>
---
v2: Change {0} to {} as Leon Romanovsky's comment.
---
 tools/pci/pcitest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
index 0a1344c45213..441b54234635 100644
--- a/tools/pci/pcitest.c
+++ b/tools/pci/pcitest.c
@@ -40,7 +40,7 @@ struct pci_test {
 
 static int run_test(struct pci_test *test)
 {
-	struct pci_endpoint_test_xfer_param param;
+	struct pci_endpoint_test_xfer_param param = {};
 	int ret = -EINVAL;
 	int fd;
 
-- 
2.25.1

