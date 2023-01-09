Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9BCB6625E9
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jan 2023 13:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjAIMxX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Jan 2023 07:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbjAIMxW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Jan 2023 07:53:22 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80357DC
        for <linux-pci@vger.kernel.org>; Mon,  9 Jan 2023 04:53:21 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id gh17so19843456ejb.6
        for <linux-pci@vger.kernel.org>; Mon, 09 Jan 2023 04:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JWcWhdL0MGFlmpHHzw+nzUE0W1FuXam1XrT9yOATWIA=;
        b=Cv/RpAzHarCz+tumN0XaZY4dW84AUEJ1icCb2g3uP3XBEr/9UAPr8uaQHcFNzCMzxV
         ECPVRe2IdOw8AdQr47HE7KfvnJdf1aOe+i6Zq7Ff2ap9QfMWFuJBM81WgYH0w+dBnGWU
         goGxZ3fDXqLOeKf6yzuf/paHSwSN8hUHD8Hyzy8+JhRHi5d/pSdwye8n1U6LYi9YExpB
         1kS3cFggCyreJOVfHUztuAFQw5XVIc94PRN4ERjBMZnLV5GpHReN7v/LCAcgVWmQ428p
         KuvJIqPvQj4uok56PG8GjqhjFVt3SmONJCeVTdJL17rDL/BP6w2041h2aYbjol3yxbgu
         W+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JWcWhdL0MGFlmpHHzw+nzUE0W1FuXam1XrT9yOATWIA=;
        b=N4BgfxcDAJg+p7kuDHhCiE0KOCf9Aef0ZYLkBgYpRH9sEVmdeks3L5h8NdXHQLQF2Q
         hSeIc0zGE9e6q2e6huHQIv3Kjk9Hdbl7gJ1wL64pzJh6Sy8TDoespkpEu29zAfHV7g4a
         NHgRc0676C9F06BhvS7UckAQQRYHTSn+QsxLyoeCAMo+PwUIqmVfb6zXZaiT/TednYNW
         nV59UeBtNvOLyeVztnH1pShbNCa6TfGGXfXNBRvaTnsy33yFZEAvIcBwFYTStrIo5tZT
         wuPRiLEtmHawDKTe6ewr2k1rxl3hOe585hP0MZcdRFttJe60tU83EkoKxHHnz7O0vqG3
         w5VQ==
X-Gm-Message-State: AFqh2kqCN84OVlym7WOgZqUI/hNp0n1qGtlmnbuoJ4MUIiEX/RRWDtkx
        Hu++JdpTnEwMHKV/CBPKHMOflTw4mzccmg==
X-Google-Smtp-Source: AMrXdXsqtwpG/CaRK1fU6As1AI76bg4pjUWBgRjcByWon2DZqVGE8SF7/qOef/854gdi/wIMswVvWg==
X-Received: by 2002:a17:906:5e41:b0:84d:465e:49b7 with SMTP id b1-20020a1709065e4100b0084d465e49b7mr2782341eju.63.1673268799666;
        Mon, 09 Jan 2023 04:53:19 -0800 (PST)
Received: from AHUANG12-3ZHH9X.lenovo.com (220-143-195-242.dynamic-ip.hinet.net. [220.143.195.242])
        by smtp.gmail.com with ESMTPSA id wl21-20020a170907311500b0084d37cc06fesm2565652ejb.94.2023.01.09.04.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 04:53:19 -0800 (PST)
From:   Adrian Huang <adrianhuang0701@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     Jonathan Derrick <jonathan.derrick@linux.dev>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Adrian Huang <adrianhuang0701@gmail.com>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Adrian Huang <ahuang12@lenovo.com>
Subject: [PATCH 1/1] PCI: vmd: Fix boot failure when trying to clean up domain before enumeration
Date:   Mon,  9 Jan 2023 20:51:48 +0800
Message-Id: <20230109125148.16813-1-adrianhuang0701@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Adrian Huang <ahuang12@lenovo.com>

Commit 6aab5622296b ("PCI: vmd: Clean up domain before enumeration")
clears PCI configuration space of VMD root ports. However, the host OS
cannot boot successfully with the following error message:

  vmd 0000:64:05.5: PCI host bridge to bus 10000:00
  ...
  vmd 0000:64:05.5: Bound to PCI domain 10000
  ...
  DMAR: VT-d detected Invalidation Queue Error: Reason f
  DMAR: VT-d detected Invalidation Time-out Error: SID ffff
  DMAR: VT-d detected Invalidation Completion Error: SID ffff
  DMAR: QI HEAD: UNKNOWN qw0 = 0x0, qw1 = 0x0
  DMAR: QI PRIOR: UNKNOWN qw0 = 0x0, qw1 = 0x0
  DMAR: Invalidation Time-out Error (ITE) cleared

The root cause is that memset_io() clears prefetchable memory base/limit
registers and prefetchable base/limit 32 bits registers sequentially. This
might enable prefetchable memory if the device disables prefetchable memory
originally. Here is an example (before memset_io()):

  PCI configuration space for 10000:00:00.0:
  86 80 30 20 06 00 10 00 04 00 04 06 00 00 01 00
  00 00 00 00 00 00 00 00 00 01 01 00 00 00 00 20
  00 00 00 00 01 00 01 00 ff ff ff ff 75 05 00 00
  00 00 00 00 40 00 00 00 00 00 00 00 00 01 02 00

So, prefetchable memory is ffffffff00000000-575000fffff, which is disabled.
Here is the quote from section 7.5.1.3.9 of PCI Express Base 6.0 spec:

  The Prefetchable Memory Limit register must be programmed to a smaller
  value than the Prefetchable Memory Base register if there is no
  prefetchable memory on the secondary side of the bridge.

When memset_io() clears prefetchable base 32 bits register, the
prefetchable memory becomes 0000000000000000-575000fffff, which is enabled.
This behavior causes that the content of PCI configuration space of VMD
root ports is 0xff after invoking memset_io() in vmd_domain_reset():

  10000:00:00.0 PCI bridge: Intel Corporation Sky Lake-E PCI Express Root Port A (rev ff) (prog-if ff)
          !!! Unknown header type 7f
  00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
  ...
  f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

  10000:00:01.0 PCI bridge: Intel Corporation Sky Lake-E PCI Express Root Port B (rev ff) (prog-if ff)
          !!! Unknown header type 7f
  00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
  ...
  f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

To fix the issue, prefetchable limit upper 32 bits register needs to be
cleared firstly. This also adheres to the implementation of
pci_setup_bridge_mmio_pref(). Please see the function for detail.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=216644
Fixes: 6aab5622296b ("PCI: vmd: Clean up domain before enumeration")
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>
Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
---
 drivers/pci/controller/vmd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 769eedeb8802..e520aec55b68 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -526,6 +526,9 @@ static void vmd_domain_reset(struct vmd_dev *vmd)
 				     PCI_CLASS_BRIDGE_PCI))
 					continue;
 
+				/* Clear the upper 32 bits of PREF limit. */
+				memset_io(base + PCI_PREF_LIMIT_UPPER32, 0, 4);
+
 				memset_io(base + PCI_IO_BASE, 0,
 					  PCI_ROM_ADDRESS1 - PCI_IO_BASE);
 			}
-- 
2.31.1

