Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23BC53604BF
	for <lists+linux-pci@lfdr.de>; Thu, 15 Apr 2021 10:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbhDOIqF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 15 Apr 2021 04:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbhDOIqF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Apr 2021 04:46:05 -0400
Received: from mail.nic.cz (lists.nic.cz [IPv6:2001:1488:800:400::400])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC18C061574;
        Thu, 15 Apr 2021 01:45:42 -0700 (PDT)
Received: from thinkpad (unknown [IPv6:2a0e:b107:ae1:0:3e97:eff:fe61:c680])
        by mail.nic.cz (Postfix) with ESMTPSA id 820CC140A70;
        Thu, 15 Apr 2021 10:45:38 +0200 (CEST)
Date:   Thu, 15 Apr 2021 10:45:37 +0200
From:   Marek Behun <marek.behun@nic.cz>
To:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: marvell: armada-37xx: Set linux,pci-domain
 to zero
Message-ID: <20210415104537.403de52e@thinkpad>
In-Reply-To: <20210415083640.ntg6kv6ayppxldgd@pali>
References: <20210412123936.25555-1-pali@kernel.org>
        <CAL_JsqLSse=W3TFu=Wc=eEAV4fKDGfsQ6JUvO3KyG_pnGTVg6A@mail.gmail.com>
        <20210415083640.ntg6kv6ayppxldgd@pali>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-100.0 required=5.9 tests=SHORTCIRCUIT,
        USER_IN_WELCOMELIST,USER_IN_WHITELIST shortcircuit=ham
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.nic.cz
X-Virus-Scanned: clamav-milter 0.102.2 at mail
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 15 Apr 2021 10:36:40 +0200
Pali Rohár <pali@kernel.org> wrote:

> On Tuesday 13 April 2021 13:17:29 Rob Herring wrote:
> > On Mon, Apr 12, 2021 at 7:41 AM Pali Rohár <pali@kernel.org> wrote:  
> > >
> > > Since commit 526a76991b7b ("PCI: aardvark: Implement driver 'remove'
> > > function and allow to build it as module") PCIe controller driver for
> > > Armada 37xx can be dynamically loaded and unloaded at runtime. Also driver
> > > allows dynamic binding and unbinding of PCIe controller device.
> > >
> > > Kernel PCI subsystem assigns by default dynamically allocated PCI domain
> > > number (starting from zero) for this PCIe controller every time when device
> > > is bound. So PCI domain changes after every unbind / bind operation.  
> > 
> > PCI host bridges as a module are relatively new, so seems likely a bug to me.  
> 
> Why a bug? It is there since 5.10 and it is working.
> 
> > > Alternative way for assigning PCI domain number is to use static allocated
> > > numbers defined in Device Tree. This option has requirement that every PCI
> > > controller in system must have defined PCI bus number in Device Tree.  
> > 
> > That seems entirely pointless from a DT point of view with a single PCI bridge.  
> 
> If domain id is not specified in DT then kernel uses counter and assigns
> counter++. So it is not pointless if we want to have stable domain id.

What Rob is trying to say is that
- the bug is that kernel assigns counter++
- device-tree should not be used to fix problems with how kernel does
  things
- if a device has only one PCIe controller, it is pointless to define
  it's pci-domain. If there were multiple controllers, then it would
  make sense, but there is only one
