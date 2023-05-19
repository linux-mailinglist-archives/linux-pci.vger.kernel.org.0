Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79318709315
	for <lists+linux-pci@lfdr.de>; Fri, 19 May 2023 11:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjESJa7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 May 2023 05:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjESJa5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 May 2023 05:30:57 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BEBE42;
        Fri, 19 May 2023 02:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684488656; x=1716024656;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=3QfHmYRgUcLgG7yswANAS21WIRJnHhTTVTEGJa0Yw9M=;
  b=aNPhWBtEmbfUJGCuZ6C/AS1LQLE60/QVbdL7GBDcF4QLgw8fDKmv35IX
   GRxdptbCE+iSlpzfX2C+kniw7UWt8Pa+NvDFJsLv++Gr85rzsD7nPXu+Q
   DPr4xMclzMPMflAUzxoyKws2UV0ZMLzkIY3Ahu15uBcw08ADcsI3d1qmN
   3soASoX/Gc9vAxa3Z2qsu0Lo/Ut+h+EWiA6L9leF2skbCUjuSkZSJ7w5I
   LLyJBOxL1Uz4RaONjT+mS9H5bQllEPwjfnmjLli0fXVyLROq71YLEtGBV
   cj9oR4/sbXBCmHPnmKwALIjHZGl1T7dAq1bZi+Dgi1mmwveHRZ62DSAHq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="336920982"
X-IronPort-AV: E=Sophos;i="6.00,176,1681196400"; 
   d="scan'208";a="336920982"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 02:30:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="792315594"
X-IronPort-AV: E=Sophos;i="6.00,176,1681196400"; 
   d="scan'208";a="792315594"
Received: from iannetti-mobl.ger.corp.intel.com ([10.252.43.241])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 02:30:36 -0700
Date:   Fri, 19 May 2023 12:30:34 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Shaohua Li <shaohua.li@intel.com>,
        Greg Kroah-Hartman <gregkh@suse.de>, linux-pci@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI/ASPM: Handle link retraining race
In-Reply-To: <ZGaquEqo/psIH14Y@bhelgaas>
Message-ID: <777a753-42f0-6616-5cc0-fceb157acc2@linux.intel.com>
References: <ZGaquEqo/psIH14Y@bhelgaas>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1530899728-1684488455=:1681"
Content-ID: <94817ff1-4e4b-68c8-52bb-a4221219ee2@linux.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1530899728-1684488455=:1681
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <1d89f724-36b9-5e14-7d6f-7ac47fa9bb14@linux.intel.com>

On Thu, 18 May 2023, Bjorn Helgaas wrote:

> On Tue, May 02, 2023 at 11:39:23AM +0300, Ilpo Järvinen wrote:
> > Implementation Note at the end of PCIe r6.0.1 sec 7.5.3.7 recommends
> > handling LTSSM race to ensure link retraining acquires correct
> > parameters from the LNKCTL register. According to the implementation
> > note, LTSSM might transition into Recovery or Configuration state
> > independently of the driver requesting it, and if retraining due to
> > such an event is still ongoing, the value written into the LNKCTL
> > register might not be considered by the link retraining.
> > 
> > Ensure link training bit is clear before toggling link retraining bit
> > to meet the requirements of the Implementation Note.
> > 
> > Fixes: 7d715a6c1ae5 ("PCI: add PCI Express ASPM support")
> > Suggested-by: Lukas Wunner <lukas@wunner.de>
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > Reviewed-by: Lukas Wunner <lukas@wunner.de>
> > Cc: stable@vger.kernel.org
> 
> Thanks for this!
> 
> The existing pcie_retrain_link() and pcie_wait_for_retrain() both
> return bool, but neither is named as a predicate, and it's always a
> little hard for me to keep track of what the true/false return values
> mean.
> 
> I propose tweaking them so they both return 0 for success or
> -ETIMEDOUT for failure.  What do you think?  It does make the patch
> bigger, which is kind of unfortunate.

It's better, yes, unless stable folks think it's not a minimal change.

As a confirmation for your return tweak improving things, I recall that I 
had to be careful with the bool in this case for the reasons you mention 
(it requires more mental capacity and verification which way the return 
is).

(Also, expect the error handling reindent to cause a conflict with the RMW 
series.)

-- 
 i.


