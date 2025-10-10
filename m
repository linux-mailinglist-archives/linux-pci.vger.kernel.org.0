Return-Path: <linux-pci+bounces-37801-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C93BCC90C
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 12:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 426B7355B1A
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 10:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A98285CA1;
	Fri, 10 Oct 2025 10:37:27 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65422857C2
	for <linux-pci@vger.kernel.org>; Fri, 10 Oct 2025 10:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760092647; cv=none; b=A36chi799SIfS+ZbgVeYH5Yi6ld7xtWc4NAwEWPMmwXyV0sdqS9JeklY1bCrTFpseC5bZcqWgroP7f258kq2CdBkV4SbNLVWzd2Svmx/t6kQ/UV87ftz5KGZKjGpc1cr4RYxUP8BKz4z1iPTFTF9IBa4HXL+H2OxXczwtEjxrBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760092647; c=relaxed/simple;
	bh=t9iQlzVQ19GL2M0MpfsEv2qNN0F73K0bmUNkcYfhAK0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Br7zGpjz9nxjbN0VduqX+hY0J1nhJI+OHw5vYUSIYk8DThsfQ4GDV4VA7dUGlRE3nF8bLfQqerGqPu/5BTT2vvfbGnQ2j2BP8ofEMpIVo2nlclhgqAljwvpZ4eEYupMkpH8776qESuRgehCwJ9fheSC9gNvixORTuTAgghZ7Tmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b00a9989633so273831266b.0
        for <linux-pci@vger.kernel.org>; Fri, 10 Oct 2025 03:37:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760092642; x=1760697442;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b1x7n9Mu/PlGODo9nRrYWrIHcB4t2KXts9oiHev/O1U=;
        b=tG44NqXWazXsXFY6CaUTnJG1d4Irk7ySbBSNNjZ33+GE6hx3aUkJZWZhYw6I6iyTdW
         ccwpTMf7wDGA/S0jjd6qpxPoS7yy0YfHqJB/x8MZpqF2M8yl0S8W+yJkvb5mW9i/f/XR
         78PRvvx79HhI5TSakLQupgFnSAaDxyGkLslRI02HTe4GgvUIYt8m8fHXNm7DfbCuViMS
         Ofdz1kv6N3Q6u0P/5envFX4O/aQZGRuKB+7USpUWkTYEJpU+IAjgYrnczYGWVwocUomz
         HvEHqC1CzfPjki19vVih/RaqDqJ9OAt8FpqBoF+IV5KAQ7FKVlsaxW62D+r3McOGoyz1
         MBcw==
X-Forwarded-Encrypted: i=1; AJvYcCWMnlF/qWLR6XrvPmFgbkt1Y12ofmr54+TROArYxk6/pE5HUlAOq3CP0Y/P7LeOPwOXKKQJ5dMg/wU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ1riUUPq5H8vC9NW5qH68kDEgJFwNVGULRypp+gOSJJ8+nTYf
	67rzZBJwIZ70A9Z13sggM1v023pU6hKHdkexuAifmbF6jWCVLMc42DMyNibZ4A==
X-Gm-Gg: ASbGncsmjP6iILx7jQRapCs+5iznn3GuYWnPTx8A/13vlFC5lPptF+ajB6OjdtiN9Yv
	uSJYTLrmD3dy3TlchymMDyQXEgUsZBVacoSSUyKqEog6HslIOzlW+ycA3noXLCa+2oX+4Cxkun6
	0iZQX8e4JrcIkjAHsf6bX0MN0lSrR8vwDIXJ3CFArhN9dGKO5ossVMZ748hVdle0/28Q9gOIR+l
	6Q6WBD2CnESLFYMTq7mTtDPCCabSj1A2D3A4vpzFssKSx97DLEsTzxTB0wHY+4grI4ZOhVpBLCE
	LVfL4teGJsy2nmC3T+LGHblT7NAG+EHwZyQLOLQEkc3Tt2+Tiky0NHm6U9gmM4RzxEVMLFr+KYj
	L0FtVi32OO3uGnUgEsiFlHvxRKpR6f3fQC1c=
