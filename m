Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B714D4C887C
	for <lists+linux-pci@lfdr.de>; Tue,  1 Mar 2022 10:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbiCAJr5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Mar 2022 04:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234119AbiCAJry (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Mar 2022 04:47:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5357B8BF47;
        Tue,  1 Mar 2022 01:47:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DF486B817CF;
        Tue,  1 Mar 2022 09:47:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32853C340EE;
        Tue,  1 Mar 2022 09:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646128030;
        bh=bIEyEZCYsYHYD4lz+YBrbdVvQiVr4Nv4bmNiO9AhL4I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hQMMlXanjwsY0GvyqcfaeYDkD7UPWfXKsRh3SU34twWSptfTIm7Tv48s3LKORwKSE
         aGw9cpI51eIW1iNYFG1IASAGOiT3V0vGDk1g3GHtp5t9gGTyv7g0T+C4a+KHz4imaq
         Bua7vWOfr8KfPCfeobB0ionRCQR/lCLjiCzxxETMrGd8I0nTkOE4cugEimddghBWLF
         HWibgvIVSMOOI/hhhcYULMAD6QNwwVd22+U4bi5csnO1KywIiGbSWAkfsULI7VpMdS
         Ra6mHuQywp1ZrukDEZ9gYyhgITOLeYStx1VewEQX5AuTSI1J+HhoN8J/hTgv6wCkwS
         tvIewl+GCmuwQ==
Received: by pali.im (Postfix)
        id 67CEAC77; Tue,  1 Mar 2022 10:47:07 +0100 (CET)
Date:   Tue, 1 Mar 2022 10:47:07 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] PCI: mvebu: Add support for sending
 Set_Slot_Power_Limit message
Message-ID: <20220301094707.64jbqpoxhmana7ua@pali>
References: <20220225125407.wglplhyisgges3zk@pali>
 <20220225165731.GA359939@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220225165731.GA359939@bhelgaas>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 25 February 2022 10:57:31 Bjorn Helgaas wrote:
> On Fri, Feb 25, 2022 at 01:54:07PM +0100, Pali Rohár wrote:
> > On Thursday 24 February 2022 15:28:11 Bjorn Helgaas wrote:
> > > On Tue, Feb 22, 2022 at 05:31:57PM +0100, Pali Rohár wrote:
> > > > This PCIe message is sent automatically by mvebu HW when link changes
> > > > status from down to up.
> 
> > > > +	 * Program Root Complex to automatically sends Set Slot Power Limit
> > > > +	 * PCIe Message when changing status from Dl-Down to Dl-Up and valid
> > > > +	 * slot power limit was specified.
> > > 
> > > s/Root Complex/Root Port/, right?  AFAIK the message would be sent by
> > > a Downstream Port, i.e., a Root Port in this case.
> > 
> > Yes!
> > 
> > I see that on more places that names "Root Port", "Root Bridge" and
> > "Root Complex" used as the one thing.
> > 
> > It is probably because HW has only one Root Port and is integrated into
> > same silicon as Root Complex and shares HW registers. And Root Port has
> > PCI class code "PCI Bridge", hence Root Bridge.
> > 
> > But I agree that correct name is "Root Port".
> > 
> > Moreover in Armada 38x Functional Specification is this register named
> > "Root Complex Set Slot Power Limit" and not Root "Port".
> 
> Haha, yes, sounds like this stems from the knowledge that "of course
> this Root Complex only has one Root Port, so there's no real
> difference between them."
> 
> So I think it makes sense for #defines for device-specific registers
> like PCIE_SSPL_OFF to match the Armada spec, but I think it would be
> better if the comments and code structure did not have the assumption
> that there's only one Root Port baked into them.  For one thing, this
> can help make the driver structure more uniform across all the
> drivers.

Ok!

