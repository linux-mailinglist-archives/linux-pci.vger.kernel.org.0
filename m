Return-Path: <linux-pci+bounces-1191-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 814D9818F14
	for <lists+linux-pci@lfdr.de>; Tue, 19 Dec 2023 19:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8E381F2A066
	for <lists+linux-pci@lfdr.de>; Tue, 19 Dec 2023 18:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01104374F3;
	Tue, 19 Dec 2023 17:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uam53GwX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E3B3D0B4
	for <linux-pci@vger.kernel.org>; Tue, 19 Dec 2023 17:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-20308664c13so3198836fac.3
        for <linux-pci@vger.kernel.org>; Tue, 19 Dec 2023 09:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703008750; x=1703613550; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pCjAZTWWLM4FUdLW7OOrXwxN9A3rgWt2k5gNccaU1Js=;
        b=uam53GwXvXO75m7w4QFiC+fLqyHhAy0LNdtdj/paeAajebwYGkLpy391XeEoRr8IbU
         /9jQ/H9q6fdV0z5tT9154HdRbf2VGfQc7NUiwd97iXwnHAC9jmQiyDhcAEKoQSt7Jt5I
         Vxm11ntouN/XoOg0HfQFuVGKj9C5nmdv6oAguukOwAgLxwXRhAxdFBoSaPsGNaK948rP
         kuHIqqPQRt4lcdGTS0DR5jWH0vcFwVPjHxKfL+mdpf0v35uOOLgnTCJ51eYxw7RD0zov
         cg4IZBeQR2olC5Hn9iCI/kgV6YMM+k58a4GaRI/61SeOOQstfquSmUl2NEBnXwHoQ67F
         /Qnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703008750; x=1703613550;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pCjAZTWWLM4FUdLW7OOrXwxN9A3rgWt2k5gNccaU1Js=;
        b=gZhMBvOIQEEVTYitP8ZBRq0FOB49KoSAjhDYCpOOF5ZQWN75erh3KxPG8d3iGDC/PP
         HDp97H/IIXiUbWUsTFi/iV4imGwOuQ7/BEsm4jLEHqtrbSyQVwgS/AI2yOjKYfDkSfHR
         RB6gtlGnZUVBvJkvC32dzFP0pkmHIwlGoIIfsPNuRVcro8Zh8lPt3uyrjK67dV4pGhri
         0+z1UbAh2u3HvE4a20JUv0h6BWvFq91hgbcGi+yzGq4sgZ8F6K4yQ/oBWTVFbfJYS6aM
         IVxYtAzRpkgbDLB4I3KtPeW6Ub+8KamLHdC+0cFT6BdivBTjvx22k22/XEYnnXWJZb/c
         b4yg==
X-Gm-Message-State: AOJu0Yz9n8YywbIKzBbRDMLaer/FUCogKWz+ZJBuUHgHv8n63KvA9f+v
	GS1Mo5tGm+LrXb58IZN0Hmlm
X-Google-Smtp-Source: AGHT+IHPNUF80SMp5JF29BNsN7F9MBdzvUzKvDsCJcTB2tCSOrr032UZdal174E0pTEs1iB8boRy6Q==
X-Received: by 2002:a05:6871:a003:b0:1fb:18a6:4853 with SMTP id vp3-20020a056871a00300b001fb18a64853mr20258366oab.99.1703008750696;
        Tue, 19 Dec 2023 09:59:10 -0800 (PST)
Received: from thinkpad ([117.217.177.154])
        by smtp.gmail.com with ESMTPSA id r9-20020a63ec49000000b005b9083b81f0sm20039579pgj.36.2023.12.19.09.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 09:59:10 -0800 (PST)
Date: Tue, 19 Dec 2023 23:29:00 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: Frank Li <Frank.li@nxp.com>, Vidya Sagar <vidyas@nvidia.com>,
	"helgaas@kernel.org" <helgaas@kernel.org>,
	"kishon@ti.com" <kishon@ti.com>,
	"lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
	"kw@linux.com" <kw@linux.com>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
	"lznuaa@gmail.com" <lznuaa@gmail.com>,
	"hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>,
	"jdmason@kudzu.us" <jdmason@kudzu.us>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>,
	"allenbh@gmail.com" <allenbh@gmail.com>,
	"linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] PCI: designware-ep: Allow pci_epc_set_bar()
 update inbound map address
Message-ID: <20231219175900.GA24515@thinkpad>
References: <20220222162355.32369-1-Frank.Li@nxp.com>
 <20220222162355.32369-2-Frank.Li@nxp.com>
 <ZXsRp+Lzg3x/nhk3@x1-carbon>
 <ZXsc57whj/3e/+zq@lizhi-Precision-Tower-5810>
 <ZXtkMC1ZjsgHMRvT@x1-carbon>
 <ZXtrG40SR81YAR6a@lizhi-Precision-Tower-5810>
 <ZXtzjIIl5oabviZI@lizhi-Precision-Tower-5810>
 <ZX13xhBm3RmshqgD@x1-carbon>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZX13xhBm3RmshqgD@x1-carbon>

