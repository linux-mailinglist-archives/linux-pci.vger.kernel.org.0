Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F662706E18
	for <lists+linux-pci@lfdr.de>; Wed, 17 May 2023 18:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjEQQ1S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 May 2023 12:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjEQQ1R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 May 2023 12:27:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1ACE45;
        Wed, 17 May 2023 09:27:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 648946495A;
        Wed, 17 May 2023 16:27:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D30C433EF;
        Wed, 17 May 2023 16:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684340828;
        bh=86RzE6D5pO3A8yYeWzeN2fRiureyHgGp8eTGKaO2dq4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MDrcxoVXnq/S9N0/g9hHTGp4FCME2zRJVfQZLAS+gTYrC8nR4Kb4zWvvV+348dyus
         mCneVveEYvMrI2vAlXLTLMLY5EGhRWsKaQXflRKYbkC9552rgqqssBWhAJ9O78/uBn
         +MUGjuW38Mg2taa/USgIVp9t9qvckfgl9jfff/kg7/pyLoxgCpK7HnUj9YTDaILzOu
         +U10SDC+S3DC7WqGm3tso5Aft3LBT0y3hzyDdTH8KPt6b11eUl4W7v8Zm3LDX5v/Rw
         z2qS6WNnIP4aPkznPR4pr0QrOski9n7prAH/qiwza06jKvrnuG5nbkxqXzZ2PFn9Qq
         0AUC9NntdMmmA==
Date:   Wed, 17 May 2023 11:27:07 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Shuai Xue <xueshuai@linux.alibaba.com>,
        Robin Murphy <robin.murphy@arm.com>, yangyicong@huawei.com,
        will@kernel.org, baolin.wang@linux.alibaba.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, rdunlap@infradead.org,
        mark.rutland@arm.com, zhuo.song@linux.alibaba.com,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH v3 2/3] drivers/perf: add DesignWare PCIe PMU driver
Message-ID: <ZGUAWxoEngmqFcLJ@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230517105421.00003251@Huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 17, 2023 at 10:54:21AM +0100, Jonathan Cameron wrote:
> On Tue, 16 May 2023 14:17:52 -0500
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> > On Tue, May 16, 2023 at 04:03:04PM +0100, Jonathan Cameron wrote:
> ...

> > > The approach used here is to separately walk the PCI topology and
> > > register the devices.  It can 'maybe' get away with that because no
> > > interrupts and I assume resets have no nasty impacts on it because
> > > the device is fairly simple.  In general that's not going to work.
> > > CXL does a similar trick (which I don't much like, but too late
> > > now), but we've also run into the problem of how to get interrupts
> > > if not the main driver.  
> > 
> > Yes, this is a real problem.  I think the "walk all PCI devices
> > looking for one we like" approach is terrible because it breaks a lot
> > of driver model assumptions (no device ID to autoload module via udev,
> > hotplug doesn't work, etc), but we don't have a good alternative right
> > now.
> > 
> > I think portdrv is slightly better because at least it claims the
> > device in the usual way and gives a way for service drivers to
> > register with it.  But I don't really like that either because it
> > created a new weird /sys/bus/pci_express hierarchy full of these
> > sub-devices that aren't really devices, and it doesn't solve the
> > module load and hotplug issues.
> > 
> > I would like to have portdrv be completely built into the PCI core and
> > not claim Root Ports or Switch Ports.  Then those devices would be
> > available via the usual driver model for driver loading and binding
> > and for hotplug.
> 
> Let me see if I understand this correctly as I can think of a few options
> that perhaps are inline with what you are thinking.
> 
> 1) All the portdrv stuff converted to normal PCI core helper functions
>    that a driver bound to the struct pci_dev can use.
> 2) Driver core itself provides a bunch of extra devices alongside the
>    struct pci_dev one to which additional drivers can bind? - so kind
>    of portdrv handling, but squashed into the PCI device topology?
> 3) Have portdrv operated under the hood, so all the services etc that
>    it provides don't require a driver to be bound at all.  Then
>    allow usual VID/DID based driver binding.
> 
> If 1 - we are going to run into class device restrictions and that will
> just move where we have to handle the potential vendor specific parts.
> We probably don't want that to be a hydra with all the functionality
> and lookups etc driven from there, so do we end up with sub devices
> of that new PCI port driver with a discover method based on either
> vsec + VID or DVSEC with devices created under the main pci_dev.
> That would have to include nastiness around interrupt discovery for
> those sub devices. So ends up roughly like port_drv.
> 
> I don't think 2 solves anything.
> 
> For 3 - interrupts and ownership of facilities is going to be tricky
> as initially those need to be owned by the PCI core (no device driver bound)
> and then I guess handed off to the driver once it shows up?  Maybe that
> driver should call a pci_claim_port() that gives it control of everything
> and pci_release_port() that hands it all back to the core.  That seems
> racey.

Yes, 3 is the option I want to explore.  That's what we already do for
things like ASPM.  Agreed, interrupts is a potential issue.  I think
the architected parts of config space should be implicitly owned by
the PCI core, with interfaces à la pci_disable_link_state() if drivers
need them.

Bjorn
