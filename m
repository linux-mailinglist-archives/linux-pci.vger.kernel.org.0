Return-Path: <linux-pci+bounces-33197-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5743B16487
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 18:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB1F6167B1B
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 16:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4294C2DC32D;
	Wed, 30 Jul 2025 16:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aiBCDdUe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0539418DB24;
	Wed, 30 Jul 2025 16:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753892506; cv=none; b=Hjm3vbKB4VnBOxOH13/iv/G8ezb/AhJ0MLkZh+GuNZ8EShFnxIcfk0Y0TWc+/0YtwXCxwExf8f8LzlDze5TCx2h2DT6xhqK9uBZv4cyTK9U+1DqBQD88q65wTCfibjnpXjg7KPXZOYMVJa9XB5/rlbiRo12sEKERKEi485a27SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753892506; c=relaxed/simple;
	bh=Z/C3ul5o75i6bTpbhJZLGEjV6nDj+lf/hDM6AkOr34I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rip5fgpc2trbGFGpCPn3DtMVxDgyNwwtQqCgFFe8oZLBT0wxnZyxPvNj0bYCxc6NWOLbbXof9adDGgzmxgsh1oDWj+fP4ZK+Up4uVQdhbMmxZrKl0NXVgtY3DnWUZwpGzgoMaKs6wStD0DixqnQhKshxTYcbZOEN3OZcjzd/VAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aiBCDdUe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A335C4CEE3;
	Wed, 30 Jul 2025 16:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753892505;
	bh=Z/C3ul5o75i6bTpbhJZLGEjV6nDj+lf/hDM6AkOr34I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aiBCDdUeAhbo90SYZVK5pgGP6Ixwqf56PxCBG0mWpQOhbCHY0fYBuNTto7qCQe+7Y
	 X55RLKXT8bxgM+aP1+/q5pbDbnSE+sPqrkZKovPRiki3qQmYfWBDylFOYFvlEE3ys2
	 EP1V7U2UzklkCKJocA4UCdXop6SGNVcziJR6gdyAnAiYeUiBJL94Z8+CCj0h7vsMrF
	 jDElP6bu+0Q4TDmLc0ZbLzarjNJ6aIZylF/q72OzBPN7vzG17TWB8t1wm0ZkAKSmeU
	 BhkNBMF0o2ilUiPR5m9P+FXxIFfT4phrUZ7h8wYxqizfA5Ex4XXHl60N4O3zqIFJ0I
	 Csj7368Nvfkhg==
Date: Wed, 30 Jul 2025 18:21:37 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>, Tony Luck <tony.luck@intel.com>,
 Borislav Petkov <bp@alien8.de>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>, Robert
 Moore <robert.moore@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Hanjun Guo
 <guohanjun@huawei.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Mahesh
 J Salgaonkar <mahesh@linux.ibm.com>, Oliver O'Halloran <oohall@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev,
 osandov@osandov.com, konrad.wilk@oracle.com, linux-edac@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 kernel-team@meta.com
Subject: Re: [PATCH v3] vmcoreinfo: Track and log recoverable hardware
 errors
Message-ID: <20250730182137.18605ea1@foz.lan>
In-Reply-To: <zc4jm3hwvtwo5y2knk2bqzwmpf7ma7bdzs6uv2osavzcdew3nk@lfjrlp6sr7zz>
References: <20250722-vmcore_hw_error-v3-1-ff0683fc1f17@debian.org>
	<7ce9731a-b212-4e27-8809-0559eb36c5f2@linux.alibaba.com>
	<4qh2wbcbzdajh2tvki26qe4tqjazmyvbn7v7aqqhkxpitdrexo@ucch4ppo7i4e>
	<fdb5dced-ea5a-48b8-bbb4-fc3ade7f3df8@linux.alibaba.com>
	<ldlansfiesfxf4a6dzp5z2etquz5jgiq6ttx3al6q7sesgros6@xh4lkevbzsow>
	<4ef01be1-44b2-4bf5-afec-a90d4f71e955@linux.alibaba.com>
	<2a7ok3hdq3hmz45fzosd5vve4qpn6zy5uoogg33warsekigazu@wgfi7qsg5ixo>
	<a87c5e74-082f-4be6-bbfd-4867bf72ddcc@linux.alibaba.com>
	<zc4jm3hwvtwo5y2knk2bqzwmpf7ma7bdzs6uv2osavzcdew3nk@lfjrlp6sr7zz>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed, 30 Jul 2025 06:11:52 -0700
Breno Leitao <leitao@debian.org> escreveu:

> Hello Shuai,
> 
> On Wed, Jul 30, 2025 at 10:13:13AM +0800, Shuai Xue wrote:
> > In ghes_log_hwerr(), you're counting both CPER_SEV_CORRECTED and
> > CPER_SEV_RECOVERABLE errors:  
> 
> Thanks. I was reading this code a bit more, and I want to make sure my
> understanding is correct, giving I was confused about CORRECTED and
> RECOVERABLE errors.
> 
> CPER_SEV_CORRECTED means it is corrected in the background, and the OS
> was not even notified about it. That includes 1-bit ECC error.
> THose are not the errors we are interested in, since they are irrelavant
> to the OS.

Hardware-corrected errors aren't irrelevant. The rasdaemon utils capture
such errors, as they may be a symptom of a hardware defect. In a matter
of fact, at rasdamon, thresholds can be set to trigger an action, like
for instance, disable memory blocks that contain defective memories.

This is specially relevant on HPC and supercomputer workloads, where
it is a lot cheaper to disable a block of bad memory than to lose
an entire job because that could take several weeks of run time on
a supercomputer, just because a defective memory ended causing a
failure at the application.

Regards,
Mauro

