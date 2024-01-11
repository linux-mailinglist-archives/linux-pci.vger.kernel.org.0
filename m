Return-Path: <linux-pci+bounces-2054-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A01082AEE0
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 13:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13AC81F245F5
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 12:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2032B15AEF;
	Thu, 11 Jan 2024 12:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I7L9pOnj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71B515AC5
	for <linux-pci@vger.kernel.org>; Thu, 11 Jan 2024 12:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-28cf491b197so2792149a91.1
        for <linux-pci@vger.kernel.org>; Thu, 11 Jan 2024 04:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704976825; x=1705581625; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lUjrrZ3Jg1GUMAie5ebnK4hlRzI9jSk+yPsyIMgP7Cg=;
        b=I7L9pOnj2gmHPXX3UUbnrWYfZH2x5047cV/fypzF3Y4ux3Y0oF/TgcPKblFJhFqyfN
         uRt+i6HwRmtVLCXSAecx2Ihe27aeeuvT5TpzeIlMY+pOieEKi5vEYiIqh8Yh10B/i7CD
         RswIwp5eHwjY6N1qjV8nIrBBXxP6J14XSk3vW2Bn7p6zOzOIE/PEiBwUrY0QGlV1B3uq
         5jloVDT1ujj9h5SuzxJPTboxkF1HAHNqZEefAsPr+DxEp2kTY7JW+n/TN6Iti8VvdcC1
         B9JbnzOo84Tyhq4z4XFf3s4P+tBtYNJme3NJUYiuB1DgqPvdhTHQvmnigGmTOd/jg4fy
         8JSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704976825; x=1705581625;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lUjrrZ3Jg1GUMAie5ebnK4hlRzI9jSk+yPsyIMgP7Cg=;
        b=mXRAIk4olKPFOQKVF185Qe32jArKShauQjc9F4h6g/KuaVXzUWvFQbgtItNip3yid7
         0PB2BuxJOOdjqD3DyjAxJWkzKucLwqR43Xl/wQB9UI+yNnmmhUPB7UupVkAb5AdlXOkB
         8AIKhdqb/yWPmdqlAb+lTjLzIrT8blzn5phz9khDKRmnWWO379U1/36ChfJU/y3FcFDI
         uEvHmksHeGIWAVK73ryHlZ3g91ldPPEx44xPpkDqXWP8EZ/Bkdz1xRl2ySBRs/Y4tgQv
         0si/O6BSsEei/SlYCOHAfCyXj/MGGcqmnsivr4umamk281cAmyv+5n2numwZa0fNGfe6
         GQcw==
X-Gm-Message-State: AOJu0YzYKv/Hrkko3Q+9Pv4wcoYX26UsuIr9ahyh+niLdXE4zGZcHzWQ
	N93pVvcxL23V3I+axIri9vA7rF9Iyqut
X-Google-Smtp-Source: AGHT+IFlzCZDk+7khh2nGY76iLSM3Y0+E3O+l032jjoiVmXYGJDOGVhuEwa5Sr5OwMDDcz8NiN7tAg==
X-Received: by 2002:a17:90a:4984:b0:28c:f1f3:4dcb with SMTP id d4-20020a17090a498400b0028cf1f34dcbmr914767pjh.69.1704976825101;
        Thu, 11 Jan 2024 04:40:25 -0800 (PST)
Received: from thinkpad ([202.131.159.18])
        by smtp.gmail.com with ESMTPSA id mf15-20020a17090b184f00b0028cef2025ddsm1418530pjb.15.2024.01.11.04.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 04:40:24 -0800 (PST)
Date: Thu, 11 Jan 2024 18:10:09 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Lukas Wunner <lukas@wunner.de>, Bartosz Golaszewski <brgl@bgdev.pl>,
	Kalle Valo <kvalo@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	=?iso-8859-1?Q?N=EDcolas_F_=2E_R_=2E_A_=2E?= Prado <nfraprado@collabora.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Peng Fan <peng.fan@nxp.com>, Robert Richter <rrichter@amd.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Huacai Chen <chenhuacai@kernel.org>, Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [RFC 3/9] PCI/portdrv: create platform devices for child OF nodes
