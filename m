Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662281DE838
	for <lists+linux-pci@lfdr.de>; Fri, 22 May 2020 15:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbgEVNky (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 May 2020 09:40:54 -0400
Received: from foss.arm.com ([217.140.110.172]:35854 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729399AbgEVNkx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 May 2020 09:40:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0BF121063;
        Fri, 22 May 2020 06:40:53 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 385DD3F68F;
        Fri, 22 May 2020 06:40:51 -0700 (PDT)
Date:   Fri, 22 May 2020 14:40:48 +0100
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
Message-ID: <20200522134048.GG11785@e121166-lin.cambridge.arm.com>
References: <20200427060551.1372591-1-jiaxun.yang@flygoat.com>
 <20200514131650.3587281-1-jiaxun.yang@flygoat.com>
 <20200514131650.3587281-2-jiaxun.yang@flygoat.com>
 <AC29D474-D846-41AF-9900-759CE430A744@flygoat.com>
 <20200522131018.GE11785@e121166-lin.cambridge.arm.com>
 <7FE3D498-D293-407C-A70C-5E763151477C@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7FE3D498-D293-407C-A70C-5E763151477C@flygoat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 22, 2020 at 09:32:10PM +0800, Jiaxun Yang wrote:

[...]

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

Pulled [1,2,3] into pci/mips, thanks !

Lorenzo
