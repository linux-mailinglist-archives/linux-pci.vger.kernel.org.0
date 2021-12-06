Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A179746A68B
	for <lists+linux-pci@lfdr.de>; Mon,  6 Dec 2021 21:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245430AbhLFUJf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Dec 2021 15:09:35 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:59348 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbhLFUJf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Dec 2021 15:09:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E160ACE17BE;
        Mon,  6 Dec 2021 20:06:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1AD3C341C2;
        Mon,  6 Dec 2021 20:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638821163;
        bh=nud5wfy7ReLgTznOxedJgGkAf5LlFhrRveJvOB4LORs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gs9hXQhyP/9a2KawaeNHh18Gk9uaYVdoJL06MtQ0TnJikMDdtw3J8s+9RvY1fSu+M
         2av8Su6WXNxkPwWitrwezBNBzsKoAW0upwtjP/NSMKBl7pO4QJQHF+0sBXrj1w4j86
         doj0eA7e2Q8dlqkguLyUnrZM3Z49976l4pRfReufsmTnHjleXgn8LovoFWmSqu7nkC
         p9nyXbNQGnS8sZJCRdH5DDCS5sgnYIXlpmpG08qACFBcJZ2AOU3wIcCc7pSEMcBXpa
         MqOmeFDAcTERBMSUEaYyHArD/jMCVvU17f/FYYpuN+GuWZHM5TrIethw23EPt+dlng
         rbsLlMm1TOZ0Q==
Date:   Mon, 6 Dec 2021 14:06:01 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>, john@phrozen.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v5 09/13] PCI: mediatek: allow selecting controller
 driver for airoha arch
Message-ID: <20211206200601.GA7175@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129235549.GA2704502@bhelgaas>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 29, 2021 at 05:55:50PM -0600, Bjorn Helgaas wrote:
> On Mon, Nov 29, 2021 at 04:33:25PM +0100, Felix Fietkau wrote:
> > The EN7523 SoC uses the same controller as MT7622
> 
> If you have occasion to post a v6, please:
> 
>   - Update the subject line so it starts with a capital letter,
>     capitalizes "Airoha" appropriately, and includes "EN7523" as your
>     DT patch does, and moves those close to the beginning, e.g.,
> 
>       PCI: mediatek: Allow selection for Airoha EN7532
> 
>   - Update the commit log so it says what this patch does.  It's OK to
>     repeat the subject line.  Add a period at end.

Sending again since you posted a v6 without doing any of the above.

> > Signed-off-by: Felix Fietkau <nbd@nbd.name>
> > ---
> >  drivers/pci/controller/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> > index 93b141110537..f1342059c2a3 100644
> > --- a/drivers/pci/controller/Kconfig
> > +++ b/drivers/pci/controller/Kconfig
> > @@ -233,7 +233,7 @@ config PCIE_ROCKCHIP_EP
> >  
> >  config PCIE_MEDIATEK
> >  	tristate "MediaTek PCIe controller"
> > -	depends on ARCH_MEDIATEK || COMPILE_TEST
> > +	depends on ARCH_AIROHA || ARCH_MEDIATEK || COMPILE_TEST
> >  	depends on OF
> >  	depends on PCI_MSI_IRQ_DOMAIN
> >  	help
> > -- 
> > 2.30.1
> > 
