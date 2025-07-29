Return-Path: <linux-pci+bounces-33116-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3279B14EAA
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 15:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F79F7AE275
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 13:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4145F19CD1D;
	Tue, 29 Jul 2025 13:48:09 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26599433D9;
	Tue, 29 Jul 2025 13:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753796889; cv=none; b=Ac8lzjtyrAiZi7ang0usgU2smUBcgTVRMvQptlzVNXtgL89Tfsy+9uZMbma6ysJC9Ge4iMz0lSBixaELrlGg7EF8ynygE+EileZzAd/v7z3uovkqfM8f6zk9yr8EcjZ7nldquIsEFThs6ctrg0PXVNclXLY+hN8ZWiTaAMtuvDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753796889; c=relaxed/simple;
	bh=JVZWhpRYte2sbQKu62ue1NYRYw1oPj6xjDI3KqoI+8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j6rQgpL4EZOs7jsRk2m23yshATYre6liaX+X2bQt3F/DZJEQnEqoLz29pumnoyRDcUBcLHKQ0qT+kU7BJrYJE8oFA+8UrTeTzcX5+WROd79CQLrn0XP4tmsxi7NTrJIzpMMNmgYFuirmGrxHxFvPC1X7j23poVmT/XcA+pD6qVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae0de1c378fso796966966b.3;
        Tue, 29 Jul 2025 06:48:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753796885; x=1754401685;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fqpJ3qavj+uj5qUw11hqA4ZXOBuAyd1GoY7/Qe2tt3o=;
        b=jc5D63kQEvJ1xczOvm3qXfAiX+6N6UI7ZyAyBWHgBwZCI9xyMzwj41Sij5m2Hc5+1Z
         uOAgTvqTK5tRz9bvGwufjhgDRT4bkOz1vuYpIC9pUOGJDgOMjCI/mcGFiVt1GrgQ09az
         bHRLI4gs3YJR5yJeAHIFMwqBiDS+ylZqEnp+z66hsVJRVZTINx3i/m2sv21xMn4kR7+1
         QeOrJZpPxamDKyCkMzNrHjZvXVSYc/zB64gRLh41i4jUfWAaFUJl54J0zVy6xV1u5Tja
         1WPnKahJNdstRme7Y7syna5Roy1W256TyOUqh1mZRqlS859WB3dwvtl0vywRLPI8XW6D
         Ec2g==
X-Forwarded-Encrypted: i=1; AJvYcCVzKWJlMknOvY0lqt/PRa/O4W/ad282gN91x0sX1ldgg80wk02NdgzIBJM+EjpAyvOaUHy+maFhHHVj@vger.kernel.org, AJvYcCW+Hc17dEgyV/kzQG2Bu9cNRs3WnF8Hq7YoBKgKUIt1H4gyJ918QEcB2tRgyBba8tz4+2aeC0N0TstJ4w==@vger.kernel.org, AJvYcCW2Wdf802l5s3aApGqPmO2/tVw4KOgo15jBcYhfVA68ZyzQdr0P9iPHNfFti7swoDhmGOicAOguxd3RWWHs@vger.kernel.org, AJvYcCXmLkKAJhjR9F/TVdDtC6I9OGZznTEwksWDhVlMGnKetS5igkte0fN8SDoM0bOE69p7kYd5EZHknI+U@vger.kernel.org
X-Gm-Message-State: AOJu0YyKEQ5fL+/+pbhr+rvgaCpO2MEuPxvTOqUx5QZflhH4FIvPyXQC
	6yyFCNP+Q90KfaZQQrElmTsIMf45DZfWWWv8DjJW62DAkobf6SYWc5CS
X-Gm-Gg: ASbGncvAYmiaHryCNliGxTSPLIkMsX0TpI4ShGgQ2VWTzpKABzz7SR0qnbvBWy0wuOz
	4ijg9E1gNvzZriO/EPmmUmfNcO15d7i5QpHK1n5LtAnYtxsLEiEvJsNwjTXdV4sxwWEasWGMo9M
	tKHM6qYMajye7RZMmK82Nm3pkcM3Q0Zfuu9+FL9JLNy/uI1wf+jgU6++kt71WwORlona78jCn84
	8g47wdBT0q1QosMSpUiCakySNh3yoYqZbUKMTkaESG6CX0Vj/0YY6zMcp2b2fdMd2eELw9IFpvy
	ntOoHF/p1MHUeam6eJHQRKoxBEQI8J32lna3A7z8aKvHJoddNhmEDm0RblTRtMyjL10rNFOIJBS
	C/1ZkuyJsmYnAPszq+3o8hcS2dBbFfyaBsQ==
