Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6A762790E
	for <lists+linux-pci@lfdr.de>; Mon, 14 Nov 2022 10:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236361AbiKNJda (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 04:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235793AbiKNJd3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 04:33:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E26201;
        Mon, 14 Nov 2022 01:33:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 024B360F73;
        Mon, 14 Nov 2022 09:33:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5134AC433C1;
        Mon, 14 Nov 2022 09:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668418407;
        bh=xBEmvul305KuRTR5GwRcsRPjBTiZ9IoINVfB5XKqns0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V9dr3TdYwNbJ7vc1SZAifWvm9ynh+mHMrcoORJR+wZblXFT65PiC3pGxT6kIxOKKn
         PtylzfhLV5PlnT/2hHOgEM92e8DrAdaT6R5Hfkp9XtrkOjEVFbqG3W84FSx4pxHXms
         6NYWrmcaR4YBekI6fsusuwyIguiYTcWLd7Xmdo7fDDSU3zavIu5TDglJqKnhjWEIyK
         6uuHX4vs2754WFDURa82nskGgqClNG0az3IuoEx0wkmRpy2tK1Xe0crKW8y1aOWcDy
         nlUoAKmUZFJdUlhx0E5VjnBl73igLshZN+oxhYuZeVPR/TiRze0JA0g/jeQRdaeFSc
         5SO7Iw/dv86+Q==
Date:   Mon, 14 Nov 2022 10:33:21 +0100
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Helgaas <helgaas@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: mvebu: Use devm_request_irq() for registering
 interrupt handler
Message-ID: <Y3ILYUTbJl1hN481@lpieralisi>
References: <20220709234430.GA489657@bhelgaas>
 <20220710000659.vxmlsvoin26tdiqw@pali>
 <20220829165109.fzrgguchg4otbbab@pali>
 <20220911154516.tu2b7qhsnk6mdtui@pali>
 <Yx7nXJRHN1sWCkVq@lpieralisi>
 <20220912084808.mmi42l7sp657dz6i@pali>
 <Yx70E4nBtKoVVmhO@lpieralisi>
 <20220912090306.fto5k3rj6jrbq3rj@pali>
 <Y25GhJuzInbEz0vs@lpieralisi>
 <20221111171514.zw7esq4ahmefvojr@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221111171514.zw7esq4ahmefvojr@pali>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 11, 2022 at 06:15:14PM +0100, Pali Rohár wrote:

[...]

> > > So, could you then propose a solution how to fix this issue to allow one
> > > interrupt to be shared with more devices, like it is needed for some
> > > Armada platforms? Because I do not see a way how to do it without
> > > IRQF_SHARED and without shared interrupt it is not possible to implement
> > > any other pending features.
> > > 
> > > I'm feeling that since May there is just conclusion that all development
> > > on the mvebu must be stopped as more people here do not like this
> > > hardware and trying to do remove it or at least make it orphan.
> > 
> > Marc gave you a solution - we are going round in circles, it is getting
> > boring, honestly.
> > 
> > https://lore.kernel.org/linux-pci/874k0bf7f7.wl-maz@kernel.org
> 
> This is not the solution. As this does not allow to share one interrupt
> by multiple devices / drivers, like devm_request_irq with IRQF_SHARED
> flag. irq_set_chained_handler_and_data() can be used only by one device.
> This was expressed more times in other threads, but seems it was
> ignored.
> 
> In past I have already send patches for armada interrupt drivers and
> they were rejected by Marc, who did not wanted to talk about them. And
> in past already expressed that he is not interested in any more
> development in Armada HW as by thinks it is broken hardware and his
> devel board stopped working.
> 
> I'm really not going to implement anything new for people who already
> expressed that would reject my contribution. Why would I do it?

Because that's the only way you can get this done, that's how it works,
I can't merge code that the respective maintainer finds unacceptable.

> Anyway, here we are dealing with REGRESSION in mainline kernel. Not a
> new feature. Mainline kernel is currently broken and this my patch is
> fixing it. Exactly same fix was already applied for other pci controller
> driver.
> 
> Why it is disallowed to fix regression in kernel with exactly same
> approach and same patch which was allowed for other drivers? Because it
> really looks like that somebody is trying to ensure that Linux kernel
> should stop working on existing hardware.

Your impression is wrong - please reconsider it. The goal is to remove
the unacceptable code from the kernel not adding to it to create even
more broken legacy. It is not against this patch or HW, it is against
this same code that there is pushback, there are no strings attached.

> > Either you implement what he asks for or I drop this patch and all
> > dependent ones from the PCI queue - apologies.
> > 
> > Lorenzo
> 
> So, please if you are going to drop patch series, and you do not like my
> fix for mentioned issue, could you please fix the driver to work in
> mainline kernel?

It is not that I don't like it, I expressed the reason why I can't merge
it above.

I can't fix it for you.

> Do not take me wrong, but it is really problem if mainline kernel is
> broken, developers like Greg are publicly talking that vendors,
> distributors and other should update kernels to new versions and not
> stay on the old one; and then other developers are rejecting fixes to
> regression in new versions and basically are saying that people and
> vendors should not upgrade kernels to new versions as it would stop
> working on some hardware.
> 
> And I'm not even mentioned that there happened lot of other development
> and cleanup in this area and everything is stopped and maybe now after
> 2 years would discarded, like some developers want as they do not like
> some kind of hardware.

See above, let's close this argument.

> I'm really disappointed that I have to discuss about such thing.

So am I :)

> If fixing regressions and bugs is not a priority for kernel and is first
> subject to rewrite other parts of code and implement couple of new
> features, then I think it is a good idea to stop being doing
> development.

Don't twist it that way, I think we have been clear on the matter.

Lorenzo
