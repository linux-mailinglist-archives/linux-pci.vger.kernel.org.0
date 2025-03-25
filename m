Return-Path: <linux-pci+bounces-24686-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BBBA7071B
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 17:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 311F916B451
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 16:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8306025D553;
	Tue, 25 Mar 2025 16:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gm7A+yRb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB9419066D
	for <linux-pci@vger.kernel.org>; Tue, 25 Mar 2025 16:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742920603; cv=none; b=gQM8tDIV8a2DW+E+CVC1156MD42TDWb4ElAFbQZ5Pxf+2FMtdtUB9eJGHc/WYFg+nTdrtmB2Tq/VEmDVAbNnyLVX81DFtUXKCbFepH9DL4Q59AUJAZsEG0NINxhpiqcZmhISFJeOxJEw/n4PjW6joEMIgdz5ujOgLKBfyOSvY4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742920603; c=relaxed/simple;
	bh=BVF6tvcpehD4+H6Zap8OoyqkRDaTorodX42PsoJ5H/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XgEx9AhwlPe/cuVc9zewl10G9j30I1KXBP2pctPOFbHE0TPaIdrtH7Sb81QayEh5bgfHLBpqE8sZGx6hAeyeBm62PnjUbb4ZjHBmBYUXkKIXXw1hvigE2oL4+CJjjAk4aSC50LPM1ZSwMLQd5waAxEBqpl7eUnfSxXp74algNwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Gm7A+yRb; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2240b4de12bso51232735ad.2
        for <linux-pci@vger.kernel.org>; Tue, 25 Mar 2025 09:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742920600; x=1743525400; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x45WNxy+GXjRDdBoNfsMrlZpihQlvBlFRGtpBrd99JI=;
        b=Gm7A+yRb2YKzS8G2j05WT9blXwkK1Vqgx13gbNEzJ87B1AM7QXoUaqTEUJAO9Ny8vp
         9TffEpyYM/Bbc9cvqYA/BwVf7G7T6JUe6v4sPNUDrQVpLtUYSrIwoLZpZwSkm9JxvojS
         t5eo4xY5wukC3c6bwM+2tP7+RvPA09/vGyM86pOOPa+Sq8X959pcIj3xluZodSMnjFA7
         FeC/XGrvvzfPS/1BHYbhxZt/9aIibU8+qh1rWss0jr4Na+ruJ41ctJdGEju5QWnIHVsn
         h/1Gzh/V3Ui8lMKCNkpxEK/SikbjYa4u5yJKw+Su0GaJeSPUr1/rySRU/lxzASdLVpjI
         fSAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742920600; x=1743525400;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x45WNxy+GXjRDdBoNfsMrlZpihQlvBlFRGtpBrd99JI=;
        b=DRPPsc3jymfk8uduZMvF0eIlSC6XPde9cGmO+/2DYLZ05Yr176ts+p7uyDCtIwtvqB
         jQGFE080Sii+CTq0aDkbvGP8dis2r1lqJAJZb0gC32Dj9YSI4LZ8SeV5S8MZPV15BzP6
         T1Ow/deUDh6fPpI4GlxIA5ERPST1UEXu/THkeMxOznyaeH67nQQKzj0nmVZKSEV4E1Wa
         AXXEEyVvyyLElZj2ruaw+OibC8qEXFwYtlP85yBlEs/7Qrv6jccDFL0RjSMpai626/8Q
         Uom3sgiWD9OIGVJxUG1729aCTTM3i7Ut9A4Gf8fLm+8vqh7w4bMw21chMeJt1nT/GT0Y
         xCZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWecyhFAlBSzOBo7Cn0zOYn0G1MnHPMRio4MzIX6sVUnZ5T9x3xmP0YSmFuc/rjy3P0tBVRBAQNekU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygbt7gYAAgzhGfxXelyp5LNRBT6wyr/iVmVb0f3j/ddmlq862R
	aMGgstsVH9+EFFqHQteq5b7pahS+20Q+4Ao8KE+Gq3uPPek141qaidjEyVxfUQ==
