Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2ADA71104F
	for <lists+linux-pci@lfdr.de>; Thu, 25 May 2023 18:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241849AbjEYQDj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 May 2023 12:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240972AbjEYQDi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 May 2023 12:03:38 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412F31A1;
        Thu, 25 May 2023 09:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685030609; x=1716566609;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tKSomgZfJIJViV5AgHDrW8vEErjJuh+A/tbGzRSSoJA=;
  b=I21IISzJ0LfUbewdIJJDnAo0AGwoa5Ed80TjfEP3ThAE64cHoLBBFFzN
   XM5udKnbuJclmBpaWhVJaoNxI8jvMBkY5Ukqzbs6c+kqC71iRYaJGjprD
   KEDlwiJEKoxL2BhTyAC/ItNtoDEAV0rUjmaCCnzYvLY/vvMstSYYcGqIT
   dkwsYnzXj5M85q2pnJFHnP+oWM5u1DcDT4L0i5Cg1JnXVB/oCKygxRA/8
   LJjwQMw/GaSSV8BuV6FlL+8ZfQVX1h778eL5kgT4jFkQZrAtU7QBmMpwO
   lm7MkJdSTqsSEpAeSWMlLnsYxCkEKirZfdP1TPuzOj3iRMu2om540pvyq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="417411727"
X-IronPort-AV: E=Sophos;i="6.00,191,1681196400"; 
   d="scan'208";a="417411727"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 09:03:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="708055450"
X-IronPort-AV: E=Sophos;i="6.00,191,1681196400"; 
   d="scan'208";a="708055450"
Received: from satuan-mobl1.amr.corp.intel.com (HELO [10.212.187.173]) ([10.212.187.173])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 09:03:02 -0700
Message-ID: <9cf6d69c-7c14-e709-0cd7-d51f21c6141f@linux.intel.com>
Date:   Thu, 25 May 2023 09:03:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH v4 2/2] PCI: Don't assume root ports from > 2015 are power
 manageable
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        Natikar Basavaraj <Basavaraj.Natikar@amd.com>,
        Deucher Alexander <Alexander.Deucher@amd.com>,
        linux-pm@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Iain Lane <iain@orangesquash.org.uk>
References: <20230524190726.17012-1-mario.limonciello@amd.com>
 <20230524190726.17012-2-mario.limonciello@amd.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230524190726.17012-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 5/24/23 12:07 PM, Mario Limonciello wrote:

This looks like a generic fix to me. So why talk about > 2015? IMO,
you can remove > 2015 from the title.

> Using a USB keyboard or mouse to wakeup the system from s2idle fails when
> that XHCI device is connected to a USB-C port for an AMD USB4 router.
> 
> Due to commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> all PCIe ports go into D3 during s2idle.
> 
> When specific root ports are put into D3 over s2idle on some AMD platforms
> it is not possible for the platform to properly identify wakeup sources.
> This happens whether the root port goes into D3hot or D3cold.

I think Linux/Windows comparison is also not needed. But it is up to you.

> 
> Comparing registers between Linux and Windows 11 this behavior to put
> these specific root ports into D3 at suspend is unique to Linux. On an
> affected system Windows does not put those specific root ports into D3
> over Modern Standby.
> 
> Windows doesn't put the root ports into D3 because root ports are not
> power manageable.
> 
> Linux shouldn't assume root ports support D3 just because they're on a
> machine newer than 2015, the ports should also be deemed power manageable.
> Add an extra check explicitly for root ports to ensure D3 isn't selected
> for these ports.
> 

Other than above suggestions, rest looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

> Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> Reported-by: Iain Lane <iain@orangesquash.org.uk>
> Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v3->v4:
>  * Move after refactor
> ---
>  drivers/pci/pci.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index d1fa040bcea7..d293db963327 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3015,6 +3015,14 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>  	if (dmi_check_system(bridge_d3_blacklist))
>  		return false;
>  
> +	/*
> +	 * It's not safe to put root ports that don't support power
> +	 * management into D3.
> +	 */
> +	if (pci_pcie_type(bridge) == PCI_EXP_TYPE_ROOT_PORT &&
> +	    !platform_pci_power_manageable(bridge))
> +		return false;
> +
>  	/*
>  	 * It should be safe to put PCIe ports from 2015 or newer
>  	 * to D3.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
