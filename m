Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 229423D14DE
	for <lists+linux-pci@lfdr.de>; Wed, 21 Jul 2021 19:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbhGUQbJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Jul 2021 12:31:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:39506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229459AbhGUQbI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Jul 2021 12:31:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A930F61222;
        Wed, 21 Jul 2021 17:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626887505;
        bh=AilQ46pk+2fIUx3ol9DVGFG0IMAI8bKWvoJej1mBTDY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=JZBH5p2/I6tnBBYPmppaaMdzLEeyoueUbkDMHEmwNTSac4kmMsdlv8Xzhg2ayUNfn
         ZMdqCJHCzoe08mLJPdx41/2RA3eMnIyqtxtjsOW0uB7RHoAfAhHHqt5zpdmbhXVGTN
         9H69at2PaRgOYVqwmgYIiQsl0nG7G5xlC4ZfkqMGohQU1vgzqQFumFIexQpx+agXrA
         75Q5FBQ5u1VOc9HECTS0hLfhoneoTjyTjveSfsmT5FKJvWyYvmsGxj7kl1c6sA2eTf
         yacL3jFNU4/uVK4w7x/ab51b2wcOpC0p1ilcsm9olodqpNCgArVHBxKfGUKw1xQzQu
         ki0I1YXSh8I+A==
Date:   Wed, 21 Jul 2021 12:11:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christian Gmeiner <christian.gmeiner@gmail.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: dwc: do not ignore link errors
Message-ID: <20210721171142.GA189373@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721152821.2967356-1-christian.gmeiner@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 21, 2021 at 05:28:21PM +0200, Christian Gmeiner wrote:
> This fixes long boot delays of about 10 seconds.
> 
> I am working on a device powered by an TI am65 SoC where
> we have a PCIe expansion slot. If there is no PCIe device
> connected I see boot delays caused by pci_host_probe(..).

I agree this is problematic.  Surely the controller can generate an
interrupt when the link comes up?  If so, can we make an interrupt
handler for that "Link Up" interrupt that calls or schedules
pci_host_probe(), and get rid of dw_pcie_wait_for_link() altogether?

I doubt we want to just return failure here if the link doesn't come
up right away, because then we can never hot-add a device later.

886a9c134755 ("PCI: dwc: Move link handling into common code")
addresses this in the commit log:

  The behavior for a link down was inconsistent as some drivers would
  fail probe in that case while others succeed. Let's standardize this
  to succeed as there are usecases where devices (and the link) appear
  later even without hotplug. For example, a reconfigured FPGA device.

> Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
> ---
> 
> V2: fix compile
> 
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index a608ae1fad57..ce7d3a6f9a03 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -408,8 +408,9 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  			goto err_free_msi;
>  	}
>  
> -	/* Ignore errors, the link may come up later */
> -	dw_pcie_wait_for_link(pci);
> +	ret = dw_pcie_wait_for_link(pci);
> +	if (ret)
> +		goto err_free_msi;
>  
>  	bridge->sysdata = pp;
>  
> -- 
> 2.31.1
> 
