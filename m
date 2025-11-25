Return-Path: <linux-pci+bounces-42022-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C388C84372
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 10:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AC2FD34E055
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 09:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679082D5932;
	Tue, 25 Nov 2025 09:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Ujh5Xxgt"
X-Original-To: linux-pci@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44E1269B1C;
	Tue, 25 Nov 2025 09:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764062836; cv=none; b=fGfB0qmTBDxxexsfqLg1AK100CCVnDKRZUQHRAHtahcZ3v4KR5grV/OkzSTCsz50TIdLg3wUivBP77ZrouY/wd/FxMv/SDtiK6Q8RpqEtZk2Nxn2c8x+zY4ku9y9XTwmF+Ajt7hxoOG9sOBHee5vFxppyRs1pHXZ6ohsHxhP10k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764062836; c=relaxed/simple;
	bh=9fsfpjAM2+mQ4S4GAkoN+7jqNZGufRMjtus1fCgCMqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HwR4Vbuv9pVfdwJPCtTbTcpCKpopE/8Nqk6F6O0sVQ7Gc1vA8jnJprp3MZ5XuiigMhmoBwbV2s+/yQshXJFTaXiW74jb7HIkPl8+hUKKjBugDnQXt+c3wvPTU9QHES0aFAcYP616SxuANPibzSwll6hPhJYm0QHOgS5rw7obsUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Ujh5Xxgt; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=k/+2LtzZDQDT/XIIJmpYRUvrcP2KDj85kUn+MGkQNJM=; b=Ujh5XxgtWd8jr9zZcd2oA5syOx
	Cwt9IJjcT2z4O5nC1oTDkZz2phCS+d5yfzIkGRu+3qoqEO2RlWYiUacquZZfBmTVSUBoRbs2suKMb
	tgNMMpisQA++79/GIAH54dlpgo6eDFiYCm+51O/uVjZGIk4WsbQUyxEdYxcDg802H6xhoFfnanQHH
	9ssOiu60VP0hjxpyMc5BSbNgLUL69A3AfZGGp6YTPhBEe6KGim/4BfYTG36omzLqBzqEPxcbwEr1u
	RUnLeqwU2gSJrzxpg6hLMJbWkXHRZJ1RayRA4ZqkwA+pmawb3gg1rEUtggbyAIsM1erOI2idwpGJb
	W3EEC88g==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vNpKA-003ICO-9j; Tue, 25 Nov 2025 09:27:02 +0000
Date: Tue, 25 Nov 2025 01:26:55 -0800
From: Breno Leitao <leitao@debian.org>
To: Borislav Petkov <bp@alien8.de>, akpm@linux-foundation.org
Cc: tony.luck@intel.com, akpm@linux-foundation.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev, 
	osandov@osandov.com, xueshuai@linux.alibaba.com, konrad.wilk@oracle.com, 
	linux-edac@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
	kernel-team@meta.com, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>, 
	Robert Moore <robert.moore@intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Hanjun Guo <guohanjun@huawei.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH RESEND v5] vmcoreinfo: Track and log recoverable hardware
 errors
Message-ID: <zbqtqndpicedldf37c7t74cikasqruzkv2rqt2eh6ufjbj4exb@3p7ajieb6ovr>
References: <20251010-vmcore_hw_error-v5-1-636ede3efe44@debian.org>
 <vpilvvscosdl4o4cvbmtsrrp4btfwr5iidywmuiawfrgtlcwrr@ubtdbxfqyqpu>
 <20251118141002.GEaRx-Oge8ZxtR4Vzi@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118141002.GEaRx-Oge8ZxtR4Vzi@fat_crate.local>
X-Debian-User: leitao

Hello Andrew,

On Tue, Nov 18, 2025 at 03:10:02PM +0100, Borislav Petkov wrote:
> On Tue, Nov 18, 2025 at 05:01:47AM -0800, Breno Leitao wrote:
> > Do you know what is the right tree for this patch?
> > 
> > I am wondering if it should go through Kdump, x86 or RAS/MCE tree?
> 
> I can take it if akpm wants me to...

Would you prefer to have this patch on your tree, or on Borislav's?

Thanks
--breno

