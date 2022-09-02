Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F2F5AA530
	for <lists+linux-pci@lfdr.de>; Fri,  2 Sep 2022 03:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234985AbiIBBjF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Sep 2022 21:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbiIBBjC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Sep 2022 21:39:02 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638DE91D2F
        for <linux-pci@vger.kernel.org>; Thu,  1 Sep 2022 18:39:00 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id b196so681079pga.7
        for <linux-pci@vger.kernel.org>; Thu, 01 Sep 2022 18:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=xtrTkJ4Uu3ohhJxNrzty1GMo4mCUZ5As2LZg/P4tK50=;
        b=YYQS3U2an0NHsaT3kRyB/CjX2F6iSDaaaXdAkWZvO6gonxfA9qhHlPPJIy66EZe3ZR
         wxIjWeCJzO7jdFWWO88kKC3qSXJ1mLTTNBSOcVvGsmLmcdYAQSBwKNehifBdxOZDugqV
         isbdfKU8zmXU8m/Rm4CMHQofJVobu0qt2c+DjTYFJ5nX6ZsHTBHOxLlM51mZyvNLpmVQ
         Q+YgCC0+Y8zFHJRTaKTF2NKyWdE/a8DEmMRHAUZ8A1vOp/Kq1MqYaKQzBTyto1CV5NQP
         3+lPV55ABJaNHPEdbwbeUfQ4cHlupDfFN0jhMHJfQ5143PjQWyb5UgPyMSfsKXs/t6TM
         bxOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=xtrTkJ4Uu3ohhJxNrzty1GMo4mCUZ5As2LZg/P4tK50=;
        b=ITm33MYxWbAoQxO4o3qDZ0Ph7nSvtmEPthODzDiSE3Mre+O5i9axk6TJOecH5L3tcw
         FDU2CnYuEOEO245RBSjTmWp/xNbszz6yJ7ZijBFBIKmKE8p4UNMmgHthuncTUZhCU+FN
         WR7Kx+i8CyFP9QEQ2XLjct6UKMcfWN9vnng6JOBI21Excn0HauvVO+zJIbTBkMLRgJLg
         V4a3CzeI5yo98y6SQ59U6chLMxD7eHkOSUQGOoBeWe+xlc4ZScyY4cNlyzwmYcHGZHmG
         WxYq2j89Ag5cO5yUCuw+3r8NiOTgwREyi8n91aoFe6CwhzpLNGJ38GL3GMaZEWiFXMRr
         oo8A==
X-Gm-Message-State: ACgBeo18D+vSc4O/tQ2OV6X7cV5PcS4xju23cqEXyNl5+d+7D5yTAMsI
        pC+kZ3RdRxWgBLt+S4NewKKw
X-Google-Smtp-Source: AA6agR7DjBAE56OPQD2pNaMD6zNmrRU9jU2sr6gi8usaSIIxK9Wdjn2+Sdz7pqPgMja4jY2efNlR5A==
X-Received: by 2002:a63:4b5e:0:b0:41d:e04b:4515 with SMTP id k30-20020a634b5e000000b0041de04b4515mr28031011pgl.100.1662082739808;
        Thu, 01 Sep 2022 18:38:59 -0700 (PDT)
Received: from thinkpad ([117.217.177.124])
        by smtp.gmail.com with ESMTPSA id y1-20020a17090a474100b001fdbb2e38acsm4058764pjg.5.2022.09.01.18.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 18:38:58 -0700 (PDT)
Date:   Fri, 2 Sep 2022 07:08:48 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Frank Li <frank.li@nxp.com>
Cc:     "maz@kernel.org" <maz@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "ntb@lists.linux.dev" <ntb@lists.linux.dev>,
        "lznuaa@gmail.com" <lznuaa@gmail.com>
Subject: Re: [EXT] Re: [PATCH v6 4/4] pcie: endpoint: pci-epf-vntb: add
 endpoint MSI support
Message-ID: <20220902013848.GA4935@thinkpad>
References: <20220818151127.2449064-1-Frank.Li@nxp.com>
 <20220818151127.2449064-5-Frank.Li@nxp.com>
 <20220831104203.GD5076@thinkpad>
 <AM9PR04MB8793BEEC8B2F1713C252B4CA88789@AM9PR04MB8793.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM9PR04MB8793BEEC8B2F1713C252B4CA88789@AM9PR04MB8793.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 31, 2022 at 04:19:17PM +0000, Frank Li wrote:
> 
> 
> > -----Original Message-----
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Sent: Wednesday, August 31, 2022 5:42 AM
> > To: Frank Li <frank.li@nxp.com>
> > Cc: maz@kernel.org; tglx@linutronix.de; robh+dt@kernel.org;
> > krzysztof.kozlowski+dt@linaro.org; shawnguo@kernel.org;
> > s.hauer@pengutronix.de; kw@linux.com; bhelgaas@google.com; linux-
> > kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org; linux-pci@vger.kernel.org; Peng Fan
> > <peng.fan@nxp.com>; Aisheng Dong <aisheng.dong@nxp.com>;
> > jdmason@kudzu.us; kernel@pengutronix.de; festevam@gmail.com; dl-linux-
> > imx <linux-imx@nxp.com>; kishon@ti.com; lorenzo.pieralisi@arm.com;
> > ntb@lists.linux.dev; lznuaa@gmail.com
> > Subject: [EXT] Re: [PATCH v6 4/4] pcie: endpoint: pci-epf-vntb: add endpoint
> > MSI support
> > 
> > Caution: EXT Email
> > 
> > On Thu, Aug 18, 2022 at 10:11:27AM -0500, Frank Li wrote:
> > >                         ┌───────┐          ┌──────────┐
> > >                         │       │          │          │
> > >       ┌─────────────┐   │       │          │ PCI Host │
> > >       │ MSI         │◄┐ │       │          │          │
> > >       │ Controller  │ │ │       │          │          │
> > >       └─────────────┘ └─┼───────┼───
> > ───────┼─BAR0     │
> > >                         │ PCI   │          │ BAR1     │
> > >                         │ Func  │          │ BAR2     │
> > >                         │       │          │ BAR3     │
> > >                         │       │          │ BAR4     │
> > >                         │       ├─────────►│          │
> > >                         └───────┘          └──────────┘
> > >
> > 
> > This diagram doesn't say which side is host and which one is endpoint.
> > And not conveying any useful information.
> 
> [Frank Li] At V2 version, this diagram is in cover letter.  Bjorn suggest move to here.
> I think you have good background knowledge.  But it should be helpful for new
> People,  who just touch this area. 
> 

