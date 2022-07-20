Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8799357BF3F
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jul 2022 22:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiGTUhL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Jul 2022 16:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiGTUhJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jul 2022 16:37:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B69418E1E;
        Wed, 20 Jul 2022 13:37:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12ACE61CBB;
        Wed, 20 Jul 2022 20:37:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4630DC3411E;
        Wed, 20 Jul 2022 20:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658349427;
        bh=7PpBRv20MvSwwE36jMplF6JP0iKXxREOK8LZEaor688=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jMAx2T3KOeZbhoBtYHqIwmEVTobmpeXTtp999f/G+GjFUkZPwlQBR+OBog38tBgJU
         q1LOLTUmlq6cBIZmoM7azA/nb0LXgzjM3AV/YmfrZOAZI+THEjnWIfOgAPfx7AQWXc
         5BCjiLggpScM0Zx1Ml7T5/hCU7TTOw+U0rMkAyV2DRHHK81ZQrLninPD15othpv4HB
         2VWsRzC11A7tk9m/n28R4+d2liQywt8OB4SvK2x4FdvRqBTAjSFCYKmCV9s/ZqOXMx
         D1XIGIT1Ci3jMSu05hNJxs93f3TRymkZFCwpfaWboobEzGH2BpMyWUR6/wD+FGwts4
         1FtgbYp8na7iQ==
Date:   Wed, 20 Jul 2022 15:37:05 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
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
Message-ID: <20220720203705.GA1654821@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718224033.GA1450714@bhelgaas>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 18, 2022 at 05:40:33PM -0500, Bjorn Helgaas wrote:
> On Mon, Jul 18, 2022 at 01:14:25PM -0500, Bjorn Helgaas wrote:
> > ...
> 
> > So I think brcm_pcie_setup() does initialization that doesn't depend
> > on the link or any downstream devices, and brcm_pcie_start_link() does
> > things that depend on the link being up.  Right?
> > 
> > If so, "start_link" might be a slight misnomer since AFAICT
> > brcm_pcie_start_link() doesn't do anything to initiate link-up except
> > maybe deasserting fundamental reset.  Some drivers start the LTSSM or
> > explicitly enable link training, but brcm_pcie_start_link() doesn't
> > seem to do anything like that.
> > 
> > brcm_pcie_start_link() still does brcm_pcie_set_outbound_win().  Does
> > that really depend on the link being up?  If that only affects the
> > Root Port, maybe it could be done before link-up?
> 
> What about the /* PCIe->SCB endian mode for BAR */ thing?  Does that
> depend on the link being up?
> 
> And the "Refclk from RC should be gated with CLKREQ#" part?  Does that
> depend on the link being up?
> 
> It seems obvious that brcm_pcie_set_ssc() and reading the negotiated
> link speed and width depend on the link being up.

Can we close on this?  Splitting into

  (a) stuff that can be initialized before the link is available and
  (b) stuff that depends on the link

makes good sense, but then (b) should only contain stuff that actually
depends on the link.

The "PCIe->SCB endian mode for BAR" *sounds* like something related to
the primary side of the RP, not the link.

Not sure about "Refclk from RC".  RC would certainly be primary side,
but ASPM has to do with secondary (link) side.

Bjorn
