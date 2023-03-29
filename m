Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8916CD975
	for <lists+linux-pci@lfdr.de>; Wed, 29 Mar 2023 14:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjC2MjF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Mar 2023 08:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjC2MjE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Mar 2023 08:39:04 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFB319B;
        Wed, 29 Mar 2023 05:39:03 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id r14so5755032oiw.12;
        Wed, 29 Mar 2023 05:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680093543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zuLF4mG8KTV/m4ayMe7Q/gSh3eN9gwA6jaAXiVE/1pM=;
        b=2RGMcpOHaJKsYVQQw+W8eT9nC1lDaAA15fM+wxOAcrjrqQCUZxgP4jZ6pgRTE/sfUf
         wyBcvMZsboN2GgTMt6UnnWf4Hl+7N8sHxVXJ5p9kaCRNPkGKyRvP7/Ll+dbbsKmsWdHw
         ZYFrl2mzB8fPssAertgICyORUqhBlQRP8OamdjA1/fW5/DKmf3s44RhnJqy+Xl+63Wr/
         Gy/An2tYX0wBoLz6rN+mYuGjAY+dL4LJtj0PKniM+Z668G47ud/aWn/cBs3kMn3Xt/rj
         wqaeCJDxG9vzhsttp7IRgd2fc+RvkeSJ3lOSRuHO16KPx1PRvz++KlpLMrXN7l3YIos3
         3XZQ==
X-Gm-Message-State: AO0yUKW8t9ziPuVtTMtwsmy5zD6FstWRqDZuVPPe9h9hLAagTxvtNqgV
        DdsK2hNeUuqZnT03hUGplQ==
X-Google-Smtp-Source: AK7set/JC4BaXpmgDCIc8Jg7j+gs+I5dpQzu5Z3CYmvb6hPXylNsgQ/UeFQ1u6nzNWI4SZTOCOzcjQ==
X-Received: by 2002:a54:440f:0:b0:386:ee2f:86e7 with SMTP id k15-20020a54440f000000b00386ee2f86e7mr8139484oiw.10.1680093542772;
        Wed, 29 Mar 2023 05:39:02 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o79-20020a4a2c52000000b0053b8ae294f3sm7711992ooo.11.2023.03.29.05.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 05:39:02 -0700 (PDT)
Received: (nullmailer pid 2725003 invoked by uid 1000);
        Wed, 29 Mar 2023 12:39:01 -0000
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Cc:     Jon Hunter <jonathanh@nvidia.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: Fix use-after-free in pci_bus_release_domain_nr()
Date:   Wed, 29 Mar 2023 07:38:35 -0500
Message-Id: <20230329123835.2724518-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit c14f7ccc9f5d ("PCI: Assign PCI domain IDs by ida_alloc()")
introduced a use-after-free bug in the bus removal cleanup. The issue
was found with kfence:

[   19.285870] ==================================================================
[   19.293351] BUG: KFENCE: use-after-free read in pci_bus_release_domain_nr+0x10/0x70

