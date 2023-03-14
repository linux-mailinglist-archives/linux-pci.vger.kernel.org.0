Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3166B9CF6
	for <lists+linux-pci@lfdr.de>; Tue, 14 Mar 2023 18:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjCNR01 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Mar 2023 13:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjCNR01 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Mar 2023 13:26:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B237F9545C
        for <linux-pci@vger.kernel.org>; Tue, 14 Mar 2023 10:26:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65A07B819F6
        for <linux-pci@vger.kernel.org>; Tue, 14 Mar 2023 17:26:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB5DC4339B;
        Tue, 14 Mar 2023 17:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678814783;
        bh=xJ0MZdPQ+VyrQm8kJJScCpf+Xu472bOsGovWjBVQahk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UFNcQeKGzFRq51nEfJCsEHpwO6bt1a1oFk4c6nZCoC9gznoJfQ+ezp9VFky/nbQSp
         hgnhcz+XZBgHVOrPi2N7BmEj4E2tIPMhs2iqR2gI7KiB9WydsdVRZL789vr6af7Sxm
         XzkE/uxka8wE6n0mhLixED582NY5cVHoAbPxtzVyC12AIYTlYET4gEAf1Hj204SsM1
         kpstbuz+ICOvzbQ30WDRsLSO3wYptWx0peJzTLhuoJ31WU6WeW21WE/12FzekhcBR/
         RY0Sea4/TPeSMeqgI2i+PiqZ2Tp/3J1ZekUjc2L+0RzryKcnUgxb0EdTbE1ms96tlc
         5iwWCakJgbaMg==
Date:   Tue, 14 Mar 2023 11:26:20 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Tushar Dave <tdave@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: nvme-pci: Disabling device after reset failure: -5 occurs while
 AER recovery
Message-ID: <ZBCuPM0WcWaLwWXJ@kbusch-mbp.dhcp.thefacebook.com>
References: <c17f7476-8ed0-212e-9480-78732635ee3f@nvidia.com>
 <20230314161127.GA1648664@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314161127.GA1648664@bhelgaas>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 14, 2023 at 11:11:27AM -0500, Bjorn Helgaas wrote:
> On Mon, Mar 13, 2023 at 05:57:43PM -0700, Tushar Dave wrote:
> > On 3/11/23 00:22, Lukas Wunner wrote:
> > > On Fri, Mar 10, 2023 at 05:45:48PM -0800, Tushar Dave wrote:
> > > > On 3/10/2023 3:53 PM, Bjorn Helgaas wrote:
> > > > > In the log below, pciehp obviously is enabled; should I infer that in
> > > > > the log above, it is not?
> > > > 
> > > > pciehp is enabled all the time. In the log above and below.
> > > > I do not have answer yet why pciehp shows-up only in some tests (due to DPC
> > > > link down/up) and not in others like you noticed in both the logs.
> > > 
> > > Maybe some of the switch Downstream Ports are hotplug-capable and
> > > some are not?  (Check the Slot Implemented bit in the PCI Express
> > > Capabilities Register as well as the Hot-Plug Capable bit in the
> > > Slot Capabilities Register.)
> > > ...
> 
> > > > > Generally we've avoided handling a device reset as a
> > > > > remove/add event because upper layers can't deal well with
> > > > > that.  But in the log below it looks like pciehp *did* treat
> > > > > the DPC containment as a remove/add, which of course involves
> > > > > configuring the "new" device and its MPS settings.
> > > > 
> > > > yes and that puzzled me why? especially when"Link Down/Up
> > > > ignored (recovered by DPC)". Do we still have race somewhere, I
> > > > am not sure.
> > > 
> > > You're seeing the expected behavior.  pciehp ignores DLLSC events
> > > caused by DPC, but then double-checks that DPC recovery succeeded.
> > > If it didn't, it would be a bug not to bring down the slot.  So
> > > pciehp does exactly that.  See this code snippet in
> > > pciehp_ignore_dpc_link_change():
> > > 
> > > 	/*
> > > 	 * If the link is unexpectedly down after successful recovery,
> > > 	 * the corresponding link change may have been ignored above.
> > > 	 * Synthesize it to ensure that it is acted on.
> > > 	 */
> > > 	down_read_nested(&ctrl->reset_lock, ctrl->depth);
> > > 	if (!pciehp_check_link_active(ctrl))
> > > 		pciehp_request(ctrl, PCI_EXP_SLTSTA_DLLSC);
> > > 	up_read(&ctrl->reset_lock);
> > > 
> > > So on hotplug-capable ports, pciehp is able to mop up the mess
> > > created by fiddling with the MPS settings behind the kernel's
> > > back.
> > 
> > That's the thing, even on hotplug-capable slot I do not see pciehp
> > _all_ the time. Sometime pciehp get involve and takes care of things
> > (like I mentioned in the previous thread) and other times no pciehp
> > engagement at all!
> 
> Possibly a timing issue, so I'll be interested to see if 53b54ad074de
> ("PCI/DPC: Await readiness of secondary bus after reset") makes any
> difference.  Lukas didn't mention that, so maybe it's a red herring,
> but I'm still curious since it explicitly mentions the DPC reset case
> that you're exercising here.

Catching the PDC event may be timing related. pciehp ignores the link events
during a DPC event, but it always reacts to PDC since it's indistinguishable
from a DPC occuring in response to a surprise removal, and these slots probably
don't have out-of-band presence detection.
