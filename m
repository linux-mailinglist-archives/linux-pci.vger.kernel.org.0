Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 170591C5726
	for <lists+linux-pci@lfdr.de>; Tue,  5 May 2020 15:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbgEENiP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 May 2020 09:38:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:55650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728608AbgEENiP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 May 2020 09:38:15 -0400
Received: from localhost (mobile-166-175-56-67.mycingular.net [166.175.56.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E655A206A5;
        Tue,  5 May 2020 13:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588685894;
        bh=qB4MmpYPSXsyc2JhZZVOek3rhd8rGZO3tZNAIqqMSJA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Le6NhDtclW5LGRJrRy7Qzv/jlEVt//5Dt3C71PuKpWfSMbRV9LrZB36geFAsHfb+N
         26468VXZRb09dlxfiirF2B0OustZ4G9G8RkkmxEZHLhcwia3btfOL+6F0oiqDN5+ro
         MN8hqwRGpRS+Q1BY1O+t8UwBYP0AY08Ma6jLgNOE=
Date:   Tue, 5 May 2020 08:38:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     bhelgaas@google.com, Heiner Kallweit <hkallweit1@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Krzysztof Wilczynski <kw@linux.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] PCI/ASPM: Enable ASPM for root complex <-> bridge <->
 bridge case
Message-ID: <20200505133812.GA353121@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505122801.12903-1-kai.heng.feng@canonical.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 05, 2020 at 08:27:59PM +0800, Kai-Heng Feng wrote:
> The TI PCIe-to-PCI bridge prevents the Intel SoC from entering power
> state deeper than PC3 due to disabled ASPM, consumes lots of unnecessary
> power. On Windows ASPM L1 is enabled on the device and its upstream
> bridge, so it can make the Intel SoC reach PC8 or PC10 to save lots of
> power.

The above is a benefit, but leading off with it suggests that this
change is specifically for that config, which it isn't.

> Currently, ASPM is disabled if downstream has bridge function. It was
> introduced by commit 7d715a6c1ae5 ("PCI: add PCI Express ASPM support").
> The commit introduced PCIe ASPM support, but didn't explain why ASPM
> needs to be in that case.

s/needs to be in that case/needs to be disabled in that case/ ?

> So relax the condition a bit to let bridge which connects to root
> complex enables ASPM, instead of removing it completely, to avoid
> regression.

If this is a regression, that means it used to work correctly.  So are
you saying 7d715a6c1ae5^ works correctly?  That seems doubtful since
7d715a6c1ae5 appeared in v2.6.26 and added ASPM support in the first
place.

> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=207571
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/pci/pcie/aspm.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 2378ed692534..af5e22d78101 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -629,13 +629,15 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
>  	/* Setup initial capable state. Will be updated later */
>  	link->aspm_capable = link->aspm_support;
>  	/*
> -	 * If the downstream component has pci bridge function, don't
> -	 * do ASPM for now.

I agree, that comment is missing the essential information about *why*
we don't do ASPM.

> +	 * If upstream bridge isn't connected to root complex and the
> +	 * downstream component has pci bridge function, don't do ASPM for now.

But this comment just perpetuates it and makes the special case even
more special.  I think we should either remove that special case
completely or figure out what the real issue is.

I know we weren't always very good about computing the acceptable
latencies (and we still don't handle LTR correctly, though that's an
L1 Substates issue that wouldn't have applied in the 7d715a6c1ae5
timeframe).

>  	 */
> -	list_for_each_entry(child, &linkbus->devices, bus_list) {
> -		if (pci_pcie_type(child) == PCI_EXP_TYPE_PCI_BRIDGE) {
> -			link->aspm_disable = ASPM_STATE_ALL;
> -			break;
> +	if (parent->bus->parent) {
> +		list_for_each_entry(child, &linkbus->devices, bus_list) {
> +			if (pci_pcie_type(child) == PCI_EXP_TYPE_PCI_BRIDGE) {
> +				link->aspm_disable = ASPM_STATE_ALL;
> +				break;
> +			}
>  		}
>  	}
>  
> -- 
> 2.17.1
> 
