Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 841101739F3
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2020 15:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgB1Oe4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Feb 2020 09:34:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:36054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbgB1Oe4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 Feb 2020 09:34:56 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 523512469F;
        Fri, 28 Feb 2020 14:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582900495;
        bh=w3UA1fKXCu+uvMVyxVCYKL1pRR3K84thi2LNljYiuJs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=IFlyVVE3wEX6cV10osvVSZ29QRyW+OG67t9GAaxaKoX5ypfFtq8LZoMqSkKOBN1DM
         Lhg8QocR6b1QSr21Bv7AhpRsh+CIDEqjMrVXaoD33hXmyxeby0fAVfYOjtBi+k1rNY
         NjLqHPoZFckXPsnGU6c36tNE71nxQdc5JqocqA0E=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D56CD35226D1; Fri, 28 Feb 2020 06:34:54 -0800 (PST)
Date:   Fri, 28 Feb 2020 06:34:54 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     "Derrick, Jonathan" <jonathan.derrick@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>
Subject: Re: [PATCH v2] PCI: vmd: Add indirection layer to vmd irq lists
Message-ID: <20200228143454.GI2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <1572527333-6212-1-git-send-email-jonathan.derrick@intel.com>
 <20191031231126.GG20975@paulmck-ThinkPad-P72>
 <14aa0466567ebf9bff1301c81214a449c581c998.camel@intel.com>
 <20200228111010.GA4064@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228111010.GA4064@e121166-lin.cambridge.arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 28, 2020 at 11:10:10AM +0000, Lorenzo Pieralisi wrote:
