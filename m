Return-Path: <linux-pci+bounces-246-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 564677FDBF5
	for <lists+linux-pci@lfdr.de>; Wed, 29 Nov 2023 16:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1047A282757
	for <lists+linux-pci@lfdr.de>; Wed, 29 Nov 2023 15:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B738C3715B;
	Wed, 29 Nov 2023 15:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sSELOhAv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F2783
	for <linux-pci@vger.kernel.org>; Wed, 29 Nov 2023 07:51:47 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1ce28faa92dso53437585ad.2
        for <linux-pci@vger.kernel.org>; Wed, 29 Nov 2023 07:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701273107; x=1701877907; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jYTe4sDO3tSmN8zuRiGsHnnpKSxG01ZVPhEqI5BFFhw=;
        b=sSELOhAv5S8Wh80D098ERlmWIRiDcFFs4hiWMUsL6WoYEjBklEFMtxoxjglDh3dIPO
         OJpABY62PFW6PMYAoFalgubHCKVs50VydD79DmM6IkWKFZWdD0Dprjkne5tkXcXudYUz
         oO9ItDHLzhoiS3vmmW26v2EJGxECracnQzRrc/DZJwF8+IB1fqKXWF62xq72N5J0Upf6
         B5Gt92nDu2uXx+ee637tzixHFxW4QaYIy4QfSe+V9U0dpuDGOsqT9HYGXCZjQnHWHBw0
         r9miqdZ30dDniO74necph5TewGPYFpzmFWLik5tdIVHlGTCueXalgPBCl+b8NuHvIASC
         BAZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701273107; x=1701877907;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jYTe4sDO3tSmN8zuRiGsHnnpKSxG01ZVPhEqI5BFFhw=;
        b=whlS9hmrqoNxa+50eIJHU1ZhJqpSC/I/u62LEGNu/bxSu66KdYOm2KYsjy9YZLV9hM
         skyjRabfQGt5rxA9yPmDTMVrFjoiuTiyTYGqrDh9/ZnhX0t4atLMWIlBIe83Lgw/6Ztu
         xsoi+5mvQ7N1/Ld5Oz3emrK+3p6ntAlTaaPtZQoAzeDcwqg/+yj+uk18PcDttAUlTcBJ
         QuVwwekVM2AHCwlVUgMgcSszjfiV3ZSTcfOFOqE4ldUMEIl6xRXsZz77botQmbwVw0eS
         hGnsBYz4SWOTW3+MXrScsexBJmfCTl7FQjNTP5xOJ+LPTB90s/W75rYJESwCut9RHJbk
         1iFg==
X-Gm-Message-State: AOJu0YzJIjkQtX//keRBWUc/XK/ZNxMEmznxK54Z5IFMWmiyDkQbpMur
	mDdMntUa1f8tCbmGCkrr6bvW
X-Google-Smtp-Source: AGHT+IFHdlz4rEhuI1QD3GSvsLIbFT+AXIt2YFW4utgWWXc4aymSpAlhFhs0ewCO9E1BQjfxDum2NA==
X-Received: by 2002:a17:902:e552:b0:1cf:fe32:6319 with SMTP id n18-20020a170902e55200b001cffe326319mr5933972plf.53.1701273106605;
        Wed, 29 Nov 2023 07:51:46 -0800 (PST)
Received: from thinkpad ([59.92.100.237])
        by smtp.gmail.com with ESMTPSA id o16-20020a170902d4d000b001cfc2ec5de3sm7272324plg.24.2023.11.29.07.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 07:51:46 -0800 (PST)
Date: Wed, 29 Nov 2023 21:21:40 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Vidya Sagar <vidyas@nvidia.com>
Subject: Re: [PATCH v7 1/2] PCI: designware-ep: Fix DBI access before core
 init
Message-ID: <20231129155140.GC7621@thinkpad>
References: <20231120084014.108274-2-manivannan.sadhasivam@linaro.org>
 <ZWYmX8Y/7Q9WMxES@x1-carbon>
 <ZWcitTbK/wW4VY+K@x1-carbon>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZWcitTbK/wW4VY+K@x1-carbon>

