Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85EE1264FB3
	for <lists+linux-pci@lfdr.de>; Thu, 10 Sep 2020 21:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgIJTt3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Sep 2020 15:49:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:56586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbgIJTtD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Sep 2020 15:49:03 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E3EA21556;
        Thu, 10 Sep 2020 19:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599767343;
        bh=fQPrOqT+dPGzhbvMzpauhMm/mvp1v3NIk76kgWfOD7o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=DKM20eDAwuHYONhV12jFXqeC2HLdXGgogHQPtJuj5xFEUHldpKpWAOlE1rq6XO36d
         Et3WGV5co/glraAfZ9lZXZ00mrO8xZLI0Uw50pDLZlv/dF1MZKmll4GCUIyoaT2z7S
         IudFewmZXDDYL9/eOAHc+VL+eXBZNllc+QNoGI9E=
Date:   Thu, 10 Sep 2020 14:49:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com
Subject: Re: [PATCH v8 1/5] PCI: Conditionally initialize host bridge
 native_* members
Message-ID: <20200910194901.GA808976@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a76b4a524d3915d42e894da7f4dbdec6c104512.1595649348.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 24, 2020 at 08:58:52PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> If CONFIG_PCIEPORTBUS is not enabled in kernel then initialing
> struct pci_host_bridge PCIe specific native_* members to "1" is
> incorrect. So protect the PCIe specific member initialization
> with CONFIG_PCIEPORTBUS.

s/initialing/initializing/

> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  drivers/pci/probe.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 2f66988cea25..a94b97564ceb 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -588,12 +588,14 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
>  	 * may implement its own AER handling and use _OSC to prevent the
>  	 * OS from interfering.
>  	 */
> +#ifdef CONFIG_PCIEPORTBUS
>  	bridge->native_aer = 1;
>  	bridge->native_pcie_hotplug = 1;
> -	bridge->native_shpc_hotplug = 1;
>  	bridge->native_pme = 1;
>  	bridge->native_ltr = 1;

native_ltr isn't dependent on PCIEPORTBUS either, is it?  It's only
used for ASPM.

>  	bridge->native_dpc = 1;
> +#endif
> +	bridge->native_shpc_hotplug = 1;
>  
>  	device_initialize(&bridge->dev);
>  }
> -- 
> 2.17.1
> 
