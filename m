Return-Path: <linux-pci+bounces-6955-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D06258B8AD7
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 14:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C4D42813DF
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 12:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E24812C490;
	Wed,  1 May 2024 12:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRiju2N6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123B012BEBE;
	Wed,  1 May 2024 12:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714568384; cv=none; b=Ql/Y4AsQyaacR6czoWiFrBozJ4RNcGbd79WbviMet4tF1wwGyd2Bnpp8NV98mbbxT/iOUzkcqwVc/dwLtAkA469e2kqe4/LneYr4p6QmHJFihj5u/oI+mCyqpsOciYlPq8TzZfbgorBbrqwWLOM3s/CYc4kwz34pPZdDuHHXh9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714568384; c=relaxed/simple;
	bh=KxstT7yaWo1HV/VdY87oK/SPbrVfRoguXq0JxrzWNVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYLwZFHmNThxwdbfULiyi35RrusPqFKtA1st7XpQBs/cM67PuU+jkgeWl+H/km+2QIBlR7n0n5STOB6f9hW92cShHJXnfCNiGzP4Hn5d9JWWKzndGqZQ6PgRiFwCjMCQXpM04PzJFB+sijVc5pJns6tYA+6HiP74nbtD3potPg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRiju2N6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A68C4AF18;
	Wed,  1 May 2024 12:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714568383;
	bh=KxstT7yaWo1HV/VdY87oK/SPbrVfRoguXq0JxrzWNVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WRiju2N6FSf6SmX8/SeiqxqDPVUn58NouaFEjSc492GjsVq4LUVMxAbS8dWnH+EOS
	 NNvZWiF33xtYtN0AMZ/wOMIZBhl9LzLBvpzq04+5viXGioH02aT1aqueLlUGeTAsdM
	 bevXE43WHP0/R0GnK6QMm88pTy7hn66rPkS4mlV1/0atSqvc9CF/t+aC8qAta3BZsI
	 //c6VwQ+zBloA+jYaSXYVQUA7E3ie3k1NbdK8HBck3G7AUQlbIvkWcqwnZJRENxiwv
	 9uIJBgNvmE9nr+qDv4ZZM2RRjByu9o2FhpZR9aikuuH2Go/7bd6e+GprMLjydr/dpR
	 xRW1NZVyGuhVA==
Date: Wed, 1 May 2024 13:59:35 +0100
From: Will Deacon <will@kernel.org>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-serial@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marc Zyngier <maz@kernel.org>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Andrei Warkentin <andrei.warkentin@intel.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Subject: Re: [PATCH v5 01/17] arm64: PCI: Migrate ACPI related functions to
 pci-acpi.c
Message-ID: <20240501125935.GA15380@willie-the-truck>
References: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
 <20240501121742.1215792-2-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501121742.1215792-2-sunilvl@ventanamicro.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, May 01, 2024 at 05:47:26PM +0530, Sunil V L wrote:
> The functions defined in arm64 for ACPI support are required
> for RISC-V also. To avoid duplication, move these functions
> to common location.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  arch/arm64/kernel/pci.c | 191 ----------------------------------------
>  drivers/pci/pci-acpi.c  | 182 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 182 insertions(+), 191 deletions(-)

Looks like a straight-forward move of the code, so:

Acked-by: Will Deacon <will@kernel.org>

Will

