Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C157630C297
	for <lists+linux-pci@lfdr.de>; Tue,  2 Feb 2021 15:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234607AbhBBOzt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Feb 2021 09:55:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:59260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234675AbhBBOvP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Feb 2021 09:51:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DBCEB64D99;
        Tue,  2 Feb 2021 14:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612277434;
        bh=07hLbFCtDkZ4eTQCPgWqQLt7zEthQROapxH1XvnUpuA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JG701PiarFPgrg+8iCT9jviYVpKuFI0MHNXPVYKSyBKYgtRYijz49x1U17vLV0kqp
         OzBdzX8WO+jN2kbJ3emjJYV5Txd10RiCihzTPd3i7An4wpsHX7hv2xeOIXzVyIVJSA
         jn7kTYK7iuVicxzuGEp395Hy5zd7fFZp+vUW9gKtNQPs2dL/Lad16pnjFAwqRSKryf
         smt4WMaCjslXeKe9ZG+tC84itv/zNFracdYlDjJdLNsw7LaNg4SKDCTsAyar/84uKG
         vPDvcH/z60otMlvCTEq3DuqDezihM2zhTN5RQ+3bj83S9KnhoS6m1Z81+buUygjAP8
         SQ6S4Jq60UxwQ==
Date:   Tue, 2 Feb 2021 15:50:28 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 09/13] pci: dwc: pcie-kirin: allow to optionally require
 a regulator
Message-ID: <20210202155028.28b0cf94@coco.lan>
In-Reply-To: <20210202134101.GB5154@sirena.org.uk>
References: <cover.1612271903.git.mchehab+huawei@kernel.org>
        <7f4abd1ba9f4b33fe6f66213f56aa4269db74317.1612271903.git.mchehab+huawei@kernel.org>
        <20210202134101.GB5154@sirena.org.uk>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Mark,

Em Tue, 2 Feb 2021 13:41:01 +0000
Mark Brown <broonie@kernel.org> escreveu:

> On Tue, Feb 02, 2021 at 02:29:54PM +0100, Mauro Carvalho Chehab wrote:
> > On Hikey 970, there's a power supply controlled by Hi6421v600
> > regulator that turns on the PCI devices on the board. Without
> > that, no PCI hardware would work.
> > 
> > As this is device-dependent, such regulator line should be
> > optional.  
> 
> Supplies should only be optional if they may be physically absent from
> the system, 

That's the case. On Hikey 960, the PCIe hardware supported by this
driver doesn't require any regulator.

On Hikey 970, the PCIe hardware is more complex. Some components
are outside the SoC, and those require a regulator to be powered
up.

> if they are just sometimes not described well in firmware
> they should be requested via the normal regulator_get() interface, the
> core will supply a dummy regulator if there is nothing at all in the
> firmware description.

For Hikey 970, a normal regulator_get() would work.

> Supplies should also generally be referred to with the naming used in
> the datasheet for the part.

Ok, I'll rename it to "pcie_vdd", which better reflects the 
schematics.

Thanks,
Mauro
