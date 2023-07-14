Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D4C753613
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jul 2023 11:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235335AbjGNJIL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jul 2023 05:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235834AbjGNJIE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jul 2023 05:08:04 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5DD2D66;
        Fri, 14 Jul 2023 02:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689325678; x=1720861678;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=EeCmo5QPrerXx59WQvD8Hi1p50w/XswlhljpvGAX/l0=;
  b=Kzd8PExYdJI8uEMEX+QeCOaNmP7rF5BwCHzpkzNZMbwuRTnboV0sx7jp
   u99IdVs01CqYfiLkKnCZ0G35mr/9fgi4TBBwX1NqH0YQV7srqv3NWG2TT
   34VfCqKpdbZj1n1Xrhb5vNXYa639ntOQiTXVtOl+lOs9YBJAhKir95oRf
   wIaGLECJfxyKKhux1k9FHrYmpM2vT5ayAj8SLs0LR+Yk8QCEA3HB0iaxA
   7Ct1JeDxW6DXIuKRbYu+kpxIGpdd7xRDkgnJwG+oxcTimI8E4eGsFH+3p
   QO/3VogGYU7K8GereWjL+YelZm2EXrMIUAIBOf1NtameI2FkMG3czplfL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="364303219"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="364303219"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 02:06:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="672626070"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="672626070"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 14 Jul 2023 02:06:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qKEkS-002bvt-2C;
        Fri, 14 Jul 2023 12:06:00 +0300
Date:   Fri, 14 Jul 2023 12:06:00 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Jesse Barnes <jbarnes@virtuousgeek.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Shaohua Li <shaohua.li@intel.com>,
        Thomas Renninger <trenn@suse.de>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        linux-kernel@vger.kernel.org,
        Dean Luick <dean.luick@cornelisnetworks.com>,
        Jonas =?iso-8859-1?Q?Dre=DFler?= <verdre@v0yd.nl>,
        stable@vger.kernel.org
Subject: Re: [PATCH v4 04/11] PCI/ASPM: Use RMW accessors for changing LNKCTL
Message-ID: <ZLEP+FPwsvk8jw5E@smile.fi.intel.com>
References: <20230713124505.94866-1-ilpo.jarvinen@linux.intel.com>
 <20230713124505.94866-5-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230713124505.94866-5-ilpo.jarvinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 13, 2023 at 03:44:58PM +0300, Ilpo Järvinen wrote:
> Don't assume that the device is fully under the control of ASPM and use
> RMW capability accessors which do proper locking to avoid losing
> concurrent updates to the register values.
> 
> If configuration fails in pcie_aspm_configure_common_clock(), the
> function attempts to restore the old PCI_EXP_LNKCTL_CCC settings. Store
> only the old PCI_EXP_LNKCTL_CCC bit for the relevant devices rather
> than the content of the whole LNKCTL registers. It aligns better with
> how pcie_lnkctl_clear_and_set() expects its parameter and makes the
> code more obvious to understand.

...

>  	int same_clock = 1;
> -	u16 reg16, parent_reg, child_reg[8];
> +	u16 reg16, parent_old_ccc, child_old_ccc[8];

	u16 ccc;

>  	struct pci_dev *child, *parent = link->pdev;
>  	struct pci_bus *linkbus = parent->subordinate;

...

	ccc = same_clock ? PCI_EXP_LNKCTL_CCC : 0);

>  	/* Configure downstream component, all functions */
>  	list_for_each_entry(child, &linkbus->devices, bus_list) {
>  		pcie_capability_read_word(child, PCI_EXP_LNKCTL, &reg16);
> -		child_reg[PCI_FUNC(child->devfn)] = reg16;
> -		if (same_clock)
> -			reg16 |= PCI_EXP_LNKCTL_CCC;
> -		else
> -			reg16 &= ~PCI_EXP_LNKCTL_CCC;
> -		pcie_capability_write_word(child, PCI_EXP_LNKCTL, reg16);
> +		child_old_ccc[PCI_FUNC(child->devfn)] = reg16 & PCI_EXP_LNKCTL_CCC;
> +		pcie_capability_clear_and_set_word(child, PCI_EXP_LNKCTL,
> +						   PCI_EXP_LNKCTL_CCC,
> +						   same_clock ? PCI_EXP_LNKCTL_CCC : 0);

		pcie_capability_clear_and_set_word(child, PCI_EXP_LNKCTL,
						   PCI_EXP_LNKCTL_CCC, ccc);

>  	}

...

> +	pcie_capability_clear_and_set_word(parent, PCI_EXP_LNKCTL,
> +					   PCI_EXP_LNKCTL_CCC,
> +					   same_clock ? PCI_EXP_LNKCTL_CCC : 0);

	pcie_capability_clear_and_set_word(parent, PCI_EXP_LNKCTL,
					   PCI_EXP_LNKCTL_CCC, ccc);

?

-- 
With Best Regards,
Andy Shevchenko


