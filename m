Return-Path: <linux-pci+bounces-30483-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB251AE5FAC
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 10:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD92E1921536
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 08:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9249026A1B6;
	Tue, 24 Jun 2025 08:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fxz306EQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBA126AABD
	for <linux-pci@vger.kernel.org>; Tue, 24 Jun 2025 08:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750754537; cv=none; b=UEgh4er/eAi1gva/8mPSJsT1f7gteqoemrmBUC7jcS4vdyIaH0B+4sZ8KPCb7ijMRTinwyqaxxMWXLqR04OO+ePU71bdNNM3+fgkxEzeaIAdQ0G7Pwmw7g6h9PsILbivG8qOad7lbDK7+o6KiHzJ6ZBdPBzWWmVGw6Fw7kchwBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750754537; c=relaxed/simple;
	bh=3Tl50QRot2WkIvfokK9qdj1BSMDotYIDGEiBd31Bkl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tsJ1k/7XUip6L7ZYJC82BgUjI4F8l7F4G6W9qyW9GjGDj93lLgwM2MTxQn16XcuGB9YNOzf8bUwnuekIqqhTYUsyRkSv+uIgLGmS/lvWrsiQa+GqZyElL6clUQSDq8WBApmofjAMRVf1iPL1gR4Hb4hGC/jWN+TJXBWtK80+kx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fxz306EQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B46CDC4CEF4;
	Tue, 24 Jun 2025 08:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750754537;
	bh=3Tl50QRot2WkIvfokK9qdj1BSMDotYIDGEiBd31Bkl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fxz306EQtGYag/EotFTjrjzKzHD8uzWx39k+A2B3J2B5A+zWQPx0CHb8bjcjp3JVX
	 QjeN9Cq+RLbscv44UmZ0dw0kpz87To7a+XaFxxUlYVKdbIEZ8//QKhUvq705bVSpBR
	 mT0eXLwRx9OciQZ9P75mN1uilxnw388SXPCbs4e6g3iBxezxZ0NOZfW3P072OnrFAV
	 fHvi8aDJly7+uGOAOptQpb54xbpu47l89ZdRfULSXxxQ+RhzkHJPLI3BQomNKU1Kbd
	 dg0lQ4gPGD+eDOwdZWeS9kuPjYE7hlitSP0yBDFkQUOh/q7VwXohLe+RzdGZf5AgXJ
	 uYAbScb17TCeg==
Date: Tue, 24 Jun 2025 10:42:13 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-pci@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 1/2] PCI: endpoint: Fix configfs group list head
 handling
Message-ID: <aFpk5Yv9tn_mW8Ht@ryzen>
References: <20250624081949.289664-1-dlemoal@kernel.org>
 <20250624081949.289664-2-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624081949.289664-2-dlemoal@kernel.org>

On Tue, Jun 24, 2025 at 05:19:48PM +0900, Damien Le Moal wrote:
> Doing a list_del() on the epf_group field of struct pci_epf_driver in
> pci_epf_remove_cfs() is not correct as this field is a list head, not
> a list entry. This list_del() call triggers a KASAN warning when an
> endpoint function driver which has a configfs attribute group is torn
> down:
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in pci_epf_remove_cfs+0x17c/0x198
> Write of size 8 at addr ffff00010f4a0d80 by task rmmod/319
> 
> CPU: 3 UID: 0 PID: 319 Comm: rmmod Not tainted 6.16.0-rc2 #1 NONE
> Hardware name: Radxa ROCK 5B (DT)
> Call trace:
> show_stack+0x2c/0x84 (C)
> dump_stack_lvl+0x70/0x98
> print_report+0x17c/0x538
> kasan_report+0xb8/0x190
> __asan_report_store8_noabort+0x20/0x2c
> pci_epf_remove_cfs+0x17c/0x198
> pci_epf_unregister_driver+0x18/0x30
> nvmet_pci_epf_cleanup_module+0x24/0x30 [nvmet_pci_epf]
> __arm64_sys_delete_module+0x264/0x424
> invoke_syscall+0x70/0x260
> el0_svc_common.constprop.0+0xac/0x230
> do_el0_svc+0x40/0x58
> el0_svc+0x48/0xdc
> el0t_64_sync_handler+0x10c/0x138
> el0t_64_sync+0x198/0x19c
> ...
> 
> Remove this incorrect list_del() call from pci_epf_remove_cfs().
> 
> Fixes: ef1433f717a2 ("PCI: endpoint: Create configfs entry for each pci_epf_device_id table entry")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>