> > > s/sends/send/
> > > s/Set Slot Power Limit/Set_Slot_Power_Limit/ to match spec usage (also
> > > below)
> > > s/Dl-Down/DL_Down/ to match spec usage
> > > s/Dl-Up/DL_Up/ ditto
> > 
> > In Armada 38x Functional Specification spec it is called like I wrote
> > and some people told me to use "naming" as written in SoC/HW
> > specification to not confuse other people who are writing / developing
> > drivers according to official SoC/HW specification.
> > 
> > I see that both has pro and cons. Usage of terminology from PCIe spec is
> > what PCIe people expect and terminology from vendor SoC HW spec is what
> > people who develop that SoC expect.
> > 
> > I can update and change comments without issue to any variant which you
> > prefer. No problem with it. Just I wanted to write why I chose those
> > names.
> 
> All these concepts are purely PCIe.  There is no Armada-specific
> meaning because they have to behave as specified by the PCIe spec so
> they work across the Link with non-Armada devices on the other end.
> If the Armada spec spells them differently, I claim that's an editing
> mistake in that spec.
> 
> My preference is to use the PCIe spec naming except for
> Armada-specific things.  The Armada spellings don't appear in the PCIe
> spec, so it's just an unnecessary irritant when trying to look them
> up.

Ok!

> > > > +	case PCI_EXP_SLTCTL:
> > > > +		if ((mask & PCI_EXP_SLTCTL_ASPL_DISABLE) &&
> > > > +		    port->slot_power_limit_value &&
> > > > +		    port->slot_power_limit_scale) {
> > > > +			u32 sspl = mvebu_readl(port, PCIE_SSPL_OFF);
> > > > +			if (new & PCI_EXP_SLTCTL_ASPL_DISABLE)
> > > > +				sspl &= ~PCIE_SSPL_ENABLE;
> > > > +			else
> > > > +				sspl |= PCIE_SSPL_ENABLE;
> > > > +			mvebu_writel(port, sspl, PCIE_SSPL_OFF);
> > > 
> > > IIUC, the behavior of PCI_EXP_SLTCTL_ASPL_DISABLE as observed by
> > > software that sets it and reads it back will depend on whether the DT
> > > contains "slot-power-limit-milliwatt".
> > > 
> > > If there is no DT property, port->slot_power_limit_value will be zero
> > > and PCIE_SSPL_ENABLE will never be set.  So if I clear
> > > PCI_EXP_SLTCTL_ASPL_DISABLE, then read it back, it looks like it will
> > > read as being set.
> > 
> > Yes.
> > 
> > > That's not what I would expect from the spec (PCIe r6.0, sec 7.5.3.10).
> > 
> > Ok. What you would expect here? That PCI_EXP_SLTCTL_ASPL_DISABLE is not
> > set even when Set_Slot_Power_Limit was never sent and would be never
> > sent (as it was not programmed by firmware = in DT)?
> 
> Per spec, I would expect PCI_EXP_SLTCTL_ASPL_DISABLE to be either:
> 
>   - Hardwired to 0, so writes have no effect and reads always return
>     0, or
> 
>   - Writable, so a read always returns what was previously written.
> 
> Here's the relevant text from r6.0, sec 7.5.3.10:
> 
>   Auto Slot Power Limit Disable - When Set, this disables the
>   automatic sending of a Set_Slot_Power_Limit Message when a Link
>   transitions from a non-DL_Up status to a DL_Up status.
> 
>   Downstream ports that don’t support DPC are permitted to hardwire
>   this bit to 0.
> 
>   Default value of this bit is implementation specific.
> 
> AFAICT, the Slot Power Control mechanism is required for all devices,
> but without "slot-power-limit-milliwatt", we don't know what limit to
> use.  Apparently the CEM specs specify minimum values, but they depend
> on the form factor.
> 
> From r6.0, sec 6.9:
> 
>   For Adapters:
> 
>     - Until and unless a Set_Slot_Power_Limit Message is received
>       indicating a Slot Power Limit value greater than the lowest
>       value specified in the form factor specification for the
>       adapter's form factor, the adapter must not consume more than
>       the lowest value specified.
> 
>     - An adapter must never consume more power than what was specified
>       in the most recently received Set_Slot_Power_Limit Message or
>       the minimum value specified in the corresponding form factor
>       specification, whichever is higher.
> 
> If PCIE_SSPL_ENABLE is never set, Set_Slot_Power_Limit will never be
> sent, and the device is not allowed to consume more than the minimum
> power specified by its form factor spec.
> 
> I'd say reading PCI_EXP_SLTCTL should return whatever
> PCI_EXP_SLTCTL_ASPL_DISABLE value was most recently written, but we
> should set PCIE_SSPL_ENABLE only when we have a
> "slot-power-limit-milliwatt" property AND
> PCI_EXP_SLTCTL_ASPL_DISABLE == 0.
> 
> Does that make sense?

Yes!
