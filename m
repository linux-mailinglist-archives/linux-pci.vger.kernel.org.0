Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9BA5B56EB
	for <lists+linux-pci@lfdr.de>; Mon, 12 Sep 2022 11:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiILJDO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Sep 2022 05:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiILJDN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Sep 2022 05:03:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2FE2AE31;
        Mon, 12 Sep 2022 02:03:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53C2DB80C9D;
        Mon, 12 Sep 2022 09:03:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95029C433B5;
        Mon, 12 Sep 2022 09:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662973390;
        bh=rroGK1qgiudE47SXuHyimZ1hrzOFpKH7plrx/wspNrQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xbln2LQkRPsMcXjCqg2m/pAbEoEtHLPKEqZkElSXEmocK3WOWH+Pu8gN2DnYR82Rr
         C7wsTd/HO1FzuRZgYRXq+trIHjccrMeTQmhE6z5K876HbqnfUysn0kjnlugcR3vj9B
         CE+moMAM5qqn1WHwHlpy2VJFeYZsJolNCXGHICuxFRjZvsNG5OaIQrcC+U69IQwIxD
         R/YKxzIkODoNQYoQrLsB6FzVKd75grO7m5EORxtOVEhjH6jpOXv8c3Wg1aedbqzF5W
         hk/4JsuHhHhswK3vz/Qzc1vvQAc1NWGOhKvREQ8GtiBdhT54TFTTn2RIp7LHvVv4Go
         jwQOV8oy4VBrw==
Received: by pali.im (Postfix)
        id AF6B311D3; Mon, 12 Sep 2022 11:03:06 +0200 (CEST)
Date:   Mon, 12 Sep 2022 11:03:06 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
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
Message-ID: <20220912090306.fto5k3rj6jrbq3rj@pali>
References: <20220709143151.qhoa7vjcidxadrvt@pali>
 <20220709234430.GA489657@bhelgaas>
 <20220710000659.vxmlsvoin26tdiqw@pali>
 <20220829165109.fzrgguchg4otbbab@pali>
 <20220911154516.tu2b7qhsnk6mdtui@pali>
 <Yx7nXJRHN1sWCkVq@lpieralisi>
 <20220912084808.mmi42l7sp657dz6i@pali>
 <Yx70E4nBtKoVVmhO@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yx70E4nBtKoVVmhO@lpieralisi>
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

