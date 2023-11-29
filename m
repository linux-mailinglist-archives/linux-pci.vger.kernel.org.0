Return-Path: <linux-pci+bounces-244-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E13B7FD8F4
	for <lists+linux-pci@lfdr.de>; Wed, 29 Nov 2023 15:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD8652824B8
	for <lists+linux-pci@lfdr.de>; Wed, 29 Nov 2023 14:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C82225D9;
	Wed, 29 Nov 2023 14:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oYfUqx82"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD45FCE
	for <linux-pci@vger.kernel.org>; Wed, 29 Nov 2023 06:08:09 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6c320a821c4so5897368b3a.2
        for <linux-pci@vger.kernel.org>; Wed, 29 Nov 2023 06:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701266889; x=1701871689; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xqhIKIAAkgzS+01MpQb+4NjWytY/8qrLTb5XTN87Jt0=;
        b=oYfUqx82sqyJmGBocxTmAItIFbYmZiXDIkQj+63qbRLQaHO8xxsG69FKfJOnLIxzpN
         emoLpZy66Td/vHgvToh76uBzkW75fEyNnxM6QxhB1/VUEIBel0DvbEuIT/rimfuS0FID
         SG/jOuTk8LyHs8LuI7lgfdi41KqufyApUFtIUGfAQyjd46UhOddXcv5WXcfovbOTmHng
         bs01OdAYoKa0tRr2gON5QSvn0Alp+YMMsTWqXF2N88O/6t4X4j9B2qp+Ougkh8hymO1y
         Mfzc+sx43Cz78lt2TnN9walkh+cS/Yb76G+EbjCk/i5E2VUGcZvS8/230PvROj+s3sXF
         4PiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701266889; x=1701871689;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xqhIKIAAkgzS+01MpQb+4NjWytY/8qrLTb5XTN87Jt0=;
        b=iL0YYo5sJyg8FbKwXDpTrOBPjrEAgaYzG7zjXgyFkjKVISVLlH9lpmEqgystz8CsJ2
         Fg2lwA8IQzpVt9db2mE7oLH1KMAYGSbdxLYcZklCYkhNfkx2ycGW4TdKiKist9puS3Ik
         30M7H10QsekZFTE7xYGdzdT9LImbe5o6uRbQJepCNUlXjw+rlQ0wrdSlRXqJjEpDjr0j
         4oEtYNyFR0WZfZs1liky9YQw98qcDpZzJua65YwfcGZs8jQ0/RM5kVtilxSSsM0hrd/X
         I92/mXcSUwrZmBy3nHoP0DF6mi7gdN2m8eScCEGlBbylsPen5kNh6Au8tqq3h4eWiJxf
         D16w==
X-Gm-Message-State: AOJu0Yygv4EDvCrKDOoF2d3y5DWbmzN3zCYK79mqPMNYPD2Z/rc1itKG
	Mz0Ip10/3uRer9+jRk16+i1FFe+XJiPpD/jpeA==
X-Google-Smtp-Source: AGHT+IGs1uRX8liE8+y+XLOOyiNVexvvdtOzdKQYHNDaN6sIoGWkQXkDJ0+H7sbE4itsi9971IO/bw==
X-Received: by 2002:a05:6a00:3a0b:b0:6cb:8dba:ce6c with SMTP id fj11-20020a056a003a0b00b006cb8dbace6cmr18966045pfb.18.1701266889086;
        Wed, 29 Nov 2023 06:08:09 -0800 (PST)
Received: from thinkpad ([117.207.26.69])
        by smtp.gmail.com with ESMTPSA id i19-20020aa787d3000000b006cdce7c69d9sm1532304pfo.91.2023.11.29.06.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 06:08:08 -0800 (PST)
Date: Wed, 29 Nov 2023 19:38:03 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v7 1/2] PCI: designware-ep: Fix DBI access before core
 init
Message-ID: <20231129140803.GB7621@thinkpad>
References: <20231120084014.108274-2-manivannan.sadhasivam@linaro.org>
 <ZWYmX8Y/7Q9WMxES@x1-carbon>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZWYmX8Y/7Q9WMxES@x1-carbon>

Hi Niklas,

