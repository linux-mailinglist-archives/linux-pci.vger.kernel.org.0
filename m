Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88C86BD268
	for <lists+linux-pci@lfdr.de>; Thu, 16 Mar 2023 15:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjCPOcC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Mar 2023 10:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjCPOcC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Mar 2023 10:32:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407A7273D
        for <linux-pci@vger.kernel.org>; Thu, 16 Mar 2023 07:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678977088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=IUpF5YpfmKBEdpMgbmDi2tfoMcmDwV8UPq2EahjD2lk=;
        b=DHnGJfsl4GxAvqlRYZgEONvSFsQjYR4WKNDD2YodjEMzzFNi0SeVbD/Q1ZyD9CDFfq5RTz
        fUuu8I5hthMVHopFSQuhFjvyWMejyvdhrUYG72av5F/NFffapM0cRWoj8PqGH1MCMdtYGU
        UWMpvfYxzO39kqc9E774Ci7qANCuh8E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-u1YagfLrP5W91Yg2bVoVlw-1; Thu, 16 Mar 2023 10:31:27 -0400
X-MC-Unique: u1YagfLrP5W91Yg2bVoVlw-1
Received: by mail-wm1-f69.google.com with SMTP id fl22-20020a05600c0b9600b003ed26ca6206so2720469wmb.2
        for <linux-pci@vger.kernel.org>; Thu, 16 Mar 2023 07:31:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678977086;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IUpF5YpfmKBEdpMgbmDi2tfoMcmDwV8UPq2EahjD2lk=;
        b=0VPAKMbaqqlVg/Nnn4E4IVQWOt2QF6yTXROZhBaTtoEMS5cItPjpJWCLgHNCJ+zrev
         NqgLIYv8JQkW71A3Zqrhn5m7R7mZaMvQIudHV47tNsTzVfYoIcHai/zsturQ4As4Xmdx
         nXKf83wsQtA+jFMoHKDIAOqSrH2rPYu4bopcJ68Uz0aOtMAPBH/B0QmvMsT0erIW68GG
         JUZpCTXzkm4jBGQ0DtRBBQgzmyCz38PrB/ry/k1Q44aWCcaFk8lP4P+wkQzFDFutlExH
         qsxREWV9/XgBvmANC1Zc9MR2hV+Wc4KZt6//KL77vAMRjNm4zH86wAYXsurnYLohuOMy
         eUGg==
X-Gm-Message-State: AO0yUKW9vGUMeVNJCcTii6CL21gruy8WuIyBaAwQYALii/+BZZNzu6Ma
        WhOV6N5sPq7KcgZQGKBi/vjn4zp8Q2vGlwa121jvVI2btLEwsN7wfWHzXnbvpOyy8Shii5al+r6
        lQZG4Nl1ucUELgDEyVFSm
X-Received: by 2002:a05:600c:1d27:b0:3ed:2a41:8529 with SMTP id l39-20020a05600c1d2700b003ed2a418529mr2598329wms.2.1678977085984;
        Thu, 16 Mar 2023 07:31:25 -0700 (PDT)
X-Google-Smtp-Source: AK7set9ONATU/6Jrjx4MVUvm8TBfCFj8L6oolG4cHH5OfWe7GoRvRBF/xk+E8xlHDHoVUXeZJyfTVw==
X-Received: by 2002:a05:600c:1d27:b0:3ed:2a41:8529 with SMTP id l39-20020a05600c1d2700b003ed2a418529mr2598313wms.2.1678977085687;
        Thu, 16 Mar 2023 07:31:25 -0700 (PDT)
Received: from kherbst.pingu.com (ip1f1032bf.dynamic.kabel-deutschland.de. [31.16.50.191])
        by smtp.gmail.com with ESMTPSA id fk4-20020a05600c0cc400b003e0015c8618sm5145432wmb.6.2023.03.16.07.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 07:31:24 -0700 (PDT)
From:   Karol Herbst <kherbst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Karol Herbst <kherbst@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        nouveau@lists.freedesktop.org
Subject: [PATCH] PCI: stop spamming info in quirk_nvidia_hda
Date:   Thu, 16 Mar 2023 15:31:22 +0100
Message-Id: <20230316143122.2377354-1-kherbst@redhat.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Users kept complaining about those messages and it's a little spammy on
prime systems so turn it into a debug print.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org
Cc: nouveau@lists.freedesktop.org
Fixes: b516ea586d71 ("PCI: Enable NVIDIA HDA controllers")
Signed-off-by: Karol Herbst <kherbst@redhat.com>
---
 drivers/pci/quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 44cab813bf951..b10c77bbe4716 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5549,7 +5549,7 @@ static void quirk_nvidia_hda(struct pci_dev *gpu)
 	if (val & BIT(25))
 		return;
 
-	pci_info(gpu, "Enabling HDA controller\n");
+	pci_dbg(gpu, "Enabling HDA controller\n");
 	pci_write_config_dword(gpu, 0x488, val | BIT(25));
 
 	/* The GPU becomes a multi-function device when the HDA is enabled */
-- 
2.39.2

