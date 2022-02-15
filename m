Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6C84B70D7
	for <lists+linux-pci@lfdr.de>; Tue, 15 Feb 2022 17:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237848AbiBOPJy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Feb 2022 10:09:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbiBOPJy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Feb 2022 10:09:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C7B24BCE;
        Tue, 15 Feb 2022 07:09:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB19361563;
        Tue, 15 Feb 2022 15:09:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF293C340EB;
        Tue, 15 Feb 2022 15:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644937782;
        bh=rQRzKiWjUEky441SM9VPj2LOw9hR96TVsT711jhkyb0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=CXP0rEBrVkzFiRZeDgYjn/z85zqqkvPxVs1Zg02Ic84H/tmLzroXhvXVJipIGcgcn
         Pe4nloYCPt+YsC2XrN5rhBXqzvsVSnpk3L+CbCHtaKBkExYFT3xfEJycVe7XsgW3A2
         2Gx1pBjJxjjEV1MLyAHmIArBJ+wI01dWa+wKjHlSFCOcuy6P3wGWsemyhCSThNDC8c
         7KC7s0k/P8lbTMwO4RW/DP8jBuYVoX/mC93BarWSlDdy1wDN2wZleW8DfGUWpAt4PT
         hrIS/csTdZ0nbk+eU4QIOgsccjVTRuH9SMyT37PW1+STNiu/aMnREhQNWkEa2UYMjF
         20XbDO+rzoxvg==
Date:   Tue, 15 Feb 2022 09:09:39 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Keith Busch <kbusch@kernel.org>,
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
Message-ID: <20220215150939.GA106706@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAd53p6hATV8TOcJ9Qi2rMwVi=y_9+tQu6KhDkAm6Y8=cQ_xoA@mail.gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 14, 2022 at 08:23:05AM +0800, Kai-Heng Feng wrote:
> On Thu, Feb 10, 2022 at 5:36 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Tue, Dec 07, 2021 at 02:15:04PM +0100, Rafael J. Wysocki wrote:
> > > On Tue, Dec 7, 2021 at 12:12 AM Keith Busch <kbusch@kernel.org> wrote:
> > > > On Fri, Dec 03, 2021 at 11:15:41AM +0800, Kai-Heng Feng wrote:
> > > > > When Samsung PCIe Gen4 NVMe is connected to Intel ADL VMD, the
> > > > > combination causes AER message flood and drags the system performance
> > > > > down.
> > > > >
> > > > > The issue doesn't happen when VMD mode is disabled in BIOS, since AER
> > > > > isn't enabled by acpi_pci_root_create() . When VMD mode is enabled, AER
> > > > > is enabled regardless of _OSC:
> > > > > [    0.410076] acpi PNP0A08:00: _OSC: platform does not support [AER]
> > > > > ...
> > > > > [    1.486704] pcieport 10000:e0:06.0: AER: enabled with IRQ 146
> > > > >
> > > > > Since VMD is an aperture to regular PCIe root ports, honor ACPI _OSC to
> > > > > disable PCIe features accordingly to resolve the issue.
> > > >
> > > > At least for some versions of this hardare, I recall ACPI is unaware of
> > > > any devices in the VMD domain; the platform can not see past the VMD
> > > > endpoint, so I throught the driver was supposed to always let the VMD
> > > > domain use OS native support regardless of the parent's ACPI _OSC.
> > >
> > > This is orthogonal to whether or not ACPI is aware of the VMD domain
> > > or the devices in it.
> > >
> > > If the platform firmware does not allow the OS to control specific
> > > PCIe features at the physical host bridge level, that extends to the
> > > VMD "bus", because it is just a way to expose a hidden part of the
> > > PCIe hierarchy.
> >
> > I don't understand what's going on here.  Do we understand the AER
> > message flood?  Are we just papering over it by disabling AER?
> 
> To be more precise, AER is disabled by the platform vendor in BIOS to
> paper over the issue.
> The only viable solution for us is to follow their settings. We may
> never know what really happens underneath.
> 
> Disabling ASPM/AER/PME etc is a normal practice for ODMs unfortunately.

OK.  So this patch actually has nothing in particular to do with AER.
It's about making _OSC apply to *all* devices below a host bridge,
even those below a VMD.

This is slightly ambiguous because while "_OSC applies to the entire
hierarchy originated by a PCI Host Bridge" (PCI Firmware spec r3.3,
sec 4.5.1), vmd.c creates a logical view where devices below the VMD
are in a separate hierarchy with a separate domain.

The interpretation that _OSC applies to devices below VMD should work,
as long as it is possible for platform firmware to manage services
(AER, pciehp, etc) for things below VMD without getting in the way of
vmd.c.

But I think one implication of this is that we cannot support
hot-added VMDs.  For example, firmware that wants to manage AER will
use _OSC to retain AER control.  But if the firmware doesn't know how
VMDs work, it will not be able to handle AER for devices below the
VMD.

> > If an error occurs below a VMD, who notices and reports it?  If we
> > disable native AER below VMD because of _OSC, as this patch does, I
> > guess we're assuming the platform will handle AER events below VMD.
> > Is that really true?  Does the platform know how to find AER log
> > registers of devices below VMD?
> >
> > > The platform firmware does that through ACPI _OSC under the host
> > > bridge device (not under the VMD device) which it is very well aware
> > > of.
