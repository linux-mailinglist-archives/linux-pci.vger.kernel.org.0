Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C38A671FB
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2019 17:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfGLPKy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Jul 2019 11:10:54 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33474 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbfGLPKy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Jul 2019 11:10:54 -0400
Received: by mail-pl1-f195.google.com with SMTP id c14so4908584plo.0
        for <linux-pci@vger.kernel.org>; Fri, 12 Jul 2019 08:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bpkdGumnCxVJ5QkvopMAKHuDk2Cmi1QHk5zgDoY3xmE=;
        b=xyHw0p49aGG+bHJkAwOFsAyVLIy6ynGQUOVqJSZW2rdYBcMge9BS0dv8b3pXcc+QsB
         52ZjWyLo4eCKwwXkK1MywW+/ICPskgQBpOWaqdYt311VFlay/UvS+NI+iDdRBDC8nfQH
         7iG2DsYxsndMDH8pWwOufpGY4o74/6StEFO8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bpkdGumnCxVJ5QkvopMAKHuDk2Cmi1QHk5zgDoY3xmE=;
        b=Ppvx0H+ZKv0IhpWTY7fUXxmmWFYCUMkNEW9ZnvS3A/7xU2m0p8YeHYS/1xKLpdDvhr
         /10A0de336MZ/ys87ZQcHNpn0cuk5KCrHCsUeX3PUo17mydVCE1BMDz9D+nz/R4lBVuI
         Pb0o70EUu6ndwXhcVqqMHfZnB6JNfV6buchlsFURDni2fWtHOm1SZuJDoVx1UdmcJiNf
         0bUZi5jHIedh8pbYmFfcDyo0O6qNzCyLxVXP4speUuzwaxn548X+1BGznQxZ1O6M5Idn
         cmDvKH2X4pHU3yuDPgNll5CJO2L56F5w0P/DIgQheo09RdI8362KmUsRNDwfFB1RoHLd
         ZHkg==
X-Gm-Message-State: APjAAAV9LofttVlUHe3RfenFLpOulqmFvgggiIUWkAeukYdoh0GM3l2H
        OiDRblgE4Na3Ns8T2p4h91o=
X-Google-Smtp-Source: APXvYqxJ7Kem+nQt02Z16GBq/vs2O/YsBJDeceBJIv6amPGaj5XayXNv7u5mL3pmC3eI8AkB/Vv2gw==
X-Received: by 2002:a17:902:6a88:: with SMTP id n8mr12077228plk.70.1562944253560;
        Fri, 12 Jul 2019 08:10:53 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id l124sm8863171pgl.54.2019.07.12.08.10.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 08:10:52 -0700 (PDT)
Date:   Fri, 12 Jul 2019 11:10:51 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
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
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, will@kernel.org,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Subject: Re: [PATCH v1 1/6] rcu: Add support for consolidated-RCU reader
 checking
Message-ID: <20190712151051.GB235410@google.com>
References: <20190711234401.220336-1-joel@joelfernandes.org>
 <20190711234401.220336-2-joel@joelfernandes.org>
 <20190712111125.GT3402@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712111125.GT3402@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 12, 2019 at 01:11:25PM +0200, Peter Zijlstra wrote:
> On Thu, Jul 11, 2019 at 07:43:56PM -0400, Joel Fernandes (Google) wrote:
> > +int rcu_read_lock_any_held(void)
> > +{
> > +	int lockdep_opinion = 0;
> > +
> > +	if (!debug_lockdep_rcu_enabled())
> > +		return 1;
> > +	if (!rcu_is_watching())
> > +		return 0;
> > +	if (!rcu_lockdep_current_cpu_online())
> > +		return 0;
> > +
> > +	/* Preemptible RCU flavor */
> > +	if (lock_is_held(&rcu_lock_map))
> 
> you forgot debug_locks here.

Actually, it turns out debug_locks checking is not even needed. If
debug_locks == 0, then debug_lockdep_rcu_enabled() returns 0 and we would not
get to this point.

> > +		return 1;
> > +
> > +	/* BH flavor */
> > +	if (in_softirq() || irqs_disabled())
> 
> I'm not sure I'd put irqs_disabled() under BH, also this entire
> condition is superfluous, see below.
> 
> > +		return 1;
> > +
> > +	/* Sched flavor */
> > +	if (debug_locks)
> > +		lockdep_opinion = lock_is_held(&rcu_sched_lock_map);
> > +	return lockdep_opinion || !preemptible();
> 
> that !preemptible() turns into:
> 
>   !(preempt_count()==0 && !irqs_disabled())
> 
> which is:
> 
>   preempt_count() != 0 || irqs_disabled()
> 
> and already includes irqs_disabled() and in_softirq().
> 
> > +}
> 
> So maybe something lke:
> 
> 	if (debug_locks && (lock_is_held(&rcu_lock_map) ||
> 			    lock_is_held(&rcu_sched_lock_map)))
> 		return true;

Agreed, I will do it this way (without the debug_locks) like:

---8<-----------------------

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index ba861d1716d3..339aebc330db 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -296,27 +296,15 @@ EXPORT_SYMBOL_GPL(rcu_read_lock_bh_held);
 
 int rcu_read_lock_any_held(void)
 {
-	int lockdep_opinion = 0;
-
 	if (!debug_lockdep_rcu_enabled())
 		return 1;
 	if (!rcu_is_watching())
 		return 0;
 	if (!rcu_lockdep_current_cpu_online())
 		return 0;
-
-	/* Preemptible RCU flavor */
-	if (lock_is_held(&rcu_lock_map))
-		return 1;
-
-	/* BH flavor */
-	if (in_softirq() || irqs_disabled())
-		return 1;
-
-	/* Sched flavor */
-	if (debug_locks)
-		lockdep_opinion = lock_is_held(&rcu_sched_lock_map);
-	return lockdep_opinion || !preemptible();
+	if (lock_is_held(&rcu_lock_map) || lock_is_held(&rcu_sched_lock_map))
+		return 1;
+	return !preemptible();
 }
 EXPORT_SYMBOL_GPL(rcu_read_lock_any_held);
 
