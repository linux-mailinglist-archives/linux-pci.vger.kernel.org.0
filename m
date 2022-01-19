Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC3284938AE
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jan 2022 11:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346375AbiASKhR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jan 2022 05:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240089AbiASKhP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jan 2022 05:37:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39388C061574
        for <linux-pci@vger.kernel.org>; Wed, 19 Jan 2022 02:37:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBB27615B8
        for <linux-pci@vger.kernel.org>; Wed, 19 Jan 2022 10:37:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 187B5C004E1;
        Wed, 19 Jan 2022 10:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642588634;
        bh=TjTZwal2S4wQseFf6EPXhLlLNJ8ifolG/o8pz/Lda4U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZkHN0YgPn974TfRCmLbvPT2rxn6wLs0SwXEg7Q6BL6O+zH3+TXNwzcTijMaaQTuga
         m/ltfAAXaRJh+w09DRrszLrv68GYQGyXtVoRo44665tq1evUhwctPAJ9eWUGr9llID
         Q+wa501e0zPpZKaCeNOKsNqM+j4VW82zomwJpYRrs41DOOmApWBpACSSiMxQVMLsn8
         8naCOmSl1phVJcYFzgv5gvt/XCfDLy87bCFU8l2a1ijr5/h8u5SYXbO8cqbbeESJP7
         VYUREL7RNwEr2edJZN9Na3S8hWVCRJNKWwWikNqP//bQSdXDZ38Zyzjweze/S6TiaX
         X7BNnhW0tic8Q==
Received: by pali.im (Postfix)
        id 3B0E67DF; Wed, 19 Jan 2022 11:37:11 +0100 (CET)
Date:   Wed, 19 Jan 2022 11:37:11 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Stefan Roese <sr@denx.de>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Yao Hongbo <yaohongbo@linux.alibaba.com>,
        Naveen Naidu <naveennaidu479@gmail.com>
Subject: Re: [PATCH v3 2/2] PCI/AER: Enable AER on all PCIe devices
 supporting it
Message-ID: <20220119103711.hadtvpxklfnxmqth@pali>
References: <20220119092200.35823-1-sr@denx.de>
 <20220119092200.35823-3-sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220119092200.35823-3-sr@denx.de>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 19 January 2022 10:22:00 Stefan Roese wrote:
> With this change, AER is now enabled on all PCIe devices, also when the
> PCIe device is hot-plugged.
> 
> Please note that this change is quite invasive, as with this patch
> applied, AER now will be enabled in the Device Control registers of all
> available PCIe Endpoints, which currently is not the case.
> 
> When "pci=noaer" is selected, AER stays disabled of course.

Hello Stefan! I was thinking more about this change and I'm not sure
what happens if AER-capable PCIe device is hotplugged into some PCIe
switch connected in the PCIe hierarchy where Root Port is not
AER-capable (e.g. current linux implementation of pci-aardvark.c and
pci-mvebu.c). My feeling is that in this case AER should not be enabled
as there is nobody who can deliver AER interrupt to the OS. But I really
do not know what is supposed from kernel AER driver, so lets wait for
Bjorn reply.

And when you opened this issue with hotplugging, another thing for
followup changes in future is calling pcie_set_ecrc_checking() function
to align ECRC state of newly hotplugged device with "pci=ecrc=..."
cmdline option. As currently it is done only at that function
set_device_error_reporting().

> Signed-off-by: Stefan Roese <sr@denx.de>
> Cc: Bjorn Helgaas <helgaas@kernel.org>
> Cc: Pali Rohár <pali@kernel.org>
> Cc: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: Yao Hongbo <yaohongbo@linux.alibaba.com>
> Cc: Naveen Naidu <naveennaidu479@gmail.com>
> ---
> v3:
> - New patch, replacing the "old" 2/2 patch
>   Now enabling of AER for each PCIe device is done in pci_aer_init(),
>   which also makes sure that AER is enabled in each PCIe device even when
>   it's hot-plugged.
> 
>  drivers/pci/pcie/aer.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 9fa1f97e5b27..01a25e4a5168 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -387,6 +387,10 @@ void pci_aer_init(struct pci_dev *dev)
>  	pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_ERR, sizeof(u32) * n);
>  
>  	pci_aer_clear_status(dev);
> +
> +	/* Enable AER if requested */
> +	if (pci_aer_available())
> +		pci_enable_pcie_error_reporting(dev);
>  }
>  
>  void pci_aer_exit(struct pci_dev *dev)
> -- 
> 2.34.1
> 
