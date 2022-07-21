Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A9957D0C6
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jul 2022 18:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbiGUQKU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jul 2022 12:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbiGUQKT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2022 12:10:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AACFD36;
        Thu, 21 Jul 2022 09:10:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 574CCB8259F;
        Thu, 21 Jul 2022 16:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A13C341CE;
        Thu, 21 Jul 2022 16:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658419814;
        bh=zjEMXxvQfsb7nOkZ6WVZ/odfEb3wozMXvOYlBekZ6gA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=XxIXrS3HIIKOKkGycN0c93jk/96JsOl5hmSGPiTEpF3eLDb9gTevw6jtwszfSoDro
         RrbC6SLOStxwUzGWa7v94cs7xpAkG4GSumD5tSUeyQdHHrDTP/sK5zswYvwzSDT/5h
         5XN4p9QSYWgdvR4cgKXPQONld0/EN0pTBLRj3Mh8puX6vPpPMMRkIg1js9ybBPLOPN
         3E83BYNlalWK/l+1KqAfQ1rHgbB1ausOpakX+qlPgyI4VAFv0dW6KV6Spm/heicwAB
         odXTFriKVie4M2pXlndqjErPjbB4rjMyRyZlQbKtstKVnmjWvXvpYy5JmPm4oVmapB
         BVG7UnISXkaHw==
Date:   Thu, 21 Jul 2022 11:10:13 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/6] PCI: brcmstb: Split brcm_pcie_setup() into two
 funcs
Message-ID: <20220721161013.GA1725073@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+-6iNyAXEYT=pc-i0RgtA2njD3f6yELNppJqy733c7O_rmgUg@mail.gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 21, 2022 at 10:56:53AM -0400, Jim Quinlan wrote:
> On Wed, Jul 20, 2022 at 4:37 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Mon, Jul 18, 2022 at 05:40:33PM -0500, Bjorn Helgaas wrote:
> > > On Mon, Jul 18, 2022 at 01:14:25PM -0500, Bjorn Helgaas wrote:
> > > > ...
> > >
> > > > So I think brcm_pcie_setup() does initialization that doesn't depend
> > > > on the link or any downstream devices, and brcm_pcie_start_link() does
> > > > things that depend on the link being up.  Right?
> > > >
> > > > If so, "start_link" might be a slight misnomer since AFAICT
> > > > brcm_pcie_start_link() doesn't do anything to initiate link-up except
> > > > maybe deasserting fundamental reset.  Some drivers start the LTSSM or
> > > > explicitly enable link training, but brcm_pcie_start_link() doesn't
> > > > seem to do anything like that.
> > > >
> > > > brcm_pcie_start_link() still does brcm_pcie_set_outbound_win().  Does
> > > > that really depend on the link being up?  If that only affects the
> > > > Root Port, maybe it could be done before link-up?
> > >
> > > What about the /* PCIe->SCB endian mode for BAR */ thing?  Does that
> > > depend on the link being up?
> > >
> > > And the "Refclk from RC should be gated with CLKREQ#" part?  Does that
> > > depend on the link being up?
> > >
> > > It seems obvious that brcm_pcie_set_ssc() and reading the negotiated
> > > link speed and width depend on the link being up.
> >
> > Can we close on this?  Splitting into
>
> Absolutely.
> 
> >   (a) stuff that can be initialized before the link is available and
> >   (b) stuff that depends on the link
> >
> > makes good sense, but then (b) should only contain stuff that actually
> > depends on the link.
> >
> > The "PCIe->SCB endian mode for BAR" *sounds* like something related to
> > the primary side of the RP, not the link.
> >
> > Not sure about "Refclk from RC".  RC would certainly be primary side,
> > but ASPM has to do with secondary (link) side.
> 
> I get the feedback, submission coming soon -- I was waiting for the
> email thread to conclude.

I don't expect a new posting of the patches in response to every
question, but hopefully this is a conversation that goes both ways,
and there's no need to slow down the conversation.  It's more than
acceptable to simply ask and answer questions and post updated patches
later.  We're running out of runway and I want to make sure we get
this thing done this cycle.

Bjorn
