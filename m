Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB5BA2F3DBE
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jan 2021 01:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437002AbhALVhN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Jan 2021 16:37:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:37448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437021AbhALUmp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Jan 2021 15:42:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D8DC522DFA;
        Tue, 12 Jan 2021 20:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610484124;
        bh=Jx8pGRlLDrjjP+Fq9/Sw3nurTHY381O0KfCYsbhOLjU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=hmuhtYsSE/btYpfJ94B8LaWcLD9ErTUIN2+BXv88yC4i3IQBP6xlJ9pCR1vkYjtAy
         Jm2SUYw0GYpN0ahpJwzopvIERhZcwHEiStN2Iuv97Wqd/ItJDG+zcWinAV1JrtJoAO
         3JtZPfcsEyJaDsAMDKg7go05aLazEAvAEM6uXb8SAmYO425wplrF9wMjuW88DHKVG0
         j7JSxZAn/XQ5TpciFJkGfapGzI7njDy4+pSrOSsQZyeSC7RVgUQr81HEnUKcdMAsov
         g1GyC/c6IuUNjIW47mWiOKajE+mGJ+4HDmLpfzIOlibm4Ko2qURrMlu4zW521dbl/G
         dKy7eyhxSdaqQ==
Date:   Tue, 12 Jan 2021 14:42:02 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ian Kumlien <ian.kumlien@gmail.com>
Cc:     kai.heng.feng@canonical.com, linux-pci@vger.kernel.org,
        alexander.duyck@gmail.com, refactormyself@gmail.com,
        puranjay12@gmail.com
Subject: Re: [PATCH 1/3] PCI/ASPM: Use the path max in L1 ASPM latency check
Message-ID: <20210112204202.GA1489918@bjorn-Precision-5520>
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
> 
> The current code doesn't take the maximum latency into account.
> 
> From the example:
>    +----------------+
>    |                |
>    |  Root complex  |
>    |                |
>    |    +-----+     |
>    |    |32 μs|     |
>    +----------------+
>            |
>            |  Link 1
>            |
>    +----------------+
>    |     |8 μs|     |
>    |     +----+     |
>    |    Switch A    |
>    |     +----+     |
>    |     |8 μs|     |
>    +----------------+
>            |
>            |  Link 2
>            |
>    +----------------+
>    |    |32 μs|     |
>    |    +-----+     |
>    |    Switch B    |
>    |    +-----+     |
>    |    |32 μs|     |
>    +----------------+
>            |
>            |  Link 3
>            |
>    +----------------+
>    |     |8μs|      |
>    |     +---+      |
>    |   Endpoint C   |
>    |                |
>    |                |
>    +----------------+
> 
> Links 1, 2 and 3 are all in L1 state - endpoint C initiates the
> transition to L0 at time T. Since switch B takes 32 μs to exit L1 on
> it's ports, Link 3 will transition to L0 at T+32 (longest time
> considering T+8 for endpoint C and T+32 for switch B).
> 
> Switch B is required to initiate a transition from the L1 state on it's
> upstream port after no more than 1 μs from the beginning of the
> transition from L1 state on the downstream port. Therefore, transition from
> L1 to L0 will begin on link 2 at T+1, this will cascade up the path.
> 
> The path will exit L1 at T+34.
> 
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

I don't think this is quite right.  We're looking at the path to
04:00.0, which includes two Links and one Switch:

The upstream Link:
  00:01.2 AMD Root Port               L1 Exit Latency <32us
  01:00.0 AMD Switch Upstream Port    L1 Exit Latency <32us

The downstream Link:
  02:04.0 AMD Switch Downstream Port  L1 Exit Latency <32us
  04:00.0 Realtek Endpoint            L1 Exit Latency <64us, Acceptable 64us

If both Links are in L1 and 04:00.0 needs to use the Link at time T,
I think the following events are relevant:

  T        04:00.0 initiates L1 exit on downstream Link
  T+1us    01:00.0 initiates L1 exit on upstream Link
  T+33us   upstream Link is in L0 (32us after initiating exit)
  T+64us   downstream Link is in L0 (64us after initiating exit)

The upstream Link's L1 exit latency is completely covered by the
downstream Link's, so 04:00.0 *should* only see its own exit latency
(64us), which it claims to be able to tolerate.

This patch computes "l1_max_latency + l1_switch_latency", which is
64us + 1us in this case.  I don't think it's correct to add the 1us
here because that delay is only relevant to the upstream Link.  We
should add it to the *upstream Link's* exit latency, but even with
that, its exit latency is only 33us from 04:00.0's point of view.

> Without this patch, 03:00.0 misbehaves and only gives me ~40 mbit/s over
> links with 6 or more hops. With this patch I'm back to a maximum of ~933
> mbit/s.
> 
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
> 
> It correctly identifies the issue.
> 
> For reference, pcie information:
> https://bugzilla.kernel.org/show_bug.cgi?id=209725
> 
> Kai-Heng Feng has a machine that will not boot with ASPM without this patch,
> information is documented here:
> https://bugzilla.kernel.org/show_bug.cgi?id=209671
> 
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

This is pretty subtle but I *think* the existing code is actually
correct.  The exit latency of a downstream Link overlaps all except
1us of the latency of the next upstream Link, so I don't think we have
to add the total Switch delay to the max Link exit latency.  We only
have to add the Switch delays downstream of Link X to Link X's exit
latency.

Also, I think we should accumulate the 1us Switch latency for *all*
Switches as the existing code does.  For the case where a Switch's
Upstream Port is L1-capable but the Downstream Port is not, this patch
doesn't add any l1_switch_latency.  That assumes the Switch can start
the upstream L1 exit instantly upon receipt of a TLP at the Downstream
Port.  I think we should assume it takes the same time (up to 1us) to
start that exit as it would if the Downstream Port were in L1.

>  		link = link->parent;
>  	}

My guess is the real problem is the Switch is advertising incorrect
exit latencies.  If the Switch advertised "<64us" exit latency for its
Upstream Port, we'd compute "64us exit latency + 1us Switch delay =
65us", which is more than either 03:00.0 or 04:00.0 can tolerate, so
we would disable L1 on that upstream Link.

Working around this would require some sort of quirk to override the
values read from the Switch, which is a little messy.  Here's what I'm
thinking (not asking you to do this; just trying to think of an
approach):

  - Configure common clock earlier, in pci_configure_device(), because
    this changes the "read-only" L1 exit latencies in Link
    Capabilities.

  - Cache Link Capabilities in the pci_dev.

  - Add a quirk to override the cached values for the Switch based on
    Vendor/Device ID and probably DMI motherboard/BIOS info.

Bjorn
