Return-Path: <linux-pci+bounces-27384-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A368AAE4EE
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 17:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F85A3AB19C
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 15:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801FF289346;
	Wed,  7 May 2025 15:36:33 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56005748D;
	Wed,  7 May 2025 15:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746632193; cv=none; b=rY19VgLP1z7neelijMziTvMVlD0TJNt92EWu3UWwv7YhgciIcI8sbzs2mbFvJgzcoKc3WTGupY1Pt6x6mQPtylzBbgvqAT3xTaYdYqwhVXYNcP4K/cqXAgS1mTdeUzw1+HqqHFQ3td1L61Non9j83D/t3gQPxdISNlvxUrPeXPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746632193; c=relaxed/simple;
	bh=AqeGKYZmJoJGYyMkrFh3sxPaKMjEoYRtVwnLWT9e0dk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZAAnid/JQImvcp+n24avP2Hz0QdYvJe9l4zDLFIiWCC9iHh8C9tsHqkK0oadn5w++Uloi6pgqCyhWFoh8q42sw+NaRCkHU4ErRgemXZPwGFXKjQlX5DVcBOTdP3gRzHE64TypdZGwYiNPlvPwOXSW7azPq+523v6vL0IsD4z3gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D32C4CEE2;
	Wed,  7 May 2025 15:36:29 +0000 (UTC)
Date: Wed, 7 May 2025 11:36:40 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: lukas@wunner.de, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, helgaas@kernel.org,
 bhelgaas@google.com, tony.luck@intel.com, bp@alien8.de,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, oleg@redhat.com,
 naveen@kernel.org, davem@davemloft.net, anil.s.keshavamurthy@intel.com,
 mark.rutland@arm.com, peterz@infradead.org, tianruidong@linux.alibaba.com
Subject: Re: [PATCH v7] PCI: hotplug: Add a generic RAS tracepoint for
 hotplug event
Message-ID: <20250507113640.0b27d95f@gandalf.local.home>
In-Reply-To: <20250507011535.43800-1-xueshuai@linux.alibaba.com>
References: <20250507011535.43800-1-xueshuai@linux.alibaba.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 May 2025 09:15:35 +0800
Shuai Xue <xueshuai@linux.alibaba.com> wrote:

> +#endif /* _TRACE_HW_EVENT_PCI_HP_H */
> +
> +#undef TRACE_INCLUDE_PATH
> +#define TRACE_INCLUDE_PATH  ../../drivers/pci/hotplug

Note, this is not always safe to do. If "drivers", "pci" or "hotplug" ever
become a macro, the path will also be updated, and this will fail to build.

> +#undef TRACE_INCLUDE_FILE
> +#define TRACE_INCLUDE_FILE trace
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> diff --git a/include/uapi/linux/pci.h b/include/uapi/linux/pci.h

The safer way to do this is to have:

In drivers/pci/hotplug/Makefile:

CFLAGS_pciehp_ctrl.o := -I$(src)

And replace the TRACE_INCLUDE_PATH to:

#define TRACE_INCLUDE_PATH .

-- Steve

