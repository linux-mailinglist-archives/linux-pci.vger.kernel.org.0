Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A2D727BBE
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jun 2023 11:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234816AbjFHJof (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Jun 2023 05:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235607AbjFHJoe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Jun 2023 05:44:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2658D26AD;
        Thu,  8 Jun 2023 02:44:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58FA264B4C;
        Thu,  8 Jun 2023 09:44:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2435C433D2;
        Thu,  8 Jun 2023 09:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686217467;
        bh=MAksfBTIoVC5jjvwSkPpkQ/OQRwj4YVGqdNLzO4pMBI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jy5pWexP6YqYTxr+44kP8nsL2uS1LMvpkMkO+kQMSN5HyXYuuGKncvAOEjwOXHPZa
         fd6/h/EEtrMGD0AUTb8mxEA/7+fINvyTlu/kvnmIQ/UiRvxCk5g2aUi2ai/HgBLI7a
         SLvy/DIUKgju2aRC1FwuE9ObUnRQxf3rJ2INHpNO5a+grfgHCpAPtBANT6rdhJBBUv
         KB4AEWVJBFY/qvZia+DqoJ0mhP8onNZndJjGiFp2n2zkheCiIWgSEPhwUb/vQj6Kok
         IoNKx1b1ciV1JY4mMdl1LYJmeve4Uhn/8jWnldZHRosqfTbgPO7YIMMpOZTtFZvT23
         dW/AjsbHe2rpA==
Date:   Thu, 8 Jun 2023 11:44:21 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Siddharth Vadapalli <s-vadapalli@ti.com>
Cc:     tjoseph@cadence.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, nadeem@cadence.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        vigneshr@ti.com, srk@ti.com, nm@ti.com
Subject: Re: [PATCH v3] PCI: cadence: Fix Gen2 Link Retraining process
Message-ID: <ZIGi9Tfk7hemFIM6@lpieralisi>
References: <20230607091427.852473-1-s-vadapalli@ti.com>
 <ZIBanRGGPeFw90NZ@lpieralisi>
 <5888f3ff-bc95-16ed-3cae-958719d87874@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5888f3ff-bc95-16ed-3cae-958719d87874@ti.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 08, 2023 at 09:31:59AM +0530, Siddharth Vadapalli wrote:
> Hello Lorenzo,
> 
> Thank you for reviewing this patch.
> 
> On 07/06/23 15:53, Lorenzo Pieralisi wrote:
> > On Wed, Jun 07, 2023 at 02:44:27PM +0530, Siddharth Vadapalli wrote:
> >> The Link Retraining process is initiated to account for the Gen2 defect in
> >> the Cadence PCIe controller in J721E SoC. The errata corresponding to this
> >> is i2085, documented at:
> >> https://www.ti.com/lit/er/sprz455c/sprz455c.pdf
> >>
> >> The existing workaround implemented for the errata waits for the Data Link
> >> initialization to complete and assumes that the link retraining process
> >> at the Physical Layer has completed. However, it is possible that the
> >> Physical Layer training might be ongoing as indicated by the
> >> PCI_EXP_LNKSTA_LT bit in the PCI_EXP_LNKSTA register.
> >>
> >> Fix the existing workaround, to ensure that the Physical Layer training
> >> has also completed, in addition to the Data Link initialization.
> >>
> >> Fixes: 4740b969aaf5 ("PCI: cadence: Retrain Link to work around Gen2 training defect")
> >> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> >> Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>
> >> ---
> >>
> >> Hello,
> >>
> >> This patch is based on linux-next tagged next-20230606.
> >>
> >> v2:
> >> https://lore.kernel.org/r/20230315070800.1615527-1-s-vadapalli@ti.com/
> >> Changes since v2:
> >> - Merge the cdns_pcie_host_training_complete() function with the
> >>   cdns_pcie_host_wait_for_link() function, as suggested by Bjorn
> >>   for the v2 patch.
> >> - Add dev_err() to notify when Link Training fails, since this is a
> >>   fatal error and proceeding from this point will almost always crash
> >>   the kernel.
> >>
> >> v1:
> >> https://lore.kernel.org/r/20230102075656.260333-1-s-vadapalli@ti.com/
> >> Changes since v1:
> >> - Collect Reviewed-by tag from Vignesh Raghavendra.
> >> - Rebase on next-20230315.
> >>
> >> Regards,
> >> Siddharth.
> >>
> >>  .../controller/cadence/pcie-cadence-host.c    | 20 +++++++++++++++++++
> >>  1 file changed, 20 insertions(+)
> >>
> >> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
> >> index 940c7dd701d6..70a5f581ff4f 100644
> >> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> >> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> >> @@ -12,6 +12,8 @@
> >>  
> >>  #include "pcie-cadence.h"
> >>  
> >> +#define LINK_RETRAIN_TIMEOUT HZ
> >> +
> >>  static u64 bar_max_size[] = {
> >>  	[RP_BAR0] = _ULL(128 * SZ_2G),
> >>  	[RP_BAR1] = SZ_2G,
> >> @@ -80,8 +82,26 @@ static struct pci_ops cdns_pcie_host_ops = {
> >>  static int cdns_pcie_host_wait_for_link(struct cdns_pcie *pcie)
> >>  {
> >>  	struct device *dev = pcie->dev;
> >> +	unsigned long end_jiffies;
> >> +	u16 link_status;
> >>  	int retries;
> >>  
> >> +	/* Wait for link training to complete */
> >> +	end_jiffies = jiffies + LINK_RETRAIN_TIMEOUT;
> >> +	do {
> >> +		link_status = cdns_pcie_rp_readw(pcie, CDNS_PCIE_RP_CAP_OFFSET + PCI_EXP_LNKSTA);
> >> +		if (!(link_status & PCI_EXP_LNKSTA_LT))
> >> +			break;
> > 
> > You can use a bool variable eg link_trained and use that below.
> 
> Sure, I will do that. link_trained = !(link_status & PCI_EXP_LNKSTA_LT); within
> the do-while loop and checking for it to be true in the loop as well as below.
> 
> > 
> >> +		usleep_range(0, 1000);
> >> +	} while (time_before(jiffies, end_jiffies));
> >> +
> >> +	if (!(link_status & PCI_EXP_LNKSTA_LT)) {
> >> +		dev_info(dev, "Link training complete\n");
> >> +	} else {
> >> +		dev_err(dev, "Fatal! Link training incomplete\n");
> >> +		return -ETIMEDOUT;
> >> +	}
> > 
> > I don't necessarily see the reason why you are adding additional
> > logging, more so given that this now does not affect just the
> > workaround but all cadence controllers.
> > 
> > Actually, is that something you have tested and considered ?
> 
> While I agree that I could have performed the entire Link Training check only if
> the Gen2 Link Retraining Quirk is set for the RC, considering that the
> completion of the Link Training is a necessity irrespective of whether or not
> the Quirk exists, I preferred to add the check unconditionally. I would like to
> point out that the race condition responsible for the crash is the following:
> Without the completion of the Physical Layer link training, the call to the
> cdns_pci_map_bus() function in order to access the End Point's registers (if an
> EP device is connected) results in the crash. This is primarily observed only on
> RT Linux where the software call to cdns_pci_map_bus() by PCI subsystem occurs
> quite fast, before the Physical Layer link training is complete. For this
> reason, irrespective of whether the Physical Layer link training occurs only
> once because of the default flow or occurs a second time due to the Gen2 Link
> Retraining Quirk, it appears to me that the crash could potentially occur in
> both cases if we don't wait for the Physical Layer link training to complete.

This means that you are fixing the controller code for all Cadence platforms
and current code is broken (I am not really sure what you mean wrt RT Linux
- please elaborate, this does not sound good to me at all), so the
commit log must be rewritten.

> Please let me know if this sounds acceptable. If not, I will check if the quirk
> is set before proceeding to verify link training completion and implement this
> in the v4 patch.

Not only this is acceptable but that's what you should do. Current code
relies on assumptions (that you will have to explain to me please) wrt
link training and that's not OK.

Lorenzo

> 
> > 
> > Thanks,
> > Lorenzo
> > 
> >> +
> >>  	/* Check if the link is up or not */
> >>  	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
> >>  		if (cdns_pcie_link_up(pcie)) {
> >> -- 
> >> 2.25.1
> >>
> 
> -- 
> Regards,
> Siddharth.
