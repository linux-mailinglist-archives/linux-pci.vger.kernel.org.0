Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1A0708BE2
	for <lists+linux-pci@lfdr.de>; Fri, 19 May 2023 00:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjERWqV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 May 2023 18:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjERWqU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 May 2023 18:46:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6BBE69;
        Thu, 18 May 2023 15:46:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A2FB6097D;
        Thu, 18 May 2023 22:46:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2BC3C433EF;
        Thu, 18 May 2023 22:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684449977;
        bh=5jbb66fGEZu6UT2i6W8aN8eC7k6vi7bEWizHOjF7QwM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=tnH9q6TK5ot5KvSSx3RmIhm1BwQNKRa5zTtopxojt5TtLF5XXPJR7d6pyGvlATs12
         FvO4pYjaUAYnl4D48vff5Q2jHna0ro2hG2f+1kbOyUOp9wFst6NUGlq9W5kPprEkwJ
         RTgBGYpRyalfgpQ2UFZwT9JsaeOk9d3BoGilo1NLoDEa6v4pF7P1iQ8/IMIPy1FOfC
         0AYFC/vfx/P6ogmgnPJVtkhunME8EUiNxad/8ncyEt17wFzBP3wKcxJNzA9QLY+ZuH
         PxR9AaBdRHRYVn9P1BfJJt2GGockWJrWlR8Xat+k2OQLr3ZpRCVfkOgL4Msh/dQJdC
         M/vZRUJIpVRvw==
Date:   Thu, 18 May 2023 17:46:16 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Shaohua Li <shaohua.li@intel.com>,
        Greg Kroah-Hartman <gregkh@suse.de>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI/ASPM: Handle link retraining race
Message-ID: <ZGaquEqo/psIH14Y@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230502083923.34562-1-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 02, 2023 at 11:39:23AM +0300, Ilpo Järvinen wrote:
> Implementation Note at the end of PCIe r6.0.1 sec 7.5.3.7 recommends
> handling LTSSM race to ensure link retraining acquires correct
> parameters from the LNKCTL register. According to the implementation
> note, LTSSM might transition into Recovery or Configuration state
> independently of the driver requesting it, and if retraining due to
> such an event is still ongoing, the value written into the LNKCTL
> register might not be considered by the link retraining.
> 
> Ensure link training bit is clear before toggling link retraining bit
> to meet the requirements of the Implementation Note.
> 
> Fixes: 7d715a6c1ae5 ("PCI: add PCI Express ASPM support")
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org

Thanks for this!

The existing pcie_retrain_link() and pcie_wait_for_retrain() both
return bool, but neither is named as a predicate, and it's always a
little hard for me to keep track of what the true/false return values
mean.

I propose tweaking them so they both return 0 for success or
-ETIMEDOUT for failure.  What do you think?  It does make the patch
bigger, which is kind of unfortunate.

Bjorn

commit f55ef626b57f ("PCI/ASPM: Avoid link retraining race")
parent e8d05f522fae
Author: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Date:   Tue May 2 11:39:23 2023 +0300

    PCI/ASPM: Avoid link retraining race
    
    PCIe r6.0.1, sec 7.5.3.7, recommends setting the link control parameters,
    then waiting for the Link Training bit to be clear before setting the
    Retrain Link bit.
    
    This avoids a race where the LTSSM may not use the updated parameters if it
    is already in the midst of link training because of other normal link
    activity.
    
    Wait for the Link Training bit to be clear before toggling the Retrain Link
    bit to ensure that the LTSSM uses the updated link control parameters.
    
    [bhelgaas: commit log, return 0 (success)/-ETIMEDOUT instead of bool for
    both pcie_wait_for_retrain() and the existing pcie_retrain_link()]
    Suggested-by: Lukas Wunner <lukas@wunner.de>
    Fixes: 7d715a6c1ae5 ("PCI: add PCI Express ASPM support")
    Link: https://lore.kernel.org/r/20230502083923.34562-1-ilpo.jarvinen@linux.intel.com
    Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Reviewed-by: Lukas Wunner <lukas@wunner.de>
    Cc: stable@vger.kernel.org

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 72cdb30a924a..3aa73ecdf86f 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -193,12 +193,39 @@ static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
 	link->clkpm_disable = blacklist ? 1 : 0;
 }
 
