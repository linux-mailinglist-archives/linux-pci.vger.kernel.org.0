Return-Path: <linux-pci+bounces-38231-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47416BDF1BB
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 16:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 031D13A3885
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 14:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24289296BB4;
	Wed, 15 Oct 2025 14:38:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2223E14EC73;
	Wed, 15 Oct 2025 14:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760539080; cv=none; b=Kq7yhQVeTPlidkxUs6VA/cSCJBnDfydgLxPPb5o/AXOYqmAk9hfVvsxLZO+yEW4gZVDoB6A8hZeX19k9U73rypadyr5VJXiUouVjb35SCSnvivy2hVznj0W14Y4zfFurkg0vw2nqjmPHh1nUXe/qHweejIJY+um0q0fFuogLzc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760539080; c=relaxed/simple;
	bh=7+N5SWsjXq7OvvmdSpCwATxCuNTmb8GbyyWKfzzTEsw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bzDrqh9vSStA3qpVDYWwk+INd+9sPsY27eTTYPrwPXbNLWwSHXaUbgZkdEGVjxWys3ZKS0Uxmbb5uagXaSxhqyHESZuZpvLZQK/e/jP2InCxyuNb7zkeqgoFdirC3KMm6dUhsbOKUH+DorvS6WzWRd1DvZc5iIVa/RYiBdPyDpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id B7E6A1A0172;
	Wed, 15 Oct 2025 14:37:53 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 45CEE6000F;
	Wed, 15 Oct 2025 14:37:49 +0000 (UTC)
Date: Wed, 15 Oct 2025 10:37:57 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: lukas@wunner.de, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, helgaas@kernel.org,
 ilpo.jarvinen@linux.intel.com, mattc@purestorage.com,
 Jonathan.Cameron@huawei.com, bhelgaas@google.com, tony.luck@intel.com,
 bp@alien8.de, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 oleg@redhat.com, naveen@kernel.org, davem@davemloft.net,
 anil.s.keshavamurthy@intel.com, mark.rutland@arm.com, peterz@infradead.org,
 tianruidong@linux.alibaba.com
Subject: Re: [PATCH v12 1/3] PCI: trace: Add a generic RAS tracepoint for
 hotplug event
Message-ID: <20251015103757.3d6f6cf7@gandalf.local.home>
In-Reply-To: <b6353617-048a-4e12-a1d4-6d1484619927@linux.alibaba.com>
References: <20251014123159.57764-1-xueshuai@linux.alibaba.com>
	<20251014123159.57764-2-xueshuai@linux.alibaba.com>
	<20251014114029.4c59bb1a@gandalf.local.home>
	<b6353617-048a-4e12-a1d4-6d1484619927@linux.alibaba.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: fgnor9rjjpcii9s886naip5wzh8wghtr
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 45CEE6000F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/FTVt6E7UMjnFa3gZkkgvObqEHUxcIBNI=
X-HE-Tag: 1760539069-379651
X-HE-Meta: U2FsdGVkX18owMZos1tJOGdmmegpdG3PengPH+NiaoyOZSXWF9nvdJ9nseJ2U0CCiy5P2nJ+7GHWsBkHlDQUpV+kst3thccxO61gYx4lN9Ewvz/zCp18HxJaM6JHuNZ+6t/A/QJFd2B6Vq1LkS2jFUKmnJ3dzwI5a6s2mQJ77mKF8+RoQD07QPbuZFuIcaIjXjJgAWiJwWoXDVx4JecuJ5ffNeIsT/mDnwzs3qqfyK69Al/K/5301vqjf35FEAWgvL0P/+S9mJgyuk5FcFwJ33/KiKG+gEhTWH6T/cshRj0rpoFYOuh1d9Th4NeW/+b8+2bFYsfRK1zhJoOax0yOB+XK99utHzLf

On Wed, 15 Oct 2025 14:29:07 +0800
Shuai Xue <xueshuai@linux.alibaba.com> wrote:

> Hi, Steve,
> 
> Thank you for your suggestion about passing the controller directly to
> the trace event. I investigated this approach, but unfortunately we
> cannot implement it due to structural limitations in the PCI hotplug
> subsystem.

Ah, that makes sense. Perhaps add a comment about this by the TRACE_EVENT()
so that I don't recommend this again ;-)

-- Steve

