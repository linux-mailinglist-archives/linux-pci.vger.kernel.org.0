Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8F444968A4
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jan 2022 01:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiAVAWd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jan 2022 19:22:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiAVAWd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jan 2022 19:22:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB063C06173B
        for <linux-pci@vger.kernel.org>; Fri, 21 Jan 2022 16:22:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D452B8215F
        for <linux-pci@vger.kernel.org>; Sat, 22 Jan 2022 00:22:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31FC4C340E1;
        Sat, 22 Jan 2022 00:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642810948;
        bh=NTowGpsEDBr1J7UMM7f/hBovn31BRiOyXt89K/3JyUQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Yj7FzJiFqx1NJ90Q1n8Me9ZK6eBOwAOcIKpvogLVu357ahUimL+CnPLoFrPoTZQ2G
         9XWGMFNZwsjhKx4rAby/rScDp9Kwt8iLn+5dz7d3HrQErYpUMzZo7igbxqUwroPgxb
         JlGvA73dST31O2K29kb1Ib2KaVnqHgg4kFuAgSYx8Sc3yPowTxDYMjoJq3erumoiKv
         /xxWViGWZN4dFFqGpNFzoGFsQKH7tS/HwrQ0yBByPtz3VG6E8KyRbA5ersfmnE8AgZ
         6Q3ZFLXfqoh/ziUWU1/0BO6ZRyLMg+i4W5KTo5iGeJcu/GvK5SoPpJ04ER+SQwonoK
         uTr4Wp9FdmNPg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id ECF715C4C94; Fri, 21 Jan 2022 16:22:27 -0800 (PST)
Date:   Fri, 21 Jan 2022 16:22:27 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Scott Wood <swood@redhat.com>
Cc:     Jon Derrick <jonathan.derrick@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v2] PCI: vmd: Add indirection layer to vmd irq lists
Message-ID: <20220122002227.GC947480@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <1572527333-6212-1-git-send-email-jonathan.derrick@intel.com>
 <YetJ1ZYMVOEkblAM@p1g2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YetJ1ZYMVOEkblAM@p1g2>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 21, 2022 at 06:03:33PM -0600, Scott Wood wrote:
> On Thu, Oct 31, 2019 at 07:08:53AM -0600, Jon Derrick wrote:
> > With CONFIG_MAXSMP and CONFIG_PROVE_LOCKING, the size of an srcu_struct can
> > grow quite large. In one compilation instance it produced a 74KiB data
> > structure. These are embedded in the vmd_irq_list struct, and a N=64 allocation
> > can exceed MAX_ORDER, violating reclaim rules.
> [snip]
> > ---
> > Added Paul to make him aware of srcu_struct size with these options
> > 
> > v1->v2:
> > Squashed the revert into this commit
> > changed n=1 kcalloc to kzalloc
> > 
> >  drivers/pci/controller/vmd.c | 47 ++++++++++++++++++++++----------------------
> >  1 file changed, 24 insertions(+), 23 deletions(-)
> 
> Has there been any progress on this?  We're seeing a similar problem
> in a PREEMPT_RT kernel with MAXSMP.

In case this helps...

I have started working on shrinking the srcu_struct structure.  Those
possessing intestinal fortitude of mythic proportions might wish to
try this very lightly tested -rcu commits out:

1385139340b7 ("srcu: Dynamically allocate srcu_node array")

This will be followed by additional commits that will dispense
entirely with the srcu_node array unless or until that particular
srcu_struct structure encounters significant update-side contention.

Thoughts?

							Thanx, Paul

------------------------------------------------------------------------

