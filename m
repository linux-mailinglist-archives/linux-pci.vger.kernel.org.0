Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00A5E34CE0D
	for <lists+linux-pci@lfdr.de>; Mon, 29 Mar 2021 12:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbhC2Kke (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Mar 2021 06:40:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:45960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231842AbhC2Kkb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Mar 2021 06:40:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 21FDF6192B;
        Mon, 29 Mar 2021 10:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617014430;
        bh=1bwAu+A9nWc4hRxv9ICbykOqZtzSHWV2ft8Sxgq3Vfg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nFxHNRM/LWArdKC+besjAV5l9HY6/NBl5bhm0hyzhXDdjUoAPj4NzmSuXZ9dfvhTh
         t6b9F4BYadHNNMg9EY0k7+cLHsOs93gOTt0hR1GQtWTYaW7WhodYiQJVFCwieKx0K7
         kHu3cwE4DoNnNQOjZj6oQFcvqAPCM5XnPFlFTJcw=
Date:   Mon, 29 Mar 2021 12:40:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH v9 4/4] docs: ABI: Add sysfs documentation interface of
 dw-xdata-pcie driver
Message-ID: <YGGunNguZTiRS8FP@kroah.com>
References: <cover.1617011831.git.gustavo.pimentel@synopsys.com>
 <5840637a206dd1287caf142a0dbedf0dac9ccd48.1617011831.git.gustavo.pimentel@synopsys.com>
 <YGGnC8LouF+paZ6G@kroah.com>
 <DM5PR12MB18353C0E6935F94C457F9595DA7E9@DM5PR12MB1835.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR12MB18353C0E6935F94C457F9595DA7E9@DM5PR12MB1835.namprd12.prod.outlook.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 29, 2021 at 10:25:25AM +0000, Gustavo Pimentel wrote:
> On Mon, Mar 29, 2021 at 11:8:11, Greg Kroah-Hartman 
> <gregkh@linuxfoundation.org> wrote:
> 
> > On Mon, Mar 29, 2021 at 11:59:40AM +0200, Gustavo Pimentel wrote:
> > > This patch describes the sysfs interface implemented on the dw-xdata-pcie
> > > driver.
> > > 
> > > Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > > ---
> > >  Documentation/ABI/testing/sysfs-driver-xdata | 46 ++++++++++++++++++++++++++++
> > >  1 file changed, 46 insertions(+)
> > >  create mode 100644 Documentation/ABI/testing/sysfs-driver-xdata
> > > 
> > > diff --git a/Documentation/ABI/testing/sysfs-driver-xdata b/Documentation/ABI/testing/sysfs-driver-xdata
> > > new file mode 100644
> > > index 00000000..66af19a
> > > --- /dev/null
> > > +++ b/Documentation/ABI/testing/sysfs-driver-xdata
> > > @@ -0,0 +1,46 @@
> > > +What:		/sys/class/misc/drivers/dw-xdata-pcie.<device>/write
> > > +Date:		April 2021
> > > +KernelVersion:	5.13
> > > +Contact:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > > +Description:	Allows the user to enable the PCIe traffic generator which
> > > +		will create write TLPs frames - from the Root Complex to the
> > > +		Endpoint direction.
> > > +		Usage e.g.
> > > +		 echo 1 > /sys/class/misc/dw-xdata-pcie.<device>/write
> > 
> > Again, this does not match the code.  Either fix the code (which I
> > recommend), or change this and the other sysfs descriptions of writing
> > values here.
> 
> I've commented about this previously, but I didn't get feedback on it, 
> therefore I assumed that justification was okay.
> I will change the code to accept only the "1" input on the *_store()

Why not use the built-in function to parse "1/y/Y" that the kernel
provides for this type of thing?

thanks,

greg k-h
