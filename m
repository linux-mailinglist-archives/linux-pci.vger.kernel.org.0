Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8896DC015C
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2019 10:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbfI0Ilh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Sep 2019 04:41:37 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:37327 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfI0Ilh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Sep 2019 04:41:37 -0400
X-Originating-IP: 65.39.69.237
Received: from localhost (unknown [65.39.69.237])
        (Authenticated sender: repk@triplefau.lt)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id B7CF2FF80F;
        Fri, 27 Sep 2019 08:41:34 +0000 (UTC)
Date:   Fri, 27 Sep 2019 10:50:00 +0200
From:   Remi Pommarel <repk@triplefau.lt>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: aardvark: Don't rely on jiffies while holding
 spinlock
Message-ID: <20190927084959.GC1208@voidbox.localdomain>
References: <20190927083142.8571-1-repk@triplefau.lt>
 <20190927103420.48bb9335@windsurf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190927103420.48bb9335@windsurf>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Thomas,

On Fri, Sep 27, 2019 at 10:34:20AM +0200, Thomas Petazzoni wrote:
> Hello Remi,
> 
> Thanks for the new iteration!
> 
> On Fri, 27 Sep 2019 10:31:42 +0200
> Remi Pommarel <repk@triplefau.lt> wrote:
> 
> > diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> > index fc0fe4d4de49..ee05ccb2b686 100644
> > --- a/drivers/pci/controller/pci-aardvark.c
> > +++ b/drivers/pci/controller/pci-aardvark.c
> > @@ -175,7 +175,8 @@
> >  	(PCIE_CONF_BUS(bus) | PCIE_CONF_DEV(PCI_SLOT(devfn))	| \
> >  	 PCIE_CONF_FUNC(PCI_FUNC(devfn)) | PCIE_CONF_REG(where))
> >  
> > -#define PIO_TIMEOUT_MS			1
> > +#define PIO_RETRY_CNT			10
> > +#define PIO_RETRY_DELAY			2 /* 2 us*/
> 
> So this changes the timeout from 1ms to just 20us, a division by 50
> from the previous timeout value. From my measurements, it could
> sometime take up to 6us from a single PIO read operation to complete,
> which is getting close to the 20us timeout.
> 
> Shouldn't PIO_RETRY_CNT be kept at 500, so that we keep using a 1ms
> timeout ?

Damn. You right of course, sorry about that.

Thanks

-- 
Remi
