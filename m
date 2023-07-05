Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E61F748E8E
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jul 2023 22:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbjGEUGV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jul 2023 16:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbjGEUGU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jul 2023 16:06:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD11188;
        Wed,  5 Jul 2023 13:06:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8141616FB;
        Wed,  5 Jul 2023 20:06:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA81FC433C7;
        Wed,  5 Jul 2023 20:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688587579;
        bh=z5pOaz2o7vAP2YYNhfS0EUOnW70/UEHkLQ7tR3WqAaY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=TJPC1G02VrF+X/MQY3zvnWf6w99sv8SGZs9esbh15UwTqy6jsR65e63GQtj722Ga+
         sq/DUutey0colk4gWe6ebEUHNlsAzuvaAMfhFi48dzCaiPsgGA1nBM9bqPRdSOvBWQ
         2wuAP8qRvEJSBlQknfZWecUcsfm6SmBXo9yISo4Ce991HvVCsB9Gvojx/CkIoqYIPo
         dU9ELI48fKtEvId/VkyrFa4H/lvR2vO14QoutBBvhAN2as+ABkqX4wALhxwK/Vi2Ag
         y+QEdaIyU1c8hHh20mDzai1AswiWVRQy6XL3s+kRSwzExHpWC6f/jhrRDU4sc8QqWj
         jnfdHKJhlNhFg==
Date:   Wed, 5 Jul 2023 15:06:17 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, Vidya Sagar <vidyas@nvidia.com>,
        Michael Bottini <michael.a.bottini@linux.intel.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        intel-wired-lan@osuosl.org, bhelgaas@google.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [Intel-wired-lan] [PATCH] PCI/ASPM: Enable ASPM on external PCIe
 devices
Message-ID: <20230705200617.GA72825@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAd53p5YjKbOkzBUmhu=EctusO7d38tHhg_b+zzvfVt97hLuOA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 28, 2023 at 01:09:49PM +0800, Kai-Heng Feng wrote:
> On Wed, Jun 28, 2023 at 4:54 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Tue, Jun 27, 2023 at 04:35:25PM +0800, Kai-Heng Feng wrote:
> > > On Fri, Jun 23, 2023 at 7:06 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Tue, Jun 20, 2023 at 01:36:59PM -0500, Limonciello, Mario wrote:

> > It's perfectly fine for the IP to support PCI features that are not
> > and can not be enabled in a system design.  But I expect that
> > strapping or firmware would disable those features so they are not
> > advertised in config space.
> >
> > If BIOS leaves features disabled because they cannot work, but at the
> > same time leaves them advertised in config space, I'd say that's a
> > BIOS defect.  In that case, we should have a DMI quirk or something to
> > work around the defect.
> 
> That means most if not all BIOS are defected.
> BIOS vendors and ODM never bothered (and probably will not) to change
> the capabilities advertised by config space because "it already works
> under Windows".

This is what seems strange to me.  Are you saying that Windows never
enables these power-saving features?  Or that Windows includes quirks
for all these broken BIOSes?  Neither idea seems very convincing.

> > > So the logic is to ignore the capability and trust the default set
> > > by BIOS.
> >
> > I think limiting ASPM support to whatever BIOS configured at boot-time
> > is problematic.  I don't think we can assume that all platforms have
> > firmware that configures ASPM as aggressively as possible, and
> > obviously firmware won't configure hot-added devices at all (in
> > general; I know ACPI _HPX can do some of that).
> 
> Totally agree. I was not suggesting to limiting the setting at all.
> A boot-time parameter to flip ASPM setting is very useful. If none has
> been set, default to BIOS setting.

A boot-time parameter for debugging and workarounds is fine.  IMO,
needing a boot-time parameter in the course of normal operation is
not OK.

Bjorn
