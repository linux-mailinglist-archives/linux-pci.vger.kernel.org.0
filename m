Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540E154B478
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jun 2022 17:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344128AbiFNPS4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jun 2022 11:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343593AbiFNPSz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jun 2022 11:18:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A9D2F38C;
        Tue, 14 Jun 2022 08:18:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D647B81983;
        Tue, 14 Jun 2022 15:18:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9EBFC3411C;
        Tue, 14 Jun 2022 15:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655219932;
        bh=J2nvep70ztufiXjK8zkqurUdHaOco9RVIdWlW0n//ik=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ZipO5ZUCf6/omUHuCtPPDid9mJmPTsQbtBfZJv3CZXICjksUqnCCcTqGd0Caj5S0Y
         er2IByOB7/FLY9qdimOGr/UILfocQXjY4bADekWWr7aKPuF34r/XJwbt2kf448nwiK
         viNdfrEyxe3GtZAEVGN9hIkgJnnSsLjTxRsB8SS/JyRoQ3RHVGcsFZOtrxbpmpRWTM
         iO9JPu2qKHF759X/LF5VjZzuf/nbgEmU46wlwuA57QGeJhTGsTlqPJYk/ZhXPWY/iX
         J9dVcNzzU5V6PB+vw/o0FAKkpG7rpBfszgE9g9sE0H5/1LCLppVXb0IeUHnmXE99TZ
         4O4CL1BXKDO5A==
Date:   Tue, 14 Jun 2022 10:18:50 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Ferry Toth <ftoth@exalondelft.nl>
Subject: Re: [PATCH v1 1/1] x86/PCI: Disable e820 usage for the resource
 allocation
Message-ID: <20220614151850.GA756316@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yqh3PtENhktETx4S@smile.fi.intel.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 14, 2022 at 02:55:42PM +0300, Andy Shevchenko wrote:
> On Mon, Jun 13, 2022 at 05:35:20PM -0500, Bjorn Helgaas wrote:
> > On Mon, Jun 13, 2022 at 11:16:41PM +0300, Andy Shevchenko wrote:
> > > The resource management improve for PCI on x86 broke booting of Intel MID
> > > platforms. It seems that the current code removes all available resources
> > > from the list and none of the PCI device may be initialized. Restore the
> > > old behaviour by force disabling the e820 usage for the resource allocation.
> > > 
> > > Fixes: 4c5e242d3e93 ("x86/PCI: Clip only host bridge windows for E820 regions")
> > > Depends-on: fa6dae5d8208 ("x86/PCI: Add kernel cmdline options to use/ignore E820 reserved regions")
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > Yeah, I blew it with 4c5e242d3e93.  Can you provide more details on
> > how the MID platforms broke?
> 
> It's not so easy. The breakage seems affects the console driver and earlycon
> doesn't work. erlyprintk doesn't support 32-bit MMIO addresses (again,
> addresses, not data size). That said, there is nothing to show at all.
> 
> What I did, I have bisected to your patch, commented out the call and instead
> added a printk() to see what it does, and it basically removed all resources
> listed in _CRS.
> 
> > Since you set "pci_use_e820 = false" for
> > MID below, I assume MID doesn't depend on the e820 clipping and thus
> > should not break if we turn off clipping by default in 2023 as in
> > 0ae084d5a674 ("x86/PCI: Disable E820 reserved region clipping starting
> > in 2023").
> 
> > But it'd be nice to see the dmesg log and make sure.
> 
> Nothing to provide (see above why), sorry.

A dmesg log with a working kernel, especially from one with Hans'
revert, which might have a little more logging about clipping, might
have enough info to help figure this out.

Bjorn