On Tue, Nov 28, 2023 at 05:41:52PM +0000, Niklas Cassel wrote:
> On Mon, Nov 20, 2023 at 02:10:13PM +0530, Manivannan Sadhasivam wrote:
> > The drivers for platforms requiring reference clock from the PCIe host for
> > initializing their PCIe EP core, make use of the 'core_init_notifier'
> > feature exposed by the DWC common code. On these platforms, access to the
> > hw registers like DBI before completing the core initialization will result
> > in a whole system hang. But the current DWC EP driver tries to access DBI
> > registers during dw_pcie_ep_init() without waiting for core initialization
> > and it results in system hang on platforms making use of
> > 'core_init_notifier' such as Tegra194 and Qcom SM8450.
> > 
> > To workaround this issue, users of the above mentioned platforms have to
> > maintain the dependency with the PCIe host by booting the PCIe EP after
> > host boot. But this won't provide a good user experience, since PCIe EP is
> > _one_ of the features of those platforms and it doesn't make sense to
> > delay the whole platform booting due to the PCIe dependency.
> > 
> > So to fix this issue, let's move all the DBI access during
> > dw_pcie_ep_init() in the DWC EP driver to the dw_pcie_ep_init_complete()
> > API that gets called only after core initialization on these platforms.
> > This makes sure that the DBI register accesses are skipped during
> > dw_pcie_ep_init() and accessed later once the core initialization happens.
> > 
> > For the rest of the platforms, DBI access happens as usual.
> > 
> > Co-developed-by: Vidya Sagar <vidyas@nvidia.com>
> > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> 
> Hello Mani,
> 
> I tried this patch on top of a work in progress EP driver,
> which, similar to pcie-qcom-ep.c has a perst gpio as input,
> and a .core_init_notifier.
> 
> What I noticed is the following every time I reboot the RC, I get:
> 
> [  604.735115] debugfs: Directory 'a40000000.pcie_ep' with parent 'dmaengine' already present!
> [ 1000.713582] debugfs: Directory 'a40000000.pcie_ep' with parent 'dmaengine' already present!
> [ 1000.714355] debugfs: File 'mf' in directory '/' already present!
> [ 1000.714890] debugfs: File 'wr_ch_cnt' in directory '/' already present!
> [ 1000.715476] debugfs: File 'rd_ch_cnt' in directory '/' already present!
> [ 1000.716061] debugfs: Directory 'registers' with parent '/' already present!
> 
> 
> Also:
> 
> # ls -al /sys/class/dma/dma*/device | grep pcie
> lrwxrwxrwx    1 root     root             0 Jan  1 00:14 /sys/class/dma/dma3chan0/device -> ../../../a40000000.pcie_ep
> lrwxrwxrwx    1 root     root             0 Jan  1 00:14 /sys/class/dma/dma3chan1/device -> ../../../a40000000.pcie_ep
> lrwxrwxrwx    1 root     root             0 Jan  1 00:14 /sys/class/dma/dma3chan2/device -> ../../../a40000000.pcie_ep
> lrwxrwxrwx    1 root     root             0 Jan  1 00:14 /sys/class/dma/dma3chan3/device -> ../../../a40000000.pcie_ep
> lrwxrwxrwx    1 root     root             0 Jan  1 00:14 /sys/class/dma/dma4chan0/device -> ../../../a40000000.pcie_ep
> lrwxrwxrwx    1 root     root             0 Jan  1 00:14 /sys/class/dma/dma4chan1/device -> ../../../a40000000.pcie_ep
> lrwxrwxrwx    1 root     root             0 Jan  1 00:14 /sys/class/dma/dma4chan2/device -> ../../../a40000000.pcie_ep
> lrwxrwxrwx    1 root     root             0 Jan  1 00:14 /sys/class/dma/dma4chan3/device -> ../../../a40000000.pcie_ep
> lrwxrwxrwx    1 root     root             0 Jan  1 00:16 /sys/class/dma/dma5chan0/device -> ../../../a40000000.pcie_ep
> lrwxrwxrwx    1 root     root             0 Jan  1 00:16 /sys/class/dma/dma5chan1/device -> ../../../a40000000.pcie_ep
> lrwxrwxrwx    1 root     root             0 Jan  1 00:16 /sys/class/dma/dma5chan2/device -> ../../../a40000000.pcie_ep
> lrwxrwxrwx    1 root     root             0 Jan  1 00:16 /sys/class/dma/dma5chan3/device -> ../../../a40000000.pcie_ep
> 
> Adds another dmaX entry for each reboot.
> 
> 
> I'm quite sure that you will see the same with pcie-qcom-ep.
> 

Yes, you are right. I'm aware of this issue but don't have a handy solution atm.

> I think that either the DWC drivers using core_init (only tegra and qcom)
> need to deinit the eDMA in their assert_perst() function, or this patch
> needs to deinit the eDMA before initializing it.
> 

The problem with first option is that it is too late. The moment EP gets perst
assert IRQ, refclk will be cut off by the host. So if EP tries to access any
hardware registers (edma_core_off) it will result in hard reboot.

The second option is not a complete solution, because the EPF drivers still need
to release the DMA channels and that can only happen if the EPF drivers know
that the host is going into power down state. Even if the DWC core makes an
assumption that EPF drivers are releasing the channel, in reality it is not
happening.

> 
> A problem with the current code, if you do NOT have this patch, which I assume
> is also problem on pcie-qcom-ep, is that since assert_perst() function performs
> a core reset, all the eDMA setting written in the dbi by the eDMA driver will be
> cleared, so a PERST assert + deassert by the RC will wipe the eDMA settings.
> Hopefully, this will no longer be a problem after this patch has been merged.
> 

Yes. Since all the DBI accesses were moved to the dw_pcie_ep_late_init()
function that get's called during perst deassert with the help of
dw_pcie_ep_init_complete(), all the settings will be reconfigured again.

- Mani

> 
> Kind regards,
> Niklas

-- 
மணிவண்ணன் சதாசிவம்

