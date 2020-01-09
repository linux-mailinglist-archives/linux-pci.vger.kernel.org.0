Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E96B11357BA
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2020 12:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729864AbgAILPL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jan 2020 06:15:11 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42943 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728918AbgAILPK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jan 2020 06:15:10 -0500
Received: by mail-pf1-f196.google.com with SMTP id 4so3230443pfz.9
        for <linux-pci@vger.kernel.org>; Thu, 09 Jan 2020 03:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V5KScgUXFsdncgT6FrgA2mFPOOg0Ude/9JNc+emy5Ls=;
        b=G7LF1zERk0/S8IFqf2HWTYi1sdr4IgJVAeJUqtn57RmwNJ2mvqYBRy4J15mBuLkj3W
         kkHxOqlJ5af9EXg8gOaiMG8Dwz/WZZawY4P729TXGs3ZMYond1SXSeMj4C9l1aR7wlbr
         5AdMNz0MuFEdftCXlnZWYumWS4OzRBUHtsJLdp9WUhm1A4pmXQBvy/kzao0KT3gnrTi1
         fNy+905kkFtQSGbc/yMyk9s3Ds+Sh6NU2ZSKkMdZ1zlFJlfhARIvYkHyAjktAMQq0hzo
         FtvV98EtG0npILvKugmEuhrjuo9ZAa+GU0LxL6sGTrgmLYD+M/ykFLRQ1cXt9OXdl7bP
         dSCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V5KScgUXFsdncgT6FrgA2mFPOOg0Ude/9JNc+emy5Ls=;
        b=EmWEMh4l9mIFjQROXLG7soZK58Cd/6YX/a7tJAppYPwpjmHjtVNK1fCShAbwjPrkrD
         l7BNrUGvm51qYVQbEBBQHNv0oQbZL8kt+R0IHBalFLHBBHSPKHpwja88RYYyC6GS8QoH
         Uyr3NcFHVE8yiPRF/GR2n99EoBSh0rU6PUMRF9+f9yj3LpW8KyL9nEjPy2rtE5TFEQM0
         FQJkGacnQs6S8EIAIvZgeaNdBIRe4/ao/5pX0MA7sd+BZGW9ze1C1FXS6A82n5eiRTXC
         yrUgJsJZTwUuRc7TCCuyTCZtBROUYbNotpLZqPR/gBk2wxDXTyEcSNE03JVGKNqu5xcg
         QZEQ==
X-Gm-Message-State: APjAAAXK2YDwjdtCHAUkzLCjrZQWXXVCX0sElE+dC2OPuP6Ru8E/tlE+
        AV4KX5CXUmtAayPd62JEKUC3yQ==
X-Google-Smtp-Source: APXvYqxz0NcBJqX/ySDqpIt+UdCTpr25Lr5id6kHEoB6WfJr9rFZr/50dFv0BbiymZQlt7ZB6ii32A==
X-Received: by 2002:a65:5608:: with SMTP id l8mr10788035pgs.210.1578568509940;
        Thu, 09 Jan 2020 03:15:09 -0800 (PST)
Received: from T480 (98.142.130.235.16clouds.com. [98.142.130.235])
        by smtp.gmail.com with ESMTPSA id r66sm7960444pfc.74.2020.01.09.03.15.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Jan 2020 03:15:09 -0800 (PST)
Date:   Thu, 9 Jan 2020 19:14:58 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Zaihai Yu <yuzaihai@hisilicon.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] PCI: dwc: Separate CFG0 and CFG1 into different ATU
 regions
Message-ID: <20200109111457.GA18850@T480>
References: <20200109060657.1953-1-shawn.guo@linaro.org>
 <CH2PR12MB40073FCB953227A37F7A1A91DA390@CH2PR12MB4007.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH2PR12MB40073FCB953227A37F7A1A91DA390@CH2PR12MB4007.namprd12.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Gustavo,

Thanks for taking a look.

On Thu, Jan 09, 2020 at 10:37:14AM +0000, Gustavo Pimentel wrote:
> Hi Shawn,
> 
> On Thu, Jan 9, 2020 at 6:6:57, Shawn Guo <shawn.guo@linaro.org> wrote:
> 
> > Some platform has 4 (or more) viewports.  In that case, CFG0 and CFG1
> 
> Remove double space before "In that..." 

Hmm, that was intentional.  My writing practice is using two spaces
after a period and single space after a comma.  Is it a bad habit?

@Lorenzo, @Bjorn, let me know if you guys think this should be fixed.

> 
> > can be separated into different ATU regions.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> >  .../pci/controller/dwc/pcie-designware-host.c    | 16 +++++++++++++++-
> >  drivers/pci/controller/dwc/pcie-designware.h     |  1 +
> >  2 files changed, 16 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index 0f36a926059a..504d2a192bba 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -532,6 +532,7 @@ static int dw_pcie_access_other_conf(struct pcie_port *pp, struct pci_bus *bus,
> >  	u64 cpu_addr;
> >  	void __iomem *va_cfg_base;
> >  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > +	int index = PCIE_ATU_REGION_INDEX1;
> >  
> >  	busdev = PCIE_ATU_BUS(bus->number) | PCIE_ATU_DEV(PCI_SLOT(devfn)) |
> >  		 PCIE_ATU_FUNC(PCI_FUNC(devfn));
> > @@ -548,7 +549,20 @@ static int dw_pcie_access_other_conf(struct pcie_port *pp, struct pci_bus *bus,
> >  		va_cfg_base = pp->va_cfg1_base;
> >  	}
> >  
> > -	dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX1,
> > +	if (pci->num_viewport >= 4) {
> > +		/*
> > +		 * If there are 4 (or more) viewports, we can separate
> > +		 * CFG0 and CFG1 into different ATU regions:
> > +		 *  - region0: MEM
> > +		 *  - region1: CFG0
> > +		 *  - region2: IO
> > +		 *  - region3: CFG1
> > +		 */
> > +		if (type == PCIE_ATU_TYPE_CFG1)
> > +			index = PCIE_ATU_REGION_INDEX3;
> > +	}
> > +
> > +	dw_pcie_prog_outbound_atu(pci, index,
> >  				  type, cpu_addr,
> >  				  busdev, cfg_size);
> >  	if (write)
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > index 5a18e94e52c8..86225804f1e7 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -63,6 +63,7 @@
> >  #define PCIE_ATU_VIEWPORT		0x900
> >  #define PCIE_ATU_REGION_INBOUND		BIT(31)
> >  #define PCIE_ATU_REGION_OUTBOUND	0
> > +#define PCIE_ATU_REGION_INDEX3		0x3
> >  #define PCIE_ATU_REGION_INDEX2		0x2
> >  #define PCIE_ATU_REGION_INDEX1		0x1
> >  #define PCIE_ATU_REGION_INDEX0		0x0
> > -- 
> > 2.17.1
> 
> With the description fix,
> 
> Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>

Thanks!

Shawn
