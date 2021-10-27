Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57B5843D5E5
	for <lists+linux-pci@lfdr.de>; Wed, 27 Oct 2021 23:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbhJ0Vk1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Oct 2021 17:40:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:41594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232045AbhJ0VkX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 Oct 2021 17:40:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5303360D42;
        Wed, 27 Oct 2021 21:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635370677;
        bh=vLiIfNu/LBHkvASsSz6r5IhCi/TCTkMibmd4RzIo5SE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r1PDHPT+08Enf9PlduEp8ddfwQUMPja4rCnQKhPSOgmlm1EBbTUZRDB3IcbDeQjP1
         qfigBf9vX5z/PCnvL5NMx7JaDpA63Ru8oo5ESUJ9Hk1hJZgJgqFcVnLPp7uEmmV/R7
         +muYlfp9JcaP3f7Dtw2KJPYdvgoYFWXhuu8EHx5LNC98kZ0d2+qaTVMPNEDSo3SNuG
         HaB4gcSEn9/xy39dY5ng1qZ8MoR8snl1al+ntiz9XVbbHqXzHbkIWq3f7274Zwf98F
         MEOMKAp9H5oRspDIr6IDipytX89HIZbwAOitIyRC6BIBavrdAE8ctAN2tCcc7XcNHu
         CyMezx2VSVCTg==
Received: by pali.im (Postfix)
        id 0B651894; Wed, 27 Oct 2021 23:37:54 +0200 (CEST)
Date:   Wed, 27 Oct 2021 23:37:54 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jim Quinlan <james.quinlan@broadcom.com>,
        Rob Herring <robh@kernel.org>,
        Jim Quinlan <jim2101024@gmail.com>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Saenz Julienne <nsaenzjulienne@suse.de>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/6] dt-bindings: PCI: Add bindings for Brcmstb EP
 voltage regulators
Message-ID: <20211027213754.bnswkijrqinackgt@pali>
References: <CA+-6iNyxYm4Sf6EsKjmedi8RF-CZKsXs9KXMjaTd_xqnyFL8ZA@mail.gmail.com>
 <20211027165857.GA229979@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211027165857.GA229979@bhelgaas>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 27 October 2021 11:58:57 Bjorn Helgaas wrote:
> On Tue, Oct 26, 2021 at 05:27:32PM -0400, Jim Quinlan wrote:
> 
> > I don't think it matters but our PCIe controllers only have a single
> > root port.
> 
> Just to kibitz, and I don't know anything about the DT binding under
> discussion here, but I would prefer if DTs and drivers did not have
> the "single root port" assumption baked deeply in them.

+1

Please look also at my proposal for similar/same issue:
https://lore.kernel.org/linux-pci/20211023144252.z7ou2l2tvm6cvtf7@pali/t/#u

> I expect some controllers to support multiple root ports, and it would
> be really nice if the DTs and drivers all had similar structures with
> the single-root-port controllers just being the N=1 case.
> 
> For example, some drivers put their per-root port stuff in
> *_add_pcie_port() functions, which I think is a nice way to do it
> because it leaves the door open for calling *_add_pcie_port() in a
> loop.
> 
> Ironically, the only driver I see that looks like it currently
> supports multiple root ports is pci-mvebu.c, and it doesn't have an
> _add_pcie_port() function.

Ironically, pci-mvebu.c is doing it wrong because HW has basically N
fully independent HW host bridges and pci-mvebu.c driver is registering
one kernel virtual host bridge device and is merging root ports of all
host bridges into this one "virtual" bus which belongs to that kernel
virtual host bridge... Plus root ports are also "virtual" because they
are broken in HW. So correctly pci-mvebu.c should have been split into
separate host bridge DTS nodes, but due to backward compatibility it is
not possible.

> Having this sort of consistent structure and naming across drivers is
> a huge help for ongoing maintenance.
> 
> Bjorn

+1

That is why I sent that my proposal. Defining this as a common way for
(new) drivers would really helps a lot all maintenance.
