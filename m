Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444921D752F
	for <lists+linux-pci@lfdr.de>; Mon, 18 May 2020 12:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgERKaH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 May 2020 06:30:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:32904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbgERKaH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 May 2020 06:30:07 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF8FC207ED;
        Mon, 18 May 2020 10:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589797806;
        bh=Sf1JheQuxgic/yXSR/EPXNFwtvaoa4Ub/q1l21Oq5jo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2RSZnkvH3M3vTEJsTumTgFRb/xWah7mnoyzpfX1RsCwszzwCQnrWL/+Z22YZaL5Vx
         gUMP3eLiOIog+yoyhMDpx31Mce7Xtifss5kcjXvd08M7qZqnHEZrbwMRkbM1TN0ETk
         zvRJdSZmv869eUhJxKjn8WRLf8tKwniFbUQZp1d0=
Received: by pali.im (Postfix)
        id 64D1089D; Mon, 18 May 2020 12:30:04 +0200 (CEST)
Date:   Mon, 18 May 2020 12:30:04 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>,
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 00/12] PCI: aardvark: Fix support for Turris MOX and
 Compex wifi cards
Message-ID: <20200518103004.6tydnad3apkfn77y@pali>
References: <20200430080625.26070-1-pali@kernel.org>
 <20200513135643.478ffbda@windsurf.home>
 <87pnb2h7w1.fsf@FE-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87pnb2h7w1.fsf@FE-laptop>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sunday 17 May 2020 17:57:02 Gregory CLEMENT wrote:
> Hello,
> 
> > Hello,
> >
> > On Thu, 30 Apr 2020 10:06:13 +0200
> > Pali Rohár <pali@kernel.org> wrote:
> >
> >> Marek Behún (5):
> >>   PCI: aardvark: Improve link training
> >>   PCI: aardvark: Add PHY support
> >>   dt-bindings: PCI: aardvark: Describe new properties
> >>   arm64: dts: marvell: armada-37xx: Set pcie_reset_pin to gpio function
> >>   arm64: dts: marvell: armada-37xx: Move PCIe comphy handle property
> >> 
> >> Pali Rohár (7):
> >>   PCI: aardvark: Train link immediately after enabling training
> >>   PCI: aardvark: Don't blindly enable ASPM L0s and don't write to
> >>     read-only register
> >>   PCI: of: Zero max-link-speed value is invalid
> >>   PCI: aardvark: Issue PERST via GPIO
> >>   PCI: aardvark: Add FIXME comment for PCIE_CORE_CMD_STATUS_REG access
> >>   PCI: aardvark: Replace custom macros by standard linux/pci_regs.h
> >>     macros
> >>   arm64: dts: marvell: armada-37xx: Move PCIe max-link-speed property
> >
> > Thanks a lot for this work. For a number of reasons, I'm less involved
> > in Marvell platform support in Linux, but I reviewed your series and
> > followed the discussions around it, and I'm happy to give my:
> >
> > Acked-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> 
> With this acked-by for the series, the reviewed-by from Rob on the
> binding and the tested-by, I am pretty confident so I applied the
> patches 10, 11 and 12 on mvebu/dt64.
> 
> Thanks,
> 
> Gregory

Thank you!

Lorenzo, would you now take remaining patches?

> 
> >
> > for the whole series. The changes all seem sensible, and have been
> > tested by several folks.
> >
> > Thanks!
> >
> > Thomas
> > -- 
> > Thomas Petazzoni, CTO, Bootlin
> > Embedded Linux and Kernel engineering
> > https://bootlin.com
> 
> -- 
> Gregory Clement, Bootlin
> Embedded Linux and Kernel engineering
> http://bootlin.com
