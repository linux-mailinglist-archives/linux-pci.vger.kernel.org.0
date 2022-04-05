Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7964F4721
	for <lists+linux-pci@lfdr.de>; Wed,  6 Apr 2022 01:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241345AbiDEVAB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Apr 2022 17:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573102AbiDER7u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Apr 2022 13:59:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3F4E7F47
        for <linux-pci@vger.kernel.org>; Tue,  5 Apr 2022 10:57:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9CDF618B8
        for <linux-pci@vger.kernel.org>; Tue,  5 Apr 2022 17:57:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FDCEC385A0;
        Tue,  5 Apr 2022 17:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649181470;
        bh=nOJ3EvLRUQ250/Bw/PdfXlCFetOc/t/imqbP6MgSTg8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Ay7qlvUL+EgQia3WdKc35/ig/dgGvQUAqlYK485GIn6Qpt0XPHWsZtx2qN6u/w/s7
         Ehu2m+T2kV5KFmllhq+od5A5FH+moSmZyTqkIMJmJ1pDHm52HdknHSX7YGd8kpkeQJ
         SDmODydjaqchmdBOGRNC+5ElvbHvjvbJQ0poPIIvTsTu0bAZuK7BMt3unLTwDlh9zP
         fkjE1BY6klnFhrub+2/mGd01e1NEcrleg6UL34hkXmgA76bjUNUGNpZ125Gk7s8Hy+
         FCOPYhHcDVELUAgVBbzxRhl3KRxlXixa84xnmEwYKeVdxXXOhjDNqjMe4NYNbq4sGn
         zbExNU/G06d6w==
Date:   Tue, 5 Apr 2022 12:57:48 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org,
        "kernelci@groups.io" <kernelci@groups.io>,
        "kernelci-results@groups.io" <kernelci-results@groups.io>
Subject: Re: next/master bisection: baseline.login on asus-C523NA-A20057-coral
Message-ID: <20220405175748.GA72007@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28ee7ff8-5b21-9154-74e9-efd59da4a498@collabora.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 04, 2022 at 08:44:41PM +0100, Guillaume Tucker wrote:
> On 29/03/2022 19:44, Guillaume Tucker wrote:
> > On 28/03/2022 13:54, Hans de Goede wrote:
> >> On 3/24/22 23:19, Mark Brown wrote:
> >>> On Thu, Mar 24, 2022 at 09:34:30PM +0100, Hans de Goede wrote:
> >> Ok, Guillaume, can you try a kernel with commit 5949965ec9340cfc0e65f7d8a576b660b26e2535
> >> ("x86/PCI: Preserve host bridge windows completely covered by E820") + the 
> >> attached patch added on top a try on the asus-C523NA-A20057-coral machine please
> >> and see if that makes it boot again ?
> > 
> > Sorry I've been busy with a conference.  Sure, will put that
> > through KernelCI tomorrow and let you know the outcome.
> 
> Well the issue seems to have been fixed on mainline, unless it's
> intermittent.  In any case, next-20220404 is booting fine:
> 
>   https://linux.kernelci.org/test/plan/id/624aed811a5acd09adae071e/
> 
> Last time it was seen to fail was next-20220330:
> 
>   https://linux.kernelci.org/test/plan/id/62442f68e30d6f89a4ae06b7/

This is because I dropped 5949965ec934 ("x86/PCI: Preserve host bridge
windows completely covered by E820") from the PCI tree starting with
next-20220401 because it causes the regression.  So I expect
next-20220404 to boot fine (next-20220401 should boot fine as well; I
don't know whether that was tested).

The gory details:

  20220330 should fail; it includes:
    5949965ec934 ("x86/PCI: Preserve host bridge windows completely covered by E820")
    d13f73e9108a ("x86/PCI: Log host bridge window clipping for E820 regions")
    9c253994c5ba ("x86/PCI: Eliminate remove_e820_regions() common subexpressions")
    ffb217a13a2e ("Linux 5.17-rc7")

  20220331 should fail; it includes:
    18146f25ac66 ("PCI: hv: Remove unused hv_set_msi_entry_from_desc()")
    5949965ec934 ("x86/PCI: Preserve host bridge windows completely covered by E820")
    d13f73e9108a ("x86/PCI: Log host bridge window clipping for E820 regions")
    9c253994c5ba ("x86/PCI: Eliminate remove_e820_regions() common subexpressions")
    ffb217a13a2e ("Linux 5.17-rc7")

  20220401 should boot; it includes:
    1c6cec4ab487 ("x86/PCI: Log host bridge window clipping for E820 regions")
    b2922e67d233 ("x86/PCI: Eliminate remove_e820_regions() common subexpressions")
    22ef7ee3eeb2 ("PCI: hv: Remove unused hv_set_msi_entry_from_desc()")
    148a65047695 ("Merge tag 'pci-v5.18-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci")

  20220404 should boot; it includes:
    22ef7ee3eeb2 ("PCI: hv: Remove unused hv_set_msi_entry_from_desc()")
    148a65047695 ("Merge tag 'pci-v5.18-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci")

> Ironically, the KernelCI staging linux-next job with the patches
> mentioned in your previous email applied is now failing:
> 
>   https://staging.kernelci.org/test/plan/id/624b2d3b923f532dc305f4c7/

This says we tested commit 1aceacc82d3f, which I guess is the
staging-next-20220404.1 tag at https://github.com/kernelci/linux.git.
It took me a while to find the commit history, but
https://github.com/kernelci/linux/commits/1aceacc82d3f says this
includes:

  0a0c05a90278 x86/PCI: Limit "e820 entry fully covers window" check to non ISA MMIO
  b5fd57109d22 x86/PCI: Preserve host bridge windows completely covered by E820

So the proposed fix (0a0c05a90278) apparently didn't work.

Bjorn
