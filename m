Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F624DA3E6
	for <lists+linux-pci@lfdr.de>; Tue, 15 Mar 2022 21:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244786AbiCOUXr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Mar 2022 16:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241737AbiCOUXq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Mar 2022 16:23:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2341138BF4;
        Tue, 15 Mar 2022 13:22:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B41FA60ADC;
        Tue, 15 Mar 2022 20:22:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB780C340EE;
        Tue, 15 Mar 2022 20:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647375753;
        bh=0ut9v8Mofhd/tDzKnf+CcR23DD7IKhRDy7v5nmBCQRs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=QSX4VnegdduIPQ4gZD4KPnc7tYVCALT6gbLR4n2oxiLXu8TC0gn3fNF2mjlEaaNPU
         PFNwEFFoB6RoHY7prjq/OeRY+Xym5US9MnVzdmfY8u7uLVVSr5VAXcm6JW8wklQagU
         oQC8VrspRe1pVoHw8opM6drZhiOLb/eCIPbOHh7HXZdB0wl1aQNHEW/DndgeULJINr
         6ipaC17b9LCDSVTSOErcvcUqjUQq0kci9XdrXbon7/q/IVkS0AqS6xwXDuwNOV/UBY
         1imP6DMySbw3eDWF7z2q79RDZuHnWJTmBAtRJmqWELwBt+seMzAVZ9P7fN3DDjbaUk
         wLSStbBQ4Bn9w==
Date:   Tue, 15 Mar 2022 15:22:31 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, micklorain@protonmail.com
Subject: Re: [PATCH v1 1/1] PCI: Enable INTx quirk for ATI PCIe-USB adapter
Message-ID: <20220315202231.GA629970@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjBlxOi0ljZVUb/D@smile.fi.intel.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 15, 2022 at 12:09:08PM +0200, Andy Shevchenko wrote:
> On Mon, Mar 14, 2022 at 02:42:53PM -0500, Bjorn Helgaas wrote:
> > On Mon, Mar 14, 2022 at 12:14:48PM +0200, Andy Shevchenko wrote:
> > > ATI PCIe-USB adapter advertises MSI, but it doesn't work if INTx is disabled.
> > > Enable the respective quirk as it's done for other ATI devices on this chipset,
> > > 
> > > Fixes: 306c54d0edb6 ("usb: hcd: Try MSI interrupts on PCI devices")
> > 
> > This is interesting because there must be a TON of these AMD/ATI SB600
> > USB devices in the field, and 306c54d0edb6 was merged in July 2020 and
> > appeared in v5.9.
> > 
> > So why would we only get a report now, in February 2022?  Is there
> > some change more recent than 306c54d0edb6 that exposed this problem?
> 
> I think it's a rhetorical question. To me it's as simple as the latency
> between getting the change into the kernel.
> 
> However, I'm a bit worried that in case of ATI there are not so many
> platforms that are kept up-to-dated.

This would be a rhetorical question if I were not interested in the
answer but asking only to make a point.  That's not the case at all.

If these SB600 USB devices stopped working in v5.9 (October 2020),
that would affect lots of keyboards and mice, and I would be surprised
if we didn't hear about it until February, 2022.

I looked through https://github.com/linuxhw/Dmesg, and there are at
least 40 dmesg logs from v5.9 or later with SB600 USB, so I'm
still a little skeptical that 306c54d0edb6 by itself is enough to
explain this.

Anyway, I applied this to pci/msi for v5.18 with the following commit
log:

    PCI: Disable broken MSI on ATI SB600 USB adapters

    Some ATI SB600 USB adapters advertise MSI, but MSI doesn't work if INTx is
    disabled.  Disable MSI on these adapters.

