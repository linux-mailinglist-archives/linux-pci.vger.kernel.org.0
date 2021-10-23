Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27EB84383F9
	for <lists+linux-pci@lfdr.de>; Sat, 23 Oct 2021 16:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbhJWO6O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 23 Oct 2021 10:58:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:39400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229901AbhJWO6O (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 23 Oct 2021 10:58:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E253760FD8;
        Sat, 23 Oct 2021 14:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635000955;
        bh=4XCfTzqibljJFYGtxk5OYG1tv/o6DDhpqQK2LhvRGqg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZDy1fKjgUK81hfKcvI5+pE8WbkN2ggBmkzH6T49Eis1598sfHzP1RdEqRBZKXpRcB
         6FkuK+BmD6rKMMx2DGeNhCUyxZ7TLJDznU9JcZdI1O7qenAB2JpjGExFq+vhXygC0C
         kf5SwzG7udFRIB32GjfWvwd0LZ5H7jGiRO1z6Lso1JpXyYpRcKV8ryA05FpjHkF1uS
         eKsV/bG2wzzJj4ZIKpTS2/VMAW5dRUxsGSnD9r0O+Ym1UUEAU7/ODLhJ87Kgl8ex/p
         oTB2hM7eP+8lY3LjBo05Eh1z9nmW5QPeICaRJ71hB7BnKzH2nvpXmrR+OKhz0CB2gK
         gDdNib0+RMH6Q==
Received: by pali.im (Postfix)
        id CAD4B883; Sat, 23 Oct 2021 16:55:52 +0200 (CEST)
Date:   Sat, 23 Oct 2021 16:55:52 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linuxarm@huawei.com,
        mauro.chehab@huawei.com,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Songxiaowei <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v14 05/11] PCI: kirin: give more time for PERST# reset to
 finish
Message-ID: <20211023145552.3ly4kukfyrark7c2@pali>
References: <cover.1634622716.git.mchehab+huawei@kernel.org>
 <9a365cffe5af9ec5a1f79638968c3a2efa979b65.1634622716.git.mchehab+huawei@kernel.org>
 <20211022151624.mgsgobjsjgyevnyt@pali>
 <20211023103059.6add00e6@sal.lan>
 <20211023104011.zmj7y7vtplpnmhwd@pali>
 <20211023144534.55aaecf9@sal.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211023144534.55aaecf9@sal.lan>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Saturday 23 October 2021 14:45:34 Mauro Carvalho Chehab wrote:
> Em Sat, 23 Oct 2021 12:40:11 +0200
> Pali Rohár <pali@kernel.org> escreveu:
> > It is classic setup for boards with just one PCIe port.
> > 
> > > with 3 elements connected to the bus: an Ethernet card, a M.2 slot and
> > > a mini PCIe slot. It seems HiKey 970 is unique with regards to PERST# signal,
> > > as there are 4 independent PERST# signals there:
> > > 
> > > 	- one for PEX 8606 (the PCIe root port);
> > > 	- one for Ethernet;
> > > 	- one for M.2;
> > > 	- one for mini-PCIe.  
> > 
> > This is not unique setup, its pretty normal. Every PCIe card has (own)
> > PERST# pin and obviously you want to control each pin separately via SW.
> > And because PCIe switch is also (upstream) PCIe device it has also
> > PERST# pin.
> 
> Based on the discussions we had to add per-port DT PERST# gpios, it
> sounded to me that this is was not a typical setup ;-)
> 
> It seems that the typical setup is to have a single PERST# connected
> to all devices inside the bus.

Hello!

I'm sure it is not unique :) Just seems that these boards either do not
use device tree (x86-based) or do not have specified reset-gpios in DTS
at all.

Sometimes there is no need to touch PERST# gpio as either firmware
during boot handles it (x86 BIOS/UEFI case, or U-Boot for arm case) or
because board/cpu reset toggle PERST# in a way that is compatible for
cards init.

Looks like you have non-x86 board, which does not have PCIe init code in
firmware, needs special handling of PERST# and you are doing it with
upstream kernel :-) So maybe all these conditions are unique... But HW
design not.

As this setup with reset-gpios per card in DTS nodes is something which
I will need too, I sent email to Rob with proposal how to universally
declare it in DTS, independently of PCIe controller (you are on CC):
https://lore.kernel.org/linux-pci/20211023144252.z7ou2l2tvm6cvtf7@pali/

Due to how PCIe cards are broken, PERST# signal is sometimes the only
one option how to reset card at runtime. So requirement for separate
PERST# per card configurable at runtime by OS will be requirement for
more and more boards.
