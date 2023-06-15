Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C382731EB0
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jun 2023 19:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjFORH3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Jun 2023 13:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjFORH2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Jun 2023 13:07:28 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AB7123;
        Thu, 15 Jun 2023 10:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686848847; x=1718384847;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FXV1YChUXwSF8PZCAUD+tpfoEBwKY/uzBtEPKcW5DBo=;
  b=gXERln9Rg2qQwFDlRCdTAOm8jL3u9SrAqV8OkpEDKFRucJc5AqCzjokb
   LgRaXKulvFhF4dwmS90c/S2U6mcMaXLnknXo39D7h/wmYsa6GngtcNO8R
   Zf60P2XEEDKiuUs3WwU0vbHo1e15j3IKSU7TtOg+DP5t87Bk62lBpkStv
   k9hN4pAjdxtt+pDY4rMijYkGAhkjt3o9IZLDNzlGO8FtRnS6oT+S6dJQF
   vlS8rkSm0WynrtY5i/pDt4RPMqtqXLnpIJdMrv4zqtlQ9PtePcWNtdDhC
   jNvtVuNw3V06rdlhHD+2G8tIBn8rPjCu3MjS3YJSkjLYiCdGVxs/I721t
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="387521010"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="387521010"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 10:07:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="825368959"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="825368959"
Received: from akcopko-mobl2.amr.corp.intel.com (HELO [10.212.220.19]) ([10.212.220.19])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 10:07:26 -0700
Message-ID: <a268fc1c-dd63-cac5-4aec-836a6299ab36@linux.intel.com>
Date:   Thu, 15 Jun 2023 10:07:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH] PCI/ASPM: Enable ASPM on external PCIe devices
Content-Language: en-US
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>, bhelgaas@google.com
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Michael Bottini <michael.a.bottini@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230615070421.1704133-1-kai.heng.feng@canonical.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230615070421.1704133-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/15/23 12:04 AM, Kai-Heng Feng wrote:
> When a PCIe device is hotplugged to a Thunderbolt port, ASPM is not
> enabled for that device. However, when the device is plugged preboot,
> ASPM is enabled by default.
> 
> The disparity happens because BIOS doesn't have the ability to program
> ASPM on hotplugged devices.
> 
> So enable ASPM by default for external connected PCIe devices so ASPM
> settings are consitent between preboot and hotplugged.

Why it has to be consistent? Can you add info about what it solves?

> 
> On HP Thunderbolt Dock G4, enable ASPM can also fix BadDLLP error:
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

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
