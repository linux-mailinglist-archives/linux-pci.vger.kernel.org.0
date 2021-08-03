Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CECCF3DF87B
	for <lists+linux-pci@lfdr.de>; Wed,  4 Aug 2021 01:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbhHCX3G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Aug 2021 19:29:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:40612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232515AbhHCX3G (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Aug 2021 19:29:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A30A60F70;
        Tue,  3 Aug 2021 23:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628033332;
        bh=GmoA4YfZ69M3eQkFSrZN2NVFszn93izMv7Ht0OYeC5M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=e43diXsmvY6wHs4oCwSTY6aWBaQ7ccBlc5nXCQ2QL3/Xr7os2Daom1MjaHzHo367G
         axj3H9MhjJdccSK8TH1WIh6TJ3Nn2UENDhRIAKzdrLA9GX3CZTpOavwQeEkiUwBuFh
         cHTXdktoNRHKc0ZA0OcJ44XP02EH2qgyxiWfoer7q1uIk9qDJgakHo1G544yWCEfWu
         GChsYiXCm6J5A4GW2Hjok5RHozpQ+JdBzrFQKCBblgoRLRmNSePXGqoEbW9VcrO1Bl
         nIq65w5EXsp5odzsvt5WfRDeg0G2iW7GlQD7gDIXvcu/uB0mcnPY6H+ZMQe7fxvcGf
         9vyaVnJ9yYC/A==
Date:   Tue, 3 Aug 2021 18:28:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com, rajatja@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/ACS: Enforce pci=noats with Transaction Blocking
Message-ID: <20210803232851.GA1585719@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162404966325.2362347.12176138291577486015.stgit@omen>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 18, 2021 at 02:55:14PM -0600, Alex Williamson wrote:
> PCIe Address Translation Services (ATS) provides a mechanism for a
> device to provide an on-device caching translation agent (device
> iotlb).  We already have a means to disable support for this feature
> via the pci=noats option.  For untrusted and externally facing
> devices, we not only disable ATS support for the device, but we use
> Access Control Services (ACS) Transaction Blocking to actively
> prevent devices from sending TLPs with non-default AT field values.
> 
> Extend pci=noats to also make use of PCI_ACS_TB so that not only is
> ATS disabled at the device, but blocked at the downstream ports.
> This provides a means to further lock-down ATS for cases such as
> device assignment, where it may not be the hardware configuration of
> the device that makes it untrusted, but the driver running on the
> device.
> 
> Cc: Rajat Jain <rajatja@google.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Applied to pci/virtualization for v5.15, thanks!

> ---
>  drivers/pci/pci.c    |    4 ++--
>  drivers/pci/quirks.c |    2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 68f57d86b243..5aa1bb2ddd80 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -915,8 +915,8 @@ static void pci_std_enable_acs(struct pci_dev *dev)
>  	/* Upstream Forwarding */
>  	ctrl |= (cap & PCI_ACS_UF);
>  
> -	/* Enable Translation Blocking for external devices */
> -	if (dev->external_facing || dev->untrusted)
> +	/* Enable Translation Blocking for external devices and noats */
> +	if (pci_ats_disabled() || dev->external_facing || dev->untrusted)
>  		ctrl |= (cap & PCI_ACS_TB);
>  
>  	pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 6d74386eadc2..d541076c083a 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5031,7 +5031,7 @@ static int pci_quirk_enable_intel_spt_pch_acs(struct pci_dev *dev)
>  	ctrl |= (cap & PCI_ACS_CR);
>  	ctrl |= (cap & PCI_ACS_UF);
>  
> -	if (dev->external_facing || dev->untrusted)
> +	if (pci_ats_disabled() || dev->external_facing || dev->untrusted)
>  		ctrl |= (cap & PCI_ACS_TB);
>  
>  	pci_write_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, ctrl);
> 
> 
