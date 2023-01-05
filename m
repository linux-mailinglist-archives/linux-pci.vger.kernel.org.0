Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18F765F521
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jan 2023 21:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235444AbjAEUX3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Jan 2023 15:23:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235286AbjAEUX2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Jan 2023 15:23:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B84C6338A;
        Thu,  5 Jan 2023 12:23:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0824361C21;
        Thu,  5 Jan 2023 20:23:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 411B3C433F0;
        Thu,  5 Jan 2023 20:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672950206;
        bh=FIfxMl/MEG5bk0JUtoAVlSmA7pBb8INFQCFomPkOSgU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jviNP1dRQ/Boul30ZlWwseIubbN//VU9CL5VMazCkB6Uh1DGfBZVzWHZSIffQSnkG
         sa/RHpzAGfA3GN3h+nSpOKBs2qirSbOPywsPebSX9Tcn7czTcvmRpVyrrRdo45kU0H
         r3hxrpYGvKUd/2T+7IeYiFa9l5ghfQiQG+77KZx1++gG1uWC1pYU6IrmQAUdnU1p7o
         8CP54tlKt98pmkk/ZwYS8P3e4sSt9mVEDlSwCkU3R9+iMInt+ve0/WNlKnjhtihnza
         WE3ZWON21/S3ZHWsf7CzB67tJ4HG3+jqRDzKkq5PaEUdcxl4yWNZFuO7S5/AGYBv7G
         kKnGXoJlGl++g==
Date:   Thu, 5 Jan 2023 14:23:24 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "kernelorg@undead.fr" <kernelorg@undead.fr>,
        "kjhambrick@gmail.com" <kjhambrick@gmail.com>,
        "2lprbe78@duck.com" <2lprbe78@duck.com>,
        "nicholas.johnson-opensource@outlook.com.au" 
        <nicholas.johnson-opensource@outlook.com.au>,
        "benoitg@coeus.ca" <benoitg@coeus.ca>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "wse@tuxedocomputers.com" <wse@tuxedocomputers.com>,
        "mumblingdrunkard@protonmail.com" <mumblingdrunkard@protonmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Box, David E" <david.e.box@intel.com>,
        "Sun, Yunying" <yunying.sun@intel.com>
Subject: Re: Bug report: the extended PCI config space is missed with 6.2-rc2
Message-ID: <20230105202324.GA1165237@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63b7289cb7439_5174129445@dwillia2-xfh.jf.intel.com.notmuch>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 05, 2023 at 11:44:28AM -0800, Dan Williams wrote:
> Bjorn Helgaas wrote:

> > Apparently the only mention of [mem 0x80000000-0x8fffffff] in the
> > firmware/kernel interface is as an EfiMemoryMappedIO region.
> > 
> > I think this is a firmware bug, but obviously we're going to have to
> > figure out a way around it.
> 
> Definitely an ambiguity / conflict, but not sure it is a bug when you
> look at from the perspective of how would an EFI runtime service use
> ECAM/MMCONFIG space? 

I think it's perfectly fine for firmware to advertise ECAM space as an
EfiMemoryMappedIO region via EFI GetMemoryMap() because it certainly
makes sense that EFI runtime services would use config space.

My understanding is that the OS should learn about device address
space via ACPI _CRS, not GetMemoryMap().  The MCFG spec (PCI Firmware
Spec, r3.3, sec 4.1.2) requires ECAM space to be reserved via a
PNP0C02 motherboard device _CRS.

So what I think *is* a bug is that this firmware doesn't report the
ECAM space via PNP0C02 _CRS.

If somebody thinks the lack of this reservation is not a bug, I would
love to hear ideas about how Linux *should* be handling this.  There
are many variations on how firmware does things like this, and it's
been a nightmare trying to figure out something that works with all of
them.

> Would it be enough to add this clarification in "EFI 2.9 Table 7-6
> Memory Type Usage after ExitBootServices()"?
> 
> s/This memory is not used by the OS./This memory is not used by the OS,
> unless ACPI declares it for another purpose./

I guess the idea is that MCFG is a form of "ACPI declaring it"?  I
don't have an explicit citation for it, but I infer at [1] that ACPI
static tables are second-class citizens and not intended as a way of
reserving address space because that would lead to problems booting
old OSes on firmware that provides new tables unknown to the OS.

Bjorn

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/PCI/acpi-info.rst?id=v6.1#n32
