Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0028B1B824B
	for <lists+linux-pci@lfdr.de>; Sat, 25 Apr 2020 01:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgDXXDm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Apr 2020 19:03:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:60922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbgDXXDm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Apr 2020 19:03:42 -0400
Received: from localhost (mobile-166-175-187-210.mycingular.net [166.175.187.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0528B20736;
        Fri, 24 Apr 2020 23:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587769422;
        bh=QRC5RDMV9hOxLWtPLZ9RJTdbygVAEKlVTo1MN4TmJNc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=N2tnERDqIqfOCFVIC/E5S1smwiDBsc9kJHSMWpPQklHBz1d72B1R17OEOqNiDv3JE
         XJrseOXKZy9eg8dLNbw1mN6l+IpK92+rw2ImA0pvY87WQBdEnmIZS6a7CLzSnpzQuZ
         z7Q5k7lbSWo3jpTqKVKnUow54mC7B/BRs/cHBCdI=
Date:   Fri, 24 Apr 2020 18:03:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Use of_node_name_eq for node name comparisons
Message-ID: <20200424230340.GA217775@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416215114.7715-1-robh@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 16, 2020 at 04:51:14PM -0500, Rob Herring wrote:
> Convert string compares of DT node names to use of_node_name_eq helper
> instead. This removes direct access to the node name pointer.
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied to pci/hotplug for v5.8, thanks!

> ---
>  drivers/pci/hotplug/rpaphp_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
> index 6504869efabc..9887c9de08c3 100644
> --- a/drivers/pci/hotplug/rpaphp_core.c
> +++ b/drivers/pci/hotplug/rpaphp_core.c
> @@ -435,7 +435,7 @@ static int rpaphp_drc_add_slot(struct device_node *dn)
>   */
>  int rpaphp_add_slot(struct device_node *dn)
>  {
> -	if (!dn->name || strcmp(dn->name, "pci"))
> +	if (!of_node_name_eq(dn, "pci"))
>  		return 0;
>  
>  	if (of_find_property(dn, "ibm,drc-info", NULL))
> -- 
> 2.20.1
> 
