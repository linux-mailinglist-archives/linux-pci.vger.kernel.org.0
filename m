Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0039625AC1
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 13:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbiKKM4r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 07:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233518AbiKKM4p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 07:56:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641B17E9B2;
        Fri, 11 Nov 2022 04:56:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42BF261FB7;
        Fri, 11 Nov 2022 12:56:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CA4DC433C1;
        Fri, 11 Nov 2022 12:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668171402;
        bh=GZJjoXeY92/wbEWKodrjM/CxinxDfJeWCSKEhT/weGA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EfgC7U+h3qFbloGBBqd7bP4ir8ilTncbWTxwGcjWHmekLads9w3xh4//+sotqYa2b
         wMvM71TCvCTEySTV69a9ygtndNunJMgon2Mh4QOb0D1t/Qu/etI5vH61e1jELdSrE+
         Bg5X9XGq7IkrZyWdAhA2lrlfQ19pDTbCOV/Mlm9h4dGgzmUgjwvaIKSvaEeLI4xLaZ
         7rKAjXEP7boQCHRi2SPPeMbch9pQl4CQbO3FiEvu8yHfM+bHRanmHXMY0W6Y63g0LU
         j6rRjb9zbF7VaC7yKb/O9guIeHwmK94IgsBIpFjAynIgmzguMDt1XQA3ocND+v56Og
         2pQgwhGdMFKGw==
Date:   Fri, 11 Nov 2022 13:56:36 +0100
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] PCI: mvebu: Use devm_request_irq() for registering
 interrupt handler
Message-ID: <Y25GhJuzInbEz0vs@lpieralisi>
References: <20220709143151.qhoa7vjcidxadrvt@pali>
 <20220709234430.GA489657@bhelgaas>
 <20220710000659.vxmlsvoin26tdiqw@pali>
 <20220829165109.fzrgguchg4otbbab@pali>
 <20220911154516.tu2b7qhsnk6mdtui@pali>
 <Yx7nXJRHN1sWCkVq@lpieralisi>
 <20220912084808.mmi42l7sp657dz6i@pali>
 <Yx70E4nBtKoVVmhO@lpieralisi>
 <20220912090306.fto5k3rj6jrbq3rj@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220912090306.fto5k3rj6jrbq3rj@pali>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 12, 2022 at 11:03:06AM +0200, Pali Rohár wrote:
