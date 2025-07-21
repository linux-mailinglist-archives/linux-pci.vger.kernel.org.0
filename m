Return-Path: <linux-pci+bounces-32637-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 326C7B0C105
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 12:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59A447A15F8
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 10:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6CC28D8D9;
	Mon, 21 Jul 2025 10:13:52 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F345818FC91;
	Mon, 21 Jul 2025 10:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753092832; cv=none; b=IDCPjiTt3e6/9lNm1L2rMS38TiEPwTZZu798yHtLX2fM8DzOAuHHGWMS4DOVR1MxCIrNWVEmY7hMXfUs/9g8DeOznbx8P6MEvqHHEtO9pMqAdR4FKTzWblX+uqvf7RgmsPVkvxQfGoZP1IRB0R5DznySbME8+dOZLj2Q0SwNIYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753092832; c=relaxed/simple;
	bh=6CyXE+47ncMqeXYaeDUusWd/J6hfJn2bzzc1Sds7XhA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rbwWKW3t59ABrjN+c9pT5wTRFlyuQpi4g5t2yPn664PYRWmg0jrc7HSU+SLHQxnNJMgWD4fyXeKzY1bALL7Zpr9gKs0Ht5FbetZJjCqLIObBRlvUoigtGadrwpxyjBwoG+76Y7cJlYr89wM5qOnqgafeQDu+dcqfdK0X1574AmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-612bc52ac2bso6569390a12.2;
        Mon, 21 Jul 2025 03:13:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753092829; x=1753697629;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZuAcMhFgdlgq8bC6IAO8bRQcMyXQHBrJDpRfuyPWDRU=;
        b=p4v3GWVL19nuAF6GeT6xQMkV2GDNh8IjdHsXFWMlZoJ4tplqa8KWiPC8jOp1UuJhsC
         lroSHUfJP9oyHXGLFGwoplJpjHBxVSIXA6gNlsfGlFjdjxUz1qrI1iBTPrX0wpHcmVhc
         q5xKOutqrFOIZdldp3xhafwDgqbsqdBBMPu/NcTZFX8p4Qz4wyQ9iVIDBq8Y1qqaYDo2
         2I10zVnPCdJyzCdc5fGn0UYmKkgB5fOOoL+e8uV5NkEg7VLcfLx1zQ7f6nLnFzoxSXjl
         86u7lCW4kcvjfUntN8Ybu/0UafxL3aTbwOPpt9em0xF6piMPjgIA0qzd1zb5jkUkNm5g
         UfCA==
X-Forwarded-Encrypted: i=1; AJvYcCU3dTaIANcZ76tIfV2z7DAN/n2X29bZrCfUU8/vySWpV/yU1KoOdxV7lgfhImTPiFWAfZypj059aSTt@vger.kernel.org, AJvYcCUo07KNSVFa72P84jgZRFBXvkfjC+dH954foOfHZvBV2Mfyz0mUxJGWH1AMNNnqWq7Rix8pNp6tVLBRxyV8@vger.kernel.org, AJvYcCXpiUYMgvHXg2moZdqRBtSrGQPLJcaFerdJRdqRJVLFjbbUNoeMdHjg/8qGqrV12MJHV6y5gwq+a4G9@vger.kernel.org
X-Gm-Message-State: AOJu0YxjeiFPlW81OZ5j4VlecYKn4GyweeEaFcut2MytwxrjettBBSpq
	NywwjcGX+koz7kdg6Q1OUkLN8x/QXvuvRXb0n9pb0hVymPtmghLrNlan
X-Gm-Gg: ASbGnctlbHLTFeZ38qwwP8kUG92IJrZ1QSzDSuhfSrGn01EFMjcm03qJhIy0j16dNlE
	AF10WhkYF6EhP38AAVp1R94BcljrgXQSJpF5puBY4CbS9ycofItVB4ljyuO9PSxQ8MZLT+WsGcW
	j7lv/bA5hfWhr2ipAuyUMGH+NIDbuLa1w349TGia3s+1W9Jpy2MLx0ZyqBr/Ih7RFs0YLfjmgoZ
	3Oy5CSwbhs7D6B04Q9HL5SjOvpP0ip5cez+bOFGN1qshVnJXZ64IsuvEVPXiDMJ8LOP/UxIOGda
	ejVgbrpRvZJM+te3vY7qM1400U/VLZ4DBwHvYIdkR/SqhRUwiU/gqYDKN15HNm8v5aREILow4Vq
	gCDQSYJnWi8cEsQ==
X-Google-Smtp-Source: AGHT+IErUDyPlenXYLMWBxMmUQ3k7sVd3OKn3UyVnT+AN7vTNaLOpHhpwyQ3698aqKvdx6Wh4zcoiQ==
X-Received: by 2002:a05:6402:430f:b0:60c:44d6:281f with SMTP id 4fb4d7f45d1cf-6128590b4c6mr18720456a12.7.1753092828834;
        Mon, 21 Jul 2025 03:13:48 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612c903fbd3sm5166297a12.36.2025.07.21.03.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 03:13:48 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 21 Jul 2025 03:13:40 -0700