Message-ID: <20240111124009.GA3003@thinkpad>
References: <20240104130123.37115-1-brgl@bgdev.pl>
 <20240104130123.37115-4-brgl@bgdev.pl>
 <20240109144327.GA10780@wunner.de>
 <CAMRc=MdXO6c6asvRSn_Z8-oFS48hroT+dazGKB6WWY1_Zu7f1Q@mail.gmail.com>
 <20240110132853.GA6860@wunner.de>
 <659f00ed271b3_5cee2942@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <659f00ed271b3_5cee2942@dwillia2-xfh.jf.intel.com.notmuch>

On Wed, Jan 10, 2024 at 12:41:17PM -0800, Dan Williams wrote:
> [ add Terry ]
> 
> 
> Lukas Wunner wrote:
> > On Wed, Jan 10, 2024 at 01:55:18PM +0100, Bartosz Golaszewski wrote:
> > > On Tue, Jan 9, 2024 at 3:43???PM Lukas Wunner <lukas@wunner.de> wrote:
> > > > On Thu, Jan 04, 2024 at 02:01:17PM +0100, Bartosz Golaszewski wrote:
> > > > > In order to introduce PCIe power-sequencing, we need to create platform
> > > > > devices for child nodes of the port driver node. They will get matched
> > > > > against the pwrseq drivers (if one exists) and then the actuak PCIe
> > > > > device will reuse the node once it's detected on the bus.
> > > > [...]
> > > > > --- a/drivers/pci/pcie/portdrv.c
> > > > > +++ b/drivers/pci/pcie/portdrv.c
> > > > > @@ -715,7 +716,7 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
> > > > >               pm_runtime_allow(&dev->dev);
> > > > >       }
> > > > >
> > > > > -     return 0;
> > > > > +     return devm_of_platform_populate(&dev->dev);
> > > > >  }
> > > >
> > > > I think this belongs in of_pci_make_dev_node(), portdrv seems totally
> > > > the wrong place.  Note that you're currently calling this for RCECs
> > > > (Root Complex Event Collectors) as well, which is likely not what
> > > > you want.
> > > >
> > > 
> > > of_pci_make_dev_node() is only called when the relevant PCI device is
> > > instantiated which doesn't happen until it's powered-up and scanned -
> > > precisely the problem I'm trying to address.
> > 
> > No, of_pci_make_dev_node() is called *before* device_attach(),
> > i.e. before portdrv has even probed.  So it seems this should
> > work perfectly well for your use case.
> > 
> > 
> > > > devm functions can't be used in the PCI core, so symmetrically call
> > > > of_platform_unpopulate() from of_pci_remove_node().
> > > 
> > > I don't doubt what you're saying is true (I've seen worse things) but
> > > this is the probe() callback of a driver using the driver model. Why
> > > wouldn't devres work?
> > 
> > The long term plan is to move the functionality in portdrv to
> > the PCI core.  Because devm functions can't be used in the PCI
> > core, adding new ones to portdrv will *add* a new roadblock to
> > migrating portdrv to the PCI core.  In other words, it makes
> > future maintenance more difficult.
> > 
> > Generally, only PCIe port services which share the same interrupt
> > (hotplug, PME, bandwith notification, flit error counter, ...)
> > need to live in portdrv.  Arbitrary other stuff should not be
> > shoehorned into portdrv.
> 
> I came here to say the same thing. It is already the case that portdrv
> is not a good model to build new functionality upon [1], and PCI core
> enlightenment should be considered first.
> 

The primary reason for plugging the power sequencing into portdrv is due to
portdrv binding with all the bridge devices and acting as management driver for
the bridges. This is where exactly the power sequencing part needs to be plugged
in IMO. But if the idea of the portdrv is just to expose services based on
interrupts, then please suggest a better place to plug this power sequencing
part.

- Mani

> The portdrv model is impeding Terry's CXL Port error handling effort, so
> I am on the lookout for portdrv growing new entanglements to unwind
> later.
> 
> [1]: http://lore.kernel.org/r/20221025232535.GA579167@bhelgaas
> 

-- 
மணிவண்ணன் சதாசிவம்