> On Monday 12 September 2022 10:55:47 Lorenzo Pieralisi wrote:
> > On Mon, Sep 12, 2022 at 10:48:08AM +0200, Pali Rohár wrote:
> > > On Monday 12 September 2022 10:01:32 Lorenzo Pieralisi wrote:
> > > > On Sun, Sep 11, 2022 at 05:45:16PM +0200, Pali Rohár wrote:
> > > > > On Monday 29 August 2022 18:51:09 Pali Rohár wrote:
> > > > > > On Sunday 10 July 2022 02:06:59 Pali Rohár wrote:
> > > > > > > On Saturday 09 July 2022 18:44:30 Bjorn Helgaas wrote:
> > > > > > > > [+cc Marc, since he commented on this]
> > > > > > > > 
> > > > > > > > On Sat, Jul 09, 2022 at 04:31:51PM +0200, Pali Rohár wrote:
> > > > > > > > > On Friday 01 July 2022 16:29:41 Pali Rohár wrote:
> > > > > > > > > > On Thursday 23 June 2022 11:27:47 Bjorn Helgaas wrote:
> > > > > > > > > > > On Tue, May 24, 2022 at 02:28:17PM +0200, Pali Rohár wrote:
> > > > > > > > > > > > Same as in commit a3b69dd0ad62 ("Revert "PCI: aardvark: Rewrite IRQ code to
> > > > > > > > > > > > chained IRQ handler"") for pci-aardvark driver, use devm_request_irq()
> > > > > > > > > > > > instead of chained IRQ handler in pci-mvebu.c driver.
> > > > > > > > > > > >
> > > > > > > > > > > > This change fixes affinity support and allows to pin interrupts from
> > > > > > > > > > > > different PCIe controllers to different CPU cores.
> > > > > > > > > > > 
> > > > > > > > > > > Several other drivers use irq_set_chained_handler_and_data().  Do any
> > > > > > > > > > > of them need similar changes?  The commit log suggests that using
> > > > > > > > > > > chained IRQ handlers breaks affinity support.  But perhaps that's not
> > > > > > > > > > > the case and the real culprit is some other difference between mvebu
> > > > > > > > > > > and the other drivers.
> > > > > > > > > > 
> > > > > > > > > > And there is another reason to not use irq_set_chained_handler_and_data
> > > > > > > > > > and instead use devm_request_irq(). Armada XP has some interrupts
> > > > > > > > > > shared and it looks like that irq_set_chained_handler_and_data() API
> > > > > > > > > > does not handle shared interrupt sources too.
> > > > > > > > > > 
> > > > > > > > > > I can update commit message to mention also this fact.
> > > > > > > > > 
> > > > > > > > > Anything needed from me to improve this fix?
> > > > > > > > 
> > > > > > > > My impression from Marc's response [1] was that this patch would
> > > > > > > > "break the contract the kernel has with userspace" and he didn't think
> > > > > > > > this was acceptable.  But maybe I'm not understanding it correctly.
> > > > > > > 
> > > > > > > This is argument which Marc use when he does not have any argument.
> > > > > > > 
> > > > > > > Support for dedicated INTx into pci-mvebu.c was introduced just recently
> > > > > > > and I used irq_set_chained_handler_and_data() just because I thought it
> > > > > > > is a good idea and did not know about all those issues with it. So there
> > > > > > > cannot be any breakage by this patch.
> > > > > > > 
> > > > > > > I already converted other pci-aardvark.c driver to use
> > > > > > > irq_set_chained_handler_and_data() API because wanted it... But at the
> > > > > > > end _that conversion_ caused breakage of afinity support and so this
> > > > > > > conversion had to be reverted:
> > > > > > > https://lore.kernel.org/linux-pci/20220515125815.30157-1-pali@kernel.org/#t
> > > > > > > 
> > > > > > > Based on his past decisions, above suggestions which cause _real_
> > > > > > > breakage and his expressions like mvebu should be put into the trash,
> > > > > > > I'm not going to listen him anymore. The only breaking is done by him.
> > > > > > > 
> > > > > > > 
> > > > > > > There are two arguments why to not use irq_set_chained_handler_and_data:
> > > > > > > 
> > > > > > > 1) It does not support afinity and therefore has negative performance
> > > > > > >    impact on Armada platforms with more CPUs and more PCIe ports.
> > > > > > > 
> > > > > > > 2) It does not support shared interrupts and therefore it will break
> > > > > > >    hardware on which interrupt lines are shares (mostly Armada XP).
> > > > > > > 
> > > > > > > So these issues have to be fixed and currently I see only option to
> > > > > > > switch irq_set_chained_handler_and_data() to devm_request_irq() which I
> > > > > > > did in this fixup patch.
> > > > > > 
> > > > > > Any progress here? This patch is waiting here since end of May and if
> > > > > > something is going to be broken then it is this fact of ignoring reported
> > > > > > issues and proposed patch. Do you better solution how to fix commit
> > > > > > ec075262648f?
> > > > > 
> > > > > After two weeks I'm reminding this fix patch again...
> > > > 
> > > > There is no point complaining about something you were asked
> > > > to change, really - there is not.
> > > > 
> > > > You were given feedback, feel free to ignore it, it won't help
> > > > getting this patch upstream - it is as simple as that, sorry.
> > > > 
> > > > Thanks,
> > > > Lorenzo
> > > 
> > > I'm not sure if I understand you, what do you mean that all patches
> > > which depends on this are now automatically rejected or what?
> > 
> > I am not merging this code unless it is acked by an IRQ maintainer.
> > 
> > Is it clear enough ?
> > 
> > Thanks,
> > Lorenzo
> 
> So, could you then propose a solution how to fix this issue to allow one
> interrupt to be shared with more devices, like it is needed for some
> Armada platforms? Because I do not see a way how to do it without
> IRQF_SHARED and without shared interrupt it is not possible to implement
> any other pending features.
> 
> I'm feeling that since May there is just conclusion that all development
> on the mvebu must be stopped as more people here do not like this
> hardware and trying to do remove it or at least make it orphan.

Marc gave you a solution - we are going round in circles, it is getting
boring, honestly.

https://lore.kernel.org/linux-pci/874k0bf7f7.wl-maz@kernel.org

Either you implement what he asks for or I drop this patch and all
dependent ones from the PCI queue - apologies.

Lorenzo
