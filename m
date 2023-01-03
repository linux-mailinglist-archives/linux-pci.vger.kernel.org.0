Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23FD265C7BA
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jan 2023 20:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238379AbjACTu7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Jan 2023 14:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238993AbjACTut (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Jan 2023 14:50:49 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AD9DEF9
        for <linux-pci@vger.kernel.org>; Tue,  3 Jan 2023 11:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672775443; x=1704311443;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KxhYgpbgG8q84CFYisj7x9zwz/CLDzDNZTCOaAYPpCs=;
  b=dRuckrKM6T8qz52JEj8r4qQnMn2fX5scKK4o5bAAD748bHIc/M7TkaZ9
   FvOfb9vQwd8Mgv1c4nKtQwEaFZt3SHOP9NgZ8/lkCjIjU8mOVhD9Cq/EI
   pikgIsjEwpi4VRqNtLMBFroJbcJjrTkZvdGHjKxe7zN2W2RAmHoUeshT7
   ay05fSK5tW/vkPY2OvGpOzN2BL9I2CUI22eokle4GDtyJUl7TSifzDXsL
   zJ5CXAEvB/wtrf4JnmSD9vFx9t2uBlLwWEWwWgLCSjnGeWREzCOn/Mm64
   PcmLCRbR/228FGwwOXvWNV6IBLvqagfFt6gACEHjr4xZqO/eNGRtsChN1
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="348964056"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="348964056"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 11:50:42 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="654908863"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="654908863"
Received: from jjha-mobl1.amr.corp.intel.com (HELO [10.209.61.244]) ([10.209.61.244])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 11:50:42 -0800
Message-ID: <86ea6848-7608-f42d-c918-9dba618502b1@linux.intel.com>
Date:   Tue, 3 Jan 2023 11:50:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 1/3] PCI/PM: Observe reset delay irrespective of bridge_d3
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci@vger.kernel.org
Cc:     Keith Busch <kbusch@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
        Ravi Kishore Koppuravuri <ravi.kishore.koppuravuri@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sheng Bi <windy.bi.enflame@gmail.com>,
        Stanislav Spassov <stanspas@amazon.de>,
        Yang Su <yang.su@linux.alibaba.com>
References: <cover.1672511016.git.lukas@wunner.de>
 <ec4761d5e7f7a3258d9a37284571b9eb1c2e0a4a.1672511017.git.lukas@wunner.de>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <ec4761d5e7f7a3258d9a37284571b9eb1c2e0a4a.1672511017.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 12/31/22 10:33 AM, Lukas Wunner wrote:
> If a PCI bridge is suspended to D3cold upon entering system sleep,
> resuming it entails a Fundamental Reset per PCIe r6.0 sec 5.8.
> 
> The delay prescribed after a Fundamental Reset in PCIe r6.0 sec 6.6.1
> is sought to be observed by:
> 
>   pci_pm_resume_noirq()
>     pci_pm_bridge_power_up_actions()
>       pci_bridge_wait_for_secondary_bus()
> 
> However, pci_bridge_wait_for_secondary_bus() bails out if the bridge_d3
> flag is not set.  That flag indicates whether a bridge is allowed to
> suspend to D3cold at *runtime*.
> 
> Hence *no* delay is observed on resume from system sleep if runtime
> D3cold is forbidden.  That doesn't make any sense, so drop the bridge_d3
> check from pci_bridge_wait_for_secondary_bus().
> 
> The purpose of the bridge_d3 check was probably to avoid delays if a
> bridge remained in D0 during suspend.  However the sole caller of
> pci_bridge_wait_for_secondary_bus(), pci_pm_bridge_power_up_actions(),
> is only invoked if the previous power state was D3cold.  Hence the
> additional bridge_d3 check seems superfluous.
> 
> Fixes: ad9001f2f411 ("PCI/PM: Add missing link delays required by the PCIe spec")
> Tested-by: Ravi Kishore Koppuravuri <ravi.kishore.koppuravuri@intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v5.5+
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>  drivers/pci/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index fba95486caaf..f43f3e84f634 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4964,7 +4964,7 @@ void pci_bridge_wait_for_secondary_bus(struct pci_dev *dev)
>  	if (pci_dev_is_disconnected(dev))
>  		return;
>  
> -	if (!pci_is_bridge(dev) || !dev->bridge_d3)
> +	if (!pci_is_bridge(dev))
>  		return;
>  
>  	down_read(&pci_bus_sem);

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
