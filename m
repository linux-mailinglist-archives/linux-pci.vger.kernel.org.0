Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B88491B66B3
	for <lists+linux-pci@lfdr.de>; Fri, 24 Apr 2020 00:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgDWWXQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Apr 2020 18:23:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:51372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbgDWWXP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Apr 2020 18:23:15 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21EE72074F;
        Thu, 23 Apr 2020 22:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587680595;
        bh=9Nrt0OxqT5utotJoqTQIINDGg/pqsdOEZXHqutpH39A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UkR4pF/0OtaK2GkEm7C25nnaxmGlkm7jMkiY05a487p/R6Zs0463Y9ZOgDlsqLdaA
         pv+s8R0mlGVchdL2NPsF7LhVzFj9UfGlg3GuoeHiv4vB1vKRQ/KJ81EyzKyrX+lQTS
         7CxOjAsNnRpULeUMOMiKLR9nF91SUOH3Lez5wJoY=
Received: by pali.im (Postfix)
        id D71A67E0; Fri, 24 Apr 2020 00:23:12 +0200 (CEST)
Date:   Fri, 24 Apr 2020 00:23:12 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
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
Message-ID: <20200423222312.5ghfmxcxnb2l5xtz@pali>
References: <20200423190202.ssbhwoupmssrdcyi@pali>
 <20200423221714.GA247156@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200423221714.GA247156@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 23 April 2020 17:17:14 Bjorn Helgaas wrote:
> On Thu, Apr 23, 2020 at 09:02:02PM +0200, Pali Rohár wrote:
> > On Thursday 23 April 2020 13:41:51 Bjorn Helgaas wrote:
> > > [+cc Rob]
> > > 
> > > On Tue, Apr 21, 2020 at 01:16:56PM +0200, Marek Behún wrote:
> > > > From: Pali Rohár <pali@kernel.org>
> > > > 
> > > > Add support for issuing PERST via GPIO specified in 'reset-gpios'
> > > > property (as described in PCI device tree bindings).
> > > > 
> > > > Some buggy cards (e.g. Compex WLE900VX or WLE1216) are not detected
> > > > after reboot when PERST is not issued during driver initialization.
> > > 
> > > Does this slot support hotplug?
> > 
> > I have no idea. I have not heard that anybody tried hotplugging cards
> > with this aardvark pcie controller at runtime.
> > 
> > This patch fixes initialization only at boot time when cards were
> > plugged prior powering board on.
> > 
> > > If so, I don't think this fix will help the hot-add case, will it?
> > 
> > I even do not know if aardvark HW supports it. And if yes, I think it is
> > unimplemented and/or broken.
> > 
> > In documentation there is some interrupt register which could signal it,
> > but I it is not used by kernel's pci-aardvark.c driver.
> 
> "lspci -vv" will show you whether the hardware claims to support it,
> e.g.,
> 
>   00:1c.0 PCI bridge: Intel Corporation Sunrise Point-LP PCI Express Root Port #1
>     Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
>       SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
> 
> If the right combination of bits are set there, pciehp will claim the
> port and support hotplug.

aardvark controller does not have pci bridge on bus. Kernel aardvark
driver uses pci_bridge_emul_init() for registering emulated pci bridge.

Is hotplug flag from that emulated pci bridge relevant here?
