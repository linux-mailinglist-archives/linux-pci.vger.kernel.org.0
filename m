Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2076489DA
	for <lists+linux-pci@lfdr.de>; Fri,  9 Dec 2022 22:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiLIVE1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Dec 2022 16:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiLIVEX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Dec 2022 16:04:23 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0444FB07AE
        for <linux-pci@vger.kernel.org>; Fri,  9 Dec 2022 13:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670619862; x=1702155862;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Zf2AJZYYZZg7iFROb/tP1Q23AdFGwrRbdQN443z4gYo=;
  b=gDxAhpNa5FGzRdrvwSc6hiSXEjMEg6IQb7upDlYoaeiQ3sSK7gpdUTar
   3kwttQ8gVhh9I0b/6rLjEtQZf1ioxT1clzjWpskM/758I3csKaDthLbpP
   ZH4WeL4LcvrQCeSzpMCxlJgUW2qRG4F/riWz9OjaU4p2vepOx9e+XgxPV
   jrONM8k+BMTC82qXlBXUl/sPDyl9+/vDmRqWaSHL/uGbq9eL+RA1EMUnw
   KdYYBc2bObhdhvWhb0H4imSPlibRhxEAxqEAR74YKCW80NyDEmGUsCHMN
   4m5PJqDWBSrWzkoS+DlA5xAfk+t6Odfm6s5uSYidhQtoGHDXyGPgosGEI
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="344592559"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="344592559"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 13:04:22 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="680047987"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="680047987"
Received: from rrode-mobl1.amr.corp.intel.com (HELO [10.251.24.37]) ([10.251.24.37])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 13:04:22 -0800
Message-ID: <6cd41027-bda8-a57a-ea18-33308fd681f1@linux.intel.com>
Date:   Fri, 9 Dec 2022 13:04:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v2] PCI/portdrv: Do not require an interrupt for all AER
 capable ports
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
References: <20221209170712.GA1627846@bhelgaas>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20221209170712.GA1627846@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 12/9/22 9:07 AM, Bjorn Helgaas wrote:
> On Wed, Dec 07, 2022 at 10:41:05AM +0200, Mika Westerberg wrote:
>> Only Root Ports and Event Collectors use MSI for AER. PCIe Switch ports
>> or endpoints on the other hand only send messages (that get collected by
>> the former). For this reason do not require PCIe switch ports and
>> endpoints to use interrupt if they support AER.
>>
>> This allows portdrv to attach PCIe switch ports of Intel DG1 and DG2
>> discrete graphics cards. These do not declare MSI or legacy interrupts.
>>
>> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Thanks for the additional info!  This seems like something we should
> definitely do.
> 
> I'm wondering whether we should check for this in
> get_port_device_capability().  It already has similar checks for
> device type for other services.  This would skip pci_set_master() for
> these non-RP, non-RCEC devices, which is probably harmless, since I
> assume we only need that to make sure MSI works.

Currently, we only have high level (cap or enable/disable) checks in 
get_port_device_capability(). Why bring in more AER specific checks
there and make it complicated? Is there any benefit in doing this?

> 
> It would also prevent allocation of the AER service for non-RP,
> non-RCEC devices.  That's also probably harmless, since aer_probe()
> ignores those devices anyway.
> 
> What do you think of something like this?  (This is based on my
> pci/portdrv branch which squashed everything into portdrv.c:
> https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=pci/portdrv)
> 
> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index a6c4225505d5..8b16e96ec15c 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -232,7 +232,9 @@ static int get_port_device_capability(struct pci_dev *dev)
>  	}
>  
>  #ifdef CONFIG_PCIEAER
> -	if (dev->aer_cap && pci_aer_available() &&
> +	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> +             pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) &&
> +	    dev->aer_cap && pci_aer_available() &&
>  	    (pcie_ports_native || host->native_aer))
>  		services |= PCIE_PORT_SERVICE_AER;
>  #endif

If you want to do it, will you remove the relevant check in AER driver
probe?


-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
