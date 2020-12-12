Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE33F2D8AAF
	for <lists+linux-pci@lfdr.de>; Sun, 13 Dec 2020 00:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbgLLXsU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 12 Dec 2020 18:48:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:34128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbgLLXsU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 12 Dec 2020 18:48:20 -0500
Date:   Sat, 12 Dec 2020 17:47:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607816859;
        bh=Qm8Kw0pVUY9fTQzc7h1oKrohv7LjCc8x3xPQywEFlOc=;
        h=From:To:Cc:Subject:In-Reply-To:From;
        b=exsg12L2WxGXsGh9XNl5XefWnLBi9u067p1UjCWgSpfFAeaI8vgf4ceTTefM7r8E8
         IVhCzLWYrfsZph+4L8Xci8D9mfR/Om69NJgrbB+wIigAFebe8jLhEQi3lN6yYeF4j1
         +MPyOysAU0xHjaborfsH4CEDuoxOomFzFPk7i8t7ampx6VvL7LzFo368R4MZ+liDBR
         NQiEolemC8avodxtAPdNM08v3eTTxRUMbrukGRRrTrUG0jMseVPkTMe/8hyXmbUw75
         O7Z0iCgdVp+8fMCyvAf5KF4b0perEJbCJMx+G2g04WJZ1UnfoasFiLcRWXBqDLltj2
         1YoQJf45/cdHw==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ian Kumlien <ian.kumlien@gmail.com>
Cc:     kai.heng.feng@canonical.com, linux-pci@vger.kernel.org,
        alexander.duyck@gmail.com, refactormyself@gmail.com,
        puranjay12@gmail.com
Subject: Re: [PATCH 1/3] PCI/ASPM: Use the path max in L1 ASPM latency check
Message-ID: <20201212234737.GA130506@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201024205548.1837770-1-ian.kumlien@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Oct 24, 2020 at 10:55:46PM +0200, Ian Kumlien wrote:
> Make pcie_aspm_check_latency comply with the PCIe spec, specifically:
> "5.4.1.2.2. Exit from the L1 State"
> 
> Which makes it clear that each switch is required to initiate a
> transition within 1μs from receiving it, accumulating this latency and
> then we have to wait for the slowest link along the path before
> entering L0 state from L1.
> ...

> On my specific system:
> 03:00.0 Ethernet controller: Intel Corporation I211 Gigabit Network Connection (rev 03)
> 04:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. Device 816e (rev 1a)
> 
>             Exit latency       Acceptable latency
> Tree:       L1       L0s       L1       L0s
> ----------  -------  -----     -------  ------
> 00:01.2     <32 us   -
> | 01:00.0   <32 us   -
> |- 02:03.0  <32 us   -
> | \03:00.0  <16 us   <2us      <64 us   <512ns
> |
> \- 02:04.0  <32 us   -
>   \04:00.0  <64 us   unlimited <64 us   <512ns
> 
> 04:00.0's latency is the same as the maximum it allows so as we walk the path
> the first switchs startup latency will pass the acceptable latency limit
> for the link, and as a side-effect it fixes my issues with 03:00.0.
> 
> Without this patch, 03:00.0 misbehaves and only gives me ~40 mbit/s over
> links with 6 or more hops. With this patch I'm back to a maximum of ~933
> mbit/s.

There are two paths here that share a Link:

  00:01.2 --- 01:00.0 -- 02:03.0 --- 03:00.0 I211 NIC
  00:01.2 --- 01:00.0 -- 02:04.0 --- 04:00.x multifunction Realtek

1) The path to the I211 NIC includes four Ports and two Links (the
   connection between 01:00.0 and 02:03.0 is internal Switch routing,
   not a Link).

   The Ports advertise L1 exit latencies of <32us, <32us, <32us,
   <16us.  If both Links are in L1 and 03:00.0 initiates L1 exit at T,
   01:00.0 initiates L1 exit at T + 1.  A TLP from 03:00.0 may see up
   to 1 + 32 = 33us of L1 exit latency.

   The NIC can tolerate up to 64us of L1 exit latency, so it is safe
   to enable L1 for both Links.

2) The path to the Realtek device is similar except that the Realtek
   L1 exit latency is <64us.  If both Links are in L1 and 04:00.x
   initiates L1 exit at T, 01:00.0 again initiates L1 exit at T + 1,
   but a TLP from 04:00.x may see up to 1 + 64 = 65us of L1 exit
   latency.

   The Realtek device can only tolerate 64us of latency, so it is not
   safe to enable L1 for both Links.  It should be safe to enable L1
   on the shared link because the exit latency for that link would be
   <32us.

> The original code path did:
> 04:00:0-02:04.0 max latency 64    -> ok
> 02:04.0-01:00.0 max latency 32 +1 -> ok
> 01:00.0-00:01.2 max latency 32 +2 -> ok
> 
> And thus didn't see any L1 ASPM latency issues.
> 
> The new code does:
> 04:00:0-02:04.0 max latency 64    -> ok
> 02:04.0-01:00.0 max latency 64 +1 -> latency exceeded
> 01:00.0-00:01.2 max latency 64 +2 -> latency exceeded

[Nit: I don't think we should add 1 for the 02:04.0 -- 01:00.0 piece
because that's internal Switch routing, not a Link.  But even without
that extra microsecond, this path does exceed the acceptable latency
since 1 + 64 = 65us, and 04:00.0 can only tolerate 64us.]

> It correctly identifies the issue.
> 
> For reference, pcie information:
> https://bugzilla.kernel.org/show_bug.cgi?id=209725