commit 1385139340b7a1c8f35cb7a52af221096cdef86e
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Fri Jan 21 16:13:52 2022 -0800

    srcu: Dynamically allocate srcu_node array
    
    This commit shrinks the srcu_struct structure by converting its ->node
    field from a fixed-size compile-time array to a pointer to a dynamically
    allocated array.  In kernels built with large values of NR_CPUS that boot
    on systems with smaller numbers of CPUs, this can save significant memory.
    
    Reported-by: A cast of thousands
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 4025840ba9a38..f7190058fb8ab 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -60,7 +60,7 @@ struct srcu_node {
  * Per-SRCU-domain structure, similar in function to rcu_state.
  */
 struct srcu_struct {
-	struct srcu_node node[NUM_RCU_NODES];	/* Combining tree. */
+	struct srcu_node *node;			/* Combining tree. */
 	struct srcu_node *level[RCU_NUM_LVLS + 1];
 						/* First node at each level. */
 	struct mutex srcu_cb_mutex;		/* Serialize CB preparation. */
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 7d13e35e5d277..7cb5f34c62418 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -24,6 +24,7 @@
 #include <linux/smp.h>
 #include <linux/delay.h>
 #include <linux/module.h>
+#include <linux/slab.h>
 #include <linux/srcu.h>
 
 #include "rcu.h"
@@ -75,12 +76,44 @@ do {									\
 	spin_unlock_irqrestore(&ACCESS_PRIVATE(p, lock), flags)	\
 
 /*
- * Initialize SRCU combining tree.  Note that statically allocated
+ * Initialize SRCU per-CPU data.  Note that statically allocated
  * srcu_struct structures might already have srcu_read_lock() and
  * srcu_read_unlock() running against them.  So if the is_static parameter
  * is set, don't initialize ->srcu_lock_count[] and ->srcu_unlock_count[].
+ *
+ * Returns @true if allocation succeeded and @false otherwise.
+ */
+static void init_srcu_struct_data(struct srcu_struct *ssp)
+{
+	int cpu;
+	struct srcu_data *sdp;
+
+	/*
+	 * Initialize the per-CPU srcu_data array, which feeds into the
+	 * leaves of the srcu_node tree.
+	 */
+	WARN_ON_ONCE(ARRAY_SIZE(sdp->srcu_lock_count) !=
+		     ARRAY_SIZE(sdp->srcu_unlock_count));
+	for_each_possible_cpu(cpu) {
+		sdp = per_cpu_ptr(ssp->sda, cpu);
+		spin_lock_init(&ACCESS_PRIVATE(sdp, lock));
+		rcu_segcblist_init(&sdp->srcu_cblist);
+		sdp->srcu_cblist_invoking = false;
+		sdp->srcu_gp_seq_needed = ssp->srcu_gp_seq;
+		sdp->srcu_gp_seq_needed_exp = ssp->srcu_gp_seq;
+		sdp->mynode = NULL;
+		sdp->cpu = cpu;
+		INIT_WORK(&sdp->work, srcu_invoke_callbacks);
+		timer_setup(&sdp->delay_work, srcu_delay_timer, 0);
+		sdp->ssp = ssp;
+	}
+}
+
+/*
+ * Allocated and initialize SRCU combining tree.  Returns @true if
+ * allocation succeeded and @false otherwise.
  */
-static void init_srcu_struct_nodes(struct srcu_struct *ssp)
+static bool init_srcu_struct_nodes(struct srcu_struct *ssp)
 {
 	int cpu;
 	int i;
@@ -92,6 +125,9 @@ static void init_srcu_struct_nodes(struct srcu_struct *ssp)
 
 	/* Initialize geometry if it has not already been initialized. */
 	rcu_init_geometry();
+	ssp->node = kcalloc(rcu_num_nodes, sizeof(*ssp->node), GFP_ATOMIC);
+	if (!ssp->node)
+		return false;
 
 	/* Work out the overall tree geometry. */
 	ssp->level[0] = &ssp->node[0];
@@ -129,29 +165,19 @@ static void init_srcu_struct_nodes(struct srcu_struct *ssp)
 	 * Initialize the per-CPU srcu_data array, which feeds into the
 	 * leaves of the srcu_node tree.
 	 */
-	WARN_ON_ONCE(ARRAY_SIZE(sdp->srcu_lock_count) !=
-		     ARRAY_SIZE(sdp->srcu_unlock_count));
 	level = rcu_num_lvls - 1;
 	snp_first = ssp->level[level];
 	for_each_possible_cpu(cpu) {
 		sdp = per_cpu_ptr(ssp->sda, cpu);
-		spin_lock_init(&ACCESS_PRIVATE(sdp, lock));
-		rcu_segcblist_init(&sdp->srcu_cblist);
-		sdp->srcu_cblist_invoking = false;
-		sdp->srcu_gp_seq_needed = ssp->srcu_gp_seq;
-		sdp->srcu_gp_seq_needed_exp = ssp->srcu_gp_seq;
 		sdp->mynode = &snp_first[cpu / levelspread[level]];
 		for (snp = sdp->mynode; snp != NULL; snp = snp->srcu_parent) {
 			if (snp->grplo < 0)
 				snp->grplo = cpu;
 			snp->grphi = cpu;
 		}
-		sdp->cpu = cpu;
-		INIT_WORK(&sdp->work, srcu_invoke_callbacks);
-		timer_setup(&sdp->delay_work, srcu_delay_timer, 0);
-		sdp->ssp = ssp;
 		sdp->grpmask = 1 << (cpu - sdp->mynode->grplo);
 	}
+	return true;
 }
 
 /*
@@ -162,6 +188,7 @@ static void init_srcu_struct_nodes(struct srcu_struct *ssp)
  */
 static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 {
+	ssp->node = NULL;
 	mutex_init(&ssp->srcu_cb_mutex);
 	mutex_init(&ssp->srcu_gp_mutex);
 	ssp->srcu_idx = 0;
@@ -174,7 +201,8 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 		ssp->sda = alloc_percpu(struct srcu_data);
 	if (!ssp->sda)
 		return -ENOMEM;
-	init_srcu_struct_nodes(ssp);
+	init_srcu_struct_data(ssp);
+	WARN_ON_ONCE(!init_srcu_struct_nodes(ssp));
 	ssp->srcu_gp_seq_needed_exp = 0;
 	ssp->srcu_last_gp_end = ktime_get_mono_fast_ns();
 	smp_store_release(&ssp->srcu_gp_seq_needed, 0); /* Init done. */
