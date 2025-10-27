Return-Path: <linux-pci+bounces-39362-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8A9C0C43B
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 09:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 602173BEA99
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 08:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C0A2E54B3;
	Mon, 27 Oct 2025 08:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OVmHjXKD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a3Dp2nNl"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0E919D065;
	Mon, 27 Oct 2025 08:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761552775; cv=none; b=GFIKC/x81aFresPMLAPShEAXSaYdehJjldXKwsh2J8bwpyzAHK7IOFwrT+xK0FJzNAVd2NtHEjaKKdJ6Il9h8RzDckE+8wZz36hbTUvitRrV6rOU91NXH/abMAIQ4RqrBiGjkq3ymc3yoSx4wD3EszGinA64JuFkNLOpnDz3mnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761552775; c=relaxed/simple;
	bh=ri4SjW2mNgGweElIFVOxQV7dEFpJirLoX2TZ9GqVdFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQhaNASlsVZB/313LZi5d3Cyg16VLjuIm/VDNtsEVhJ6+TMBN5oIIdqUnSTa6jplDfpf/i/l/nLXGmvNI3cb8epjuhXPvrlgPLZWqb87zqJ3GUAlzuyiCySbUQEVk8amRt6y0CgE4fowMYzFvy9PShviPYpEWRmq6fnt/J19LXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OVmHjXKD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a3Dp2nNl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 27 Oct 2025 09:12:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761552772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ri4SjW2mNgGweElIFVOxQV7dEFpJirLoX2TZ9GqVdFA=;
	b=OVmHjXKDQzc6GeSonF1vQFw8KctRRTHTRl70iJQ7RUUvvI+lvgUL6x+1tefbK+W7aknCAx
	2B2ZRR1NjkoaBkL2Gv6tZH9M1CqcqwCD45hIp5EcVyFCVcoY2q/2SHp49nExOVq9yiL28y
	/+5DWYjpjECjHkxcKNUHb/onmk9P0OPTCg8MIJywfeYytGk6+CCt3FSYf64hbcr+hXfsVL
	PG2+yICSaeZn1ASoq8OD9yddhrbkWMO7e0EgN8ep4Ik8k4lbd/kxOO0S1a9v3ia1Yj+nbT
	zSuUZEGZsOH7vUaf+rb0dvvOCS8t1gqkFOvVOABN2maoNqx8SfqVLl6wrdG4Dw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761552772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ri4SjW2mNgGweElIFVOxQV7dEFpJirLoX2TZ9GqVdFA=;
	b=a3Dp2nNl73mFf4dnj8orsYpQOFRqnRCcQ5+XQ2eOAZjN3YbSV944cgjykZFDtx6m+i04X2
	rQSMFmYSozjPeAAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
Cc: Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Waiman Long <longman@redhat.com>, linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 2/2] PCI/aer_inject: Remove unnecessary lock in
 aer_inject_exit
Message-ID: <20251027081251.aerhtaJi@linutronix.de>
References: <20251026044335.19049-2-jckeep.cuiguangbo@gmail.com>
 <20251026044335.19049-4-jckeep.cuiguangbo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251026044335.19049-4-jckeep.cuiguangbo@gmail.com>

On 2025-10-26 04:43:35 [+0000], Guangbo Cui wrote:
> After misc_deregister and restoring PCI bus ops, there can be no further
> users accessing the einjected list. The list items are therefore safely
> freed without taking the lock.

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

> Signed-off-by: Guangbo Cui <jckeep.cuiguangbo@gmail.com>

Sebastian

