Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A25E441FB6
	for <lists+linux-pci@lfdr.de>; Mon,  1 Nov 2021 18:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbhKAR70 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Nov 2021 13:59:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:38238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231588AbhKAR7Z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Nov 2021 13:59:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 18F5761058;
        Mon,  1 Nov 2021 17:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635789412;
        bh=WiBnBHSIxqp0Vb1O0pxCkDHWFMkUCELEPiehK40+ZKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aVdP8F7F6fz6jgIKfc2ajaeENARDqkZHRoiVDxh/Ma5cZKhpweZ08+jODd4OkbyJT
         lRIR5eY2+HEqVrB/ms6puYfjuBXkYh+sSMXLsxoE4z63rSUjH8WwafreXi/rufw4/9
         MdvM43T7PbJX4Qj7J7yA5RglCBQrSkPqboxSloxJKhi4yZnbD6wWTZueLcHxfni2pg
         wkznNkOK1o0GQbV9WjeArMtpJDxowkcuCvW7H+UBvi5FUJMEx/37d43ZeXyTQk0SGS
         PwsIAhkz909BPIvtcZlLSD/b1Lf6+EY9Jb/eKHKE6+bkis9w912NHmcPdqcU6nuI8C
         4u9mwIIFOGBCw==
Received: by pali.im (Postfix)
        id 875FA7E4; Mon,  1 Nov 2021 18:56:49 +0100 (CET)
Date:   Mon, 1 Nov 2021 18:56:49 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Marvell: Update PCIe fixup
Message-ID: <20211101175649.q743eg65jpjtk7sd@pali>
References: <20211101150405.14618-1-pali@kernel.org>
 <20211101162711.GA2744544@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211101162711.GA2744544@nvidia.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Monday 01 November 2021 13:27:11 Jason Gunthorpe wrote:
> On Mon, Nov 01, 2021 at 04:04:05PM +0100, Pali Rohár wrote:
> > - The code relies on rc_pci_fixup being called, which only happens
> >   when CONFIG_PCI_QUIRKS is enabled, so add that to Kconfig. Omitting
> >   this causes a booting failure with a non-obvious cause.
> > - Update rc_pci_fixup to set the class properly, copying the
> >   more modern style from other places
> > - Correct the rc_pci_fixup comment
> > 
> > This patch just re-applies commit 1dc831bf53fd ("ARM: Kirkwood: Update
> > PCI-E fixup") for all other Marvell platforms which use same buggy PCIe
> > controller.
> 
> I wonder if that code is even relevant any more since we started using
> CONFIG_PCI_MVEBU
> 
> ?

It is (still) relevant for platforms which do not use CONFIG_PCI_MVEBU
yet.

> Really, these broken controllers should not be used "raw" but always
> via their special host bridge driver that fixes all the config space
> problems.

I agree.

Long-term goal should be to convert these platforms to use pci-mvebu.c
driver. And until it happens simple fixes like in commit 1dc831bf53fd is
needed for all affected Marvell platforms.

Some details how these Marvell PCIe controllers are broken is in email:
https://lore.kernel.org/linux-pci/20211003120944.3lmwxylnhlp2kfj7@pali/
