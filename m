Return-Path: <linux-pci+bounces-40138-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05993C2DE3F
	for <lists+linux-pci@lfdr.de>; Mon, 03 Nov 2025 20:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E9683B1F14
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 19:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB80323D7DA;
	Mon,  3 Nov 2025 19:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Da4+Jzq9"
X-Original-To: linux-pci@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB405224B1F;
	Mon,  3 Nov 2025 19:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762197688; cv=none; b=C5yqc4aa5+Qi0aOl8HwvVd9imUbTmmv8pupvzg3znGjncLTcdMrktqt8e4ipHvbMAnDo18YtHJCxyMUbXFZSQZNlmOMPQEENt+xiKa8AR9J3Y9byHNOyGY5ZVdJhZWqpMtj2oNZStAqX8hIs5z/YynuPpWFPMO08Qalja+YAueE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762197688; c=relaxed/simple;
	bh=XIKZfpbWhIczx+zfqu9he4VYj9BcO79XICH9IZJazMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+r5qB9nebiyS0hdFXCLv2oq2a2q6z88756Q1px80B1lCynnZSojNWUwXlyEd8Z7ejOjlbfR5milLexM6tJjGKensAfbcqrm1KhIOMkbGzcYiJi9aYisMXcBeypxs7URJIXk4x7zQmt+dP9d1k+sytt/w9JzNLcIlmB0BTD/Vow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Da4+Jzq9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=bApFsiCh5GhK1LrnE+wALM58Na/7RmLhN4XmrqINttw=; b=Da4+Jzq9hAP4ZVsMeffgtRao6u
	xWPp3cQ4ny2634aCIWw8HMHQtw3eQnPiGuAao+sPnye+9Pjsh+fZJETDK40F/RgoWiCvS4fQOyBzy
	rsnz9h7ZWkx/9mtH3nU6qeY6sRGuhiKfMqO1z1eOnXRyyTAWoS4vl1ANoQ2PnMu86u6gf6skx65XG
	HqGSYBRmGR/ZWuvhe+TJ6Y8nXPSSVYpYYj8caAM8EpUtj0M9Anb6e3YJNDMEwMLRobjw9WLbyqv+t
	/j7wrKfU1XO9D2HCN7AGKeBG6guRpSSNANim/uSnoG6iEkDbqeOCjmZs6cYPsU0hCmxnjI452AlrR
	SMCUGfUg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG07E-0000000FtOT-09nn;
	Mon, 03 Nov 2025 19:21:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1E29C300230; Mon, 03 Nov 2025 20:21:20 +0100 (CET)
Date: Mon, 3 Nov 2025 20:21:20 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Waiman Long <longman@redhat.com>, linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 2/2] PCI/aer_inject: Convert inject_lock to
 raw_spinlock_t
Message-ID: <20251103192120.GJ3419281@noisy.programming.kicks-ass.net>
References: <20251102105706.7259-1-jckeep.cuiguangbo@gmail.com>
 <20251102105706.7259-3-jckeep.cuiguangbo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251102105706.7259-3-jckeep.cuiguangbo@gmail.com>

On Sun, Nov 02, 2025 at 10:57:06AM +0000, Guangbo Cui wrote:
> The AER injection path may run in interrupt-disabled context while
> holding inject_lock. On PREEMPT_RT kernels, spinlock_t becomes a
> sleeping lock, so it must not be taken while a raw_spinlock_t is held.
> Doing so violates lock ordering rules and trigger lockdep reports
> such as “Invalid wait context”.
> 
> Convert inject_lock to raw_spinlock_t to ensure non-sleeping locking
> semantics. The protected list is bounded and used only for debugging,
> so raw locking will not cause latency issues.

Bounded how?

Also,

---

--- a/drivers/pci/pcie/aer_inject.c
+++ b/drivers/pci/pcie/aer_inject.c
@@ -85,12 +85,13 @@ static void aer_error_init(struct aer_er
 	err->pos_cap_err = pos_cap_err;
 }
 
-/* inject_lock must be held before calling */
 static struct aer_error *__find_aer_error(u32 domain, unsigned int bus,
 					  unsigned int devfn)
 {
 	struct aer_error *err;
 
+	lockdep_assert_held(&inject_lock);
+
 	list_for_each_entry(err, &einjected, list) {
 		if (domain == err->domain &&
 		    bus == err->bus &&
@@ -100,20 +101,24 @@ static struct aer_error *__find_aer_erro
 	return NULL;
 }
 
-/* inject_lock must be held before calling */
 static struct aer_error *__find_aer_error_by_dev(struct pci_dev *dev)
 {
-	int domain = pci_domain_nr(dev->bus);
+	int domain;
+
+	lockdep_assert_held(&inject_lock);
+
+	domain = pci_domain_nr(dev->bus);
 	if (domain < 0)
 		return NULL;
 	return __find_aer_error(domain, dev->bus->number, dev->devfn);
 }
 
-/* inject_lock must be held before calling */
 static struct pci_ops *__find_pci_bus_ops(struct pci_bus *bus)
 {
 	struct pci_bus_ops *bus_ops;
 
+	lockdep_assert_held(&inject_lock);
+
 	list_for_each_entry(bus_ops, &pci_bus_ops_list, list) {
 		if (bus_ops->bus == bus)
 			return bus_ops->ops;

