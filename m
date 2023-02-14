Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4B46970A1
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 23:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjBNWUb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 17:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjBNWUa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 17:20:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999ED213C;
        Tue, 14 Feb 2023 14:20:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41958B81F4B;
        Tue, 14 Feb 2023 22:20:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C97E4C433D2;
        Tue, 14 Feb 2023 22:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676413227;
        bh=4qh6KKDiA9YehbMq8jIe0pJ2avRcazFqJ/GS5WKquhk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=DFvE2Q/fbAn2NXd+uMUoDGXtGmIXolFnmQ/SWod/OgHGevcdzSdXoNcSIBt+4nLcc
         gN/oPMqDk2ujvbZWitvrLxm6s5OKzqccg4AYfs0APkuutZaf2D2nUEDhv8OGieCh0q
         0zg3AWva7jpsJ/gzUktMrke1EiBRTf5L4j8o1SiD0yAoUzfSS9cweH7IWXZarLxhM2
         AdXGPNb9SwTd7TNSkchh9gfVXy8ibqgG7C+h7SpsdYlttSzOtfVB2LGeFkvGrKJ/CT
         Tw+X5OY+4QXXCsSyQva/iIGx7Bs2uxgNIqr2X6XXu4uxPUlnbLQ1b6N44uFrm+j8WP
         YxMloF1Pxz/oA==
Date:   Tue, 14 Feb 2023 16:20:25 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yang Su <yang.su@linux.alibaba.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        alex.williamson@redhat.com, matthew@wil.cx,
        jbarnes@virtuousgeek.org, greg@kroah.com, patchwork-bot@kernel.org,
        andrew.murray@arm.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, linux-kernel@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/1] PCI: Tune secondary bus reset time for PCIe
Message-ID: <20230214222025.GA3089181@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87b08879-4f1a-e91d-861a-0a1af4ad46fc@linux.alibaba.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 13, 2023 at 11:58:06AM +0800, Yang Su wrote:
> Sorry to interrupt, this email is reformat as plaint text, I want to test
> this email
> 
> whether can send linux-kernel@vger.kernel.org .
> 
> 
> Hi Bjorn,
> 
> I think my patch is different from Lucas, because I use pcie_wait_for_link
> not
> 
> pci_bridge_wait_for_secondary_bus, my patch is similar to the process logic
> 
> in pci_bridge_wait_for_secondary_bus which also call pcie_wait_for_link.
> 
> 
> pcie_wait_for_link wait fixed 100ms and then wait the data link is ready,
> but
> 
> pci_bridge_wait_for_secondary_bus call pcie_wait_for_link wait time depends
> 
> on the devices max waiting time in bus, the calculate max time having a bug
> 
> as below,
> 
> 
> In pci_bridge_wait_for_secondary_bus, pci_bus_max_d3cold_delay will take
> count of wrong time delay,
> 
> such as NVIDIA GPU T4 is not pci bridge, so the subordinate is none,
> pci_bus_max_d3cold_delay
> 
> set the min_delay is 100, max_delay is 0, here is the bug, after
> list_for_each_entry() in pci_bus_max_d3cold_delay,
> 
> the min_delay will be 0, the max_delay also 0, the pci_bus_max_d3cold_delay
> return is surely 0.
> 
> 
> Last, I request Ravi Kishore Koppuravuri to test my patch to see Intel Ponte
> Vecchio HPC GPU
> 
> whether can work, I think my patch will wait enough time to be ready after
> secondary bus reset.
> 
> 
> I have tested NVIDIA GPU T4 and NVIDIA GPU A100 which my patch is ok, but I
> think there is need
> 
> more test to validate my patch. But the fact is I do not have enough device
> to validate. If Ravi Kishore Koppuravuri
> 
> can help me test, the patch test will be more enough, and I would be
> grateful for test. Thank you very much!

This will need to be updated to apply on top of Lukas' patches since
they change the same area.  You could rebase on top of:
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?id=53b54ad074de

It also will need a concise description of what this fixes and why we
want it.  I see that it changes the time we wait after a secondary bus
reset, but I have to read the patch itself to figure out what's going
on.

