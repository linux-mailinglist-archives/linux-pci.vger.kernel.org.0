Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 230CA281428
	for <lists+linux-pci@lfdr.de>; Fri,  2 Oct 2020 15:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgJBNhW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Oct 2020 09:37:22 -0400
Received: from foss.arm.com ([217.140.110.172]:36202 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387717AbgJBNhV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Oct 2020 09:37:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57BD530E;
        Fri,  2 Oct 2020 06:37:21 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 38BF73F70D;
        Fri,  2 Oct 2020 06:37:19 -0700 (PDT)
Date:   Fri, 2 Oct 2020 14:37:13 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: aardvark: Fix comphy with old ATF
Message-ID: <20201002133713.GA24425@e121166-lin.cambridge.arm.com>
References: <20200902144344.16684-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200902144344.16684-1-pali@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 02, 2020 at 04:43:42PM +0200, Pali Rohár wrote:
> This patch series fixes regression introduced in commit 366697018c9a
> ("PCI: aardvark: Add PHY support") which caused aardvark driver
> initialization failure on EspressoBin board with factory version of
> Arm Trusted Firmware provided by Marvell.
> 
> Second patch depends on the first patch, so please add appropriate
> Fixes/Cc:stable@ tags to have both patches correctly backported to
> stable kernels.
> 
> I have tested both patches with Marvell ATF firmware ebin-17.10-uart.zip
> and with upstream ATF+uboot and aardvark was initialized successfully.
> Without this patch series on ebin-17.10-uart.zip aardvark initialization
> failed.
> 
> Pali Rohár (2):
>   phy: marvell: comphy: Convert internal SMCC firmware return codes to
>     errno
>   PCI: aardvark: Fix initialization with old Marvell's Arm Trusted
>     Firmware
> 
>  drivers/pci/controller/pci-aardvark.c        |  4 +++-
>  drivers/phy/marvell/phy-mvebu-a3700-comphy.c | 14 +++++++++++---
>  drivers/phy/marvell/phy-mvebu-cp110-comphy.c | 14 +++++++++++---
>  3 files changed, 25 insertions(+), 7 deletions(-)

Applied to pci/aardvark (both patches), thanks.

Lorenzo
