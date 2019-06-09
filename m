Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9D503AB25
	for <lists+linux-pci@lfdr.de>; Sun,  9 Jun 2019 20:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbfFISib (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 Jun 2019 14:38:31 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:39503 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729384AbfFISib (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 Jun 2019 14:38:31 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 0743B300000AD;
        Sun,  9 Jun 2019 20:38:28 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id B91004D0F8; Sun,  9 Jun 2019 20:38:28 +0200 (CEST)
Date:   Sun, 9 Jun 2019 20:38:28 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/3] PCI: Do not poll for PME if the device is in D3cold
Message-ID: <20190609183828.eyjxg32bpwswkg2u@wunner.de>
References: <20190605145820.37169-1-mika.westerberg@linux.intel.com>
 <20190605145820.37169-3-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605145820.37169-3-mika.westerberg@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 05, 2019 at 05:58:19PM +0300, Mika Westerberg wrote:
> PME polling does not take into account that a device that is directly
> connected to the host bridge may go into D3cold as well. This leads to a
> situation where the PME poll thread reads from a config space of a
> device that is in D3cold and gets incorrect information because the
> config space is not accessible.
> 
> Here is an example from Intel Ice Lake system where two PCIe root ports
> are in D3cold (I've instrumented the kernel to log the PMCSR register
> contents):
> 
>   [   62.971442] pcieport 0000:00:07.1: Check PME status, PMCSR=0xffff
>   [   62.971504] pcieport 0000:00:07.0: Check PME status, PMCSR=0xffff
> 
> Since 0xffff is interpreted so that PME is pending, the root ports will
> be runtime resumed. This repeats over and over again essentially
> blocking all runtime power management.
> 
> Prevent this from happening by checking whether the device is in D3cold
> before its PME status is read.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Lukas Wunner <lukas@wunner.de>
Fixes: 71a83bd727cc ("PCI/PM: add runtime PM support to PCIe port")
Cc: stable@vger.kernel.org # v3.6+

Although the patch I've posted today (which checks for an "all ones" read
from config space) covers the issue fixed herein, your patch still makes
sense to avoid unnecessarily accessing config space in the first place.

Thanks,

Lukas

> ---
>  drivers/pci/pci.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 87a1f902fa8e..720da09d4d73 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2060,6 +2060,13 @@ static void pci_pme_list_scan(struct work_struct *work)
>  			 */
>  			if (bridge && bridge->current_state != PCI_D0)
>  				continue;
> +			/*
> +			 * If the device is in D3cold it should not be
> +			 * polled either.
> +			 */
> +			if (pme_dev->dev->current_state == PCI_D3cold)
> +				continue;
> +
>  			pci_pme_wakeup(pme_dev->dev, NULL);
>  		} else {
>  			list_del(&pme_dev->list);
> -- 
> 2.20.1
> 
