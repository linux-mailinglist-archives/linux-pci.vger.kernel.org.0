Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC3F610486
	for <lists+linux-pci@lfdr.de>; Thu, 27 Oct 2022 23:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236277AbiJ0VgZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Oct 2022 17:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236191AbiJ0VgZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Oct 2022 17:36:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB1F5F113;
        Thu, 27 Oct 2022 14:36:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC086624EC;
        Thu, 27 Oct 2022 21:36:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00638C433D6;
        Thu, 27 Oct 2022 21:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666906583;
        bh=d+99Qklp1XvLTs5hzjLB/CTz9UM6Vp6GAr9OOIx8fNY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KC66wXZdXYcDgawaSO+aUS27v4e+yS1UvhLRjbeCDLDfEMLfg+pdBqzvstCPxGY4J
         yWHwLfUgNMj1ommkw2Sxymy1hLEvLDgIHEcjKB6FQJUVFeKLqLdtddCxVcplG7wXwA
         aH8+5VsPOfiqPHOfpVEB13uqNDXnuCv7pGAhYZR1CR5o3LjsYZfRL+dt4a1FqevkOY
         v5vpsfW5kKSMZFSGC7MCQTDSiAbGUncz5dnFwrHcWwGp0sv0EGs1I1YXoVGGo7U/fP
         NzmunzziJR1YI6b+7ldr25Gs5o95nHmV02oXhUZ1JhPZRX7zeNsFosbzh5CLldySCP
         ghkFW/BXcKO3g==
Date:   Thu, 27 Oct 2022 16:36:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Stefan Richter <stefanr@s5r6.in-berlin.de>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux1394-devel@lists.sourceforge.net, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2] firewire: ohci: convert to generic power management
Message-ID: <20221027213620.GA842366@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027060342.GA444@wunner.de>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 27, 2022 at 08:03:42AM +0200, Lukas Wunner wrote:
> On Tue, Oct 25, 2022 at 04:25:21PM -0500, Bjorn Helgaas wrote:
> > N.B. This changes the order of pmac_ohci_off() and pmac_ohci_on().
> > Previously, pmac_ohci_off() was called *after* pci_save_state() and
> > pci_set_power_state(), and this change calls it *before*.
> > 
> > Similarly, pmac_ohci_on() was previously called *before*
> > pci_set_power_state() and pci_restore_state() and this change calls it
> > *after*.
> 
> Seems likely the ordering change may break things.
> 
> pmac_ohci_on/off() toggles PMAC_FTR_1394_ENABLE, which is defined as:
> 
>  * enable/disable the firewire cell of an uninorth ASIC.
> 
> It sounds like it will cut power to the firewire controller and I'd
> expect that pci_save_state() will then not be able to access config
> space.

Yeah, definitely a risk, so I won't merge this myself since I have no
insight or way to test it.

> The only way to make this work is to define a struct dev_pm_domain
> whose ->suspend_noirq callback first invokes the pci_bus_type
> ->suspend_noirq callback and then cuts power to the firewire cell
> by calling pmac_ohci_off().
> 
> I've done something like this for Thunderbolt power management on
> x86 Macs a few years back but didn't get around to upstream it so far:
> 
> https://github.com/l1k/linux/commit/4db7f0b1f5c9

Wow, that's some impressive reverse engineering and work!

We're not quite there yet, but if we ever get to the point where this
driver is the only thing preventing us from removing the PCI legacy PM
hooks, I think I'd be inclined to just sacrifice PM completely for
this driver.  I can't really see putting in the kind of work you did
for Thunderbolt.

Bjorn
