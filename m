Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75FE2283E56
	for <lists+linux-pci@lfdr.de>; Mon,  5 Oct 2020 20:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbgJESbn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Oct 2020 14:31:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:38220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726935AbgJESbn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 5 Oct 2020 14:31:43 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83DC820774;
        Mon,  5 Oct 2020 18:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601922702;
        bh=vzwSwHuWzZIKDRTeB20OvPSCcgO4pYSS2Oz7ARQSdAs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=u1mCW6oOrxMxXBWcpKct/iAJmqdE+TL58827+SS3AoPdDcRLECPdEAXpaS2WfL0TA
         q/8Mpwf2B4RQyNAqgQ7JzTn60KrJb89IMLKlN/4tYtEqI7GJjxgMzb070MFMEx2fIb
         czWO53YUZ1gC8/uYSh95dLC0eFn/hSbQKk6+3VPE=
Date:   Mon, 5 Oct 2020 13:31:41 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ian Kumlien <ian.kumlien@gmail.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [PATCH] Use maximum latency when determining L1/L0s ASPM v2
Message-ID: <20201005183141.GA3028319@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803145832.11234-1-ian.kumlien@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

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
> 
> Signed-off-by: Ian Kumlien <ian.kumlien@gmail.com>

I'm not sure where we're at with this.  If we can come up with:

  - "lspci -vv" for the entire affected hierarchy before the fix

  - specific identification of incorrect configuration per spec

  - patch that fixes that specific misconfiguration

  - "lspci -vv" for the entire affected hierarchy after the fix

then we have something to work with.  It doesn't have to (and should
not) fix all the problems at once.

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
> +
>  		/*
>  		 * Check L1 latency.
>  		 * Every switch on the path to root complex need 1
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
>  
>  		link = link->parent;
>  	}
> -- 
> 2.28.0
> 
