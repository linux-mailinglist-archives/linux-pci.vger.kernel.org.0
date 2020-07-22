Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A411228D03
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jul 2020 02:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbgGVAPb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jul 2020 20:15:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52558 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727953AbgGVAPa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jul 2020 20:15:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595376930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=yb1tjJbEhpJuclMtgMyLcW78ZZjdWCXvTbVarsTz3+0=;
        b=H3dcZf4eV5gd16Z+/bZtG4OcJNNHc0JkErIrK1Nr9RxEvnjuUgndYH2xC//j0vySp7pk80
        o4j/nk0z1mpvGYH1pOgJgC9ca8SLFsLJUs4mhWBh4PZP6K+xpb8pQFsL4rBKKdVxjXAGeZ
        nlrPsl09HM8VF18+oJFawtlzYgHsS1M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-WQwzR4y3OA-26v9M2oWiOw-1; Tue, 21 Jul 2020 20:15:26 -0400
X-MC-Unique: WQwzR4y3OA-26v9M2oWiOw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 881FC1902EA2;
        Wed, 22 Jul 2020 00:15:25 +0000 (UTC)
Received: from pc-72.home.com (unknown [10.40.192.79])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1CB606FECD;
        Wed, 22 Jul 2020 00:15:16 +0000 (UTC)
From:   Julia Suvorova <jusual@redhat.com>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Julia Suvorova <jusual@redhat.com>
Subject: [PATCH] x86/PCI: Use MMCONFIG by default for KVM guests
Date:   Wed, 22 Jul 2020 02:15:13 +0200
Message-Id: <20200722001513.298315-1-jusual@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Scanning for PCI devices at boot takes a long time for KVM guests. It
can be reduced if KVM will handle all configuration space accesses for
non-existent devices without going to userspace [1]. But for this to
work, all accesses must go through MMCONFIG.
This change allows to use pci_mmcfg as raw_pci_ops for 64-bit KVM
guests making MMCONFIG the default access method.

[1] https://lkml.org/lkml/2020/5/14/936

Signed-off-by: Julia Suvorova <jusual@redhat.com>
---
 arch/x86/pci/direct.c      | 5 +++++
 arch/x86/pci/mmconfig_64.c | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/arch/x86/pci/direct.c b/arch/x86/pci/direct.c
index a51074c55982..8ff6b65d8f48 100644
--- a/arch/x86/pci/direct.c
+++ b/arch/x86/pci/direct.c
@@ -6,6 +6,7 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/dmi.h>
+#include <linux/kvm_para.h>
 #include <asm/pci_x86.h>
 
 /*
@@ -264,6 +265,10 @@ void __init pci_direct_init(int type)
 {
 	if (type == 0)
 		return;
+
+	if (raw_pci_ext_ops && kvm_para_available())
+		return;
+
 	printk(KERN_INFO "PCI: Using configuration type %d for base access\n",
 		 type);
 	if (type == 1) {
diff --git a/arch/x86/pci/mmconfig_64.c b/arch/x86/pci/mmconfig_64.c
index 0c7b6e66c644..9eb772821766 100644
--- a/arch/x86/pci/mmconfig_64.c
+++ b/arch/x86/pci/mmconfig_64.c
@@ -10,6 +10,7 @@
 #include <linux/init.h>
 #include <linux/acpi.h>
 #include <linux/bitmap.h>
+#include <linux/kvm_para.h>
 #include <linux/rcupdate.h>
 #include <asm/e820/api.h>
 #include <asm/pci_x86.h>
@@ -122,6 +123,8 @@ int __init pci_mmcfg_arch_init(void)
 		}
 
 	raw_pci_ext_ops = &pci_mmcfg;
+	if (kvm_para_available())
+		raw_pci_ops = &pci_mmcfg;
 
 	return 1;
 }
-- 
2.25.4

