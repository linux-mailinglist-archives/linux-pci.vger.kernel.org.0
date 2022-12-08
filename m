Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8128B646F82
	for <lists+linux-pci@lfdr.de>; Thu,  8 Dec 2022 13:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiLHMXx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Dec 2022 07:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLHMXw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Dec 2022 07:23:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C2A42983
        for <linux-pci@vger.kernel.org>; Thu,  8 Dec 2022 04:23:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 630AB61EED
        for <linux-pci@vger.kernel.org>; Thu,  8 Dec 2022 12:23:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909C4C433C1;
        Thu,  8 Dec 2022 12:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670502230;
        bh=aslS0lqZ2aY/a+SsFhlf2VU/N3U85rteoesQpO1rGQQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=tu8Ygr9MpDra/B87dyyKE/qbGVLR3UxqibUCtWjlW6b8wbiF5vADfW0tqbQhNJqt0
         PVwiCFrP5KN5nc7HCg4I48Zv+fawzG6hBN5UPNKl92eiFSlcN5bMHq77Qkmrlh/uG3
         ZIq5p/KVj1eNmoDGBtj7GBV69vs+ofmYpgZHyR/8we801WqUR/RZVVzBt0lB3XLR5c
         dHdUPyws/t7UZC2KHuCBk3YEqt2fzrDfsVxp1dGwY8CXu8RMijmpt11K3V92Svbpqg
         w1cP0BMDoTW3uA9K06JTOs3XHDNmiDrkpXx/F/SY5oo1EVW6yhzgP6Z2JQyYcOpjhb
         yqbnSvezMe2Ow==
Date:   Thu, 8 Dec 2022 06:23:49 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI/portdrv: Do not require an interrupt for all AER
 capable ports
Message-ID: <20221208122349.GA1525911@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5F9EnsNqyc3hEeK@black.fi.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 08, 2022 at 07:58:42AM +0200, Mika Westerberg wrote:
> On Wed, Dec 07, 2022 at 04:35:37PM -0600, Bjorn Helgaas wrote:
> > On Wed, Dec 07, 2022 at 10:41:05AM +0200, Mika Westerberg wrote:
> > > Only Root Ports and Event Collectors use MSI for AER. PCIe Switch ports
> > > or endpoints on the other hand only send messages (that get collected by
> > > the former). For this reason do not require PCIe switch ports and
> > > endpoints to use interrupt if they support AER.
> > > 
> > > This allows portdrv to attach PCIe switch ports of Intel DG1 and DG2
> > > discrete graphics cards. These do not declare MSI or legacy interrupts.
> > 
> > Help me understand more about this situation.  I guess we want portdrv
> > to attach not to a GPU itself, but to a switch port on the card that
> > *leads* to the GPU?
> 
> Yes correct.
> 
> > From the patch, it looks like the only PCIe port service this switch
> > port advertises is AER (not PME, DPC, hotplug, etc), and it doesn't
> > have MSI or MSI-X.
> 
> Correct.
> 
> > So aerdriver should be able to register for PCIE_PORT_SERVICE_AER, but
> > aer_probe() ignores everything except Root Ports and RCECs.  What's
> > the benefit then?  I must be missing something.
> 
> The portdrv is needed for power management and everything else PCI even
> if there is no actual "service" attached.

Thanks!  I'm trying to connect the dots to get to the specific bug fix
or improvement made by this patch.

The pcie_pme_driver itself doesn't seem involved because it registers
for PCIE_PORT_SERVICE_PME, and that's only set for Root Ports and
RCECs.

The pcie_portdrv_pm_ops would be another possibility, but with the
exception of pcie_port_runtime_idle(), all those ops just iterate over
service drivers, which aren't involved.

So I'm guessing this has to do with setting
DPM_FLAG_NO_DIRECT_COMPLETE and DPM_FLAG_SMART_SUSPEND in
pcie_portdrv_probe().  Does the lack of portdrv mean the GPU can't
suspend?  Does this reduce power consumption?  How would a user know
this change would help their system?

Bjorn
