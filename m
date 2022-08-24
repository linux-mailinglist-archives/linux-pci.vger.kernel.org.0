Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E2959F7DB
	for <lists+linux-pci@lfdr.de>; Wed, 24 Aug 2022 12:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236617AbiHXKdP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Aug 2022 06:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236500AbiHXKdO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Aug 2022 06:33:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A250380B4D;
        Wed, 24 Aug 2022 03:33:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1858161900;
        Wed, 24 Aug 2022 10:33:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 191E0C433D6;
        Wed, 24 Aug 2022 10:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661337192;
        bh=+gsQSafX9u7DcMcLEj6Bzg0Av/lPycIr85rXwV72OC0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i1JPp9kcEmRc3pTqob4/kF5ttxl3+gUDSOJk5X5r46s7LoLeSF5mYqfSBdqHyST5j
         Y9242jQRNVWwh+78PrAMZr8tsImEg7st17CvvsR6OqbtND/6N3uechefWJ6EyzrGoW
         KrFT3KPlmidoNxXQDE/4MAw74s8kIocabqSocLQCrTRO32eiEWG6E5gw9LUGGGGHG9
         9FWKH17h5vkG+LeC/mMUG45KWlJ9KnwCzYRKfhWvaZr+HbM+4vHWMyEFt1pbjTqxD7
         7Ov/f3EOLmEUWeU2Q+CTuInoSepk8dC+fWTdLJuvinlDQt9646bi7Hx4GkU5OwSZnj
         kj4CRWkXHiHXg==
Received: by pali.im (Postfix)
        id 428D57DA; Wed, 24 Aug 2022 12:33:08 +0200 (CEST)
Date:   Wed, 24 Aug 2022 12:33:08 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: pci-bridge-emul: Set position of PCI
 capabilities to real HW value
Message-ID: <20220824103308.tmjvks2sbn5p4dew@pali>
References: <20220703104627.27058-1-pali@kernel.org>
 <20220823101439.24525-1-pali@kernel.org>
 <YwT4fRJ4dF2JflwF@lpieralisi>
 <20220823163110.rtqz534otlzsziza@pali>
 <YwXSW4pDSMZeHhMm@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwXSW4pDSMZeHhMm@lpieralisi>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 24 August 2022 09:25:15 Lorenzo Pieralisi wrote:
> [...]
> 
> > > In other words: what if PCI express capability is lower in the address
> > > space (config) than the subsystem ID vendor capability ?
> > 
> > Current code expects that if host controller driver sets both pcie_start
> > and ssid_start, those values are correct, non-overlapping and can be
> > handled correctly.
> > 
> > And if offset to PCI express capability is lower than offset to SSID
> > capability then there should not be any issue. First capability is
> > correctly set into capabilities_pointer (via min function) and then
> > pci_bridge_emul_conf_read() should handle it.
> 
> I don't understand how the pointer to the SSID cap is set in this
> specific case, I don't see any code doing that but that's most certainly
> because I don't know in details the emul bridge internals.
> 
> IIUC, in pci_bridge_emul_read_ssid(), we set the next cap pointer if
> the PCI express capability is at an address higher (current case) than
> the SSID capability otherwise we set it to 0 (end of the list).
> 
> The other way around, I don't see the PCI express next cap pointer
> being set anywhere (where, IIUC, it should be set to point to the
> SSID cap) - I am not sure you are handling it.

Ou, I see. This is really missing! It should be set when initializing
pcie_conf.cap_id and pcie_conf.cap at this place:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/pci/pci-bridge-emul.c?h=v6.0-rc2#n379

I will fix it and send a new version of this patch.

