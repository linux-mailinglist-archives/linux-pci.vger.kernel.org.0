Return-Path: <linux-pci+bounces-32912-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EF0B116C4
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 04:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2E0D7B2744
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 02:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F92236431;
	Fri, 25 Jul 2025 02:57:58 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D16EEAB;
	Fri, 25 Jul 2025 02:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753412278; cv=none; b=byIDUmm3qaalDQUmEqwxRjJEij1KF4KktwW9d1NL/fEtLfNO5p0tuPbID8SWd9DgpKOEGrRCpxuR5T05Ob3ZwsAibblgQK80bv7Gue8scGFhSax+ocnjO3cOL9d34OzAHDWxMchnqCEp99LwjHFpc2/BhNZLnHlKk+7ycYU41Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753412278; c=relaxed/simple;
	bh=f/UMZbY8MC7A9ZUgJjvAh4CyHHxUWCBuESUtGELKnZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E/o2EuIwWXX2z4AkhCHd4jtxKbDxCvgwbPHug8G+GZwLNKis3+n1a1xr8oWZNXfTY8p4YHS/ViOIQ6QQj4foZTcrrwSf7QQ6sEVNKh0OZUXbXNTLaPWxWxWQUn9fcNaNI1RvUGtx17HZ7SmGEpHka26KfsmBuQyHqtugJ+xJgQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 313E180318;
	Fri, 25 Jul 2025 02:57:53 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 8E26B20027;
	Fri, 25 Jul 2025 02:57:48 +0000 (UTC)
Date: Thu, 24 Jul 2025 22:57:52 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: kernel test robot <lkp@intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
 lukas@wunner.de, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-edac@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 helgaas@kernel.org, ilpo.jarvinen@linux.intel.com, mattc@purestorage.com,
 Jonathan.Cameron@huawei.com, oe-kbuild-all@lists.linux.dev,
 tony.luck@intel.com, bp@alien8.de, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, oleg@redhat.com, naveen@kernel.org,
 davem@davemloft.net, anil.s.keshavamurthy@intel.com, mark.rutland@arm.com,
 peterz@infradead.org, tianruidong@linux.alibaba.com
Subject: Re: [PATCH v9 2/2] PCI: trace: Add a RAS tracepoint to monitor link
 speed changes
Message-ID: <20250724225752.42af5c45@gandalf.local.home>
In-Reply-To: <4b41e3e2-ebac-48c3-b1a3-ce24a5bed475@linux.alibaba.com>
References: <20250723033108.61587-3-xueshuai@linux.alibaba.com>
	<202507240322.nJGdyXsy-lkp@intel.com>
	<20250724100659.697b5972@batman.local.home>
	<4b41e3e2-ebac-48c3-b1a3-ce24a5bed475@linux.alibaba.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: sss3io6n3hnw8p43h7pfm1f4x44m5jxe
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 8E26B20027
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19jcfMhVBqN8ygImD+nGXKd/1XxI6VLNn0=
X-HE-Tag: 1753412268-21638
X-HE-Meta: U2FsdGVkX1/MPnrqv2eLnEQVG0SZ4y+N9BHa2JgS74m3VvHFSDTZN8JNGPlQP+U89ajIGWgPuyUHqP5bppbe1owxH2xMB+wqWm4JjBTHpQWRyGoL0bXxdySjDa4OEdHrTt/ccSiLL3EZcM1wuAD68TH+IzV6GoRyyrUIGiBSusQxsle59ecfn+mIvYprxYFgQ1oDPYO/Z8c/EIKPtr3SVBRiCdMxnff8AJqAzKA0uz/5wXbKWwtAFzGGW47KsWaK6jvpAjbDEJZSIgLiJVJGTCJp6+8tomBqVuNiG3+ZVdeErH2S8L2mOHc4lSZugts4dUodwhaV9gFOI/oMAz1PLbzyr6NxwXQCEYkSPtTUwvAaGQV42Fsr/A==

On Fri, 25 Jul 2025 10:31:45 +0800
Shuai Xue <xueshuai@linux.alibaba.com> wrote:

> I'm leaning toward option 1 (dedicated trace.c file) as it's the
> cleanest approach and follows the pattern used in other subsystems. Does
> that sound reasonable to you?

That's fine, but make sure you have #ifdef CONFIG_FOO around tracepoints
that are only used when those configs are enabled, otherwise you will get
warnings.

Well, if they are exported, then the warnings are suppressed.

  https://lore.kernel.org/all/20250725025149.726267838@kernel.org/

-- Steve

