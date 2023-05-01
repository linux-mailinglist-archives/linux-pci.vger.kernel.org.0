Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C73A6F3B11
	for <lists+linux-pci@lfdr.de>; Tue,  2 May 2023 01:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjEAXs6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 May 2023 19:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbjEAXr6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 May 2023 19:47:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AC9358B
        for <linux-pci@vger.kernel.org>; Mon,  1 May 2023 16:47:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C0B162036
        for <linux-pci@vger.kernel.org>; Mon,  1 May 2023 23:47:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F19D5C433D2;
        Mon,  1 May 2023 23:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682984876;
        bh=tDpd21tGKFTe5xeAgZInQx1DWKsVjiIWei2U+dU5OZs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uFU80+qD7tDhH5RLXOAaQaRJ6s5o2Ozz2u4Z5+J/7IwobUB5FaEyg3vppbVOoRwcB
         tvzJrRKyKi1/Iz4PhzUsQp52DaPxFnm+XzTbiFnA7WKgGt4jvCRGa/HFg0+A5fHDho
         WIb0s+KRomEHK26EVfm6uWRGnu1wj4D8y1ofKOZI=
Date:   Tue, 2 May 2023 08:47:53 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Ashutosh Sharma <ashutosh.dandora4@gmail.com>,
        linux-pci@vger.kernel.org, alex.williamson@redhat.com,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Timothy Redaelli <tredaelli@redhat.com>
Subject: Re: How to disable Linux kernel nvme driver for a particular PCI
 address ?
Message-ID: <2023050252-sitting-clean-8649@gregkh>
References: <CADOvten3LND2XnKbUuEmKni7c93DPXdP99ZbW84mouGtdBSHZw@mail.gmail.com>
 <20230501163128.GA587981@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230501163128.GA587981@bhelgaas>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 01, 2023 at 11:31:28AM -0500, Bjorn Helgaas wrote:
> [+cc Greg, Rafael, Timothy]
> 
> On Mon, May 01, 2023 at 12:19:39PM +0530, Ashutosh Sharma wrote:
> > Hi,
> > 
> > I have multiple NVMe drives of same type (same vendor and same model)
> > attached to my system running Ubuntu 22.04.2 LTS with Linux kernel
> > version 5.19.0-35-generic.I have unbound one drive from 'nvme' driver
> > and bound to the 'vfio-pci' driver using "driverctl
> > set-override"command.

First off, I just "love" how the vfio people have taken a debugging tool
and made it part of a "enterprise configuration" process.  That's a
horrible hack and the vfio developers really should not be doing this as
people have found out.

> > But when I perform the hot plugging on that particular drive, then
> > after plugged in, the drive by default binds with 'nvme' driver. So, I
> > want to permanently bypass/disable the 'nvme' driver only for a
> > particular pci address/slot. I cannot blacklist the 'nvme' driver
> > entirely, as other drives still need to be bound with 'nvme' driver.
> > 
> > So, Is there any way to disable the 'nvme' driver for a particular PCI
> > address/slot ?
> 
> I think this is more of a device model or udev question than a PCI
> subsystem question, so I cc'd some of those folks.

It's up to userspace to write tools to do this if they want to continue
to force userspace to be the one that does this binding/unbinding for
the vfio drivers.  Otherwise, the vfio driver itself should be the one
doing the binding to the device automatically, not the nvme driver, IF
that driver is supposed to be the one actually controlling it.

sorry, and good luck!

greg k-h
