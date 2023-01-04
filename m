Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E80B65CE7B
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jan 2023 09:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234002AbjADImw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Jan 2023 03:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbjADImv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Jan 2023 03:42:51 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4676D18B08
        for <linux-pci@vger.kernel.org>; Wed,  4 Jan 2023 00:42:50 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id z16so15737634wrw.1
        for <linux-pci@vger.kernel.org>; Wed, 04 Jan 2023 00:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ibKGssGp1sbc8GhGpeNmx58bAzMOGgxSv1GDHJGCDHc=;
        b=ra3Yd1R4sD2fhDAXtEsvG9HJe+tQ8BJGflin9PA93clSP+jKlLI5EUulHaxlK3flNn
         YFZz0rLtBP3Nr/QL0MefDUgTw+fQrdWzEztCf7KcoBES5rCqPE1Ul7ECf4GVw6oK+IIk
         SHaR9x/2WyW++i8vbH7UmPjvuBMZCsYtUlKTO8kzZx29881wM4hXR8ZAhzMSgGAPmrdn
         ctMav3F3IyMI4LfaRsNZgYoa9m7sTwHUwiWVPJ6BqrvkJZrIsWRPkfZZ9dZ0HlpKuOTt
         eiQLzNe3tRUL0Gy6xqr18w2OPZbfSej5oCW9RNYhDREGR86kK9RqHtOCKDCaaVnn/7E2
         4D9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ibKGssGp1sbc8GhGpeNmx58bAzMOGgxSv1GDHJGCDHc=;
        b=1AmskfX37Zxx7g9jEjqGnE7Xxw2ncXVsmVhrf1ZmvgqIdwA9oqo7us8Ogsx0jhzLNX
         vxEh7K9q3rEYSqe3pYZFQksCNuuXNgD1i6nlko+lcAYZ1WHzurdME6N+SJYZ6f4/5hbj
         zHDh5ViKIj4PB/nMbnwHnUexmu23i7Cv6/+PamF/18p15CiYONLJnX3mWF1MXTOBulqT
         D9KoCBzF572OlY5u+fcqi4bBhUY3gJ9pqX7vKR2LiQNxUCzLoGh/fqWshkLhpl7Z/hmV
         T8vi72eaUgYTuJudV3hYklly0k5dpdWyNVUdW17gVVQljlfZiZ0zmJFNwq/fY2RPChfI
         SwiQ==
X-Gm-Message-State: AFqh2kpI3VBCorLPSawd5TjL1cFtAyhsxLy3zvZPsPlBs1n4JDMssBg9
        tql15mlcRyNwc2J/alKbY1kXXA==
X-Google-Smtp-Source: AMrXdXsBPSufr/J6ypoezVK29IjiorGCY754T3fzUItRvUasnwawLzmZR8NRsZuJkRuRNVIwcuOagA==
X-Received: by 2002:a5d:4406:0:b0:242:7248:fbe with SMTP id z6-20020a5d4406000000b0024272480fbemr29084029wrq.25.1672821768739;
        Wed, 04 Jan 2023 00:42:48 -0800 (PST)
Received: from localhost.localdomain (bzq-84-110-153-254.static-ip.bezeqint.net. [84.110.153.254])
        by smtp.gmail.com with ESMTPSA id j6-20020a056000124600b0029100e8dedasm13463343wrx.28.2023.01.04.00.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 00:42:47 -0800 (PST)
From:   Alvaro Karsz <alvaro.karsz@solid-run.com>
To:     virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org
Cc:     bhelgaas@google.com, mst@redhat.com,
        Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: [PATCH v2 1/3] PCI: Add SolidRun vendor ID
Date:   Wed,  4 Jan 2023 10:42:45 +0200
Message-Id: <20230104084245.3424347-1-alvaro.karsz@solid-run.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add SolidRun vendor ID to pci_ids.h

The vendor ID is used in 2 different source files,
the SNET vDPA driver and PCI quirks.

Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
--
v2:
	- Semantics fixes in commit log.
	- Move the vendor ID to the rigth place, sorted by vendor ID.
---
 include/linux/pci_ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index b362d90eb9b..9a3102e61db 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -3092,6 +3092,8 @@
 
 #define PCI_VENDOR_ID_3COM_2		0xa727
 
+#define PCI_VENDOR_ID_SOLIDRUN          0xd063
+
 #define PCI_VENDOR_ID_DIGIUM		0xd161
 #define PCI_DEVICE_ID_DIGIUM_HFC4S	0xb410
 
-- 
2.32.0

