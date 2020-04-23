Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBD491B66EF
	for <lists+linux-pci@lfdr.de>; Fri, 24 Apr 2020 00:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgDWWk1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Apr 2020 18:40:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:57920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbgDWWk1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Apr 2020 18:40:27 -0400
Received: from localhost (mobile-166-175-187-210.mycingular.net [166.175.187.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A58F920CC7;
        Thu, 23 Apr 2020 22:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587681627;
        bh=vtw4qEaCryTJCKZa7PoOKNpJpLKNnKxDKiH2r2cVNcg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Vl+pjjz7j17+BxwdBBJTSwpLeT2AckVWI9Em06dosPFGJFBWYbPRDlkv3RhUTbfAi
         SnoWOr8YcJ5PMcPyZqE5Mh5N9VkukUW+rhh8xgM0jSJshMrysQBD9/87nKDXvSZibs
         Z9PIMStpwczDbl1+xyPrcChi+pzgPkdX1hIR2uy8=
Date:   Thu, 23 Apr 2020 17:40:25 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>,
        linux-pci@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Remi Pommarel <repk@triplefau.lt>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 4/9] PCI: aardvark: issue PERST via GPIO
Message-ID: <20200423224025.GA250713@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200423222312.5ghfmxcxnb2l5xtz@pali>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 24, 2020 at 12:23:12AM +0200, Pali Rohár wrote:
> On Thursday 23 April 2020 17:17:14 Bjorn Helgaas wrote:
> > On Thu, Apr 23, 2020 at 09:02:02PM +0200, Pali Rohár wrote:
> > > On Thursday 23 April 2020 13:41:51 Bjorn Helgaas wrote:
> > > > [+cc Rob]
> > > > 
> > > > On Tue, Apr 21, 2020 at 01:16:56PM +0200, Marek Behún wrote:
> > > > > From: Pali Rohár <pali@kernel.org>
> > > > > 
> > > > > Add support for issuing PERST via GPIO specified in 'reset-gpios'
> > > > > property (as described in PCI device tree bindings).
> > > > > 
> > > > > Some buggy cards (e.g. Compex WLE900VX or WLE1216) are not detected
> > > > > after reboot when PERST is not issued during driver initialization.
> > > > 
> > > > Does this slot support hotplug?
> > > 
> > > I have no idea. I have not heard that anybody tried hotplugging cards
> > > with this aardvark pcie controller at runtime.
> > > 
> > > This patch fixes initialization only at boot time when cards were
> > > plugged prior powering board on.
> > > 
> > > > If so, I don't think this fix will help the hot-add case, will it?
> > > 
> > > I even do not know if aardvark HW supports it. And if yes, I think it is
> > > unimplemented and/or broken.
> > > 
> > > In documentation there is some interrupt register which could signal it,
> > > but I it is not used by kernel's pci-aardvark.c driver.
> > 
> > "lspci -vv" will show you whether the hardware claims to support it,
> > e.g.,
> > 
> >   00:1c.0 PCI bridge: Intel Corporation Sunrise Point-LP PCI Express Root Port #1
> >     Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
> >       SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
> > 
> > If the right combination of bits are set there, pciehp will claim the
> > port and support hotplug.
> 
> aardvark controller does not have pci bridge on bus. Kernel aardvark
> driver uses pci_bridge_emul_init() for registering emulated pci bridge.
> 
> Is hotplug flag from that emulated pci bridge relevant here?

I doubt it.
