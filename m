Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A93636F079
	for <lists+linux-pci@lfdr.de>; Thu, 29 Apr 2021 21:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbhD2TYy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Apr 2021 15:24:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:35538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231357AbhD2TX5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Apr 2021 15:23:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5829C6144E;
        Thu, 29 Apr 2021 19:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619724190;
        bh=OI/1szp0Xz/VR6hQfYsOdCzY1+KuV4hjYKsyihyrzaI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qiBeWbFqFd2JW+/IeA0A/6z7EAL745roaQhToyMH5LNFjKEyPoMKYvXTHyRihqrig
         rZTQj+E6Inw21VxjBrXQUX8Vt2kWY54i9gpdF4vecvViXPX7bXhpXcSn6JejUef+3s
         tYPO8UIUxpwyGtAD2ilee+FGOT82PpKTDBnJbdcLxOmjsQbG/A2fig/7l6ZRLD7bJr
         mA27SVK4k79jN37lAwBEQlMN5Q9PcVM2qqAFUy/fKRKeHK+kDNFjTRS7GBs8UeY5Xo
         2c2iT/7Il0qf2lcp/D9X45wDwUd6yN6EEQfEe4mtYE9SkGdzWuiJi6vxpvWNQkfedK
         r4rmnpGLXkE0A==
Date:   Thu, 29 Apr 2021 14:23:08 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-pci@vger.kernel.org, ckoenig.leichtzumerken@gmail.com,
        daniel.vetter@ffwll.ch, Harry.Wentland@amd.com,
        ppaalanen@gmail.com, Alexander.Deucher@amd.com,
        gregkh@linuxfoundation.org, Felix.Kuehling@amd.com
Subject: Re: [PATCH v5 08/27] PCI: add support for dev_groups to struct
 pci_device_driver
Message-ID: <20210429192308.GA510492@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c315d0d0-6fd8-0510-99c6-dd72bd583c0a@amd.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 29, 2021 at 12:53:15PM -0400, Andrey Grodzovsky wrote:
> On 2021-04-28 12:53 p.m., Bjorn Helgaas wrote:
> > On Wed, Apr 28, 2021 at 11:11:48AM -0400, Andrey Grodzovsky wrote:
> > > This is exact copy of 'USB: add support for dev_groups to
> > > struct usb_device_driver' patch by Greg but just for
> > > the PCI case.

> > ...
> > The usual commit citation format is 7d9c1d2f7aca ("USB: add support
> > for dev_groups to struct usb_device_driver") so it's easier to locate
> > the commit.
> > 
> > I see there is also b71b283e3d6d ("USB: add support for dev_groups to
> > struct usb_driver").  I don't know enough about USB to know whether
> > 7d9c1d2f7aca or b71b283e3d6d is a closer analogue to what you're doing
> > here, but I do see that struct usb_driver is far more common than
> > struct usb_device_driver.
> > 
> > PCI has struct pci_driver, but doesn't have the concept of a struct
> > pci_device_driver.
> 
> Since we don't have pci_device_driver then pci_driver is the best place
> for it then, no ?

Of course.  My point was just that maybe you should say this is
similar to b71b283e3d6d ("USB: add support for dev_groups to struct
usb_driver"), not similar to 7d9c1d2f7aca ("USB: add support for
dev_groups to struct usb_device_driver").

Bjorn