Having the block diagram always helps but my point is that this diagram doesn't
convey the immediate knowledge that it is supposed to do so. Like there is no
partition between host and endpoint and you did not add any explanation about
it in the below text. So in v2, please incorporate those.

> I already mark "PCI Func" and "PCI Host".  
> 

Sorry, that's not helpful and you need to improve it.

> > 
> > > Linux supports endpoint functions. PCI Host write BAR<n> space like write
> > > to memory. The EP side can't know memory changed by the host driver.
> > >
> > 
> > I think you just say, that there is no defined way of raising IRQs by host
> > to the endpoint.
> > 
> > > PCI Spec has not defined a standard method to do that. Only define MSI(x)
> > > to let EP notified RC status change.
> > >
> > 
> > MSI is from EP, right? Throughout the driver you should call it as "doorbell"
> > and not MSI.
> 
> [Frank Li] What's I want said is that PCI standard define MSI(x) to let EP notify RC. 
> But there are not standard way for reverse direction.  MSI should be correct here.
> 

Right. But also use "MSI/MSI-X" instead of "MSI(x)"

> > 
> > > The basic idea is to trigger an IRQ when PCI RC writes to a memory
> > > address. That's what MSI controller provided. EP drivers just need to
> > > request a platform MSI interrupt, struct msi_msg *msg will pass down a
> > > memory address and data. EP driver will map such memory address to one
> > of
> > > PCI BAR<n>.  Host just writes such an address to trigger EP side irq.
> > >
> > 
> > IIUC (by looking at other patches in the series), the memory assigned for BAR
> > region by the PCI host is mapped to the platform interrupt controller in
> > PCI Endpoint. Such that, whenever the PCI host writes to the BAR region, it
> > will trigger an IRQ in the Endpoint.
> > 
> > This kind of setup is available in other platforms like Qualcomm where the
> > mapping of a register region available in BAR0 and interrupt controller is
> > done in the hardware itself. So whenever the PCI host writes to that register
> > in BAR0, an IRQ will be delivered to the endpoint.
> 
> [Frank Li] Yes,  not all platform have it. And EP driver have not provide a API
> to get register region.  I think platform msi API is pretty good API. 
> Many system have GIC ITS,  so EP function driver can use it.  Our test platform
> have not ITS yet,  so we added a simple MU-MSI driver to do it. I think qualcomm
> platform can use similar method.  So all EP function driver can use common method
> to get notification from PCI host.
> 

What is the common method here? If you want to make this doorbell feature
common across all EPF drivers, then you need to provide EPF APIs.

> > 
> > > Add MSI support for pci-epf-vntb. pci-epf-vntb driver query if system
> > > have MSI controller. Setup doorbell address according to struct msi_msg.
> > >
> > > So PCIe host can write this doorbell address to triger EP side's irq.
> > >
> > > If no MSI controller exist, fall back to software polling.
> > >
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 134 +++++++++++++++---
> > >  1 file changed, 112 insertions(+), 22 deletions(-)
> > >
> > > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > b/drivers/pci/endpoint/functions/pci-epf-vntb.c

[...]

> > > +static void epf_ntb_epc_msi_init(struct epf_ntb *ntb)
> > > +{
> > > +     struct device *dev = &ntb->epf->dev;
> > > +     struct irq_domain *domain;
> > > +     int virq;
> > > +     int ret;
> > > +     int i;
> > > +
> > > +     domain = dev_get_msi_domain(ntb->epf->epc->dev.parent);
> > > +     if (!domain)
> > > +             return;
> > > +
> > > +     dev_set_msi_domain(dev, domain);
> > > +
> > > +     if (platform_msi_domain_alloc_irqs(&ntb->epf->dev,
> > > +             ntb->db_count,
> > > +             epf_ntb_write_msi_msg)) {
> > > +             dev_info(dev, "Can't allocate MSI, fall back to poll mode\n");
> > > +             return;
> > > +     }
> > > +
> > > +     dev_info(dev, "vntb use MSI as doorbell\n");
> > > +
> > 
> > Why are you using the interrupt controller as the MSI controller? Why not
> > just
> > a plain interrupt controller?
> 
> [Frank Li] what's your means?   I think only MSI controller support write memory to trigger irq.
> 

From EPF driver perspective, only the IRQs need to be requested, right? So why
cannot you expose MU as a generic irqchip driver, instead of a MSI controller? 

Thanks,
Mani

-- 
மணிவண்ணன் சதாசிவம்
