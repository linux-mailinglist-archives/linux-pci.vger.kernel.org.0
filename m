Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FED94F5BCE
	for <lists+linux-pci@lfdr.de>; Wed,  6 Apr 2022 13:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbiDFKtp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Apr 2022 06:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359118AbiDFKsX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Apr 2022 06:48:23 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96755505E65
        for <linux-pci@vger.kernel.org>; Wed,  6 Apr 2022 00:12:18 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id bo5so1689308pfb.4
        for <linux-pci@vger.kernel.org>; Wed, 06 Apr 2022 00:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A1ZmQ0LEmR3OOKCT6LbGpsJN17JrWfuCp3spOBn+7ys=;
        b=imWh4RFwVhwV48pgB5H2Rk9lgcGiJab6/fGqHvtiXUfwCecaFw9d3PBd2m0v8TgPjF
         3MUi9AyWZq8oup4KtE202CWPc2OV4UgUv32ciSiHLRXPi+HsjYpMPo2n9gvKc/nX44hd
         UeqfcT6zSLJiuW+85EyQ6bvae5Q1jEaCn+KME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A1ZmQ0LEmR3OOKCT6LbGpsJN17JrWfuCp3spOBn+7ys=;
        b=fVHcUqKDUN5fmH4ghlyjp3UspHX9/op/iTxN3555kG2Gdrlyk1VaYaaReMaHyhaSnx
         N2SQDEXl3F/WCjEcmtnEK+rqRboMxxbXnqlajifIvGkA3TlkpcR/IzLPGLc1cQi0ldve
         vbsbEgfACWhySWKM0Z540haiQsLx8xerPHV9E9MV7R5Hhdn8I/yasEirpar6pPufXp8Q
         7Puz/W9FMp1lufcL8sg5XbSMOECxumFlc6LU/wlmRykH0mm6pFsXZnx7uGrFZUvl3GIR
         sM/9NfD0Fk1177652qOLo9JlFNlqwxGBHTKFbikcbOH+lL/nKou6KEqxN11DnePXFc1U
         agSg==
X-Gm-Message-State: AOAM5322SCcPQVc7savUOpNAHAwKk6gc1s8k1dN2k8SAdYUcxYBAPM5X
        vUfcV7yuP60Wgik/ArCAtklmniHRfiNvrQ==
X-Google-Smtp-Source: ABdhPJwVlccxYEcB9HkcJAYauOW/XtRZfeWCrlBKg8E7IQob9Y2pKkVaemr+VLJQZqmkw5oKOWTliA==
X-Received: by 2002:a05:6a00:1510:b0:4fa:f5fe:ffd5 with SMTP id q16-20020a056a00151000b004faf5feffd5mr7477279pfu.2.1649229137998;
        Wed, 06 Apr 2022 00:12:17 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:f953:ca90:a854:80ca])
        by smtp.gmail.com with UTF8SMTPSA id g6-20020a056a000b8600b004faa49add69sm17893931pfj.107.2022.04.06.00.12.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 00:12:17 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, David Stevens <stevensd@chromium.org>
Subject: [RFC] PCI: sysfs: add bypass for config read admin check
Date:   Wed,  6 Apr 2022 16:11:31 +0900
Message-Id: <20220406071131.2930035-1-stevensd@google.com>
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: David Stevens <stevensd@chromium.org>

Add a moduleparam that can be set to bypass the check that limits users
without CAP_SYS_ADMIN to only being able to read the first 64 bytes of
the config space. This allows systems without problematic hardware to be
configured to allow users without CAP_SYS_ADMIN to read PCI
capabilities.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 drivers/pci/pci-sysfs.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 602f0fb0b007..162423b3c052 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -28,10 +28,17 @@
 #include <linux/pm_runtime.h>
 #include <linux/msi.h>
 #include <linux/of.h>
+#include <linux/moduleparam.h>
 #include "pci.h"
 
 static int sysfs_initialized;	/* = 0 */
 
+static bool allow_unsafe_config_reads;
+module_param_named(allow_unsafe_config_reads,
+		   allow_unsafe_config_reads, bool, 0644);
+MODULE_PARM_DESC(allow_unsafe_config_reads,
+		 "Enable full read access to config space without CAP_SYS_ADMIN.");
+
 /* show configuration fields */
 #define pci_config_attr(field, format_string)				\
 static ssize_t								\
@@ -696,7 +703,8 @@ static ssize_t pci_read_config(struct file *filp, struct kobject *kobj,
 	u8 *data = (u8 *) buf;
 
 	/* Several chips lock up trying to read undefined config space */
-	if (file_ns_capable(filp, &init_user_ns, CAP_SYS_ADMIN))
+	if (allow_unsafe_config_reads ||
+	    file_ns_capable(filp, &init_user_ns, CAP_SYS_ADMIN))
 		size = dev->cfg_size;
 	else if (dev->hdr_type == PCI_HEADER_TYPE_CARDBUS)
 		size = 128;
-- 
2.35.1.1094.g7c7d902a7c-goog