On Monday 12 September 2022 10:55:47 Lorenzo Pieralisi wrote:
> On Mon, Sep 12, 2022 at 10:48:08AM +0200, Pali Rohár wrote:
> > On Monday 12 September 2022 10:01:32 Lorenzo Pieralisi wrote:
> > > On Sun, Sep 11, 2022 at 05:45:16PM +0200, Pali Rohár wrote:
> > > > On Monday 29 August 2022 18:51:09 Pali Rohár wrote:
> > > > > On Sunday 10 July 2022 02:06:59 Pali Rohár wrote:
> > > > > > On Saturday 09 July 2022 18:44:30 Bjorn Helgaas wrote:
> > > > > > > [+cc Marc, since he commented on this]
> > > > > > > 
> > > > > > > On Sat, Jul 09, 2022 at 04:31:51PM +0200, Pali Rohár wrote:
> > > > > > > > On Friday 01 July 2022 16:29:41 Pali Rohár wrote:
> > > > > > > > > On Thursday 23 June 2022 11:27:47 Bjorn Helgaas wrote:
> > > > > > > > > > On Tue, May 24, 2022 at 02:28:17PM +0200, Pali Rohár wrote:
> > > > > > > > > > > Same as in commit a3b69dd0ad62 ("Revert "PCI: aardvark: Rewrite IRQ code to
> > > > > > > > > > > chained IRQ handler"") for pci-aardvark driver, use devm_request_irq()
> > > > > > > > > > > instead of chained IRQ handler in pci-mvebu.c driver.
> > > > > > > > > > >
> > > > > > > > > > > This change fixes affinity support and allows to pin interrupts from
> > > > > > > > > > > different PCIe controllers to different CPU cores.
> > > > > > > > > > 
> > > > > > > > > > Several other drivers use irq_set_chained_handler_and_data().  Do any
> > > > > > > > > > of them need similar changes?  The commit log suggests that using
> > > > > > > > > > chained IRQ handlers breaks affinity support.  But perhaps that's not
> > > > > > > > > > the case and the real culprit is some other difference between mvebu
> > > > > > > > > > and the other drivers.
> > > > > > > > > 
> > > > > > > > > And there is another reason to not use irq_set_chained_handler_and_data
> > > > > > > > > and instead use devm_request_irq(). Armada XP has some interrupts
> > > > > > > > > shared and it looks like that irq_set_chained_handler_and_data() API
> > > > > > > > > does not handle shared interrupt sources too.
> > > > > > > > > 
> > > > > > > > > I can update commit message to mention also this fact.
> > > > > > > > 
> > > > > > > > Anything needed from me to improve this fix?
> > > > > > > 
> > > > > > > My impression from Marc's response [1] was that this patch would
> > > > > > > "break the contract the kernel has with userspace" and he didn't think
> > > > > > > this was acceptable.  But maybe I'm not understanding it correctly.
> > > > > > 
> > > > > > This is argument which Marc use when he does not have any argument.
> > > > > > 
> > > > > > Support for dedicated INTx into pci-mvebu.c was introduced just recently
> > > > > > and I used irq_set_chained_handler_and_data() just because I thought it
> > > > > > is a good idea and did not know about all those issues with it. So there
> > > > > > cannot be any breakage by this patch.
> > > > > > 
> > > > > > I already converted other pci-aardvark.c driver to use
> > > > > > irq_set_chained_handler_and_data() API because wanted it... But at the
> > > > > > end _that conversion_ caused breakage of afinity support and so this
> > > > > > conversion had to be reverted:
> > > > > > https://lore.kernel.org/linux-pci/20220515125815.30157-1-pali@kernel.org/#t
> > > > > > 
> > > > > > Based on his past decisions, above suggestions which cause _real_
> > > > > > breakage and his expressions like mvebu should be put into the trash,
> > > > > > I'm not going to listen him anymore. The only breaking is done by him.
> > > > > > 
> > > > > > 
> > > > > > There are two arguments why to not use irq_set_chained_handler_and_data:
> > > > > > 
> > > > > > 1) It does not support afinity and therefore has negative performance
> > > > > >    impact on Armada platforms with more CPUs and more PCIe ports.
> > > > > > 
> > > > > > 2) It does not support shared interrupts and therefore it will break
> > > > > >    hardware on which interrupt lines are shares (mostly Armada XP).
> > > > > > 
> > > > > > So these issues have to be fixed and currently I see only option to
> > > > > > switch irq_set_chained_handler_and_data() to devm_request_irq() which I
> > > > > > did in this fixup patch.
> > > > > 
> > > > > Any progress here? This patch is waiting here since end of May and if
> > > > > something is going to be broken then it is this fact of ignoring reported
> > > > > issues and proposed patch. Do you better solution how to fix commit
> > > > > ec075262648f?
> > > > 
> > > > After two weeks I'm reminding this fix patch again...
> > > 
> > > There is no point complaining about something you were asked
> > > to change, really - there is not.
> > > 
> > > You were given feedback, feel free to ignore it, it won't help
> > > getting this patch upstream - it is as simple as that, sorry.
> > > 
> > > Thanks,
> > > Lorenzo
> > 
> > I'm not sure if I understand you, what do you mean that all patches
> > which depends on this are now automatically rejected or what?
> 
> I am not merging this code unless it is acked by an IRQ maintainer.
> 
> Is it clear enough ?
> 
> Thanks,
> Lorenzo

So, could you then propose a solution how to fix this issue to allow one
interrupt to be shared with more devices, like it is needed for some
Armada platforms? Because I do not see a way how to do it without
IRQF_SHARED and without shared interrupt it is not possible to implement
any other pending features.

I'm feeling that since May there is just conclusion that all development
on the mvebu must be stopped as more people here do not like this
hardware and trying to do remove it or at least make it orphan.
