Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969A57748AC
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 21:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236385AbjHHTgy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Aug 2023 15:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236468AbjHHTg1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 15:36:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193BB20368
        for <linux-pci@vger.kernel.org>; Tue,  8 Aug 2023 12:01:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A578B62AA6
        for <linux-pci@vger.kernel.org>; Tue,  8 Aug 2023 19:01:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E20C433C7;
        Tue,  8 Aug 2023 19:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691521313;
        bh=0ae5G6tSj0OL+A3GFu495JUE3nYM/DD41GwOWh8tmi8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gyot/I+786CqzBjykEQ7hKwGnDiU/pzJTJEKXsEoQHJACD/Pj7vhjp6kMLFxe7GSU
         ZYimKAr8l2yUiPm+jUpCrVZ5DRnqMcsbipZo7tARAlaTCDu3cH0d1+OEwH+ggBHrYx
         97gXlDtdpUhQhN6lpl2ZHm9H8Sofk9lMUpObDPEBEXiJnCAHyxVYx9nCP6IrKwlt4X
         qLSH1E7rvtVyqAJ7lQXX53elXB8DXyGPbX+oHNAp5U1IQ6lp74Ky31viZFvScG7pfs
         pPcDAwfWbRXBT6V585kh0br8O8fVuBSPRdEO94DLcIbThEDCphZPX41D3Ecpc8/e9P
         o3itsQxL0qQ+w==
Received: by pali.im (Postfix)
        id DDD45687; Tue,  8 Aug 2023 21:01:49 +0200 (CEST)
Date:   Tue, 8 Aug 2023 21:01:49 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: mvebu: Mark driver as BROKEN
Message-ID: <20230808190149.ewjmbqt7altvngn2@pali>
References: <ZMzicVQEyHyZzBOc@shell.armlinux.org.uk>
 <20230804170655.GA147757@bhelgaas>
 <20230808073154.bstm3xwtjalyq3qb@pali>
 <20230808080159.cjffiewenmazhrgx@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230808080159.cjffiewenmazhrgx@pengutronix.de>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 08 August 2023 10:01:59 Uwe Kleine-König wrote:
> Hello Pali,
> 
> On Tue, Aug 08, 2023 at 09:31:54AM +0200, Pali Rohár wrote:
> > On Friday 04 August 2023 12:06:55 Bjorn Helgaas wrote:
> > > I queued up the revert below, including a note in the Kconfig help
> > > text about the known issues.
> > > 
> > > commit 814b6bb15367 ("Revert "PCI: mvebu: Mark driver as BROKEN"")
> > > Author: Bjorn Helgaas <bhelgaas@google.com>
> > > Date:   Fri Aug 4 11:54:43 2023 -0500
> > > 
> > >     Revert "PCI: mvebu: Mark driver as BROKEN"
> > >     
> > >     b3574f579ece ("PCI: mvebu: Mark driver as BROKEN") made it impossible to
> > >     enable the pci-mvebu driver.  The driver does have known problems, but as
> > >     Russell and Uwe reported, it does work in some configurations, so removing
> > >     it broke some working setups.
> > >     
> > >     Revert b3574f579ece so pci-mvebu is available.  Mention the known problems
> > >     in the Kconfig help text.
> > >     
> > >     Reported-by: Russell King (Oracle) <linux@armlinux.org.uk>
> > >     Link: https://lore.kernel.org/r/ZMzicVQEyHyZzBOc@shell.armlinux.org.uk
> > >     Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > >     Link: https://lore.kernel.org/r/20230804134622.pmbymxtzxj2yfhri@pengutronix.de
> > >     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > > 
> > 
> > What you are trying to achieve with this patch now?
> 
> We all agree that there are problems with the pci-mvebu driver. But to
> my knowledge it works in some configurations. So I guess the thing to
> achieve here is to go from "broken for everyone" (with the driver
> depending on BROKEN) to "broken for only some people". So in my view
> it's an improvement.

There is no improvement. I do not see any patch, suggestion or other
contribution or discussion how to at least start doing anything in this
area.

> > Do you think that it is really correct to show that everything is
> > working for everybody correctly?
> 
> What makes you think Bjorn considers everything to work fine? Both the
> commit log and the added help text suggest he's aware of problems.

Where it is written? There is nothing which instruct majority of
distributions that there are problems about which they should be aware.

Simple revert without any indication is not a solution.

> > Now I'm starting understand why majority of HW industry say to not use
> > "unsupported mainline kernel" and instead use our prepared patched
> > kernels...
> 
> Yes, for a given company it's the easiest and cheapest option to just
> support a single kernel version. In this regard the patch adding the
> dependency on BROKEN is even worse than the commit that removes it
> again. In an ideal world Marvell would care to work on the issues of
> their hardware's drivers or at least provide enough documentation to the
> folks who care about these drivers. I guess we both know we're not in
> that ideal world.

Now I perfectly understand Marvell, why they do not want to do it.
Now after 3 years I see how the whole development in PCI works.

> I wonder what's your objective problem with this revert. You can just
> keep PCI_MVEBU disabled, so it doesn't affect the machines you care
> about.  You might get some mail with complaints that the driver is
> broken in some configuration. But without this revert you might get
> (more?) complaints that the driver cannot be enabled. Is that any
> better?

Surprisingly I got less emails about problems since then.

> Best regards
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ |


