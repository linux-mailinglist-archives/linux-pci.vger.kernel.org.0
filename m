Return-Path: <linux-pci+bounces-33288-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA49B1823E
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 15:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A88FF1AA75C2
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 13:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2751C24468E;
	Fri,  1 Aug 2025 13:15:31 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E203FB1B;
	Fri,  1 Aug 2025 13:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754054131; cv=none; b=sWSCIacUFbQCIq9j+lY69GCEvO+LuC/qdmHd7urO4VxLKex4rieI8njrYIdar35DZXSOmC0p5C9t5HQB6Jul/zcsUufK3cjOfda49ScMUBuwP3vXx9GIV/6nUJZl5/YNDzrMFIhshdMXj0Dc1I5BBGn46g1HUlO0/3ieGflBFrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754054131; c=relaxed/simple;
	bh=6dpd9phay9ZxH4XuAj/67+dRY75lqSqOxuEaAlGrRn0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=D6jBuzMHJY7ZKVaF8SlxNzF+5NgLhkmfNi9wJ5dtqK9db8qt5iCFnzBWHImF7iOC2tXn22VdyYKyC9+jYmyguf5/Wyi+wLAy/aEzroPDjxMBDN0sm4715jJTPMJOcadqZYt5E73c85EOxVfewCGfv8hBFHCSITJGQ7HEg4z9H9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-604bff84741so2898566a12.2;
        Fri, 01 Aug 2025 06:15:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754054127; x=1754658927;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bPuL8T14V3X7lD1CGrwguzeqQdg4mYhlg7hqLHO0DYU=;
        b=FqJ2Zn3Riqpv9UyFr+CJ3yCXJtIV0qa+BS91IDYmXDWyH+D1B9F5lWsa07Wvvbs10B
         6bfYFnp6mpjQcIRa0Ct1plgEqUY743DGMtxdR0A+V1K/6FaRAx5qgSEauIQWZuU4qAQP
         dCve7GGMklYT5vO6DxRUyHuPoB+aqX86mcf/dFV/CqMETxQ4hbLFPzQ0QJCZt46Udo2P
         Ep/fqyPrKBgwrsvnkEHrP3T7cQjpNQOCixi5rgJon9nz7Akbm4XpqDBeC9X6nebB2Z2D
         XIuMJH3Ln2drFa9nmHB2YPTeekXPC58mlMD92J3BuYDQXv418WcQ1o/uUFmHNTqOu/oj
         bxMA==
X-Forwarded-Encrypted: i=1; AJvYcCUPPtf9jGSboQnlXIn99a+MRqP4yFdRgBkcNOXw+uV8F+dI50SC2deqhpkBoFhNUpGbvuaF35uJtcaOQ5RT@vger.kernel.org, AJvYcCUbFkR1f4J3W3MKVsNJyKxrE40705cWwcK8qRSzj+vapnjPIgI0/DeNwXEmKJOomdzmh8FwiffTekvB@vger.kernel.org, AJvYcCWe+SNsM64n2Dcz8d4F2rks+vtPFXeZjx1m502CwvhE8E77bJvd9YQqhSynDIKH1HsGNoJXOhvMcHDr@vger.kernel.org
X-Gm-Message-State: AOJu0YygBPIFiosMC7ZU0xQ2+Nls0uXUw2nx8Tg78kpvf21xDQ+o2ojq
	TwHYNqMJmJ3C7vY4EXcKxG8T7KvaUr1vk+jLVHz9u5puI3zmIzzuKpFs
X-Gm-Gg: ASbGnctmeXK2DL7IPB/cdDZTEeZB2fsJc0sCRtDa3ixe+cFGneiTL1HqzSUJ3+HTN1O
	nyY6Ui2QcRk37+VEM0pzAOJuCjJP1hj34jcAEa8f5MoIBMqjQI4V5PraNjnOo6BNV2+raYgH/Di
	ZRWKidQ90EPeDcTKyIz8cE9bSYUYLrlXPsxfpWWJgZGTDi/YaEo4oD5ANXc6CdbvGJ9Hbf18MpK
	YgKYJ1mnvYSQUQ+Lo7wb/zvuqCUsR4VsnVVOnJHiuDT3v0HoowFwm6nJ9elDJeSonN44/5LUJHl
	moYM71RnkefMImqmUOpDGbMu5frjcke8htStpjc2fkExuTh78RFWqoPAxIS3ya2IHsjHZTHiqfO
	ICcI/3dei0R3ijQ==
