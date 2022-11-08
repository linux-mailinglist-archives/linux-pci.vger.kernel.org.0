Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D61621F47
	for <lists+linux-pci@lfdr.de>; Tue,  8 Nov 2022 23:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbiKHWan (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Nov 2022 17:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiKHWaP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Nov 2022 17:30:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFD051C00;
        Tue,  8 Nov 2022 14:29:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E623617A3;
        Tue,  8 Nov 2022 22:29:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F00BC433D6;
        Tue,  8 Nov 2022 22:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667946586;
        bh=BqvLW4jV5m1Bw96AoPI7MuAfx2h0xX+8YgylNPLrHPk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ALUXgK44ZlDy0Hq1JR65VSfRXW0YJEhV1L57HIyNALpCiXaedEt2EiQIlXZmytvMb
         P7KANRx4MVmAgcYLibZnaI5nYHBpVk9QtRmCsvE9qS/CJENQCoiA9aZNGIfIAJqhbS
         WFVnSh93jYn4RmX8alKaebzoNU+3ufrs0YNhbHM5YwRrMs5EavX/r0BApua83/yLtR
         LBl+98l5WSe47pbVmTJO28XR/UYFQTAXhoGXvZAfi02qqqC3aJqNUA9/ScmgNgRakW
         u6BRMgp6+LGEg+tsO8qj+09+uIhXGUMf260kQLjH6p89Q5PYLIbo9BlRgSAh1FI2Di
         hAt+MWp3lOSBw==
Date:   Tue, 8 Nov 2022 16:29:44 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nathan Rossi <nathan@nathanrossi.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Rossi <nathan.rossi@digi.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI/ASPM: Wait for data link active after retraining
Message-ID: <20221108222944.GA504625@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220602065544.2552771-1-nathan@nathanrossi.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 02, 2022 at 06:55:44AM +0000, Nathan Rossi wrote:
> From: Nathan Rossi <nathan.rossi@digi.com>
> 
> When retraining the link either the child or the parent device may have
> the data link layer state machine of the respective devices move out of
> the active state despite the physical link training being completed.
> Depending on how long is takes for the devices to return to the active
> state, the device may not be ready and any further reads/writes to the
> device can fail.
> 
> This issue is present with the pci-mvebu controller paired with a device
> supporting ASPM but without advertising the Slot Clock, where during
> boot the pcie_aspm_cap_init call would cause common clocks to be made
> consistent and then retrain the link. However the data link layer would
> not be active before any device initialization (e.g. ASPM capability
> queries, BAR configuration) causing improper configuration of the device
> without error.
> 
> To ensure the child device is accessible, after the link retraining use
> pcie_wait_for_link to perform the associated state checks and any needed
> delays.
> 
> Signed-off-by: Nathan Rossi <nathan.rossi@digi.com>
> ---
>  drivers/pci/pcie/aspm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index a96b7424c9..4b8a1810be 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -288,7 +288,8 @@ static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
>  		reg16 &= ~PCI_EXP_LNKCTL_CCC;
>  	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
>  
> -	if (pcie_retrain_link(link))
> +	/* Retrain link and then wait for the link to become active */
> +	if (pcie_retrain_link(link) && pcie_wait_for_link(parent, true))

pcie_retrain_link() waits for PCI_EXP_LNKSTA_LT (Link Training) to be
cleared, which means the LTSSM has exited the Configuration/Recovery
state.  pcie_wait_for_link() waits for PCI_EXP_LNKSTA_DLLLA (Data Link
Layer Link Active) to be set, which means the link is in DL_Active.

I don't see an explicit procedure in the spec for determining when
a link retrain is complete, but from PCIe r6.0, sec 6.2.11 (DPC):

  After software releases the Downstream Port from DPC, the Port’s
  LTSSM must transition to the Detect state, where the Link will
  attempt to retrain. Software can use Data Link Layer State Changed
  interrupts, DL_ACTIVE ERR_COR signaling, or both, to signal when the
  Link reaches the DL_Active state again.

and sec 6.6:

  On the completion of Link Training (entering the DL_Active state,
  see Section 3.2), a component must be able to receive and process
  TLPs and DLLPs.

The only use mentioned in the spec for the Link Training bit is the
implementation note in sec 7.5.3.7 about avoiding race conditions when
using the Retrain Link bit, where software should poll Link Training
until it returns to zero before setting the Retrain Link bit to change
link parameters.

And I think you're absolutely right that what we *want* here is the
data link layer DL_Active state, not just the link layer L0 state.

This all makes me think that checking the Link Training bit might be
the wrong thing to begin with.

Of course, the Data Link Layer Link Active bit wasn't added until PCIe
r1.1, and even now it's optional.  Without it, I don't know if there's
a way to make sure the link is in DL_Active.

Maybe pcie_retrain_link() should wait for Data Link Layer Link Active
if it is supported, and use the existing behavior of waiting for Link
Training to be cleared otherwise?

>  		return;
>  
>  	/* Training failed. Restore common clock configurations */
> ---
> 2.36.1
