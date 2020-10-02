Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD964281562
	for <lists+linux-pci@lfdr.de>; Fri,  2 Oct 2020 16:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387777AbgJBOi7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Oct 2020 10:38:59 -0400
Received: from foss.arm.com ([217.140.110.172]:37852 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbgJBOi7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Oct 2020 10:38:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C64D30E;
        Fri,  2 Oct 2020 07:38:58 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C518C3F70D;
        Fri,  2 Oct 2020 07:38:56 -0700 (PDT)
Date:   Fri, 2 Oct 2020 15:38:51 +0100
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
Message-ID: <20201002143851.GA25575@e121166-lin.cambridge.arm.com>
References: <20200902144344.16684-1-pali@kernel.org>
 <20201002133713.GA24425@e121166-lin.cambridge.arm.com>
 <20201002142616.dxgdneg2lqw4pxie@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201002142616.dxgdneg2lqw4pxie@pali>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 02, 2020 at 04:26:16PM +0200, Pali Rohár wrote:
> On Friday 02 October 2020 14:37:13 Lorenzo Pieralisi wrote:
> > On Wed, Sep 02, 2020 at 04:43:42PM +0200, Pali Rohár wrote:
> > > This patch series fixes regression introduced in commit 366697018c9a
> > > ("PCI: aardvark: Add PHY support") which caused aardvark driver
> > > initialization failure on EspressoBin board with factory version of
> > > Arm Trusted Firmware provided by Marvell.
> > > 
> > > Second patch depends on the first patch, so please add appropriate
> > > Fixes/Cc:stable@ tags to have both patches correctly backported to
> > > stable kernels.
> > > 
> > > I have tested both patches with Marvell ATF firmware ebin-17.10-uart.zip
> > > and with upstream ATF+uboot and aardvark was initialized successfully.
> > > Without this patch series on ebin-17.10-uart.zip aardvark initialization
> > > failed.
> > > 
> > > Pali Rohár (2):
> > >   phy: marvell: comphy: Convert internal SMCC firmware return codes to
> > >     errno
> > >   PCI: aardvark: Fix initialization with old Marvell's Arm Trusted
> > >     Firmware
> > > 
> > >  drivers/pci/controller/pci-aardvark.c        |  4 +++-
> > >  drivers/phy/marvell/phy-mvebu-a3700-comphy.c | 14 +++++++++++---
> > >  drivers/phy/marvell/phy-mvebu-cp110-comphy.c | 14 +++++++++++---
> > >  3 files changed, 25 insertions(+), 7 deletions(-)
> > 
> > Applied to pci/aardvark (both patches), thanks.
> 
> Ok! For second patch would be needed to put CC:stable line with
> specifying prerequisite of first patch as written in document:
> 
> https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> 
> If I understood it correctly, second patch needs following line:
> 
> Cc: <stable@vger.kernel.org> # <commit_id_of_first_path>: comphy: errno return codes
> 
> where <commit_id_of_first_path> is commit id of PATCH 1/2.
> 
> (correct me if I'm wrong)
> 
> Now when first commit has commit id, could you update second commit to
> include this information about prerequisite?

No I can't because they will be merged at the same time. What we can
do is mark the second patch for stable and during the stable review
ask to pull patch (1). Or better you shall send both patches to stable
kernels when they hit Linus' tree.

Lorenzo
