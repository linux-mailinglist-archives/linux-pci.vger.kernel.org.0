Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93A05A37B4
	for <lists+linux-pci@lfdr.de>; Sat, 27 Aug 2022 15:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbiH0ND4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Aug 2022 09:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbiH0NDz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Aug 2022 09:03:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DCCD52
        for <linux-pci@vger.kernel.org>; Sat, 27 Aug 2022 06:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661605433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=+EoogJmL1LdU4qsxdiA67NtSxsci+Hnk3sRJu9JBGyA=;
        b=Y6pWvO+ZB1BNNArPV95p55azQ+D6Up5L2PSe2CJPwnPzFO/e3jUBBHNHGPcRV2n+mOXWru
        d7vxrUdCxr/gCVbMWQ2E/yhKOhavwbNt370+2R2ef7ZyTiR+cKKTzJs3ZJEeb8+HsXpFXw
        7zjmQhomtSUz0Wtz7ihYi94KmUP7t34=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-bwYhGl34OsejDyeO-4MToA-1; Sat, 27 Aug 2022 09:03:50 -0400
X-MC-Unique: bwYhGl34OsejDyeO-4MToA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DA5F6185A7BA;
        Sat, 27 Aug 2022 13:03:49 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.192.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E20AAC15BB3;
        Sat, 27 Aug 2022 13:03:46 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Wei Liu <wei.liu@kernel.org>,
        Deepak Rawat <drawat.floss@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH v3 0/3] Drivers: hv: Avoid allocating MMIO from framebuffer region for other passed through PCI devices
Date:   Sat, 27 Aug 2022 15:03:42 +0200
Message-Id: <20220827130345.1320254-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Changes since v2:
- Add Michael's R-b tags to PATCHes1-3 and Bjorn's A-b tag to PATCH1.
- Commit messages tweaks [Michael].

Passed through PCI device sometimes misbehave on Gen1 VMs when Hyper-V
DRM driver is also loaded. Looking at IOMEM assignment, we can see e.g.

$ cat /proc/iomem
...
f8000000-fffbffff : PCI Bus 0000:00
  f8000000-fbffffff : 0000:00:08.0
    f8000000-f8001fff : bb8c4f33-2ba2-4808-9f7f-02f3b4da22fe
...
fe0000000-fffffffff : PCI Bus 0000:00
  fe0000000-fe07fffff : bb8c4f33-2ba2-4808-9f7f-02f3b4da22fe
    fe0000000-fe07fffff : 2ba2:00:02.0
      fe0000000-fe07fffff : mlx4_core

the interesting part is the 'f8000000' region as it is actually the
VM's framebuffer:

$ lspci -v
...
0000:00:08.0 VGA compatible controller: Microsoft Corporation Hyper-V virtual VGA (prog-if 00 [VGA controller])
	Flags: bus master, fast devsel, latency 0, IRQ 11
	Memory at f8000000 (32-bit, non-prefetchable) [size=64M]
...

Recently merged commit a0ab5abced55 ("drm/hyperv : Removing the restruction of
VRAM allocation with PCI bar size") improved the situation as resources,
reserved through vmbus_allocate_mmio() can't be allocated twice:

...
f8000000-fffbffff : PCI Bus 0000:00
  f8000000-fbffffff : 0000:00:08.0
    f8000000-f8001fff : bb8c4f33-2ba2-4808-9f7f-02f3b4da22fe
    f8100000-f88fffff : 5620e0c7-8062-4dce-aeb7-520c7ef76171
...

Always reserve FB region on Gen1 VMs (PATCH2) and make sure we never allocate
anything besides framebuffer from there (PATCH3).

Vitaly Kuznetsov (3):
  PCI: Move PCI_VENDOR_ID_MICROSOFT/PCI_DEVICE_ID_HYPERV_VIDEO
    definitions to pci_ids.h
  Drivers: hv: Always reserve framebuffer region for Gen1 VMs
  Drivers: hv: Never allocate anything besides framebuffer from
    framebuffer memory region

 drivers/gpu/drm/hyperv/hyperv_drm_drv.c       |  3 -
 drivers/hv/vmbus_drv.c                        | 56 ++++++++++++++-----
 .../net/ethernet/microsoft/mana/gdma_main.c   |  4 --
 drivers/video/fbdev/hyperv_fb.c               |  4 --
 include/linux/pci_ids.h                       |  3 +
 5 files changed, 44 insertions(+), 26 deletions(-)

-- 
2.37.1

