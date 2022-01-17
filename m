Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 134DE4904EB
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jan 2022 10:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235756AbiAQJaJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jan 2022 04:30:09 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:42474 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235753AbiAQJaE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jan 2022 04:30:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD834608C0
        for <linux-pci@vger.kernel.org>; Mon, 17 Jan 2022 09:30:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC4BC36AE3;
        Mon, 17 Jan 2022 09:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642411803;
        bh=2dO/Z2pvb4d/QZ4iCCw/enkh+MU8xdSP5FCVdhoj69c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XHtgSkVJZ35/lRJM9OMIj11U3t5hR8pv7L7Q9NaLBBA0jugr6RMkDEnhB5t727bRR
         zFYfBSXKW0Nu34iQuV2YJju9M3vswdcniGKaZYW19lMcb/1K4hICZbIRGj5Xm3Pxqv
         GoTu7JUUieYSf6bAVh8wO9rXjwPTLEdF5pp6Hi+XgTAm62kgmGg7MojIPl1Sx+pAJh
         8M3rqj/XVbTR5aN1LIQ6DZBQUdT4XJMplJi6ye9f0capC5RdOyEsCtaLmsW/SwWAbR
         jNcHD7fcecXKwX7/rPMVTwF/oiqeGSNqhM5kes4ia7W8KEyyHM2tFAWK1SySO5RN+5
         dZ1GzrckHl/9A==
Received: by pali.im (Postfix)
        id 713E3871; Mon, 17 Jan 2022 10:30:00 +0100 (CET)
Date:   Mon, 17 Jan 2022 10:30:00 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Stefan Roese <sr@denx.de>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Yao Hongbo <yaohongbo@linux.alibaba.com>,
        Naveen Naidu <naveennaidu479@gmail.com>
Subject: Re: [PATCH v2 2/2] PCI/AER: Enable AER on Endpoints as well
Message-ID: <20220117093000.p3a5lqjn4e5kfk3o@pali>
References: <20220117080348.2757180-1-sr@denx.de>
 <20220117080348.2757180-3-sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220117080348.2757180-3-sr@denx.de>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Monday 17 January 2022 09:03:48 Stefan Roese wrote:
> Currently, the PCIe AER subsystem does not enable AER in the PCIe
> Endpoints via the Device Control register. It's only done for the
> Root Port and all PCIe Ports in between the Root Port and the
> Endpoint(s). Some device drivers enable AER in their PCIe device by
> directly calling pci_enable_pcie_error_reporting(). But in most
> cases, AER is currently disabled in the PCIe Endpoints.
> 
> This patch enables AER on PCIe Endpoints now as well in
> set_device_error_reporting(). This will make the ad-hoc calls to
> pci_enable_pcie_error_reporting() superfluous.
> 
> Signed-off-by: Stefan Roese <sr@denx.de>
> Cc: Bjorn Helgaas <helgaas@kernel.org>
> Cc: Pali Rohár <pali@kernel.org>
> Cc: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: Yao Hongbo <yaohongbo@linux.alibaba.com>
> Cc: Naveen Naidu <naveennaidu479@gmail.com>

Reviewed-by: Pali Rohár <pali@kernel.org>

> ---
> v2:
> - New patch
> 
>  drivers/pci/pcie/aer.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 9fa1f97e5b27..385e2033d7b5 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1216,7 +1216,8 @@ static int set_device_error_reporting(struct pci_dev *dev, void *data)
>  	if ((type == PCI_EXP_TYPE_ROOT_PORT) ||
>  	    (type == PCI_EXP_TYPE_RC_EC) ||
>  	    (type == PCI_EXP_TYPE_UPSTREAM) ||
> -	    (type == PCI_EXP_TYPE_DOWNSTREAM)) {
> +	    (type == PCI_EXP_TYPE_DOWNSTREAM) ||
> +	    (type == PCI_EXP_TYPE_ENDPOINT)) {

Hm... maybe another question to discussion: Why enabling of AER is
limited just to above PCIe port types? Why we do not want to enable it
for _all_ PCIe devices? Currently in the above list are missing Legacy
endpoints (which probably do not support AER and so do not have AER
capability in config space), Root Complex Integrated Endpoints (these
should provide AER supports too, right?), PCIe to PCI/X Bridges (these
may generate its own AER errors) and PCI to PCIe Bridges (these are
maybe complicated as subtree behind such bridges are regular PCIe
devices and so could fully support AER but on legacy PCI bus there is
probably no access to extended config space where is AER). But in all of
these cases, are there any issues with enabling AER via function
pci_enable_pcie_error_reporting()? For me it looks like that in the
worst case dev just does not have AER capability in config space or
extended config space is not accessible (which is same as no AER
capability).

>  		if (enable)
>  			pci_enable_pcie_error_reporting(dev);
>  		else
> -- 
> 2.34.1
> 
