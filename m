Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECFC74AFF43
	for <lists+linux-pci@lfdr.de>; Wed,  9 Feb 2022 22:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbiBIVgn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Feb 2022 16:36:43 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:45282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233507AbiBIVgm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Feb 2022 16:36:42 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD55C102FD8;
        Wed,  9 Feb 2022 13:36:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A9CE1CE2299;
        Wed,  9 Feb 2022 21:36:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F57C340E7;
        Wed,  9 Feb 2022 21:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644442600;
        bh=eNht/WhgzI8HFTOVd2yW6iJsHrqt1HK/5VYfUBwQ1uM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=JUwNLoEq61UWVbFsZ2V+yv+PvSSsVPz5tNr5QxdlYhj22VaLg9iAVui4YIh8tapzj
         iLN54K9XL2kynxSnFzf0FOkYC9ggxOw+OeE/RiAn5kXrCmEx1QU5iP8rBtFvhd7YDO
         i8AGWJv5HGyHDgCLutrG1D9MHBCO+Nbj8iDk6PXaRu5VjiUlD5B6STNGV0mHSL2U23
         3m1NvYk567QRt4Blysx3IKfXJlEnX9xMoc9zUNdoBIsIjg8Ahgdd4izuV64XPVXR9x
         BitoHIZmPT6A+wGbRUhZx4xUGgp7vY5JAJAspX+GK4xBdWRsovJ4sP+JFUahq2gjWt
         Yz8czzi7mY4tA==
Date:   Wed, 9 Feb 2022 15:36:38 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Keith Busch <kbusch@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] PCI: vmd: Honor ACPI _OSC on PCIe features
Message-ID: <20220209213638.GA587920@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gUFY8fFKFhqmRHLKvaRA7mqDwkx7q=7soSGmu51dSD_Q@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 07, 2021 at 02:15:04PM +0100, Rafael J. Wysocki wrote:
> On Tue, Dec 7, 2021 at 12:12 AM Keith Busch <kbusch@kernel.org> wrote:
> > On Fri, Dec 03, 2021 at 11:15:41AM +0800, Kai-Heng Feng wrote:
> > > When Samsung PCIe Gen4 NVMe is connected to Intel ADL VMD, the
> > > combination causes AER message flood and drags the system performance
> > > down.
> > >
> > > The issue doesn't happen when VMD mode is disabled in BIOS, since AER
> > > isn't enabled by acpi_pci_root_create() . When VMD mode is enabled, AER
> > > is enabled regardless of _OSC:
> > > [    0.410076] acpi PNP0A08:00: _OSC: platform does not support [AER]
> > > ...
> > > [    1.486704] pcieport 10000:e0:06.0: AER: enabled with IRQ 146
> > >
> > > Since VMD is an aperture to regular PCIe root ports, honor ACPI _OSC to
> > > disable PCIe features accordingly to resolve the issue.
> >
> > At least for some versions of this hardare, I recall ACPI is unaware of
> > any devices in the VMD domain; the platform can not see past the VMD
> > endpoint, so I throught the driver was supposed to always let the VMD
> > domain use OS native support regardless of the parent's ACPI _OSC.
> 
> This is orthogonal to whether or not ACPI is aware of the VMD domain
> or the devices in it.
> 
> If the platform firmware does not allow the OS to control specific
> PCIe features at the physical host bridge level, that extends to the
> VMD "bus", because it is just a way to expose a hidden part of the
> PCIe hierarchy.

I don't understand what's going on here.  Do we understand the AER
message flood?  Are we just papering over it by disabling AER?

If an error occurs below a VMD, who notices and reports it?  If we
disable native AER below VMD because of _OSC, as this patch does, I
guess we're assuming the platform will handle AER events below VMD.
Is that really true?  Does the platform know how to find AER log
registers of devices below VMD?

> The platform firmware does that through ACPI _OSC under the host
> bridge device (not under the VMD device) which it is very well aware
> of.
