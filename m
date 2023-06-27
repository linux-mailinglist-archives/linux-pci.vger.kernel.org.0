Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1A6740555
	for <lists+linux-pci@lfdr.de>; Tue, 27 Jun 2023 22:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjF0Uyk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Jun 2023 16:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjF0UyZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Jun 2023 16:54:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D1F2D5E;
        Tue, 27 Jun 2023 13:54:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E1436121C;
        Tue, 27 Jun 2023 20:54:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E0BC433C0;
        Tue, 27 Jun 2023 20:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687899259;
        bh=Hm7z216rqQnH0e76SmK/867WJ1BfQMPcC4F8hcTa9sU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=cmhnsAm9UK6vinJK/y9SQBdq+D9uSOgpviNaSwMXfaatRhJonaAxyraewZfD6Kxgp
         Sj0NRblbxmgRpuof9UzGIQxmU04L1WPmjRjZEFuLD+06Gx70gadjYmYaK2OxpJvXWS
         sUpr8wU1ng3sOfx8E4AWYO907Rka0txowsRmlup23DMXjQK7NzONbAs6OGrNMRUNx+
         2KBaUO3uie3pIjKl0yH8nWEkamXc1sQUqpzPtuvsic6eN42dsYyM9muh/3srI6PmeD
         tEQoH/qy9uJZG13/euXH4skC3CbJyO5NZfnDrnRKWYtPj1jRKfuhpb0/3Bzlwm7nk8
         u7pQzowrNcbmg==
Date:   Tue, 27 Jun 2023 15:54:17 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        bhelgaas@google.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Michael Bottini <michael.a.bottini@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/ASPM: Enable ASPM on external PCIe devices
Message-ID: <20230627205417.GA366405@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAd53p4kH7E92++jabBhvsM_+M7Dpyk2JP+aoVdb_sxZn47eyQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 27, 2023 at 04:35:25PM +0800, Kai-Heng Feng wrote:
> On Fri, Jun 23, 2023 at 7:06 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Tue, Jun 20, 2023 at 01:36:59PM -0500, Limonciello, Mario wrote:
> > > <snip>
> > > > > A variety of Intel chipsets don't support lane width switching
> > > > > or speed switching.  When ASPM has been enabled on a dGPU,
> > > > > these features are utilized and breakage ensues.
> > > >
> > > > Maybe this helps explain all the completely unmaintainable ASPM
> > > > garbage in amdgpu and radeon.
> > > >
> > > > If these devices are broken, we need quirks for them.
> > >
> > > The problem is which device do you consider "broken"?
> > > The dGPU that uses these features when the platform advertises ASPM
> > > or the chipset which doesn't support the features that the device
> > > uses when ASPM is active?
> > >
> > > With this problem I'm talking about the dGPU works fine on hosts
> > > that support these features.
> >
> > Without more details about what's broken and when, I can't say.  What
> > I *think* is that a device that doesn't work per spec needs a quirk.
> > Typically it's a device that advertises a capability that doesn't work
> > correctly.
> 
> Many silicon vendors use the same "PCI IP" and integrate it into their
> own chip. That's one of the reason why the capability doesn't really
> reflect what actually being support.
> The vendors then send their private datasheet to system integrator so
> BIOS can enable what's really supported.

It's perfectly fine for the IP to support PCI features that are not
and can not be enabled in a system design.  But I expect that
strapping or firmware would disable those features so they are not
advertised in config space.

If BIOS leaves features disabled because they cannot work, but at the
same time leaves them advertised in config space, I'd say that's a
BIOS defect.  In that case, we should have a DMI quirk or something to
work around the defect.

> So the logic is to ignore the capability and trust the default set
> by BIOS.

I think limiting ASPM support to whatever BIOS configured at boot-time
is problematic.  I don't think we can assume that all platforms have
firmware that configures ASPM as aggressively as possible, and
obviously firmware won't configure hot-added devices at all (in
general; I know ACPI _HPX can do some of that).

It's possible we need some kind of policy that limits ASPM to the BIOS
config until date X, but I don't want to limit that forever.

> > > If you follow my idea of hot added devices the policy follows
> > > the parent would it work for the i225 PCIe device case?
> >
> > That doesn't *sound* really robust to me because even if the default
> > config after hot-add works, the user can change things via sysfs, and
> > any configuration we set it to should work as well.  If there are
> > land-mines there, we need a quirk that prevents sysfs from running
> > into it.
> 
> For this case it means driver needs to provide a ASPM callback to flip
> PTM based on ASPM sysfs.

I'm not sure I follow this, but it sounds like you're saying PTM
doesn't work correctly with some ASPM configurations.  Is this allowed
by the PCIe spec or is it a hardware defect?  If the latter, maybe we
just need a quirk to disable PTM on the device.

I'm not sure PTM is valuable enough to add a generic callback
mechanism to work around a defect in an individual device.

Bjorn
