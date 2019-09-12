Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A566B0A09
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2019 10:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbfILITP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Sep 2019 04:19:15 -0400
Received: from foss.arm.com ([217.140.110.172]:58718 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbfILITO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Sep 2019 04:19:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28AC71570;
        Thu, 12 Sep 2019 01:19:14 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 943183F71F;
        Thu, 12 Sep 2019 01:19:13 -0700 (PDT)
Date:   Thu, 12 Sep 2019 09:19:11 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     Simon Horman <horms@verge.net.au>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] PCI: rcar: Remove unnecessary header include (../pci.h)
Message-ID: <20190912081910.GZ9720@e119886-lin.cambridge.arm.com>
References: <20190905150528.20417-1-andrew.murray@arm.com>
 <67fb0f5a-1bf1-596a-4012-8ae881220096@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67fb0f5a-1bf1-596a-4012-8ae881220096@ideasonboard.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 11, 2019 at 11:33:03PM +0100, Kieran Bingham wrote:
> Hi Andy!
> 
> On 05/09/2019 16:05, Andrew Murray wrote:
> > Remove unnecessary header include (../pci.h) since it doesn't
> > provide any needed symbols.
> 
> This appears to have been added in 9e2aee80c78d ("PCI: Move private DT
> related functions into private header")

Thanks, I never looked back at the history of this.

> 
> Several other drivers were touched in that commit too.
> 
> Have you checked to see if any others can also be cleaned up?

Yes I went through all the current drivers/pci/host/ files, I believe this
was the only one.

> 
>  (I only ask, because I only see this single patch on linux-renesas-soc,
> my apologies if others are on different lists.)
> 
> Regardless of that, this looks fine to me, and passes a cursory compile
> check.
> 
> And I've just tried with pcie-xilinx, and pcie-altera, but both still
> need this header - so perhaps pcie-rcar was just the odd one out.
> 
> Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

Thanks,

Andrew Murray

> 
> 
> > Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> > ---
> >  drivers/pci/controller/pcie-rcar.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
> > index f6a669a9af41..ee1c38c2fac9 100644
> > --- a/drivers/pci/controller/pcie-rcar.c
> > +++ b/drivers/pci/controller/pcie-rcar.c
> > @@ -30,8 +30,6 @@
> >  #include <linux/pm_runtime.h>
> >  #include <linux/slab.h>
> >  
> > -#include "../pci.h"
> > -
> >  #define PCIECAR			0x000010
> >  #define PCIECCTLR		0x000018
> >  #define  CONFIG_SEND_ENABLE	BIT(31)
> > 
> 
