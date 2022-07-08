Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B750056C2AD
	for <lists+linux-pci@lfdr.de>; Sat,  9 Jul 2022 01:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238365AbiGHTJR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Jul 2022 15:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238234AbiGHTJQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Jul 2022 15:09:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA02E1D30F;
        Fri,  8 Jul 2022 12:09:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 945F4B8293A;
        Fri,  8 Jul 2022 19:09:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9FA2C341C0;
        Fri,  8 Jul 2022 19:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657307353;
        bh=+NZEyFYPdbr8kXruv6m/Wp64ICTEZTxsYg+7/aEdf78=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gSBMHeCpq53HUAvj/h+EELkWExteN9Os8rQPs6jm/JxJQxzOrG9Qi5V0Dc6sJnIag
         VIqW7BjaGaD+VzWvr/V/+63lIFVnlBonGuhQvn29lK5IIvJteFeQrjnSzt/zl9kywM
         CphmN9BwhAiKUCUUpBk2g10G+TtL6Ibw18U9cGUodzgWAWmh38bPPtvTeF5h2WH1+i
         q5o0Maojf90EF0EkOGBxXUONQaxPxn/SDamY23ZYVvDLe4tDUJuiEhvBuacfE5rc9J
         ukhClWOuzy+ginFATtxnLQcXnNoUtKr889rpv+CrvOAtaciqfLKzQy+oEi3/4AyIfL
         HhPZ1VKsbtaKA==
Date:   Fri, 8 Jul 2022 14:09:11 -0500
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
        Philipp Zabel <p.zabel@pengutronix.de>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 3/4] PCI: brcmstb: Add control of subdevice voltage
 regulators
Message-ID: <20220708190911.GA366338@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+-6iNxg1sMrejizShy7iDhdhun7b_4Yo1OA43=FufkZ_W6iyA@mail.gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 08, 2022 at 11:16:08AM -0400, Jim Quinlan wrote:
> On Wed, Jul 6, 2022 at 7:13 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, Jul 01, 2022 at 12:27:24PM -0400, Jim Quinlan wrote:
> > > This Broadcom STB PCIe RC driver has one port and connects directly to one
> > > device, be it a switch or an endpoint.  We want to be able to leverage the
> > > recently added mechanism that allocates and turns on/off subdevice
> > > regulators.
> > > ...

> > > +      * If we have failed linkup there is no point to return an error as
> > > +      * currently it will cause a WARNING() from pci_alloc_child_bus().
> > > +      * We return 0 and turn on the "refusal_mode" so that any further
> > > +      * accesses to the pci_dev just get 0xffffffff
> > > +      */
> > > +     if (brcm_pcie_linkup(pcie) != 0)
> > > +             pcie->refusal_mode = true;
> >
> > Is there a bisection hole between the previous patch and this one?
> > The previous patch sets .add_bus() to pci_subdev_regulators_add_bus(),
> > so we'll turn on the regulators, but we don't know whether the link
> > came up.  If it didn't come up, it looks like we might get a CPU abort
> > when enumerating?
> 
> I don't think so.  At this commit, attempting the link-up is still
> done before the call
> to pci_host_probe().  Since there is no power there will be no link,
> the probe will
> fail and pci_host_probe() will never be invoked.

Ah, OK, thanks for the explanation.

> > I think we should split out the refusal_mode patch:
> >
> >   - Add refusal mode
> >   - Add subdev regulator mechanism
> >   - This patch (which would then be clearly about managing regulators
> >     in suspend/resume, IIUC)
> 
> Will do.

If it's not too hard to do, I think splitting it will make the patches
easier to read.

Bjorn
