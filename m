Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E636C243A
	for <lists+linux-pci@lfdr.de>; Mon, 20 Mar 2023 23:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjCTWIJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Mar 2023 18:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjCTWII (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Mar 2023 18:08:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E23E7AB3
        for <linux-pci@vger.kernel.org>; Mon, 20 Mar 2023 15:08:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33FACB80EFD
        for <linux-pci@vger.kernel.org>; Mon, 20 Mar 2023 22:08:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBCB8C433D2;
        Mon, 20 Mar 2023 22:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679350084;
        bh=HJfe6VIpPYczDri/DoUe5fjKAHK6Phe7nesOsamBdLg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=CQs1vuJ9WEmzUF/2OpMXSdcunvB3Lnn21M9IaYw/AWVAdX1Ze/dShV9hyl1UAGqK0
         X1KdCqkDk+SM6o8FNyVGzmR4pfGSDbg5qpTgZ8v2xpjviuOkKCsv0sOTKaVZZAi5OL
         5AJ+eC4JTOPj6kw2q7VwrHOkQLTzRjzJj4LYhNhao1L3XN4guRtmBG61qjPUaFyHlN
         wEAhR6l2XcgjQ8ZJbXE2tTQ2a37B/fqI5B/hjhwUn0Mr6+VJX+cDXE+WynQ9VWH0Tl
         SgTeuggWcpABCDN9oWsEsAbUrVD42AUVkxRz6J23VJ77cVHmAaKcXjoOdwq/TumrCW
         FRBtOhzKUQXtg==
Date:   Mon, 20 Mar 2023 17:08:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "thomas@glanzmann.de" <thomas@glanzmann.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PCI: Add quirk to clear MSI-X
Message-ID: <20230320220802.GA2326747@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81c13f51-45ee-76da-b780-96ce636ac187@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 20, 2023 at 04:37:17PM -0500, Limonciello, Mario wrote:
> > > When I say "BIOS" I mean collectively "all" of this firmware.
> > 
> > I don't understand the point you're making here.  I don't think it
> > matters whether this device-specific knowledge is in APU
> > microcontroller firmware, BIOS, Linux, etc.
> > 
> > I'm trying to suggest that if we zoom all the way in and look just at
> > the PCIe TLPs, we would see two config writes that put the device in
> > D3hot, then back in D0.  A working device should end up either back in
> > D0active with MSI-X fully enabled (if No_Soft_Reset is set and MSI-X
> > was originally enabled), or in D0uninitialized (if No_Soft_Reset is
> > clear).
> > 
> > But with this device, apparently some additional software intervention
> > is required, i.e., after the config write to go back to D0, we need
> > two more writes to clear and set the MSI-X enable bit.
> 
> My point is that's only needed if the hardware wasn't initialized correctly.
> If it's initialized properly then it behaves like you expect.

So is this something that BIOS must initialize, and then it's locked
so that by the time Linux shows up, this one-time initialization can
no longer be done?

If Linux *could* do this one-time initialization, and subsequent
D0/D3hot transitions worked per spec, that would be awesome because we
wouldn't have to worry about making sure we run the quirk at every
possible transition.

> > Let's say somebody runs coreboot on this platform.  Does coreboot need
> > this device-specific knowledge?
> 
> Yes; the exact same bug will happen with a coreboot implementation that had
> the initialization done improperly.

My claim is that this means the device doesn't conform to the spec.

If we add a conforming PCI device that neither the OS nor the firmware
has ever seen before, standard generic functionality like power
management should just work.

Bjorn
