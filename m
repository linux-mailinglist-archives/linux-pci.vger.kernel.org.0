Return-Path: <linux-pci+bounces-40505-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD34C3B900
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 15:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CD851885571
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 14:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7787332EDA;
	Thu,  6 Nov 2025 14:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mde1aon2"
X-Original-To: linux-pci@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3235239E81;
	Thu,  6 Nov 2025 14:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762437962; cv=none; b=kbvaab7X0odBAAI8gFvyGY47CP+uMTHDKMjuksfCIBlukd+J78KNZUxkwoNYvkgOlbYSA3LIxsVAwSEsKz4gKnrdb1rQ71uMP3alzVISaLAO5JHBlTFtGfERDjbO81WLCZt4uP7cLcpBPgLDrwibvIu4PDoQBgpXaS9mG/gYSO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762437962; c=relaxed/simple;
	bh=miUnIMUnEgCoYR8oq+QVdvzoDVR3AhpjXJx5BUCDQKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMJJbPKX2o3qSUizarGwItrSgHBaSAI8oaALe6AKGFSFjOSt0Q10TR9Gwza0Kj8YnMaSCmRAvqaNtoji1XOzrSpjLju5UIrqrUTxdlmAhCn8IXEmAB76fHDrakFz9y/QPnDhUFIz62pW2BamuQu2d09NMzBHCkxJEKLqEK1DuXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mde1aon2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=hODm64mydJ9/XhOXdh8Jq7SbwA95m5lBwPGqdtbS7sc=; b=mde1aon2MU1vjpC7X4EeG7XgWi
	VEsWt1tOe2OOS3UDR8NuCFlRzH8V/m+CznsvufVDgdToLnyj9v+1WKy4plarNEM2KTwEwudQA6DF8
	DAzjTDJEsIFIuEn9Xb4JP4XQxzCLzmF0NAxRlyQy+o34QRTIK6l8nQ4/1gL1qNdnKiNvrY7UHjsJU
	qwopo6U7bxquZa+hV1bLiLm48oUkOelx/0BXynCpqrghJZebaNVPRtRKoBLvfWIaFGaBxDWe24a9q
	dZjUiW+XDhynH9Ru0TopyVoMSHcNsNWTyu933OSR/WgUUiWPUMg0Fanp/DhbZX5QAJDseczMyfNI5
	/Yw9nR/Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vH0ca-00000003TZj-1l8F;
	Thu, 06 Nov 2025 14:05:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4723430023C; Thu, 06 Nov 2025 15:05:51 +0100 (CET)
Date: Thu, 6 Nov 2025 15:05:51 +0100
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
Message-ID: <20251106140551.GY4067720@noisy.programming.kicks-ass.net>
References: <20251102105706.7259-1-jckeep.cuiguangbo@gmail.com>
 <20251102105706.7259-3-jckeep.cuiguangbo@gmail.com>
 <20251103192120.GJ3419281@noisy.programming.kicks-ass.net>
 <20251103192709.GV1386988@noisy.programming.kicks-ass.net>
 <aQydxtOtgPTPxL_9@2a2a0ba7cec8>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQydxtOtgPTPxL_9@2a2a0ba7cec8>

On Thu, Nov 06, 2025 at 01:08:22PM +0000, Guangbo Cui wrote:

> > +	scoped_guard (raw_spinlock_irqsave, &inject_lock) {
> > +		if (ops == &aer_inj_pci_ops)
> > +			break;
> > +		pci_bus_ops_init(bus_ops, bus, ops);
> > +		list_add(&bus_ops->list, &pci_bus_ops_list);
> > +		bus_ops = NULL;
> > +	}
> 
> I found that there are two styles of calling scoped_guard in the kernel:
> 
>   1. scoped_guard (...)
> 
>   2. scoped_guard(...)
> 
> Is there any coding convention or guideline regarding this?

Not really :/ I usually use the former, to mirror if (cond) and for
(;;) usage as opposed to func(args). 

> > +				rperr->root_status |= PCI_ERR_ROOT_COR_RCV;
> > +			rperr->source_id &= 0xffff0000;
> > +			rperr->source_id |= PCI_DEVID(einj->bus, devfn);
> > +		}
> > +		if (einj->uncor_status) {
> > +			if (rperr->root_status & PCI_ERR_ROOT_UNCOR_RCV)
> > +				rperr->root_status |= PCI_ERR_ROOT_MULTI_UNCOR_RCV;
> > +			if (sever & einj->uncor_status) {
> > +				rperr->root_status |= PCI_ERR_ROOT_FATAL_RCV;
> > +				if (!(rperr->root_status & PCI_ERR_ROOT_UNCOR_RCV))
> > +					rperr->root_status |= PCI_ERR_ROOT_FIRST_FATAL;
> > +			} else
> > +				rperr->root_status |= PCI_ERR_ROOT_NONFATAL_RCV;
> > +			rperr->root_status |= PCI_ERR_ROOT_UNCOR_RCV;
> > +			rperr->source_id &= 0x0000ffff;
> > +			rperr->source_id |= PCI_DEVID(einj->bus, devfn) << 16;
> > +		}
> >  	}
> > -	raw_spin_unlock_irqrestore(&inject_lock, flags);
> >  
> >  	if (aer_mask_override) {
> >  		pci_write_config_dword(dev, pos_cap_err + PCI_ERR_COR_MASK,
> 
> LGTM, If there are no objections, I’ll include these two patches in the
> next version of the patchset and add your Signed-off-by tag.

Sure, but please do test them, I've not even had them near a compiler
;-)

Thanks!

