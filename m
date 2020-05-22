Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 730441DE8E3
	for <lists+linux-pci@lfdr.de>; Fri, 22 May 2020 16:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730046AbgEVO2V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 May 2020 10:28:21 -0400
Received: from elvis.franken.de ([193.175.24.41]:34553 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729891AbgEVO2V (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 May 2020 10:28:21 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1jc8ee-0006D2-00; Fri, 22 May 2020 16:28:08 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 0962EC0175; Fri, 22 May 2020 16:27:28 +0200 (CEST)
Date:   Fri, 22 May 2020 16:27:28 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Huacai Chen <chenhc@lemote.com>,
        Paul Burton <paulburton@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH v10 2/5] PCI: Add Loongson PCI Controller support
Message-ID: <20200522142727.GC15261@alpha.franken.de>
References: <20200427060551.1372591-1-jiaxun.yang@flygoat.com>
 <20200514131650.3587281-1-jiaxun.yang@flygoat.com>
 <20200514131650.3587281-2-jiaxun.yang@flygoat.com>
 <AC29D474-D846-41AF-9900-759CE430A744@flygoat.com>
 <20200522131018.GE11785@e121166-lin.cambridge.arm.com>
 <7FE3D498-D293-407C-A70C-5E763151477C@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7FE3D498-D293-407C-A70C-5E763151477C@flygoat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 22, 2020 at 09:32:10PM +0800, Jiaxun Yang wrote:
> 
> 
> 于 2020年5月22日 GMT+08:00 下午9:10:18, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> 写到:
> >On Wed, May 20, 2020 at 07:57:29PM +0800, Jiaxun Yang wrote:
> >> 
> >> 
> >> 于 2020年5月14日 GMT+08:00 下午9:16:38, Jiaxun Yang <jiaxun.yang@flygoat.com> 写到:
> >> >This controller can be found on Loongson-2K SoC, Loongson-3
> >> >systems with RS780E/LS7A PCH.
> >> >
> >> >The RS780E part of code was previously located at
> >> >arch/mips/pci/ops-loongson3.c and now it can use generic PCI
> >> >driver implementation.
> >> >
> >> >Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> >> >Reviewed-by: Rob Herring <robh@kernel.org>
> >> >
> >> 
> >> Hi there,
> >> 
> >> Is it possible to let this series go into next tree soon?
> >> 
> >> As LS7A dts patch would depend on this series, and I want to
> >> make the whole LS7A basic support as a part of 5.8 release.
> >
> >I think you have all necessary tags to take this in the MIPS
> >tree, please let me know if that's the way we want this to go
> >upstream - I would not pull MIPS/dts changes into the PCI tree
> >and I don't think it is needed for this series.
> 
> Please pull all PCI changes [1~3] into PCI tree.
> 
> And Thomas,
> Could you please apply rest changes into MIPS Tree?

this will cause loss of PCI support for loongson in mips-next until
everything is pulled together during merge window. As this isn't too
nice I've acked the remaining patches to get them into the pci/mips
tree, too.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
