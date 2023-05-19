Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F22709850
	for <lists+linux-pci@lfdr.de>; Fri, 19 May 2023 15:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjESNas (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 May 2023 09:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbjESNao (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 May 2023 09:30:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A1C10F8;
        Fri, 19 May 2023 06:30:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9FB865792;
        Fri, 19 May 2023 13:29:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144E2C433D2;
        Fri, 19 May 2023 13:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684502988;
        bh=iRvVooeKq1I+5NS1xQXfO0qpi/j4sF9DD1aseILelCE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=M1ayG2FT/ZDpinoT65KG3DFvA8cSEcWYBf4+K3ZY8Zl8R17rbsCmLkNPP4DEstn2S
         yjpzkkT6vavkUKRzb/F7U0vUB0M4zNpMxr2Qyy3hHov8l8stLhPrhJHgN60xkxpjun
         tsIJRgbONLJaaXYYhGwNU/XA3XMrCWVXpYL+3hhKpeyDWFICm/Za8IEuuqqwxfENSs
         if6pZ07dHueyCYMdAxGsAZZNa4pMwSV+y5eUkZS5M6VUrwVAmi3zO8eb6OSPJPtQ1T
         LZAQ7DgTFwCWp0Gj5dAADB9o9nSiwTE+viLCzmDSKwDOXWo2+UxlM+TUp2Hn7zGAzZ
         FcKQY0EnQc1mQ==
Date:   Fri, 19 May 2023 08:29:46 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Shaohua Li <shaohua.li@intel.com>,
        Greg Kroah-Hartman <gregkh@suse.de>, linux-pci@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI/ASPM: Handle link retraining race
Message-ID: <ZGd5yqfyppu00OO9@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <777a753-42f0-6616-5cc0-fceb157acc2@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 19, 2023 at 12:30:34PM +0300, Ilpo Järvinen wrote:
> On Thu, 18 May 2023, Bjorn Helgaas wrote:
> > On Tue, May 02, 2023 at 11:39:23AM +0300, Ilpo Järvinen wrote:
> > > Implementation Note at the end of PCIe r6.0.1 sec 7.5.3.7 recommends
> > > handling LTSSM race to ensure link retraining acquires correct
> > > parameters from the LNKCTL register. According to the implementation
> > > note, LTSSM might transition into Recovery or Configuration state
> > > independently of the driver requesting it, and if retraining due to
> > > such an event is still ongoing, the value written into the LNKCTL
> > > register might not be considered by the link retraining.
> > > 
> > > Ensure link training bit is clear before toggling link retraining bit
> > > to meet the requirements of the Implementation Note.
> > > 
> > > Fixes: 7d715a6c1ae5 ("PCI: add PCI Express ASPM support")
> > > Suggested-by: Lukas Wunner <lukas@wunner.de>
> > > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > > Reviewed-by: Lukas Wunner <lukas@wunner.de>
> > > Cc: stable@vger.kernel.org
> > 
> > Thanks for this!
> > 
> > The existing pcie_retrain_link() and pcie_wait_for_retrain() both
> > return bool, but neither is named as a predicate, and it's always a
> > little hard for me to keep track of what the true/false return values
> > mean.
> > 
> > I propose tweaking them so they both return 0 for success or
> > -ETIMEDOUT for failure.  What do you think?  It does make the patch
> > bigger, which is kind of unfortunate.
> 
> It's better, yes, unless stable folks think it's not a minimal change.
> 
> As a confirmation for your return tweak improving things, I recall that I 
> had to be careful with the bool in this case for the reasons you mention 
> (it requires more mental capacity and verification which way the return 
> is).
> 
> (Also, expect the error handling reindent to cause a conflict with the RMW 
> series.)

OK, thanks for taking a look!  I applied the revised patch to pci/aspm
for v6.5.  I'll take care of any conflicts with the RMW series.

> > commit f55ef626b57f ("PCI/ASPM: Avoid link retraining race")
> > parent e8d05f522fae
> > Author: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > Date:   Tue May 2 11:39:23 2023 +0300
> > 
> >     PCI/ASPM: Avoid link retraining race
> >     
> >     PCIe r6.0.1, sec 7.5.3.7, recommends setting the link control parameters,
> >     then waiting for the Link Training bit to be clear before setting the
> >     Retrain Link bit.
> >     
> >     This avoids a race where the LTSSM may not use the updated parameters if it
> >     is already in the midst of link training because of other normal link
> >     activity.
> >     
> >     Wait for the Link Training bit to be clear before toggling the Retrain Link
> >     bit to ensure that the LTSSM uses the updated link control parameters.
> >     
> >     [bhelgaas: commit log, return 0 (success)/-ETIMEDOUT instead of bool for
> >     both pcie_wait_for_retrain() and the existing pcie_retrain_link()]
> >     Suggested-by: Lukas Wunner <lukas@wunner.de>
> >     Fixes: 7d715a6c1ae5 ("PCI: add PCI Express ASPM support")
> >     Link: https://lore.kernel.org/r/20230502083923.34562-1-ilpo.jarvinen@linux.intel.com
> >     Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> >     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> >     Reviewed-by: Lukas Wunner <lukas@wunner.de>
> >     Cc: stable@vger.kernel.org
> > 
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index 72cdb30a924a..3aa73ecdf86f 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -193,12 +193,39 @@ static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
> >  	link->clkpm_disable = blacklist ? 1 : 0;
> >  }
> >  
> > -static bool pcie_retrain_link(struct pcie_link_state *link)
> > +static int pcie_wait_for_retrain(struct pci_dev *pdev)
> >  {
> > -	struct pci_dev *parent = link->pdev;
> >  	unsigned long end_jiffies;
> >  	u16 reg16;
> >  
> > +	/* Wait for Link Training to be cleared by hardware */
> > +	end_jiffies = jiffies + LINK_RETRAIN_TIMEOUT;
> > +	do {
> > +		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &reg16);
> > +		if (!(reg16 & PCI_EXP_LNKSTA_LT))
> > +			return 0;
> > +		msleep(1);
> > +	} while (time_before(jiffies, end_jiffies));
> > +
> > +	return -ETIMEDOUT;
> > +}
> > +
> > +static int pcie_retrain_link(struct pcie_link_state *link)
> > +{
> > +	struct pci_dev *parent = link->pdev;
> > +	int rc;
> > +	u16 reg16;
> > +
> > +	/*
> > +	 * Ensure the updated LNKCTL parameters are used during link
> > +	 * training by checking that there is no ongoing link training to
> > +	 * avoid LTSSM race as recommended in Implementation Note at the
> > +	 * end of PCIe r6.0.1 sec 7.5.3.7.
> > +	 */
> > +	rc = pcie_wait_for_retrain(parent);
> > +	if (rc)
> > +		return rc;
> > +
> >  	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16);
> >  	reg16 |= PCI_EXP_LNKCTL_RL;
> >  	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
> > @@ -212,15 +239,7 @@ static bool pcie_retrain_link(struct pcie_link_state *link)
> >  		pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
> >  	}
> >  
> > -	/* Wait for link training end. Break out after waiting for timeout */
> > -	end_jiffies = jiffies + LINK_RETRAIN_TIMEOUT;
> > -	do {
> > -		pcie_capability_read_word(parent, PCI_EXP_LNKSTA, &reg16);
> > -		if (!(reg16 & PCI_EXP_LNKSTA_LT))
> > -			break;
> > -		msleep(1);
> > -	} while (time_before(jiffies, end_jiffies));
> > -	return !(reg16 & PCI_EXP_LNKSTA_LT);
> > +	return pcie_wait_for_retrain(parent);
> >  }
> >  
> >  /*
> > @@ -289,15 +308,15 @@ static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
> >  		reg16 &= ~PCI_EXP_LNKCTL_CCC;
> >  	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
> >  
> > -	if (pcie_retrain_link(link))
> > -		return;
> > +	if (pcie_retrain_link(link)) {
> >  
> > -	/* Training failed. Restore common clock configurations */
> > -	pci_err(parent, "ASPM: Could not configure common clock\n");
> > -	list_for_each_entry(child, &linkbus->devices, bus_list)
> > -		pcie_capability_write_word(child, PCI_EXP_LNKCTL,
> > +		/* Training failed. Restore common clock configurations */
> > +		pci_err(parent, "ASPM: Could not configure common clock\n");
> > +		list_for_each_entry(child, &linkbus->devices, bus_list)
> > +			pcie_capability_write_word(child, PCI_EXP_LNKCTL,
> >  					   child_reg[PCI_FUNC(child->devfn)]);
> > -	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, parent_reg);
> > +		pcie_capability_write_word(parent, PCI_EXP_LNKCTL, parent_reg);
> > +	}
> >  }
> >  
> >  /* Convert L0s latency encoding to ns */

