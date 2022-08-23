Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A4C59EACA
	for <lists+linux-pci@lfdr.de>; Tue, 23 Aug 2022 20:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbiHWSQl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Aug 2022 14:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233482AbiHWSQL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Aug 2022 14:16:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D2B15705;
        Tue, 23 Aug 2022 09:31:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5083FB81EAE;
        Tue, 23 Aug 2022 16:31:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D0EC433C1;
        Tue, 23 Aug 2022 16:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661272274;
        bh=OqHw0q9DNVYJjnlUp9Yin1mQ5pVhxLZiNR6IhSFn7bA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tRjNx3AR6TP1nyjLh0bi1GmL6MkgwnTlSz6NJSYPpVDTSH3nAW1ZJ11KWAvZnEyFp
         0kbIjN2y0xVlccS/8p3JyFOSBw5mTEPLefYu/pCRpbaP+qF7svdC3CBSIub4QMI2nq
         nul+hmJeIwfF6IzqwYdp9E228aMjshTpIeCl4eWYP4e3FJN+iblUHHYfDhjaVsGMdN
         syR9CMXVKp80l7wZQxMMRz8Fa3SjPo7znivh7amixYM2pdgeb6HoQMGF9hMJua/rA9
         qZZcM1DwIkCcULA7AvcXL7HOSmyV7POWYZ7qpRWKqMXXvWRvq138LgOMvemg1vccoq
         CL6QFEY+kXyxA==
Received: by pali.im (Postfix)
        id A4438621; Tue, 23 Aug 2022 18:31:10 +0200 (CEST)
Date:   Tue, 23 Aug 2022 18:31:10 +0200
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
Message-ID: <20220823163110.rtqz534otlzsziza@pali>
References: <20220703104627.27058-1-pali@kernel.org>
 <20220823101439.24525-1-pali@kernel.org>
 <YwT4fRJ4dF2JflwF@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YwT4fRJ4dF2JflwF@lpieralisi>
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

