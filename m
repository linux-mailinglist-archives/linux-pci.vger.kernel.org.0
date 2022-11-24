Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B29637F4B
	for <lists+linux-pci@lfdr.de>; Thu, 24 Nov 2022 19:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiKXSqQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 13:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiKXSp7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 13:45:59 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45674EC0A
        for <linux-pci@vger.kernel.org>; Thu, 24 Nov 2022 10:45:03 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id w15-20020a17090a380f00b0021873113cb4so2268511pjb.0
        for <linux-pci@vger.kernel.org>; Thu, 24 Nov 2022 10:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5mUc7Hj+XQfjTjlDIFjVYP+TraLI2iMKH19WfjbmoCU=;
        b=qrssbKT0+X3S2a2vA11xfRsFFE4GBXlNnE3Zh83wyE/w7BcnXA8O3tKMV+MsNTedd5
         o2mVKqmODuotSHR59IgWUSH7zyL9r+dwGCTFvGwDKbxkauQMab+S2T5Xs9LFCwVVdM9j
         WkqgWig6tXHfByOjZfNwAeyBf+1vh+Mo9PGTt+HkZbpWqABdUpLksBLyvCf+ZhhWeyGs
         MyoeWSKhjiXt95/TxHXXFXJ6T3stbaWbvDWF8SAxiNYpxnIr+awhB3hb1Pdep/8Ho6cP
         BqQw87mzNiLP6hXkkFbJNy1ty49OtCtlsq7XDbZL9zMxLQ0IhbpTfHkIXSpmNfWPIMU7
         OdKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5mUc7Hj+XQfjTjlDIFjVYP+TraLI2iMKH19WfjbmoCU=;
        b=KKBgY2V63VMdcjFhogU1ALcT7md2B9bTzfHNPj7VVEUlUfstuGQmr1xClIEYdi/Uw+
         48JeMzsLuhVyDpaEK2vI6rH4ajcyWT6/KCg7XyZBSOMKAlOU1adL4JTS/5PzyE0wKRS/
         ZAY5HhZvJb9+qEGe73JZSPPSkrdo1LFrYmbltJwz6soej44bIUM15ZKa1rtz2jx3EnV1
         vI6r9cNWWL+W53WnX8ONDhkr/OAKMAzXLeBdpjVrAo6ogHK0HHJaYN2KhcX3qFPNAPGw
         sVN9YkvKhUepFyHeWT5+uiTuRVdPJTotYv7tV07ASlxW1veb14jBV5nTloki/tixDTom
         aJBQ==
X-Gm-Message-State: ANoB5pnNCYXOY6qztxeB6GPT5U46GYKUvzIDiUob7bH6EFdWUgPTVi/z
        dCnVF80N6z1YvGCXca5z10gw
X-Google-Smtp-Source: AA0mqf5MMfxGvtucAaoiCKcufA3lnsdQsAgasNIMeAFqC8DNifHVxaNFhZZEDb+GN87gxeUCiAxbxw==
X-Received: by 2002:a17:90b:358a:b0:218:c490:33f6 with SMTP id mm10-20020a17090b358a00b00218c49033f6mr17801949pjb.83.1669315498433;
        Thu, 24 Nov 2022 10:44:58 -0800 (PST)
Received: from thinkpad ([117.202.190.212])
        by smtp.gmail.com with ESMTPSA id b12-20020aa7950c000000b0056c349f5c70sm1539156pfp.79.2022.11.24.10.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 10:44:57 -0800 (PST)
Date:   Fri, 25 Nov 2022 00:14:48 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Frank Li <frank.li@nxp.com>
Cc:     "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "kishon@ti.com" <kishon@ti.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>, "kw@linux.com" <kw@linux.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "lznuaa@gmail.com" <lznuaa@gmail.com>,
        "maz@kernel.org" <maz@kernel.org>,
        "ntb@lists.linux.dev" <ntb@lists.linux.dev>,
        Peng Fan <peng.fan@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>
Subject: Re: [EXT] Re: [PATCH v13 2/2] PCI: endpoint: pci-epf-vntb: using
 platform MSI as doorbell
Message-ID: <20221124184448.GF5119@thinkpad>
References: <20221124055036.1630573-1-Frank.Li@nxp.com>
 <20221124055036.1630573-3-Frank.Li@nxp.com>
 <20221124090028.GC5119@thinkpad>
 <HE1PR0401MB2331D3964AE6ABEA4AAEFC87880F9@HE1PR0401MB2331.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <HE1PR0401MB2331D3964AE6ABEA4AAEFC87880F9@HE1PR0401MB2331.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 24, 2022 at 06:03:40PM +0000, Frank Li wrote:
