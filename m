Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5EF5BB10F
	for <lists+linux-pci@lfdr.de>; Fri, 16 Sep 2022 18:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiIPQXJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Sep 2022 12:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiIPQXI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Sep 2022 12:23:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A89B6569
        for <linux-pci@vger.kernel.org>; Fri, 16 Sep 2022 09:23:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5348062CCA
        for <linux-pci@vger.kernel.org>; Fri, 16 Sep 2022 16:23:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6358C433C1;
        Fri, 16 Sep 2022 16:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663345386;
        bh=v5HJNIOU5xWbCFd0rGpuOhpj9GLTczU7qj0YbyVeTpo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tHz69b0EPqA/WimaFqLFFTQ+ylfwduePCLEQylvlkZCKSlUvxgOk4iitsPD9H3EBZ
         br6SWP1/qwzAPTSUqV8fZxrheZOwUNOxhKie8uiH+wytpma9M1nFUZZOZE2VLIHE9y
         8gBnDTw3sIosn2GDwoROCD1YktyK9iHQhr0IOrROtUE1GqOU4szLKHo+jj0INiEXvY
         5T0r2Qk3/Zg5+Xu9ciKQox9XOMewEYEaGyFSNF7kSX/XrNMQN15XNwXkEJLgsA+NyT
         Aj+MhO+1X3AZCbep/o277DFVJmlerpl4cMpBDSu2WLW0EiPhm71V8Hv2jNusnDD4gt
         rqxnJd+zuIoRg==
Date:   Fri, 16 Sep 2022 18:23:02 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
        pali@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        tglx@linutronix.de
Subject: Re: [PATCH 03/11] PCI: aardvark: Add support for DLLSC and hotplug
 interrupt
Message-ID: <20220916182302.4eba1b48@dellmb>
In-Reply-To: <YxtUR0+dBZut8QZH@lpieralisi>
References: <20220818135140.5996-1-kabel@kernel.org>
        <20220818135140.5996-4-kabel@kernel.org>
        <YxtUR0+dBZut8QZH@lpieralisi>
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 9 Sep 2022 16:57:11 +0200
Lorenzo Pieralisi <lpieralisi@kernel.org> wrote:

> [+Marc, Thomas - I can't merge this code without them reviewing it,
> I am not sure at all you can mix the timer/IRQ code the way you do]
>=20
> On Thu, Aug 18, 2022 at 03:51:32PM +0200, Marek Beh=C3=BAn wrote:
> > From: Pali Roh=C3=A1r <pali@kernel.org>
> >=20
> > Add support for Data Link Layer State Change in the emulated slot
> > registers and hotplug interrupt via the emulated root bridge.
> >=20
> > This is mainly useful for when an error causes link down event. With
> > this change, drivers can try recovery.
> >=20
> > Link down state change can be implemented because Aardvark supports Link
> > Down event interrupt. Use it for signaling that Data Link Layer Link is
> > not active anymore via Hot-Plug Interrupt on emulated root bridge.
> >=20
> > Link up interrupt is not available on Aardvark, but we check for whether
> > link is up in the advk_pcie_link_up() function. By triggering Hot-Plug
> > Interrupt from this function we achieve Link up event, so long as the
> > function is called (which it is after probe and when rescanning).
> > Although it is not ideal, it is better than nothing. =20
>=20
> So before even coming to the code review: this patch does two things.
>=20
> 1) It adds support for handling the Link down state
> 2) It adds some code to emulate a Link-up event
>=20
> Now, for (2). IIUC you are adding code to make sure that an HP
> event is triggered if advk_pcie_link_up() is called and it
> detects a Link-down->Link-up transition, that has to be notified
> through an HP event.
>=20
> If that's correct, you have to explain to me please what this is
> actually achieving and a specific scenario where we want this to be
> implemented, in fine details; then we add it to the commit log.

Hello Lorenzo, sorry for not replying earlier.

Would something like this be sufficient?

  DLLSC is needed by the pciehp driver, which handles hotplug, but also
  link state change events. AFAIK no Aardvark devices support hotplug,
  but link state change events are required for graceful driver
  unbinding in case of link down event.

  So with this change we achieve graceful driver unbind for example
  when WiFi card PCIe link goes down (we've seen this with ath10k and
  mt76 WiFi cards). Before the WiFi driver started spitting out errors,
  or even taking the whole system down.

  Since after link goes down, it can come back up if the WiFi card can
  recover (or if reset pin is used to reset the card), we need to be
  able to recognize link up event. Since AFAIK Aardvark does not have
  interrupt for link up event, the best thing we can do is simulate it
  - whenever we read the link state, find it is up, and have cached
  value saying it is down, we trigger the link up event. We read link
  state whenever the configuration space is read, for example by
  writing 1 to /sys/bus/pci/rescan.

Marek