X-Google-Smtp-Source: AGHT+IEYfCLCRKyIYslyl3UFPfKlAD8lqFnN82aArNqtqxcmZVzH9pFB/iAZ58Z08aOhkebEsM/Xgg==
X-Received: by 2002:a17:907:7f17:b0:b3c:5f99:dac7 with SMTP id a640c23a62f3a-b50bedbe43cmr1176878966b.21.1760092641679;
        Fri, 10 Oct 2025 03:37:21 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d9526724sm203209666b.82.2025.10.10.03.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 03:37:21 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 10 Oct 2025 03:36:50 -0700
Subject: [PATCH RESEND v5] vmcoreinfo: Track and log recoverable hardware
 errors
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251010-vmcore_hw_error-v5-1-636ede3efe44@debian.org>
X-B4-Tracking: v=1; b=H4sIAMLh6GgC/23RPU/EMAwG4L8SZW5Q7Hy014mBWxlgROiUps41w
 7UoRQF06n9HLUIU5WbLz+tXvvKZUqSZt+zKE+U4x2nkLTMV435w45lE7HnLOEo0spa1yBc/JTo
 NHydKaUpCIWo8kPUKLK8Yf0sU4ucmvvCn4/Px8YG/VowPcX6f0tcWlGGb/pigCzODANH4oA31n
 VVK3/fURTfeTem8YRn3gC0BFCACNHWoe4uuc3ug+m2DcHvRddY422nljSuS1S4ZsQTUmhykbVT
 wEKAuAP0HNPLGBXoFHASya/tGFYDZA+VDshEgZB+UUQdLusN/wLIs38ln25D0AQAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=11826; i=leitao@debian.org;
 h=from:subject:message-id; bh=t9iQlzVQ19GL2M0MpfsEv2qNN0F73K0bmUNkcYfhAK0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBo6OHgNltaZ5HX7C9EThfykcafUcVNk7oJ70BQ/
 imTzpWMiYWJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaOjh4AAKCRA1o5Of/Hh3
 ba0PD/sFM8jC7KzjXxHE5yaoM16WyRH87W4OC+puOIsB6WlcXGpw97fp+kyO3Cxr4rO7PyiMh6E
 YZslSIudp3Fnehch4YnpgC++6wGUoL3yETjmylO+9R42+edASH3xPxXL8tA7OemwmuGyMegPaIE
 YH3drbJvOUdq33FBQLs5yEmCfPw7ryIEOBbhAspnlpTnjX12NgOyt1ITwMIIu2ttUDg7tBuPmrq
 IA5FTjdo0lakhHSnA7rBeXVtBF0nHKZsFC3eH3/akZNo9F9EmSHpuGTDvcASsldUBGkpWWPIOIm
 0+7TBdyg6DeRQNp+VPDFHwlXUwu0+Ls5fxDW9MLggiedtnJrqQArvC31gKImx08P1xs8kypJ6/w
 W2A13EQ3mMgLuMrCK7Xki9p9q7CSNSi93sKrfyJNJBVfp61TthX9Rbs2QyE+gAkRKJdBSHbqGgy
 tzOjJELi9hze37VAYU9UdJI6Plz1OB4fk0qnN1epdDAbwp1QkyqIX4LJ6fdkwYx4txZO3DqYnXw
 w7zp+9ahTZF/WRXABGwjnytBwmOZVVytP0shA9pesRRadGCXgTThUp7SU3OjQDzSSkRMV5BqJBf
 QGx8I26RLhhcWdnvnx0F/Re5pz1i5lg9mLFilWibwQTufTAmEj2rybvV9RKgg07Fq35QFa90mDl
 uSEIyhXbnVXDoZQ==
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
Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
Changes in v5:
- Move the headers to uapi file (Dave Hansen)
- Use atomic operations in the tracking struct (Dave Hansen)
- Drop the MCE enum type, and track MCE errors as "others"
- Document this feature better
- Link to v4: https://lore.kernel.org/r/20250801-vmcore_hw_error-v4-1-fa1fe65edb83@debian.org

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
 Documentation/driver-api/hw-recoverable-errors.rst | 60 ++++++++++++++++++++++
 arch/x86/kernel/cpu/mce/core.c                     |  4 ++
 drivers/acpi/apei/ghes.c                           | 36 +++++++++++++
 drivers/pci/pcie/aer.c                             |  2 +
 include/linux/vmcore_info.h                        |  8 +++
 include/uapi/linux/vmcore.h                        |  9 ++++
 kernel/vmcore_info.c                               | 17 ++++++
 7 files changed, 136 insertions(+)

