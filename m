Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5CB1731ABF
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jun 2023 16:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344674AbjFOOCx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Jun 2023 10:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344705AbjFOOCs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Jun 2023 10:02:48 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303E42954;
        Thu, 15 Jun 2023 07:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686837762; x=1718373762;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=zttLVJaw4A/zKfW8QvRzstWGwu9ts8jjjqC2T5OQw1c=;
  b=Qy5+s+MTbVvxYpPuJSE9NqKYt0DdQpZjU3gXsw2Da1GneaJ1jGdJdtNM
   JFFDyjUW4MRO2aDkxNeOmqEtoleZhd90NC5yWsoiwfszEWRws53smcbj3
   yq0vraT75n2Fmev8I/ZnfIXNToqSXRFAJ1x3RBCdJIrk4xQgg9xOm/m12
   hK93Tw466wqRqzRQNq//KLCLGwfyMgRLMHO3yKsfTXkxeG455GoerH6KP
   XvqRiL/1vfpUy09HVEhpgatoe21F8t22I+68ceBBWuIx63h00W6Zd3nm8
   52x7rPBoUC2mnu4yrRmcMWsQMiykMwUMaY0e9MbcXBVrSI0RgLWgB0J2T
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="387406064"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="387406064"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 07:02:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="715635104"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="715635104"
Received: from ijarvine-mobl2.ger.corp.intel.com ([10.251.212.170])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 07:02:27 -0700
Date:   Thu, 15 Jun 2023 17:02:21 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
cc:     bhelgaas@google.com, Mario Limonciello <mario.limonciello@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Michael Bottini <michael.a.bottini@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI/ASPM: Enable ASPM on external PCIe devices
In-Reply-To: <20230615070421.1704133-1-kai.heng.feng@canonical.com>
Message-ID: <e93dfb6f-575a-b233-a842-521f6b396be6@linux.intel.com>
References: <20230615070421.1704133-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 15 Jun 2023, Kai-Heng Feng wrote:

> When a PCIe device is hotplugged to a Thunderbolt port, ASPM is not
> enabled for that device. However, when the device is plugged preboot,
> ASPM is enabled by default.
> 
> The disparity happens because BIOS doesn't have the ability to program
> ASPM on hotplugged devices.
> 
> So enable ASPM by default for external connected PCIe devices so ASPM
> settings are consitent between preboot and hotplugged.

consistent

> On HP Thunderbolt Dock G4, enable ASPM can also fix BadDLLP error:

enabling ASPM ?

-- 
 i.

> pcieport 0000:00:1d.0: AER: Corrected error received: 0000:07:04.0
> pcieport 0000:07:04.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Receiver ID)
> pcieport 0000:07:04.0:   device [8086:0b26] error status/mask=00000080/00002000
> pcieport 0000:07:04.0:    [ 7] BadDLLP
> 
> The root cause is still unclear, but quite likely because the I225 on
> the dock supports PTM, where ASPM timing is precalculated for the PTM.
> 
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217557
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/pci/pcie/aspm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 66d7514ca111..613b0754c9bb 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -119,7 +119,9 @@ static int policy_to_aspm_state(struct pcie_link_state *link)
>  		/* Enable Everything */
>  		return ASPM_STATE_ALL;
>  	case POLICY_DEFAULT:
> -		return link->aspm_default;
> +		return dev_is_removable(&link->downstream->dev) ?
> +			link->aspm_capable :
> +			link->aspm_default;
>  	}
>  	return 0;
>  }
> 
