Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA3C4DAF37
	for <lists+linux-pci@lfdr.de>; Wed, 16 Mar 2022 12:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355500AbiCPLxf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Mar 2022 07:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355502AbiCPLx2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Mar 2022 07:53:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72EC65829;
        Wed, 16 Mar 2022 04:52:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D146616E3;
        Wed, 16 Mar 2022 11:52:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C437C340E9;
        Wed, 16 Mar 2022 11:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647431532;
        bh=YIXNbeLlceKzi8tGJMsF0FSZC0BtIxsHH/dOGJwT3vo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=eKM0V6/6SZPbobuGuYihJZagDFL2cWeBBa6cb8AgOtGOyj28kepg59L6FR9shoG7B
         ggj9FT4PjlZwfKAAaphsQW5cJ34FqycaQ8ba6ZQuBmGBEdmzdN/JT9JEGX8QDe34nR
         8ndPhY8OH7WXKUnnqLCqjt3FXbCfWe9b1vDmSvqcxHSST4MtFJwxGhVPMcyrBfHIY6
         M5f3Hdkajmnwz+NksW+p9t8ngSZTku3YOgr1dbLSVALyITTGNx+fDYZVHgu+Z+wDyU
         /MYYpaBpGxSny2QRCT8NSIasxPg6iKWeWiFs/bTeBcvMJ6GTwiF9SgpdQyi/LWbMF/
         Hz+Qt4RP/KzZg==
Date:   Wed, 16 Mar 2022 06:52:09 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, micklorain@protonmail.com
Subject: Re: [PATCH v1 1/1] PCI: Enable INTx quirk for ATI PCIe-USB adapter
Message-ID: <20220316115209.GA666450@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjG7rZ11PP3vWz89@smile.fi.intel.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 16, 2022 at 12:27:57PM +0200, Andy Shevchenko wrote:
> On Tue, Mar 15, 2022 at 03:22:31PM -0500, Bjorn Helgaas wrote:
> > On Tue, Mar 15, 2022 at 12:09:08PM +0200, Andy Shevchenko wrote:
> > > On Mon, Mar 14, 2022 at 02:42:53PM -0500, Bjorn Helgaas wrote:
> > > > On Mon, Mar 14, 2022 at 12:14:48PM +0200, Andy Shevchenko wrote:
> > > > > ATI PCIe-USB adapter advertises MSI, but it doesn't work if INTx is disabled.
> > > > > Enable the respective quirk as it's done for other ATI devices on this chipset,
> > > > > 
> > > > > Fixes: 306c54d0edb6 ("usb: hcd: Try MSI interrupts on PCI devices")
> > > > 
> > > > This is interesting because there must be a TON of these AMD/ATI SB600
> > > > USB devices in the field, and 306c54d0edb6 was merged in July 2020 and
> > > > appeared in v5.9.
> > > > 
> > > > So why would we only get a report now, in February 2022?  Is there
> > > > some change more recent than 306c54d0edb6 that exposed this problem?
> > > 
> > > I think it's a rhetorical question. To me it's as simple as the latency
> > > between getting the change into the kernel.
> > > 
> > > However, I'm a bit worried that in case of ATI there are not so many
> > > platforms that are kept up-to-dated.
> > 
> > This would be a rhetorical question if I were not interested in the
> > answer but asking only to make a point.  That's not the case at all.
> > 
> > If these SB600 USB devices stopped working in v5.9 (October 2020),
> > that would affect lots of keyboards and mice, and I would be surprised
> > if we didn't hear about it until February, 2022.
> > 
> > I looked through https://github.com/linuxhw/Dmesg, and there are at
> > least 40 dmesg logs from v5.9 or later with SB600 USB, so I'm
> > still a little skeptical that 306c54d0edb6 by itself is enough to
> > explain this.
> > 
> > Anyway, I applied this to pci/msi for v5.18 with the following commit
> > log:
> > 
> >     PCI: Disable broken MSI on ATI SB600 USB adapters
> > 
> >     Some ATI SB600 USB adapters advertise MSI, but MSI doesn't work if INTx is
> >     disabled.  Disable MSI on these adapters.
> 
> But IIUC MSI is _not_ disabled. That's why I have issued this version of the
> patch with different commit message. Did I misunderstand something?

Oh, right, of course.  Sorry, I was asleep at the wheel.

I guess it's just that for these devices, we don't disable INTx when
enabling MSI.  I can't remember why we disable INTx when enabling MSI,
but it raises the question of whether it's better to leave INTx
enabled or to just disable use of MSI completely.

Bjorn