On Tuesday 23 August 2022 17:55:41 Lorenzo Pieralisi wrote:
> On Tue, Aug 23, 2022 at 12:14:39PM +0200, Pali Rohár wrote:
> > mvebu and aardvark HW have PCIe capabilities on different offset in PCI
> > config space. Extend pci-bridge-emul.c code to allow setting custom driver
> > custom value where PCIe capabilities starts.
> > 
> > With this change PCIe capabilities of both drivers are reported at the same
> > location as where they are reported by U-Boot - in their real HW offset.
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> > Changes in v2:
> > * Rebase on top of v6.0-rc1, fix usage of PCIE_CAP_PCIEXP
> > ---
> >  drivers/pci/controller/pci-aardvark.c |  1 +
> >  drivers/pci/controller/pci-mvebu.c    |  1 +
> >  drivers/pci/pci-bridge-emul.c         | 46 +++++++++++++++++----------
> >  drivers/pci/pci-bridge-emul.h         |  2 ++
> >  4 files changed, 33 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> > index 966c8b48bd96..4834198cc86b 100644
> > --- a/drivers/pci/controller/pci-aardvark.c
> > +++ b/drivers/pci/controller/pci-aardvark.c
> > @@ -1078,6 +1078,7 @@ static int advk_sw_pci_bridge_init(struct advk_pcie *pcie)
> >  	bridge->pcie_conf.rootcap = cpu_to_le16(PCI_EXP_RTCAP_CRSVIS);
> >  
> >  	bridge->has_pcie = true;
> > +	bridge->pcie_start = PCIE_CORE_PCIEXP_CAP;
> >  	bridge->data = pcie;
> >  	bridge->ops = &advk_pci_bridge_emul_ops;
> >  
> > diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> > index af915c951f06..0fdbb5585fec 100644
> > --- a/drivers/pci/controller/pci-mvebu.c
> > +++ b/drivers/pci/controller/pci-mvebu.c
> > @@ -946,6 +946,7 @@ static int mvebu_pci_bridge_emul_init(struct mvebu_pcie_port *port)
> >  	bridge->subsystem_vendor_id = ssdev_id & 0xffff;
> >  	bridge->subsystem_id = ssdev_id >> 16;
> >  	bridge->has_pcie = true;
> > +	bridge->pcie_start = PCIE_CAP_PCIEXP;
> >  	bridge->data = port;
> >  	bridge->ops = &mvebu_pci_bridge_emul_ops;
> >  
> > diff --git a/drivers/pci/pci-bridge-emul.c b/drivers/pci/pci-bridge-emul.c
> > index 9c2ca28e3ecf..dfbbe43ef518 100644
> > --- a/drivers/pci/pci-bridge-emul.c
> > +++ b/drivers/pci/pci-bridge-emul.c
> > @@ -22,11 +22,7 @@
> >  
> >  #define PCI_BRIDGE_CONF_END	PCI_STD_HEADER_SIZEOF
> >  #define PCI_CAP_SSID_SIZEOF	(PCI_SSVID_DEVICE_ID + 2)
> > -#define PCI_CAP_SSID_START	PCI_BRIDGE_CONF_END
> > -#define PCI_CAP_SSID_END	(PCI_CAP_SSID_START + PCI_CAP_SSID_SIZEOF)
> >  #define PCI_CAP_PCIE_SIZEOF	(PCI_EXP_SLTSTA2 + 2)
> > -#define PCI_CAP_PCIE_START	PCI_CAP_SSID_END
> > -#define PCI_CAP_PCIE_END	(PCI_CAP_PCIE_START + PCI_CAP_PCIE_SIZEOF)
> >  
> >  /**
> >   * struct pci_bridge_reg_behavior - register bits behaviors
> > @@ -324,7 +320,7 @@ pci_bridge_emul_read_ssid(struct pci_bridge_emul *bridge, int reg, u32 *value)
> >  	switch (reg) {
> >  	case PCI_CAP_LIST_ID:
> >  		*value = PCI_CAP_ID_SSVID |
> > -			(bridge->has_pcie ? (PCI_CAP_PCIE_START << 8) : 0);
> > +			((bridge->pcie_start > bridge->ssid_start) ? (bridge->pcie_start << 8) : 0);
> >  		return PCI_BRIDGE_EMUL_HANDLED;
> >  
> >  	case PCI_SSVID_VENDOR_ID:
> > @@ -365,12 +361,25 @@ int pci_bridge_emul_init(struct pci_bridge_emul *bridge,
> >  	if (!bridge->pci_regs_behavior)
> >  		return -ENOMEM;
> >  
> > -	if (bridge->subsystem_vendor_id)
> > -		bridge->conf.capabilities_pointer = PCI_CAP_SSID_START;
> > -	else if (bridge->has_pcie)
> > -		bridge->conf.capabilities_pointer = PCI_CAP_PCIE_START;
> > -	else
> > -		bridge->conf.capabilities_pointer = 0;
> > +	/* If ssid_start and pcie_start were not specified then choose the lowest possible value. */
> > +	if (!bridge->ssid_start && !bridge->pcie_start) {
> > +		if (bridge->subsystem_vendor_id)
> > +			bridge->ssid_start = PCI_BRIDGE_CONF_END;
> > +		if (bridge->has_pcie)
> > +			bridge->pcie_start = bridge->ssid_start + PCI_CAP_SSID_SIZEOF;
> > +	} else if (!bridge->ssid_start && bridge->subsystem_vendor_id) {
> > +		if (bridge->pcie_start - PCI_BRIDGE_CONF_END >= PCI_CAP_SSID_SIZEOF)
> > +			bridge->ssid_start = PCI_BRIDGE_CONF_END;
> > +		else
> > +			bridge->ssid_start = bridge->pcie_start + PCI_CAP_PCIE_SIZEOF;
> > +	} else if (!bridge->pcie_start && bridge->has_pcie) {
> > +		if (bridge->ssid_start - PCI_BRIDGE_CONF_END >= PCI_CAP_PCIE_SIZEOF)
> > +			bridge->pcie_start = PCI_BRIDGE_CONF_END;
> 
> Right. So here the PCI express capability should be made to point to
> subsystem ID vendor capability but I don't see anything in the code
> that makes it happen. I am just trying to understand what this patch
> is changing and AFAICS this code path is not triggered with current
> code but it may well be in the future.

This top level branch is called when emulated PCI bridge is PCIe device
(has_pcie is truth) and PCIe host controller driver did not want to put
PCI express capability at any specific offset (pcie_start address is not
filled, is zero), but want to put SSID capability at specific offset
(ssid_start is filled).

Second inner branch is called when between PCI standard capability and
SSID capability is enough place for putting PCI express capability.

So in this case offset for PCI express capability (pcie_start) is set
immediate after the PCI standard capability.

All these conditions (toplevel + inner branch) are not currently called,
because both aardvark and mvebu drivers do not match those conditions.
I put this code here to ensure that if somebody adds a new driver which
will use pci emul bridge, it will work and does not crash kernel because
values pcie_start or ssid_start are not filled but capabilities are
required.

> In other words: what if PCI express capability is lower in the address
> space (config) than the subsystem ID vendor capability ?

Current code expects that if host controller driver sets both pcie_start
and ssid_start, those values are correct, non-overlapping and can be
handled correctly.

And if offset to PCI express capability is lower than offset to SSID
capability then there should not be any issue. First capability is
correctly set into capabilities_pointer (via min function) and then
pci_bridge_emul_conf_read() should handle it.

The whole my idea is to construct capabilities linked list structure
correctly based on input requirements (e.g. fixed location of some
capability, etc).

> I am just trying to understand the patch, so forgive me if the question
> is already addressed in the code.
> 
> Thanks,
> Lorenzo
> 
> > +		else
> > +			bridge->pcie_start = bridge->ssid_start + PCI_CAP_SSID_SIZEOF;
> > +	}
> > +
> > +	bridge->conf.capabilities_pointer = min(bridge->ssid_start, bridge->pcie_start);
> >  
> >  	if (bridge->conf.capabilities_pointer)
> >  		bridge->conf.status |= cpu_to_le16(PCI_STATUS_CAP_LIST);
> > @@ -459,15 +468,17 @@ int pci_bridge_emul_conf_read(struct pci_bridge_emul *bridge, int where,
> >  		read_op = bridge->ops->read_base;
> >  		cfgspace = (__le32 *) &bridge->conf;
> >  		behavior = bridge->pci_regs_behavior;
> > -	} else if (reg >= PCI_CAP_SSID_START && reg < PCI_CAP_SSID_END && bridge->subsystem_vendor_id) {
> > +	} else if (reg >= bridge->ssid_start && reg < bridge->ssid_start + PCI_CAP_SSID_SIZEOF &&
> > +		   bridge->subsystem_vendor_id) {
> >  		/* Emulated PCI Bridge Subsystem Vendor ID capability */
> > -		reg -= PCI_CAP_SSID_START;
> > +		reg -= bridge->ssid_start;
> >  		read_op = pci_bridge_emul_read_ssid;
> >  		cfgspace = NULL;
> >  		behavior = NULL;
> > -	} else if (reg >= PCI_CAP_PCIE_START && reg < PCI_CAP_PCIE_END && bridge->has_pcie) {
> > +	} else if (reg >= bridge->pcie_start && reg < bridge->pcie_start + PCI_CAP_PCIE_SIZEOF &&
> > +		   bridge->has_pcie) {
> >  		/* Our emulated PCIe capability */
> > -		reg -= PCI_CAP_PCIE_START;
> > +		reg -= bridge->pcie_start;
> >  		read_op = bridge->ops->read_pcie;
> >  		cfgspace = (__le32 *) &bridge->pcie_conf;
> >  		behavior = bridge->pcie_cap_regs_behavior;
> > @@ -538,9 +549,10 @@ int pci_bridge_emul_conf_write(struct pci_bridge_emul *bridge, int where,
> >  		write_op = bridge->ops->write_base;
> >  		cfgspace = (__le32 *) &bridge->conf;
> >  		behavior = bridge->pci_regs_behavior;
> > -	} else if (reg >= PCI_CAP_PCIE_START && reg < PCI_CAP_PCIE_END && bridge->has_pcie) {
> > +	} else if (reg >= bridge->pcie_start && reg < bridge->pcie_start + PCI_CAP_PCIE_SIZEOF &&
> > +		   bridge->has_pcie) {
> >  		/* Our emulated PCIe capability */
> > -		reg -= PCI_CAP_PCIE_START;
> > +		reg -= bridge->pcie_start;
> >  		write_op = bridge->ops->write_pcie;
> >  		cfgspace = (__le32 *) &bridge->pcie_conf;
> >  		behavior = bridge->pcie_cap_regs_behavior;
> > diff --git a/drivers/pci/pci-bridge-emul.h b/drivers/pci/pci-bridge-emul.h
> > index 71392b67471d..2a0e59c7f0d9 100644
> > --- a/drivers/pci/pci-bridge-emul.h
> > +++ b/drivers/pci/pci-bridge-emul.h
> > @@ -131,6 +131,8 @@ struct pci_bridge_emul {
> >  	struct pci_bridge_reg_behavior *pci_regs_behavior;
> >  	struct pci_bridge_reg_behavior *pcie_cap_regs_behavior;
> >  	void *data;
> > +	u8 pcie_start;
> > +	u8 ssid_start;
> >  	bool has_pcie;
> >  	u16 subsystem_vendor_id;
> >  	u16 subsystem_id;
> > -- 
> > 2.20.1
> > 
