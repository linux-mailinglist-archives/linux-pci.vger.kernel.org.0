Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D36F1DE7B6
	for <lists+linux-pci@lfdr.de>; Fri, 22 May 2020 15:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbgEVNKX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 May 2020 09:10:23 -0400
Received: from foss.arm.com ([217.140.110.172]:35410 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729570AbgEVNKX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 May 2020 09:10:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84C04D6E;
        Fri, 22 May 2020 06:10:22 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE4573F68F;
        Fri, 22 May 2020 06:10:20 -0700 (PDT)
Date:   Fri, 22 May 2020 14:10:18 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Paul Burton <paulburton@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH v10 2/5] PCI: Add Loongson PCI Controller support
Message-ID: <20200522131018.GE11785@e121166-lin.cambridge.arm.com>
References: <20200427060551.1372591-1-jiaxun.yang@flygoat.com>
 <20200514131650.3587281-1-jiaxun.yang@flygoat.com>
 <20200514131650.3587281-2-jiaxun.yang@flygoat.com>
 <AC29D474-D846-41AF-9900-759CE430A744@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AC29D474-D846-41AF-9900-759CE430A744@flygoat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 20, 2020 at 07:57:29PM +0800, Jiaxun Yang wrote:
> 
> 
> 于 2020年5月14日 GMT+08:00 下午9:16:38, Jiaxun Yang <jiaxun.yang@flygoat.com> 写到:
> >This controller can be found on Loongson-2K SoC, Loongson-3
> >systems with RS780E/LS7A PCH.
> >
> >The RS780E part of code was previously located at
> >arch/mips/pci/ops-loongson3.c and now it can use generic PCI
> >driver implementation.
> >
> >Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> >Reviewed-by: Rob Herring <robh@kernel.org>
> >
> 
> Hi there,
> 
> Is it possible to let this series go into next tree soon?
> 
> As LS7A dts patch would depend on this series, and I want to
> make the whole LS7A basic support as a part of 5.8 release.

I think you have all necessary tags to take this in the MIPS
tree, please let me know if that's the way we want this to go
upstream - I would not pull MIPS/dts changes into the PCI tree
and I don't think it is needed for this series.

Thanks,
Lorenzo
