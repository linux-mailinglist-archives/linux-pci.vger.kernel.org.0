Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71DB661F9D
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jan 2023 09:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjAIIFF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Jan 2023 03:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbjAIIFE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Jan 2023 03:05:04 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D1512084
        for <linux-pci@vger.kernel.org>; Mon,  9 Jan 2023 00:05:03 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id ja17so5638082wmb.3
        for <linux-pci@vger.kernel.org>; Mon, 09 Jan 2023 00:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FZEnByuYZvS4oCO1vsa+paT8I+UTZXQmFwyne1ALlrI=;
        b=BuJW0gQ8Gc5KrObkxInIyw9PuEH78Wd4O2dd2DrEKlw2s4KULrGCkmrTdJWfh+KpI/
         O9aZOpadf7+gOZ8iiaYxCu5Wlv90r/vGUMTGQhqGAhNNMYTdrEFeozk6o/6IB9X9Yxsr
         NjUESK+0q+bjcrT3MCv4xVjsuXZznuXbV2zWY7aa61pSApxfG/CHhzLmhUM5AOBHASnw
         udccYsgKbF1qVbLmIjVTfIBul5vJPQI3ew172d8ZAzYTe9OzIjYMLvNDUIloyoyarsy5
         2LOmvEeG8xF0aTOgtLIc6+H23jKIadnxH/RWhkleR5U+v9KJtpk4UzET0iduKSnQA03L
         O2CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FZEnByuYZvS4oCO1vsa+paT8I+UTZXQmFwyne1ALlrI=;
        b=ViwWJkImWgwkcfnDdhywyOZivWEdoEkAD/SmfXJ3i+JX6Y9ahi0VzoJE4Kf0ZZhDqe
         FuGyjtrKtjwJoVjcrg3SH8l1XniXtX+H/yHy+7Jj5+/p6y8lnGll1EjJ4vM1j9fnWoUn
         +Bc81XMRIQNSttLDdty+f7roqSewJimk+sE1W3SrgzOeI09a338XGTzlkDsX6JcWoFSG
         PInTKWJnbvfWYicUCCzhpIM+SAPLeKkFtpsZfoB3EB+XSl3E4lx4ZHQKcW+De+jr4ZmA
         SsdDTFtLZveLeRRuwX5Q5DumjB7hhoTGLT8BxfBnN4syu05CU52C3t8SzZfITQz3JIOe
         JU/g==
X-Gm-Message-State: AFqh2krUdRVmnlKAqxCjaMFDJIGJmwkhX2FpQpxr8S4FJDhTRjlUjjyZ
        /jlmE/UMclCVbFEixqxxAFVCjA==
X-Google-Smtp-Source: AMrXdXtlCLU9gB3jqVupm3Tx0U0gBBgA61YGRuQhR0b+lwt+fRT56ka/gWU6kCOroTd0tvZca3EUag==
X-Received: by 2002:a05:600c:3d8b:b0:3d9:f0d8:708c with SMTP id bi11-20020a05600c3d8b00b003d9f0d8708cmr1356882wmb.26.1673251501438;
        Mon, 09 Jan 2023 00:05:01 -0800 (PST)
Received: from localhost.localdomain (bzq-84-110-153-254.static-ip.bezeqint.net. [84.110.153.254])
        by smtp.gmail.com with ESMTPSA id h8-20020a05600c350800b003d990372dd5sm16361989wmq.20.2023.01.09.00.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 00:05:00 -0800 (PST)
From:   Alvaro Karsz <alvaro.karsz@solid-run.com>
To:     virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org
Cc:     bhelgaas@google.com, mst@redhat.com,
        Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: [PATCH v8 1/3] PCI: Add SolidRun vendor ID
Date:   Mon,  9 Jan 2023 10:04:53 +0200
Message-Id: <20230109080453.1155113-1-alvaro.karsz@solid-run.com>
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
