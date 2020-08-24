Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7844A24FE84
	for <lists+linux-pci@lfdr.de>; Mon, 24 Aug 2020 15:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbgHXNFr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Aug 2020 09:05:47 -0400
Received: from mga04.intel.com ([192.55.52.120]:26057 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726158AbgHXNFr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Aug 2020 09:05:47 -0400
IronPort-SDR: QN4buq9gNgMJ9luGosHs4mPhXFm+nSpM3mRhPfc9i7MVbvqiUvIRKxjIjv3H4jXPH5NlKNmuVI
 S2ilqdr724Gw==
X-IronPort-AV: E=McAfee;i="6000,8403,9722"; a="153302899"
X-IronPort-AV: E=Sophos;i="5.76,348,1592895600"; 
   d="scan'208";a="153302899"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 06:05:00 -0700
IronPort-SDR: glWWwqLpFaUo/CuOVMUTSluWKXlQFEkR/gwSjhw10bFmVJ+dIY/MC0+LPvGLg1B9IY1DWQJ7lP
 M3Omj83EY+0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,348,1592895600"; 
   d="scan'208";a="402345797"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 24 Aug 2020 06:04:57 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 24 Aug 2020 16:04:56 +0300
Date:   Mon, 24 Aug 2020 16:04:56 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     bhelgaas@google.com, jonathan.derrick@intel.com,
        Mario.Limonciello@dell.com, Heiner Kallweit <hkallweit1@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Krzysztof Wilczynski <kw@linux.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI/ASPM: Enable ASPM for links under VMD domain
Message-ID: <20200824130456.GJ1375436@lahna.fi.intel.com>
References: <20200821123222.32093-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821123222.32093-1-kai.heng.feng@canonical.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Fri, Aug 21, 2020 at 08:32:20PM +0800, Kai-Heng Feng wrote:
> New Intel laptops with VMD cannot reach deeper power saving state,
> renders very short battery time.
> 
> As BIOS may not be able to program the config space for devices under
> VMD domain, ASPM needs to be programmed manually by software. This is
> also the case under Windows.
> 
> The VMD controller itself is a root complex integrated endpoint that
> doesn't have ASPM capability, so we can't propagate the ASPM settings to
> devices under it. Hence, simply apply ASPM_STATE_ALL to the links under
> VMD domain, unsupported states will be cleared out anyway.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/pci/pcie/aspm.c |  3 ++-
>  drivers/pci/quirks.c    | 11 +++++++++++
>  include/linux/pci.h     |  2 ++
>  3 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 253c30cc1967..dcc002dbca19 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -624,7 +624,8 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
>  		aspm_calc_l1ss_info(link, &upreg, &dwreg);
>  
>  	/* Save default state */
> -	link->aspm_default = link->aspm_enabled;
> +	link->aspm_default = parent->dev_flags & PCI_DEV_FLAGS_ENABLE_ASPM ?
> +			     ASPM_STATE_ALL : link->aspm_enabled;
>  
>  	/* Setup initial capable state. Will be updated later */
>  	link->aspm_capable = link->aspm_support;
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index bdf9b52567e0..2e2f525bd892 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5632,3 +5632,14 @@ static void apex_pci_fixup_class(struct pci_dev *pdev)
>  }
>  DECLARE_PCI_FIXUP_CLASS_HEADER(0x1ac1, 0x089a,
>  			       PCI_CLASS_NOT_DEFINED, 8, apex_pci_fixup_class);
> +
> +/*
> + * Device [8086:9a09]
> + * BIOS may not be able to access config space of devices under VMD domain, so
> + * it relies on software to enable ASPM for links under VMD.
> + */
> +static void pci_fixup_enable_aspm(struct pci_dev *pdev)
> +{
> +	pdev->dev_flags |= PCI_DEV_FLAGS_ENABLE_ASPM;
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a09, pci_fixup_enable_aspm);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 835530605c0d..66a45916c7c6 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -227,6 +227,8 @@ enum pci_dev_flags {
>  	PCI_DEV_FLAGS_NO_FLR_RESET = (__force pci_dev_flags_t) (1 << 10),
>  	/* Don't use Relaxed Ordering for TLPs directed at this device */
>  	PCI_DEV_FLAGS_NO_RELAXED_ORDERING = (__force pci_dev_flags_t) (1 << 11),
> +	/* Enable ASPM regardless of how LnkCtl is programmed */
> +	PCI_DEV_FLAGS_ENABLE_ASPM = (__force pci_dev_flags_t) (1 << 12),

I wonder if instead of dev_flags this should have a bit field in struct
pci_dev? Not sure which one is prefered actually, both seem to include
quirks as well ;-)

>  };
>  
>  enum pci_irq_reroute_variant {
> -- 
> 2.17.1
