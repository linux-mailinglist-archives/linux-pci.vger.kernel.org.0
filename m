Return-Path: <linux-pci+bounces-2111-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAFE82C31E
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 16:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72B351F24FD9
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 15:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E2B6EB68;
	Fri, 12 Jan 2024 15:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4N8l/0GP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4CITCkRg"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD4C6E2C7;
	Fri, 12 Jan 2024 15:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705074808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YCUv4QD3m4qLNZG02uewh/6SZ5moAHjrquOh0sYfrIk=;
	b=4N8l/0GPCLeFqCcRf8EEXw/ERWD4S3cJmBEsgCCDnnixeNbE49Fz+CjUCWnanmNB80C6lS
	gvLpUBdj0TcPvjjVLYhmlMCUUkf/17Pio2Ug73x9ndFMcXt31L3Y2DNsJ3xlfTgmNbedvP
	37TW9pCz5S9fe0vQ5NXSXR0RAlKal72sMb7r2bvR2DigLu5fkyDjHsH2z+hy+KeTb931kV
	9J7/ItVk14cEN9Ad1b+6Zay4eQ1zcBQNT5QZlv3FpkKJhiANjHDuR6gnf3SoX0i8zsp4xa
	CxVu8XdZ1oYDJx+RGXGm/JXedqaENb3lNRZVKIQ9TRB7YjaxoSMw4cI6d1yPuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705074808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YCUv4QD3m4qLNZG02uewh/6SZ5moAHjrquOh0sYfrIk=;
	b=4CITCkRgGXuMgHHvP4EOiVQ0hY0q/EDh+yJQjmMOBUe7pOj2fY+M76/yy2h1mT6ZGIzNN5
	wXaD7VFyRM+RAsBA==
To: Vidya Sagar <vidyas@nvidia.com>, bhelgaas@google.com,
 rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com,
 jiang.liu@linux.intel.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 treding@nvidia.com, jonathanh@nvidia.com, sdonthineni@nvidia.com,
 kthota@nvidia.com, mmaddireddy@nvidia.com, vidyas@nvidia.com,
 sagar.tv@gmail.com
Subject: Re: [PATCH V3] PCI/MSI: Fix MSI hwirq truncation
In-Reply-To: <20240111052814.713016-1-vidyas@nvidia.com>
References: <20240108120522.1368240-1-vidyas@nvidia.com>
 <20240111052814.713016-1-vidyas@nvidia.com>
Date: Fri, 12 Jan 2024 16:53:26 +0100
Message-ID: <87bk9qim4p.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jan 11 2024 at 10:58, Vidya Sagar wrote:
> While calculating the hwirq number for an MSI interrupt, the higher
> bits (i.e. from bit-5 onwards a.k.a domain_nr >= 32) of the PCI domain
> number gets truncated because of the shifted value casting to return
> type of pci_domain_nr() which is 'int'. This for example is resulting
> in same hwirq number for devices 0019:00:00.0 and 0039:00:00.0.
>
> So, cast the PCI domain number to 'irq_hw_number_t' before left shifting
> it to calculate hwirq number.

This still does not explain that this fixes it only on 64-bit platforms
and why we don't care for 32-bit systems.


