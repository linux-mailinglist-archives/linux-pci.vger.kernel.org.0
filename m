Return-Path: <linux-pci+bounces-39284-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA357C076BB
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 18:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1DC21C42D6E
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 17:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5460D31D74A;
	Fri, 24 Oct 2025 16:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlHaGBXH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2748E1A83F9;
	Fri, 24 Oct 2025 16:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761325173; cv=none; b=RIC3G7kp72Tr4rtzqzI0D3Px+d4KoD2eRncGvGfGx3Z+QZ/XgKzuIS00aRCnLQ0+qcR20C988RRv7ts7NQO+d7lJbNae88NmCaW0rNUGximk1ZqB5YHwnDT1zxYjRmHNtW18cJFN54348rEhcfpDhCNKf5ynv6xHCbR7iRo94ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761325173; c=relaxed/simple;
	bh=NI/rc7eye74iVvlRLxjIh57O/Fz+QQfLbOm4CGCtKu0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DLqfKc3B+qSOvucorzTnPoAhesKAnxqVkEAtLHT8+aeCdoocdFV6uhu5SE3o5//LZ4eYgqxbrFGGWdNETcfUsODIUjtN4gIIK8pPE28f9+VZc+b6UEzl3qxDCDCuZMvSyqLDyB5uVQFodhZulsprNvmJ2ttE1w4bhlBmx/7cX44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dlHaGBXH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BCC1C4CEF1;
	Fri, 24 Oct 2025 16:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761325172;
	bh=NI/rc7eye74iVvlRLxjIh57O/Fz+QQfLbOm4CGCtKu0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=dlHaGBXHbSEjOtiqusEUlrKtOZ6KQUUkEohK4jVyq06y51ril3e2UyTzQlNqHa4fv
	 xGWcwEbddkZw+j7nvdxYmFP01zdfzXbEvyw5k3ZF1rmu5BCBZKYTRja8qzwpYWx8GV
	 IpA8xovmQI6jzsg1KOIbekIQsSZ7Ayx0jQiwxo5HHL6+KsvC+4Px5Uw2RCg0iGUiRl
	 c5PstjMQIBCcQ5uL/sm7a093geQ4H17bWT94f2cAgcgzhGewsxGxKPtbGSyUXEop7U
	 716uOwYJ5X4t+HFlZZdW9Pmlo7y1o9jYobv605l7b98M4ir6PDALPlLAS/RlR9Sdv+
	 +6V9XLWXdib+Q==
Date: Fri, 24 Oct 2025 11:59:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Waiman Long <longman@redhat.com>, linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] pci/aer_inject: switching inject_lock to
 raw_spinlock_t
Message-ID: <20251024165931.GA1354268@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009150651.93618-1-jckeep.cuiguangbo@gmail.com>

On Thu, Oct 09, 2025 at 03:06:50PM +0000, Guangbo Cui wrote:
> When injecting AER errors under PREEMPT_RT, the kernel may trigger a
> lockdep warning about an invalid wait context:
> 
> ```
> [ 1850.950780] [ BUG: Invalid wait context ]
> [ 1850.951152] 6.17.0-11316-g7a405dbb0f03-dirty #7 Not tainted
> [ 1850.951457] -----------------------------
> [ 1850.951680] irq/16-PCIe PME/56 is trying to lock:
> [ 1850.952004] ffff800082865238 (inject_lock){+.+.}-{3:3}, at: aer_inj_read_config+0x38/0x1dc
> [ 1850.952731] other info that might help us debug this:
> [ 1850.952997] context-{5:5}
> [ 1850.953192] 5 locks held by irq/16-PCIe PME/56:
> [ 1850.953415]  #0: ffff800082647390 (local_bh){.+.+}-{1:3}, at: __local_bh_disable_ip+0x30/0x268
> [ 1850.953931]  #1: ffff8000826c6b38 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire+0x4/0x48
> [ 1850.954453]  #2: ffff000004bb6c58 (&data->lock){+...}-{3:3}, at: pcie_pme_irq+0x34/0xc4
> [ 1850.954949]  #3: ffff8000826c6b38 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire+0x4/0x48
> [ 1850.955420]  #4: ffff800082863d10 (pci_lock){....}-{2:2}, at: pci_bus_read_config_dword+0x5c/0xd8
> ```
> ...

If/when you update the commit log, please:

  - Update subject line to match history (use "git log --oneline")

  - Drop the timestamps because they don't help understand the issue

  - Drop the ```; just indent quoted material a couple spaces

  - Drop the `` around code names; the () after functions is enough

  - Trim it as others suggested; I appreciate the details about how
    to reproduce it, but they could go after the ---, where we'll be
    able to find them via the Link: tag

