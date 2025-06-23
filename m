Return-Path: <linux-pci+bounces-30357-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAE3AE3B81
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 12:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBB311898B9D
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 10:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306FD23AE9B;
	Mon, 23 Jun 2025 10:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGQ+zyxW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC3923A9AC
	for <linux-pci@vger.kernel.org>; Mon, 23 Jun 2025 10:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750672818; cv=none; b=XaL0XHmKwz4Fge4rJxI8WHT+WtICxVQhNEXYPgDrcZ0FxjKMuukYOHi8GHWf+Uk01zcrVAlCepvocihLxOD+kxajSK8Q60wYa1S/rdCTmoAjzo3z/+3WaKRmyF+ike5BGF+YQmj7XZFgfLOxQktblyaV1cpcSVvdqpTtIwTb3uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750672818; c=relaxed/simple;
	bh=fEbRPQ4hEvdurfoPEsqe5jAaXK+4OgLHRXutJScJZmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GYNq2t18Z936x5Wg9IORWgHtcE1QAUhEsaR6x137ih/gC+eiAAISffSvt4U4EgeSMwrj0jCPxHaVA2LQ3HGainJNxwNw+rL+XxQ9CPo6KX9NjXipeNKa3+46zdhlmZaOQgHPzYKT6hBRQhwoP2zbmEnK32Zrr/7Oec1dQfVNw5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGQ+zyxW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4756DC4CEEA;
	Mon, 23 Jun 2025 10:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750672817;
	bh=fEbRPQ4hEvdurfoPEsqe5jAaXK+4OgLHRXutJScJZmg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FGQ+zyxW1F5Oy8JXNUOBh/kegtLfj17Wy/ltVxDrH+9PfBnyaQNkopnwZ7q9ToQGv
	 6Xb8fg96CkILJGlbZAjT7s3FBth23A8J6ymqa+6+FitreMlSPHd0KGol2YQlCOY+C1
	 LqhJ41271HV5s6SGMhkE/Z0xxtLIRBYA84BGBqyEnOEgVPujyWviSQolR/NVC9ubMN
	 h9RrbqIAcqDt70GifWSNasSK2Bpsq4xlpM2ZvEQ3HouebdtCQ6XYYp0xELWAePQgQ6
	 9CxvXMfRbpntw6lNKkHD+9Ba8YT84EJjWW1PZkTpgltCmAkMrANbQpT5BxJ+ZWxu/O
	 pDLtA6pM5guhw==
Date: Mon, 23 Jun 2025 12:00:14 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-pci@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: endpoint: Fix configfs group removal on driver
 teardown
Message-ID: <aFklrtQTwqKhOl39@ryzen>
References: <20250617010737.560029-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617010737.560029-1-dlemoal@kernel.org>

Hello Damien,

On Tue, Jun 17, 2025 at 10:07:37AM +0900, Damien Le Moal wrote:
> An endpoint driver configfs attributes group is added to the
> epf_group list of struct pci_epf_driver pci_epf_add_cfs() but not
> removed from this list when the attribute group is unregistered with
> pci_ep_cfs_remove_epf_group(). Add the missing list_del_init() call in
> that function to correctly remove the attribute group from the driver
> list.

This seems like a bug (bug #1).

> 
> Furthermore, doing a list_del() on the epf_group field of struct
> pci_epf_driver in pci_epf_remove_cfs() is not correct as this field is a
> list head, not a list entry, and triggers a KASAN warning:

This seems like another bug (bug #2).


I do understand that both bugs were introduced by the same commit.

However, since it is two separate bugs, I personally think that they
deserve two separate patches (even if they will have the same Fixes tag).


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

This KASAN splat seems to belong to bug #2.



I think it is a litte bit confusing that you attach a KASAN
splat to a patch that fixes two different bugs.

Surely this KASAN bug can be fixes with only:

-     list_del(&driver->epf_group);
+     WARN_ON(!list_empty(&driver->epf_group));


So I think it would make more sense if the patch that fixes the KASAN splat
includes only the changes that are needed to fix the KASAN splat, and then
for the other bug, create a different patch that will then have a clearer
commit message (because it will not have an unrelated KASAN splat in it).


Kind regards,
Niklas

