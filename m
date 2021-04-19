Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51CAE36471B
	for <lists+linux-pci@lfdr.de>; Mon, 19 Apr 2021 17:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240020AbhDSP2Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Apr 2021 11:28:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:54468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233733AbhDSP2P (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Apr 2021 11:28:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E914F61007;
        Mon, 19 Apr 2021 15:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618846065;
        bh=6TEjxRd9ZbIa/svDgfBY26QbZkTylNMdMpa3EbPBDhg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fcp8jW9dXBXv+P8zQcQIEdkRewugO8w+QHwssCos1YIljJGv3nqwVHZRTjEPTum2Q
         JSiVfap0UEjJo9I8w4LT1SsDt8nmMRzdphkKSN14hFe/x4Wv3EiGmDrNPFjzwPaGVT
         zpYCPK2LKFH1b2ko2bpgICj3EuINdHCpTruKhhPtoiBnXe0tYgeMstbqMmM0xjQZww
         r1EZfpaqmJqD4Z6pl7b0n/q+j6ReoErLs79xtW8BW3BpmO8nhA8jOh0FgoSzL90FpZ
         4ELDgpIdl/Kl/SozQZGrQdJAF6IwW8n6uDeVhqx/2fDZoPeQGArKeRcBbv+7TTMfI5
         pI549RMaekTDQ==
Date:   Tue, 20 Apr 2021 00:27:42 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Subject: Re: PCIe: can't set Max Payload Size to 256
Message-ID: <20210419152742.GB13015@redsun51.ssa.fujisawa.hgst.com>
References: <20210416173119.d2eq2zetzp5awunj@pali>
 <20210416202941.GB32082@redsun51.ssa.fujisawa.hgst.com>
 <20210416230430.cdzlnifaenzhbsmm@pali>
 <20210417022904.GC32082@redsun51.ssa.fujisawa.hgst.com>
 <20210417093108.uspm6e6h46k655p2@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210417093108.uspm6e6h46k655p2@pali>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Apr 17, 2021 at 11:31:08AM +0200, Pali Rohár wrote:
> On Saturday 17 April 2021 11:29:04 Keith Busch wrote:
> > On Sat, Apr 17, 2021 at 01:04:30AM +0200, Pali Rohár wrote:
> > > Above NVMe disk is connected to PCIe packet switch (which acts as pair
> > > of Upstream and Downstream ports of PCI bridge) and PCIe packet switch
> > > is connected to the Root port.
> > > 
> > > I'm not sure what should I set or what to force.
> > 
> > Try adding the suggested kernel parameter, "pci=pcie_bus_safe".
> 
> Ok, I will try it.
> 
> > Unless this is a hot-plug scenario, it is odd the OS was handed
> > mismatched PCIe settings. That usually indicates a platform bios issue,
> > and the kernel parameter is typically successful at working around it.
> 
> This is arm64, no BIOS. Kernel uses native pci-aardvark.c host
> controller driver which handles everything related to PCIe.

That also sounds odd. The default MPS value is 128b, so something
changed your bridge to 256b. Linux pci driver generally uses the
existing settings. The only times it attempts to change them is if you
used parameters to tell it to do that, or if it detects a mismatch, so
I'm curious what component set the bridge as you've observed.

In any case, the 'safe' parameter sounds like the most likely way to
work around it.
