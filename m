Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D658B3E1A78
	for <lists+linux-pci@lfdr.de>; Thu,  5 Aug 2021 19:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbhHERfb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Aug 2021 13:35:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:57276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240060AbhHERfa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Aug 2021 13:35:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9784861104;
        Thu,  5 Aug 2021 17:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628184915;
        bh=36BRsfhi9BO0Kd9mw3h2GUzrkAMFIJGSmPhKF+cVypU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SfMNDFo0wrVWg8Vav2jfmYPttGnjY8qHRcUr+YCdMgx6DRvuC+iKSabSk82GGrs9S
         oSPdjZl0Qiu/weIEd2EhFGPmoAaqIF0u+7FIAQVO1zhN9qnARFn+QY5+XI4+SHuLQb
         V+QMD7bfs0AyGqajUM8lctGQRPlKnkhHl4T4Y5xxhH6gMgntcBBlAADj0VBALHzSA+
         gq0U3RCuFQxwsyGRjRHdD9UL/GZODSqvw+TsExz2nrgs8+qQtKDLj4JwVdnQvX2FUt
         RhLLRjw7Q2RzO9KtxiTvF33Kh5/d2ElgvpyR/Kc5ojc67hiH+c5pZY2ms8u7GB3l43
         DWEnsoRGh8g8w==
Received: by pali.im (Postfix)
        id 34637817; Thu,  5 Aug 2021 19:35:13 +0200 (CEST)
Date:   Thu, 5 Aug 2021 19:35:13 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>
Cc:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] PCI: aardvark: Interrupt fixes
Message-ID: <20210805173513.at5rhmemfk67crzf@pali>
References: <20210625090319.10220-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210625090319.10220-1-pali@kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 25 June 2021 11:03:12 Pali Rohár wrote:
> Per Lorenzo's request [1] I'm resending [2] some other aardvark patches
> which fixes just interrupts.
> 
> I addressed review comments from [2], updated patches and added Acked-by
> tags.
> 
> [1] - https://lore.kernel.org/linux-pci/20210603151605.GA18917@lpieralisi/
> [2] - https://lore.kernel.org/linux-pci/20210506153153.30454-1-pali@kernel.org/

Could you review these patches?

> Pali Rohár (7):
>   PCI: aardvark: Do not touch status bits of masked interrupts in
>     interrupt handler
>   PCI: aardvark: Check for virq mapping when processing INTx IRQ
>   PCI: aardvark: Remove irq_mask_ack callback for INTx interrupts
>   PCI: aardvark: Don't mask irq when mapping
>   PCI: aardvark: Fix support for MSI interrupts
>   PCI: aardvark: Correctly clear and unmask all MSI interrupts
>   PCI: aardvark: Fix setting MSI address
> 
>  drivers/pci/controller/pci-aardvark.c | 82 ++++++++++++++-------------
>  1 file changed, 44 insertions(+), 38 deletions(-)
> 
> -- 
> 2.20.1
> 
