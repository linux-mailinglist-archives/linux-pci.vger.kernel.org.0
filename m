Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7A15281613
	for <lists+linux-pci@lfdr.de>; Fri,  2 Oct 2020 17:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388165AbgJBPHF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Oct 2020 11:07:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:51866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388169AbgJBPHE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Oct 2020 11:07:04 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D124A206CA;
        Fri,  2 Oct 2020 15:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601651224;
        bh=lPmxsNvPQckyNK0W5rno7Rz65VQ55u3DSvZaGGDIQ3g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jqwpMUkbAPxWWqZPnN19bUyl6xtu4tDndxoJMXMqIT4zRw3YoX8kHwiXHVwNjzNno
         6rFQb3T9uswM2UzXd594nS5rNh8tA+qd7teIfcCD2TJ0hG0+iZGDiu8AATD3woj7E2
         nnmPQEuV4HRdyiahRI9E+/jMUzLjECoVca/r4REo=
Received: by pali.im (Postfix)
        id 4327FE79; Fri,  2 Oct 2020 17:07:01 +0200 (CEST)
Date:   Fri, 2 Oct 2020 17:07:01 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: aardvark: Fix comphy with old ATF
Message-ID: <20201002150701.bvatgxygq4rjssly@pali>
References: <20200902144344.16684-1-pali@kernel.org>
 <20201002133713.GA24425@e121166-lin.cambridge.arm.com>
 <20201002142616.dxgdneg2lqw4pxie@pali>
 <20201002143851.GA25575@e121166-lin.cambridge.arm.com>
 <20201002145237.r2troxmgbq2bf3ep@pali>
 <20201002150300.GA25684@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201002150300.GA25684@e121166-lin.cambridge.arm.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 02 October 2020 16:03:09 Lorenzo Pieralisi wrote:
> On Fri, Oct 02, 2020 at 04:52:37PM +0200, Pali Rohár wrote:
> > On Friday 02 October 2020 15:38:51 Lorenzo Pieralisi wrote:
> > > On Fri, Oct 02, 2020 at 04:26:16PM +0200, Pali Rohár wrote:
> > > > On Friday 02 October 2020 14:37:13 Lorenzo Pieralisi wrote:
> > > > > On Wed, Sep 02, 2020 at 04:43:42PM +0200, Pali Rohár wrote:
> > > > > > This patch series fixes regression introduced in commit 366697018c9a
> > > > > > ("PCI: aardvark: Add PHY support") which caused aardvark driver
> > > > > > initialization failure on EspressoBin board with factory version of
> > > > > > Arm Trusted Firmware provided by Marvell.
> > > > > > 
> > > > > > Second patch depends on the first patch, so please add appropriate
> > > > > > Fixes/Cc:stable@ tags to have both patches correctly backported to
> > > > > > stable kernels.
> > > > > > 
> > > > > > I have tested both patches with Marvell ATF firmware ebin-17.10-uart.zip
> > > > > > and with upstream ATF+uboot and aardvark was initialized successfully.
> > > > > > Without this patch series on ebin-17.10-uart.zip aardvark initialization
> > > > > > failed.
> > > > > > 
> > > > > > Pali Rohár (2):
> > > > > >   phy: marvell: comphy: Convert internal SMCC firmware return codes to
> > > > > >     errno
> > > > > >   PCI: aardvark: Fix initialization with old Marvell's Arm Trusted
> > > > > >     Firmware
> > > > > > 
> > > > > >  drivers/pci/controller/pci-aardvark.c        |  4 +++-
> > > > > >  drivers/phy/marvell/phy-mvebu-a3700-comphy.c | 14 +++++++++++---
> > > > > >  drivers/phy/marvell/phy-mvebu-cp110-comphy.c | 14 +++++++++++---
> > > > > >  3 files changed, 25 insertions(+), 7 deletions(-)
> > > > > 
> > > > > Applied to pci/aardvark (both patches), thanks.
> > > > 
> > > > Ok! For second patch would be needed to put CC:stable line with
> > > > specifying prerequisite of first patch as written in document:
> > > > 
> > > > https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> > > > 
> > > > If I understood it correctly, second patch needs following line:
> > > > 
> > > > Cc: <stable@vger.kernel.org> # <commit_id_of_first_path>: comphy: errno return codes
> > > > 
> > > > where <commit_id_of_first_path> is commit id of PATCH 1/2.
> > > > 
> > > > (correct me if I'm wrong)
> > > > 
> > > > Now when first commit has commit id, could you update second commit to
> > > > include this information about prerequisite?
> > > 
> > > No I can't because they will be merged at the same time.
> > 
> > And it is a problem? Git commit id of first patch would not be changed,
> > so referencing to it is now possible from second commit (unless you do
> > rebasing).
> > 
> > > What we can do is mark the second patch for stable
> > 
> > This is done by adding "Cc: <stable@vger.kernel.org>" line to second
> > patch which I suggested, right?
> 
> I will apply the stable tag and dependency, it should be fine.

Ok! I thought that according to stable-kernel-rules.html that dependent
commit could be added after stable email address separated with # char.
At least this is how I understood stable-kernel-rules.html and its
section:

  "Additionally, some patches submitted via Option 1 may have additional
   patch prerequisites which can be cherry-picked."

> Please ensure you follow up stable updates especially in case patches
> don't backport properly (ie please try).

No problem, I can monitor emails about backporting these patches.

> Lorenzo
