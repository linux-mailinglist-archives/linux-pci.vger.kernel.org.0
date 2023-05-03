Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994AF6F4E5B
	for <lists+linux-pci@lfdr.de>; Wed,  3 May 2023 03:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbjECBKY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 May 2023 21:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjECBKY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 May 2023 21:10:24 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF2726A9
        for <linux-pci@vger.kernel.org>; Tue,  2 May 2023 18:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683076222; x=1714612222;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qkjHhoNFl2wffQqFwwDO1U8PNcp3kIF334YG3q8M1fE=;
  b=hrPQ/YVl/Ew64zzZ3YIax+OPYWvGYJkd0EqKBj+To7jfEuFUBRD8Xn3T
   VZl1UMEm9JoK34pdSoV4oKH3aTtdsxrlW6k0JzBOBYK85wEZbv4ANRzyY
   xaEkWQj6Q5tCHi6gu9sqCLnEuw7Flv8OAugdnAt6bEbFa8bIChJvxCzYm
   4sOQb9FaHNnuoYAoNRYqPyzWCspTXfpwc1znYqFEUWhkj+zH0r0UsJi7B
   +oeFPzdexDpse5ipZG2xsvjjD2AELWsAuzoGceMtHwxWOAm4mo2H9T+wz
   MnXASu8jBRbeGM9tn0jFQjRI9n2BBZPCrsO6w11tz+bj5WgySomMk9INq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="347358987"
X-IronPort-AV: E=Sophos;i="5.99,245,1677571200"; 
   d="scan'208";a="347358987"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2023 18:10:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="820597163"
X-IronPort-AV: E=Sophos;i="5.99,245,1677571200"; 
   d="scan'208";a="820597163"
Received: from leeliche-mobl.amr.corp.intel.com (HELO [10.209.114.176]) ([10.209.114.176])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2023 18:10:21 -0700
Message-ID: <993c522a-04e6-6125-8d22-663bd414220f@linux.intel.com>
Date:   Tue, 2 May 2023 18:10:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/5] PCI/ASPM: Disable ASPM_STATE_L1 only when class
 driver disables L1 ASPM
Content-Language: en-US
To:     Ajay Agarwal <ajayagarwal@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Nikhil Devshatwar <nikhilnd@google.com>,
        Manu Gautam <manugautam@google.com>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Michael Bottini <michael.a.bottini@linux.intel.com>
Cc:     linux-pci@vger.kernel.org
References: <20230502193140.1062470-1-ajayagarwal@google.com>
 <20230502193140.1062470-2-ajayagarwal@google.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230502193140.1062470-2-ajayagarwal@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 5/2/23 12:31 PM, Ajay Agarwal wrote:
> Currently the aspm driver sets ASPM_STATE_L1 as well as
> ASPM_STATE_L1SS bits in aspm_disable when the caller disables L1.
> pcie_config_aspm_link takes care that L1ss ASPM is not enabled
> if L1 is disabled. ASPM_STATE_L1SS bits do not need to be
> explicitly set. The sysfs node store() function, which also
> modifies the aspm_disable value, does not set these bits either
> when only L1 ASPM is disabled by the user.
> 
> Disable ASPM_STATE_L1 only when the caller disables L1 ASPM.

Maybe you can add something like, No functional changes intended.

Otherwise, looks good.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

> 
> Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
> ---
> Changelog since v1:
>  - Better commit message
> 
>  drivers/pci/pcie/aspm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 66d7514ca111..5765b226102a 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1095,8 +1095,7 @@ static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
>  	if (state & PCIE_LINK_STATE_L0S)
>  		link->aspm_disable |= ASPM_STATE_L0S;
>  	if (state & PCIE_LINK_STATE_L1)
> -		/* L1 PM substates require L1 */
> -		link->aspm_disable |= ASPM_STATE_L1 | ASPM_STATE_L1SS;
> +		link->aspm_disable |= ASPM_STATE_L1;
>  	if (state & PCIE_LINK_STATE_L1_1)
>  		link->aspm_disable |= ASPM_STATE_L1_1;
>  	if (state & PCIE_LINK_STATE_L1_2)

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
