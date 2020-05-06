Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 445061C7D82
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 00:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730090AbgEFWmb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 May 2020 18:42:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:51010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729654AbgEFWma (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 May 2020 18:42:30 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94B512075E;
        Wed,  6 May 2020 22:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588804950;
        bh=UaeCzXF3gxehCWoev+4woXreftwS3km7FRXYYZNVyW0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=eco718RTIYLy77DqsH8+nRdjWFxXBXDrXCU4osL4eMhby/q94BX2CMkc1LgYVlqy1
         4ewOAaAYCgsGn1zmzUDiJySXvlpJVdBZht21YH7bzpqI71JsXd0bR8Mp1h/JEzAnVd
         1IrKWygXGdTLUTfMvclkgYVcUZTWj3oKIWNHDJo0=
Date:   Wed, 6 May 2020 17:42:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Do not use pcie_get_speed_cap() to determine when
 to start waiting
Message-ID: <20200506224228.GA458845@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416083245.73957-1-mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 16, 2020 at 11:32:45AM +0300, Mika Westerberg wrote:
> Kai-Heng Feng reported that it takes long time (>1s) to resume
> Thunderbolt connected PCIe devices from both runtime suspend and system
> sleep (s2idle).
> 
> These PCIe downstream ports the second link capability (PCI_EXP_LNKCAP2)
> announces support for speeds > 5 GT/s but it is then capped by the
> second link control (PCI_EXP_LNKCTL2) register to 2.5 GT/s. This
> possiblity was not considered in pci_bridge_wait_for_secondary_bus() so
> it ended up waiting for 1100 ms as these ports do not support active
> link layer reporting either.
> 
> PCIe spec 5.0 section 6.6.1 mandates that we must wait minimum of 100 ms
> before sending configuration request to the device below, if the port
> does not support speeds > 5 GT/s, and if it does we first need to wait
> for the data link layer to become active before waiting for that 100 ms.
> 
> PCIe spec 5.0 section 7.5.3.6 further says that all downstream ports
> that support speeds > 5 GT/s must support active link layer reporting so
> instead of looking for the speed we can check for the active link layer
> reporting capability and determine how to wait based on that (as they go
> hand in hand).

I can't quite tell what the defect is here.

I assume you're talking about this text from sec 6.6.1:

  - With a Downstream Port that does not support Link speeds greater
    than 5.0 GT/s, software must wait a minimum of 100 ms before
    sending a Configuration Request to the device immediately below
    that Port.

  - With a Downstream Port that supports Link speeds greater than 5.0
    GT/s, software must wait a minimum of 100 ms after Link training
    completes before sending a Configuration Request to the device
    immediately below that Port. Software can determine when Link
    training completes by polling the Data Link Layer Link Active bit
    or by setting up an associated interrupt (see Section 6.7.3.3 ).

I don't understand what Link Control 2 has to do with this.  The spec
talks about ports *supporting* certain link speeds, which sounds to me
like the Link Capabilities.  It doesn't say anything about the current
or target link speed.

> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206837
> Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/pci/pci.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 595fcf59843f..d9d9ff5b968e 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4822,7 +4822,13 @@ void pci_bridge_wait_for_secondary_bus(struct pci_dev *dev)
>  	if (!pcie_downstream_port(dev))
>  		return;
>  
> -	if (pcie_get_speed_cap(dev) <= PCIE_SPEED_5_0GT) {
> +	/*
> +	 * Since PCIe spec mandates that all downstream ports that support
> +	 * speeds greater than 5 GT/s must support data link layer active
> +	 * reporting so we use that here to determine when the delay should
> +	 * be issued.
> +	 */
> +	if (!dev->link_active_reporting) {
>  		pci_dbg(dev, "waiting %d ms for downstream link\n", delay);
>  		msleep(delay);
>  	} else {
> -- 
> 2.25.1
> 
