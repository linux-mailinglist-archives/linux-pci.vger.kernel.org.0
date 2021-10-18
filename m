Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1391F431FE5
	for <lists+linux-pci@lfdr.de>; Mon, 18 Oct 2021 16:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbhJROjd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Oct 2021 10:39:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:58316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231736AbhJROjd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Oct 2021 10:39:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EC10E60FD8;
        Mon, 18 Oct 2021 14:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634567842;
        bh=zdZ1w32XEmm3gSqpjvDQ0HryAwERxjgClkMifksRYPk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=n9zantTnTpLbfPqXml7p25GAjC0m8XF9D5pIQQ1f0MdJ0ihxYwryK2as+KclEqgbr
         lv2QNBtsacoXHoHepR1PZC2dqvQ61Sa7VjH4UzjFQpnUmfhKT0M1ulTHQdDLTBkPCL
         y2M5Dva4Tj6DCMOvsfh6tWmpuTSGlv1eoizTetTLwas/bBqN4ClwVRuE/FRvWcKymf
         4bK2Yt6gRGLaiztBNpssse58VrRF5axHVVbDxhQXa2bM96zry5uD8a1/kRdWvKtdAK
         m/4P2vg/q1oI2cIvhHXLXwQTJSH++/E+RozpjCnZ7Y8rwisonY3rmP1aaLDJM1eB+j
         I7MUscLIzOIaA==
Date:   Mon, 18 Oct 2021 15:37:16 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Krzysztof =?UTF-8?B?V2ls?= =?UTF-8?B?Y3p5xYRza2k=?= 
        <kw@linux.com>, Songxiaowei <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v13 09/10] PCI: kirin: fix poweroff sequence
Message-ID: <20211018153716.0370a66c@sal.lan>
In-Reply-To: <20211018102127.GD17152@lpieralisi>
References: <cover.1634539769.git.mchehab+huawei@kernel.org>
        <8116a4ddaaeda8dd056e80fa0ee506c5c6f42ca7.1634539769.git.mchehab+huawei@kernel.org>
        <20211018102127.GD17152@lpieralisi>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Em Mon, 18 Oct 2021 11:21:27 +0100
Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> escreveu:

> On Mon, Oct 18, 2021 at 08:07:34AM +0100, Mauro Carvalho Chehab wrote:
> > This driver currently doesn't call dw_pcie_host_deinit()
> > at the .remove() callback. This can cause an OOPS if the driver
> > is unbound.  
> 
> This looks like a fix, it has to be marked as such.

Well, without patch 10/10, the .remove() ops won't be called,
so, it is not really a fix, but I can surely add a c/c
stable@vger.kernel.org and add a Fixes: tag here.

> 
> > While here, add a poweroff function, in order to abstract
> > between the internal and external PHY logic.
> > 
> > Acked-by: Xiaowei Song <songxiaowei@hisilicon.com>
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> > 
> > See [PATCH v13 00/10] at: https://lore.kernel.org/all/cover.1634539769.git.mchehab+huawei@kernel.org/
> > 
> >  drivers/pci/controller/dwc/pcie-kirin.c | 30 ++++++++++++++++---------
> >  1 file changed, 20 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
> > index b17a194cf78d..ffc63d12f8ed 100644
> > --- a/drivers/pci/controller/dwc/pcie-kirin.c
> > +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> > @@ -680,6 +680,23 @@ static const struct dw_pcie_host_ops kirin_pcie_host_ops = {
> >  	.host_init = kirin_pcie_host_init,
> >  };
> >  
> > +static int kirin_pcie_power_off(struct kirin_pcie *kirin_pcie)
> > +{
> > +	int i;
> > +
> > +	if (kirin_pcie->type == PCIE_KIRIN_INTERNAL_PHY)
> > +		return hi3660_pcie_phy_power_off(kirin_pcie);
> > +
> > +	for (i = 0; i < kirin_pcie->n_gpio_clkreq; i++) {
> > +		gpio_direction_output(kirin_pcie->gpio_id_clkreq[i], 1);
> > +	}  
> 
> It looks like you are adding functionality here (ie gpio), not
> just wrapping common code in a function.

It is just reverting the power on logic there.

> 
> Also, remove the braces, they aren't needed.

Yeah, I forgot to drop it, when I dropped a tem code that had some
dev_dbg() on it.

I'll drop on v14.

Regards,
Mauro
