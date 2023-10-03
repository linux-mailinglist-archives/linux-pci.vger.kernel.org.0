Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322C17B5F66
	for <lists+linux-pci@lfdr.de>; Tue,  3 Oct 2023 05:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239019AbjJCDeG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Oct 2023 23:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjJCDd5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Oct 2023 23:33:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9F1C4
        for <linux-pci@vger.kernel.org>; Mon,  2 Oct 2023 20:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696304034; x=1727840034;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8hrPTwG+qvc6yIX5gr87EpGqU45u4drcsvGaXtYvhwU=;
  b=cfNwcx3nfsXHJnb/kiKKoWs3FDfF0QciaOAD4MycWqX7spK3ze/P2vXY
   u+xwIrlaWIylr8kec9XNCIPE2hSLj+xzZH5kq1r3goAx6MihwyxG5N+Tg
   mirDQkun/5iu/us2bOwjciWvO99xcrRUX9CM2IGsJi6QssH2NFnjQlXAC
   HYZwdAAK+WiJlBHGoS4zKdOJlldqcF0DknELFEKAyj/ojO3olv0g9r1D9
   RLOdW+GbZ9l7fo8so9mhPEr7Uf0BeVOgngYOWEqIDvFT8D7AaLHPRuMRV
   Kj8Mo2j9CfvZCyoij4hDrQNLrpJVy0cUVvLimu5vPnWTbdO9DgbsoxGeq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="385607052"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="385607052"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 20:33:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="821089020"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="821089020"
Received: from aeflaneg-mobl.amr.corp.intel.com (HELO [10.212.233.55]) ([10.212.233.55])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 20:33:52 -0700
Message-ID: <520298c9-eda0-4d6f-b14d-5681a6862bc6@linux.intel.com>
Date:   Mon, 2 Oct 2023 20:33:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/ASPM: fix unexpected behavior when re-enabling L1
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Ajay Agarwal <ajayagarwal@google.com>,
        Lukas Wunner <lukas@wunner.de>
References: <20231002151452.GA560499@bhelgaas>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20231002151452.GA560499@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 10/2/2023 8:14 AM, Bjorn Helgaas wrote:
> [+cc Sathy, Lukas]
> 
> On Sat, Aug 26, 2023 at 01:10:35PM +0200, Heiner Kallweit wrote:
>> After the referenced commit we may see L1 sub-states being active
>> unexpectedly. Following scenario as an example:
>> r8169 disables L1 because of known hardware issues on a number of
>> systems. Implicitly L1.1 and L1.2 are disabled too.
>> On my system L1 and L1.1 work fine, but L1.2 causes missed
>> rx packets. Therefore I write 1 to aspm_l1_1.
>> This removes ASPM_STATE_L1 from the disabled modes and therefore
>> unexpectedly enables also L1.2. So return to the old behavior.

IIUC, the above-mentioned SysFS issue will be fixed by your change to
aspm_attr_store_common(), right?

Can you elaborate why you need the following change?

>> @@ -1063,7 +1063,7 @@ static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
>>  	if (state & PCIE_LINK_STATE_L1)
>> -		link->aspm_disable |= ASPM_STATE_L1;
>> +		link->aspm_disable |= ASPM_STATE_L1 | ASPM_STATE_L1SS;

>>
>> A comment in the commit message of the referenced change correctly points
>> out that this behavior is inconsistent with aspm_attr_store_common().
>> So change aspm_attr_store_common() accordingly.
> 
> I think we should split this into a pure revert of fb097dcd5a28 with
> the description of the unintended consequence, followed by another
> patch to change aspm_attr_store_common().
> 

I agree, the revert and new change should be split into two patches.

> I guess the existing aspm_attr_store_common() behavior allows a
> similar unexpected behavior?  For example, in this sequence:
> 
>   - Write 0 to "l1_aspm" to disable L1
>   - Write 1 to "l1_1_aspm" to enable L1.1
> 
> does L1.2 get implicitly enabled as well even though that's clearly
> not what the user intended?
> 
> There's also the separate question of how the sysfs file and the
> pci_disable_link_state() API should interact.  Drivers use that API
> when they know about a defect in their device, but the user can
> override that via syfs.
> 
> In [1], we have a similar situation with D3cold support, where we're
> thinking that we should not allow a user to use sysfs to override that
> driver knowledge.
> 
> Bjorn
> 
> [1] https://lore.kernel.org/r/b8a7f4af2b73f6b506ad8ddee59d747cbf834606.1695025365.git.lukas@wunner.de
> 
>> Fixes: fb097dcd5a28 ("PCI/ASPM: Disable only ASPM_STATE_L1 when driver disables L1")
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  drivers/pci/pcie/aspm.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>> index 3dafba0b5..6d3788257 100644
>> --- a/drivers/pci/pcie/aspm.c
>> +++ b/drivers/pci/pcie/aspm.c
>> @@ -1063,7 +1063,7 @@ static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
>>  	if (state & PCIE_LINK_STATE_L0S)
>>  		link->aspm_disable |= ASPM_STATE_L0S;
>>  	if (state & PCIE_LINK_STATE_L1)
>> -		link->aspm_disable |= ASPM_STATE_L1;
>> +		link->aspm_disable |= ASPM_STATE_L1 | ASPM_STATE_L1SS;
>>  	if (state & PCIE_LINK_STATE_L1_1)
>>  		link->aspm_disable |= ASPM_STATE_L1_1;
>>  	if (state & PCIE_LINK_STATE_L1_2)
>> @@ -1251,6 +1251,8 @@ static ssize_t aspm_attr_store_common(struct device *dev,
>>  			link->aspm_disable &= ~ASPM_STATE_L1;
>>  	} else {
>>  		link->aspm_disable |= state;
>> +		if (state & ASPM_STATE_L1)
>> +			link->aspm_disable |= ASPM_STATE_L1SS;
>>  	}
>>  
>>  	pcie_config_aspm_link(link, policy_to_aspm_state(link));
>> -- 
>> 2.42.0
>>

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
