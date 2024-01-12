Return-Path: <linux-pci+bounces-2093-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBD782BDFF
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 11:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23687B223E9
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 10:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867DA57301;
	Fri, 12 Jan 2024 10:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OpOcctWq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C355D729
	for <linux-pci@vger.kernel.org>; Fri, 12 Jan 2024 10:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-28bc7155755so3378104a91.2
        for <linux-pci@vger.kernel.org>; Fri, 12 Jan 2024 02:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705053624; x=1705658424; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dRYoalgnwKVYfdSiaBfDRevKcT4wc2GOJqsALypTOmU=;
        b=OpOcctWqWBe3ajchwYGTl3RxOwVKYQiBfBqLvQPnN9D8/8aHpnJz3q8CFxEqBfsUz5
         JCacvo4unw0zaCQBdj4M6F5i5WoCuGpCHuOYKV7nE+rvVqchOgHOsECliAMxK3y51HLF
         rzi2gvAQUP7nPGrQ9WApRk9fws2Q2gJarzBju1s7MBOYwc9VHLYA7fkVglDsvqCeeFiE
         HMZv7RO/ch4OuvWpErEJumEsS1cnaCnNgBIOKwgGGRrYTpMJX1G+kmIsRzVirT88jPKj
         A+6UBi8td/SRVZ17mRI3eMvlyjP5TqYKFmvFKPuFutppLVyrVbJiu7TXitHS5rFPrKyL
         6Y8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705053624; x=1705658424;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dRYoalgnwKVYfdSiaBfDRevKcT4wc2GOJqsALypTOmU=;
        b=xA8+A8fByT4xU9IffebJFzsl1HpvXDM2NvALysbyCp9OG6BoUA7z9BxHqFpQLGxL6c
         R16LgEH9yjyLMlsVfH4nisKB8/5Grab3ub1ke6og1sHbTi9rk9BtcZoI0ZZ+bBTi03tb
         j6j7vsCP6uWWpD5SzwC7f5oqJowRtmtr3VBGS5Nr5VM0ciEX6clB+2lImcHJiRueznyp
         0xO9FieNjsEDnWyw9nRzxEjXJML1+D27zEDxHV89gsmB7b87XwQINEk5nIoCiWNZI4iN
         GbuO5LMBGx2x1THD5DpJ0RFk+KyD8mn1VmJINzo2TM+9ynmSl/uma9lP4qxT9FsPRwHS
         QZNw==
X-Gm-Message-State: AOJu0YwtHE+jS90hLsdI8BoXGQMgoTss9cRFS7nnUGOYq6PsHQ+aBPXe
	yZHu0Mx7yhoedOwgMnewxKLxoifqXSsMtVkl385R7sk3i35CkL4=
X-Google-Smtp-Source: AGHT+IGVBuc/bzfWDGIQZBxbBGBGgbQ8hy2U6+QesiLzQrB5AGxj9ilSJ5pZ8u646RBth+dnJjW/eA==
X-Received: by 2002:a17:90a:898b:b0:28d:2b9d:e273 with SMTP id v11-20020a17090a898b00b0028d2b9de273mr917862pjn.74.1705053624143;
        Fri, 12 Jan 2024 02:00:24 -0800 (PST)
Received: from google.com (108.93.126.34.bc.googleusercontent.com. [34.126.93.108])
        by smtp.gmail.com with ESMTPSA id px12-20020a17090b270c00b0028e17b2f27esm58229pjb.13.2024.01.12.02.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 02:00:23 -0800 (PST)
Date: Fri, 12 Jan 2024 15:30:15 +0530
From: Ajay Agarwal <ajayagarwal@google.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Johan Hovold <johan@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Sajid Dalvi <sdalvi@google.com>
Subject: Re: [PATCH] Revert "PCI: dwc: Wait for link up only if link is
 started"
Message-ID: <ZaENr7jQ35winQAe@google.com>
References: <20230706082610.26584-1-johan+linaro@kernel.org>
 <20230706125811.GD4808@thinkpad>
 <ZKgJfG5Mi-e77LQT@hovoldconsulting.com>
 <ZKwwAin4FcCETGq/@google.com>
 <20230711073719.GA36617@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230711073719.GA36617@thinkpad>