X-Google-Smtp-Source: AGHT+IHFkYKv/rbhKiOnOJxUfULDIWQuOJVDDjNuIkW476Ceze0aVUEftZ7cwSl0d9WImjiKqgM1Wg==
X-Received: by 2002:a17:907:1c8c:b0:af6:361e:bbbc with SMTP id a640c23a62f3a-af8fd58a063mr1326768266b.2.1754054126971;
        Fri, 01 Aug 2025 06:15:26 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a1e82a5sm288266266b.82.2025.08.01.06.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 06:15:26 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 01 Aug 2025 05:31:22 -0700
Subject: [PATCH v4] vmcoreinfo: Track and log recoverable hardware errors
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250801-vmcore_hw_error-v4-1-fa1fe65edb83@debian.org>
X-B4-Tracking: v=1; b=H4sIAJmzjGgC/23PQWrDMBCF4auIWVvFM5Il16veI5QgyaNYi1pFD
 mpL8N2DQwou7nbgfT9zg4VL4gUGcYPCNS0pzzAI3QgIk5svLNMIgwBqqWtta2X9CLnwefo6cym
 5SEWk6ZVNUGigEfBZOKbvh3h6bwRMabnm8vMIVNyuTwv1waooUfYh6o5Hb5TSbyP75OaXXC6wY
 ZX2gDkCJFFG7G20oyHn3R5ofr8g/H/ovOmc8VqFzh3KalcmOgJqK8fW9CoGjGj/AOu63gFZjFc
 eagEAAA==
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
 linux-pci@vger.kernel.org, kernel-team@meta.com, osandov@fb.com, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=8255; i=leitao@debian.org;
 h=from:subject:message-id; bh=6dpd9phay9ZxH4XuAj/67+dRY75lqSqOxuEaAlGrRn0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBojL3ty8aeWsEjZnDFnn1Ba6dJoYJz35woUGATu
 OraNsExFciJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaIy97QAKCRA1o5Of/Hh3
 bdTID/43KDd/Q1mSN4jZ1cULP9bNWwVt895nJKhKFHHHvnhK8VtOmfbsKb93CXzO5ysalRWeb8b
 Ek6IBb466wD7bQ/vLmrrgf4SmHvcjNszbwzgDMF9rblvSKCxhJkslV8eWRCYtQ13G8BET8qzDg5
 6FoO6lEeLvNVEeNCSTPXJoWOA/5uZCjmP1LzrUrjgNVeBAtB6uidfMlqXcY3xx+Kp+03opbdtxJ
 cy5dF/MkHh07Nunn9GdNYvcVyYI5fcRTaRC6AUp5rYNyEyc3EEJ9tcTt0XpdVyQL1hLsMK+wU1q
 SSf972wC7g+Xb352VbBDVtGP675uOGtyv0VLBX9qTzB2ufa3e6Hob5sMHlu+xvTRfQOO9DfRy9X
 TXsJMESOAlka2NTK5juaw3oEWNB2vfaMb/T8GmrAJ2ildYLDCjS/hjqijifqtBR7RqZvkM5nj6O
 4AjnrmedOxALeX/5sWV/xJS/sE/hVFWE0QuzOpb+CJ/s09AdYgNOjSt3eNmitD3bb6+768x0vCL
 s79AHjH1oaCSt4BcyzcCdZ2QWGBs1fAcgbhBECvtAb/xFtCLLUZq7acZGpLoyft9KokRkFhdEby
 Rtv7WAjj6oJ88TNjzZWS8S0xSNKfJMzU+7tzHrQixzYk79wud/zaKqCovubuVrYy9i96COLJiAO
 fUDzWkbxpPSOZKg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Introduce a generic infrastructure for tracking recoverable hardware
errors (HW errors that are visible to the OS but does not cause a panic)
and record them for vmcore consumption. This aids post-mortem crash
analysis tools by preserving a count and timestamp for the last
occurrence of such errors. On the other side, correctable errors, which
the OS typically remains unaware of because the underlying hardware
handles them transparently, are less relevant for crash dump
and therefore are NOT tracked in this infrastructure.

Add centralized logging for sources of recoverable hardware
errors based on the subsystem it has been notified.