> 
> 
> > -----Original Message-----
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Sent: Thursday, November 24, 2022 3:00 AM
> > To: Frank Li <frank.li@nxp.com>
> > Cc: lpieralisi@kernel.org; Aisheng Dong <aisheng.dong@nxp.com>;
> > bhelgaas@google.com; devicetree@vger.kernel.org; festevam@gmail.com;
> > imx@lists.linux.dev; jdmason@kudzu.us; kernel@pengutronix.de;
> > kishon@ti.com; krzysztof.kozlowski+dt@linaro.org; kw@linux.com; linux-
> > arm-kernel@lists.infradead.org; dl-linux-imx <linux-imx@nxp.com>; linux-
> > kernel@vger.kernel.org; linux-pci@vger.kernel.org;
> > lorenzo.pieralisi@arm.com; lznuaa@gmail.com; maz@kernel.org;
> > ntb@lists.linux.dev; Peng Fan <peng.fan@nxp.com>; robh+dt@kernel.org;
> > s.hauer@pengutronix.de; shawnguo@kernel.org; tglx@linutronix.de
> > Subject: [EXT] Re: [PATCH v13 2/2] PCI: endpoint: pci-epf-vntb: using platform
> > MSI as doorbell
> > 
> > Caution: EXT Email
> > 
> > On Thu, Nov 24, 2022 at 12:50:36AM -0500, Frank Li wrote:
> > > ┌────────────┐   ┌───────────────
> > ────────────────────┐   ┌─────────
> > ───────┐
> > > │            │   │                                   │   │                │
> > > │            │   │ PCI Endpoint                      │   │ PCI Host       │
> > > │            │   │                                   │   │                │
> > > │            │◄──┤ 1.platform_msi_domain_alloc_irqs()│   │
> > │
> > > │            │   │                                   │   │                │
> > > │ MSI        ├──►│ 2.write_msi_msg()                 ├──►├─BAR<n>
> > │
> > > │ Controller │   │   update doorbell register address│   │                │
> > > │            │   │   for BAR                         │   │                │
> > > │            │   │                                   │   │ 3. Write BAR<n>│
> > > │            │◄──┼──────────────────────
> > ─────────────┼───┤                │
> > > │            │   │                                   │   │                │
> > > │            ├──►│ 4.Irq Handle                      │   │                │
> > > │            │   │                                   │   │                │
> > > │            │   │                                   │   │                │
> > > └────────────┘   └───────────────
> > ────────────────────┘   └─────────
> > ───────┘
> > >
> > 
> > There are at least couple of BAR regions used in this patch but they were not
> > mentioned in the above diagram.
> 
> This patch just affected one BAR regions.  Do you like "BAR[DB]"?
> 
> Do you want to me draw other BARs, which used by this function?
> 

It'd be good to just mention DB BAR.