On Wed, Nov 29, 2023 at 11:38:34AM +0000, Niklas Cassel wrote:
> On Tue, Nov 28, 2023 at 06:41:51PM +0100, Niklas Cassel wrote:
> > On Mon, Nov 20, 2023 at 02:10:13PM +0530, Manivannan Sadhasivam wrote:
> > > The drivers for platforms requiring reference clock from the PCIe host for
> > > initializing their PCIe EP core, make use of the 'core_init_notifier'
> > > feature exposed by the DWC common code. On these platforms, access to the
> > > hw registers like DBI before completing the core initialization will result
> > > in a whole system hang. But the current DWC EP driver tries to access DBI
> > > registers during dw_pcie_ep_init() without waiting for core initialization
> > > and it results in system hang on platforms making use of
> > > 'core_init_notifier' such as Tegra194 and Qcom SM8450.
> > > 
> > > To workaround this issue, users of the above mentioned platforms have to
> > > maintain the dependency with the PCIe host by booting the PCIe EP after
> > > host boot. But this won't provide a good user experience, since PCIe EP is
> > > _one_ of the features of those platforms and it doesn't make sense to
> > > delay the whole platform booting due to the PCIe dependency.
> > > 
> > > So to fix this issue, let's move all the DBI access during
> > > dw_pcie_ep_init() in the DWC EP driver to the dw_pcie_ep_init_complete()
> > > API that gets called only after core initialization on these platforms.
> > > This makes sure that the DBI register accesses are skipped during
> > > dw_pcie_ep_init() and accessed later once the core initialization happens.
> > > 
> > > For the rest of the platforms, DBI access happens as usual.
> > > 
> > > Co-developed-by: Vidya Sagar <vidyas@nvidia.com>
> > > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > ---
> > 
> > Hello Mani,
> > 
> > I tried this patch on top of a work in progress EP driver,
> > which, similar to pcie-qcom-ep.c has a perst gpio as input,
> > and a .core_init_notifier.
> > 
> > What I noticed is the following every time I reboot the RC, I get:
> > 
> > [  604.735115] debugfs: Directory 'a40000000.pcie_ep' with parent 'dmaengine' already present!
> > [ 1000.713582] debugfs: Directory 'a40000000.pcie_ep' with parent 'dmaengine' already present!
> > [ 1000.714355] debugfs: File 'mf' in directory '/' already present!
> > [ 1000.714890] debugfs: File 'wr_ch_cnt' in directory '/' already present!
> > [ 1000.715476] debugfs: File 'rd_ch_cnt' in directory '/' already present!
> > [ 1000.716061] debugfs: Directory 'registers' with parent '/' already present!
> > 
> > 
> > Also:
> > 
> > # ls -al /sys/class/dma/dma*/device | grep pcie
> > lrwxrwxrwx    1 root     root             0 Jan  1 00:14 /sys/class/dma/dma3chan0/device -> ../../../a40000000.pcie_ep
> > lrwxrwxrwx    1 root     root             0 Jan  1 00:14 /sys/class/dma/dma3chan1/device -> ../../../a40000000.pcie_ep
> > lrwxrwxrwx    1 root     root             0 Jan  1 00:14 /sys/class/dma/dma3chan2/device -> ../../../a40000000.pcie_ep
> > lrwxrwxrwx    1 root     root             0 Jan  1 00:14 /sys/class/dma/dma3chan3/device -> ../../../a40000000.pcie_ep
> > lrwxrwxrwx    1 root     root             0 Jan  1 00:14 /sys/class/dma/dma4chan0/device -> ../../../a40000000.pcie_ep
> > lrwxrwxrwx    1 root     root             0 Jan  1 00:14 /sys/class/dma/dma4chan1/device -> ../../../a40000000.pcie_ep
> > lrwxrwxrwx    1 root     root             0 Jan  1 00:14 /sys/class/dma/dma4chan2/device -> ../../../a40000000.pcie_ep
> > lrwxrwxrwx    1 root     root             0 Jan  1 00:14 /sys/class/dma/dma4chan3/device -> ../../../a40000000.pcie_ep
> > lrwxrwxrwx    1 root     root             0 Jan  1 00:16 /sys/class/dma/dma5chan0/device -> ../../../a40000000.pcie_ep
> > lrwxrwxrwx    1 root     root             0 Jan  1 00:16 /sys/class/dma/dma5chan1/device -> ../../../a40000000.pcie_ep
> > lrwxrwxrwx    1 root     root             0 Jan  1 00:16 /sys/class/dma/dma5chan2/device -> ../../../a40000000.pcie_ep
> > lrwxrwxrwx    1 root     root             0 Jan  1 00:16 /sys/class/dma/dma5chan3/device -> ../../../a40000000.pcie_ep
> > 
> > Adds another dmaX entry for each reboot.
> > 
> > 
> > I'm quite sure that you will see the same with pcie-qcom-ep.
> > 
> > I think that either the DWC drivers using core_init (only tegra and qcom)
> > need to deinit the eDMA in their assert_perst() function, or this patch
> > needs to deinit the eDMA before initializing it.
> > 
> > 
> > A problem with the current code, if you do NOT have this patch, which I assume
> > is also problem on pcie-qcom-ep, is that since assert_perst() function performs
> > a core reset, all the eDMA setting written in the dbi by the eDMA driver will be
> > cleared, so a PERST assert + deassert by the RC will wipe the eDMA settings.
> > Hopefully, this will no longer be a problem after this patch has been merged.
> > 
> > 
> > Kind regards,
> > Niklas
> 
> I'm sorry that I'm just looking at this patch now (it's v7 already).
> But I did notice that the DWC code is inconsistent for drivers having
> a .core_init_notifier and drivers not having a .core_init_notifier.
> 
> When receiving a hot reset or link-down reset, the DWC core gets reset,
> which means that most DBI settings get reset to their reset value.
> 

I believe you are talking about the hardware here and not the DWC core driver.

> 
> Both tegra and qcom-ep does have a start_link() that is basically a no-op.

That's because of the fact that we cannot write to LTSSM registers before perst
deassert.

> Instead, ep_init_complete() (and LTSSM enable) is called when PERST is
> deasserted, so settings written by ep_init_complete() will always get set
> after PERST is asserted + deasserted.
> 
> However, for a driver without a .core_init_notifier, a pci-epf-test unbind
> + bind, will currently NOT write the DBI settings written by
> ep_init_complete() when starting the link the second time.
> 
> If you unbind + bind pci-epf-test (which requires stopping and starting the
> link), I think that you should write all the DBI settings. Unbinding + binding
> will allocate memory for all the BARs, write all the iATU settings etc.
> It doesn't make sense that some DBI writes (those made by ep_init_complete())
> are not redone.
> 
> The problem is that if you do not have a .core_init_notifier,
> ep_init_complete() (which does DBI writes) is only called by ep_init(),
> and never ever again.
> 

Hmm, right. I did not look close into non-core_init_notifier platforms because
of the lack of hardware.

> 
> Considering that .start_link() is a no-op for DWC drivers with a
> .core_init_notifier (they instead call ep_init_complete() when perst is
> deasserted), I think the most logical thing would be for .start_link() to
> call ep_init_complete() (for drivers without a .core_init_notifier), that way,
> all DBI settings (and not just some) will be written on an unbind + bind.
> 
> 
> Something like this:
> 
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -465,6 +465,16 @@ static int dw_pcie_ep_start(struct pci_epc *epc)
>  {
>         struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>         struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +       const struct pci_epc_features *epc_features;
> +
> +       if (ep->ops->get_features) {
> +               epc_features = ep->ops->get_features(ep);
> +               if (!epc_features->core_init_notifier) {
> +                       ret = dw_pcie_ep_init_complete(ep);
> +                       if (ret)
> +                               return ret;
> +               }
> +       }
>  
>         return dw_pcie_start_link(pci);
>  }
> @@ -729,7 +739,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>         struct device *dev = pci->dev;
>         struct platform_device *pdev = to_platform_device(dev);
>         struct device_node *np = dev->of_node;
> -       const struct pci_epc_features *epc_features;
>         struct dw_pcie_ep_func *ep_func;
>  
>         INIT_LIST_HEAD(&ep->func_list);
> @@ -817,16 +826,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>         if (ret)
>                 goto err_free_epc_mem;
>  
> -       if (ep->ops->get_features) {
> -               epc_features = ep->ops->get_features(ep);
> -               if (epc_features->core_init_notifier)
> -                       return 0;
> -       }
> -
> -       ret = dw_pcie_ep_init_complete(ep);
> -       if (ret)
> -               goto err_remove_edma;
> -
>         return 0;
>  
>  err_remove_edma:
> 
> 
> I could send a patch, but it would be conflicting with your patch.
> And you also need to handle deiniting + initing the eDMA in a nice way,
> but that seems to be a problem that also needs to be addressed with the
> patch in $subject.
> 
> What do you think?
> 

Your proposed solution looks good to me. If you are OK, I can spin up a patch on
behalf of you (with your authorship ofc) and integrate it with this series.

Let me know!

- Mani

> 
> Kind regards,
> Niklas

-- 
மணிவண்ணன் சதாசிவம்

