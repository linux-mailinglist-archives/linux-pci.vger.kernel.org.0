Return-Path: <linux-pci+bounces-33178-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EF9B16117
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 15:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F1513AF501
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 13:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624A8298CC4;
	Wed, 30 Jul 2025 13:12:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D832980DB;
	Wed, 30 Jul 2025 13:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753881120; cv=none; b=LY6T6mMgat8Sqio2E5hYB2tmzDqxu3Oz9NQScO/PzguT/dzSeV8zlp0ehNatNaZi+Q5PvR5NL6YoQOvC4zK5TcRRUPjQWJ/DuZ23/HHKBGX+dDaWu5PZDswwHyv7//TCEzybC6nMuXiUB9ebBftaU5BX7m4Cs0c7EjgiZ68Tksk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753881120; c=relaxed/simple;
	bh=m896s30J1y4O6958v84e106QWtaKbxc1uuVbVIJSHDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iO37NQYa3wvMWTo0eB+Y4lEx+wtY9TF/99ONCbXievOQFW/4KIP0km37vyRDUYrc0ZgZPIYeDtWxhs8TzV1J4nbcsmIPyebug2VmIrnU++knVBfvdZ9K7TOYjOW6JtWyajKrVmsMvdRMTY4328VHTMtawVPbQUjUVdXRSs1oRjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-61543f03958so4371563a12.0;
        Wed, 30 Jul 2025 06:11:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753881117; x=1754485917;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1r+g1VtuzHhM6ee74oinlCtt8nG5NflXojKIeCrDYVI=;
        b=jisuMXU6NGKi2L91RmXtKtRjiNO2k2dS9RU5AeBE9zOf1Q5kAQBEiB+7B4gAspLyd6
         7VXnQpB1MH9FLyJDqNXzY55YO1Nl7IASUdzpfekhscSqd05yzM5rd+5q1OtD4tXML7e/
         +p03DVleSm0wm/922ePoYwz062WyDNwElE/URAf2D80TZrb78h67UpH39puJqwmCPDbr
         dSmzA0UvCM4flBUAZmuUBkcEA6qaqjSVZ1hXkbd7RM63+8qnrKNrjZIvUtq/DZk91h8s
         q78KzK/+kz9J/c2JelNZxv+rmjT/CsS6LOT49eTULlHsrha7eq72NgEsgN1BZJ8N6vK2
         Btjg==
X-Forwarded-Encrypted: i=1; AJvYcCUKMXmx0cqs9Mtjsn/ekVLFoBOUB5hE/blrTOktjJr5n+Wo7lTEUqL2xmmAs0O9Bub9AnxlnIH2e7da@vger.kernel.org, AJvYcCVMwo5W5PRErj0dG5Siuz33IiG5wUogUAa5Obi/TfvirzU6Xg7fXrMzPjvdobdUOunfhPCVVgPC6zNkmMUP@vger.kernel.org, AJvYcCWFS3BEPcODlu3KtXFd3OPTd1B90ij5h66pF/e4E1ZZQNjf69DzKyEA6kVVZcJjYh0W7Q/PjTsIFP4WDA==@vger.kernel.org, AJvYcCXqF39gx4cSOHsHNU3hmtFzIAq4A/Ngsxy8I5EnlAuMNH6eB0u/QgqnG2ZgA2L+jiNzNQZEdINISBmG@vger.kernel.org
X-Gm-Message-State: AOJu0YzkBiIuA/eyTVqyyqp3KImB1LSvjqne1v1sGM9+lHfu2xaya3Xd
	DUdztzwOqG/baPZeG5lnUiSVJVF+uWPODJKL854/JD5gCqllRjaeGF7k
X-Gm-Gg: ASbGncuA6hqBp5eOdS3ikqcI2LH9JmDZIRyXGbjDvCV8nNVw9WmAYaIdrKla78SDQtH
	EucI2A1LBscHvcDwiIu7H7U17Zwlwn5sAsibfIQnlbyTDvzCrmI4nJrORRUUH4CiaR+t5MvH9lw
	Dyu515ZxExg0JGPnR2S5CN7MBQkIHaja1/NXcVaz3/jSBHLmZJHKDURurmvt2U9FOkNp7CAVydM
	nDjZhIfCaPlK3y2Dd1UXHULxWATVW3LURt42jfePnTJJKyShSc9wzbzfs7TUfAjDWimpCYRMdj1
	yL91vg+6WdF0vOGubiHBZytQ2AoNuLEx+hspf4foRGSss02AoUHyJBYl6JsBiCc1kCtLIqp3thZ
	tjqlEvtQK+YK3
