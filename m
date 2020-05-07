Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC5C41C9E4F
	for <lists+linux-pci@lfdr.de>; Fri,  8 May 2020 00:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgEGWT4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 18:19:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:53362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbgEGWT4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 May 2020 18:19:56 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 113672082E;
        Thu,  7 May 2020 22:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588889995;
        bh=/VazbYPf8Ao1AjTLIv5tPrNXtqvkoTOm4G4776Dbhc8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=K0bH3KsYmxPVYkHl5vugmjzs8QQS0ryro2WGbz1InP5bfiyhgeqo7uIjtDfrwUQql
         hmjEv0gWWIyrW1tK0QWJgeiSSD/EbH8MVXgdC4G2qqdO2cA+3VMpJT2pkEUI6pDnbV
         EUaZrlAOaX0ccGQmfgTnvFWhkcuqFP5GborudZyI=
Date:   Thu, 7 May 2020 17:19:53 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     bhelgaas@google.com, Heiner Kallweit <hkallweit1@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Krzysztof Wilczynski <kw@linux.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] PCI/ASPM: Enable ASPM for bridge-to-bridge link
Message-ID: <20200507221953.GA36865@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505173423.26968-1-kai.heng.feng@canonical.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 06, 2020 at 01:34:21AM +0800, Kai-Heng Feng wrote:
> The TI PCIe-to-PCI bridge prevents the Intel SoC from entering power
> state deeper than PC3 due to disabled ASPM, consumes lots of unnecessary
> power. On Windows ASPM L1 is enabled on the device and its upstream
> bridge, so it can make the Intel SoC reach PC8 or PC10 to save lots of
> power.
> 
> In short, ASPM always gets disabled on bridge-to-bridge link.
> 
> The special case was part of first ASPM introduction patch, commit
> 7d715a6c1ae5 ("PCI: add PCI Express ASPM support"). However, it didn't
> explain why ASPM needs to be disabled in special bridge-to-bridge case.
> 
> Let's remove the the special case, as PCIe spec already envisioned ASPM
> on bridge-to-bridge link.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=207571
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Applied to pci/aspm for v5.8, thanks!

I did keep your Reviewed-by, Mika.  If the fact that this applies only
to the PCIe-to-PCI/PCI-X case makes your reviewed-by invalid, just let
me know and I'll drop it.

> ---
> v3:
>  - Remove the special case completely.
> 
> v2: 
>  - Enable ASPM on root complex <-> bridge <-> bridge, instead of using
>    quirk.
>  drivers/pci/pcie/aspm.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 2378ed692534..b17e5ffd31b1 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -628,16 +628,6 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
>  
>  	/* Setup initial capable state. Will be updated later */
>  	link->aspm_capable = link->aspm_support;
> -	/*
> -	 * If the downstream component has pci bridge function, don't
> -	 * do ASPM for now.
> -	 */
> -	list_for_each_entry(child, &linkbus->devices, bus_list) {
> -		if (pci_pcie_type(child) == PCI_EXP_TYPE_PCI_BRIDGE) {
> -			link->aspm_disable = ASPM_STATE_ALL;
> -			break;
> -		}
> -	}
>  
>  	/* Get and check endpoint acceptable latencies */
>  	list_for_each_entry(child, &linkbus->devices, bus_list) {
> -- 
> 2.17.1
> 
