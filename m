Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3BFA318B36
	for <lists+linux-pci@lfdr.de>; Thu, 11 Feb 2021 13:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhBKMxS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Feb 2021 07:53:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:56644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231383AbhBKMuz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Feb 2021 07:50:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 73E4564E2E;
        Thu, 11 Feb 2021 12:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613047814;
        bh=8/oehDChx5waeEQqVGP9ccJz4ZCiidcZ3MbufrThYR4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OAcCnRR/sJWRlx5pHaunE1yXC8t5yXHUVTeP6xsD8ght59I1PC4+NZ327gSRKt4Sm
         RFLDHURbz4lYKL7ZK+2sYakZhOjrMVGiWmZK6thxDGxsgxC+oJWMLR1usBTkBBSAUR
         jGQMXb5I81h/aVn7vjgG/B9FN975XxEEECksrb8s=
Date:   Thu, 11 Feb 2021 13:50:12 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Aaron Ma <aaron.ma@canonical.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Lee Jones <lee.jones@linaro.org>, peter.chen@nxp.com,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] xhci-pci: Set AMD Renoir USB controller to D3 when
 shutdown
Message-ID: <YCUoBP4GUrGL0J3J@kroah.com>
References: <20210204051850.64857-1-aaron.ma@canonical.com>
 <CAAd53p4euFiw7pfDnD2H8oMVeeTqQ_c+wOFDLM2xPccn5MewiA@mail.gmail.com>
 <cd4595e6-67da-885c-1a67-6dfd71425b8c@canonical.com>
 <CAAd53p4z1ydFi5pwOZJnsrBDPNVLKU0ygqa0+kdZdXWYocPLgQ@mail.gmail.com>
 <YCJJrVp2DvCzigCw@kroah.com>
 <00de6927-3fa6-a9a3-2d65-2b4d4e8f0012@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00de6927-3fa6-a9a3-2d65-2b4d4e8f0012@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 10, 2021 at 03:13:30PM +0200, Mathias Nyman wrote:
> On 9.2.2021 10.37, Greg Kroah-Hartman wrote:
> > On Fri, Feb 05, 2021 at 02:50:15PM +0800, Kai-Heng Feng wrote:
> >> On Fri, Feb 5, 2021 at 2:45 PM Aaron Ma <aaron.ma@canonical.com> wrote:
> >>>
> >>>
> >>> On 2/5/21 12:27 PM, Kai-Heng Feng wrote:
> >>>> Can you please test the following patch, which should address the root cause:
> >>>> https://lore.kernel.org/linux-acpi/20201201213019.1558738-1-furquan@google.com/
> >>>>
> >>>> It also helps another AMD laptop on S5:
> >>>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1912935
> >>>>
> >>>
> >>> No, this patch doesn't help on ThinkPad AMD platform.
> >>
> >> Thanks for the confirmation!
> >>
> >> Acked-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > 
> > Mathias, want me to take this in my tree now, or are you going to send
> > me more patches for 5.12-rc1?
> > 
> 
> Nothing more for 5.12-rc1 from me.
> 
> Could this be a PCI quirk instead of xhci?
> Maybe there is some PCI flag for this already, haven't checked yet.
> 
> We want a specific PCI device to go to PCI D3cold at PCI shutdown...

There probably is.  Kay-Heng, can you look into doing that instead?

thanks,

greg k-h
