Return-Path: <linux-pci+bounces-17203-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FDD9D5D47
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 11:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28A41B233CB
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 10:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4D91BE243;
	Fri, 22 Nov 2024 10:29:23 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43926171088;
	Fri, 22 Nov 2024 10:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732271363; cv=none; b=JsSxvQCxd38UWarm8KZFqpKauKcU9MMkI8CocYfowxSJIz4dagj0B0Y+n8onAatXr91XDVY2MoffMjF5ProBd0NIEGQfs3/nvtwASK9Lh60kXYmPJY/CdT3+r76R0ZmLHsS4ykkt9rNkVIpjgfkmun8T532QI2LKoUFnR5eJ4lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732271363; c=relaxed/simple;
	bh=KY6cZV4aUfFBErHosWRZzSawkaV7LS7+XJEKWzxNyRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oOP9c0Fn+PTMCQmEPcuRf5v50VVZ55QeXL8M4CzkYURxpgATep1/iu5F9ZJtttbdQFzQqAc0HvoGOMZNqRN309PrOXzMl8BSeXBjupW0lK4jiF/y1PPoGO6BaA7TnmYzb8doTCkK+eropdUnRNnB/cFPf5zQSmKYpiOc2R+Z/T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 8A3C5102BE4DD;
	Fri, 22 Nov 2024 11:29:16 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 57C351B9BCF; Fri, 22 Nov 2024 11:29:16 +0100 (CET)
Date: Fri, 22 Nov 2024 11:29:16 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bhelgaas@google.com,
	tony.luck@intel.com, bp@alien8.de, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, oleg@redhat.com, naveen@kernel.org,
	davem@davemloft.net, anil.s.keshavamurthy@intel.com,
	mark.rutland@arm.com, peterz@infradead.org
Subject: Re: [PATCH v3] PCI: hotplug: Add a generic RAS tracepoint for
 hotplug event
Message-ID: <Z0Bc_Mws5mD03TMI@wunner.de>
References: <20241120124328.19111-1-xueshuai@linux.alibaba.com>
 <Zz786zZljAy2J5i7@wunner.de>
 <7002248c-f3af-42aa-ba42-a65cd738ae37@linux.alibaba.com>
 <20241121084354.4a554829@gandalf.local.home>
 <Zz-9vviSWP8oRPUx@wunner.de>
 <20241121190826.78506b40@gandalf.local.home>
 <e96ed0ee-01c8-4429-a903-17bc7813d78a@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e96ed0ee-01c8-4429-a903-17bc7813d78a@linux.alibaba.com>

On Fri, Nov 22, 2024 at 02:25:33PM +0800, Shuai Xue wrote:
> Agreed. pci_hp_event is more reasonable. Than is:
> 
> - system: pci
> - event: pci_hp_event
> 
> /sys/kernel/debug/tracing/events/pci/pci_hp_event
> 
> @Lukas, if you have any other concerns, please let me know.

This LGTM, thank you.

