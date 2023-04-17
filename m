Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9566E5409
	for <lists+linux-pci@lfdr.de>; Mon, 17 Apr 2023 23:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjDQVlu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Apr 2023 17:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbjDQVlu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Apr 2023 17:41:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC865BA7;
        Mon, 17 Apr 2023 14:41:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 678FF622AE;
        Mon, 17 Apr 2023 21:41:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 989E9C433D2;
        Mon, 17 Apr 2023 21:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681767680;
        bh=zwSRHL7ia0cXc0WBv9dvwcdxlWGC4zBtxTop1dSNYPk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BZYR+QYjlaOb8ePdTFcn/eLhe3xwTb+cYq+quPwgRwGOmQucQabJYPajz0AfLQwTy
         gllUtHWvaUFC/tyjCTKLdQ7oHfbysQkCsdk608LTZbx8vqcD6/hesMBfdBGMAsUkZe
         0sRTQw5yPyz5oQDNOynhCOfomFNjsQmKuNJ0WC9v98o2HfyD8vxpeUlkTMj+5qtrAA
         7qGYdfWJ6a7kgeiiemL/KEbUlTqLTchU0BapdSAm0hjrgaea3zmCh3rvCKdS5jT4Bu
         wggtRWJhEGqtAzAlgy1NMkcyJ8vSno7KgSa4XWIRSvEwdIJpzMDUbGH2p58VXwXju+
         EYKBETTkZHa9Q==
Date:   Mon, 17 Apr 2023 16:41:19 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] PCI: brcmstb: CLKREQ# accomodations of downstream
 device
Message-ID: <20230417214119.GA53173@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3a1271b-3faf-0900-d8e4-2ded0230f461@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 14, 2023 at 01:33:29PM -0700, Florian Fainelli wrote:
> On 4/14/23 13:27, Bjorn Helgaas wrote:
> > On Tue, Apr 11, 2023 at 12:59:17PM -0400, Jim Quinlan wrote:
> ...

> > > The HW+driver is able to tell us when mode (a) mode is needed.  But there
> > > is no easy way to tell if L1SS mode should be configured.  In certain
> > > situations, getting this wrong may cause a panic during boot time.  So we
> > > rely on the DT prop "brcm,enable-l1ss" to tell us when mode (c) is desired.
> > > Using this mode only makes sense when the downstream device is L1SS-capable
> > > and the OS has been configured to activate L1SS
> > > (e.g. policy==powersupersave).
> > 
> > I'm really concerned about the user experience here.  I assume users
> > do not want to edit the DT based on what device they plug in.  They
> > shouldn't need to (and probably won't) know whether the device
> > supports L1SS.
> > 
> > I hate kernel/module parameters, but I think even that would be better
> > then having to edit the DT.
> 
> The problem I see with kernel/module parameters is that it is really hard to
> differentiate whether they should be applied across all instances of the
> device/drivers or just for one in particular.
> 
> The Raspberry Pi 4 is a single pcie-brcmstb instance, but we have other
> systems supported by that driver on Set-top-box and Cable Modem chips for
> instance where we may have different types of end-points being connected,
> some of which could be Multi-chip-module (MCM) where everything is known
> ahead of time, and sometimes cards that are plugged to full-sized PCIe or
> mini-PCIe connectors, where some amount of runtime discoverability is
> involved.
> 
> Without inventing some custom modular parameter syntax, it may not work that
> well. The Device Tree properties at least easily allow for per-instance
> configuration.

We do have this already (from
Documentation/admin-guide/kernel-parameters.txt):

        pci=option[,option...]  [PCI] various PCI subsystem options.

                                Some options herein operate on a specific device
                                or a set of devices (<pci_dev>). These are
                                specified in one of the following formats:

                                [<domain>:]<bus>:<dev>.<func>[/<dev>.<func>]*
                                pci:<vendor>:<device>[:<subvendor>:<subdevice>]

                                Note: the first format specifies a PCI
                                bus/device/function address which may change
                                if new hardware is inserted, if motherboard
                                firmware changes, or due to changes caused
                                by other kernel parameters. If the
                                domain is left unspecified, it is
                                taken to be zero. Optionally, a path
                                to a device through multiple device/function
                                addresses can be specified after the base
                                address (this is more robust against
                                renumbering issues).  The second format
                                selects devices using IDs from the
                                configuration space which may match multiple
                                devices in the system.