X-Gm-Gg: ASbGncs13quY2rQmOT+KE5L+c074V55DR7OGEOlQSDwHTlpL22RF4eif3aKQ8bxnUwN
	UO8fwPmhmGZQ4WU4hMMcxN6BeSHxtO+LdmirMrOf1Z8WDTquaVKnxRWlhcBdHyF06WDc6rhrXzP
	QRdXLfOYgcWqMsGQk9apqTzvWSvTTbTE9F0VkMl2mgvFzX0FN7kMXgfmlTwAGkvj9hMyqYERtxL
	oL5zLashZG0vYXZofastYJrG/UMooLZPylkefg5YAcTtvhQPg4EcB5ux7dKrRdZjMMJkOSeTD3Q
	NmRK4xrygmUMptukHiKyL6PIFi+wWcsfKpsGjnSXcS8o563UWPrp6QBf
X-Google-Smtp-Source: AGHT+IEVZf3cjT/H7LfymK6hzxUjvfOQ2dA0kGMvfu5BvFoGp9VVlRIweYBC+Rpqfm4TthlGV5Mt8g==
X-Received: by 2002:a17:90b:1f8d:b0:2ff:72f8:3708 with SMTP id 98e67ed59e1d1-3030fea9024mr30752421a91.17.1742920599697;
        Tue, 25 Mar 2025 09:36:39 -0700 (PDT)
Received: from thinkpad ([120.60.136.104])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf61a49bsm14597634a91.34.2025.03.25.09.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 09:36:39 -0700 (PDT)
Date: Tue, 25 Mar 2025 22:06:32 +0530
From: 
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>
To: Hans Zhang <hans.zhang@cixtech.com>
Cc: Peter Chen <peter.chen@cixtech.com>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>, 
	"bhelgaas@google.com" <bhelgaas@google.com>, "vigneshr@ti.com" <vigneshr@ti.com>, 
	"kishon@kernel.org" <kishon@kernel.org>, "cassel@kernel.org" <cassel@kernel.org>, 
	"wojciech.jasko-EXT@continental-corporation.com" <wojciech.jasko-EXT@continental-corporation.com>, "thomas.richard@bootlin.com" <thomas.richard@bootlin.com>, 
	"bwawrzyn@cisco.com" <bwawrzyn@cisco.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "srk@ti.com" <srk@ti.com>
Subject: Re: [PATCH 0/4] Loadable Module support for PCIe Cadence and J721E
Message-ID: <2sxwud7mllpbtymfvlw5sshv3fhz3rpk37x23x5ywpzle2qlg4@7bsqhcimnfqp>
References: <20250307103128.3287497-1-s-vadapalli@ti.com>
 <Z9pffxeXHVOsoi4O@nchen-desktop>
 <20250319062534.ollh3s5t7znf5zqs@uda0492258>
 <Z9qO1f5MgNcwO5A4@nchen-desktop>
 <20250319095511.hf3y2c6vbbnm3ien@thinkpad>
 <a8966792-fa0e-4e8e-aceb-427819ae4ef5@cixtech.com>
 <bkw4xm4jwe3iuf6sixxl4udosea3bhlwogfua66naf5echbyzv@dlwcbscedh6w>
 <96940e1e-a395-49bc-ac29-7ca86bfb8ad7@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <96940e1e-a395-49bc-ac29-7ca86bfb8ad7@cixtech.com>

