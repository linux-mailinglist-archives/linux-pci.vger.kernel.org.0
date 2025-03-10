Return-Path: <linux-pci+bounces-23327-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFD2A5981E
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 15:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDDBF3A5861
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 14:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2B222CBD3;
	Mon, 10 Mar 2025 14:50:48 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249051991CA;
	Mon, 10 Mar 2025 14:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741618248; cv=none; b=gRiHFlvSSbGol3FKzUYGCAXpndHHOQrxAuwBmYF5PqC3qVUsJOoMzrbjVxkYi9fAWhQOmfh3XRqAEydFNeDDS4BVxyMCGnyRXoaYFgdPBylTgNGEV0WGrWdgg9GYaub6DmIpvLmb5ve2vWtO5CRkv6fdbwUz/Y+qupg1bPOnbog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741618248; c=relaxed/simple;
	bh=sJZlHzkYsycOqHKWmwxAlYYEYlLkn+MmH1EaJ4bLWaA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q4FAP2LdK2XapCjuvfpd6abTeT5GM2QayjfObSygnVDEwqje1/SW3jgVDfB5gRSHzQHazoy+rXIdM06I3zBnuMHpmdl5KZn5pfAAamv1kBfT0F3lxNvO4K3k7IafAl6BrWzLFbwmyVbV6o6p54M88fBTrVhdOKnIQ48Ppa2seOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92756C4CEE5;
	Mon, 10 Mar 2025 14:50:45 +0000 (UTC)
Date: Mon, 10 Mar 2025 10:50:44 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: lukas@wunner.de, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, helgaas@kernel.org,
 bhelgaas@google.com, tony.luck@intel.com, bp@alien8.de,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, oleg@redhat.com,
 naveen@kernel.org, davem@davemloft.net, anil.s.keshavamurthy@intel.com,
 mark.rutland@arm.com, peterz@infradead.org, tianruidong@linux.alibaba.com
Subject: Re: [PATCH v5] PCI: hotplug: Add a generic RAS tracepoint for
 hotplug event
Message-ID: <20250310105044.129dc354@gandalf.local.home>
In-Reply-To: <deb6f0c4-77b8-431e-9b81-555a8344c750@linux.alibaba.com>
References: <20250109025543.56830-1-xueshuai@linux.alibaba.com>
	<20250113155503.71467082@gandalf.local.home>
	<deb6f0c4-77b8-431e-9b81-555a8344c750@linux.alibaba.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Mar 2025 11:59:55 +0800
Shuai Xue <xueshuai@linux.alibaba.com> wrote:

> Hi, Steve,
> 
> If I move PCI_HOTPLUG_EVENT into one place, `include/upai/linux/pci.h`,
> I need to include:
> 
>      #include <linux/tracepoint.h>
> 
> Then, kernel build fails with CONFIG_UAPI_HEADER_TEST=y:

Just move the enum definitions, not the entire event file.

That is, have one place has the PCI_HOTPLUG_EVENT macro, and have both the
uapi header as well as the tracepoint header include that header.

I guess I need to see the entire change.

-- Steve

