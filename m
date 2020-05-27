Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB5461E4046
	for <lists+linux-pci@lfdr.de>; Wed, 27 May 2020 13:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730061AbgE0Li3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 May 2020 07:38:29 -0400
Received: from elvis.franken.de ([193.175.24.41]:41055 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729712AbgE0Li2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 May 2020 07:38:28 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1jduO3-00011U-03; Wed, 27 May 2020 13:38:19 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 77FD5C0594; Wed, 27 May 2020 13:35:02 +0200 (CEST)
Date:   Wed, 27 May 2020 13:35:02 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Huacai Chen <chenhc@lemote.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Paul Burton <paulburton@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH v11 0/5] Loongson Generic PCI v11
Message-ID: <20200527113502.GD13537@alpha.franken.de>
References: <20200427060551.1372591-1-jiaxun.yang@flygoat.com>
 <20200526092130.145550-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526092130.145550-1-jiaxun.yang@flygoat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 26, 2020 at 05:21:11PM +0800, Jiaxun Yang wrote:
> v11 fixes a minor style issue in patch 2.
> 
> Now it have got enough ack,
> Thomas, cloud you please apply it to mips-next?
> 
> Thanks.
> 
> Jiaxun Yang (5):
>   PCI: Don't disable decoding when mmio_always_on is set
>   PCI: Add Loongson PCI Controller support
>   dt-bindings: Document Loongson PCI Host Controller
>   MIPS: DTS: Loongson64: Add PCI Controller Node
>   MIPS: Loongson64: Switch to generic PCI driver
> 
>  .../devicetree/bindings/pci/loongson.yaml     |  62 +++++
>  arch/mips/Kconfig                             |   1 +
>  arch/mips/boot/dts/loongson/rs780e-pch.dtsi   |  12 +
>  arch/mips/loongson64/Makefile                 |   2 +-
>  arch/mips/loongson64/vbios_quirk.c            |  29 ++
>  arch/mips/pci/Makefile                        |   1 -
>  arch/mips/pci/fixup-loongson3.c               |  71 -----
>  arch/mips/pci/ops-loongson3.c                 | 116 --------
>  drivers/pci/controller/Kconfig                |  10 +
>  drivers/pci/controller/Makefile               |   1 +
>  drivers/pci/controller/pci-loongson.c         | 247 ++++++++++++++++++
>  drivers/pci/probe.c                           |   2 +-
>  12 files changed, 364 insertions(+), 190 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/loongson.yaml
>  create mode 100644 arch/mips/loongson64/vbios_quirk.c
>  delete mode 100644 arch/mips/pci/fixup-loongson3.c
>  delete mode 100644 arch/mips/pci/ops-loongson3.c
>  create mode 100644 drivers/pci/controller/pci-loongson.c

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