On Wed, Mar 26, 2025 at 12:03:01AM +0800, Hans Zhang wrote:
> 
> 
> On 2025/3/25 23:26, manivannan.sadhasivam@linaro.org wrote:
> > EXTERNAL EMAIL
> > 
> > On Thu, Mar 20, 2025 at 10:14:02AM +0800, hans.zhang wrote:
> > > 
> > > 
> > > On 2025/3/19 17:55, manivannan.sadhasivam@linaro.org wrote:
> > > > EXTERNAL EMAIL
> > > > 
> > > > On Wed, Mar 19, 2025 at 05:31:01PM +0800, Peter Chen wrote:
> > > > > On 25-03-19 14:25:34, Siddharth Vadapalli wrote:
> > > > > > > > 
> > > > > > > > Hello,
> > > > > > > > 
> > > > > > > > This series enables support to build the PCIe Cadence Controller drivers
> > > > > > > > and the PCI J721E Application/Wrapper/Glue driver as Loadable Kernel
> > > > > > > > Modules. The motivation for this series is that PCIe is not a necessity
> > > > > > > > for booting the SoC, due to which it doesn't have to be a built-in
> > > > > > > > module. Additionally, the defconfig doesn't enable the PCIe Cadence
> > > > > > > > Controller drivers and the PCI J721E driver, due to which PCIe is not
> > > > > > > > supported by default. Enabling the configs as of now (i.e. without this
> > > > > > > > series) will result in built-in drivers i.e. a bloated Linux Image for
> > > > > > > > everyone who doesn't have the PCIe Controller.
> > > > > > > 
> > > > > > > If the user doesn't enable PCIe controller device through DTS/ACPI,
> > > > > > > that's doesn't matter.
> > > > > > 
> > > > > > The Linux Image for arm64 systems built using:
> > > > > > arch/arm64/configs/defconfig
> > > > > > will not have support for the Cadence PCIe Controller and the PCIe J721e
> > > > > > driver, because these configs aren't enabled.
> > > > > > 
> > > > > > > 
> > > > > > > > @@ -209,6 +209,12 @@ CONFIG_NFC=m
> > > > > > > >    CONFIG_NFC_NCI=m
> > > > > > > >    CONFIG_NFC_S3FWRN5_I2C=m
> > > > > > > >    CONFIG_PCI=y
> > > > > > > > +CONFIG_PCI_J721E=m
> > > > > > > > +CONFIG_PCI_J721E_HOST=m
> > > > > > > > +CONFIG_PCI_J721E_EP=m
> > > > > > > > +CONFIG_PCIE_CADENCE=m
> > > > > > > > +CONFIG_PCIE_CADENCE_HOST=m
> > > > > > > > +CONFIG_PCIE_CADENCE_EP=m
> > > > > > > 
> > > > > > > The common Cadence configuration will be select if the glue layer's
> > > > > > > configuration is select according to Kconfig.
> > > > > > > 
> > > > > > > Please do not set common configuration as module, some user may need
> > > > > > > it as build-in like dw's. Considering the situation, the rootfs is at
> > > > > > > NVMe.
> > > > > > 
> > > > > > The common configuration at the moment is "DISABLED" i.e. no support for
> > > > > > the Cadence Controller at all. Which "user" are you referring to? This
> > > > > > series was introduced since having the drivers built-in was pushed back at:
> > > > > 
> > > > > We are using Cadence controller, and prepare upstream radxa-o6 board
> > > > > whose rootfs is at PCIe NVMe.
> > > > > 
> > > > 
> > > > It doesn't matter. Only criteria AFAIK to build the driver as built-in in
> > > > defconfig is that it should be a depedency for console. For some time, storage
> > > > was also a dependency, but for sure PCIe is not.
> > > > 
> > > > Moreover, CONFIG_BLK_DEV_NVME is built as a module in ARM64 defconfig. So it
> > > > doesn't matter if you build PCIe controller driver as a built-in or not. You
> > > > need to load the NVMe driver somehow.
> > > > 
> > > > So please use initramfs.
> > > > 
> > > > > You could build driver as module for TI glue layer, but don't force
> > > > > other vendors using module as well, see dwc as an example please.
> > > > > 
> > > > 
> > > > DWC is a bad example here. Only reason the DWC drivers are not loadable is due
> > > > to the in-built MSI controller implementation as irqchip. People tend to build
> > > > the irqchip controllers as always built-in for some known issues. Even then some
> > > > driver developers prefer to built them as loadable module but suppress unbind to
> > > > avoid rmmoding the module.
> > > Hi Mani,
> > > 
> > > I think the MSI RTL module provided by Synopsys PCIe controller IP is not a
> > > standard operation. The reason for this MSI module is probably to be used by
> > > some cpus that do not have ITS(LPI interrupt) designed. Or RISC-V SOC, etc.
> > > MSI is defined as an MSI/MSIX interrupt that starts with a direct write
> > > memory access.
> > > 
> > 
> > Yeah, DWC MSI controller is not a great design. The older ones are even more
> > horrible (using SPI interrupts for reporting AERs etc...).
> 
> Hi Mani,
> 
> Currently Synopsys and Cadence provide SPI interrupts for reporting AERs
> etc... This IP vendor only provides an alternative approach that actually
> requires SOC design companies to design according to PCIe SPEC and conform
> to linux OS software behavior.
> 
> I have a way to workaround AER is SPI interrupt. It can also use aer.c
> drivers. However, I have been afraid to submit patch, because this is a
> problem of SOC designers themselves, which does not conform to the port
> driver of linux os (aer.c). So it will certainly not be accepted.
> 

