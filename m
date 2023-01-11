Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8167466663A
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jan 2023 23:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236292AbjAKWbG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Jan 2023 17:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236111AbjAKWa7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jan 2023 17:30:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08F35F48;
        Wed, 11 Jan 2023 14:30:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A94461EE7;
        Wed, 11 Jan 2023 22:30:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6359AC433EF;
        Wed, 11 Jan 2023 22:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673476257;
        bh=KUi1HGeABxjWRsu8PJIH+JwPcZ8NI+ELZCnpYlQMHT4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Kf0tL8z6062nMukSXj1bvr1p2+gTipJIIAonn6AF+NvYFqLCjffe3AnTHerJKON4X
         4XlVyqh7SbpnYnHGKCJbqki8pLXtRRlMGXCjRA2bX1+cAM/MWZh6Y2PqP5kOi4P8aA
         TAU6ux9d7GP3M2hHkNjcAdghPQeR+OEVwmJoRHDZOUGGdb0Wsf01iMHwJfU8Zms/5z
         E4yextY1IkFAA1H7ZGLXLOvrYvuC6m2qjKYBlQwvzX8m3JRi3zg/98ASwD1hvhjIEP
         7EzqVSMkcUU0QWS7IPBmijS7p9sO2De9edsnyvU/9V/1m7ZblnP86jQCSVw1BazflW
         zALJ7OVhpjOEw==
Date:   Wed, 11 Jan 2023 16:30:55 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Dan J Williams <dan.j.williams@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        David E Box <david.e.box@intel.com>,
        Yunying Sun <yunying.sun@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Hans de Goede <hdegoede@redhat.com>,
        Florent DELAHAYE <linuxkernelml@undead.fr>,
        Konrad J Hambrick <kjhambrick@gmail.com>,
        Matt Hansen <2lprbe78@duck.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Benoit =?iso-8859-1?Q?Gr=E9goire?= <benoitg@coeus.ca>,
        Werner Sembach <wse@tuxedocomputers.com>,
        mumblingdrunkard@protonmail.com, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/2] PCI: Fix extended config space regression
Message-ID: <20230111223055.GA1712775@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110180243.1590045-1-helgaas@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 10, 2023 at 12:02:41PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> 07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map") appeared
> in v6.2-rc1 and broke extended config space on several machines.
> 
> This broke drivers that use things in extended config space, e.g., perf,
> VSEC telemetry, EDAC, QAT, etc.
> 
> This happened because mmconfig-shared.c checks to see that ECAM space is
> reserved in E820 or ACPI motherboard resources.  If it's not, it assumes
> ECAM doesn't work.  07eab0901ede removed some E820 entries, so it looked
> like ECAM was no longer reserved, so we stopped using it.
> 
> The machines where this broke don't reserve the ECAM in ACPI PNP0C02
> devices (which seems to be what the PCI Firmware spec requires), but they
> do mention it in the EFI memory map as EfiMemoryMappedIO.
> 
> Bjorn Helgaas (2):
>   x86/pci: Simplify is_mmconf_reserved() messages
>   x86/pci: Treat EfiMemoryMappedIO as reservation of ECAM space
> 
>  arch/x86/pci/mmconfig-shared.c | 44 +++++++++++++++++++++++++++++-----
>  1 file changed, 38 insertions(+), 6 deletions(-)

Applied to for-linus for v6.2.  Sorry for the breakage and thank you
very much for the debugging and testing help!
