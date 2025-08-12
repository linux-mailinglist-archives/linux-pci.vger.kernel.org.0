Return-Path: <linux-pci+bounces-33878-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF4DB23332
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 20:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43C1A179919
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 18:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F852DFA3E;
	Tue, 12 Aug 2025 18:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W0PJU9Y0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WvQmd9lb"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94081EBFE0;
	Tue, 12 Aug 2025 18:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755022947; cv=none; b=oqBeTwFVaXJTVUSk+oNEHF9IS4/Cp7snm9/lEPszOAJBdXkALGpSMRI6eeMZaetAlLRbR1San2qc3+nu4YpHWJ3Y/dtbHO/Dy0H+pvKgBKss4MWKQ++pz2aT+lxIoK9WL0zmy9Be2VIaCdUdXzom7Rwki8kSYsVZ+D52Rcj7uGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755022947; c=relaxed/simple;
	bh=p/3UD5jav3q32TaAM30o1fI04zVNZZyMfypSSa78HPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQOEJLMJRj5opximw7nMneyVybL31LvdICgl7nav0sVa+/AHQEDzxydqIoqqur6Xdbbcs7bgMxAOGrEWd9AxN3B0gsKovBtOBeKottBLbG2GAe/irdZY+iVWDRjL5Ky//TZLdymPx/1NVaOiPY667aH6NttKjpnX3aMVH05B7RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W0PJU9Y0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WvQmd9lb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 12 Aug 2025 20:22:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755022943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jxlU+znl/JTn8im/jrvMANP+QmBATT55GjJL6MNB2U0=;
	b=W0PJU9Y0mwFXzoNEYmmWJ9DEaVd18sk5xZhfL5P6+SPy/UiH96Z3lwfGfxX0XukryhTCCt
	BZqnOOBlkpLfNKaJgsY+2/RQYhMJlBV6VyncN5syQGvRjC50tBBIL7xXB5c8qNnPUF1nor
	DrzE/x1ETcN9nIlroHk2RBBiVJMRkWhgffdXx+WJSs46rdW8MCwnDTmHmitymuhHMXcy+S
	yclwkc14SY9Xnzf0hJ+tWOqgfn0Bo+xF6LA8rATGOK9vR+KCkMTPemRJKE+stAu/RslAHi
	eMtDvREiZqr/88kERqWShhUBJWbFgjK8zWbpl5yiYq5casOfpD1trpkH++Hx6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755022943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jxlU+znl/JTn8im/jrvMANP+QmBATT55GjJL6MNB2U0=;
	b=WvQmd9lbZTxISl3kvoyVzLH6spl7ILIfdAMDjJgeJRmHAqvHS2BR7rQ9CXzOO4ofU3Kwnh
	lXe4Kxy5BgpumeCg==
From: Nam Cao <namcao@linutronix.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?iso-8859-1?Q?Wilczy=B4nski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: Re: [PATCH] PCI: vmd: Remove MSI-X check on child devices
Message-ID: <20250812182209.c31roKpC@linutronix.de>
References: <aJtUjnuWr1S31jhX@kbusch-mbp>
 <20250812163015.GA194338@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812163015.GA194338@bhelgaas>

On Tue, Aug 12, 2025 at 11:30:15AM -0500, Bjorn Helgaas wrote:
> On Tue, Aug 12, 2025 at 08:49:50AM -0600, Keith Busch wrote:
> > The doc you linked is riddled with errors. The original vmd commit
> > message is more accurate: VMD domains support child devices with MSI and
> > MSI-x interrupts. The VMD device can't even tell the difference which
> > one the device is using. It just manipulates messages sent to the usual
> > APIC address 0xfeeXXXXX.
> 
> Thanks, Keith!  I updated the commit log like this:
> 
>   d7d8ab87e3e7 ("PCI: vmd: Switch to msi_create_parent_irq_domain()") added a
>   WARN_ON sanity check that child devices support MSI-X, because VMD document
>   says [1]:
> 
>     Intel VMD only supports MSIx Interrupts from child devices and therefore
>     the BIOS must enable PCIe Hot Plug and MSIx interrups [sic].
> 
>   However, the VMD device can't even tell the difference between a child
>   device using MSI and one using MSI-X.  Per 185a383ada2e ("x86/PCI: Add
>   driver for Intel Volume Management Device (VMD)"), VMD does not support
>   INTx interrupts, but does support child devices using either MSI or MSI-X.
> 
>   Remove the sanity check to avoid the unnecessary WARN_ON reported by Ammar.

Minor correction, it is not just an unnecessary WARN_ON, but child devices'
drivers couldn't enable MSI at all.

So perhaps something like "Remove the sanity check to allow child devices
which only support MSI".

Thank you both,
Nam

