Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D917F3F4E69
	for <lists+linux-pci@lfdr.de>; Mon, 23 Aug 2021 18:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbhHWQdv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Aug 2021 12:33:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:35322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229962AbhHWQdv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 23 Aug 2021 12:33:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3129D6101C;
        Mon, 23 Aug 2021 16:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629736388;
        bh=5sOx2aLL6QuASx5rt4q1aJg0cVftu5ctuGF4et88xkw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FxjG1vunvZDj4VqYbLCK2AfkVXJ9x3PeEjDktDLuwS4lUl9zeJcwxLYSA/mpK4w/B
         LmBwKqTXteYOLedloviZoRGf8d5Uru5rkmi0+ZXxOmQCgIZwuG3lRlsqQwhC17bkik
         ZdWIWKP3GM2rFjxJYCHHN1uxao9jbJqhSrGMTDnn4IDfQ8CI3F8ULK7BxebWagz+yk
         F0RQnGNU/ITxCGBYdHKiQnbwplRU7Rc9q8V/YYfGAechzcwUBzLfWje5MdhqKmS1PR
         50Mfl/184LNDqD5DAwGbU7umfUNLJtzNaaLRc3+gPEPPRuHex5QcvYu5ncwzX1YrRB
         piWxRG1pboNXA==
Received: by pali.im (Postfix)
        id C53CBFC2; Mon, 23 Aug 2021 18:33:05 +0200 (CEST)
Date:   Mon, 23 Aug 2021 18:33:05 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] PCI: aardvark: Check for virq mapping when
 processing INTx IRQ
Message-ID: <20210823163305.okizte3ejnm6ltra@pali>
References: <20210625090319.10220-1-pali@kernel.org>
 <20210625090319.10220-3-pali@kernel.org>
 <f38ad6edfb6ee63f273a430154e1038f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f38ad6edfb6ee63f273a430154e1038f@kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 06 August 2021 09:29:02 Marc Zyngier wrote:
> On 2021-06-25 10:03, Pali Rohár wrote:
> > It is possible that we receive spurious INTx interrupt. So add needed
> > check
> > before calling generic_handle_irq() function.
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > Reviewed-by: Marek Behún <kabel@kernel.org>
> > Cc: stable@vger.kernel.org
> > ---
> >  drivers/pci/controller/pci-aardvark.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/pci-aardvark.c
> > b/drivers/pci/controller/pci-aardvark.c
> > index 36fcc077ec72..59f91fad2481 100644
> > --- a/drivers/pci/controller/pci-aardvark.c
> > +++ b/drivers/pci/controller/pci-aardvark.c
> > @@ -1226,7 +1226,11 @@ static void advk_pcie_handle_int(struct advk_pcie
> > *pcie)
> >  			    PCIE_ISR1_REG);
> > 
> >  		virq = irq_find_mapping(pcie->irq_domain, i);
> > -		generic_handle_irq(virq);
> > +		if (virq)
> > +			generic_handle_irq(virq);
> > +		else
> > +			dev_err_ratelimited(&pcie->pdev->dev, "unexpected INT%c IRQ\n",
> > +					    (char)i+'A');
> >  	}
> >  }
> 
> Please use generic_handle_domain_irq() instead of irq_find_mapping()
> and generic_handle_irq().

Ok! At the time when I was sending these patches there was no function
generic_handle_domain_irq().

As all these interrupt related patches are targeting also stable tress
where is no generic_handle_domain_irq() function too, it would be easier
for backporting to use irq_find_mapping() + generic_handle_irq(). And
later after applying all interrupt related patches, include a patch
which converts all usage to generic_handle_domain_irq().

> Thanks,
> 
>         M.
> -- 
> Jazz is not dead. It just smells funny...