X-Google-Smtp-Source: AGHT+IEJtGnQI/JmjEkDplKRh70f/n/Jy4pzHrfnwvhr7GH7c/cFeAWRx79OuzuHzhr0tNthVPDzgQ==
X-Received: by 2002:a17:907:e915:b0:ae6:d47a:105d with SMTP id a640c23a62f3a-af8fda78edamr401007566b.55.1753881116184;
        Wed, 30 Jul 2025 06:11:56 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635a6685fsm743144466b.89.2025.07.30.06.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 06:11:55 -0700 (PDT)
Date: Wed, 30 Jul 2025 06:11:52 -0700
From: Breno Leitao <leitao@debian.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>, 
	Robert Moore <robert.moore@intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Hanjun Guo <guohanjun@huawei.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev, osandov@osandov.com, 
	konrad.wilk@oracle.com, linux-edac@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-pci@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v3] vmcoreinfo: Track and log recoverable hardware errors
Message-ID: <zc4jm3hwvtwo5y2knk2bqzwmpf7ma7bdzs6uv2osavzcdew3nk@lfjrlp6sr7zz>
References: <20250722-vmcore_hw_error-v3-1-ff0683fc1f17@debian.org>
 <7ce9731a-b212-4e27-8809-0559eb36c5f2@linux.alibaba.com>
 <4qh2wbcbzdajh2tvki26qe4tqjazmyvbn7v7aqqhkxpitdrexo@ucch4ppo7i4e>
 <fdb5dced-ea5a-48b8-bbb4-fc3ade7f3df8@linux.alibaba.com>
 <ldlansfiesfxf4a6dzp5z2etquz5jgiq6ttx3al6q7sesgros6@xh4lkevbzsow>
 <4ef01be1-44b2-4bf5-afec-a90d4f71e955@linux.alibaba.com>
 <2a7ok3hdq3hmz45fzosd5vve4qpn6zy5uoogg33warsekigazu@wgfi7qsg5ixo>
 <a87c5e74-082f-4be6-bbfd-4867bf72ddcc@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a87c5e74-082f-4be6-bbfd-4867bf72ddcc@linux.alibaba.com>

Hello Shuai,

On Wed, Jul 30, 2025 at 10:13:13AM +0800, Shuai Xue wrote:
> In ghes_log_hwerr(), you're counting both CPER_SEV_CORRECTED and
> CPER_SEV_RECOVERABLE errors:

Thanks. I was reading this code a bit more, and I want to make sure my
understanding is correct, giving I was confused about CORRECTED and
RECOVERABLE errors.

CPER_SEV_CORRECTED means it is corrected in the background, and the OS
was not even notified about it. That includes 1-bit ECC error.
THose are not the errors we are interested in, since they are irrelavant
to the OS.

If that is true, then I might not want count CPER_SEV_CORRECTED errors
at all, but only CPER_SEV_RECOVERABLE.

> However, in the AER section, you're only handling AER_CORRECTABLE cases.
> IMHO, Non-fatal errors are recoverable and correspond to
> CPER_SEV_RECOVERABLE in the ACPI context.
> 
> The mapping should probably be:
> 
> - AER_CORRECTABLE → CPER_SEV_CORRECTED
> - AER_NONFATAL → CPER_SEV_RECOVERABLE

Thanks. This means I want to count AER_NONFATAL but not AER_CORRECTABLE.
Is this right?

Summarizing, This is the a new version of the change, according to my
new understanding:

commit deca1c4b99dcfa64b29fe035f8422b4601212413
Author: Breno Leitao <leitao@debian.org>
Date:   Thu Jul 17 07:39:26 2025 -0700

    vmcoreinfo: Track and log recoverable hardware errors

    Introduce a generic infrastructure for tracking recoverable hardware
    errors (HW errors that are visible to the OS but does not cause a panic)
    and record them for vmcore consumption. This aids post-mortem crash
    analysis tools by preserving a count and timestamp for the last
    occurrence of such errors. On the other side, correctable errors, which
    the OS typically remains unaware of because the underlying hardware
    handles them transparently, are less relevant and therefore are NOT
    tracked in this infrastructure.

    Add centralized logging for sources of recoverable hardware
    errors based on the subsystem it has been notified.

    hwerror_data is write-only at kernel runtime, and it is meant to be read
    from vmcore using tools like crash/drgn. For example, this is how it
    looks like when opening the crashdump from drgn.

            >>> prog['hwerror_data']
            (struct hwerror_info[6]){
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
index a0d54993edb3b..9c549c4a1a708 100644
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
+	    guid_equal(sec_type, &CPER_SEC_PCI_X_BUS) {
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
index e286c197d7167..d814c06cdbee6 100644
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