hwerror_data is write-only at kernel runtime, and it is meant to be read
from vmcore using tools like crash/drgn. For example, this is how it
looks like when opening the crashdump from drgn.

	>>> prog['hwerror_data']
	(struct hwerror_info[1]){
		{
			.count = (int)844,
			.timestamp = (time64_t)1752852018,
		},
		...

This helps fleet operators quickly triage whether a crash may be
influenced by hardware recoverable errors (which executes a uncommon
code path in the kernel), especially when recoverable errors occurred
shortly before a panic, such as the bug fixed by
commit ee62ce7a1d90 ("page_pool: Track DMA-mapped pages and unmap them
when destroying the pool")

This is not intended to replace full hardware diagnostics but provides
a fast way to correlate hardware events with kernel panics quickly.

Rare machine check exceptions—like those indicated by mce_flags.p5 or
mce_flags.winchip—are not accounted for in this method, as they fall
outside the intended usage scope for this feature’s user base.

Suggested-by: Tony Luck <tony.luck@intel.com>
Suggested-by: Shuai Xue <xueshuai@linux.alibaba.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v4:
- Split the error by hardware subsystem instead of kernel
  subsystem/driver (Shuai)
- Do not count the corrected errors, only focusing on recoverable errors (Shuai)
- Link to v3: https://lore.kernel.org/r/20250722-vmcore_hw_error-v3-1-ff0683fc1f17@debian.org

Changes in v3:
- Add more information about this feature in the commit message
  (Borislav Petkov)
- Renamed the function to hwerr_log_error_type() and use hwerr as
  suffix (Borislav Petkov)
- Make the empty function static inline (kernel test robot)
- Link to v2: https://lore.kernel.org/r/20250721-vmcore_hw_error-v2-1-ab65a6b43c5a@debian.org

Changes in v2:
- Split the counter by recoverable error (Tony Luck)
- Link to v1: https://lore.kernel.org/r/20250714-vmcore_hw_error-v1-1-8cf45edb6334@debian.org
---
 arch/x86/kernel/cpu/mce/core.c |  4 ++++
 drivers/acpi/apei/ghes.c       | 36 ++++++++++++++++++++++++++++++++++++
 drivers/pci/pcie/aer.c         |  2 ++
 include/linux/vmcore_info.h    | 17 +++++++++++++++++
 kernel/vmcore_info.c           | 18 ++++++++++++++++++
 5 files changed, 77 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 4da4eab56c81d..f85759453f89a 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -45,6 +45,7 @@
 #include <linux/task_work.h>
 #include <linux/hardirq.h>
 #include <linux/kexec.h>
+#include <linux/vmcore_info.h>
 
 #include <asm/fred.h>
 #include <asm/cpu_device_id.h>
@@ -1690,6 +1691,9 @@ noinstr void do_machine_check(struct pt_regs *regs)
 	}
 
 out:
+	/* Given it didn't panic, mark it as recoverable */
+	hwerr_log_error_type(HWERR_RECOV_MCE);
+
 	instrumentation_end();
 
 clear:
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index a0d54993edb3b..562459e9d632e 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -43,6 +43,7 @@
 #include <linux/uuid.h>
 #include <linux/ras.h>
 #include <linux/task_work.h>
+#include <linux/vmcore_info.h>
 
 #include <acpi/actbl1.h>
 #include <acpi/ghes.h>
@@ -867,6 +868,40 @@ int cxl_cper_kfifo_get(struct cxl_cper_work_data *wd)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cper_kfifo_get, "CXL");
 