On Sat, Dec 16, 2023 at 10:11:19AM +0000, Niklas Cassel wrote:
> On Thu, Dec 14, 2023 at 04:28:44PM -0500, Frank Li wrote:
> > 
> 
> (snip)
> 
> > Does below change fix your problem?
> 
> It is basically the same fix as I sent out earlier in this thread,
> but yes, it does solve 1 out of 2 problems introduced by the patch
> in $subject, so:
> 
> Tested-by: Niklas Cassel <niklas.cassel@wdc.com>
> 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > index f6207989fc6ad..2868d44649ef7 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > @@ -177,7 +177,7 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
> >         if (!ep->bar_to_atu[bar])
> >                 free_win = find_first_zero_bit(ep->ib_window_map, pci->num_ib_windows);
> >         else
> > -               free_win = ep->bar_to_atu[bar];
> > +               free_win = ep->bar_to_atu[bar] - 1;
> >  
> >         if (free_win >= pci->num_ib_windows) {
> >                 dev_err(pci->dev, "No free inbound window\n");
> > @@ -191,7 +191,7 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
> >                 return ret;
> >         }
> >  
> > -       ep->bar_to_atu[bar] = free_win;
> > +       ep->bar_to_atu[bar] = free_win + 1;
> >         set_bit(free_win, ep->ib_window_map);
> >  
> >         return 0;
> > @@ -228,7 +228,7 @@ static void dw_pcie_ep_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> >         struct dw_pcie_ep *ep = epc_get_drvdata(epc);
> >         struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> >         enum pci_barno bar = epf_bar->barno;
> > -       u32 atu_index = ep->bar_to_atu[bar];
> > +       u32 atu_index = ep->bar_to_atu[bar] - 1;
> 
> You probably want to add a:
> 
> if (!ep->bar_to_atu[bar])
> 	return;
> 
> here, so that dw_pcie_ep_clear_bar() will never try to use -1 as index.
> (E.g. if clear_bar() is called twice on the same BAR.)
> 
> >  
> >         __dw_pcie_ep_reset_bar(pci, func_no, bar, epf_bar->flags);
> > 
> 
> (snip)
> 
> > > > from dw_pcie_ep_set_bar(), also needs to be dropped, so that the iATU
> > > > settings will be re-written for platforms with core_init_notifiers.
> > > > 
> > > > Right now, for a platform with a core_init_notifier, if you run
> > > > pci_endpoint_test + reboot the RC (so that PERST is asserted + deasserted),
> > > > and then run pci_endpoint_test again, then I'm quite sure that
> > > > pci_endpoint_test will not pass the second time (because iATU settings
> > > > were not rewritten after reset).
> > > > 
> > > > It would be nice if Mani or Vidya could confirm this.
> 
> So problem 2 out of 2 introduced by the patch in $subject is that
> DWC drivers with a .core_init_notifier, will perform a reset_control_assert()
> to reset the core (which will reset both sticky and non-sticky registers),
> which means that the early return in dw_pcie_ep_set_bar():
> https://github.com/torvalds/linux/blob/v6.7-rc5/drivers/pci/controller/dwc/pcie-designware-ep.c#L268-L269
> 
> while returning after the iATU settings have been written,
> it will return before:
> 
> 	dw_pcie_writel_dbi2(pci, reg_dbi2, lower_32_bits(size - 1));
> 	dw_pcie_writel_dbi(pci, reg, flags);
> 
> Which means that, for drivers with a .core_init_notifier, BARx_REG and
> BARx_MASK registers will not be written. This means that they will have
> reset values for these registers, which means that e.g. the BAR_SIZE
> (which is defined by BARx_MASK) might be incorrect for these platforms
> because this function returns early.
> 
> I will not send a fix for this problem, I will leave that to you, or Mani,
> or Vidya, and hope that people are happy that I simply reported this issue.
> 

The fix for this issue shouldn't be in the DWC driver but rather in the EPF
drivers. Because, EPF drivers are the ones calling pci_epc_set_bar() during
bind(). So they have to properly cleanup the resources once the perst assertion
happens. This issue also applies to other resources such as DMA channels.

The problem here is, there is a disconnect between DWC (EPC) and EPF drivers.
When the perst assertion happens, the event is not passed to EPF drivers
resulting in the EPF drivers having no knowledge that they need to give up the
resources.

We need to fix this in a sane way and I'm looking into it.

But I really appreciate your finding here and in other thread where we discussed
similar issue.

- Mani

> 
> Here is my suggested solution in case anyone wants to take a stab at it:
> 
> > > > I guess one option would be modify dw_pcie_ep_init_notify() to call
> > > > dw_pcie_ep_clear_bar() on all non-NULL BARs stored in ep->epf_bar[],
> > > > before calling pci_epc_init_notify(). That way the second .core_init
> > > > (pci_epf_test_core_init()) call will use write the settings, because
> > > > ep->epf_bar[] will be empty, so the "write the settings only the first
> > > > time" approach will then also work for core_init_notifier platforms.
> 
> 
> Kind regards,
> Niklas

-- 
மணிவண்ணன் சதாசிவம்

