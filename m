Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37FEB629EEF
	for <lists+linux-pci@lfdr.de>; Tue, 15 Nov 2022 17:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238598AbiKOQYs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Nov 2022 11:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238579AbiKOQYr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2022 11:24:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EE7221;
        Tue, 15 Nov 2022 08:24:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 725E3B819B6;
        Tue, 15 Nov 2022 16:24:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE3DC433B5;
        Tue, 15 Nov 2022 16:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668529484;
        bh=TuVhkAZ0uTh5Zg7z7YoIeegiTSUDH74uPKa+wzXU/Cw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=JA5YxFCEc98HTu7yw2uflsCyRrPIvVZUNO6fyq8Il/vaT/EY/BEpShw3N2W/x+3Uc
         RzBF21umBWS0SU4k20ICSzzpFwKe4kneFMO23bpEVz8xrfFRpHqWyPLQQcR8WHaxS6
         y/2jlcDUYoIJ9uNw06mb3k4LqZFBJm9QKjpN7UDQfAJ29W9Hkf2Kh/AiPuQ4dQUdVh
         lM2TaV5mvcY5bl8jx6rOKVlQC2Ssa/kcdXg4jiDXV2QEf+tJ7m62wMgsYpbYzsggsk
         hgsU3egUEm3yUAgYIFBwwEwHTB5ieblNiu3DKFiU6wmXijWZ1/eyIy1jk4UMy9nURX
         hog5ZPJA2Bz/w==
Date:   Tue, 15 Nov 2022 10:24:42 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Wei Gong <gongwei833x@gmail.com>, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v2] pci: fix device presence detection for VFs
Message-ID: <20221115162442.GA919213@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221113034519-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Lukas; you can probably give a better answer here :)]

On Sun, Nov 13, 2022 at 03:46:06AM -0500, Michael S. Tsirkin wrote:
> On Fri, Nov 11, 2022 at 05:42:19PM -0600, Bjorn Helgaas wrote:
> > On Thu, Nov 10, 2022 at 03:15:55PM -0500, Michael S. Tsirkin wrote:
> > > On Thu, Nov 10, 2022 at 01:35:47PM -0600, Bjorn Helgaas wrote:
> > > ...
> > 
> > > > Prior to this change pci_device_is_present(VF) returned "false"
> > > > (because the VF Vendor ID is 0xffff); after the change it will return
> > > > "true" (because it will look at the PF Vendor ID instead).
> > > > 
> > > > Previously virtio_pci_remove() called virtio_break_device().  I guess
> > > > that meant the virtio I/O operation will never be completed?
> > > > 
> > > > But if we don't call virtio_break_device(), the virtio I/O operation
> > > > *will* be completed?
> > > 
> > > It's completed anyway - nothing special happened at the device
> > > level - but driver does not detect it.
> > > 
> > > Calling virtio_break_device will mark all queues as broken, as
> > > a result attempts to check whether operation completed
> > > will return false.
> > > 
> > > This probably means we need to work on handling surprise removal
> > > better in virtio blk - since it looks like actual suprise
> > > removal will hang too. But that I think is a separate issue.
> > 
> > Yeah, this situation doesn't seem like it's inherently special for
> > virtio or VFs, so it's a little surprising to see
> > pci_device_is_present() used there.
> 
> Just making sure - pci_device_is_present *is* the suggested way
> to distinguish between graceful and surprise removal, isn't it?

I'm not quite sure what you're asking here.  A driver would learn
about a graceful removal when its .remove() method is called before
the device is physically removed.  The device is still accessible and
everything should just work.

A driver would learn about a surprise removal either by a read result
that is PCI_POSSIBLE_ERROR() or possibly when its .error_detected()
callback is called.  The .remove() method will eventually be called
when we destroy the pci_dev.

I guess .remove() might use pci_device_is_present() and assume that if
it returns "true", this is a graceful removal.  But that's not
reliable since the device could be physically removed between the
pci_device_is_present() call and the driver's next access to it.

I think the best thing would be for .remove() to just do whatever it
needs to do and look for errors, e.g., using PCI_POSSIBLE_ERROR(),
without relying on pci_device_is_present().

If .remove() wants to avoid doing something that might cause an error,
maybe we should expose pci_dev_is_disconnected().  That's set by the
hotplug remove paths before .remove() is called and feels a little
less racy.

Bjorn