-static bool pcie_retrain_link(struct pcie_link_state *link)
+static int pcie_wait_for_retrain(struct pci_dev *pdev)
 {
-	struct pci_dev *parent = link->pdev;
 	unsigned long end_jiffies;
 	u16 reg16;
 
+	/* Wait for Link Training to be cleared by hardware */
+	end_jiffies = jiffies + LINK_RETRAIN_TIMEOUT;
+	do {
+		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &reg16);
+		if (!(reg16 & PCI_EXP_LNKSTA_LT))
+			return 0;
+		msleep(1);
+	} while (time_before(jiffies, end_jiffies));
+
+	return -ETIMEDOUT;
+}
+
+static int pcie_retrain_link(struct pcie_link_state *link)
+{
+	struct pci_dev *parent = link->pdev;
+	int rc;
+	u16 reg16;
+
+	/*
+	 * Ensure the updated LNKCTL parameters are used during link
+	 * training by checking that there is no ongoing link training to
+	 * avoid LTSSM race as recommended in Implementation Note at the
+	 * end of PCIe r6.0.1 sec 7.5.3.7.
+	 */
+	rc = pcie_wait_for_retrain(parent);
+	if (rc)
+		return rc;
+
 	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16);
 	reg16 |= PCI_EXP_LNKCTL_RL;
 	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
@@ -212,15 +239,7 @@ static bool pcie_retrain_link(struct pcie_link_state *link)
 		pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
 	}
 
-	/* Wait for link training end. Break out after waiting for timeout */
-	end_jiffies = jiffies + LINK_RETRAIN_TIMEOUT;
-	do {
-		pcie_capability_read_word(parent, PCI_EXP_LNKSTA, &reg16);
-		if (!(reg16 & PCI_EXP_LNKSTA_LT))
-			break;
-		msleep(1);
-	} while (time_before(jiffies, end_jiffies));
-	return !(reg16 & PCI_EXP_LNKSTA_LT);
+	return pcie_wait_for_retrain(parent);
 }
 
 /*
@@ -289,15 +308,15 @@ static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
 		reg16 &= ~PCI_EXP_LNKCTL_CCC;
 	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
 
-	if (pcie_retrain_link(link))
-		return;
+	if (pcie_retrain_link(link)) {
 
-	/* Training failed. Restore common clock configurations */
-	pci_err(parent, "ASPM: Could not configure common clock\n");
-	list_for_each_entry(child, &linkbus->devices, bus_list)
-		pcie_capability_write_word(child, PCI_EXP_LNKCTL,
+		/* Training failed. Restore common clock configurations */
+		pci_err(parent, "ASPM: Could not configure common clock\n");
+		list_for_each_entry(child, &linkbus->devices, bus_list)
+			pcie_capability_write_word(child, PCI_EXP_LNKCTL,
 					   child_reg[PCI_FUNC(child->devfn)]);
-	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, parent_reg);
+		pcie_capability_write_word(parent, PCI_EXP_LNKCTL, parent_reg);
+	}
 }
 
 /* Convert L0s latency encoding to ns */

> ---
>  drivers/pci/pcie/aspm.c | 37 +++++++++++++++++++++++++++----------
>  1 file changed, 27 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 66d7514ca111..dde1ef13d0d1 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -193,12 +193,37 @@ static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
>  	link->clkpm_disable = blacklist ? 1 : 0;
>  }
>  
> +static bool pcie_wait_for_retrain(struct pci_dev *pdev)
> +{
> +	unsigned long end_jiffies;
> +	u16 reg16;
> +
> +	/* Wait for link training end. Break out after waiting for timeout */
> +	end_jiffies = jiffies + LINK_RETRAIN_TIMEOUT;
> +	do {
> +		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &reg16);
> +		if (!(reg16 & PCI_EXP_LNKSTA_LT))
> +			break;
> +		msleep(1);
> +	} while (time_before(jiffies, end_jiffies));
> +
> +	return !(reg16 & PCI_EXP_LNKSTA_LT);
> +}
> +
>  static bool pcie_retrain_link(struct pcie_link_state *link)
>  {
>  	struct pci_dev *parent = link->pdev;
> -	unsigned long end_jiffies;
>  	u16 reg16;
>  
> +	/*
> +	 * Ensure the updated LNKCTL parameters are used during link
> +	 * training by checking that there is no ongoing link training to
> +	 * avoid LTSSM race as recommended in Implementation Note at the end
> +	 * of PCIe r6.0.1 sec 7.5.3.7.
> +	 */
> +	if (!pcie_wait_for_retrain(parent))
> +		return false;
> +
>  	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16);
>  	reg16 |= PCI_EXP_LNKCTL_RL;
>  	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
> @@ -212,15 +237,7 @@ static bool pcie_retrain_link(struct pcie_link_state *link)
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
> -- 
> 2.30.2
> 
