Return-Path: <linux-pci+bounces-267-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3907FE93C
	for <lists+linux-pci@lfdr.de>; Thu, 30 Nov 2023 07:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E994B20C9D
	for <lists+linux-pci@lfdr.de>; Thu, 30 Nov 2023 06:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DB45CBE;
	Thu, 30 Nov 2023 06:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sf9f0Rfd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177D010D1
	for <linux-pci@vger.kernel.org>; Wed, 29 Nov 2023 22:38:06 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6cb55001124so1398512b3a.0
        for <linux-pci@vger.kernel.org>; Wed, 29 Nov 2023 22:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701326285; x=1701931085; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wB2suDQUxj370zm29/Om6hbD3PtwMfkiVhj+43MzNf8=;
        b=Sf9f0RfdCN0fw2s2O9zydipHOBnItt+Orqvm6CUHRVXKCLbHf806ruhGA38mxhLHPa
         0r/mfj4QU4WY731rPdTPAAJ2UHFJUkIvmiVzQVuyCUv6qT9P1ijxXInI/lEpGevNDTwV
         fnkqVAZloUzglSx1jU5wJ7qAa0ZaZn0icD5vcRhYcycHa5Y+HxEQvbS4f5/6KQpm9rzY
         DF+WJdj+ndGegCyh+OQLpcAy86jFJ8AduFpiagrBrUaK+ZPaODZomeo3dj7raosqzru8
         rXPy4dZL/9/AAtgOnwJZIc7t7QeKqU7igdi+sBzwmXpTeUqNGmCsXDeargq/Bl+frB3f
         3jAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701326285; x=1701931085;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wB2suDQUxj370zm29/Om6hbD3PtwMfkiVhj+43MzNf8=;
        b=eGacUu6BLmPJJxE8CKRJXiAMyuhuV55/VbMn5fQNkFdMoFu6lHexAq03JaIktTQ5qs
         kgcH8ALJptCdIVyJNsHFom+ywGosyQtR0hU8xmoNQsHAY7skflRN0CS6re2z+RBwbq6/
         k66wBIUTcOxrELWYm+cUPC1vZywqZd6D0DmV7XgcG88tA8rpipfZAGxgxOlGY6zjE2M0
         HADohlqZjMfzBJRCopFJtJDeAtW+LfWr4o8oQXGFH22zObUxxksmyEUFspyvOUaXaIw7
         0P3xxowhJxVqxAo0A0eelZnstWJP8y0j26Z9QDhflq6EeO5rFnPuUCd7q6jsokrckZzX
         gU9Q==
X-Gm-Message-State: AOJu0Yy8/vx+/Yb6Y8OBONmZ++YlQZjN1rfwWpBJxDbcDTpRWAJblEyj
	WVaKnZTe3yVAHuVCrLlqIEie
X-Google-Smtp-Source: AGHT+IG8AdwymsSRgoMv5EsLGSRYEvZGT6ADCj19D0n/BxQqrgyRva2D6A83E6PjFyw80UlGOpORdg==
X-Received: by 2002:a05:6a20:42a1:b0:18b:826d:1e89 with SMTP id o33-20020a056a2042a100b0018b826d1e89mr25783292pzj.12.1701326285365;
        Wed, 29 Nov 2023 22:38:05 -0800 (PST)
Received: from thinkpad ([59.92.100.237])
        by smtp.gmail.com with ESMTPSA id g1-20020a62e301000000b006c4d86a259csm451735pfh.28.2023.11.29.22.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 22:38:04 -0800 (PST)
Date: Thu, 30 Nov 2023 12:08:00 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Vidya Sagar <vidyas@nvidia.com>
Subject: Re: [PATCH v7 1/2] PCI: designware-ep: Fix DBI access before core
 init
Message-ID: <20231130063800.GD3043@thinkpad>
References: <20231120084014.108274-2-manivannan.sadhasivam@linaro.org>
 <ZWYmX8Y/7Q9WMxES@x1-carbon>
 <ZWcitTbK/wW4VY+K@x1-carbon>
 <20231129155140.GC7621@thinkpad>
 <ZWdob6tgWf6919/s@x1-carbon>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZWdob6tgWf6919/s@x1-carbon>

