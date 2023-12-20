Return-Path: <linux-pci+bounces-1215-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA54B81987F
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 07:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97D6A288794
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 06:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BF911C81;
	Wed, 20 Dec 2023 06:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dnLKLmqp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804CA168D6
	for <linux-pci@vger.kernel.org>; Wed, 20 Dec 2023 06:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d3f2985425so250795ad.3
        for <linux-pci@vger.kernel.org>; Tue, 19 Dec 2023 22:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703052248; x=1703657048; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+0vykn25YgXqPuj0htPCqxMV/eZgBVykFB8sc8+W7XY=;
        b=dnLKLmqpLnycMOHvNF26d/v6OQtIGQt+M7S8PZGbfxvl1J21nKlT0AjOtTZZwLVKJY
         ThFG5wD6nrSFi0KE5AyG6HhUGTUgwfjbob5em2NTQf4oQA8DSUrSaMRw2HMzcN/NodoZ
         VRGjwMuvNB0lU9qKoXrUGUOnMuvORKN4zE+zYXhcc1hPBPi1L7/HfgN8PPuNiPCx5Psk
         qtxOCqgB4NnwAjf9wMbxzCwKa3FBAg2K9s3Fi9q+DCuTsnULPxCYQDDxXE+RuFARlfA4
         NPwpxWBg/4j9CWxydwD+NBR48YE6qgEwcskVJ/0/BOOjJ71tpBgWr5JmWWGoNpgCOEdH
         Yzhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703052248; x=1703657048;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+0vykn25YgXqPuj0htPCqxMV/eZgBVykFB8sc8+W7XY=;
        b=fVix5adXYaFxPlfHr/qy9pkne/u3kKMo/ibEKJN+xnxjZ4ldHkkt0SBHRQITid940a
         gtIYXCo/lnJuYp6uTVRlpbQ0dTZg5A13ZqWXbCVlffQNlsRMOD8Zu5a1hwyee0x9fAWQ
         Md8wBpeSbiAE+7FmiYg5ARsY5u4t30ZJKUhhEF9jU8Rx/bnsOVx6zj6LGJp32PiJkOLr
         hFipHJ4ElCnh+qNu/m0nIjPb84nySqdwvpUlYKadWn+OD3+lcbi9NUdFyGw5LK/dwGFC
         GlMTFAwR/SmHWFSepdcPzEE38jwDtBgtXyE8d1gOdJGj7icb/Pebzsay1ESdZS3tIm0t
         FOPQ==
X-Gm-Message-State: AOJu0Yw4PDAmugmSPH6UXoqqd7D3ULKMbeAIm0ej22iEJZ9+oWF6LDQu
	wnH3Bj6/0IOxQyAuzcWfubJZ
X-Google-Smtp-Source: AGHT+IFEMQjJsNYIZkSB99+BOaXRCBsfnPlUMzTbSBBFvef2hbEtIbbtDGpGNK2GaPuHjf8+nUzYBA==
X-Received: by 2002:a17:902:7c04:b0:1d3:5990:fd4a with SMTP id x4-20020a1709027c0400b001d35990fd4amr4925623pll.56.1703052247665;
        Tue, 19 Dec 2023 22:04:07 -0800 (PST)
Received: from thinkpad ([117.217.177.154])
        by smtp.gmail.com with ESMTPSA id r1-20020a170902be0100b001d38a7e6a30sm8879342pls.70.2023.12.19.22.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 22:04:07 -0800 (PST)