> That's the only question I have on this patch.
> 
> Lorenzo
> 
> > The whole my idea is to construct capabilities linked list structure
> > correctly based on input requirements (e.g. fixed location of some
> > capability, etc).
> > 
> > > I am just trying to understand the patch, so forgive me if the question
> > > is already addressed in the code.
> > > 
> > > Thanks,
> > > Lorenzo
> > > 
> > > > +		else
> > > > +			bridge->pcie_start = bridge->ssid_start + PCI_CAP_SSID_SIZEOF;
> > > > +	}
> > > > +
> > > > +	bridge->conf.capabilities_pointer = min(bridge->ssid_start, bridge->pcie_start);
> > > >  
> > > >  	if (bridge->conf.capabilities_pointer)
> > > >  		bridge->conf.status |= cpu_to_le16(PCI_STATUS_CAP_LIST);
> > > > @@ -459,15 +468,17 @@ int pci_bridge_emul_conf_read(struct pci_bridge_emul *bridge, int where,
> > > >  		read_op = bridge->ops->read_base;
> > > >  		cfgspace = (__le32 *) &bridge->conf;
> > > >  		behavior = bridge->pci_regs_behavior;
> > > > -	} else if (reg >= PCI_CAP_SSID_START && reg < PCI_CAP_SSID_END && bridge->subsystem_vendor_id) {
> > > > +	} else if (reg >= bridge->ssid_start && reg < bridge->ssid_start + PCI_CAP_SSID_SIZEOF &&
> > > > +		   bridge->subsystem_vendor_id) {
> > > >  		/* Emulated PCI Bridge Subsystem Vendor ID capability */
> > > > -		reg -= PCI_CAP_SSID_START;
> > > > +		reg -= bridge->ssid_start;
> > > >  		read_op = pci_bridge_emul_read_ssid;
> > > >  		cfgspace = NULL;
> > > >  		behavior = NULL;
> > > > -	} else if (reg >= PCI_CAP_PCIE_START && reg < PCI_CAP_PCIE_END && bridge->has_pcie) {
> > > > +	} else if (reg >= bridge->pcie_start && reg < bridge->pcie_start + PCI_CAP_PCIE_SIZEOF &&
> > > > +		   bridge->has_pcie) {
> > > >  		/* Our emulated PCIe capability */
> > > > -		reg -= PCI_CAP_PCIE_START;
> > > > +		reg -= bridge->pcie_start;
> > > >  		read_op = bridge->ops->read_pcie;
> > > >  		cfgspace = (__le32 *) &bridge->pcie_conf;
> > > >  		behavior = bridge->pcie_cap_regs_behavior;
> > > > @@ -538,9 +549,10 @@ int pci_bridge_emul_conf_write(struct pci_bridge_emul *bridge, int where,
> > > >  		write_op = bridge->ops->write_base;
> > > >  		cfgspace = (__le32 *) &bridge->conf;
> > > >  		behavior = bridge->pci_regs_behavior;
> > > > -	} else if (reg >= PCI_CAP_PCIE_START && reg < PCI_CAP_PCIE_END && bridge->has_pcie) {
> > > > +	} else if (reg >= bridge->pcie_start && reg < bridge->pcie_start + PCI_CAP_PCIE_SIZEOF &&
> > > > +		   bridge->has_pcie) {
> > > >  		/* Our emulated PCIe capability */
> > > > -		reg -= PCI_CAP_PCIE_START;
> > > > +		reg -= bridge->pcie_start;
> > > >  		write_op = bridge->ops->write_pcie;
> > > >  		cfgspace = (__le32 *) &bridge->pcie_conf;
> > > >  		behavior = bridge->pcie_cap_regs_behavior;
> > > > diff --git a/drivers/pci/pci-bridge-emul.h b/drivers/pci/pci-bridge-emul.h
> > > > index 71392b67471d..2a0e59c7f0d9 100644
> > > > --- a/drivers/pci/pci-bridge-emul.h
> > > > +++ b/drivers/pci/pci-bridge-emul.h
> > > > @@ -131,6 +131,8 @@ struct pci_bridge_emul {
> > > >  	struct pci_bridge_reg_behavior *pci_regs_behavior;
> > > >  	struct pci_bridge_reg_behavior *pcie_cap_regs_behavior;
> > > >  	void *data;
> > > > +	u8 pcie_start;
> > > > +	u8 ssid_start;
> > > >  	bool has_pcie;
> > > >  	u16 subsystem_vendor_id;
> > > >  	u16 subsystem_id;
> > > > -- 
> > > > 2.20.1
> > > > 