> On Wed, Nov 06, 2019 at 04:25:25PM +0000, Derrick, Jonathan wrote:
> > On Thu, 2019-10-31 at 16:11 -0700, Paul E. McKenney wrote:
> > > On Thu, Oct 31, 2019 at 07:08:53AM -0600, Jon Derrick wrote:
> > > > With CONFIG_MAXSMP and CONFIG_PROVE_LOCKING, the size of an srcu_struct can
> > > > grow quite large. In one compilation instance it produced a 74KiB data
> > > > structure. These are embedded in the vmd_irq_list struct, and a N=64 allocation
> > > > can exceed MAX_ORDER, violating reclaim rules.
> > > > 
> > > >   struct srcu_struct {
> > > >           struct srcu_node   node[521];                    /*     0 75024 */
> > > >           /* --- cacheline 1172 boundary (75008 bytes) was 16 bytes ago --- */
> > > >           struct srcu_node *         level[4];             /* 75024    32 */
> > > >           struct mutex       srcu_cb_mutex;                /* 75056   128 */
> > > >           /* --- cacheline 1174 boundary (75136 bytes) was 48 bytes ago --- */
> > > >           spinlock_t                 lock;                 /* 75184    56 */
> > > >           /* --- cacheline 1175 boundary (75200 bytes) was 40 bytes ago --- */
> > > >           struct mutex       srcu_gp_mutex;                /* 75240   128 */
> > > >           /* --- cacheline 1177 boundary (75328 bytes) was 40 bytes ago --- */
> > > >           unsigned int               srcu_idx;             /* 75368     4 */
> > > > 
> > > >           /* XXX 4 bytes hole, try to pack */
> > > > 
> > > >           long unsigned int          srcu_gp_seq;          /* 75376     8 */
> > > >           long unsigned int          srcu_gp_seq_needed;   /* 75384     8 */
> > > >           /* --- cacheline 1178 boundary (75392 bytes) --- */
> > > >           long unsigned int          srcu_gp_seq_needed_exp; /* 75392     8 */
> > > >           long unsigned int          srcu_last_gp_end;     /* 75400     8 */
> > > >           struct srcu_data *         sda;                  /* 75408     8 */
> > > >           long unsigned int          srcu_barrier_seq;     /* 75416     8 */
> > > >           struct mutex       srcu_barrier_mutex;           /* 75424   128 */
> > > >           /* --- cacheline 1180 boundary (75520 bytes) was 32 bytes ago --- */
> > > >           struct completion  srcu_barrier_completion;      /* 75552    80 */
> > > >           /* --- cacheline 1181 boundary (75584 bytes) was 48 bytes ago --- */
> > > >           atomic_t                   srcu_barrier_cpu_cnt; /* 75632     4 */
> > > > 
> > > >           /* XXX 4 bytes hole, try to pack */
> > > > 
> > > >           struct delayed_work work;                        /* 75640   152 */
> > > > 
> > > >           /* XXX last struct has 4 bytes of padding */
> > > > 
> > > >           /* --- cacheline 1184 boundary (75776 bytes) was 16 bytes ago --- */
> > > >           struct lockdep_map dep_map;                      /* 75792    32 */
> > > > 
> > > >           /* size: 75824, cachelines: 1185, members: 17 */
> > > >           /* sum members: 75816, holes: 2, sum holes: 8 */
> > > >           /* paddings: 1, sum paddings: 4 */
> > > >           /* last cacheline: 48 bytes */
> > > >   };
> > > > 
> > > > With N=64 VMD IRQ lists, this would allocate 4.6MiB in a single call. This
> > > > violates MAX_ORDER reclaim rules when PAGE_SIZE=4096 and
> > > > MAX_ORDER_NR_PAGES=1024, and invokes the following warning in mm/page_alloc.c:
> > > > 
> > > >   /*
> > > >    * There are several places where we assume that the order value is sane
> > > >    * so bail out early if the request is out of bound.
> > > >    */
> > > >   if (unlikely(order >= MAX_ORDER)) {
> > > >   	WARN_ON_ONCE(!(gfp_mask & __GFP_NOWARN));
> > > >   	return NULL;
> > > >   }
> > > > 
> > > > This patch changes the irq list array into an array of pointers to irq
> > > > lists to avoid allocation failures with greater msix counts.
> > > > 
> > > > This patch also reverts commit b31822277abcd7c83d1c1c0af876da9ccdf3b7d6.
> > > > The index_from_irqs() helper was added to calculate the irq list index
> > > > from the array of irqs, in order to shrink vmd_irq_list for performance.
> > > > 
> > > > Due to the embedded srcu_struct within the vmd_irq_list struct having a
> > > > varying size depending on a number of factors, the vmd_irq_list struct
> > > > no longer guarantees optimal data structure size and granularity.
> > > > 
> > > > Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> > > > ---
> > > > Added Paul to make him aware of srcu_struct size with these options
> > > 
> > > There was some discussion of making the srcu_struct structure's ->node[]
> > > array be separately allocated, which would allow this array to be
> > > rightsize for the system in question.  However, I believe they ended up
> > > instead separately allocating the srcu_struct structure itself.
> > > 
> > > Without doing something like that, I am kind of stuck.  After all,
> > > at compile time, the kernel build system tells SRCU that it needs to
> > > be prepared to run on systems with thousands of CPUs.  Which requires
> > > substantial memory to keep track of all those CPUs.  Which are not
> > > present on most systems.
> > > 
> > > Thoughts?
> > 
> > Yes I haven't seen an elegant solution other than making users aware
> > of the situation.
> > 
> > Thanks for your input
> 
> Jon, Paul,
> 
> I don't know if there was any further development in this area in the
> meantime, should we proceed with this patch ?

Let me be more explicit.  Would it be helpful to you guys if there was
a variable-sized ->node[] array that is separately allocated?  If so,
please do tell me.  After all, I cannot read your minds  ;-)

An instance of such a variant would not be available via DEFINE_SRCU(),
which at compile time would absolutely need to allocate as many elements
as Kconfig said to allocate.  In addition, instances of srcu_struct
taking this approach would not be usable until after init_srcu_struct()
was invoked, which would allocate a right-sized ->node array.

Again, would this be helpful?

							Thanx, Paul
