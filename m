Return-Path: <linux-pci+bounces-39533-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAA1C14F21
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 14:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3CD61A62ABD
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 13:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5923328F8;
	Tue, 28 Oct 2025 13:44:44 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1680F32E125;
	Tue, 28 Oct 2025 13:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761659083; cv=none; b=TsgRg0meSu7VYfiQJCSBII3CYB/jT4waKRLMSB8Y77YpaWUJmJcgiqYI/yKi5tqbJXNK3lVhj75Lp/dlWhTxAIND1//7EiwueuMixbV4sptbFi3gp46CvEfBs66hG5v1od01yApYqpwrycMRAJRw4UMxebijb6xQvIIiUvYL1eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761659083; c=relaxed/simple;
	bh=IxwKCbUXHJTMHTBOxpn47Gc03a6SOp3BE8zoqd4FhvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UMunvInp9+mbl4UopoQIsY9v5a7PiDgU/FAV/JvsIzWoH+JwZnozEtl5Eiy51mRlXRbXejFTY96N6Qs/PvIvE/wf+OXTtqX/8n+NEzD6/0s4WJ8gN8JbRJUF06cjlJrYMyvwKlLxLDejG61EdIEQLkJ7pSV9NAq+Q1A9Z8AeYK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id EF8402C0664E;
	Tue, 28 Oct 2025 14:44:38 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id D868B587B; Tue, 28 Oct 2025 14:44:38 +0100 (CET)
Date: Tue, 28 Oct 2025 14:44:38 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Crystal Wood <crwood@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org, Attila Fazekas <afazekas@redhat.com>,
	linux-pci@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Bjorn Helgaas <helgaas@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>
Subject: Re: [PATCH v2] genirq/manage: Reduce priority of forced secondary
 interrupt handler
Message-ID: <aQDIxvU18vzB-1G-@wunner.de>
References: <f6dcdb41be2694886b8dbf4fe7b3ab89e9d5114c.1761569303.git.lukas@wunner.de>
 <20251028120652.AJUTgtwZ@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028120652.AJUTgtwZ@linutronix.de>

On Tue, Oct 28, 2025 at 01:06:52PM +0100, Sebastian Andrzej Siewior wrote:
> On 2025-10-27 13:59:31 [+0100], Lukas Wunner wrote:
> > The issue does not show on non-PREEMPT_RT because the primary handler
> > runs in hardirq context and thus can preempt the threaded secondary
> > handler, clear the Root Error Status register and prevent the secondary
> > handler from getting stuck.
> 
> Not sure if I mentioned it before but this is due to forced threaded
> IRQs which can also be enabled on non-PREEMPT_RT systems via `threadirqs`.

According to the commit which introduced the "threadirqs" command line
option, 8d32a307e4fa ("genirq: Provide forced interrupt threading"),
it is "mostly a debug option".  I guess the option allows testing
the waters on arches which do not yet "select ARCH_SUPPORTS_RT"
to see if force-threaded interrupts break anything.  I recall the
option being available in mainline for much longer than PREEMPT_RT
and it was definitely useful as a justification to upstream changes
which were otherwise only needed by the out-of-tree PREEMPT_RT patches.

Intuitively I would assume that debug options are not worth calling out
in commit messages or code comments as users and developers will
primarily be interested in the real deal (i.e. PREEMPT_RT) and not
an option which gets us only halfway there.  However if you
(or anyone else) feels strongly about it, I'll be happy to respin.

Thanks for taking a look!

Lukas