Right. There is not clean way afaik.

> 
> > 
> > > There are also SOC vendors that do not use the built-in MSI RTL module.
> > > Instead, MSI/MSIX interrupts are transmitted directly to the GIC's ITS
> > > module via the GIC V3/V4 interface. For example, RK3588, they do not use the
> > > PCIe controller built-in MSI module. Some Qualcomm platforms also modify the
> > > PCIe controller's built-in MSI modules to connect each of them to 32 SPI
> > > interrupts to the GIC. I was under the impression that the SDM845 was
> > > designed that way. The only explanation is that SPI interrupts are faster
> > > than LPI interrupts without having to look up some tables.
> > > 
> > 
> > If ITS is available, platforms should make use of that. There is no way DWC MSI
> > is superior than ITS. We are slowly migrating the Qcom platforms to use ITS.
> > 
> 
> I agree with you.
> 
> > And btw, Qcom DWC MSI controller raise interrupts for AER/PME sent by the
> > downstream components. So enabling ITS is uncovering AER errors which were
> > already present :)
> > 
> > > So the dwc driver can also compile to ko?
> > > 
> > 
> > Only if the MSI support is made as a build time option and there is a guarantee
> > that the platform will never use it (which is difficult to do as the driver can
> > only detect it during the runtime based on devicetree).
> 
> Anyway, I would still like to request that the Cadence PCIe controller
> driver not be in module mode. Cadence also has a lot of customers, we are
> one of them, it's just that many customers don't have upstream. We are about
> to upstream.
> 
> This series was introduced since having the drivers built-in was pushed back
> at:
> https://lore.kernel.org/linux-arm-kernel/20250122145822.4ewsmkk6ztbeejzf@slashing/
> 
> Hans:
> The Cadence PCIe root port driver can not be made into module mode because
> of TI's idea. We should consider the ideas of other customers. If you have
> to make it module mode, I think all peripheral drivers should be module
> mode. Maybe I'm being direct, but that's probably the case.
> 

It is not about one company's idea to make the driver as a module. Linux kernel
community in general strongly encourages developers to build the drivers as
module unless there are exceptions (which I have already quoted). If you keep
building the drivers as built-in, it will result in a bloated kernel image. For
sure vendors would want *their* interested drivers to be built-in so that they
do not need to package the drivers in initramfs/rootfs, but that's not a
practice which is encouraged by the Linux community.

So I'm in favor of making the PCIe controllers as module if there are no
technical issues.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