+static void ghes_log_hwerr(int sev, guid_t *sec_type)
+{
+	if (sev != CPER_SEV_RECOVERABLE)
+		return;
+
+	if (guid_equal(sec_type, &CPER_SEC_PROC_ARM) ||
+	    guid_equal(sec_type, &CPER_SEC_PROC_GENERIC) ||
+	    guid_equal(sec_type, &CPER_SEC_PROC_IA)) {
+		hwerr_log_error_type(HWERR_RECOV_CPU);
+		return;
+	}
+
+	if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR) ||
+	    guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID) ||
+	    guid_equal(sec_type, &CPER_SEC_CXL_DRAM_GUID) ||
+	    guid_equal(sec_type, &CPER_SEC_CXL_MEM_MODULE_GUID)) {
+		hwerr_log_error_type(HWERR_RECOV_CXL);
+		return;
+	}
+
+	if (guid_equal(sec_type, &CPER_SEC_PCIE) ||
+	    guid_equal(sec_type, &CPER_SEC_PCI_X_BUS)) {
+		hwerr_log_error_type(HWERR_RECOV_PCI);
+		return;
+	}
+
+	if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM)) {
+		hwerr_log_error_type(HWERR_RECOV_MEMORY);
+		return;
+	}
+
+	hwerr_log_error_type(HWERR_RECOV_OTHERS);
+}
+
 static void ghes_do_proc(struct ghes *ghes,
 			 const struct acpi_hest_generic_status *estatus)
 {
@@ -888,6 +923,7 @@ static void ghes_do_proc(struct ghes *ghes,
 		if (gdata->validation_bits & CPER_SEC_VALID_FRU_TEXT)
 			fru_text = gdata->fru_text;
 
+		ghes_log_hwerr(sev, sec_type);
 		if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM)) {
 			struct cper_sec_mem_err *mem_err = acpi_hest_get_payload(gdata);
 
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 70ac661883672..fe0174b972a7b 100644
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
@@ -751,6 +752,7 @@ static void pci_dev_aer_stats_incr(struct pci_dev *pdev,
 		break;
 	case AER_NONFATAL:
 		aer_info->dev_total_nonfatal_errs++;
+		hwerr_log_error_type(HWERR_RECOV_PCI);
 		counter = &aer_info->dev_nonfatal_errs[0];
 		max = AER_MAX_TYPEOF_UNCOR_ERRS;
 		break;
diff --git a/include/linux/vmcore_info.h b/include/linux/vmcore_info.h
index 37e003ae52626..538a3635fb1e5 100644
--- a/include/linux/vmcore_info.h
+++ b/include/linux/vmcore_info.h
@@ -77,4 +77,21 @@ extern u32 *vmcoreinfo_note;
 Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
 			  void *data, size_t data_len);
 void final_note(Elf_Word *buf);
+
+enum hwerr_error_type {
+	HWERR_RECOV_MCE,
+	HWERR_RECOV_CPU,
+	HWERR_RECOV_MEMORY,
+	HWERR_RECOV_PCI,
+	HWERR_RECOV_CXL,
+	HWERR_RECOV_OTHERS,
+	HWERR_RECOV_MAX,
+};
+
+#ifdef CONFIG_VMCORE_INFO
+noinstr void hwerr_log_error_type(enum hwerr_error_type src);
+#else
+static inline void hwerr_log_error_type(enum hwerr_error_type src) {};
+#endif
+
 #endif /* LINUX_VMCORE_INFO_H */
diff --git a/kernel/vmcore_info.c b/kernel/vmcore_info.c
index e066d31d08f89..4b5ab45d468f5 100644
--- a/kernel/vmcore_info.c
+++ b/kernel/vmcore_info.c
@@ -31,6 +31,13 @@ u32 *vmcoreinfo_note;
 /* trusted vmcoreinfo, e.g. we can make a copy in the crash memory */
 static unsigned char *vmcoreinfo_data_safecopy;
 
+struct hwerr_info {
+	int __data_racy count;
+	time64_t __data_racy timestamp;
+};
+
+static struct hwerr_info hwerr_data[HWERR_RECOV_MAX];
+
 Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
 			  void *data, size_t data_len)
 {
@@ -118,6 +125,17 @@ phys_addr_t __weak paddr_vmcoreinfo_note(void)
 }
 EXPORT_SYMBOL(paddr_vmcoreinfo_note);
 
+void hwerr_log_error_type(enum hwerr_error_type src)
+{
+	if (src < 0 || src >= HWERR_RECOV_MAX)
+		return;
+
+	/* No need to atomics/locks given the precision is not important */
+	hwerr_data[src].count++;
+	hwerr_data[src].timestamp = ktime_get_real_seconds();
+}
+EXPORT_SYMBOL_GPL(hwerr_log_error_type);
+
 static int __init crash_save_vmcoreinfo_init(void)
 {
 	vmcoreinfo_data = (unsigned char *)get_zeroed_page(GFP_KERNEL);

---
base-commit: 89748acdf226fd1a8775ff6fa2703f8412b286c8
change-id: 20250707-vmcore_hw_error-322429e6c316

Best regards,
--  
Breno Leitao <leitao@debian.org>


