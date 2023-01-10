Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580C8664C02
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jan 2023 20:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238633AbjAJTIt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Jan 2023 14:08:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239762AbjAJTIF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jan 2023 14:08:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9179C50;
        Tue, 10 Jan 2023 11:07:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53389B8190F;
        Tue, 10 Jan 2023 19:07:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C50DEC433D2;
        Tue, 10 Jan 2023 19:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673377619;
        bh=eKDx6/7UM5d4qoCpKpkITo2Y2vuGHUHSweyrqBBkDnA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=pitb+W8kp27pZe6SW4oL+RySe7zgBy8l5P9d4SAQdoA2BEFlDJ9VkLt9p9XJauuhV
         fPIkrzIOrMHO+lQhxXbQ3Rzj3y6dWDx+TzTAUpEwwNvK6KBf/0O4YbY5m1FMXCDGR6
         E3a8/qFrDzj1doePt4W/uzhJX9OaEzUrV0vxIevSouCihXuejO3d9k77XXkEaQcjwK
         5xaLWp+QMiR4ybyXyL2qYIDswT/Qi2rC4ve08Sh3dEjqtKRGc8Y8eEe/61h3jyhjt6
         LgO8LtRrEy3eVWODVuYbmcmVK5BYkXwIJpf9j7rHHXXAMi749GMKM/FbA7t32ZxJeG
         bcO3DtodL56BA==
Date:   Tue, 10 Jan 2023 13:06:57 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
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
        "Sun, Yunying" <yunying.sun@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>
Subject: Re: Bug report: the extended PCI config space is missed with 6.2-rc2
Message-ID: <20230110190657.GA1600529@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2287772.ElGaqSPkdT@kreacher>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 10, 2023 at 07:12:42PM +0100, Rafael J. Wysocki wrote:
> On Friday, January 6, 2023 11:04:49 PM CET Bjorn Helgaas wrote:
> ...
> > The below should work better.
> > 
> > commit 696ac9286d3d ("x86/pci: Treat EfiMemoryMappedIO as reservation of ECAM space")
> > parent 1b929c02afd3
> > Author: Bjorn Helgaas <bhelgaas@google.com>
> > Date:   Thu Jan 5 16:02:58 2023 -0600
> > 
> >     x86/pci: Treat EfiMemoryMappedIO as reservation of ECAM space
> >     
> >     Normally we reject ECAM space unless it is reported as reserved in the E820
> >     table or via a PNP0C02 _CRS method (PCI Firmware, r3.3, sec 4.1.2).  This
> >     means extended config space (offsets 0x100-0xfff) may not be accessible.
> >     
> >     Some firmware doesn't report ECAM space via PNP0C02 _CRS methods, but does
> >     mention it as an EfiMemoryMappedIO region via EFI GetMemoryMap(), which is
> >     normally converted to an E820 entry by a bootloader or EFI stub.
> >     
> >     07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map"), removes
> >     E820 entries that correspond to EfiMemoryMappedIO regions because some
> >     other firmware uses EfiMemoryMappedIO for PCI host bridge windows, and the
> >     E820 entries prevent Linux from allocating BAR space for hot-added devices.
> >     
> >     Allow use of ECAM for extended config space when the region is covered by
> >     an EfiMemoryMappedIO region, even if it's not included in E820 or PNP0C02
> >     _CRS.
> >     
> >     Fixes: 07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map")
> >     Link: https://lore.kernel.org/r/ac2693d8-8ba3-72e0-5b66-b3ae008d539d@linux.intel.com
> 
> This prints quite a few debug-level messages to dmesg.  I guess you'll post an
> update with fewer of them?

Right, this was a debugging patch.

> In any case, please feel free to add
> 
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>

Thanks!