> On 2023/1/13 06:48, Bjorn Helgaas wrote:
> > [+cc Lukas, Mika]
> > 
> > Hi Yang Su,
> > 
> > Thank you for your patch!
> > 
> > On Sun, Jan 01, 2023 at 05:22:33PM +0800, Yang Su wrote:
> > > On PCI Express, there will be cases where the new code sleeps far less
> > > than the 1s being replaced by this patch. This should be okay, because
> > > PCI Express Base Specification Revision 5.0 Version 1.0 (May 22, 2019)
> > > in Section 6.6.1 "Conventional Reset" only notes 100ms as the minimum
> > > waiting time. After this time, the OS is permitted to issue
> > > Configuration Requests, but it is possible that the device responds
> > > with Configuration Request Retry Status (CRS) Completions, rather than
> > > Successful Completion. Returning CRS can go on for up to 1 second after
> > > a Conventional Reset (such as SBR) before the OS can consider the device
> > > broken. This additional wait is handled by pci_dev_wait. Besides,
> > > this patch also cover PCI and PCI-X after device reset waiting Tpvrh 1000ms.
> > > 
> > > Currently, the only callchain that lands in the function modified by
> > > this patch which invokes one out of two versions of pcibios_reset_secondary_bus
> > > that both end with a call to pci_reset_secondary_bus.
> > > 
> > > Afterwards, pci_reset_secondary_bus always invokes pci_dev_wait
> > > which wait for the device to return a non-CRS completion.
> > > 
> > > Signed-off-by: Yang Su <yang.su@linux.alibaba.com>
> > > ---
> > >   drivers/pci/pci.c | 36 +++++++++++++++++++++++++++++++++---
> > >   1 file changed, 33 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index fba95486caaf..8e4899755718 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -5063,10 +5063,40 @@ void pci_reset_secondary_bus(struct pci_dev *dev)
> > >   	 * Trhfa for conventional PCI is 2^25 clock cycles.
> > >   	 * Assuming a minimum 33MHz clock this results in a 1s
> > >   	 * delay before we can consider subordinate devices to
> > > -	 * be re-initialized.  PCIe has some ways to shorten this,
> > > -	 * but we don't make use of them yet.
> > > +	 * be re-initialized.
> > > +	 *
> > > +	 * For conventional PCI needing 1s delay after bus reset.
> > > +	 * Using pci_is_pcie to judge the bus is pci or pcie.
> > > +	 * If the bus is pci, sleeping 1s to wait device is ready.
> > > +	 *
> > > +	 * And if the bus is pcie, PCI Express Base Specification Revision 2.0
> > > +	 * (December 20, 2006) in Section 6.6.1 "Conventional Reset" only notes
> > > +	 * 100ms as the minimum waiting time, the same as the newer PCIe spec
> > > +	 * PCI Express Base Specification Revision 3.0 Version 1.a (December 7, 2015)
> > > +	 * and PCI Express Base Specification Revision 5.0 Version 1.0 (May 22, 2019).
> > > +	 * With a Downstream Port that supports Link speeds greater than 5.0 GT/s,
> > > +	 * software must wait a minimum of 100 ms after Link training completes before
> > > +	 * sending a Configuration Request to the device immediately below that Port.
> > > +	 * After this time, the OS is permitted to issue Configuration Requests,
> > > +	 * but it is possible that the device responds with Configuration Request
> > > +	 * Retry Status (CRS) Completions, rather than Successful Completion.
> > > +	 * Returning CRS can go on for up to 1 second after a Conventional Reset
> > > +	 * (such as SBR) before the OS can consider the device. This additional
> > > +	 * wait is handled by pci_dev_wait.
> > > +	 *
> > > +	 * Currently, the only callchain that lands in the function modified by
> > > +	 * this patch starts at pci_bridge_secondary_bus_reset which invokes
> > > +	 * one out of two versions of pcibios_reset_secondary_bus that both end
> > > +	 * with a call to pci_reset_secondary_bus.
> > > +	 * Afterwards, pci_bridge_secondary_bus_reset always invokes pci_dev_wait.
> > >   	 */
> > > -	ssleep(1);
> > > +	if (pci_is_pcie(dev))
> > > +		if (pcie_get_speed_cap(dev) <= PCIE_SPEED_5_0GT)
> > > +			msleep(100);
> > > +		else
> > > +			pcie_wait_for_link(dev, true);
> > > +	else
> > > +		ssleep(1);
> > This code is also updated by Lukas' patch at
> > https://lore.kernel.org/r/bd6ac49d60c1ca6fe5c27c2fa54b78d70a8ba07b.1672511017.git.lukas@wunner.de,
> > which is pretty much ready to go.
> > 
> > Can you take a look at that series and see whether it solves the same
> > problem you're solving here?  And if not, can you provide feedback on
> > what would still be needed?
> > 
> > If you do need something on top of Lukas' series, please CC him if you
> > post a revised patch.
> > 
> > Bjorn