On Tue, Jul 11, 2023 at 01:07:19PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Jul 10, 2023 at 09:51:22PM +0530, Ajay Agarwal wrote:
> > On Fri, Jul 07, 2023 at 02:47:56PM +0200, Johan Hovold wrote:
> > > On Thu, Jul 06, 2023 at 06:28:11PM +0530, Manivannan Sadhasivam wrote:
> > > > On Thu, Jul 06, 2023 at 10:26:10AM +0200, Johan Hovold wrote:
> > > 
> > > > > Finally, note that the intel-gw driver is the only driver currently not
> > > > > providing a start_link callback and instead starts the link in its
> > > > > host_init callback, and which may avoid an additional one-second timeout
> > > > > during probe by making the link-up wait conditional. If anyone cares,
> > > > > that can be done in a follow-up patch with a proper motivation.
> > > 
> > > > The offending commit is bogus since it makes the intel-gw _special_ w.r.t
> > > > waiting for the link up. Most of the drivers call dw_pcie_host_init() during the
> > > > probe time and they all have to wait for 1 sec if the slot is empty.
> > Mani, can you please explain how my commit made the intel-gw driver
> > special? The intel driver actually fails the dw_pcie_host_init if the
> > link does not come up. That was my motivation behind adding the fail
> > logic in the core driver as well.
> 
> Your commit ended up failing the probe, if dw_pcie_wait_for_link() fails for
> SoCs defining start_link() callback, which is the case for all the drivers
> except intel-gw. I take back my _special_ argument since it was special before
> your commit and now you just made its behavior applicable to all SoCs.
>
You are right. I should not have returned an error from the
dw_pcie_wait_for_link check. Raised v5 with the error return removed:
https://lore.kernel.org/all/20240112093006.2832105-1-ajayagarwal@google.com/

> > > 
> > > Just to clarify, the intel-gw driver starts the link and waits for link
> > > up in its host_init() callback, which is called during probe. That wait
> > > could possibly just be dropped in favour of the one in
> > > dw_pcie_host_init() and/or the driver could be reworked to implement
> > > start_link().
> > > 
> > > Either way, the call in dw_pcie_host_init() will only add an additional
> > > 1 second delay in cases where the link did *not* come up.
> > > 
> > > > As Johan noted, intel-gw should make use of the async probe to avoid the boot
> > > > delay instead of adding a special case.
> > > 
> > > Indeed.
> > > 
> > > Johan
> > Johan, Mani
> > My apologies for adding this regression in some of the SOCs.
> > May I suggest to keep my patch and make the following change instead?
> > This shall keep the existing behavior as is, and save the boot time
> > for drivers that do not define the start_link()?
> > 
> 
> No, IMO the offending commit was wrong in serving its purpose so a revert makes
> sense. Because, if the intention was to reduce the boot delay then it did not
> fix that because dw_pcie_wait_for_link() is still called from intel-gw's
> host_init() callback. You just skipped another instance which is there in
> dw_pcie_host_init().
> 
> So to fix this issue properly intel-gw needs to do 2 things:
> 
> 1. Move the ltssm_enable to start_link() callback and get rid of
> dw_pcie_wait_for_link() from its host_init() callback. If there is any special
> reason to not do this way, please explain.
> 
> 2. Enable async probe so that other drivers can continue probing while this
> driver waits for the link to be up. This will almost make the delay negligible.
> 
> The above 2 should be done in separate patches.
> 
> - Mani
>
Mani, the intention is not to fix the intel-gw driver in any manner. It
calls dw_pcie_wait_for_link explicitly in the probe path and checks for
the error as well. So it has to live with the delay and the probe
failure if the link does not come up.

My intention is just to get rid of the 1 sec delay for the drivers that
do not define the start_link callback, and hence do not expect that the
link will come up during probe anyway.

> > ```
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index cf61733bf78d..af6a7cd060b1 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -492,11 +492,8 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
> >                 if (ret)
> >                         goto err_remove_edma;
> > 
> > -               if (pci->ops && pci->ops->start_link) {
> > -                       ret = dw_pcie_wait_for_link(pci);
> > -                       if (ret)
> > -                               goto err_stop_link;
> > -               }
> > +               if (pci->ops && pci->ops->start_link)
> > +                       dw_pcie_wait_for_link(pci);
> >         }
> > 
> >         bridge->sysdata = pp;
> > ```
> 
> -- 
> மணிவண்ணன் சதாசிவம்

