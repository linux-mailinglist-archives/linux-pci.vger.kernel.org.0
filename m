Return-Path: <linux-pci+bounces-32649-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD29B0C597
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 15:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2951C3AD774
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 13:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713002D97A6;
	Mon, 21 Jul 2025 13:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="S/hMs1J1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF13A85C5E;
	Mon, 21 Jul 2025 13:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753106160; cv=none; b=luwvIkMwOWEj2O4xp+AQewfqwMFa9QHpIQdmF/ego4u1XYbMvKBZQywkN54CUntHkGte3BT2q7B/9aRVYrRgIkZIKzu9XQd26NvSnTJ5+OAPhtS9qqj5xWHm65cHhXknHQ76VFGVfsnK59vSQCYzkrJaK4R4Oq4qSY4VOF0N4Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753106160; c=relaxed/simple;
	bh=luNd2hdiHpXbkn51CVS1PrnHahAzaRIMafg/kGX72tU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDw8IokZ3y4j9L3tiCUPjyGa8EwdOmRxv6mqpH7Jxg7upcYi/ZtFMCJdA+77F7IekCeFnN0YmSvHRSmvph4eA5OCueyEQwXc+5CeDDHpJ2lGUOahvbbw7vuCYjG9pAodJNbgU1qDhviFyFQYbgK8cWPzY0UcDa7d6m1NNXFtzYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=S/hMs1J1; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 476F640E00CE;
	Mon, 21 Jul 2025 13:55:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id tNtVBVq-EtrH; Mon, 21 Jul 2025 13:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1753106144; bh=nlscqHmlqxD6hBwb5iB6jeV5V3isx4CM7hl7kXHzeP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S/hMs1J1tWF4XHylcao5H5R4Z4XLI9EyXKPqtAYOghbP7FblaU/9tnLnjUThM5b9p
	 HMi7nTm+ZKfPwpMoK6nQCr0pFjdtKr8zkPfmIvgCTPZDtuhzz5KSjq74tssBg9LRbs
	 Rz74d2M3sc00RXK4mvhSIOZwC6TxAZxslXvu8C4huXxMuKzsGbS9asDdvHqrquiZC0
	 4T5pa0zP5Vqo8yw8iHQCGQ0qUxfowJfMMEprHZRsoLdo6aqlJAk5cb8PTPeZ7+dkJf
	 JJsGUCuxgRv79TkeZmVUU/xyEMjXVcmSBhKvyvjPghpf9f7Q1WHkSfBwAiMUiE8KnJ
	 A1uoeaARQ2HvyC1Fbirh1RbXi0aIA2fP5rauaT1E/s/bduEIz81n/ANMRSQliAIKHJ
	 FThek94c7sT30G6u7YKLW+EjCvjcndFjg+fGTT/V67Ln9DcEYEsDCIS/EjGmLe5qle
	 b9Gr2PDtqA/sxmuAeMJ2iljDz/FX+momdWOx7VfBqAmtqZ6M58UeTfgvvwbu+RbrrI
	 YNxE1q8Ke8cSZLZQehucpd7Se5vUQMdNZ7Gfjvy6QbjeiRoXyjdC/7uYGhwOjANozr
	 7s6nkYTPUJ/W+Vwgaf3Xq7y92pA+9PRJzb0feA9Mo7jm6NpKllBW5D43GG8VQ1vwGr
	 SMc9qLT6n9IdU6NqsPK5zgJg=
Received: from rn.tnic (unknown [78.130.214.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id DF69640E01F6;
	Mon, 21 Jul 2025 13:55:17 +0000 (UTC)
Date: Mon, 21 Jul 2025 15:57:18 +0200
From: Borislav Petkov <bp@alien8.de>
To: Breno Leitao <leitao@debian.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>,
	Robert Moore <robert.moore@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev,
	osandov@osandov.com, xueshuai@linux.alibaba.com,
	konrad.wilk@oracle.com, linux-edac@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v2] vmcoreinfo: Track and log recoverable hardware errors
Message-ID: <20250721135718.GAaH5HPinaKvXjM-1g@renoirsky.local>
References: <20250721-vmcore_hw_error-v2-1-ab65a6b43c5a@debian.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250721-vmcore_hw_error-v2-1-ab65a6b43c5a@debian.org>

On Mon, Jul 21, 2025 at 03:13:40AM -0700, Breno Leitao wrote:
> Introduce a generic infrastructure for tracking recoverable hardware
> errors (HW errors that did not cause a panic) and record them for vmcore
> consumption. This aids post-mortem crash analysis tools by preserving
> a count and timestamp for the last occurrence of such errors.
> 
> This patch adds centralized logging for three common sources of

"Add centralized... "

> recoverable hardware errors:
> 
>   - PCIe AER Correctable errors
>   - x86 Machine Check Exceptions (MCE)
>   - APEI/CPER GHES corrected or recoverable errors
> 
> hwerror_tracking is write-only at kernel runtime, and it is meant to be
> read from vmcore using tools like crash/drgn. For example, this is how
> it looks like when opening the crashdump from drgn.
> 
> 	>>> prog['hwerror_tracking']
> 	(struct hwerror_tracking_info [3]){
> 		{
> 			.count = (int)844,
> 			.timestamp = (time64_t)1752852018,
> 		},
> 		...
> 

I'm still missing the justification why rasdaemon can't be used here.
You did explain it already in past emails.

> +enum hwerror_tracking_source {
> +	HWE_RECOV_AER,
> +	HWE_RECOV_MCE,
> +	HWE_RECOV_GHES,
> +	HWE_RECOV_MAX,
> +};

Are we confident this separation will serve all cloud dudes?

> +
> +#ifdef CONFIG_VMCORE_INFO
> +void hwerror_tracking_log(enum hwerror_tracking_source src);
> +#else
> +void hwerror_tracking_log(enum hwerror_tracking_source src) {};
> +#endif
> +
>  #endif /* LINUX_VMCORE_INFO_H */
> diff --git a/kernel/vmcore_info.c b/kernel/vmcore_info.c
> index e066d31d08f89..23d7ddcd55cdd 100644
> --- a/kernel/vmcore_info.c
> +++ b/kernel/vmcore_info.c
> @@ -31,6 +31,13 @@ u32 *vmcoreinfo_note;
>  /* trusted vmcoreinfo, e.g. we can make a copy in the crash memory */
>  static unsigned char *vmcoreinfo_data_safecopy;
>  
> +struct hwerror_tracking_info {
> +	int __data_racy count;
> +	time64_t __data_racy timestamp;
> +};
> +
> +static struct hwerror_tracking_info hwerror_tracking[HWE_RECOV_MAX];
> +
>  Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
>  			  void *data, size_t data_len)
>  {
> @@ -118,6 +125,17 @@ phys_addr_t __weak paddr_vmcoreinfo_note(void)
>  }
>  EXPORT_SYMBOL(paddr_vmcoreinfo_note);
>  
> +void hwerror_tracking_log(enum hwerror_tracking_source src)

A function should have a verb in its name explaining what it does:

hwerr_log_error_type()

or so.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