X-Google-Smtp-Source: AGHT+IEnOVRpGDNYutxkoNVWaRH+RN3vGL6plodOhSMKG2VljYlLZkU8dvV1F8OaIHHEQ6N7HUGQkQ==
X-Received: by 2002:a17:907:7245:b0:adf:f8f4:2001 with SMTP id a640c23a62f3a-af61d77a04emr1857844266b.49.1753796884961;
        Tue, 29 Jul 2025 06:48:04 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635a65ff4sm593488466b.81.2025.07.29.06.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 06:48:04 -0700 (PDT)
Date: Tue, 29 Jul 2025 06:48:01 -0700
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
Message-ID: <2a7ok3hdq3hmz45fzosd5vve4qpn6zy5uoogg33warsekigazu@wgfi7qsg5ixo>
References: <20250722-vmcore_hw_error-v3-1-ff0683fc1f17@debian.org>
 <7ce9731a-b212-4e27-8809-0559eb36c5f2@linux.alibaba.com>
 <4qh2wbcbzdajh2tvki26qe4tqjazmyvbn7v7aqqhkxpitdrexo@ucch4ppo7i4e>
 <fdb5dced-ea5a-48b8-bbb4-fc3ade7f3df8@linux.alibaba.com>
 <ldlansfiesfxf4a6dzp5z2etquz5jgiq6ttx3al6q7sesgros6@xh4lkevbzsow>
 <4ef01be1-44b2-4bf5-afec-a90d4f71e955@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4ef01be1-44b2-4bf5-afec-a90d4f71e955@linux.alibaba.com>

On Mon, Jul 28, 2025 at 09:08:25AM +0800, Shuai Xue wrote:
> 在 2025/7/26 00:16, Breno Leitao 写道:
> > On Fri, Jul 25, 2025 at 03:40:58PM +0800, Shuai Xue wrote:
> > 
> > 	enum hwerr_error_type {
> > 		HWERR_RECOV_MCE,     // maps to errors in do_machine_check()
> > 		HWERR_RECOV_CXL,     // maps to CPER_SEC_CXL_
> > 		HWERR_RECOV_PCI,     // maps to AER (pci_dev_aer_stats_incr()) and CPER_SEC_PCIE and CPER_SEC_PCI
> > 		HWERR_RECOV_MEMORY,  // maps to CPER_SEC_PLATFORM_MEM_
> > 		HWERR_RECOV_CPU,     // maps to CPER_SEC_PROC_
> > 		HWERR_RECOV_DMA,     // maps to CPER_SEC_DMAR_
> > 		HWERR_RECOV_OTHERS,  // maps to CPER_SEC_FW_, CPER_SEC_DMAR_,
> > 	}
> > 
> > Is this what you think we should track?
> > 
> > Thanks
> > --breno
> 
> It sounds good to me.

Does the following patch matches your expectation?

Thanks!

Author: Breno Leitao <leitao@debian.org>
Date:   Thu Jul 17 07:39:26 2025 -0700

    vmcoreinfo: Track and log recoverable hardware errors
    
    Introduce a generic infrastructure for tracking recoverable hardware
    errors (HW errors that did not cause a panic) and record them for vmcore
    consumption. This aids post-mortem crash analysis tools by preserving
    a count and timestamp for the last occurrence of such errors.
    
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
index a0d54993edb3b..f0b17efff713e 100644
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
+	if (sev != CPER_SEV_CORRECTED && sev != CPER_SEV_RECOVERABLE)
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
index e286c197d7167..5ccb6ca347f3f 100644
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
+		hwerr_log_error_type(HWERR_RECOV_PCI);
 		counter = &aer_info->dev_cor_errs[0];
 		max = AER_MAX_TYPEOF_COR_ERRS;
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