diff --git a/Documentation/driver-api/hw-recoverable-errors.rst b/Documentation/driver-api/hw-recoverable-errors.rst
new file mode 100644
index 0000000000000..fc526c3454bd7
--- /dev/null
+++ b/Documentation/driver-api/hw-recoverable-errors.rst
@@ -0,0 +1,60 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=================================================
+Recoverable Hardware Error Tracking in vmcoreinfo
+=================================================
+
+Overview
+--------
+
+This feature provides a generic infrastructure within the Linux kernel to track
+and log recoverable hardware errors. These are hardware recoverable errors
+visible that might not cause immediate panics but may influence health, mainly
+because new code path will be executed in the kernel.
+
+By recording counts and timestamps of recoverable errors into the vmcoreinfo
+crash dump notes, this infrastructure aids post-mortem crash analysis tools in
+correlating hardware events with kernel failures. This enables faster triage
+and better understanding of root causes, especially in large-scale cloud
+environments where hardware issues are common.
+
+Benefits
+--------
+
+- Facilitates correlation of hardware recoverable errors with kernel panics or
+  unusual code paths that lead to system crashes.
+- Provides operators and cloud providers quick insights, improving reliability
+  and reducing troubleshooting time.
+- Complements existing full hardware diagnostics without replacing them.
+
+Data Exposure and Consumption
+-----------------------------
+
+- The tracked error data consists of per-error-type counts and timestamps of
+  last occurrence.
+- This data is stored in the `hwerror_data` array, categorized by error source
+  types like CPU, memory, PCI, CXL, and others.
+- It is exposed via vmcoreinfo crash dump notes and can be read using tools
+  like `crash`, `drgn`, or other kernel crash analysis utilities.
+- There is no other way to read these data other than from crash dumps.
+- These errors are divided by area, which includes CPU, Memory, PCI, CXL and
+  others.
+
+Typical usage example (in drgn REPL):
+
+.. code-block:: python
+
+    >>> prog['hwerror_data']
+    (struct hwerror_info[HWERR_RECOV_MAX]){
+        {
+            .count = (int)844,
+            .timestamp = (time64_t)1752852018,
+        },
+        ...
+    }
+
+Enabling
+--------
+
+- This feature is enabled when CONFIG_VMCORE_INFO is set.
+
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 460e90a1a0b17..08adbf4cd6edc 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -45,6 +45,7 @@
 #include <linux/task_work.h>
 #include <linux/hardirq.h>
 #include <linux/kexec.h>
+#include <linux/vmcore_info.h>
 
 #include <asm/fred.h>
 #include <asm/cpu_device_id.h>
@@ -1700,6 +1701,9 @@ noinstr void do_machine_check(struct pt_regs *regs)
 	}
 
 out:
