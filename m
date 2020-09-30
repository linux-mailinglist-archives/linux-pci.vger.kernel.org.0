Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9AB027F578
	for <lists+linux-pci@lfdr.de>; Thu,  1 Oct 2020 00:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731855AbgI3Wto (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 18:49:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:55328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731839AbgI3Wtj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Sep 2020 18:49:39 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF91D20719;
        Wed, 30 Sep 2020 22:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601506178;
        bh=H6Dy8TpKH/vnGTB4vKkYvl/vv021ef3o0tpzflyW6zA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=cmd9lpw8pmF+kiIhau1NvyO6sjsTbiAyJfqiPFjAfHH2Pp+Emjbj6lh0hR+JT8qGw
         yaJPdtnEeufQsFaRoWVgqglqxs6ROIPYSSKvUUEcm+XwxAdFBigAWQG3hkTfVv+9iv
         pj/85oFlA6IaAXcUCmm5kyVCqmtvZgubOo/Fb714=
Date:   Wed, 30 Sep 2020 17:49:36 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add me as a reviewer for PCI aardvark
Message-ID: <20200930224936.GA2644335@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200925154047.GA2438563@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 25, 2020 at 10:40:47AM -0500, Bjorn Helgaas wrote:
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

Actually, I moved this to for-linus so we can get it in v5.9.  It's
zero risk, and if we wait for v5.10, you'd miss any reports related to
v5.9.

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
> 
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
