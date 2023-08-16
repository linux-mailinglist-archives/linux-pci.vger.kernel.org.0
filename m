Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50FEC77E715
	for <lists+linux-pci@lfdr.de>; Wed, 16 Aug 2023 18:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345006AbjHPQ5v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Aug 2023 12:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345015AbjHPQ5e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Aug 2023 12:57:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E51E4C;
        Wed, 16 Aug 2023 09:57:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8C4E6593B;
        Wed, 16 Aug 2023 16:57:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC411C433C9;
        Wed, 16 Aug 2023 16:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692205052;
        bh=jmZaFGRk0mUd7Pn/E+CuctT0M3zhRkLYEdXtN8lsMhA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=k7vQ/PV8S4TL0HpkpHGVy1moEfw91SCl+jhhNMzthED0X0dSObwAvzdZXwsLxri+d
         a2RYh7SyPZQchgqYquk8pX8uEzL3+20Qw6xrffbWzwt/s43/IoSnR9L8xNIQ55rbkJ
         hOpFQ2vo//Pi8co9yutR7F3b9ZfQE5Z8+DyOPZ6bKdueexcOujBQDZ/qElezZPciUq
         zXg1ZCus/o7jhJ/xfQTqTWN3aOKuBtWtpci2NkUnmL96hjDQFbb1GGEd2VN0IK/DE1
         Xjb63h8Jg9Kt7hMiVn33cqYbhi+/FMoZM11JjiamkfcaDJJISevOiIMAezkTS7iwAJ
         8fiT1gAYsncRw==
Date:   Wed, 16 Aug 2023 11:57:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Iain Lane <iain@orangesquash.org.uk>,
        Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH v11 2/9] ACPI: Adjust #ifdef for *_lps0_dev use
Message-ID: <20230816165729.GA291397@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88d86ba9-d21e-4284-847c-3b0d99cc2403@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 15, 2023 at 01:32:05PM -0500, Mario Limonciello wrote:
> On 8/15/2023 13:28, Bjorn Helgaas wrote:
> > On Wed, Aug 09, 2023 at 01:54:46PM -0500, Mario Limonciello wrote:
> > > The #ifdef currently is guarded against CONFIG_X86, but these are
> > > actually sleep related functions so they should be tied to
> > > CONFIG_ACPI_SLEEP.
> > > 
> > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > ---
> > > v9->v10:
> > >   * split from other patches
> > > ---
> > >   include/linux/acpi.h | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> > > index 0d5277b7c6323..13a0fca3539f0 100644
> > > --- a/include/linux/acpi.h
> > > +++ b/include/linux/acpi.h
> > > @@ -1100,7 +1100,7 @@ void acpi_os_set_prepare_extended_sleep(int (*func)(u8 sleep_state,
> > >   acpi_status acpi_os_prepare_extended_sleep(u8 sleep_state,
> > >   					   u32 val_a, u32 val_b);
> > > -#ifdef CONFIG_X86
> > > +#if defined(CONFIG_ACPI_SLEEP) && defined(CONFIG_X86)
> > 
> > What's the connection to CONFIG_ACPI_SLEEP?
> > 
> > The acpi_register_lps0_dev() implementation in
> > drivers/acpi/x86/s2idle.c is under #ifdef CONFIG_SUSPEND (and
> > obviously s2idle.c is only compiled at all if CONFIG_X86).
> > 
> > Both callers (amd_pmc_probe() and thinkpad_acpi_module_init()) are
> > under #ifdef CONFIG_SUSPEND.
> 
> My thought process was that s2idle.c is from drivers/acpi/x86 and only can
> be used in the context of ACPI enabled sleep.
> 
> But I could see the argument for CONFIG_SUSPEND being stronger.  I'll adjust
> and make sure the rest of the series works with CONFIG_SUSPEND.

It's very hard to verify that it's correct if the declaration is under
a different #ifdef than the implementation, whereas it's trivial if it
uses the same #ifdef.

Bjorn
