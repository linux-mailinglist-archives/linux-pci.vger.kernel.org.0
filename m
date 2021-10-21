Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A66D2435EBC
	for <lists+linux-pci@lfdr.de>; Thu, 21 Oct 2021 12:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbhJUKMH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Oct 2021 06:12:07 -0400
Received: from foss.arm.com ([217.140.110.172]:40852 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229567AbhJUKMH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Oct 2021 06:12:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8456CED1;
        Thu, 21 Oct 2021 03:09:51 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E4A143F694;
        Thu, 21 Oct 2021 03:09:49 -0700 (PDT)
Date:   Thu, 21 Oct 2021 11:09:44 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Songxiaowei <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v13 09/10] PCI: kirin: fix poweroff sequence
Message-ID: <20211021100944.GA11904@lpieralisi>
References: <cover.1634539769.git.mchehab+huawei@kernel.org>
 <8116a4ddaaeda8dd056e80fa0ee506c5c6f42ca7.1634539769.git.mchehab+huawei@kernel.org>
 <20211018102127.GD17152@lpieralisi>
 <20211018153716.0370a66c@sal.lan>
 <20211019094048.GA24481@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019094048.GA24481@lpieralisi>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 19, 2021 at 10:40:48AM +0100, Lorenzo Pieralisi wrote:
> On Mon, Oct 18, 2021 at 03:37:16PM +0100, Mauro Carvalho Chehab wrote:
> > Em Mon, 18 Oct 2021 11:21:27 +0100
> > Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> escreveu:
> > 
> > > On Mon, Oct 18, 2021 at 08:07:34AM +0100, Mauro Carvalho Chehab wrote:
> > > > This driver currently doesn't call dw_pcie_host_deinit()
> > > > at the .remove() callback. This can cause an OOPS if the driver
> > > > is unbound.  
> > > 
> > > This looks like a fix, it has to be marked as such.
> > 
> > Well, without patch 10/10, the .remove() ops won't be called,
> > so, it is not really a fix, but I can surely add a c/c
> > stable@vger.kernel.org and add a Fixes: tag here.
> 
> You have a point - unless we send patch 10 to stable as well I
> would not tag it then.
> 
> > > > While here, add a poweroff function, in order to abstract
> > > > between the internal and external PHY logic.
> > > > 
> > > > Acked-by: Xiaowei Song <songxiaowei@hisilicon.com>
> > > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > > ---
> > > > 
> > > > See [PATCH v13 00/10] at: https://lore.kernel.org/all/cover.1634539769.git.mchehab+huawei@kernel.org/
> > > > 
> > > >  drivers/pci/controller/dwc/pcie-kirin.c | 30 ++++++++++++++++---------
> > > >  1 file changed, 20 insertions(+), 10 deletions(-)
> > > > 
> > > > diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
> > > > index b17a194cf78d..ffc63d12f8ed 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-kirin.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> > > > @@ -680,6 +680,23 @@ static const struct dw_pcie_host_ops kirin_pcie_host_ops = {
> > > >  	.host_init = kirin_pcie_host_init,
> > > >  };
> > > >  
> > > > +static int kirin_pcie_power_off(struct kirin_pcie *kirin_pcie)
> > > > +{
> > > > +	int i;
> > > > +
> > > > +	if (kirin_pcie->type == PCIE_KIRIN_INTERNAL_PHY)
> > > > +		return hi3660_pcie_phy_power_off(kirin_pcie);
> > > > +
> > > > +	for (i = 0; i < kirin_pcie->n_gpio_clkreq; i++) {
> > > > +		gpio_direction_output(kirin_pcie->gpio_id_clkreq[i], 1);
> > > > +	}  
> > > 
> > > It looks like you are adding functionality here (ie gpio), not
> > > just wrapping common code in a function.
> > 
> > It is just reverting the power on logic there.
> 
> What I am saying is that executing:
> 
> for (i = 0; i < kirin_pcie->n_gpio_clkreq; i++)
> 	gpio_direction_output(kirin_pcie->gpio_id_clkreq[i], 1);
> 
> is an addition to what current code does AFAICS (ie you are not just
> moving code into a function - kirin_pcie_power_off(), you are adding
> to it), it is a logical change that belongs in a separate patch.
> 
> There are two logical changes:
> 
> - Adding dw_pcie_host_deinit()
> - Moving PHY power off code into kirin_pcie_power_off() (and adding
>   gpio handling in it)
> 
> That's what I read from the diffstat, please correct me if I am wrong.

Hi Mauro,

any comment on the above ? It is the last question I have before
merging the series, please let me know.

Thanks,
Lorenzo
