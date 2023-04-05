Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E45E6D87ED
	for <lists+linux-pci@lfdr.de>; Wed,  5 Apr 2023 22:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234487AbjDEUMn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Apr 2023 16:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234377AbjDEUMg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Apr 2023 16:12:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4987A87;
        Wed,  5 Apr 2023 13:12:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A40F762952;
        Wed,  5 Apr 2023 20:11:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADAFAC433EF;
        Wed,  5 Apr 2023 20:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680725509;
        bh=RtwX6KJxYQmKc5eE6Ge2DG54ynisAFNybPH8hjW2Myw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=dHKfeTPAenu64KkcwFR/WKz+RNZhtj4dMwwpBM3wvHCNU/ZTyHF9/pkW9hknVc0cZ
         w7fp/t1tuFEZE/K5DTqgSzyGrz1qcWh7zusMfq4giOpy8g4OyLvojp9PCs9I6WB4rK
         clFPb/fo8eu8ihkbsVTM4o62kBSyBDbIXU0jPgtBXm9exOFcJgVYeiMbQUYkfN6EK9
         XV0ezMaCDooYBPeJf/A5iyTsnCn5G67bVixFgikYhvxBzUA3VpHE5+iVnBVoFC2sqe
         xqiRjZGTB6oUN9IMzacEfdZ6ZznSh88QQVnCkDLmIu9+eOrCekx5YQQmw2U3RHRDgl
         zr5da0P/R5hug==
Date:   Wed, 5 Apr 2023 15:11:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Juergen Gross <jgross@suse.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-pci@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rich Felker <dalias@libc.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Miguel Ojeda <ojeda@kernel.org>,
        Matt Turner <mattst88@gmail.com>,
        Anatolij Gustschin <agust@denx.de>,
        "David S. Miller" <davem@davemloft.net>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v8 5/7] PCI: Allow pci_bus_for_each_resource() to take
 less arguments
Message-ID: <20230405201147.GA3637852@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZC1glzw4F9F8zCK+@smile.fi.intel.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 05, 2023 at 02:50:47PM +0300, Andy Shevchenko wrote:
> On Thu, Mar 30, 2023 at 07:24:32PM +0300, Andy Shevchenko wrote:
> > Refactor pci_bus_for_each_resource() in the same way as it's done in
> > pci_dev_for_each_resource() case. This will allow to hide iterator
> > inside the loop, where it's not used otherwise.
> > 
> > No functional changes intended.
> 
> Bjorn, this has wrong author in your tree:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=resource&id=46dbad19a59e0dd8f1e7065e5281345797fbb365

I botched it, sorry, should be fixed now.

Bjorn
