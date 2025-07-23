Return-Path: <linux-pci+bounces-32838-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 950F5B0FA93
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 20:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 942233B5F59
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 18:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D7622B8D9;
	Wed, 23 Jul 2025 18:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="WNhhE56j"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8A02222CA;
	Wed, 23 Jul 2025 18:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753297172; cv=none; b=k+rFJWC6axCMtsw2JM62oip/t60jxUXll2Yfk6oxG6ppq6Wsypmk8l2YQY/YdZzrv6FQcj1C+5dAoHhsh2emcjOnR1Qpe3HIs1ZuSkIe+6dJw3eR1smbHS/pSe1+FHqkRi7VOY0qtKrIh4oJib7U2CLVUYsOG3CwF9W5F1ZuU0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753297172; c=relaxed/simple;
	bh=YMmKd8UC5P21tTrV/oIf5AKV3dDkkV89/6bPT5QQSlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nxFQ0i7iZHMVLwkIjECTSrGdgR1yb3ZdTIaDkwTv3cwx0iAX6PPJZzdOJ4SIXFse23wIptE+Ra57TfjqXflYCLf1aVZMgPrZsKM+Kb9cxUegRrQPkHYQqEumZa6Kp5iTC9M7NezCzzrlCeSxUP7yTSh+ThBusLICWIFFnfvmskI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=WNhhE56j; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C1C1740E0163;
	Wed, 23 Jul 2025 18:59:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id NV1TOurcSxM6; Wed, 23 Jul 2025 18:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1753297157; bh=3/iUg3kpzsiZrZyEgEoQDrYxpq8863x42bI2MvnPvd8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WNhhE56jaVQu8KmDXYrC1yQdKtIH4nMnxxKq6HHMfPn3KWLUYHkITgL5pmZOmECm2
	 qIx5yZsp9NhxWPtrmSuKgpzrdK+6tDoipIeQAsybPeBFHe8nsxHbu9eGiRUwKvN35I
	 moWd3v49g+xVRScU8E2A1IRcf9nJuTnXJf0IoCcR5ViZ97oHkY2LPBNpggxXfI8909
	 KElCdwzek1ygeNaV95IzQSFtsYmW6y8EmMOZaOMj7eOAXvijsv9rBOh2DZ3mFNzXuu
	 ZF+l+TxcKo2TiX2+lIhI3pFmBVZA83e5J1tRBwTLfOopbAJnkvNL9m60r/t253U8pg
	 q/8ZlCL3IKF5Fg+PYg5+iDhJ3zt+Grhz4SPpVg3gvV2nq1fO3tKXzlnUZTy76DuQqZ
	 8w5WlekiffnTR7PRFrECf+uRApDOGb6dhTBLovo+ph+FCh/pMiKZbcADaVPA9P6JDc
	 pDVpuaKA19Snh/y1Uoa6TATlcEZ6FfJ1U2zkredBLcHM+xaX/TaPvBxUquapEQtLZw
	 bz3KciijHf7kc2P7gju5ur8KnwqmE+AAwyZx7tJYAGWAqA7ro+T4GvvI9YCkERW2Or
	 kRbhhGcn+OTYKMO/PQ2vTfHBNSTB5iEv+4o44KOwVfGCIiShLJhDiCKGmo+1U0Em4x
	 mws8PKuTNcbxgVonXq9TlbUc=
Received: from rn.tnic (unknown [78.130.214.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id C25CE40E0254;
	Wed, 23 Jul 2025 18:58:47 +0000 (UTC)
Date: Wed, 23 Jul 2025 21:00:48 +0200
From: Borislav Petkov <bp@alien8.de>
To: Breno Leitao <leitao@debian.org>
Cc: kernel test robot <lkp@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
	Tony Luck <tony.luck@intel.com>,
	Robert Moore <robert.moore@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Bjorn Helgaas <helgaas@kernel.org>, oe-kbuild-all@lists.linux.dev,
	linux-media@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev,
	osandov@osandov.com, xueshuai@linux.alibaba.com,
	konrad.wilk@oracle.com, linux-edac@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v3] vmcoreinfo: Track and log recoverable hardware errors
Message-ID: <20250723190048.GBaIExYJYiHWnSBFye@renoirsky.local>
References: <20250722-vmcore_hw_error-v3-1-ff0683fc1f17@debian.org>
 <202507232209.GrgpSr47-lkp@intel.com>
 <cdlrppnrheyq7z3gmwmwsmktpmoiwq7g5hxa67rcx4iem5i6ge@jksa5o5use4w>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cdlrppnrheyq7z3gmwmwsmktpmoiwq7g5hxa67rcx4iem5i6ge@jksa5o5use4w>

On Wed, Jul 23, 2025 at 08:36:52AM -0700, Breno Leitao wrote:
> Basically there are two approaches, from what I understand:
> 
> 	1) mark do_machine_check() as noinstr

do_machine_check is already noinstr. I think you mean mark
hwerr_log_error_type() noinstr.

And yes, you can mark it. hwerr_log_error_type() is not that fascinating
to allow instrumentation for it.

> 	2) Move hwerr_log_error_type() earlier inside the
> 	instrumentation_begin() area.

Or you can do that - that looks like less of an effort btw.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