> commit f55ef626b57f ("PCI/ASPM: Avoid link retraining race")
> parent e8d05f522fae
> Author: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Date:   Tue May 2 11:39:23 2023 +0300
> 
>     PCI/ASPM: Avoid link retraining race
>     
>     PCIe r6.0.1, sec 7.5.3.7, recommends setting the link control parameters,
>     then waiting for the Link Training bit to be clear before setting the
>     Retrain Link bit.
>     
>     This avoids a race where the LTSSM may not use the updated parameters if it
>     is already in the midst of link training because of other normal link
>     activity.
>     
>     Wait for the Link Training bit to be clear before toggling the Retrain Link
>     bit to ensure that the LTSSM uses the updated link control parameters.
>     
>     [bhelgaas: commit log, return 0 (success)/-ETIMEDOUT instead of bool for
>     both pcie_wait_for_retrain() and the existing pcie_retrain_link()]
>     Suggested-by: Lukas Wunner <lukas@wunner.de>
>     Fixes: 7d715a6c1ae5 ("PCI: add PCI Express ASPM support")
>     Link: https://lore.kernel.org/r/20230502083923.34562-1-ilpo.jarvinen@linux.intel.com
>     Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Reviewed-by: Lukas Wunner <lukas@wunner.de>
>     Cc: stable@vger.kernel.org
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 72cdb30a924a..3aa73ecdf86f 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -193,12 +193,39 @@ static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
>  	link->clkpm_disable = blacklist ? 1 : 0;
>  }
>  
> -static bool pcie_retrain_link(struct pcie_link_state *link)
> +static int pcie_wait_for_retrain(struct pci_dev *pdev)
>  {
> -	struct pci_dev *parent = link->pdev;
>  	unsigned long end_jiffies;
>  	u16 reg16;
>  
> +	/* Wait for Link Training to be cleared by hardware */
> +	end_jiffies = jiffies + LINK_RETRAIN_TIMEOUT;
> +	do {
> +		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &reg16);
> +		if (!(reg16 & PCI_EXP_LNKSTA_LT))
> +			return 0;
> +		msleep(1);
> +	} while (time_before(jiffies, end_jiffies));
> +
> +	return -ETIMEDOUT;
> +}
> +
> +static int pcie_retrain_link(struct pcie_link_state *link)
> +{
> +	struct pci_dev *parent = link->pdev;
> +	int rc;
> +	u16 reg16;
> +
> +	/*
> +	 * Ensure the updated LNKCTL parameters are used during link
> +	 * training by checking that there is no ongoing link training to
> +	 * avoid LTSSM race as recommended in Implementation Note at the
> +	 * end of PCIe r6.0.1 sec 7.5.3.7.
> +	 */
> +	rc = pcie_wait_for_retrain(parent);
> +	if (rc)
> +		return rc;
> +
>  	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16);
>  	reg16 |= PCI_EXP_LNKCTL_RL;
>  	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
> @@ -212,15 +239,7 @@ static bool pcie_retrain_link(struct pcie_link_state *link)
>  		pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
>  	}
>  
> -	/* Wait for link training end. Break out after waiting for timeout */
> -	end_jiffies = jiffies + LINK_RETRAIN_TIMEOUT;
> -	do {
> -		pcie_capability_read_word(parent, PCI_EXP_LNKSTA, &reg16);
> -		if (!(reg16 & PCI_EXP_LNKSTA_LT))
> -			break;
> -		msleep(1);
> -	} while (time_before(jiffies, end_jiffies));
> -	return !(reg16 & PCI_EXP_LNKSTA_LT);
> +	return pcie_wait_for_retrain(parent);
>  }
>  
>  /*
> @@ -289,15 +308,15 @@ static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
>  		reg16 &= ~PCI_EXP_LNKCTL_CCC;
>  	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
>  
> -	if (pcie_retrain_link(link))
> -		return;
> +	if (pcie_retrain_link(link)) {
>  
> -	/* Training failed. Restore common clock configurations */
> -	pci_err(parent, "ASPM: Could not configure common clock\n");
> -	list_for_each_entry(child, &linkbus->devices, bus_list)
> -		pcie_capability_write_word(child, PCI_EXP_LNKCTL,
> +		/* Training failed. Restore common clock configurations */
> +		pci_err(parent, "ASPM: Could not configure common clock\n");
> +		list_for_each_entry(child, &linkbus->devices, bus_list)
> +			pcie_capability_write_word(child, PCI_EXP_LNKCTL,
>  					   child_reg[PCI_FUNC(child->devfn)]);
> -	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, parent_reg);
> +		pcie_capability_write_word(parent, PCI_EXP_LNKCTL, parent_reg);
> +	}
>  }
>  
>  /* Convert L0s latency encoding to ns */
--8323329-1530899728-1684488455=:1681--
