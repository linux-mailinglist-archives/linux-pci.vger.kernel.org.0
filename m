Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5042C56B05B
	for <lists+linux-pci@lfdr.de>; Fri,  8 Jul 2022 04:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236471AbiGHCAs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jul 2022 22:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236795AbiGHCAr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jul 2022 22:00:47 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4289E73915;
        Thu,  7 Jul 2022 19:00:47 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id j1-20020a17090aeb0100b001ef777a7befso750791pjz.0;
        Thu, 07 Jul 2022 19:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pgC1QFTDMH7VG1LYr+f+vwb6dEfXUqMgnxyymooijHY=;
        b=cpsn9JGiE4udj8K1CtrlaipKdDUKyVQYX5KlzyqucWukzlbjAP8AAtQENjUeUE93jp
         UQ8eDAuydkRgc88FBG57m4hS15xXUPkSE+orSQsxvxqjw0NWxPlHsX/j4+zTmqUjxNTo
         uuH9BFBqg/EOe8Bc10bhddv2cZ3g0MM3EbHyjNROob/q0L//2RswNIuS2LlepNzLxsib
         wbqCuAmpj01F1LKQ00OHopQggT+Zs9mrulCmIAPXMco8YQwqKh/bC4G2WRzPcHhf6YYD
         6m5iR04Fd4nzvmWQG6g0M/uueXQdUupS/ytZZSfKfFTMxH6OJkav36lWplpk0QrBIqyC
         xpOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pgC1QFTDMH7VG1LYr+f+vwb6dEfXUqMgnxyymooijHY=;
        b=1LtJPAcLCWaeyhVtf4J6LR4CSDBjZAoyfgABJ77Pr81KSa5jWLmxcDa/DLJFtknRHt
         0vsJdTyyv7XOEVY7YC5fsdug8vhX8ZsNAUanLSbeYalSYcXqiLKk5mY7/3QkgpepXtd+
         ZXsu5+KbYf7uGPgvzvL4hBiupJTd12ZmXXUNiQMct8ai7+0CD7I2wcuTMpvJPYD7OjBk
         DdmKvfcXmVa4ZX4oF88tIOM9naYqh4lNah6eEapeBzD5go6RWet6m+4AXWhXWoLpqbim
         C/GOP/QTKH6CPaqIs7+8j331JQepskt5Tv+vIT5CLXDRhZsKwOnvMNygqAcEqCYV90+J
         7yGw==
X-Gm-Message-State: AJIora/gN4JmE8BR4kDs4rz5Yf74rOh19E0s3GgJONTt13M19lKrHCrj
        AHYFV5wvfOMo+dg9GSnDOz8=
X-Google-Smtp-Source: AGRyM1vo8M3KQC8yPgZ1Vt3TvHJSavgAGmE2XP++25rbWvZygTwBQelR1qdZQbnRQfIZIjtMUeamYw==
X-Received: by 2002:a17:90a:1485:b0:1ec:788e:a053 with SMTP id k5-20020a17090a148500b001ec788ea053mr1087299pja.16.1657245646795;
        Thu, 07 Jul 2022 19:00:46 -0700 (PDT)
Received: from localhost.localdomain ([122.162.197.95])
        by smtp.gmail.com with ESMTPSA id t29-20020a62d15d000000b0052897614bc6sm6396448pfl.10.2022.07.07.19.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 19:00:46 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     kishon@ti.com, lpieralisi@kernel.org, kw@linux.com,
        bhelgaas@google.com, jdmason@kudzu.us, Frank.Li@nxp.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] NTB: EPF: Mark pci_read and pci_write as static
Date:   Fri,  8 Jul 2022 07:30:35 +0530
Message-Id: <20220708020035.8071-1-jrdr.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>

kernel test robot throws below warning ->

drivers/pci/endpoint/functions/pci-epf-vntb.c:975:5: warning:
no previous prototype for 'pci_read' [-Wmissing-prototypes]
drivers/pci/endpoint/functions/pci-epf-vntb.c:984:5: warning:
no previous prototype for 'pci_write' [-Wmissing-prototypes]

mark them as static.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Souptick Joarder (HPE) <jrdr.linux@gmail.com>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index ebf7e243eefa..111568089d45 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -972,7 +972,7 @@ uint32_t pci_space[] = {
 	0,		//Max Lat, Min Gnt, interrupt pin, interrupt line
 };
 
-int pci_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val)
+static int pci_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val)
 {
 	if (devfn == 0) {
 		memcpy(val, ((uint8_t *)pci_space) + where, size);
@@ -981,7 +981,7 @@ int pci_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *
 	return -1;
 }
 
-int pci_write(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val)
+static int pci_write(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val)
 {
 	return 0;
 }
-- 
2.25.1

