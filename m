Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDB37696BC
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jul 2023 14:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjGaMsa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jul 2023 08:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjGaMs2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jul 2023 08:48:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537581BCA
        for <linux-pci@vger.kernel.org>; Mon, 31 Jul 2023 05:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690807624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+5eFnfguwCDod1JiXQvQSHlRtViJAMop/KReTBW7wSY=;
        b=IzsZF4WAAJURPG9+VdF6jHNgr3L5hGNh9Ogqv2PuDI+73w+1JVGd9YifN1j1gPUfEXtRLO
        bxS5xY35Xis4rEzItSK9w2g1TSYQvBFGzBHQdHvzlXkM0csjuKToiqZvSKYqvB3qyIYunU
        QLLFVmicyu5/CkpZPiCUm0IdqgPfaBI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-297-V-RfdZUpNw-PuaPUHVjlCg-1; Mon, 31 Jul 2023 08:46:59 -0400
X-MC-Unique: V-RfdZUpNw-PuaPUHVjlCg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9B7208030AC;
        Mon, 31 Jul 2023 12:46:58 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 98F9F492CA6;
        Mon, 31 Jul 2023 12:46:51 +0000 (UTC)
From:   Igor Mammedov <imammedo@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     terraluna977@gmail.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, imammedo@redhat.com, mst@redhat.com,
        helgaas@kernel.org
Subject: [PATCH QEMU] acpiphp: hack to send BusCheck to missing device on root bus
Date:   Mon, 31 Jul 2023 14:46:49 +0200
Message-Id: <20230731124649.2601384-1-imammedo@redhat.com>
In-Reply-To: <20230729215009.GA820749@bhelgaas>
References: <20230729215009.GA820749@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

A reproducer for [1], faking a missing device (supposedly root port)
on root bus, and ability to send BusCheck to it.

Usage:
./qemu-system-x86_64 -monitor stdio -M q35 -cpu host -smp 4 -enable-kvm  -m 4G
   -nographic
   -monitor stdio
   -snapshot
   -serial file:/tmp/s
   -kernel ~/builds/linux-2.6/arch/x86/boot/bzImage
   -append 'root=/dev/sda1 console=ttyS0'
   -device pcie-root-port,id=rp1,bus=pcie.0,chassis=0,addr=8
   vm_disk_image

wait till it boots and then at monitor prompt hotplug a device
(no hotplug will happen since hacked AML code will send only
notify to missing device, but it's sufficient to reproduce kernel crash
at commit [2]):

(qemu)  device_add e1000e,bus=rp1

observe in guest logs:
[  612.277651] BUG: kernel NULL pointer dereference, address: 0000000000000018
[...]
[  612.277798]  ? pci_assign_unassigned_bridge_resources+0x1f/0x260
[  612.277804]  ? pcibios_allocate_dev_resources+0x3c/0x2a0
[  612.277809]  enable_slot+0x21f/0x3e0
[  612.277816]  acpiphp_hotplug_notify+0x13d/0x260
[  612.277822]  ? __pfx_acpiphp_hotplug_notify+0x10/0x10
[  612.277827]  acpi_device_hotplug+0xbc/0x540
[  612.277834]  acpi_hotplug_work_fn+0x15/0x20
[  612.277839]  process_one_work+0x1f7/0x370
[  612.277845]  worker_thread+0x45/0x3b0
[  612.277850]  ? __pfx_worker_thread+0x10/0x10
[  612.277854]  kthread+0xdc/0x110
[  612.277860]  ? __pfx_kthread+0x10/0x10
[  612.277866]  ret_from_fork+0x28/0x40
[  612.277871]  ? __pfx_kthread+0x10/0x10
[  612.277876]  ret_from_fork_asm+0x1b/0x30

1)
  Link: https://lore.kernel.org/r/11fc981c-af49-ce64-6b43-3e282728bd1a@gmail.com
2)
  commit 40613da52b13fb ("PCI: acpiphp: Reassign resources on bridge if necessary")
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/i386/acpi-build.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 9c74fa17ad..f6c2584289 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1784,11 +1784,18 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         if (pci_host) {
             PCIBus *bus = PCI_HOST_BRIDGE(pci_host)->bus;
             Aml *scope = aml_scope("PCI0");
+            Aml *dev;
             /* Scan all PCI buses. Generate tables to support hotplug. */
             build_append_pci_bus_devices(scope, bus);
             if (object_property_find(OBJECT(bus), ACPI_PCIHP_PROP_BSEL)) {
                 build_append_pcihp_slots(scope, bus);
             }
+
+            /* nonexisting PCI device */
+            dev = aml_device("RPX");
+            aml_append(dev, aml_name_decl("_ADR", aml_int(0x100000)));
+            aml_append(scope, dev);
+
             aml_append(sb_scope, scope);
         }
     }
@@ -1852,12 +1859,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         scope =  aml_scope("_GPE");
         {
             method = aml_method("_E01", 0, AML_NOTSERIALIZED);
-            if (has_pcnt) {
-                aml_append(method,
-                    aml_acquire(aml_name("\\_SB.PCI0.BLCK"), 0xFFFF));
-                aml_append(method, aml_call0("\\_SB.PCI0.PCNT"));
-                aml_append(method, aml_release(aml_name("\\_SB.PCI0.BLCK")));
-            }
+            /* send BusCheck to non-present PCI device */
+            aml_append(method, aml_notify(aml_name("\\_SB.PCI0.RPX"), aml_int(0)));
             aml_append(scope, method);
         }
         aml_append(dsdt, scope);
-- 
2.39.3

