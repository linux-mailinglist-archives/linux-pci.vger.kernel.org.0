Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCDBC2879BC
	for <lists+linux-pci@lfdr.de>; Thu,  8 Oct 2020 18:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbgJHQNP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Oct 2020 12:13:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:47326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgJHQNP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Oct 2020 12:13:15 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E00D421D7D;
        Thu,  8 Oct 2020 16:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602173594;
        bh=8ZKrJvFjYcqF7yWTHLfBpFKASIzzL+rwwIWL3y+OoZY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=rXv9bsXrRpPh8l0k7R6hR53t09aVDkCld6H/ofPtBsza2urJRNUN2J0mBdbmLnHwZ
         KMo4e/HSIOE1qmUbzCawBUtoUQChL0KZK0g8SkVXnXnoDXmrhLt+XfPWQQ88EbrHjX
         w2Yz1ieraHz6PQsWWwZR18U6fTmur8gxoa3IFf5I=
Date:   Thu, 8 Oct 2020 11:13:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ian Kumlien <ian.kumlien@gmail.com>
Cc:     linux-pci@vger.kernel.org, alexander.duyck@gmail.com,
        refactormyself@gmail.com, puranjay12@gmail.com,
        kai.heng.feng@canonical.com
Subject: Re: [PATCH] Use maximum latency when determining L1 ASPM
Message-ID: <20201008161312.GA3261279@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201007132808.647589-1-ian.kumlien@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 07, 2020 at 03:28:08PM +0200, Ian Kumlien wrote:
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
> lspci -PP -s 04:00.0
> 00:01.2/01:00.0/02:04.0/04:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. Device 816e (rev 1a)
> 
> lspci -vvv -s 04:00.0
> 		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
> ...
> 		LnkCap:	Port #0, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s unlimited, L1 <64us
> ...
> 
> Which means that it can't be followed by any switch that is in L1 state.
> 
> This patch fixes it by disabling L1 on 02:04.0, 01:00.0 and 00:01.2.
> 
>                                                     LnkCtl    LnkCtl
>            ------DevCap-------  ----LnkCap-------  -Before-  -After--
>   00:01.2                                L1 <32us       L1+       L1-
>   01:00.0                                L1 <32us       L1+       L1-
>   02:04.0                                L1 <32us       L1+       L1-
>   04:00.0  L0s <512 L1 <64us             L1 <64us       L1+       L1-

OK, now we're getting close.  We just need to flesh out the
justification.  We need:

  - Tidy subject line.  Use "git log --oneline drivers/pci/pcie/aspm.c"
    and follow the example.

  - Description of the problem.  I think it's poor bandwidth on your
    Intel I211 device, but we don't have the complete picture because
    that NIC is 03:00.0, which doesn't appear above at all.

  - Explanation of what's wrong with the "before" ASPM configuration.
    I want to identify what is wrong on your system.  The generic
    "doesn't match spec" part is good, but step 1 is the specific
    details, step 2 is the generalization to relate it to the spec.

  - Complete "sudo lspci -vv" information for before and after the
    patch below.  https://bugzilla.kernel.org/show_bug.cgi?id=208741
    has some of this, but some of the lspci output appears to be
    copy/pasted and lost all its formatting, and it's not clear how
    some was collected (what kernel version, with/without patch, etc).
    Since I'm asking for bugzilla attachments, there's no space
    constraint, so just attach the complete unedited output for the
    whole system.

  - URL to the bugzilla.  Please open a new one with just the relevant
    problem report ("NIC is slow") and attach (1) "before" lspci
    output, (2) proposed patch, (3) "after" lspci output.  The
    existing 208741 report is full of distractions and jumps to the
    conclusion without actually starting with the details of the
    problem.

Some of this I would normally just do myself, but I can't get the
lspci info.  It would be really nice if Kai-Heng could also add
before/after lspci output from the system he tested.

> Signed-off-by: Ian Kumlien <ian.kumlien@gmail.com>
> ---
>  drivers/pci/pcie/aspm.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 253c30cc1967..893b37669087 100644
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
> @@ -469,11 +473,14 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
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
> +
> +			l1_switch_latency += 1000;
> +		}
>  
>  		link = link->parent;
>  	}
> -- 
> 2.28.0
> 
