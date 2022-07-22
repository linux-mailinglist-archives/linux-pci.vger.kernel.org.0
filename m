Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457E557E8B0
	for <lists+linux-pci@lfdr.de>; Fri, 22 Jul 2022 23:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbiGVVHh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Jul 2022 17:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiGVVHh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jul 2022 17:07:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601B29B56C;
        Fri, 22 Jul 2022 14:07:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF2C4620DD;
        Fri, 22 Jul 2022 21:07:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED47C341C6;
        Fri, 22 Jul 2022 21:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658524055;
        bh=BjE6WAFN8f+7PcLVzym80m/hAtGxPQSDC3WhNnOk+G0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ruDZgOs5bS6n57s1Z4ZCM8Gaa4i+Rbknj2eIDMdbL+yQ2jG/VrQXcHUAWiTYf/x1B
         Y2lIDYkvubc8UykDSDfJcJk84t3gBNbxr5jLuu2QxyeMf+5SFbPoX3xiR/AbqMc71v
         akXmZrInkgokuZqMIWBW4cIM1h+FcqP0VZtW05qn319FVKPZMgbIwdKtZVn1GDGexl
         kTyZ8uNeDJf0jRo+dqCEIYScE9l4Mzy+M0lL9Ti5IMvXV8tAfVKcMJdO/5LC7B9Dm+
         YbBK4POBUV2yv4HnyO9xMJcNhxXEPofug4D1pZwpXWgWB9+WAo4xmYBWVfxxLuR6+d
         uB+REBQS4dSrQ==
Date:   Fri, 22 Jul 2022 16:07:33 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/5] PCI: Rework pci_scan_slot() and isolated PCI
 functions
Message-ID: <20220722210733.GA1935162@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628143100.3228092-1-schnelle@linux.ibm.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 28, 2022 at 04:30:55PM +0200, Niklas Schnelle wrote:
> Hi Bjorn,
> 
> In an earlier version[0], I sought to apply the existing jailhouse special case
> for isolated PCI functions to s390. As Bjorn noted in[1] there appears to be
> some potential for cleaning things up and removing duplication.
> 
> This series attempts to do this cleanup (Patches 1 through 3) followed by enabling
> isolated PCI functions for s390 (Patches 4 and 5).
> 
> Testing:
> - On s390 with SR-IOV and a ConnectX NIC with PF 1 but not PF 0 passed throug
>   i.e. the isolated function case. Also of course with just VFs and an NVMe.
> - On x86_64 on a desktop system where ARI is disabled and with an SR-IOV NIC
>   with non-contiguous VFs as well as the usual other PCI devices.
> 
> Thanks,
> Niklas
> 
> [0] https://lore.kernel.org/linux-pci/20220404095346.2324666-1-schnelle@linux.ibm.com/
> [1] https://lore.kernel.org/linux-pci/20220408224514.GA353445@bhelgaas/
> 
> Changes v5 -> v6:
> - Added a patch (2) which separates the ARI case into its own function
> - Some whitespace changes to remove unnecesssary empty lines
> Changes v4 -> v5:
> - Remove unintended whitespace change in patch 1
> Changes v3 -> v4:
> - Use a do {} while loop in pci_scan_slot() as it is simpler (Bjorn)
> - Explicitly check "fn == 0" as it is not a pointer or bool (Bjorn)
> - Keep the "!dev" check in the ARI branch of next_fn() (Bjorn)
> - Moved the "fn == 0 && !dev" condition out of next_fn() into pci_scan_slot().
>   This allows us to keep the "!dev" case in the ARI branch and means there are
>   no new conditions in next_fn() making it easier to verify that its behavior
>   is equivalent to the existing code.
> - Guard the assignment of dev->multifunction with "fn > 0"
>   instead of "nr > 0". This matches the existing logic more closely and works
>   for the jailhouse case which unconditionally sets dev->multifunction for
>   "fn > 0". This also means fn == 0 is the single "first iteration" test.
> - Remove some unneeded whitespace in patch 2
> 
> Changes v2 -> v3:
> - Removed now unused nr_devs variable (kernel test robot)
> 
> Niklas Schnelle (5):
>   PCI: Clean up pci_scan_slot()
>   PCI: Split out next_ari_fn() from next_fn()
>   PCI: Move jailhouse's isolated function handling to pci_scan_slot()
>   PCI: Extend isolated function probing to s390
>   s390/pci: allow zPCI zbus without a function zero
> 
>  arch/s390/pci/pci_bus.c    | 82 +++++++++---------------------------
>  drivers/pci/probe.c        | 86 ++++++++++++++++++--------------------
>  include/linux/hypervisor.h |  8 ++++
>  3 files changed, 68 insertions(+), 108 deletions(-)

Applied to pci/enumeration for v5.20, thanks!
