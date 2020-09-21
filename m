Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D92862724A0
	for <lists+linux-pci@lfdr.de>; Mon, 21 Sep 2020 15:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgIUNJo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Sep 2020 09:09:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:39020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726417AbgIUNJn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Sep 2020 09:09:43 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BA0C21789;
        Mon, 21 Sep 2020 13:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600693783;
        bh=tV9re0vJKY15IANIsLBtwOSpqPFekeUVNGNJqdyZCEQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gj2ZcVHpDmqMimR+38DpWqLVIREuioT8exZybsWFHEDcvm9ocAjPsjCYVcJIejTeq
         yopx7AAKAYKx6zFRS23ZGPRbsjtxO5EP4vUKVsu4JQhwdOIHuo601ovmQuU97V1qYM
         so6Ic5guzHtZXH8206Mj+TntjRgzl278reoWTD3Q=
Received: by pali.im (Postfix)
        id D1BED7BF; Mon, 21 Sep 2020 15:09:40 +0200 (CEST)
Date:   Mon, 21 Sep 2020 15:09:40 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Tomasz Maciej Nowak <tmn505@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: aardvark: Fix comphy with old ATF
Message-ID: <20200921130940.ticdda2lo2fhcrl5@pali>
References: <20200902144344.16684-1-pali@kernel.org>
 <3f2b0e5b-87f1-7887-4afc-77f31d56b5a3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f2b0e5b-87f1-7887-4afc-77f31d56b5a3@gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Lorenzo, could you look and review this patch series? It fixes commit
366697018c9a and we would like to have fix also in stable kernels.

On Wednesday 16 September 2020 17:14:02 Tomasz Maciej Nowak wrote:
> W dniu 02.09.2020 o 16:43, Pali Rohár pisze:
> > This patch series fixes regression introduced in commit 366697018c9a
> > ("PCI: aardvark: Add PHY support") which caused aardvark driver
> > initialization failure on EspressoBin board with factory version of
> > Arm Trusted Firmware provided by Marvell.
> > 
> > Second patch depends on the first patch, so please add appropriate
> > Fixes/Cc:stable@ tags to have both patches correctly backported to
> > stable kernels.
> > 
> > I have tested both patches with Marvell ATF firmware ebin-17.10-uart.zip
> > and with upstream ATF+uboot and aardvark was initialized successfully.
> > Without this patch series on ebin-17.10-uart.zip aardvark initialization
> > failed.
> > 
> > Pali Rohár (2):
> >   phy: marvell: comphy: Convert internal SMCC firmware return codes to
> >     errno
> >   PCI: aardvark: Fix initialization with old Marvell's Arm Trusted
> >     Firmware
> 
> For both patches
> 
> Tested-by: Tomasz Maciej Nowak <tmn505@gmail.com>
> 
> > 
> >  drivers/pci/controller/pci-aardvark.c        |  4 +++-
> >  drivers/phy/marvell/phy-mvebu-a3700-comphy.c | 14 +++++++++++---
> >  drivers/phy/marvell/phy-mvebu-cp110-comphy.c | 14 +++++++++++---
> >  3 files changed, 25 insertions(+), 7 deletions(-)
> > 
> 
