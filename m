Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F136D23279F
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jul 2020 00:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgG2W2E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jul 2020 18:28:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:34994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727840AbgG2W2C (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Jul 2020 18:28:02 -0400
Received: from localhost (mobile-166-175-62-240.mycingular.net [166.175.62.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DB4820656;
        Wed, 29 Jul 2020 22:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596061682;
        bh=pW7ekEO8bAt7LKPm5znSIXBIsDP347S4ljTaX17rO5I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=1MvXiK6DmsG/ZOzT5wemncbWYR5jQuu9RNveny7aNOPlZXNzDzmk+ivoMWrFhNNLH
         Y2canWzhxyhnPcapsFmdAbfgU7y0xwqwYDTQ2WNCaABeDPD65Kd9+RkF0Au+FgaV3F
         5LHjzMFZOqxP1FPOYEoGCnkNL+u7bdNiCtNbEEoU=
Date:   Wed, 29 Jul 2020 17:27:58 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ian Kumlien <ian.kumlien@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] Use maximum latency when determining L1 ASPM
Message-ID: <20200729222758.GA1963264@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727213045.2117855-1-ian.kumlien@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 27, 2020 at 11:30:45PM +0200, Ian Kumlien wrote:
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
> This change fixes a regression introduced by:
> 66ff14e59e8a (PCI/ASPM: Allow ASPM on links to PCIe-to-PCI/PCI-X Bridges)

Hi Ian,

Sorry about the regression, and thank you very much for doing the
hard work of debugging and fixing it!

My guess is that 66ff14e59e8a isn't itself buggy, but it allowed ASPM
to be enabled on a longer path, and we weren't computing the maximum
latency correctly, so ASPM on that longer path exceeded the amount we
could tolerate.  If that's the case, 66ff14e59e8a probably just
exposed an existing problem that could occur in other topologies even
without 66ff14e59e8a.

I'd like to work through this latency code with concrete examples.
Can you collect the "sudo lspci -vv" output and attach it to an entry
at https://bugzilla.kernel.org?  If it's convenient, it would be
really nice to compare it with similar output from before this patch.

Bjorn

> Signed-off-by: Ian Kumlien <ian.kumlien@gmail.com>
> ---
>  drivers/pci/pcie/aspm.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index b17e5ffd31b1..bd53fba7f382 100644
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
> @@ -470,8 +470,9 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
>  		 * substate latencies (and hence do not do any check).
>  		 */
>  		latency = max_t(u32, link->latency_up.l1, link->latency_dw.l1);
> +		l1_max_latency = max_t(u32, latency, l1_max_latency);
>  		if ((link->aspm_capable & ASPM_STATE_L1) &&
> -		    (latency + l1_switch_latency > acceptable->l1))
> +		    (l1_max_latency + l1_switch_latency > acceptable->l1))
>  			link->aspm_capable &= ~ASPM_STATE_L1;
>  		l1_switch_latency += 1000;
>  
> -- 
> 2.27.0
> 
