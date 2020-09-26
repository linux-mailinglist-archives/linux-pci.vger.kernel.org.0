Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9782797F7
	for <lists+linux-pci@lfdr.de>; Sat, 26 Sep 2020 10:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgIZI3W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 26 Sep 2020 04:29:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:48128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbgIZI3W (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 26 Sep 2020 04:29:22 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97FD12177B;
        Sat, 26 Sep 2020 08:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601108961;
        bh=PwSiZ1RlwYLFkM1l1xsMr7P0HOy7hea191lLRDr8cxY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iEFNDKaVwy9Si/rexAuTBYFakDuFTsl7hgWrFneZ4VQszEy0QMMa0mkx8c560y/Fw
         eE1XCNQAz5qQpbG2qjfGqTqgCxP9Px/UNXpaIBO9xWOyrFp2Qdj3X3mb5Ku3tmBEcC
         sioa6/WrPGwGcOE1kQzg/X55yWsB2mXgBm0XafHA=
Received: by pali.im (Postfix)
        id 5523AFB2; Sat, 26 Sep 2020 10:29:19 +0200 (CEST)
Date:   Sat, 26 Sep 2020 10:29:19 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add me as a reviewer for PCI aardvark
Message-ID: <20200926082919.6m7x7wege7yidyb3@pali>
References: <20200925092115.16546-1-pali@kernel.org>
 <20200925154047.GA2438563@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200925154047.GA2438563@bjorn-Precision-5520>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 25 September 2020 10:40:47 Bjorn Helgaas wrote:
> On Fri, Sep 25, 2020 at 11:21:15AM +0200, Pali Rohár wrote:
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> > I have provided more fixes to this driver, I have needed functional
> > specification for this PCI controller and also hardware for testing
> > and developing (Espressobin V5 and Turris MOX B and G modules).
> > 
> > Thomas already wrote [1] that is less involved in this driver, so I
> > can help with reviewing/maintaining it.
> > 
> > [1] - https://lore.kernel.org/linux-pci/20200513135643.478ffbda@windsurf.home/
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index d746519253c3..e245dbe280ac 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -13185,6 +13185,7 @@ F:	drivers/firmware/pcdp.*
> >  
> >  PCI DRIVER FOR AARDVARK (Marvell Armada 3700)
> >  M:	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> > +R:	Pali Rohár <pali@kernel.org>
> >  L:	linux-pci@vger.kernel.org
> >  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> >  S:	Maintained
> 
> Applied to pci/misc for v5.10 with Thomas' ack and signing you up as
> maintainer, thanks!
> 
> commit ccaa71689032 ("MAINTAINERS: Add Pali Rohár as aardvark PCI maintainer")
> Author: Pali Rohár <pali@kernel.org>
> Date:   Fri Sep 25 11:21:15 2020 +0200
> 
>     MAINTAINERS: Add Pali Rohár as aardvark PCI maintainer
>     
>     Link: https://lore.kernel.org/r/20200925092115.16546-1-pali@kernel.org
>     Signed-off-by: Pali Rohár <pali@kernel.org>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Acked-by: Thomas Petazzzoni <thomas.petazzoni@bootlin.com>

Ok! Fine for me.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index deaafb617361..5959a24a4acb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13160,6 +13160,7 @@ F:	drivers/firmware/pcdp.*
>  
>  PCI DRIVER FOR AARDVARK (Marvell Armada 3700)
>  M:	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> +M:	Pali Rohár <pali@kernel.org>
>  L:	linux-pci@vger.kernel.org
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
