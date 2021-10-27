Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 377FF43C89E
	for <lists+linux-pci@lfdr.de>; Wed, 27 Oct 2021 13:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234849AbhJ0Ldu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Oct 2021 07:33:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:51708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234681AbhJ0Ldu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 Oct 2021 07:33:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0723A6109E;
        Wed, 27 Oct 2021 11:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635334285;
        bh=voIqeEMK3Rjs1PKuum29jzRmFHXKW/WfGHYkNP8IQsE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uqiiwOrOGScDXBNFvzxfV20nYaaJB3HyegtV2BeH59vh7O504fbVcyNk2yhkocjnm
         oFYIZAH0CIakwa3njWnvzuYWNcokWPm5/gWiF5bpmIc1CEmz0W3sYyi+UUtPvxymwg
         gMb2m6ZOpIMR9MuRZl8ZbfUCBmL5Q/99ynXYLI49S7Uc8LiM0vXgFHqDAKBaMC3Rxx
         2G4xpDm35OU7HTf4q/sxAn91ckFbdHu/4ODxdySbxMG7++iNnhFWy3uQB13aaaKbVj
         G9O68iW22pSUSVSSa0CcdcLn4+YiCQLmXYu8isZpLvC3RpO0QGTcE2fDzxjRLp4TBk
         t93/q2GJkCFpw==
Received: by pali.im (Postfix)
        id 61DDD894; Wed, 27 Oct 2021 13:31:22 +0200 (CEST)
Date:   Wed, 27 Oct 2021 13:31:22 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 02/14] PCI: aardvark: Fix return value of MSI domain
 .alloc() method
Message-ID: <20211027113122.jpiu75kaowjiv2nl@pali>
References: <20211012164145.14126-1-kabel@kernel.org>
 <20211012164145.14126-3-kabel@kernel.org>
 <20211027112644.GA26799@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211027112644.GA26799@lpieralisi>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 27 October 2021 12:26:53 Lorenzo Pieralisi wrote:
> On Tue, Oct 12, 2021 at 06:41:33PM +0200, Marek Behún wrote:
> > MSI domain callback .alloc() (implemented by advk_msi_irq_domain_alloc()
> > function) should return zero on success, since non-zero value indicates
> > failure.
> 
> AFAICS the .alloc() method is called in:
> 
> irq_domain_alloc_irqs_hierarchy()
> 
> which in turn is called by:
> 
> __irq_domain_alloc_irqs() -> that checks (ret < 0)
> 
> irq_domain_push_irq() -> that checks for rv != 0
> 
> irq_domain_alloc_irqs_parent() called by many drivers and also
> by msi_domain_alloc() (that checks ret < 0)
> 
> This patch is fine, I am just asking, given the above:
> 
> - How did you detect it (given that aardvark would not fail ret < 0) ?

Last year we have detected that Multi-MSI interrupts do not work
correctly and we have found that return value is incorrect during
debugging. Other drivers are returning 0.

> - Should we consolidate the .alloc() return value handling ?
> 
> Apologies if I missed something in the IRQ domain code.
> 
> Lorenzo
> 
> > When the driver was converted to generic MSI API in commit f21a8b1b6837
> > ("PCI: aardvark: Move to MSI handling using generic MSI support"), it
> > was converted so that it returns hwirq number.
> > 
> > Fix this.
> > 
> > Fixes: f21a8b1b6837 ("PCI: aardvark: Move to MSI handling using generic MSI support")
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > Reviewed-by: Marek Behún <kabel@kernel.org>
> > Signed-off-by: Marek Behún <kabel@kernel.org>
> > Cc: stable@vger.kernel.org
> > ---
> >  drivers/pci/controller/pci-aardvark.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> > index 10476c00b312..b45ff2911c80 100644
> > --- a/drivers/pci/controller/pci-aardvark.c
> > +++ b/drivers/pci/controller/pci-aardvark.c
> > @@ -1138,7 +1138,7 @@ static int advk_msi_irq_domain_alloc(struct irq_domain *domain,
> >  				    domain->host_data, handle_simple_irq,
> >  				    NULL, NULL);
> >  
> > -	return hwirq;
> > +	return 0;
> >  }
> >  
> >  static void advk_msi_irq_domain_free(struct irq_domain *domain,
> > -- 
> > 2.32.0
> > 