Subject: [PATCH v2] vmcoreinfo: Track and log recoverable hardware errors
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-vmcore_hw_error-v2-1-ab65a6b43c5a@debian.org>
X-B4-Tracking: v=1; b=H4sIANMSfmgC/2XNQQ6CMBBA0as0s6aGDqUoK+9hDCl0gC6kZmqqh
 nB3A3GhYfsX788QiT1FqMUMTMlHHyaoBWYCutFOA0nvoBaAOZZ5lVcy3brA1IzPhpgDywJR44l
 MVygDmYA7U+9fm3i5ZgJGHx+B39sgqbV+LaV3VlJSyWPX65Jca4pCnx213k6HwAOsWMJfwOwBl
 Er26lj1lTNoW/sHLMvyAZbEp/TwAAAA
X-Change-ID: 20250707-vmcore_hw_error-322429e6c316
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>, 
 Borislav Petkov <bp@alien8.de>, Robert Moore <robert.moore@intel.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Hanjun Guo <guohanjun@huawei.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 acpica-devel@lists.linux.dev, osandov@osandov.com, 
 xueshuai@linux.alibaba.com, konrad.wilk@oracle.com, 
 linux-edac@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-pci@vger.kernel.org, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=5825; i=leitao@debian.org;
 h=from:subject:message-id; bh=6CyXE+47ncMqeXYaeDUusWd/J6hfJn2bzzc1Sds7XhA=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBofhLbNzWKazOuUFUx05QoB1C3epNfFg5CF/9x+
 oZygBad+hCJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaH4S2wAKCRA1o5Of/Hh3
 bc9aD/oDPhT1z2GISr+hIhkxSHcTuTRBgx35NI6EAJI0ZbYF65j9RCs0qwdc0+G0PiHG79zHXFI
 Od7BC4cekjn3uug9Zq+hN9u0L22S6buufhDD2ItoB+79ES35ejaee2mNbANe1uZk14AGkI6/E2U
 /RMN2hXICTL9aD5hLrJjiMR/FmnkoeBUKl+0/Es601oVQab6NmzOdb9Jd+KD4WozH47rO6+kmPe
 Ic9J35aJ1b5GUkYxIzDIWy39GOU2B4vm7oIaMcziO+kCG8ZsvmMQDt2tJ1mmtpXrzIq2bu7R3dz
 Qixe9IzmG/gV9GPh9htXY6LtA8VIyQazqsFbCdHBvqShAuoxl+FR1cCxT66C/GNM0l7F/FFr53J
 uJ0PhAejWRQUXRMsQkeNg92rGCaUUfLzparmfHdPvSs1Jk63/1x+ZLxxDj20Dl0oJ8/PLBX5qhr
 YGtNfX56nSHipei04qxCgOCMEbUJ11r+YGba5l2787S6Re/NvKz8tZu5WruqFutfh0ZlBJPmYEx
 fMV4gx+X+drW4af3Sxmwr/ClBXTJzjlO+AO1z+v0ueBrgaYMztwFL0S7vijbjkWuJiDMC9Y9ZbC
 zOJUpdrfDyFbLPcyaNyxhqDzBXO+mP9NLwqfF0IOrvMAwymCWioG5VeUTaptEyl9+8HlqQUm+BN
 Em4D6y+Ne1Z983Q==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Introduce a generic infrastructure for tracking recoverable hardware
errors (HW errors that did not cause a panic) and record them for vmcore
consumption. This aids post-mortem crash analysis tools by preserving
a count and timestamp for the last occurrence of such errors.

This patch adds centralized logging for three common sources of
recoverable hardware errors:

  - PCIe AER Correctable errors
  - x86 Machine Check Exceptions (MCE)
  - APEI/CPER GHES corrected or recoverable errors

hwerror_tracking is write-only at kernel runtime, and it is meant to be
read from vmcore using tools like crash/drgn. For example, this is how
it looks like when opening the crashdump from drgn.

	>>> prog['hwerror_tracking']
	(struct hwerror_tracking_info [3]){
		{
			.count = (int)844,
			.timestamp = (time64_t)1752852018,
		},
		...

Suggested-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- Split the counter by recoverable error (Tony Luck)
- Link to v1: https://lore.kernel.org/r/20250714-vmcore_hw_error-v1-1-8cf45edb6334@debian.org
---
 arch/x86/kernel/cpu/mce/core.c |  3 +++
 drivers/acpi/apei/ghes.c       |  8 ++++++--
 drivers/pci/pcie/aer.c         |  2 ++
 include/linux/vmcore_info.h    | 14 ++++++++++++++
 kernel/vmcore_info.c           | 18 ++++++++++++++++++
 5 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 4da4eab56c81d..781cf574642eb 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -45,6 +45,7 @@
 #include <linux/task_work.h>
 #include <linux/hardirq.h>
 #include <linux/kexec.h>
+#include <linux/vmcore_info.h>
 
 #include <asm/fred.h>
 #include <asm/cpu_device_id.h>
@@ -1692,6 +1693,8 @@ noinstr void do_machine_check(struct pt_regs *regs)
 out:
 	instrumentation_end();
 
+	/* Given it didn't panic, mark it as recoverable */
+	hwerror_tracking_log(HWE_RECOV_MCE);
 clear:
 	mce_wrmsrq(MSR_IA32_MCG_STATUS, 0);
 }
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index a0d54993edb3b..396cdffbe6a37 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -43,6 +43,7 @@
 #include <linux/uuid.h>
 #include <linux/ras.h>
 #include <linux/task_work.h>
