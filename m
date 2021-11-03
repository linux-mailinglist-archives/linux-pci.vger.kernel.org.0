Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A0344441B
	for <lists+linux-pci@lfdr.de>; Wed,  3 Nov 2021 15:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbhKCPB6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Nov 2021 11:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbhKCPB6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Nov 2021 11:01:58 -0400
X-Greylist: delayed 612 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 03 Nov 2021 07:59:22 PDT
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E424FC061714;
        Wed,  3 Nov 2021 07:59:21 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 0719692009D; Wed,  3 Nov 2021 15:59:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 00ED792009B;
        Wed,  3 Nov 2021 14:59:20 +0000 (GMT)
Date:   Wed, 3 Nov 2021 14:59:20 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Marvell: Update PCIe fixup
In-Reply-To: <20211102154831.xtrlgrmrizl5eidl@pali>
Message-ID: <alpine.DEB.2.21.2111031449440.57165@angie.orcam.me.uk>
References: <20211101150405.14618-1-pali@kernel.org> <20211102084241.GA6134@alpha.franken.de> <20211102090246.unmbruykfdjabfga@pali> <20211102094700.GA7376@alpha.franken.de> <20211102100034.rhcb3k2jvr6alm6y@pali> <alpine.DEB.2.21.2111021210180.57165@angie.orcam.me.uk>
 <20211102125843.sqsusis4krnmhorq@pali> <alpine.DEB.2.21.2111021312160.57165@angie.orcam.me.uk> <20211102144929.c5wt5pbl42ocrxly@pali> <20211102154831.xtrlgrmrizl5eidl@pali>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2 Nov 2021, Pali Rohár wrote:

> So the conclusion is that there is also some RESET configuration via
> BootCS (I have no idea what it is or was). And default value (when RESET
> configuration is not used) is always "Memory controller" due to
> existence of "broken PC BIOSes" (probably x86).

 BootCS is one of the chip selects for the memory/device bus (AD bus), one 
of the three (or four in dual-PCI implementations), along with the SysAD 
bus and the PCI bus(es), interconnected, which is where DRAM sits as well 
as possibly other locally accessed devices with the Galileo system 
controllers.  See Figure 5 on page 23 of the GT-64111 document.

  Maciej