[   19.302817] Use-after-free read at 0x000000007f3b80eb (in kfence-#115):
[   19.309677]  pci_bus_release_domain_nr+0x10/0x70
[   19.309691]  dw_pcie_host_deinit+0x28/0x78
[   19.309702]  tegra_pcie_deinit_controller+0x1c/0x38 [pcie_tegra194]
[   19.309734]  tegra_pcie_dw_probe+0x648/0xb28 [pcie_tegra194]
[   19.309752]  platform_probe+0x90/0xd8
[   19.309764]  really_probe+0xb8/0x298
[   19.309777]  __driver_probe_device+0x78/0xd8
[   19.309788]  driver_probe_device+0x38/0x120
[   19.309799]  __device_attach_driver+0x94/0xe0
[   19.309812]  bus_for_each_drv+0x70/0xc8
[   19.309822]  __device_attach+0xfc/0x188
[   19.309833]  device_initial_probe+0x10/0x18
[   19.309844]  bus_probe_device+0x94/0xa0
[   19.309854]  deferred_probe_work_func+0x80/0xb8
[   19.309864]  process_one_work+0x1e0/0x348
[   19.309882]  worker_thread+0x48/0x410
[   19.309891]  kthread+0xf4/0x110
[   19.309904]  ret_from_fork+0x10/0x20

[   19.311457] kfence-#115: 0x00000000063a155a-0x00000000ba698da8, size=1072, cache=kmalloc-2k

[   19.311469] allocated by task 96 on cpu 10 at 19.279323s:
[   19.311562]  __kmem_cache_alloc_node+0x260/0x278
[   19.311571]  kmalloc_trace+0x24/0x30
[   19.311580]  pci_alloc_bus+0x24/0xa0
[   19.311590]  pci_register_host_bridge+0x48/0x4b8
[   19.311601]  pci_scan_root_bus_bridge+0xc0/0xe8
[   19.311613]  pci_host_probe+0x18/0xc0
[   19.311623]  dw_pcie_host_init+0x2c0/0x568
[   19.311630]  tegra_pcie_dw_probe+0x610/0xb28 [pcie_tegra194]
[   19.311647]  platform_probe+0x90/0xd8
[   19.311653]  really_probe+0xb8/0x298
[   19.311663]  __driver_probe_device+0x78/0xd8
[   19.311672]  driver_probe_device+0x38/0x120
[   19.311682]  __device_attach_driver+0x94/0xe0
[   19.311694]  bus_for_each_drv+0x70/0xc8
[   19.311702]  __device_attach+0xfc/0x188
[   19.311713]  device_initial_probe+0x10/0x18
[   19.311724]  bus_probe_device+0x94/0xa0
[   19.311733]  deferred_probe_work_func+0x80/0xb8
[   19.311743]  process_one_work+0x1e0/0x348
[   19.311753]  worker_thread+0x48/0x410
[   19.311763]  kthread+0xf4/0x110
[   19.311771]  ret_from_fork+0x10/0x20

[   19.311782] freed by task 96 on cpu 10 at 19.285833s:
[   19.311799]  release_pcibus_dev+0x30/0x40
[   19.311808]  device_release+0x30/0x90
[   19.311814]  kobject_put+0xa8/0x120
[   19.311832]  device_unregister+0x20/0x30
[   19.311839]  pci_remove_bus+0x78/0x88
[   19.311850]  pci_remove_root_bus+0x5c/0x98
[   19.311860]  dw_pcie_host_deinit+0x28/0x78
[   19.311866]  tegra_pcie_deinit_controller+0x1c/0x38 [pcie_tegra194]
[   19.311883]  tegra_pcie_dw_probe+0x648/0xb28 [pcie_tegra194]
[   19.311900]  platform_probe+0x90/0xd8
[   19.311906]  really_probe+0xb8/0x298
[   19.311916]  __driver_probe_device+0x78/0xd8
[   19.311926]  driver_probe_device+0x38/0x120
[   19.311936]  __device_attach_driver+0x94/0xe0
[   19.311947]  bus_for_each_drv+0x70/0xc8
[   19.311956]  __device_attach+0xfc/0x188
[   19.311966]  device_initial_probe+0x10/0x18
[   19.311976]  bus_probe_device+0x94/0xa0
[   19.311985]  deferred_probe_work_func+0x80/0xb8
[   19.311995]  process_one_work+0x1e0/0x348
[   19.312005]  worker_thread+0x48/0x410
[   19.312014]  kthread+0xf4/0x110
[   19.312022]  ret_from_fork+0x10/0x20

[   19.313579] CPU: 10 PID: 96 Comm: kworker/u24:2 Not tainted 6.2.0 #4
[   19.320171] Hardware name:  /, BIOS 1.0-d7fb19b 08/10/2022
[   19.325852] Workqueue: events_unbound deferred_probe_work_func
[   19.331919] ==================================================================

The stack trace is a bit misleading as dw_pcie_host_deinit() doesn't
directly call pci_bus_release_domain_nr(). The issue turns out to be in
pci_remove_root_bus() which first calls pci_remove_bus() which frees the
struct pci_bus when its struct device is released. Then
pci_bus_release_domain_nr() is called and accesses the freed
struct pci_bus. Reordering these fixes the issue.

Fixes: c14f7ccc9f5d ("PCI: Assign PCI domain IDs by ida_alloc()")
Reported-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Cc: Pali Rohár <pali@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/remove.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 0145aef1b930..22d39e12b236 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -157,8 +157,6 @@ void pci_remove_root_bus(struct pci_bus *bus)
 	list_for_each_entry_safe(child, tmp,
 				 &bus->devices, bus_list)
 		pci_remove_bus_device(child);
-	pci_remove_bus(bus);
-	host_bridge->bus = NULL;
 
 #ifdef CONFIG_PCI_DOMAINS_GENERIC
 	/* Release domain_nr if it was dynamically allocated */
@@ -166,6 +164,9 @@ void pci_remove_root_bus(struct pci_bus *bus)
 		pci_bus_release_domain_nr(bus, host_bridge->dev.parent);
 #endif
 
+	pci_remove_bus(bus);
+	host_bridge->bus = NULL;
+
 	/* remove the host bridge */
 	device_del(&host_bridge->dev);
 }
-- 
2.39.2