+#include <linux/vmcore_info.h>
 
 #include <acpi/actbl1.h>
 #include <acpi/ghes.h>
@@ -1136,13 +1137,16 @@ static int ghes_proc(struct ghes *ghes)
 {
 	struct acpi_hest_generic_status *estatus = ghes->estatus;
 	u64 buf_paddr;
-	int rc;
+	int rc, sev;
 
 	rc = ghes_read_estatus(ghes, estatus, &buf_paddr, FIX_APEI_GHES_IRQ);
 	if (rc)
 		goto out;
 
-	if (ghes_severity(estatus->error_severity) >= GHES_SEV_PANIC)
+	sev = ghes_severity(estatus->error_severity);
+	if (sev == GHES_SEV_RECOVERABLE || sev ==  GHES_SEV_CORRECTED)
+		hwerror_tracking_log(HWE_RECOV_GHES);
+	else if (sev >= GHES_SEV_PANIC)
 		__ghes_panic(ghes, estatus, buf_paddr, FIX_APEI_GHES_IRQ);
 
 	if (!ghes_estatus_cached(estatus)) {
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index e286c197d7167..064d220564b59 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -30,6 +30,7 @@
 #include <linux/kfifo.h>
 #include <linux/ratelimit.h>
 #include <linux/slab.h>
+#include <linux/vmcore_info.h>
 #include <acpi/apei.h>
 #include <acpi/ghes.h>
 #include <ras/ras_event.h>
@@ -746,6 +747,7 @@ static void pci_dev_aer_stats_incr(struct pci_dev *pdev,
 	switch (info->severity) {
 	case AER_CORRECTABLE:
 		aer_info->dev_total_cor_errs++;
+		hwerror_tracking_log(HWE_RECOV_AER);
 		counter = &aer_info->dev_cor_errs[0];
 		max = AER_MAX_TYPEOF_COR_ERRS;
 		break;
diff --git a/include/linux/vmcore_info.h b/include/linux/vmcore_info.h
index 37e003ae52626..5894da92a6ba4 100644
--- a/include/linux/vmcore_info.h
+++ b/include/linux/vmcore_info.h
@@ -77,4 +77,18 @@ extern u32 *vmcoreinfo_note;
 Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
 			  void *data, size_t data_len);
 void final_note(Elf_Word *buf);
+
+enum hwerror_tracking_source {
+	HWE_RECOV_AER,
+	HWE_RECOV_MCE,
+	HWE_RECOV_GHES,
+	HWE_RECOV_MAX,
+};
+
+#ifdef CONFIG_VMCORE_INFO
+void hwerror_tracking_log(enum hwerror_tracking_source src);
+#else
+void hwerror_tracking_log(enum hwerror_tracking_source src) {};
+#endif
+
 #endif /* LINUX_VMCORE_INFO_H */
diff --git a/kernel/vmcore_info.c b/kernel/vmcore_info.c
index e066d31d08f89..23d7ddcd55cdd 100644
--- a/kernel/vmcore_info.c
+++ b/kernel/vmcore_info.c
@@ -31,6 +31,13 @@ u32 *vmcoreinfo_note;
 /* trusted vmcoreinfo, e.g. we can make a copy in the crash memory */
 static unsigned char *vmcoreinfo_data_safecopy;
 
+struct hwerror_tracking_info {
+	int __data_racy count;
+	time64_t __data_racy timestamp;
+};
+
+static struct hwerror_tracking_info hwerror_tracking[HWE_RECOV_MAX];
+
 Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
 			  void *data, size_t data_len)
 {
@@ -118,6 +125,17 @@ phys_addr_t __weak paddr_vmcoreinfo_note(void)
 }
 EXPORT_SYMBOL(paddr_vmcoreinfo_note);
 
+void hwerror_tracking_log(enum hwerror_tracking_source src)
+{
+	if (src < 0 || src >= HWE_RECOV_MAX)
+		return;
+
+	/* No need to atomics/locks given the precision is not important */
+	hwerror_tracking[src].count++;
+	hwerror_tracking[src].timestamp = ktime_get_real_seconds();
+}
+EXPORT_SYMBOL_GPL(hwerror_tracking_log);
+
 static int __init crash_save_vmcoreinfo_init(void)
 {
 	vmcoreinfo_data = (unsigned char *)get_zeroed_page(GFP_KERNEL);

---
base-commit: 97987520025658f30bb787a99ffbd9bbff9ffc9d
change-id: 20250707-vmcore_hw_error-322429e6c316

Best regards,
--  
Breno Leitao <leitao@debian.org>


