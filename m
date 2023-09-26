Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0847AF208
	for <lists+linux-pci@lfdr.de>; Tue, 26 Sep 2023 19:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbjIZRzk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Sep 2023 13:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234911AbjIZRzj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Sep 2023 13:55:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60838120
        for <linux-pci@vger.kernel.org>; Tue, 26 Sep 2023 10:55:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6224C433C8;
        Tue, 26 Sep 2023 17:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695750932;
        bh=lkEslfpHFJOejPCis8PiWAyTpaGoKi32im5FR7jFJx8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=n5YPCAIHTnmW1FD4bOtkgnOUpykgsLjTEpT7DEgr03d28cV6YAhC6CXllVolejvfL
         6Sd37idQP/cTDjdpRs3jQT9X4hoWkHQniQksV5PD8Ipzq15gTik9ywKZGYY+yEFCEw
         EcwQDEVbsyRKpEvGp5bqWcQ2OJekkrOb1AVYGk+3goPtv9SuiwK34bYddI5HnHjGrJ
         Ma0dJiXRBR2qfGt8+5IcJ6T95tmK7HawiqphlthdC8hf1aZW1WG3Dxe2r+mVCnvfve
         AAgeEAh7FTLKLfBcLeEKWcBT1JZ36z4+Vxs/MShMQnTXLlh6YI917BJsGTHdNoDqs9
         jzpY95s/gyPhQ==
Date:   Tue, 26 Sep 2023 12:55:30 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Kamil Paral <kparal@redhat.com>, linux-pci@vger.kernel.org,
        regressions@lists.linux.dev, bhelgaas@google.com,
        chris.chiu@canonical.com
Subject: Re: [REGRESSION] resume with a Thunderbolt dock broke with commit
 e8b908146d44 "PCI/PM: Increase wait time after resume"
Message-ID: <20230926175530.GA418550@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925141930.GA21033@wunner.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 25, 2023 at 04:19:30PM +0200, Lukas Wunner wrote:
> On Mon, Sep 25, 2023 at 08:48:41AM -0500, Bjorn Helgaas wrote:
> > Now pciehp thinks the slot is occupied and the link is up, so we
> > re-enumerate the hierarchy.  Is this because thunderbolt did something
> > to 06:00.0 that made the link from 05:01.0 come up?
> 
> PCIe TLPs are encapsulated into Thunderbolt packets and transmitted
> alongside DisplayPort and other data over the same physical link.
> 
> For this to work, PCIe tunnels need to be set up between the Thunderbolt
> host controller and attached devices.  Once a tunnel is established,
> the PCIe link magically goes up and TLPs can be transmitted.
> 
> There are two ways to establish those tunnels:
> 
> 1/ By a firmware in the Thunderbolt host controller.
>    (firmware or "internal" connection manager, drivers/thunderbolt/icm.c)
> 
> 2/ Natively by the kernel.
>    (software connection manager)
> 
> I'm assuming that the laptop in question exclusively uses the firmware
> connection manager, hence the kernel is reliant on that firmware to
> establish tunnels and can't really do anything if it fails to do so.

Thanks for the background; that improves my meager understanding a
lot.

Since this seems to be a firmware issue, it does sound like this
laptop uses a firmware connection manager.  But there still seems to
be some kernel connection because pre-e8b908146d44, the link came up
in <5 seconds, and after the minor e8b908146d44 change, it takes >60
seconds.

I'm kind of at a loss here because I don't have a clear path forward.
What I'm hearing is that the real fix is a firmware update or a BIOS
setting change (Thunderbolt "user" instead of "secure" mode).

That is problematic for users, who will think resume got broken and
they don't know how to fix it.  It's problematic for me, because it
*looks* like a PCI issue and a PCI change exposed it, so I'll have to
deal with the reports.

Bjorn
