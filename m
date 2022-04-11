Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABBA4FC228
	for <lists+linux-pci@lfdr.de>; Mon, 11 Apr 2022 18:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241402AbiDKQZD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Apr 2022 12:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234414AbiDKQZD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Apr 2022 12:25:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E247930560;
        Mon, 11 Apr 2022 09:22:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80896616E2;
        Mon, 11 Apr 2022 16:22:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FBF9C385A4;
        Mon, 11 Apr 2022 16:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649694167;
        bh=etgszlvRZe6jojRqGriaxOztspw5uhvdBS80CxJB4SE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=DRwqaBaSdxFQPkzjCeJI8eG2gb9bLFdGYzApUjcRzrefej9I+JDefq+Z257Xoq/Gy
         I3DuZpWqrikk/H693LqgH5bEK7stEfmszvlFO3t+5hk58k7Ir+LaXzuIBwT/KMU8Rf
         ku+OY/D3ZleeOzkc+LeYswSL7WLyV0bo5XgdLB66DdZS/4ij5lsNOIlt2ej2CFQBxF
         ZhQKGbdT8lwj8+AKrjMr4ZLz+GLX8MHxvW5g0DfBodzYeJ6FHQBHQYimZaZUweqIUt
         Q4UI7i7TQP7AdaJ9lOl+mRak/VKhFNlLakve0Str0CpestWRzaWmF5d7SaX/QNISqb
         8sfQT4VqeTD0w==
Date:   Mon, 11 Apr 2022 11:22:46 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Stefan Gottwald <gottwald@igel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: PM: Quirk bridge D3 on Elo i2
Message-ID: <20220411162246.GA519922@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d6981fd-c75a-ccb0-9299-65625963a9e3@leemhuis.info>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 11, 2022 at 02:10:30PM +0200, Thorsten Leemhuis wrote:
> 
> 
> On 11.04.22 13:35, Rafael J. Wysocki wrote:
> > On Sun, Apr 10, 2022 at 11:16 AM Thorsten Leemhuis
> > <regressions@leemhuis.info> wrote:
> >>
> >> On 09.04.22 15:35, Rafael J. Wysocki wrote:
> >>> On Fri, Apr 8, 2022 at 9:53 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >>>>
> >>>> On Mon, Apr 04, 2022 at 04:46:14PM +0200, Rafael J. Wysocki wrote:
> >>>>> On Fri, Apr 1, 2022 at 1:34 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >>>>>> On Thu, Mar 31, 2022 at 11:57 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >>>>>>> On Thu, Mar 31, 2022 at 07:38:51PM +0200, Rafael J. Wysocki wrote:
> >>>>>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>>>>>>
> >>>>>>>> If one of the PCIe root ports on Elo i2 is put into D3cold and then
> >>>>>>>> back into D0, the downstream device becomes permanently inaccessible,
> >>>>>>>> so add a bridge D3 DMI quirk for that system.
> >>>>>>>>
> >>>>>>>> This was exposed by commit 14858dcc3b35 ("PCI: Use
> >>>>>>>> pci_update_current_state() in pci_enable_device_flags()"), but before
> >>>>>>>> that commit the root port in question had never been put into D3cold
> >>>>>>>> for real due to a mismatch between its power state retrieved from the
> >>>>>>>> PCI_PM_CTRL register (which was accessible even though the platform
> >>>>>>>> firmware indicated that the port was in D3cold) and the state of an
> >>>>>>>> ACPI power resource involved in its power management.
> >>>>>>>> ...

> >>>> I don't understand all that's going on here, but I applied it to
> >>>> pci/pm for v5.19, thanks!
> >>> Thank you!
> >>
> >> Sorry, but this made me wonder: why v5.19? It's a regression exposed in
> >> v5.15, so it afaics would be good to get this in this cycle -- and also
> >> backported to v5.15.y, but it seem a tag to take care of that is
> >> missing. :-/

I moved it to for-linus for v5.18 and added a stable tag for v5.15+.
