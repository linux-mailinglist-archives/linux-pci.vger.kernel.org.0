Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 189D051A7EF
	for <lists+linux-pci@lfdr.de>; Wed,  4 May 2022 19:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354930AbiEDRHA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 May 2022 13:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354579AbiEDRFT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 May 2022 13:05:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0ED5132B;
        Wed,  4 May 2022 09:54:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5CD4B827AC;
        Wed,  4 May 2022 16:54:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50683C385B1;
        Wed,  4 May 2022 16:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651683251;
        bh=c6+7Ne4K8yZ0+BKb8IfJNxGJ6ZxxOYXvDdFYiQ0PJqM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=uh7kUaXix6SXNpSHxcQafJqyVWArJKQx6BIJfPPwMl8cluoqPN3qGBf87C0JFYMh6
         aUOJawCMaS6sZ7ndt9v8Sf0sPtPEJqffnJVQsm7THm2CtvsHU2AX9qaBlyBS7vDP9m
         bBpyKzWp23iRlbBOwpNx9iabOCVxCVRLsMlixJ8MgdAvsYok1P1GsQzwz6toDlNjFg
         KrvGLi8oVTmLGLVxGdCLImBEWD9YebI+IfxvCA9qRXcAtAjfXqKVEBuGQ4JmeWHHtg
         LTOlrf0DOG1SdR1yVvMgg4/hfJrfgI4FtzUcCeKB1h1s2iF5k/INugSy7H0797WFSM
         pkT9fnIfhu9NQ==
Date:   Wed, 4 May 2022 11:54:09 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH v3 4/9] PCI/PM: Rework changing power states of PCI
 devices
Message-ID: <20220504165409.GA453565@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnFtjzGYwe28tVAA@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Anders]

On Tue, May 03, 2022 at 10:59:43AM -0700, Nathan Chancellor wrote:
> On Thu, Apr 14, 2022 at 03:11:21PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > There are some issues related to changing power states of PCI
> > devices, mostly related to carrying out unnecessary actions in some
> > places, and the code is generally hard to follow.
> > 
> >  1. pci_power_up() has two callers, pci_set_power_state() and
> >     pci_pm_default_resume_early().  The latter updates the current
> >     power state of the device right after calling pci_power_up()
> >     and it restores the entire config space of the device right
> >     after that, so pci_power_up() itself need not read the
> >     PCI_PM_CTRL register or restore the BARs after programming the
> >     device into D0 in that case.
> >  
> >  2. It is generally hard to get a clear view of the pci_power_up()
> >     code flow, especially in some corner cases, due to all of the
> >     involved PCI_PM_CTRL register reads and writes occurring in
> >     pci_platform_power_transition() and in pci_raw_set_power_state(),
> >     some of which are redundant.
> > 
> >  3. The transitions from low-power states to D0 and the other way
> >     around are unnecessarily tangled in pci_raw_set_power_state()
> >     which causes it to use a redundant local variable and makes it
> >     rather hard to follow.
> > 
> > To address the above shortcomings, make the following changes:
> > 
> >  a. Remove the code handling transitions into D0
> >     from pci_raw_set_power_state() and rename it as
> >     pci_set_low_power_state().
> > 
> >  b. Add the code handling transitions into D0 directly
> >     to pci_power_up() and to a new wrapper function
> >     pci_set_full_power_state() calling it internally that is
> >     only used in pci_set_power_state().
> > 
> >  c. Make pci_power_up() avoid redundant PCI_PM_CTRL register reads
> >     and make it work in the same way for transitions from any
> >     low-power states (transitions from D1 and D2 are handled
> >     slightly differently before the change).
> > 
> >  d. Put the restoration of the BARs and the PCI_PM_CTRL
> >     register read confirming the power state change into
> >     pci_set_full_power_state() to avoid doing that in
> >     pci_pm_default_resume_early() unnecessarily.
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> This change as commit 5bffe4c611f5 ("PCI/PM: Rework changing power
> states of PCI devices") causes my AMD-based system to fail to fully
> boot.

I dropped 5bffe4c611f5 and subsequent pci/pm patches temporarily while
this gets worked out.

Bjorn
