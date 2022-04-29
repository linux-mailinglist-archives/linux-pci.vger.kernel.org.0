Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B7B51578A
	for <lists+linux-pci@lfdr.de>; Fri, 29 Apr 2022 23:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378006AbiD2WBB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Apr 2022 18:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244304AbiD2WA6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Apr 2022 18:00:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F892DC58B
        for <linux-pci@vger.kernel.org>; Fri, 29 Apr 2022 14:57:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B407622F6
        for <linux-pci@vger.kernel.org>; Fri, 29 Apr 2022 21:57:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0496CC385A7;
        Fri, 29 Apr 2022 21:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651269457;
        bh=CKS8JIPIj/h8RRla918uWlsGDlcmbh7uyA+3I6XYGpE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jDfj3QjTMCIs21P6Fjv4FamVrh9XXdxwOWV9xZibgqmtwojNM7lbG9NX19Mps8dmu
         5hHPQcZRq2U+nTzubSYJ0wrMk9AUGEWcNelToxv+l9NFBWJBU2FdDoC0UFuRrm0jmk
         dlltl816kqdt0snLDh39e3DcHxTBUkB5iFno/0w2C9+g7ZJCnk0xdnIDn1kqn4RG05
         H4KebC6eQA+VEX/RvyqmmDHiBTXu5DWhzhMRB0iKraBsyULb8Lss4SxSk6DiOJlyFU
         A0fiXSz8MC6JdkRi9wIGuljmbWFAZ2mrAcQVX37MaBwvqOzU0e7RGY+czB5fvb4UfI
         uCqodfMsQQCxg==
Date:   Fri, 29 Apr 2022 16:57:33 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Conor.Dooley@microchip.com, maz@kernel.org
Cc:     lorenzo.pieralisi@arm.com, Daire.McNamara@microchip.com,
        bhelgaas@google.com, Cyril.Jean@microchip.com,
        david.abdurachmanov@gmail.com, linux-pci@vger.kernel.org,
        robh@kernel.org
Subject: Re: [RESEND PATCH v1 1/1] PCI: microchip: Fix potential race in
 interrupt handling
Message-ID: <20220429215733.GA97739@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79102463-adc1-9555-70ba-bdde58a77401@microchip.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+to Marc]

On Fri, Apr 29, 2022 at 09:42:52AM +0000, Conor.Dooley@microchip.com wrote:
> On 28/04/2022 10:29, Lorenzo Pieralisi wrote:
> > On Tue, Apr 05, 2022 at 12:17:51PM +0100, daire.mcnamara@microchip.com wrote:
> >> From: Daire McNamara <daire.mcnamara@microchip.com>
> >>
> >> Clear MSI bit in ISTATUS register after reading it before
> >> handling individual MSI bits
> > 
> > That explains nothing. If you are fixing a bug please describe
> > the issue and how the patch is fixing it.
> 
> Someone in the pantheon of IT gods has it out for Daire, so I am
> sending this on his behalf, but is the following revised commit
> message better?
> 
> Clear the MSI bit in ISTATUS register after reading it, but before
> reading and handling individual MSI bits from the IMSI register.
> This avoids a potential race where new MSI bits may be set on the
> IMSI register after it was read and be missed when the MSI bit in
> the ISTATUS register is cleared.

"ISTATUS" doesn't appear in the code as a register name.  Neither does
"IMSI".  Please use names that match the code.

Honestly, I don't understand enough about IRQs to determine whether
this is a correct fix.  Hopefully Marc will chime in.  All I really
know how to do is compare all the drivers and see which ones don't fit
the typical patterns.

And speaking of that, I looked at all the users of
irq_set_chained_handler_and_data() in drivers/pci.  All the handlers
except mc_handle_intx() and mc_handle_msi() call chained_irq_enter()
and chained_irq_exit().

Are mc_handle_intx() and mc_handle_msi() just really special, or is
this a mistake?

> Reported-by: Bjorn Helgaas <helgaas@kernel.org>

Please use this address instead:

Reported by: Bjorn Helgaas <bhelgaas@google.com>

> Link: https://lore.kernel.org/linux-pci/20220127202000.GA126335@bhelgaas/
> Fixes: 6f15a9c9f941 ("PCI: microchip: Add Microchip PolarFire PCIe controller driver")
> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> 
> >> This fixes a potential race condition pointed out by Bjorn Helgaas:
> >> https://lore.kernel.org/linux-pci/20220127202000.GA126335@bhelgaas/
> >>
> >> Fixes: 6f15a9c9f941 ("PCI: microchip: Add Microchip PolarFire PCIe controller driver")
> >> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> >> ---
> >> Adding linux-pci mailing list
> >>   drivers/pci/controller/pcie-microchip-host.c | 6 +-----
> >>   1 file changed, 1 insertion(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/pcie-microchip-host.c
> >> index 29d8e81e4181..da8e3fdc97b3 100644
> >> --- a/drivers/pci/controller/pcie-microchip-host.c
> >> +++ b/drivers/pci/controller/pcie-microchip-host.c
> >> @@ -416,6 +416,7 @@ static void mc_handle_msi(struct irq_desc *desc)
> >>   
> >>   	status = readl_relaxed(bridge_base_addr + ISTATUS_LOCAL);
> >>   	if (status & PM_MSI_INT_MSI_MASK) {
> >> +		writel_relaxed(status & PM_MSI_INT_MSI_MASK, bridge_base_addr + ISTATUS_LOCAL);
> > 
> > What does ISTATUS_LOCAL contain vs ISTATUS_MSI ? If you explain that
> > to me I could help you write the commit log.
> > 
> > Thanks,
> > Lorenzo
> > 
> >>   		status = readl_relaxed(bridge_base_addr + ISTATUS_MSI);
> >>   		for_each_set_bit(bit, &status, msi->num_vectors) {
> >>   			ret = generic_handle_domain_irq(msi->dev_domain, bit);
> >> @@ -432,13 +433,8 @@ static void mc_msi_bottom_irq_ack(struct irq_data *data)
> >>   	void __iomem *bridge_base_addr =
> >>   		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
> >>   	u32 bitpos = data->hwirq;
> >> -	unsigned long status;
> >>   
> >>   	writel_relaxed(BIT(bitpos), bridge_base_addr + ISTATUS_MSI);
> >> -	status = readl_relaxed(bridge_base_addr + ISTATUS_MSI);
> >> -	if (!status)
> >> -		writel_relaxed(BIT(PM_MSI_INT_MSI_SHIFT),
> >> -			       bridge_base_addr + ISTATUS_LOCAL);
> >>   }
> >>   
> >>   static void mc_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
> >> -- 
> >> 2.25.1
> >>
