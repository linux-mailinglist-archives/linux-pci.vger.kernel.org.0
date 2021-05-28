Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40A7F393A33
	for <lists+linux-pci@lfdr.de>; Fri, 28 May 2021 02:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbhE1AVJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 20:21:09 -0400
Received: from mo-csw1114.securemx.jp ([210.130.202.156]:38318 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbhE1AVI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 May 2021 20:21:08 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 14S0J9AJ025780; Fri, 28 May 2021 09:19:09 +0900
X-Iguazu-Qid: 2wGqimLSozX9hKxvxD
X-Iguazu-QSIG: v=2; s=0; t=1622161149; q=2wGqimLSozX9hKxvxD; m=Pb46Z15qciiqLgO5v7wtl2OcpgmVSghjbHQivoSirVw=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
        by relay.securemx.jp (mx-mr1112) id 14S0J8hT010418
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 28 May 2021 09:19:08 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id 143891000A4;
        Fri, 28 May 2021 09:19:08 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 14S0J7TP028838;
        Fri, 28 May 2021 09:19:07 +0900
Date:   Fri, 28 May 2021 09:19:05 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, punit1.agrawal@toshiba.co.jp,
        yuji2.ishikawa@toshiba.co.jp, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] PCI: Visconti: Add Toshiba Visconti PCIe host
 controller driver
X-TSB-HOP: ON
Message-ID: <20210528001905.26fvguz7fk7cxxsj@toshiba.co.jp>
References: <20210524063004.132043-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210524063004.132043-3-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210524111051.GB244904@rocinante.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210524111051.GB244904@rocinante.localdomain>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, 

Thanks for your review.

On Mon, May 24, 2021 at 01:10:51PM +0200, Krzysztof Wilczyński wrote:
> Hi Nobuhiro,
> 
> Thank you for working on this!
> 
> [...]
> > +static int visconti_get_resources(struct platform_device *pdev,
> > +				  struct visconti_pcie *pcie)
> > +{
> [...]
> > +	pcie->refclk = devm_clk_get(dev, "pcie_refclk");
> > +	if (IS_ERR(pcie->refclk)) {
> > +		dev_err(dev, "Failed to get refclk clock: %ld\n",
> > +			PTR_ERR(pcie->refclk));
> > +		return PTR_ERR(pcie->refclk);
> > +	}
> > +
> > +	pcie->sysclk = devm_clk_get(dev, "sysclk");
> > +	if (IS_ERR(pcie->sysclk)) {
> > +		dev_err(dev, "Failed to get sysclk clock: %ld\n",
> > +			PTR_ERR(pcie->sysclk));
> > +		return PTR_ERR(pcie->sysclk);
> > +	}
> > +
> > +	pcie->auxclk = devm_clk_get(dev, "auxclk");
> > +	if (IS_ERR(pcie->auxclk)) {
> > +		dev_err(dev, "Failed to get auxclk clock: %ld\n",
> > +			PTR_ERR(pcie->auxclk));
> > +		return PTR_ERR(pcie->auxclk);
> > +	}
> 
> Do you think you could use the dev_err_probe() to handle the
> devm_clk_get() failed?  Where applicable this is becoming a common
> patter drivers apply, for example:
> 
>   pcie->refclk = devm_clk_get(dev, "pcie_refclk");
>   if (IS_ERR(pcie->refclk))
>   	return dev_err_probe(dev, PTR_ERR(pcie->refclk),
> 			     "failed to get refclk clock\n");
> 
> [...]

Thanks for your suggestion. I will fix using dev_err_probe().

> > +	pci->link_gen = of_pci_get_max_link_speed(pdev->dev.of_node);
> > +	if (pci->link_gen < 0 || pci->link_gen > 3) {
> > +		pci->link_gen = 3;
> > +		dev_dbg(dev, "Applied default link speed\n");
> > +	}
> > +
> > +	dev_dbg(dev, "Link speed Gen %d", pci->link_gen);
> 
> Question about the above debug messages.
> 
> Given that both are at the same level and the link speed will be printed
> regardless of whether it was set to a default value or not, does it make
> sense to still print the message about applying the default link speed?
> Unless this is something that will be indeed useful during debugging and
> troubleshooting (and in which case just ignore this question).

I guess so, the message about the default value is not important.
I will remove this, thank you.

Best regards,
  Nobuhiro