The "lspci without my patches" [1] shows L1 enabled for the shared
Link from 00:01.2 --- 01:00.0 and for the Link to 03:00.0 (I211), but
not for the Link to 04:00.x (Realtek).

Per my analysis above, that looks like it *should* be a safe
configuration.  03:00.0 can tolerate 64us, actual is <33us.  04:00.0
can tolerate 64us, actual should be <32us since only the shared Link
is in L1.

However, the commit log at [2] shows L1 *enabled* for both the shared
Link from 00:01.2 --- 01:00.0 and the 02:04.0 --- 04:00.x Link, and 
that would definitely be a problem.

Can you explain the differences between [1] and [2]?

> Kai-Heng Feng has a machine that will not boot with ASPM without this patch,
> information is documented here:
> https://bugzilla.kernel.org/show_bug.cgi?id=209671

I started working through this info, too, but there's not enough
information to tell what difference this patch makes.  The attachments
compare:

  1) CONFIG_PCIEASPM_DEFAULT=y without the patch [3] and
  2) CONFIG_PCIEASPM_POWERSAVE=y *with* the patch [4]

Obviously CONFIG_PCIEASPM_POWERSAVE=y will configure things
differently than CONFIG_PCIEASPM_DEFAULT=y, so we can't tell what
changes are due to the config change and what are due to the patch.

The lspci *with* the patch ([4]) shows L0s and L1 enabled at almost
every possible place.  Here are the Links, how they're configured, and
my analysis of the exit latencies vs acceptable latencies:

  00:01.1 --- 01:00.0      L1+ (                  L1 <64us vs unl)
  00:01.2 --- 02:00.0      L1+ (                  L1 <64us vs 64us)
  00:01.3 --- 03:00.0      L1+ (                  L1 <64us vs 64us)
  00:01.4 --- 04:00.0      L1+ (                  L1 <64us vs unl)
  00:08.1 --- 05:00.x L0s+ L1+ (L0s <64ns vs 4us, L1  <1us vs unl)
  00:08.2 --- 06:00.0 L0s+ L1+ (L0s <64ns vs 4us, L1  <1us vs unl)

So I can't tell what change prevents the freeze.  I would expect the
patch would cause us to *disable* L0s or L1 somewhere.

The only place [4] shows ASPM disabled is for 05:00.1.  The spec says
we should program the same value in all functions of a multi-function
device.  This is a non-ARI device, so "only capabilities enabled in
all functions are enabled for the component as a whole."  That would
mean that L0s and L1 are effectively disabled for 05:00.x even though
05:00.0 claims they're enabled.  But the latencies say ASPM L0s and L1
should be safe to be enabled.  This looks like another bug that's
probably unrelated.

The patch might be correct; I haven't actually analyzed the code.  But
the commit log doesn't make sense to me yet.

[1] https://bugzilla.kernel.org/attachment.cgi?id=293047
[2] https://lore.kernel.org/linux-pci/20201007132808.647589-1-ian.kumlien@gmail.com/
[3] https://bugzilla.kernel.org/attachment.cgi?id=292955
[4] https://bugzilla.kernel.org/attachment.cgi?id=292957

> Signed-off-by: Ian Kumlien <ian.kumlien@gmail.com>
> Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/pci/pcie/aspm.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 253c30cc1967..c03ead0f1013 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -434,7 +434,7 @@ static void pcie_get_aspm_reg(struct pci_dev *pdev,
>  
>  static void pcie_aspm_check_latency(struct pci_dev *endpoint)
>  {
> -	u32 latency, l1_switch_latency = 0;
> +	u32 latency, l1_max_latency = 0, l1_switch_latency = 0;
>  	struct aspm_latency *acceptable;
>  	struct pcie_link_state *link;
>  
> @@ -456,10 +456,14 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
>  		if ((link->aspm_capable & ASPM_STATE_L0S_DW) &&
>  		    (link->latency_dw.l0s > acceptable->l0s))
>  			link->aspm_capable &= ~ASPM_STATE_L0S_DW;
> +
>  		/*
>  		 * Check L1 latency.
> -		 * Every switch on the path to root complex need 1
> -		 * more microsecond for L1. Spec doesn't mention L0s.
> +		 *
> +		 * PCIe r5.0, sec 5.4.1.2.2 states:
> +		 * A Switch is required to initiate an L1 exit transition on its
> +		 * Upstream Port Link after no more than 1 μs from the beginning of an
> +		 * L1 exit transition on any of its Downstream Port Links.
>  		 *
>  		 * The exit latencies for L1 substates are not advertised
>  		 * by a device.  Since the spec also doesn't mention a way
> @@ -469,11 +473,13 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
>  		 * L1 exit latencies advertised by a device include L1
>  		 * substate latencies (and hence do not do any check).
>  		 */
> -		latency = max_t(u32, link->latency_up.l1, link->latency_dw.l1);
> -		if ((link->aspm_capable & ASPM_STATE_L1) &&
> -		    (latency + l1_switch_latency > acceptable->l1))
> -			link->aspm_capable &= ~ASPM_STATE_L1;
> -		l1_switch_latency += 1000;
> +		if (link->aspm_capable & ASPM_STATE_L1) {
> +			latency = max_t(u32, link->latency_up.l1, link->latency_dw.l1);
> +			l1_max_latency = max_t(u32, latency, l1_max_latency);
> +			if (l1_max_latency + l1_switch_latency > acceptable->l1)
> +				link->aspm_capable &= ~ASPM_STATE_L1;
> +			l1_switch_latency += 1000;
> +		}
>  
>  		link = link->parent;
>  	}
> -- 
> 2.29.1
> 
