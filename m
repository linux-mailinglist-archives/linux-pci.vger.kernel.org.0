Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D86F1DE8E5
	for <lists+linux-pci@lfdr.de>; Fri, 22 May 2020 16:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730011AbgEVO2V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 May 2020 10:28:21 -0400
Received: from elvis.franken.de ([193.175.24.41]:34554 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729971AbgEVO2U (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 May 2020 10:28:20 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1jc8ed-0006D2-01; Fri, 22 May 2020 16:28:07 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 55B2FC0175; Fri, 22 May 2020 16:25:50 +0200 (CEST)
Date:   Fri, 22 May 2020 16:25:50 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Huacai Chen <chenhc@lemote.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Paul Burton <paulburton@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH v10 5/5] MIPS: Loongson64: Switch to generic PCI driver
Message-ID: <20200522142550.GB15261@alpha.franken.de>
References: <20200427060551.1372591-1-jiaxun.yang@flygoat.com>
 <20200514131650.3587281-1-jiaxun.yang@flygoat.com>
 <20200514131650.3587281-5-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514131650.3587281-5-jiaxun.yang@flygoat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 14, 2020 at 09:16:41PM +0800, Jiaxun Yang wrote:
> We can now enable generic PCI driver in Kconfig, and remove legacy
> PCI driver code.
> 
> Radeon vbios quirk is moved to the platform folder to fit the
> new structure.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> --
> v9: Fix licenses tag
> ---
>  arch/mips/Kconfig                  |   1 +
>  arch/mips/loongson64/Makefile      |   2 +-
>  arch/mips/loongson64/vbios_quirk.c |  29 ++++++++
>  arch/mips/pci/Makefile             |   1 -
>  arch/mips/pci/fixup-loongson3.c    |  71 ------------------
>  arch/mips/pci/ops-loongson3.c      | 116 -----------------------------
>  6 files changed, 31 insertions(+), 189 deletions(-)
>  create mode 100644 arch/mips/loongson64/vbios_quirk.c
>  delete mode 100644 arch/mips/pci/fixup-loongson3.c
>  delete mode 100644 arch/mips/pci/ops-loongson3.c

Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