> > 
> > The subject should be:
> > 
> > "PCI: endpoint: pci-epf-vntb: Use EP MSI controller to handle DB from host"
> > 
> > > Using platform MSI interrupt controller as endpoint(EP)'s doorbell.
> > >
> > 
> > Above line is not needed.
> > 
> > > The memory assigned for BAR region by the PCI host is mapped to the
> > 
> > Which BAR? (BAR 1 aka. DB BAR)? There are multiple BAR regions exposed by
> > this function driver.
> > 
> > > message address of platform msi interrupt controller in PCI Endpoint.
> > 
> > s/msi/MSI. Also, use either Endpoint or EP, pick one but not both.
> > 
> > > Such that, whenever the PCI host writes to the BAR region, it will
> > > trigger an IRQ in the EP.
> > >
> > > Basic working follow as
> > 
> > "work flow is"?
> > 
> > > 1. EP function driver call platform_msi_domain_alloc_irqs() alloc a
> > 
> > pci-epf-vntb function driver calls platform_msi_domain_alloc_irqs() to
> > allocate
> > MSI's from the platform MSI controller.
> > 
> > > MSI irq from MSI controller with call back function write_msi_msg();
> > > 2. write_msg_msg will config BAR and map to address defined in msi_msg;
> > 
> > The epf_ntb_write_msi_msg() passed as a callback will write the offset of the
> > MSI controller's MSI address dedicated for each MSI to the doorbell register
> > db_offset and also writes the MSI data to db_data register in the CTRL BAR
> > region.
> > 
> > > 3. Host side trigger an IRQ at Endpoint by write to BAR region.
> > >
> > 
> > Finally, the host can trigger doorbell by reading the offset of the doorbell
> > from db_offset register and writing the data read from db_data register in
> > CTRL
> > BAR region to the computed address in the DB BAR region.
> > 
> > > Add MSI doorbell support for pci-epf-vntb. Query if system has an MSI
> > > controller. Set up doorbell address according to struct msi_msg.
> > >
> > > So PCI host can write this doorbell address to trigger EP side's IRQ.
> > >
> > > If no MSI controller exists, fall back to software polling.
> > >
> > 
> > "Add doorbell support to pci-epf-vntb function driver making use of the
> > platform
> > MSI controller. If the MSI controller is not available, fallback to the polling
> > method."
> > 
> > Also, please move this paragraph to the beginning of the description.
> > 
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 146 +++++++++++++++---
> > >  1 file changed, 125 insertions(+), 21 deletions(-)
> > >
> > > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > index 0d744975f815..f770a068e58c 100644
> > > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > @@ -44,6 +44,7 @@
> > >  #include <linux/pci-epc.h>
> > >  #include <linux/pci-epf.h>
> > >  #include <linux/ntb.h>
> > > +#include <linux/msi.h>
> > >
> > >  static struct workqueue_struct *kpcintb_workqueue;
> > >
> > > @@ -137,11 +138,14 @@ struct epf_ntb {
> > >       struct epf_ntb_ctrl *reg;
> > >
> > >       u32 *epf_db;
> > > +     phys_addr_t epf_db_phys;
> > >
> > >       phys_addr_t vpci_mw_phy[MAX_MW];
> > >       void __iomem *vpci_mw_addr[MAX_MW];
> > >
> > >       struct delayed_work cmd_handler;
> > > +
> > > +     int msi_virqbase;
> > >  };
> > 
> > You should add kernel doc comments for this struct in a separate patch. It
> > will
> > help in understanding the driver better.
> > 
> > >
> > >  #define to_epf_ntb(epf_group) container_of((epf_group), struct epf_ntb,
> > group)
> > > @@ -256,11 +260,13 @@ static void epf_ntb_cmd_handler(struct
> > work_struct *work)
> > >
> > >       ntb = container_of(work, struct epf_ntb, cmd_handler.work);
> > >
> > > -     for (i = 1; i < ntb->db_count; i++) {
> > > -             if (ntb->epf_db[i]) {
> > > -                     ntb->db |= 1 << (i - 1);
> > > -                     ntb_db_event(&ntb->ntb, i);
> > > -                     ntb->epf_db[i] = 0;
> > 
> > A comment here stating that polling is implemented would be better.
> > 
> > > +     if (!ntb->epf_db_phys) {
> > > +             for (i = 1; i < ntb->db_count; i++) {
> > > +                     if (ntb->epf_db[i]) {
> > > +                             ntb->db |= 1 << (i - 1);
> > > +                             ntb_db_event(&ntb->ntb, i);
> > > +                             ntb->epf_db[i] = 0;
> > > +                     }
> > >               }
> > >       }
> > >
> > > @@ -518,6 +524,28 @@ static int epf_ntb_configure_interrupt(struct
> > epf_ntb *ntb)
> > >       return 0;
> > >  }
> > >
> > > +static int epf_ntb_db_size(struct epf_ntb *ntb)
> > > +{
> > > +     const struct pci_epc_features *epc_features;
> > > +     size_t size = sizeof(u32) * ntb->db_count;
> > > +     u32 align;
> > > +
> > > +     epc_features = pci_epc_get_features(ntb->epf->epc,
> > > +                                         ntb->epf->func_no,
> > > +                                         ntb->epf->vfunc_no);
> > > +     align = epc_features->align;
> > > +
> > > +     if (size < 128)
> > 
> > Shouldn't this be (size > 128)?
>  
> This is one coming from pci-epf-ntb.c.
> Not sure there are some EP hardware have such limitation.
>  

I'm not sure if that is correct though. drivers/ntb/hw/epf/ntb_hw_epf.c sets
the upper limit to 32 (NTB_EPF_MAX_DB_COUNT + 1) DBs, in that case the size
cannot go beyond 128.

Thanks,
Mani
-- 
மணிவண்ணன் சதாசிவம்
