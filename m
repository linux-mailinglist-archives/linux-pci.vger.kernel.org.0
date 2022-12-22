Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8956F653C7F
	for <lists+linux-pci@lfdr.de>; Thu, 22 Dec 2022 08:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234880AbiLVH0K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Dec 2022 02:26:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiLVH0I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Dec 2022 02:26:08 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A8538B4;
        Wed, 21 Dec 2022 23:26:07 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id x66so650596pfx.3;
        Wed, 21 Dec 2022 23:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C1M6sI8nGjn1AQZW7MjYI4O6nfdLnBf5J3+wPQ6ghb0=;
        b=KZRpJQE2dMcoZOUADI+9CK3UIfA+yeOJRhVV06WaoBzBZFtg5CdZP5hSE68WLOOdXm
         rG8tFq14LpuMpsAzqBqXWMdbGZYMyGIQka9dtDTu9Z0iNl1g7AiYDphbg44aUydjiiaS
         TuK6DrJjGI1cOwkQxLoSaKogyEP3yeyP+rasQspiBvXFLV8sNUIRPw7oj6UtTpLhfUV6
         7xz/qHNDbXb8f2Zqsoz+dIcgYoWolASTcAcCD70/oNGbes+I0+4ZkgcXp+k9QUtqaAUC
         NyLYQmrC52cU6+XUGtmFw5AxyCxtKkWHiAUMIQXHDjVZZb2Z4YPqvLKlXoylD3mbxDCh
         OgJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C1M6sI8nGjn1AQZW7MjYI4O6nfdLnBf5J3+wPQ6ghb0=;
        b=13v8N6MhXyuD7XNvmql05xK8xp49um2Fe+wFzsCpFkHwRl2WTl7sbCCeM1IvCZmMBb
         Ki09o5wldhZi/tmEsg2o17jRNpdQYskdJAcIMaX+KQTOnOi9I83NUKmC02+kcFJbrJRn
         9rQy1ybCwk/gfGmDfsyeaUd5yqiEehjit0i5AyGVM9EfenmI1rlQLhreYKLMR4rysegU
         InMw/qls+m1yfO1aKzQ5bNH7MEfKeBUiUVUL9TNnm8PP7OODUe6f1suLYyye8JfGVTzq
         6KN3LeFtjGhDvArsdigzokOJB/qRlHv6LMYyO4UYWdhKIyWfvoLv90Zm0GgpgFwnW5Kx
         r4Fw==
X-Gm-Message-State: AFqh2kq0605eupuvKR9z/keIBpsThISVg/8XBKZ93bvBIMqVAzMtaEHK
        hD1Ev/k7AaraZoYZjnSq9MI=
X-Google-Smtp-Source: AMrXdXuMdbHUhQAzE0MiH3d0myApJ7/oKLKYNYQRn7zJ2MLcR9aEZ57SMdbpCEwj2o/zAnLNy4GSwg==
X-Received: by 2002:a05:6a00:3691:b0:577:6264:9d0f with SMTP id dw17-20020a056a00369100b0057762649d0fmr5425480pfb.6.1671693967081;
        Wed, 21 Dec 2022 23:26:07 -0800 (PST)
Received: from localhost.localdomain ([43.132.141.4])
        by smtp.gmail.com with ESMTPSA id j186-20020a62c5c3000000b00573eb4a9a66sm11815117pfg.2.2022.12.21.23.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 23:26:06 -0800 (PST)
From:   korantwork@gmail.com
To:     nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lpieralisi@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xinghui Li <korantli@tencent.com>
Subject: [PATCH] PCI: vmd: Do not disable MSI-X remapping in VMD 28C0 controller
Date:   Thu, 22 Dec 2022 15:26:03 +0800
Message-Id: <20221222072603.1175248-1-korantwork@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Xinghui Li <korantli@tencent.com>

Commit ee81ee84f873("PCI: vmd: Disable MSI-X remapping when possible")
disable the vmd MSI-X remapping for optimizing pci performance.However,
this feature severely negatively optimized performance in multi-disk
situations.

In FIO 4K random test, we test 1 disk in the 1 CPU

when disable MSI-X remapping:
read: IOPS=1183k, BW=4622MiB/s (4847MB/s)(1354GiB/300001msec)
READ: bw=4622MiB/s (4847MB/s), 4622MiB/s-4622MiB/s (4847MB/s-4847MB/s),
io=1354GiB (1454GB), run=300001-300001msec

When not disable MSI-X remapping:
read: IOPS=1171k, BW=4572MiB/s (4795MB/s)(1340GiB/300001msec)
READ: bw=4572MiB/s (4795MB/s), 4572MiB/s-4572MiB/s (4795MB/s-4795MB/s),
io=1340GiB (1438GB), run=300001-300001msec

However, the bypass mode could increase the interrupts costs in CPU.
We test 12 disks in the 6 CPU,

When disable MSI-X remapping:
read: IOPS=562k, BW=2197MiB/s (2304MB/s)(644GiB/300001msec)
READ: bw=2197MiB/s (2304MB/s), 2197MiB/s-2197MiB/s (2304MB/s-2304MB/s),
io=644GiB (691GB), run=300001-300001msec

When not disable MSI-X remapping:
read: IOPS=1144k, BW=4470MiB/s (4687MB/s)(1310GiB/300005msec)
READ: bw=4470MiB/s (4687MB/s), 4470MiB/s-4470MiB/s (4687MB/s-4687MB/s),
io=1310GiB (1406GB), run=300005-300005msec

Signed-off-by: Xinghui Li <korantli@tencent.com>
---
 drivers/pci/controller/vmd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index e06e9f4fc50f..9f6e9324d67d 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -998,8 +998,7 @@ static const struct pci_device_id vmd_ids[] = {
 		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP,},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_28C0),
 		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW |
-				VMD_FEAT_HAS_BUS_RESTRICTIONS |
-				VMD_FEAT_CAN_BYPASS_MSI_REMAP,},
+				VMD_FEAT_HAS_BUS_RESTRICTIONS,},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x467f),
 		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
 				VMD_FEAT_HAS_BUS_RESTRICTIONS |
-- 
2.39.0

