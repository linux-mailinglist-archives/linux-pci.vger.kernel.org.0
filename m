Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5DFC1B8273
	for <lists+linux-pci@lfdr.de>; Sat, 25 Apr 2020 01:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgDXXaT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Apr 2020 19:30:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:40964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbgDXXaT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Apr 2020 19:30:19 -0400
Received: from localhost (mobile-166-175-187-210.mycingular.net [166.175.187.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F13E82076C;
        Fri, 24 Apr 2020 23:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587771018;
        bh=3wEKGv5ox3xBJSPG5UvCryAAs2g1WF/iqr0nCo6RjAs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ijJZnogwLtbiiPpXNEYBOe46Q77VEphxeEa+EJNqdaJPgJ8+BwQ8ZUhiqwd9BU4KT
         KU7/Y+V732uEGy42LTEWPaEBkKN/eJ39B7ogi+HLr6ORH5cq/6bu4aIv+SwiM9PWXu
         Sr3/76LZE+ZGEy1/I8uLeC/f9wYYT5wKsYGe4f2I=
Date:   Fri, 24 Apr 2020 18:30:16 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     linux-pci@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Frederick Lawler <fred@fredlawl.com>,
        Rajat Jain <rajatja@google.com>,
        "Patel, Mayurkumar" <mayurkumar.patel@intel.com>,
        Olof Johansson <olof@lixom.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI/AER: Allow Native AER Host Bridges to use AER
Message-ID: <20200424233016.GA218665@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587418630-13562-2-git-send-email-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jon,

I'm glad you raised this because I think the way we handle
FIRMWARE_FIRST is really screwed up.

On Mon, Apr 20, 2020 at 03:37:09PM -0600, Jon Derrick wrote:
> Some platforms have a mix of ports whose capabilities can be negotiated
> by _OSC, and some ports which are not described by ACPI and instead
> managed by Native drivers. The existing Firmware-First HEST model can
> incorrectly tag these Native, Non-ACPI ports as Firmware-First managed
> ports by advertising the HEST Global Flag and matching the type and
> class of the port (aer_hest_parse).
> 
> If the port requests Native AER through the Host Bridge's capability
> settings, the AER driver should honor those settings and allow the port
> to bind. This patch changes the definition of Firmware-First to exclude
> ports whose Host Bridges request Native AER.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
>  drivers/pci/pcie/aer.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index f4274d3..30fbd1f 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -314,6 +314,9 @@ int pcie_aer_get_firmware_first(struct pci_dev *dev)
>  	if (pcie_ports_native)
>  		return 0;
>  
> +	if (pci_find_host_bridge(dev->bus)->native_aer)
> +		return 0;

I hope we don't have to complicate pcie_aer_get_firmware_first() by
adding this "native_aer" check here.  I'm not sure what we actually
*should* do based on FIRMWARE_FIRST, but I don't think the current
uses really make sense.

I think Linux makes too many assumptions based on the FIRMWARE_FIRST
bit.  The ACPI spec really only says (ACPI v6.3, sec 18.3.2.4):

  If set, FIRMWARE_FIRST indicates to the OSPM that system firmware
  will handle errors from this source first.

  If FIRMWARE_FIRST is set in the flags field, the Enabled field [of
  the HEST AER structure] is ignored by the OSPM.

I do not see anything there about who owns the AER Capability, but
Linux assumes that if FIRMWARE_FIRST is set, firmware must own the AER
Capability.  I think that's reading too much into the spec.

We already have _OSC, which *does* explicitly talk about who owns the
AER Capability, and I think we should rely on that.  If firmware
doesn't want the OS to touch the AER Capability, it should decline to
give ownership to the OS via _OSC.

>  	if (!dev->__aer_firmware_first_valid)
>  		aer_set_firmware_first(dev);
>  	return dev->__aer_firmware_first;
> -- 
> 1.8.3.1
> 
