Return-Path: <linux-pci+bounces-11069-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B3494369F
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 21:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEC4728606D
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 19:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA94174413;
	Wed, 31 Jul 2024 19:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXxzDAtu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845EA7E59A;
	Wed, 31 Jul 2024 19:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722454875; cv=none; b=XZbtMznToN4TAQeeSgl+aGejS5S6WJ3tbEC/aCI0HvoNtGbhZuXvxdhaCDE3ZU6CuId5EMK2TS2203jOpwEvV/EA1RMdHWqB3RfTxqHvSZejrnou4F/mS0vtMsEmB4B1+G6qC8qtDMFqLMLlYRv/mthp3XoRITGrEj5JdVEcCDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722454875; c=relaxed/simple;
	bh=ybbPtwxAbX+EdKv2j4xf5JOnL86Xh7bOuRhCwIfI1vg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ejbm19y2svvIo1SjRFz/Di9lNfWbBV2KZinWphUPvZk9PpZ8AnfxXqa3jdgMGlyxtrOb1/zpKkjrPFyMMU4oZwW6jFt7oiUfgr59OrHprZqfumIhPeOgaUqMVLHt213rlCy0Yo2QwCiqx0bwcnGr8/bTFUTqb03CYVnuY8y/++M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXxzDAtu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF13C4AF09;
	Wed, 31 Jul 2024 19:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722454875;
	bh=ybbPtwxAbX+EdKv2j4xf5JOnL86Xh7bOuRhCwIfI1vg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=eXxzDAtu26AfRwv2jPkKCDNmEcjx5dvC/nrIF7bX3JyESgSKP/drRJqSwswz+Xbvz
	 1a/qOgmfOdppRfahfAnw11W9qDDeCy9Vn5CKXG6wNzU5wgCfgGIR0xG9JZEGo9ZYT8
	 W6N2x+Fdae5JLj4uAF2dVKdyL2u/h0JPSsVthWaFHnqFwdnmhBpGq0mEjoJBOpPCfM
	 pHbjTiGSKcZp68kKnKokVKgHx1QlsjcmfWSMi6AswOJJfL2Uzynh6W12SYFc8IGdrH
	 0uCrQEoxmjTfbYdhFdvo/6B1MEtkTVU0SbBH4nKaGsrIdQkN61zWJOb0y120nW7na3
	 o+OfdssbdzW2Q==
Date: Wed, 31 Jul 2024 14:41:13 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Haibo Xu <haibo1.xu@intel.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Drew Fustini <dfustini@tenstorrent.com>
Subject: Re: [PATCH v7 02/17] ACPI: scan: Add a weak function to reorder the
 IRQCHIP probe
Message-ID: <20240731194113.GA77955@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729142241.733357-3-sunilvl@ventanamicro.com>

On Mon, Jul 29, 2024 at 07:52:24PM +0530, Sunil V L wrote:
> Unlike OF framework, the irqchip probe using IRQCHIP_ACPI_DECLARE has no
> order defined. Depending on the Makefile is not a good idea. So,
> usually it is worked around by mandating only root interrupt controller
> probed using IRQCHIP_ACPI_DECLARE and other interrupt controllers are
> probed via cascade mechanism.
> 
> However, this is also not a clean solution because if there are multiple
> root controllers (ex: RINTC in RISC-V which is per CPU) which need to be
> probed first, then the cascade will happen for every root controller.
> So, introduce a architecture specific weak function to order the probing
> of the interrupt controllers which can be implemented by different
> architectures as per their interrupt controller hierarchy.

Nit: I think it's nice if the commit log and even the subject line
includes the actual *name* of the function being added.

s/a architecture/an architecture/

No need to repost for these.

> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  drivers/acpi/scan.c  | 3 +++
>  include/linux/acpi.h | 2 ++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 59771412686b..52a9dfc8e18c 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -2755,6 +2755,8 @@ static int __init acpi_match_madt(union acpi_subtable_headers *header,
>  	return 0;
>  }
>  
> +void __weak arch_sort_irqchip_probe(struct acpi_probe_entry *ap_head, int nr) { }
> +
>  int __init __acpi_probe_device_table(struct acpi_probe_entry *ap_head, int nr)
>  {
>  	int count = 0;
> @@ -2763,6 +2765,7 @@ int __init __acpi_probe_device_table(struct acpi_probe_entry *ap_head, int nr)
>  		return 0;
>  
>  	mutex_lock(&acpi_probe_mutex);
> +	arch_sort_irqchip_probe(ap_head, nr);
>  	for (ape = ap_head; nr; ape++, nr--) {
>  		if (ACPI_COMPARE_NAMESEG(ACPI_SIG_MADT, ape->id)) {
>  			acpi_probe_count = 0;
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 0687a442fec7..3fff86f95c2f 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1343,6 +1343,8 @@ struct acpi_probe_entry {
>  	kernel_ulong_t driver_data;
>  };
>  
> +void arch_sort_irqchip_probe(struct acpi_probe_entry *ap_head, int nr);
> +
>  #define ACPI_DECLARE_PROBE_ENTRY(table, name, table_id, subtable,	\
>  				 valid, data, fn)			\
>  	static const struct acpi_probe_entry __acpi_probe_##name	\
> -- 
> 2.43.0
> 

