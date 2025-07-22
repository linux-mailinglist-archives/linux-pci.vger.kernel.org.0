Return-Path: <linux-pci+bounces-32746-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60212B0E23C
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 18:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F146F3BD857
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 16:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554D927F19B;
	Tue, 22 Jul 2025 16:56:54 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589BA1FECAF;
	Tue, 22 Jul 2025 16:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753203414; cv=none; b=WTErUfB014oA2E/+VxnHTBAjyQ1xiFSYgncIskXsY8r8AEceK2xtqy4mjqPaLWS0TbZDcoRe8tFZv8DQJkbBOP0ZnwQYo0e7TMIX/Hwzp/qB10y86OBOjC7ipbO6wk5LIPuvroduxK/Wph8cSEuD078QF3jaeZrS7/NhQN7Jx5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753203414; c=relaxed/simple;
	bh=mDC8389t2+JWUjueofRYUrCIHY6cXFw3h6b4pxyIR1A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZB7me35BfHp+sBtaGtnmv4pWuwfmhjUT21CZ3ORd9sEhStZy+mwbS+qtMjtDquDKZmpSBW70EJ/4Tmt4+TTtV0N5aKKNYa50gQCNtfmOf7iHUJIwoIEWMTG7yVtQoK8aPnev3gvZTSw5xZH/K30lEXwkpgCDTsRb6znKRMmQvqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-607cc1a2bd8so9005344a12.2;
        Tue, 22 Jul 2025 09:56:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753203411; x=1753808211;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y65MISs+ayKi1h/c+6Q6S5YM36LuH85b0lohq9HpFs4=;
        b=nTwNbEvz7QXtX7SjyisR9JpjL4pyd4OWvCONOAQtQ78jQQkvj1RjngbXgfBNRQkBs6
         IwvT4fzF/X1eeoLt+pyuXMAtzoD/zvuj41xcggd5k4F0/xxjeMieWc2541pDgRA7q0Dx
         xEkTdYMM99dBLVY8BY27NOmW++FVdVdUPJ8T4VUEYUN6kLbB4RQKsgxA50BtEMJMoSss
         YmiqpCcijVQsNL2vvkWrfOIsuVDcNAT53Mqs3G8tsmmq0WSFmaKtfP5PZ7g8tKal7SK4
         PXOXFQUf9v8t/jQAnCBo8wnoXBFDwmHUFa6u7n2NE1WviAXWIpd3FuGnYhBnGJjeeZIW
         1KMA==
X-Forwarded-Encrypted: i=1; AJvYcCUzAKRORDIt8daBqfRohmtn3VhOOawMJ7lruqBULI1Q8F2abneaBqirZWF9v6Ax2M9ipSZUz5pfhNtU3OYV@vger.kernel.org, AJvYcCV6OBNIbJcCRQ/SOxvtE+bkCmipDnVcU0SQPiuNIISPtE8r6rt26kOvu2ywvcfjVORTCqumnvbSH4Z6@vger.kernel.org, AJvYcCVbxFMMCGvCBd4B76eENv+yVSYHHibGeJS8gjQuQ93QmsTmayVmd2ZqnkxMBv3zz6ESLCPVuKQBQ4vv@vger.kernel.org
X-Gm-Message-State: AOJu0YzPD0inmYRHwzqh4t1zYq8I99XecYPUJtAQ5ZDxgqiHsY4AcVde
	Jsw0iCSQTrR0j7cUNkvCSF6ejckNxyP7EB55RnrVM/Lo921J+5kIh8iJ
X-Gm-Gg: ASbGncv3LmuaFYE1w13I+vZ/B3p3etaVlwJMZIJv6Pm7BC/5ehf5V2niqMmWfMjqZZ5
	4bVi9baj/SCOAaa1FJOLdGBazRE8g+3LhBJgWBm/r749llMUlIrin2DSpd6FtZv6YopusmKNBRO
	fEyjJ+a26kNhbQJsujl9XfNAuFSFYjk1K9sFlFyej7nbiqccekexcoNpOrvgeY8AvNSXbpOyMHb
	mTuSlM6gCOqAPxBdBI7573ODAPfiRBgvkmRHIRBM1HKotIGfQpmYkSsf3/rOl546Z60ihJF0H9/
	SrkB20dGZNmReoxIEbXFifRSiVrpP0NhsNW+7aMLRw9lJaIO+QzXvr/a/SnipzriuQQC4a0GESC
	yirq5ABqOYU/qB8e3ws+vyRE=
X-Google-Smtp-Source: AGHT+IH1AYyufkWnx6tJRuJWQqKT1LagkvCibf5kL4lR2YqMxA4GaifFCKYDzqx6UoyX8YSH9UzPZQ==
X-Received: by 2002:a17:907:a647:b0:ad8:a935:b8ff with SMTP id a640c23a62f3a-ae9ce094585mr2656153566b.31.1753203410260;
        Tue, 22 Jul 2025 09:56:50 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c7d81e9sm891979866b.49.2025.07.22.09.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 09:56:49 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 22 Jul 2025 09:56:37 -0700