+	/* Given it didn't panic, mark it as recoverable */
+	hwerr_log_error_type(HWERR_RECOV_OTHERS);
+
 	instrumentation_end();
 
 clear:
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 97ee19f2cae06..92b0e3c391b2d 100644
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
index 0b5ed4722ac32..e0bcaa896803c 100644
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
@@ -765,6 +766,7 @@ static void pci_dev_aer_stats_incr(struct pci_dev *pdev,
 		break;
 	case AER_NONFATAL:
 		aer_info->dev_total_nonfatal_errs++;
+		hwerr_log_error_type(HWERR_RECOV_PCI);
 		counter = &aer_info->dev_nonfatal_errs[0];
 		max = AER_MAX_TYPEOF_UNCOR_ERRS;
 		break;
diff --git a/include/linux/vmcore_info.h b/include/linux/vmcore_info.h
index 37e003ae52626..e71518caacdfc 100644
--- a/include/linux/vmcore_info.h
+++ b/include/linux/vmcore_info.h
@@ -5,6 +5,7 @@
 #include <linux/linkage.h>
 #include <linux/elfcore.h>
 #include <linux/elf.h>
+#include <uapi/linux/vmcore.h>
 
 #define CRASH_CORE_NOTE_HEAD_BYTES ALIGN(sizeof(struct elf_note), 4)
 #define CRASH_CORE_NOTE_NAME_BYTES ALIGN(sizeof(NN_PRSTATUS), 4)
@@ -77,4 +78,11 @@ extern u32 *vmcoreinfo_note;
 Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
 			  void *data, size_t data_len);
 void final_note(Elf_Word *buf);
+
+#ifdef CONFIG_VMCORE_INFO
+void hwerr_log_error_type(enum hwerr_error_type src);
+#else
+static inline void hwerr_log_error_type(enum hwerr_error_type src) {};
+#endif
+
 #endif /* LINUX_VMCORE_INFO_H */
diff --git a/include/uapi/linux/vmcore.h b/include/uapi/linux/vmcore.h
index 3e9da91866ffd..2ba89fafa518a 100644
--- a/include/uapi/linux/vmcore.h
+++ b/include/uapi/linux/vmcore.h
@@ -15,4 +15,13 @@ struct vmcoredd_header {
 	__u8 dump_name[VMCOREDD_MAX_NAME_BYTES]; /* Device dump's name */
 };
 
+enum hwerr_error_type {
+	HWERR_RECOV_CPU,
+	HWERR_RECOV_MEMORY,
+	HWERR_RECOV_PCI,
+	HWERR_RECOV_CXL,
+	HWERR_RECOV_OTHERS,
+	HWERR_RECOV_MAX,
+};
+
 #endif /* _UAPI_VMCORE_H */
diff --git a/kernel/vmcore_info.c b/kernel/vmcore_info.c
index e066d31d08f89..fe9bf8db1922e 100644
--- a/kernel/vmcore_info.c
+++ b/kernel/vmcore_info.c
@@ -31,6 +31,13 @@ u32 *vmcoreinfo_note;
 /* trusted vmcoreinfo, e.g. we can make a copy in the crash memory */
 static unsigned char *vmcoreinfo_data_safecopy;
 
+struct hwerr_info {
+	atomic_t count;
+	time64_t timestamp;
+};
+
+static struct hwerr_info hwerr_data[HWERR_RECOV_MAX];
+
 Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
 			  void *data, size_t data_len)
 {
@@ -118,6 +125,16 @@ phys_addr_t __weak paddr_vmcoreinfo_note(void)
 }
 EXPORT_SYMBOL(paddr_vmcoreinfo_note);
 
+void hwerr_log_error_type(enum hwerr_error_type src)
+{
+	if (src < 0 || src >= HWERR_RECOV_MAX)
+		return;
+
+	atomic_inc(&hwerr_data[src].count);
+	WRITE_ONCE(hwerr_data[src].timestamp, ktime_get_real_seconds());
+}
+EXPORT_SYMBOL_GPL(hwerr_log_error_type);
+
 static int __init crash_save_vmcoreinfo_init(void)
 {
 	vmcoreinfo_data = (unsigned char *)get_zeroed_page(GFP_KERNEL);

---
base-commit: 4814a4ce3ace92d70c0cdf2896de95de0336396f
change-id: 20250707-vmcore_hw_error-322429e6c316

Best regards,
--  
Breno Leitao <leitao@debian.org>


