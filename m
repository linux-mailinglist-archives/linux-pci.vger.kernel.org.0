Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBB44673F3
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2019 19:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfGLRGf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Jul 2019 13:06:35 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46660 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbfGLRGf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Jul 2019 13:06:35 -0400
Received: by mail-pg1-f194.google.com with SMTP id i8so4783725pgm.13
        for <linux-pci@vger.kernel.org>; Fri, 12 Jul 2019 10:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U4r9fJhOOfKvEr/lr0XXxLZ2PxseLa8j58vIX2MDIbg=;
        b=fv7p9nvPni/JgBkN2DWvJ1P31XFtjqlhxVv7ZlWssudMvP9WPZSHYjuMfBevfuT3Ss
         knuButmyP+N3aV3R22zlawh7Z8X678G5pwYCFuWxtBvhtoGDhuSNXOwazo0lMuX8BfH+
         CswFAH2EOg3MwPdv1vUL19wj1rk6CZWcf1sBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U4r9fJhOOfKvEr/lr0XXxLZ2PxseLa8j58vIX2MDIbg=;
        b=CgtDMBYqs5VcxBVFGR21UOK62JGIwtJpy3ZPxIAU9DsoZKqiv7pUkjzujhQe5BWBml
         SZvc6vpOoZBoyRqHs4gkwZSy5PzYhr2NYprSL2z6Wc+EQfFNpqbiBAamgwbcx3WZzCpv
         DFHRg+m7nt2FQfu6h0MJDPGJUM7cxnDVvso6E6sFVNi9bZu+8MhXTCMZ555dlMomkzCT
         mNOLkyn/qXW9OzV67ORvuF+Pci9C9emNbo+ZCYiFFq53Jkm1p+ROHRqrViVq3C8fnsNQ
         H1M6MmjOPjHryJmkaDbLVUOltu/LNazusO/PlsQalftWlDHpalZq1MJXZkAYehQzc6S1
         sHpw==
X-Gm-Message-State: APjAAAU96CuVCbV06tEz3Qg28Ti/2Qk1XV+ONtnP7PCc3BTm47GWYgoX
        zAJGKitbGmfa3rXKLbib4Xk=
X-Google-Smtp-Source: APXvYqxWZ1lBG2pygGPOpQ8lfw5pnGgRdRphaQTQsIi1EoLggu/tzCkWCRTxy5YCUJKUx975qaz1Kw==
X-Received: by 2002:a63:8f16:: with SMTP id n22mr5755652pgd.306.1562951194055;
        Fri, 12 Jul 2019 10:06:34 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id a3sm10044435pfo.49.2019.07.12.10.06.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 10:06:33 -0700 (PDT)
Date:   Fri, 12 Jul 2019 13:06:31 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Borislav Petkov <bp@alien8.de>, c0d1n61at3@gmail.com,
        "David S. Miller" <davem@davemloft.net>, edumazet@google.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>, keescook@chromium.org,
        kernel-hardening@lists.openwall.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        neilb@suse.com, netdev@vger.kernel.org, oleg@redhat.com,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, will@kernel.org,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Subject: Re: [PATCH v1 1/6] rcu: Add support for consolidated-RCU reader
 checking
Message-ID: <20190712170631.GA111598@google.com>
References: <20190711234401.220336-1-joel@joelfernandes.org>
 <20190711234401.220336-2-joel@joelfernandes.org>
 <20190712111125.GT3402@hirez.programming.kicks-ass.net>
 <20190712151051.GB235410@google.com>
 <20190712164531.GW26519@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712164531.GW26519@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 12, 2019 at 09:45:31AM -0700, Paul E. McKenney wrote:
> On Fri, Jul 12, 2019 at 11:10:51AM -0400, Joel Fernandes wrote:
> > On Fri, Jul 12, 2019 at 01:11:25PM +0200, Peter Zijlstra wrote:
> > > On Thu, Jul 11, 2019 at 07:43:56PM -0400, Joel Fernandes (Google) wrote:
> > > > +int rcu_read_lock_any_held(void)
> > > > +{
> > > > +	int lockdep_opinion = 0;
> > > > +
> > > > +	if (!debug_lockdep_rcu_enabled())
> > > > +		return 1;
> > > > +	if (!rcu_is_watching())
> > > > +		return 0;
> > > > +	if (!rcu_lockdep_current_cpu_online())
> > > > +		return 0;
> > > > +
> > > > +	/* Preemptible RCU flavor */
> > > > +	if (lock_is_held(&rcu_lock_map))
> > > 
> > > you forgot debug_locks here.
> > 
> > Actually, it turns out debug_locks checking is not even needed. If
> > debug_locks == 0, then debug_lockdep_rcu_enabled() returns 0 and we would not
> > get to this point.
> > 
> > > > +		return 1;
> > > > +
> > > > +	/* BH flavor */
> > > > +	if (in_softirq() || irqs_disabled())
> > > 
> > > I'm not sure I'd put irqs_disabled() under BH, also this entire
> > > condition is superfluous, see below.
> > > 
> > > > +		return 1;
> > > > +
> > > > +	/* Sched flavor */
> > > > +	if (debug_locks)
> > > > +		lockdep_opinion = lock_is_held(&rcu_sched_lock_map);
> > > > +	return lockdep_opinion || !preemptible();
> > > 
> > > that !preemptible() turns into:
> > > 
> > >   !(preempt_count()==0 && !irqs_disabled())
> > > 
> > > which is:
> > > 
> > >   preempt_count() != 0 || irqs_disabled()
> > > 
> > > and already includes irqs_disabled() and in_softirq().
> > > 
> > > > +}
> > > 
> > > So maybe something lke:
> > > 
> > > 	if (debug_locks && (lock_is_held(&rcu_lock_map) ||
> > > 			    lock_is_held(&rcu_sched_lock_map)))
> > > 		return true;
> > 
> > Agreed, I will do it this way (without the debug_locks) like:
> > 
> > ---8<-----------------------
> > 
> > diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> > index ba861d1716d3..339aebc330db 100644
> > --- a/kernel/rcu/update.c
> > +++ b/kernel/rcu/update.c
> > @@ -296,27 +296,15 @@ EXPORT_SYMBOL_GPL(rcu_read_lock_bh_held);
> >  
> >  int rcu_read_lock_any_held(void)
> >  {
> > -	int lockdep_opinion = 0;
> > -
> >  	if (!debug_lockdep_rcu_enabled())
> >  		return 1;
> >  	if (!rcu_is_watching())
> >  		return 0;
> >  	if (!rcu_lockdep_current_cpu_online())
> >  		return 0;
> > -
> > -	/* Preemptible RCU flavor */
> > -	if (lock_is_held(&rcu_lock_map))
> > -		return 1;
> > -
> > -	/* BH flavor */
> > -	if (in_softirq() || irqs_disabled())
> > -		return 1;
> > -
> > -	/* Sched flavor */
> > -	if (debug_locks)
> > -		lockdep_opinion = lock_is_held(&rcu_sched_lock_map);
> > -	return lockdep_opinion || !preemptible();
> > +	if (lock_is_held(&rcu_lock_map) || lock_is_held(&rcu_sched_lock_map))
> 
> OK, I will bite...  Why not also lock_is_held(&rcu_bh_lock_map)?

Hmm, I was borrowing the strategy from rcu_read_lock_bh_held() which does not
check for a lock held in this map.

Honestly, even  lock_is_held(&rcu_sched_lock_map) seems unnecessary per-se
since !preemptible() will catch that? rcu_read_lock_sched() disables
preemption already, so lockdep's opinion of the matter seems redundant there.

Sorry I already sent out patches again before seeing your comment but I can
rework and resend them based on any other suggestions.

thanks,

 - Joel