Date: Wed, 20 Dec 2023 11:33:57 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <Niklas.Cassel@wdc.com>, Frank Li <Frank.li@nxp.com>,
	Vidya Sagar <vidyas@nvidia.com>,
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
Message-ID: <20231220060357.GA3544@thinkpad>
References: <20220222162355.32369-1-Frank.Li@nxp.com>
 <20220222162355.32369-2-Frank.Li@nxp.com>
 <ZXsRp+Lzg3x/nhk3@x1-carbon>
 <ZXsc57whj/3e/+zq@lizhi-Precision-Tower-5810>
 <ZXtkMC1ZjsgHMRvT@x1-carbon>
 <ZXtrG40SR81YAR6a@lizhi-Precision-Tower-5810>
 <ZXtzjIIl5oabviZI@lizhi-Precision-Tower-5810>
 <ZX13xhBm3RmshqgD@x1-carbon>
 <20231219175900.GA24515@thinkpad>
 <c33b8830-5237-438f-9aae-6905e9e538b8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c33b8830-5237-438f-9aae-6905e9e538b8@kernel.org>

On Wed, Dec 20, 2023 at 02:14:53PM +0900, Damien Le Moal wrote:
> On 12/20/23 02:59, Manivannan Sadhasivam wrote:
> >>>>> from dw_pcie_ep_set_bar(), also needs to be dropped, so that the iATU
> >>>>> settings will be re-written for platforms with core_init_notifiers.
> >>>>>
> >>>>> Right now, for a platform with a core_init_notifier, if you run
> >>>>> pci_endpoint_test + reboot the RC (so that PERST is asserted + deasserted),
> >>>>> and then run pci_endpoint_test again, then I'm quite sure that
> >>>>> pci_endpoint_test will not pass the second time (because iATU settings
> >>>>> were not rewritten after reset).
> >>>>>
> >>>>> It would be nice if Mani or Vidya could confirm this.
> >>
> >> So problem 2 out of 2 introduced by the patch in $subject is that
> >> DWC drivers with a .core_init_notifier, will perform a reset_control_assert()
> >> to reset the core (which will reset both sticky and non-sticky registers),
> >> which means that the early return in dw_pcie_ep_set_bar():
> >> https://github.com/torvalds/linux/blob/v6.7-rc5/drivers/pci/controller/dwc/pcie-designware-ep.c#L268-L269
> >>
> >> while returning after the iATU settings have been written,
> >> it will return before:
> >>
> >> 	dw_pcie_writel_dbi2(pci, reg_dbi2, lower_32_bits(size - 1));
> >> 	dw_pcie_writel_dbi(pci, reg, flags);
> >>
> >> Which means that, for drivers with a .core_init_notifier, BARx_REG and
> >> BARx_MASK registers will not be written. This means that they will have
> >> reset values for these registers, which means that e.g. the BAR_SIZE
> >> (which is defined by BARx_MASK) might be incorrect for these platforms
> >> because this function returns early.
> >>
> >> I will not send a fix for this problem, I will leave that to you, or Mani,
> >> or Vidya, and hope that people are happy that I simply reported this issue.
> >>
> > 
> > The fix for this issue shouldn't be in the DWC driver but rather in the EPF
> > drivers. Because, EPF drivers are the ones calling pci_epc_set_bar() during
> > bind(). So they have to properly cleanup the resources once the perst assertion
> > happens. This issue also applies to other resources such as DMA channels.
> > 
> > The problem here is, there is a disconnect between DWC (EPC) and EPF drivers.
> > When the perst assertion happens, the event is not passed to EPF drivers
> > resulting in the EPF drivers having no knowledge that they need to give up the
> > resources.
> > 
> > We need to fix this in a sane way and I'm looking into it.
> > 
> > But I really appreciate your finding here and in other thread where we discussed
> > similar issue.
> 
> We have core_init and link_up notifiers for EPF drivers. Adding link_down and
> core_exit notifiers would make a lot of sense :) A core_reset notifier could
> also be a solution.
> 

Yeah, I'm thinking along those lines.

> Adding that would also help EPF drivers to handle links going down temporarily
> (which can happen). Right now, an EPF driver can only deal with such event by
> tracking if it gets multiple link_up events.
> 

There is already link_down notifier that I introduced a while back. But it is
only used by MHI_EPF driver.

- Mani

> 
> -- 
> Damien Le Moal
> Western Digital Research
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