Subject: [PATCH v3] vmcoreinfo: Track and log recoverable hardware errors
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-vmcore_hw_error-v3-1-ff0683fc1f17@debian.org>
X-B4-Tracking: v=1; b=H4sIAMTCf2gC/23PwQrCMBAE0F8Je26k2aSp9uR/iEiSbm0ONrKVq
 JT+u1QUFL0OzBtmgpE40giNmIApxzGmARqhCwGhd8ORZGyhEYAlVmVd1jKfQmI69NcDMSeWGtH
 ghmzQykIh4MzUxdtT3O0LAX0cL4nvz4GslvRlKfNjZSWVXIfOVNR6q7XZtuSjG1aJj7BgGT8B+
 wugVLJT67qrW4vOu0+geL9A9b/ovK2c9UaH6qu4n+f5AaB/gXMpAQAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6616; i=leitao@debian.org;
 h=from:subject:message-id; bh=mDC8389t2+JWUjueofRYUrCIHY6cXFw3h6b4pxyIR1A=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBof8LQP0mW5Apo3fJr4Kr3UWtr7a5fUV3ENzs3z
 bsR6oroctuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaH/C0AAKCRA1o5Of/Hh3
 bfrmEACWV0Y2NzNaS+rMrKfK+UXuqYwjEo8CgQ+ePFSlXXZwP6FW3WTvwMh7PSTQdr7ywWj4Axk
 wwTbPaFU5BYeUK1aKZ8d3hkkuT7SD9ea4mOPr9rqK9h6yw+NkQbC/CuKVWHzuv8mpDZavcZ7b+V
 oK04g/W4hahVLe0TcmPc1npBK4Bk+cubix+NP7YG1TelB2vHAr44zCdlp732X+0sIZ7vSqg+IHV
 FSWEEMoU5x/aG75jE7VKxbfgpOBkqenHN7akQrh6MnD7eahJu2fY/q5HQOUmXPAv0oE9ZMOOjK6
 iYAkjaL8E3pGUksfwB4omeIzF/J5bnMwm3TMamhYbrx/5A3MCn0JBiTxkPpjw8OOE0ySRFEXX49
 2jbUXS+1tr9sx6TgQUKt729saRYUe5fJBuoYMA+b8OqebtNpV43EKQgA2q5pGqA/ak4R78MeDOT
 Bnq1CGyZ0oH1UqLbMxjrEQZVGUQbM8xhmluGo57IG5crD6XJjLNzjx5xloqE4Ohvj1SZ/mAnHYy
 DzJRuAiLhkYtcxVEombXzHMpYVO+7jflrN7vsn8ND67bODDLjUbd7V475HSx2pTxD+P4aLKnju3
 BgYljXOPgd5Pdi6NphcpJaC+OteLJxrk/F0hrvVL2Cql5+QkBy32qJ/+FSUul+BxYmqfjU9mbQu
 E0VQF/26shq/x+Q==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Introduce a generic infrastructure for tracking recoverable hardware
errors (HW errors that did not cause a panic) and record them for vmcore
consumption. This aids post-mortem crash analysis tools by preserving
a count and timestamp for the last occurrence of such errors.

Add centralized logging for three common sources of recoverable hardware
errors:

  - PCIe AER Correctable errors
  - x86 Machine Check Exceptions (MCE)
  - APEI/CPER GHES corrected or recoverable errors

hwerror_data is write-only at kernel runtime, and it is meant to be
read from vmcore using tools like crash/drgn. For example, this is how
it looks like when opening the crashdump from drgn.

	>>> prog['hwerror_data']
	(struct hwerror_info[3]){
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

Suggested-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
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
 arch/x86/kernel/cpu/mce/core.c |  3 +++
 drivers/acpi/apei/ghes.c       |  8 ++++++--
 drivers/pci/pcie/aer.c         |  2 ++
 include/linux/vmcore_info.h    | 14 ++++++++++++++
 kernel/vmcore_info.c           | 18 ++++++++++++++++++
 5 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 4da4eab56c81d..cb225a42eebbb 100644
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
+	hwerr_log_error_type(HWERR_RECOV_MCE);
 clear:
 	mce_wrmsrq(MSR_IA32_MCG_STATUS, 0);
 }
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index a0d54993edb3b..ebda2aa3d68f2 100644
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
+		hwerr_log_error_type(HWERR_RECOV_GHES);
+	else if (sev >= GHES_SEV_PANIC)
 		__ghes_panic(ghes, estatus, buf_paddr, FIX_APEI_GHES_IRQ);
 
 	if (!ghes_estatus_cached(estatus)) {
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index e286c197d7167..1ab744a3b7310 100644
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
+		hwerr_log_error_type(HWERR_RECOV_AER);
 		counter = &aer_info->dev_cor_errs[0];
 		max = AER_MAX_TYPEOF_COR_ERRS;
 		break;
diff --git a/include/linux/vmcore_info.h b/include/linux/vmcore_info.h
index 37e003ae52626..39afce28bfaac 100644
--- a/include/linux/vmcore_info.h
+++ b/include/linux/vmcore_info.h
@@ -77,4 +77,18 @@ extern u32 *vmcoreinfo_note;
 Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
 			  void *data, size_t data_len);
 void final_note(Elf_Word *buf);
+
+enum hwerr_error_type {
+	HWERR_RECOV_AER,
+	HWERR_RECOV_MCE,
+	HWERR_RECOV_GHES,
+	HWERR_RECOV_MAX,
+};
+
+#ifdef CONFIG_VMCORE_INFO
+void hwerr_log_error_type(enum hwerr_error_type src);
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
base-commit: 97987520025658f30bb787a99ffbd9bbff9ffc9d
change-id: 20250707-vmcore_hw_error-322429e6c316

Best regards,
--  
Breno Leitao <leitao@debian.org>


