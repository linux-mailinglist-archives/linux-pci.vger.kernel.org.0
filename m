Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C12445CC03
	for <lists+linux-pci@lfdr.de>; Wed, 24 Nov 2021 19:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbhKXS2J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Nov 2021 13:28:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbhKXS2J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Nov 2021 13:28:09 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FAFC06173E
        for <linux-pci@vger.kernel.org>; Wed, 24 Nov 2021 10:24:59 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 200so2932190pga.1
        for <linux-pci@vger.kernel.org>; Wed, 24 Nov 2021 10:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cv9LR98z/haBcGUoxtoB1LyZRHlF0e4WkqMsUbQ83LM=;
        b=yeYYVhRqpz/0ryEmg/zVDuxmBbG3xzAIcnrMUkwzZfg8iv2T91kYPG6Ppv/G9dbF0s
         RiRTqxLzrxaW6CaocImUXnXWdZOs2fB4tlKVP2Loqyz6K/huZ6y3gSan1m8DbGbwwde9
         Sp4mfSvuquEmSikFkhqC32DG++f7Pl3tcP48qT2IshVHsusxWmTcKURepg3lZBVKQDmM
         UrpNXa2vJnkaWgcuCnWETrZP52LZ1JY3/foeWMMiUYhkSB1f7llIeysmn+yvBjefGL2e
         3dHMNjVXNX8JAydvN4dYuauULqVSniujXhKeNlJcuoMqt9WbximZg1R9l5uzFqWOzfty
         mnFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cv9LR98z/haBcGUoxtoB1LyZRHlF0e4WkqMsUbQ83LM=;
        b=k29yspXPZMMKzKUY0NV7f47o9Ml39vlevTO/lw8pS+++2aG0rb6GiIk8zrG+nksEj/
         yrEBO7YlwC/AOf6lVbjUSBe+cxS3fO++lDw+Z7kRDnV3tzjBXAZNZtP52q2N1aCfLmiz
         jieegcTRT/O2Ra19l5BoQRB0aVCTlZ8VWB5MYjEn1u2XLhhebMhr8N2BRD3wDbG7cAf3
         B2CBTsTOx7NZf4B9/65pbS/x2itpi/Q04YgmXHNFvznRi+/LNCzWbGs93seax9OJyUn/
         x87SEMiIhVxWyJQdLOm1pGHy3mdNLc0DtByxm1uruPX/NOcBWZpUUTowZSIH5WkBaLHd
         SJeg==
X-Gm-Message-State: AOAM531ljbl60GYQIbbj2w02V3/k3E1cHxx+FzdT9ijtyCTmfc6OUmLw
        n57zkveivUzUzB7uZRf7uomdVzm/qeD7zbbA+/1g8A==
X-Google-Smtp-Source: ABdhPJzUQt3PryOf5wtWBEw1C6RWXhgSxvUCpainw28rcYPUxg6Z6ceywSEaUg75sFYumIC7hTm+GQW8cIpna34oV/c=
X-Received: by 2002:a63:88c3:: with SMTP id l186mr5910722pgd.377.1637778299033;
 Wed, 24 Nov 2021 10:24:59 -0800 (PST)
MIME-Version: 1.0
References: <CAPcyv4h7h3oJTEorMhL6MMD5FYbSxaWs6tb3-w=JWxhR=j77+A@mail.gmail.com>
 <20211123235557.GA2247853@bhelgaas> <CAPcyv4g0=zz8BtB9DRW0FGsRRvgGwEaQcgbmXDhJ3DwNFS9Z+g@mail.gmail.com>
 <20211124063316.GA6792@lst.de> <CAPcyv4ii=bjKNQxoMLF-gscJy7Bh8CUn205_1GpCwfMyJ22+6g@mail.gmail.com>
 <20211124072824.GA7738@lst.de> <YZ3qvtHlMkRnC74f@kroah.com>
 <CAPcyv4iYcBFDhDtcxc37EWfX1Wpuh8Zsm4-whTL0vNyY4zW3AQ@mail.gmail.com> <YZ32F0e/Cun9rB0i@kroah.com>
In-Reply-To: <YZ32F0e/Cun9rB0i@kroah.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 24 Nov 2021 10:24:48 -0800
Message-ID: <CAPcyv4i0t0Y8pPWM1x5ctcdszxHfHCG7s4_DAJeg=MG_6gcdTw@mail.gmail.com>
Subject: Re: [PATCH 20/23] cxl/port: Introduce a port driver
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Bjorn Helgaas <helgaas@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 24, 2021 at 12:22 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Nov 23, 2021 at 11:54:03PM -0800, Dan Williams wrote:
> > On Tue, Nov 23, 2021 at 11:33 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Wed, Nov 24, 2021 at 08:28:24AM +0100, Christoph Hellwig wrote:
> > > > On Tue, Nov 23, 2021 at 11:17:55PM -0800, Dan Williams wrote:
> > > > > I am missing the counter proposal in both Bjorn's and your distaste
> > > > > for aux bus and PCIe portdrv?
> > > >
> > > > Given that I've only brought in in the last mail I have no idea what
> > > > the original proposal even is.
> > >
> > > Neither do I :(
> >
> > To be clear I am also trying to get to the root of Bjorn's concern.
> >
> > The proposal in $SUBJECT is to build on / treat a CXL topology as a
> > Linux device topology on /sys/bus/cxl that references devices on
> > /sys/bus/platform (CXL ACPI topology root and Host Bridges) and
> > /sys/bus/pci (CXL Switches and Endpoints).
>
> Wait, I am confused.
>
> A bus lists devices that are on that bus.  It does not list devices that
> are on other busses.
>
> Now a device in a bus list can have a parent be on different types of
> busses, as the parent device does not matter, but the device itself can
> not be of different types.
>
> So I do not understand what you are describing here at all.  Do you have
> an example output of sysfs that shows this situation?

Commit 40ba17afdfab ("cxl/acpi: Introduce cxl_decoder objects")

...has an example of the devices registered on the CXL bus by the
cxl_acpi driver.

> > This CXL port device topology has already been shipping for a few
> > kernel cycles.
>
> So it's always been broken?  :)

Kidding aside, CXL has different moving pieces than PCI and the Linux
device-driver model is how we are organizing that complexity. CXL is
also symbiotically attached to PCI as it borrows the enumeration
mechanism while building up a parallel CXL.mem universe to live
alongside PCI.config and PCI.mmio. The CXL subsystem is similar to MD
/ DM where virtual devices are built up from other devices.

> > What is on
> > the table now is a driver for CXL port devices (a logical Linux
> > construct). The driver handles discovery of "component registers"
> > either by ACPI table or PCI DVSEC and offers services to proxision CXL
> > regions.
>
> So a normal bus controller device that creates new devices of a bus
> type, right?  What is special about that?

Yes, which is the root of my confusion about Bjorn's concern.

> > CXL 'regions' are also proposed as Linux devices that
> > represent an active CXL memory range which can interleave multiple
> > endpoints across multiple switches and host bridges.
>
> As long as these 'devices' have drivers and do not mess with the
> resources of any other device in the system, I do not understand the
> problem here.

Correct, these drivers manage CXL.mem resources and leave PCI.mmio
resource management to PCI.

> Or is the issue that you are again trying to carve up "real" devices
> into tiny devices that then somehow need to be aware of the resources
> being touched by different drivers at the same time?

No, there's no multiplexing of resources across devices / drivers that
requires cross-driver awareness.

> I'm still confused, sorry.

No worries, appreciate the attention to make sure this implementation
is idiomatic and avoids any architectural dragons.
