Return-Path: <linux-pci+bounces-1392-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1615F81EAD0
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 00:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5E7F1F21A75
	for <lists+linux-pci@lfdr.de>; Tue, 26 Dec 2023 23:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347526127;
	Tue, 26 Dec 2023 23:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDqRFliW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103555C9C;
	Tue, 26 Dec 2023 23:56:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 152A4C433C7;
	Tue, 26 Dec 2023 23:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703634964;
	bh=eeVVPhs698tzJMKPnsN0mOMee+NQ/JOkzljbDzyuvrk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=WDqRFliWt4+s1yPPXM6G//iGI15rQXGWKOoUX9AIRwNDaC0lerFygACxFF/fWG8UX
	 7377qOSvMf1ojfixahrgoBVMCNh2axBW9diJLgSXOmFFD44/BywBakydLB+MWjHgL5
	 mcyWv1sr9WIsGT3uxSd9hmIqw+qcct4UCnQBwBpYpTrN+pQXdRFE4E1CzvrFtBDQ5c
	 z1GO4icvo2Y4Wo28r/5iCAASXkZWh7Oo2fCFahN5CR2C6yyLdMqVIzajysf6kA6N+s
	 YjJ5KSiJlV6v4FEXtbo4KrkqAc2CI01/jvlM3wy0hUDYJjlpfDTvLEKMKDsU+FlOMr
	 U1H3Z20ISE+RA==
Date: Tue, 26 Dec 2023 17:56:02 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>, Haibo Xu <haibo1.xu@intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Anup Patel <anup@brainfault.org>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Jones <ajones@ventanamicro.com>,
	Will Deacon <will@kernel.org>, Len Brown <lenb@kernel.org>
Subject: Re: [RFC PATCH v3 03/17] PCI: Make pci_create_root_bus() declare its
 reliance on MSI domains
Message-ID: <20231226235602.GA1483795@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219174526.2235150-4-sunilvl@ventanamicro.com>

On Tue, Dec 19, 2023 at 11:15:12PM +0530, Sunil V L wrote:
> Similar to [1], declare this dependency for PCI probe in ACPI based
> flow.

It would be better to refer to this as 9ec37efb8783 ("PCI/MSI: Make
pci_host_common_probe() declare its reliance on MSI domains") instead
of a link to the mailing list archives.

The git SHA1 is part of the git repo, and git can tell us where that
SHA1 is included.  The lore URL is external and doesn't say anything
about what happened to the patch.

> This is required especially for RISC-V platforms where MSI controller
> can be absent.
> 
> [1] - https://lore.kernel.org/all/20210330151145.997953-12-maz@kernel.org/

