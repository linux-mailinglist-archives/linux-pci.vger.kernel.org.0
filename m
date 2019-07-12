Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A17DA67576
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2019 21:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfGLTko (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Jul 2019 15:40:44 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34311 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727355AbfGLTko (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Jul 2019 15:40:44 -0400
Received: by mail-pf1-f194.google.com with SMTP id b13so4740474pfo.1
        for <linux-pci@vger.kernel.org>; Fri, 12 Jul 2019 12:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nAJsR7QXwSJc647spM+sQunAoBzpCrSmQsX27huBu+o=;
        b=bmxPnZXFh5gOCfuOus2gHM6f6oGNgMKP/ji63JlI+bwUXl3Gpe3vjP96TTAKXaJCZC
         zj7Y8eFA2XvcXUe8SUv1NKdUvs12xq4vmo946+SPEoJfJYl3KKJWKjnEQtWp8b/06x77
         32gH3YSvwVXKePdbdirKmPWfh8K3q8ksM+3uI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nAJsR7QXwSJc647spM+sQunAoBzpCrSmQsX27huBu+o=;
        b=KlT/Q21sOe1th8p/ABzQjl2BbTyZLQshBAazFr3bWBTRS0bc1YRbGkCBg6XiX+aWgA
         WUaji6OGzcPIzab66tVfydcnc0xJe03xDtvgSgJ3+1qsI/cCmadhInxNTd0AwYxuWTbO
         g5Q1g/9QDX7cHrBOeyms7v2sgC5EIKHCNfALTUcsfHVFl4rZnHKUOZdFOEVHetFrU11E
         ucmzdNXQQ0lD8nv2D6GwyJl7ixKE9LWUefdWj27fWcfeu/cOL6fLhhjtq7+AUpsFkXD9
         f//0PpWTzdWN2aVUCp7AlBteYtqCGdsXhiy5fKIva80P7Hlqzlo+sbsuNo8uZnIeHW6Z
         00eA==
X-Gm-Message-State: APjAAAWkiTqDrCzozpR9SIch9bWtgHjlM4YdPV2smKS6hheWqweV63EF
        ZdU4HrfFzc7Dz9pe64ukDPs=
X-Google-Smtp-Source: APXvYqxvgkL0vpDAZ6Hy5r4mm056ssuxGSXpd+iPIILPiTDSys89aOnq2iGFem/k4lcJZbyW+r6SIQ==
X-Received: by 2002:a63:2246:: with SMTP id t6mr12863936pgm.209.1562960443485;
        Fri, 12 Jul 2019 12:40:43 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id bo20sm7308552pjb.23.2019.07.12.12.40.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 12:40:42 -0700 (PDT)
Date:   Fri, 12 Jul 2019 15:40:40 -0400
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
Message-ID: <20190712194040.GA150253@google.com>
References: <20190711234401.220336-1-joel@joelfernandes.org>
 <20190711234401.220336-2-joel@joelfernandes.org>
 <20190712111125.GT3402@hirez.programming.kicks-ass.net>
 <20190712151051.GB235410@google.com>
 <20190712164531.GW26519@linux.ibm.com>
 <20190712170631.GA111598@google.com>
 <20190712174630.GX26519@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712174630.GX26519@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 12, 2019 at 10:46:30AM -0700, Paul E. McKenney wrote:
> On Fri, Jul 12, 2019 at 01:06:31PM -0400, Joel Fernandes wrote:
> > On Fri, Jul 12, 2019 at 09:45:31AM -0700, Paul E. McKenney wrote:
> > > On Fri, Jul 12, 2019 at 11:10:51AM -0400, Joel Fernandes wrote:
> > > > On Fri, Jul 12, 2019 at 01:11:25PM +0200, Peter Zijlstra wrote:
> > > > > On Thu, Jul 11, 2019 at 07:43:56PM -0400, Joel Fernandes (Google) wrote:
> > > > > > +int rcu_read_lock_any_held(void)
> > > > > > +{
> > > > > > +	int lockdep_opinion = 0;
> > > > > > +
> > > > > > +	if (!debug_lockdep_rcu_enabled())
> > > > > > +		return 1;
> > > > > > +	if (!rcu_is_watching())
> > > > > > +		return 0;
> > > > > > +	if (!rcu_lockdep_current_cpu_online())
> > > > > > +		return 0;
> > > > > > +
> > > > > > +	/* Preemptible RCU flavor */
> > > > > > +	if (lock_is_held(&rcu_lock_map))
> > > > > 
> > > > > you forgot debug_locks here.
> > > > 
> > > > Actually, it turns out debug_locks checking is not even needed. If
> > > > debug_locks == 0, then debug_lockdep_rcu_enabled() returns 0 and we would not
> > > > get to this point.
> > > > 
> > > > > > +		return 1;
> > > > > > +
> > > > > > +	/* BH flavor */
> > > > > > +	if (in_softirq() || irqs_disabled())
> > > > > 
> > > > > I'm not sure I'd put irqs_disabled() under BH, also this entire
> > > > > condition is superfluous, see below.
> > > > > 
> > > > > > +		return 1;
> > > > > > +
> > > > > > +	/* Sched flavor */
> > > > > > +	if (debug_locks)
> > > > > > +		lockdep_opinion = lock_is_held(&rcu_sched_lock_map);
> > > > > > +	return lockdep_opinion || !preemptible();
> > > > > 
> > > > > that !preemptible() turns into:
> > > > > 
> > > > >   !(preempt_count()==0 && !irqs_disabled())
> > > > > 
> > > > > which is:
> > > > > 
> > > > >   preempt_count() != 0 || irqs_disabled()
> > > > > 
> > > > > and already includes irqs_disabled() and in_softirq().
> > > > > 
> > > > > > +}
> > > > > 
> > > > > So maybe something lke:
> > > > > 
> > > > > 	if (debug_locks && (lock_is_held(&rcu_lock_map) ||
> > > > > 			    lock_is_held(&rcu_sched_lock_map)))
> > > > > 		return true;
> > > > 
> > > > Agreed, I will do it this way (without the debug_locks) like:
> > > > 
> > > > ---8<-----------------------
> > > > 
> > > > diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> > > > index ba861d1716d3..339aebc330db 100644
> > > > --- a/kernel/rcu/update.c
> > > > +++ b/kernel/rcu/update.c
> > > > @@ -296,27 +296,15 @@ EXPORT_SYMBOL_GPL(rcu_read_lock_bh_held);
> > > >  
> > > >  int rcu_read_lock_any_held(void)
> > > >  {
> > > > -	int lockdep_opinion = 0;
> > > > -
> > > >  	if (!debug_lockdep_rcu_enabled())
> > > >  		return 1;
> > > >  	if (!rcu_is_watching())
> > > >  		return 0;
> > > >  	if (!rcu_lockdep_current_cpu_online())
> > > >  		return 0;
> > > > -
> > > > -	/* Preemptible RCU flavor */
> > > > -	if (lock_is_held(&rcu_lock_map))
> > > > -		return 1;
> > > > -
> > > > -	/* BH flavor */
> > > > -	if (in_softirq() || irqs_disabled())
> > > > -		return 1;
> > > > -
> > > > -	/* Sched flavor */
> > > > -	if (debug_locks)
> > > > -		lockdep_opinion = lock_is_held(&rcu_sched_lock_map);
> > > > -	return lockdep_opinion || !preemptible();
> > > > +	if (lock_is_held(&rcu_lock_map) || lock_is_held(&rcu_sched_lock_map))
> > > 
> > > OK, I will bite...  Why not also lock_is_held(&rcu_bh_lock_map)?
> > 
> > Hmm, I was borrowing the strategy from rcu_read_lock_bh_held() which does not
> > check for a lock held in this map.
> > 
> > Honestly, even  lock_is_held(&rcu_sched_lock_map) seems unnecessary per-se
> > since !preemptible() will catch that? rcu_read_lock_sched() disables
> > preemption already, so lockdep's opinion of the matter seems redundant there.
> 
> Good point!  At least as long as the lockdep splats list RCU-bh among
> the locks held, which they did last I checked.
> 
> Of course, you could make the same argument for getting rid of
> rcu_sched_lock_map.  Does it make sense to have the one without
> the other?

It probably makes it inconsistent in the least. I will add the check for
the rcu_bh_lock_map in a separate patch, if that's Ok with you - since I also
want to update the rcu_read_lock_bh_held() logic in the same patch.

That rcu_read_lock_bh_held() could also just return !preemptible as Peter
suggested for the bh case.

> > Sorry I already sent out patches again before seeing your comment but I can
> > rework and resend them based on any other suggestions.
> 
> Not a problem!

Thanks. Depending on whether there is any other feedback, I will work on the
bh_ stuff as a separate patch on top of this series, or work it into the next
series revision if I'm reposting. Hopefully that sounds Ok to you.

thanks,

 - Joel


