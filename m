Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13AA72BC3B
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2019 00:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbfE0Wzc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 May 2019 18:55:32 -0400
Received: from alpha.anastas.io ([104.248.188.109]:60975 "EHLO
        alpha.anastas.io" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbfE0Wzc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 May 2019 18:55:32 -0400
Received: from authenticated-user (alpha.anastas.io [104.248.188.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by alpha.anastas.io (Postfix) with ESMTPSA id B891D7F8FC;
        Mon, 27 May 2019 17:55:30 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=anastas.io; s=mail;
        t=1558997731; bh=NkudzRVjZwK8lfclmmYkCIVdF6pby8ZJf/uHpomfJrM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uq142o9McnLkIp2DJH96MbA0DlGTdiQl3UdGdTPVVTqtPR+wThcMWfmjZ5sVCDyyy
         288GhoTV+cep2bsIPpqVMMUs44FtEYKdwg0U+2+6fqKIw6ytRgADBDDieatKMAi9CR
         oHNmADp8/6oKo1QKUUpak0w4rkMn1blVt7wsWvETf6RbTf6y12CqVS06OPklUi4nHr
         LtBlnGo5zZKslXoD4WfucEX6E5AgXBfc0oqBhT1ewlU9E2LUJv46mStANnW2OxSqxS
         LRKu/z/xnJcn18kKFJo60+hJWWmj2RP2QxVSAbUq6M9QSlVjOXEokYLnxNaHaEJEhX
         pAv5s+9O4+2oQ==
From:   Shawn Anastasio <shawn@anastas.io>
To:     linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     bhelgaas@google.com, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au, sbobroff@linux.ibm.com,
        xyjxie@linux.vnet.ibm.com, rppt@linux.ibm.com,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 3/3] powerpc/pseries: Allow user-specified PCI resource alignment after init
Date:   Mon, 27 May 2019 17:55:21 -0500
Message-Id: <20190527225521.5884-4-shawn@anastas.io>
In-Reply-To: <20190527225521.5884-1-shawn@anastas.io>
References: <20190527225521.5884-1-shawn@anastas.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On pseries, custom PCI resource alignment specified with the commandline
argument pci=resource_alignment is disabled due to PCI resources being
managed by the firmware. However, in the case of PCI hotplug the
resources are managed by the kernel, so custom alignments should be
honored in these cases. This is done by only honoring custom
alignments after initial PCI initialization is done, to ensure that
all devices managed by the firmware are excluded.

Without this ability, sub-page BARs sometimes get mapped in between
page boundaries for hotplugged devices and are therefore unusable
with the VFIO framework. This change allows users to request
page alignment for devices they wish to access via VFIO using
the pci=resource_alignment commandline argument.

In the future, this could be extended to provide page-aligned
resources by default for hotplugged devices, similar to what is
done on powernv by commit 382746376993 ("powerpc/powernv: Override
pcibios_default_alignment() to force PCI devices to be page aligned")

Signed-off-by: Shawn Anastasio <shawn@anastas.io>
---
 arch/powerpc/include/asm/machdep.h     |  3 +++
 arch/powerpc/kernel/pci-common.c       |  9 +++++++++
 arch/powerpc/platforms/pseries/setup.c | 22 ++++++++++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 2fbfaa9176ed..46eb62c0954e 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -179,6 +179,9 @@ struct machdep_calls {
 
 	resource_size_t (*pcibios_default_alignment)(void);
 
+	/* Called when determining PCI resource alignment */
+	int (*pcibios_ignore_alignment_request)(void);
+
 #ifdef CONFIG_PCI_IOV
 	void (*pcibios_fixup_sriov)(struct pci_dev *pdev);
 	resource_size_t (*pcibios_iov_resource_alignment)(struct pci_dev *, int resno);
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index ff4b7539cbdf..1a6ded45a701 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -238,6 +238,15 @@ resource_size_t pcibios_default_alignment(void)
 	return 0;
 }
 
+resource_size_t pcibios_ignore_alignment_request(void)
+{
+	if (ppc_md.pcibios_ignore_alignment_request)
+		return ppc_md.pcibios_ignore_alignment_request();
+
+	/* Fall back to default method of checking PCI_PROBE_ONLY */
+	return pci_has_flag(PCI_PROBE_ONLY);
+}
+
 #ifdef CONFIG_PCI_IOV
 resource_size_t pcibios_iov_resource_alignment(struct pci_dev *pdev, int resno)
 {
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index e4f0dfd4ae33..c6af2ed8ee0f 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -82,6 +82,8 @@ EXPORT_SYMBOL(CMO_PageSize);
 
 int fwnmi_active;  /* TRUE if an FWNMI handler is present */
 
+int initial_pci_init_done; /* TRUE if initial pcibios init has completed */
+
 static void pSeries_show_cpuinfo(struct seq_file *m)
 {
 	struct device_node *root;
@@ -749,6 +751,23 @@ static resource_size_t pseries_pci_iov_resource_alignment(struct pci_dev *pdev,
 }
 #endif
 
+static void pseries_after_init(void)
+{
+	initial_pci_init_done = 1;
+}
+
+static int pseries_ignore_alignment_request(void)
+{
+	if (initial_pci_init_done)
+		/*
+		 * Allow custom alignments after init for things
+		 * like PCI hotplugging.
+		 */
+		return 0;
+
+	return pci_has_flag(PCI_PROBE_ONLY);
+}
+
 static void __init pSeries_setup_arch(void)
 {
 	set_arch_panic_timeout(10, ARCH_PANIC_TIMEOUT);
@@ -797,6 +816,9 @@ static void __init pSeries_setup_arch(void)
 	}
 
 	ppc_md.pcibios_root_bridge_prepare = pseries_root_bridge_prepare;
+	ppc_md.pcibios_after_init = pseries_after_init;
+	ppc_md.pcibios_ignore_alignment_request =
+		pseries_ignore_alignment_request;
 }
 
 static void pseries_panic(char *str)
-- 
2.20.1

