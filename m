Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F23EE27AD06
	for <lists+linux-pci@lfdr.de>; Mon, 28 Sep 2020 13:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgI1Lme (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Sep 2020 07:42:34 -0400
Received: from foss.arm.com ([217.140.110.172]:49980 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbgI1Lmd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Sep 2020 07:42:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3676331B;
        Mon, 28 Sep 2020 04:42:30 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6BA1F3F6CF;
        Mon, 28 Sep 2020 04:42:29 -0700 (PDT)
Date:   Mon, 28 Sep 2020 12:42:27 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        linux-pci@vger.kernel.org, bhelgaas@google.com,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: Re: [PATCH] [-next] PCI: DWC: Fix cast truncates bits from constant
 value
Message-ID: <20200928114227.GB13256@e121166-lin.cambridge.arm.com>
References: <7ea7f7d342f97c758949a17b870012f52ce5b3f5.1600767645.git.gustavo.pimentel@synopsys.com>
 <20200922165755.GA2211756@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922165755.GA2211756@bjorn-Precision-5520>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 22, 2020 at 11:57:55AM -0500, Bjorn Helgaas wrote:
> [+cc Lorenzo]
> 
> On Tue, Sep 22, 2020 at 11:59:10AM +0200, Gustavo Pimentel wrote:
> > Fixes warning given by executing "make C=2 drivers/pci/"
> > 
> > Sparse output:
> > CHECK drivers/pci/controller/dwc/pcie-designware.c
> >  drivers/pci/controller/dwc/pcie-designware.c:432:52: warning:
> >  cast truncates bits from constant value (ffffffff7fffffff becomes
> >  7fffffff)
> > 
> > Reported-by: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Joao Pinto <jpinto@synopsys.com>
> > Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> 
> Looks good to me; thanks for persevering with this.
> 
> Hopefully Lorenzo will apply this and, in the process, adjust the
> subject line to match the history:
> 
>   PCI: dwc: ...

Done, applied to pci/dwc, thanks.

Lorenzo

> >  drivers/pci/controller/dwc/pcie-designware.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > index 3c3a4d1..e7a41d9 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -429,7 +429,7 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, int index,
> >  	}
> >  
> >  	dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, region | index);
> > -	dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, (u32)~PCIE_ATU_ENABLE);
> > +	dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, ~(u32)PCIE_ATU_ENABLE);
> >  }
> >  
> >  int dw_pcie_wait_for_link(struct dw_pcie *pci)
> > -- 
> > 2.7.4
> > 
