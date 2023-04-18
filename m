Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D176E5C82
	for <lists+linux-pci@lfdr.de>; Tue, 18 Apr 2023 10:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjDRIv0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Apr 2023 04:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjDRIvZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Apr 2023 04:51:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8E040F5
        for <linux-pci@vger.kernel.org>; Tue, 18 Apr 2023 01:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681807835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1WwxFs09OLlUItADw/QKnx4w5DftEkyjXgAu+IIu1zg=;
        b=gmEJjGbNerMU6/J0B3SBM9sx8IdWmMpjcn0xzfgZAls4pNw7kVHrc+Ht511WZMM1JYaKkb
        4piKNloBb9UT6MuWgU2KHyGgU9xh/BXH0Y5htC0d7W8JXz8uJLLatLAuITbOCLcqY1b78t
        q5zO74VNTn9t5HlV9k+UVoiFOhDUWTQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-583-lXK-dijyMHW-PykYl1MBOQ-1; Tue, 18 Apr 2023 04:50:34 -0400
X-MC-Unique: lXK-dijyMHW-PykYl1MBOQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 86AFA3815F6D;
        Tue, 18 Apr 2023 08:50:33 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 811DF40C6E6E;
        Tue, 18 Apr 2023 08:50:32 +0000 (UTC)
From:   Igor Mammedov <imammedo@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     mst@redhat.com, rafael@kernel.org, lenb@kernel.org,
        bhelgaas@google.com, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH] pci: acpiphp: try to reassign resources on bridge if necessary
Date:   Tue, 18 Apr 2023 10:50:30 +0200
Message-Id: <20230418085030.2154918-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When using ACPI PCI hotplug, hotplugging a device with
large BARs may fail if bridge windows programmed by
firmware are not large enough.

Reproducer:
  $ qemu-kvm -monitor stdio -M q35  -m 4G \
      -global ICH9-LPC.acpi-pci-hotplug-with-bridge-support=on \
      -device id=rp1,pcie-root-port,bus=pcie.0,chassis=4 \
      disk_image

 wait till linux guest boots, then hotplug device
   (qemu) device_add qxl,bus=rp1

 hotplug on guest side fails with:
   pci 0000:01:00.0: [1b36:0100] type 00 class 0x038000
   pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x03ffffff]
   pci 0000:01:00.0: reg 0x14: [mem 0x00000000-0x03ffffff]
   pci 0000:01:00.0: reg 0x18: [mem 0x00000000-0x00001fff]
   pci 0000:01:00.0: reg 0x1c: [io  0x0000-0x001f]
   pci 0000:01:00.0: BAR 0: no space for [mem size 0x04000000]
   pci 0000:01:00.0: BAR 0: failed to assign [mem size 0x04000000]
   pci 0000:01:00.0: BAR 1: no space for [mem size 0x04000000]
   pci 0000:01:00.0: BAR 1: failed to assign [mem size 0x04000000]
   pci 0000:01:00.0: BAR 2: assigned [mem 0xfe800000-0xfe801fff]
   pci 0000:01:00.0: BAR 3: assigned [io  0x1000-0x101f]
   qxl 0000:01:00.0: enabling device (0000 -> 0003)
   Unable to create vram_mapping
   qxl: probe of 0000:01:00.0 failed with error -12

However when using native PCIe hotplug
  '-global ICH9-LPC.acpi-pci-hotplug-with-bridge-support=off'
it works fine, since kernel attempts to reassign unused resources.
Use the same machinery as native PCIe hotplug to (re)assign resources.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
tested in QEMU with Q35 machine on PCIE root port and also
with nested conventional bridge attached to root port.
---
 drivers/pci/hotplug/acpiphp_glue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index 5b1f271c6034..9aebde28a92f 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -517,7 +517,7 @@ static void enable_slot(struct acpiphp_slot *slot, bool bridge)
 				}
 			}
 		}
-		__pci_bus_assign_resources(bus, &add_list, NULL);
+		pci_assign_unassigned_bridge_resources(bus->self);
 	}
 
 	acpiphp_sanitize_bus(bus);
-- 
2.39.1

