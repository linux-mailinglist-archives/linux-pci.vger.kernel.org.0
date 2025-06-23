Return-Path: <linux-pci+bounces-30380-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5916DAE3F55
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 14:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE23A3A8079
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 12:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC36725F97E;
	Mon, 23 Jun 2025 12:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGmzM/Oc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8824425F7BB
	for <linux-pci@vger.kernel.org>; Mon, 23 Jun 2025 12:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750680115; cv=none; b=jtl38qsA68j+xY27BS3DNeUazX/LQXQrq3FI+LaTyh7SYp9FeQT9zYBcHQV7rZS1gK/jGoG9Yx2pbZePIoSdgDYKfbuQ42Aea47V00Wwth2LZDXv8p47/2wYAAxT8uplwJtn/6eG/85V0tXXSD+Wm9R4spk/FWchGwit1WvnqxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750680115; c=relaxed/simple;
	bh=237k/B75nd/ON3SgY7lpkxZdavMaMv3QQ1vBrgBv1gA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QtB8TP9bo6cPAcmcOjN+xgYqQFapkHoX6VPNjnIbVX1HnV35Zd/wXQJRPCFbjs5B6TZ5KC7lWcN7sne39Pz6P43Gw/hAlxKnVOc0Lnmhyfea9SXGzDxfFcgMMTCEpZNLuhMH1dtepu03WsTuCa/zVwEcNGw3nvAJXxz2uRFyvyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGmzM/Oc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31947C4CEEA;
	Mon, 23 Jun 2025 12:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750680115;
	bh=237k/B75nd/ON3SgY7lpkxZdavMaMv3QQ1vBrgBv1gA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZGmzM/Ocqt4dgPCtAyBmrgfj45+TAtuG9gENeT+apx0Y+pZGAhnABhG2wkRoYdZyY
	 F2cplO3CUIq4EdP7vqywjFb6hv1/dB5elCe5SBLJL7I6pAvw91S0mfCGHmtEqUPiPl
	 crnUuSbQkCOdHdghDc1GJY1UVqkQXUk7AwefEphYhEODhj/raY9XE2ynqzfOoJ7v8g
	 oBjUCPxAFKNgrFE4E9gDfYpreoNLfRJwFHN/7RCQwct/qUYB/9mh8zrCamfreshbaK
	 fb/RsH3xrqijHbi09bEmD/6TMa8epQOqKrfQ2sChp+M9Qa4zKW8xC5GKn73lgAGOir
	 UvZphW2vlfUvg==
Message-ID: <011c4c6d-ebff-46e4-b32f-f93eb88dd82d@kernel.org>
Date: Mon, 23 Jun 2025 21:01:53 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: endpoint: Fix configfs group removal on driver
 teardown
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-pci@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>
References: <20250617010737.560029-1-dlemoal@kernel.org>
 <aFklrtQTwqKhOl39@ryzen>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <aFklrtQTwqKhOl39@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/23/25 19:00, Niklas Cassel wrote:
> Hello Damien,
> 
> On Tue, Jun 17, 2025 at 10:07:37AM +0900, Damien Le Moal wrote:
>> An endpoint driver configfs attributes group is added to the
>> epf_group list of struct pci_epf_driver pci_epf_add_cfs() but not
>> removed from this list when the attribute group is unregistered with
>> pci_ep_cfs_remove_epf_group(). Add the missing list_del_init() call in
>> that function to correctly remove the attribute group from the driver
>> list.
> 
> This seems like a bug (bug #1).
> 
>>
>> Furthermore, doing a list_del() on the epf_group field of struct
>> pci_epf_driver in pci_epf_remove_cfs() is not correct as this field is a
>> list head, not a list entry, and triggers a KASAN warning:
> 
> This seems like another bug (bug #2).
> 
> 
> I do understand that both bugs were introduced by the same commit.
> 
> However, since it is two separate bugs, I personally think that they
> deserve two separate patches (even if they will have the same Fixes tag).
> 
> 
>>
>> ==================================================================
>> BUG: KASAN: slab-use-after-free in pci_epf_remove_cfs+0x17c/0x198
>> Write of size 8 at addr ffff00010f4a0d80 by task rmmod/319
>>
>> CPU: 3 UID: 0 PID: 319 Comm: rmmod Not tainted 6.16.0-rc2 #1 NONE
>> Hardware name: Radxa ROCK 5B (DT)
>> Call trace:
>> show_stack+0x2c/0x84 (C)
>> dump_stack_lvl+0x70/0x98
>> print_report+0x17c/0x538
>> kasan_report+0xb8/0x190
>> __asan_report_store8_noabort+0x20/0x2c
>> pci_epf_remove_cfs+0x17c/0x198
>> pci_epf_unregister_driver+0x18/0x30
>> nvmet_pci_epf_cleanup_module+0x24/0x30 [nvmet_pci_epf]
>> __arm64_sys_delete_module+0x264/0x424
>> invoke_syscall+0x70/0x260
>> el0_svc_common.constprop.0+0xac/0x230
>> do_el0_svc+0x40/0x58
>> el0_svc+0x48/0xdc
>> el0t_64_sync_handler+0x10c/0x138
>> el0t_64_sync+0x198/0x19c
> 
> This KASAN splat seems to belong to bug #2.
> 
> 
> 
> I think it is a litte bit confusing that you attach a KASAN
> splat to a patch that fixes two different bugs.
> 
> Surely this KASAN bug can be fixes with only:
> 
> -     list_del(&driver->epf_group);
> +     WARN_ON(!list_empty(&driver->epf_group));

Yes, with that, you will not get the KASAN warning, but you will get the
WARN_ON() to trigger unless bug #1 is applied first. But if you apply #1 first,
then any testing done with that bug fix only will trigger a NULL pointer
de-reference on the list_del().

For this reason, I very much dislike the idea of splitting this patch into 2
different patches as the bugs are inter-dependent.

Unless Mani insists on a split, I will not do it.

> So I think it would make more sense if the patch that fixes the KASAN splat
> includes only the changes that are needed to fix the KASAN splat, and then
> for the other bug, create a different patch that will then have a clearer
> commit message (because it will not have an unrelated KASAN splat in it).

Again, no. I do not like this idea. I can improve the commit message to explain
that more clearly though.


-- 
Damien Le Moal
Western Digital Research

