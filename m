Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55597274A00
	for <lists+linux-pci@lfdr.de>; Tue, 22 Sep 2020 22:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgIVUTI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Sep 2020 16:19:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:57238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbgIVUTI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Sep 2020 16:19:08 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAE54206B8;
        Tue, 22 Sep 2020 20:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600805947;
        bh=5vaoB8bMEsqE1CjBGD8gxuRQHtgfFBROf8RboMZHGX8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Me8dYSTteB/U2r4PdCKGp8joC5TzuFGIrLgZnGcGoCsAjgCeZCLLT8/35p4P0Pyvd
         LU2jCOa75j9YzhVwTp1Ar1/RsfNVqiYES3vFUPY0PUrrX6fzP8tOo92MwricqUTjY5
         Y/oytbN1vXHIG0u6ytV/D9ByOh0MKYaAhPwakSfo=
Date:   Tue, 22 Sep 2020 15:19:05 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ian Kumlien <ian.kumlien@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>
Subject: Re: [PATCH] Use maximum latency when determining L1/L0s ASPM v2
Message-ID: <20200922201905.GA2224139@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200803145832.11234-1-ian.kumlien@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Saheed, Puranjay]

On Mon, Aug 03, 2020 at 04:58:32PM +0200, Ian Kumlien wrote:
> Changes:
> * Handle L0s correclty as well, making it per direction
> * Moved the switch cost in to the if statement since a non L1 switch has
>   no additional cost.
> 
> For L0s:
> We sumarize the entire latency per direction to see if it's acceptable
> for the PCIe endpoint.
> 
> If it's not, we clear the link for the path that had too large latency.
> 
> For L1:
> Currently we check the maximum latency of upstream and downstream
> per link, not the maximum for the path
> 
> This would work if all links have the same latency, but:
> endpoint -> c -> b -> a -> root  (in the order we walk the path)
> 
> If c or b has the higest latency, it will not register
> 
> Fix this by maintaining the maximum latency value for the path
> 
> This change fixes a regression introduced (but not caused) by:
> 66ff14e59e8a (PCI/ASPM: Allow ASPM on links to PCIe-to-PCI/PCI-X Bridges)

We need to include some info about the problem here, e.g., the sort of
info hinted at in
https://lore.kernel.org/r/CAA85sZvJQge6ETwF1GkdvK1Mpwazh_cYJcmeZVAohmt0FjbMZg@mail.gmail.com

It would be *really* nice to have "lspci -vv" output for the system
when broken and when working correctly.  If they were attached to a
bugzilla.kernel.org entry, we could include the URL to that here.

> Signed-off-by: Ian Kumlien <ian.kumlien@gmail.com>
> ---
>  drivers/pci/pcie/aspm.c | 41 ++++++++++++++++++++++++++---------------
>  1 file changed, 26 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index b17e5ffd31b1..bc512e217258 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -434,7 +434,8 @@ static void pcie_get_aspm_reg(struct pci_dev *pdev,
>  
>  static void pcie_aspm_check_latency(struct pci_dev *endpoint)
>  {
> -	u32 latency, l1_switch_latency = 0;
> +	u32 latency, l1_max_latency = 0, l1_switch_latency = 0,
> +		l0s_latency_up = 0, l0s_latency_dw = 0;
>  	struct aspm_latency *acceptable;
>  	struct pcie_link_state *link;
>  
> @@ -447,15 +448,22 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
>  	acceptable = &link->acceptable[PCI_FUNC(endpoint->devfn)];
>  
>  	while (link) {
> -		/* Check upstream direction L0s latency */
> -		if ((link->aspm_capable & ASPM_STATE_L0S_UP) &&
> -		    (link->latency_up.l0s > acceptable->l0s))
> -			link->aspm_capable &= ~ASPM_STATE_L0S_UP;
> -
> -		/* Check downstream direction L0s latency */
> -		if ((link->aspm_capable & ASPM_STATE_L0S_DW) &&
> -		    (link->latency_dw.l0s > acceptable->l0s))
> -			link->aspm_capable &= ~ASPM_STATE_L0S_DW;
> +		if (link->aspm_capable & ASPM_STATE_L0S) {
> +			/* Check upstream direction L0s latency */
> +			if (link->aspm_capable & ASPM_STATE_L0S_UP) {
> +				l0s_latency_up += link->latency_up.l0s;
> +				if (l0s_latency_up > acceptable->l0s)
> +					link->aspm_capable &= ~ASPM_STATE_L0S_UP;
> +			}
> +
> +			/* Check downstream direction L0s latency */
> +			if (link->aspm_capable & ASPM_STATE_L0S_DW) {
> +				l0s_latency_dw += link->latency_dw.l0s;
> +				if (l0s_latency_dw > acceptable->l0s)
> +					link->aspm_capable &= ~ASPM_STATE_L0S_DW;
> +			}
> +		}

The main point of the above is to accumulate l0s_latency_up and
l0s_latency_dw along the entire path.  I don't understand the
additional:

  if (link->aspm_capable & ASPM_STATE_L0S)

around the whole block.  I don't think it's *wrong*, but unless I'm
missing something it's unnecessary since we already check for
ASPM_STATE_L0S_UP and ASPM_STATE_L0S_DW.  It does make it arguably
more parallel with the ASPM_STATE_L1 case below, but it complicates
the diff enough that I'm not sure it's worth it.

I think this could also be split off as a separate patch to fix the
L0s latency checking.

>  		/*
>  		 * Check L1 latency.
>  		 * Every switch on the path to root complex need 1

Let's take the opportunity to update the comment to add the spec
citation for this additional 1 usec of L1 exit latency for every
switch.  I think it is PCIe r5.0, sec 5.4.1.2.2, which says:

  A Switch is required to initiate an L1 exit transition on its
  Upstream Port Link after no more than 1 μs from the beginning of an
  L1 exit transition on any of its Downstream Port Links.

> @@ -469,11 +477,14 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
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

This accumulates the 1 usec delays for a Switch to propagate the exit
transition from its Downstream Port to its Upstream Port, but it
doesn't accumulate the L1 exit latencies themselves for the entire
path, does it?  I.e., we don't accumulate "latency" for the whole
path.  Don't we need that?

>  		link = link->parent;
>  	}
> -- 
> 2.28.0
> 
