Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E18D1DE8E7
	for <lists+linux-pci@lfdr.de>; Fri, 22 May 2020 16:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730114AbgEVO2W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 May 2020 10:28:22 -0400
Received: from elvis.franken.de ([193.175.24.41]:34551 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729952AbgEVO2V (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 May 2020 10:28:21 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1jc8ed-0006D2-00; Fri, 22 May 2020 16:28:07 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id E7B32C015D; Fri, 22 May 2020 16:25:27 +0200 (CEST)
Date:   Fri, 22 May 2020 16:25:27 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Huacai Chen <chenhc@lemote.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Paul Burton <paulburton@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH v10 4/5] MIPS: DTS: Loongson64: Add PCI Controller Node
Message-ID: <20200522142527.GA15261@alpha.franken.de>
References: <20200427060551.1372591-1-jiaxun.yang@flygoat.com>
 <20200514131650.3587281-1-jiaxun.yang@flygoat.com>
 <20200514131650.3587281-4-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514131650.3587281-4-jiaxun.yang@flygoat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 14, 2020 at 09:16:40PM +0800, Jiaxun Yang wrote:
> Add PCI Host controller node for Loongson64 with RS780E PCH dts.
> Note that PCI interrupts are probed via legacy way, as different
> machine have different interrupt arrangement, we can't cover all
> of them in dt.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  arch/mips/boot/dts/loongson/rs780e-pch.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