On Wed, Nov 29, 2023 at 04:36:04PM +0000, Niklas Cassel wrote:
> On Wed, Nov 29, 2023 at 09:21:40PM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Nov 29, 2023 at 11:38:34AM +0000, Niklas Cassel wrote:
> > > On Tue, Nov 28, 2023 at 06:41:51PM +0100, Niklas Cassel wrote:
> > > > On Mon, Nov 20, 2023 at 02:10:13PM +0530, Manivannan Sadhasivam wrote:
> > > > > The drivers for platforms requiring reference clock from the PCIe host for
> > > > > initializing their PCIe EP core, make use of the 'core_init_notifier'
> > > > > feature exposed by the DWC common code. On these platforms, access to the
> > > > > hw registers like DBI before completing the core initialization will result
> > > > > in a whole system hang. But the current DWC EP driver tries to access DBI
> > > > > registers during dw_pcie_ep_init() without waiting for core initialization
> > > > > and it results in system hang on platforms making use of
> > > > > 'core_init_notifier' such as Tegra194 and Qcom SM8450.
> > > > > 
> > > > > To workaround this issue, users of the above mentioned platforms have to
> > > > > maintain the dependency with the PCIe host by booting the PCIe EP after
> > > > > host boot. But this won't provide a good user experience, since PCIe EP is
> > > > > _one_ of the features of those platforms and it doesn't make sense to
> > > > > delay the whole platform booting due to the PCIe dependency.
> > > > > 
> > > > > So to fix this issue, let's move all the DBI access during
> > > > > dw_pcie_ep_init() in the DWC EP driver to the dw_pcie_ep_init_complete()
> > > > > API that gets called only after core initialization on these platforms.
> > > > > This makes sure that the DBI register accesses are skipped during
> > > > > dw_pcie_ep_init() and accessed later once the core initialization happens.
> > > > > 
> > > > > For the rest of the platforms, DBI access happens as usual.
> > > > > 
> > > > > Co-developed-by: Vidya Sagar <vidyas@nvidia.com>
> > > > > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > > ---
> > > > 
> > > > Hello Mani,
> > > > 
> > > > I tried this patch on top of a work in progress EP driver,
> > > > which, similar to pcie-qcom-ep.c has a perst gpio as input,
> > > > and a .core_init_notifier.
> > > > 
> > > > What I noticed is the following every time I reboot the RC, I get:
> > > > 
> > > > [  604.735115] debugfs: Directory 'a40000000.pcie_ep' with parent 'dmaengine' already present!
> > > > [ 1000.713582] debugfs: Directory 'a40000000.pcie_ep' with parent 'dmaengine' already present!
> > > > [ 1000.714355] debugfs: File 'mf' in directory '/' already present!
> > > > [ 1000.714890] debugfs: File 'wr_ch_cnt' in directory '/' already present!
> > > > [ 1000.715476] debugfs: File 'rd_ch_cnt' in directory '/' already present!
> > > > [ 1000.716061] debugfs: Directory 'registers' with parent '/' already present!
> > > > 
> > > > 
> > > > Also:
> > > > 
> > > > # ls -al /sys/class/dma/dma*/device | grep pcie
> > > > lrwxrwxrwx    1 root     root             0 Jan  1 00:14 /sys/class/dma/dma3chan0/device -> ../../../a40000000.pcie_ep
> > > > lrwxrwxrwx    1 root     root             0 Jan  1 00:14 /sys/class/dma/dma3chan1/device -> ../../../a40000000.pcie_ep
> > > > lrwxrwxrwx    1 root     root             0 Jan  1 00:14 /sys/class/dma/dma3chan2/device -> ../../../a40000000.pcie_ep
> > > > lrwxrwxrwx    1 root     root             0 Jan  1 00:14 /sys/class/dma/dma3chan3/device -> ../../../a40000000.pcie_ep
> > > > lrwxrwxrwx    1 root     root             0 Jan  1 00:14 /sys/class/dma/dma4chan0/device -> ../../../a40000000.pcie_ep
> > > > lrwxrwxrwx    1 root     root             0 Jan  1 00:14 /sys/class/dma/dma4chan1/device -> ../../../a40000000.pcie_ep
> > > > lrwxrwxrwx    1 root     root             0 Jan  1 00:14 /sys/class/dma/dma4chan2/device -> ../../../a40000000.pcie_ep
> > > > lrwxrwxrwx    1 root     root             0 Jan  1 00:14 /sys/class/dma/dma4chan3/device -> ../../../a40000000.pcie_ep
> > > > lrwxrwxrwx    1 root     root             0 Jan  1 00:16 /sys/class/dma/dma5chan0/device -> ../../../a40000000.pcie_ep
> > > > lrwxrwxrwx    1 root     root             0 Jan  1 00:16 /sys/class/dma/dma5chan1/device -> ../../../a40000000.pcie_ep
> > > > lrwxrwxrwx    1 root     root             0 Jan  1 00:16 /sys/class/dma/dma5chan2/device -> ../../../a40000000.pcie_ep
> > > > lrwxrwxrwx    1 root     root             0 Jan  1 00:16 /sys/class/dma/dma5chan3/device -> ../../../a40000000.pcie_ep
> > > > 
> > > > Adds another dmaX entry for each reboot.
> > > > 
> > > > 
> > > > I'm quite sure that you will see the same with pcie-qcom-ep.
> > > > 
> > > > I think that either the DWC drivers using core_init (only tegra and qcom)
> > > > need to deinit the eDMA in their assert_perst() function, or this patch
> > > > needs to deinit the eDMA before initializing it.
> > > > 
> > > > 
> > > > A problem with the current code, if you do NOT have this patch, which I assume
> > > > is also problem on pcie-qcom-ep, is that since assert_perst() function performs
> > > > a core reset, all the eDMA setting written in the dbi by the eDMA driver will be
> > > > cleared, so a PERST assert + deassert by the RC will wipe the eDMA settings.
> > > > Hopefully, this will no longer be a problem after this patch has been merged.
> > > > 
> > > > 
> > > > Kind regards,
> > > > Niklas
> > > 
> > > I'm sorry that I'm just looking at this patch now (it's v7 already).
> > > But I did notice that the DWC code is inconsistent for drivers having
> > > a .core_init_notifier and drivers not having a .core_init_notifier.
> > > 
> > > When receiving a hot reset or link-down reset, the DWC core gets reset,
> > > which means that most DBI settings get reset to their reset value.
> > > 
> > 
> > I believe you are talking about the hardware here and not the DWC core driver.
> > 
> > > 
> > > Both tegra and qcom-ep does have a start_link() that is basically a no-op.
> > 
> > That's because of the fact that we cannot write to LTSSM registers before perst
> > deassert.
> > 
> > > Instead, ep_init_complete() (and LTSSM enable) is called when PERST is
> > > deasserted, so settings written by ep_init_complete() will always get set
> > > after PERST is asserted + deasserted.
> > > 
> > > However, for a driver without a .core_init_notifier, a pci-epf-test unbind
> > > + bind, will currently NOT write the DBI settings written by
> > > ep_init_complete() when starting the link the second time.
> > > 
> > > If you unbind + bind pci-epf-test (which requires stopping and starting the
> > > link), I think that you should write all the DBI settings. Unbinding + binding
> > > will allocate memory for all the BARs, write all the iATU settings etc.
> > > It doesn't make sense that some DBI writes (those made by ep_init_complete())
> > > are not redone.
> > > 

Looking at this issue again, I think your statement may not be correct. In the
stop_link() callback, non-core_init_notifier platforms are just disabling the
LTSSM and enabling it again in start_link(). So all the rest of the
configurations (DBI etc...) should not be affected during EPF bind/unbind.

Can you point me to the specific controller driver that is doing otherwise?

- Mani

> > > The problem is that if you do not have a .core_init_notifier,
> > > ep_init_complete() (which does DBI writes) is only called by ep_init(),
> > > and never ever again.
> > > 
> > 
> > Hmm, right. I did not look close into non-core_init_notifier platforms because
> > of the lack of hardware.
> > 
> > > 
> > > Considering that .start_link() is a no-op for DWC drivers with a
> > > .core_init_notifier (they instead call ep_init_complete() when perst is
> > > deasserted), I think the most logical thing would be for .start_link() to
> > > call ep_init_complete() (for drivers without a .core_init_notifier), that way,
> > > all DBI settings (and not just some) will be written on an unbind + bind.
> > > 
> > > 
> > > Something like this:
> > > 
> > > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > @@ -465,6 +465,16 @@ static int dw_pcie_ep_start(struct pci_epc *epc)
> > >  {
> > >         struct dw_pcie_ep *ep = epc_get_drvdata(epc);
> > >         struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > > +       const struct pci_epc_features *epc_features;
> > > +
> > > +       if (ep->ops->get_features) {
> > > +               epc_features = ep->ops->get_features(ep);
> > > +               if (!epc_features->core_init_notifier) {
> > > +                       ret = dw_pcie_ep_init_complete(ep);
> > > +                       if (ret)
> > > +                               return ret;
> > > +               }
> > > +       }
> > >  
> > >         return dw_pcie_start_link(pci);
> > >  }
> > > @@ -729,7 +739,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> > >         struct device *dev = pci->dev;
> > >         struct platform_device *pdev = to_platform_device(dev);
> > >         struct device_node *np = dev->of_node;
> > > -       const struct pci_epc_features *epc_features;
> > >         struct dw_pcie_ep_func *ep_func;
> > >  
> > >         INIT_LIST_HEAD(&ep->func_list);
> > > @@ -817,16 +826,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> > >         if (ret)
> > >                 goto err_free_epc_mem;
> > >  
> > > -       if (ep->ops->get_features) {
> > > -               epc_features = ep->ops->get_features(ep);
> > > -               if (epc_features->core_init_notifier)
> > > -                       return 0;
> > > -       }
> > > -
> > > -       ret = dw_pcie_ep_init_complete(ep);
> > > -       if (ret)
> > > -               goto err_remove_edma;
> > > -
> > >         return 0;
> > >  
> > >  err_remove_edma:
> > > 
> > > 
> > > I could send a patch, but it would be conflicting with your patch.
> > > And you also need to handle deiniting + initing the eDMA in a nice way,
> > > but that seems to be a problem that also needs to be addressed with the
> > > patch in $subject.
> > > 
> > > What do you think?
> > > 
> > 
> > Your proposed solution looks good to me. If you are OK, I can spin up a patch on
> > behalf of you (with your authorship ofc) and integrate it with this series.
> 
> Sounds good to me!
> 
> Since you will need to also fix the error paths (my suggestion didn't)),
> I think that you deserve the authorship if you cook up a patch.
> 
> It would be nice to hear Vidya's opinion on my suggestion as well, since he
> appears to be the one who added the .core_init_notifier in the first place.
> 
> 
> Kind regards,
> Niklas

-- 
மணிவண்ணன் சதாசிவம்

