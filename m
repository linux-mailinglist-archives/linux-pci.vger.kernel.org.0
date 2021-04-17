Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63BFD3630B7
	for <lists+linux-pci@lfdr.de>; Sat, 17 Apr 2021 16:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236355AbhDQOuX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 17 Apr 2021 10:50:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:33438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236187AbhDQOuX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 17 Apr 2021 10:50:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 78EEE610CD;
        Sat, 17 Apr 2021 14:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618670996;
        bh=qehR/qi1HdpadgVx4RXRuIlyvC1z5fqzguqhj2k70oM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qKO66V5uRMBz/SaS5RCWc+6FwVV1Qd8rmptpEUkUfbB5AIzrhaegfdqvqZHeLwndv
         5ytO2BuDO0x/vtkEzgpBCd3jtco/kFonXd0odds6Fm0hKJJjVRnO4uC2s3gYzCc/Yr
         fk9/ah/KHiMENIkEuvMXyFkPS9fj84AM6YiOODRzJslViyn7j9JIQq2Nfl7IpUXWgo
         H9synoDM8lJ3K6w/JNowfj9shByw1C9m8oPLfRtY0MiTFX10DRY2yXURpvtgIxPo4r
         sRdhZl1QHqf+8ojZTU5GhKtT5dMyE51OlklFZ+KuBaoxEm5oitvvDTfz4NymBcxMxv
         En5Rh5zvrpfQg==
Received: by pali.im (Postfix)
        id 94E1B9F7; Sat, 17 Apr 2021 16:49:53 +0200 (CEST)
Date:   Sat, 17 Apr 2021 16:49:53 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Marek Behun <marek.behun@nic.cz>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: marvell: armada-37xx: Set linux,pci-domain
 to zero
Message-ID: <20210417144953.pznysgn5rdraxggx@pali>
References: <20210412123936.25555-1-pali@kernel.org>
 <CAL_JsqLSse=W3TFu=Wc=eEAV4fKDGfsQ6JUvO3KyG_pnGTVg6A@mail.gmail.com>
 <20210415083640.ntg6kv6ayppxldgd@pali>
 <20210415104537.403de52e@thinkpad>
 <CAL_JsqL2gjprb3MDv8KPSpe0CUBFjGajnMbF71DM+F9Yewp2uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqL2gjprb3MDv8KPSpe0CUBFjGajnMbF71DM+F9Yewp2uw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 15 April 2021 10:13:17 Rob Herring wrote:
> On Thu, Apr 15, 2021 at 3:45 AM Marek Behun <marek.behun@nic.cz> wrote:
> >
> > On Thu, 15 Apr 2021 10:36:40 +0200
> > Pali Rohár <pali@kernel.org> wrote:
> >
> > > On Tuesday 13 April 2021 13:17:29 Rob Herring wrote:
> > > > On Mon, Apr 12, 2021 at 7:41 AM Pali Rohár <pali@kernel.org> wrote:
> > > > >
> > > > > Since commit 526a76991b7b ("PCI: aardvark: Implement driver 'remove'
> > > > > function and allow to build it as module") PCIe controller driver for
> > > > > Armada 37xx can be dynamically loaded and unloaded at runtime. Also driver
> > > > > allows dynamic binding and unbinding of PCIe controller device.
> > > > >
> > > > > Kernel PCI subsystem assigns by default dynamically allocated PCI domain
> > > > > number (starting from zero) for this PCIe controller every time when device
> > > > > is bound. So PCI domain changes after every unbind / bind operation.
> > > >
> > > > PCI host bridges as a module are relatively new, so seems likely a bug to me.
> > >
> > > Why a bug? It is there since 5.10 and it is working.
> 
> I mean historically, the PCI subsystem didn't even support host
> bridges as a module. They weren't even proper drivers and it was all
> arch specific code. Most of the host bridge drivers are still built-in
> only. This seems like a small detail that was easily overlooked.
> unbind is not a well tested path.

Ok! Just to note that during my testing I have not spotted any issue.

> > > > > Alternative way for assigning PCI domain number is to use static allocated
> > > > > numbers defined in Device Tree. This option has requirement that every PCI
> > > > > controller in system must have defined PCI bus number in Device Tree.
> > > >
> > > > That seems entirely pointless from a DT point of view with a single PCI bridge.
> > >
> > > If domain id is not specified in DT then kernel uses counter and assigns
> > > counter++. So it is not pointless if we want to have stable domain id.
> >
> > What Rob is trying to say is that
> > - the bug is that kernel assigns counter++
> > - device-tree should not be used to fix problems with how kernel does
> >   things
> > - if a device has only one PCIe controller, it is pointless to define
> >   it's pci-domain. If there were multiple controllers, then it would
> >   make sense, but there is only one
> 
> Yes. I think what we want here is a domain bitmap rather than a
> counter and we assign the lowest free bit. That could also allow for
> handling a mixture of fixed domain numbers and dynamically assigned
> ones.

Currently this code is implemented in pci_bus_find_domain_nr() function.
IIRC domain number is 16bit integer, so plain bitmap would consume 8 kB
of memory. I'm not sure if it is fine or some other tree-based structure
for allocated domain numbers is needed.

> You could create scenarios where the numbers change on you, but it
> wouldn't be any different than say plugging in USB serial adapters.
> You get the same ttyUSBx device when you re-attach unless there's been
> other ttyUSBx devices attached/detached.

This should be fine for most scenarios. Dynamically attaching /
detaching PCI domain is not such common action...

Will you implement this new feature?
