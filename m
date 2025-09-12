Return-Path: <linux-pci+bounces-35979-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE45B540A0
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 04:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B26C71C2510C
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 02:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8323721CFF6;
	Fri, 12 Sep 2025 02:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TG98E05g"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E2D21E0AD
	for <linux-pci@vger.kernel.org>; Fri, 12 Sep 2025 02:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757645273; cv=none; b=lzwOJwR8jRJ0h1g3QKSxdt09hqXItc+hk/ePShCMEpqA5URejkdF3axfAUo8QAfTkCSsDtDxghB9ZFr36e9lH3K7uHpL5F5Q3qVI+cvWDocrZnpg5H/1/oLjW/Tu/lIly+PMo/ajDEK+L0m+IOAGEwrzINxAXCsO+ecO/9BWGjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757645273; c=relaxed/simple;
	bh=yFDobYsSZq/zp8BICShjZEiQbdcNvnbpAn3GlnqQnOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZiQxAq5hDVtuDKhmYHq6yJmjbMOLcPFnyt9KYtbDGap0IH9aebwVx+C/RujDudm/hr65m8ZtB4dbcwyZC4i+7jhenCRoXiQi6VCCkjF3/0MwIVhjS6o3Mf28hchIQKZwkwz7IQqyBMRbo5Pb7hta606V4p+ZegpuhjC7xsVY6Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TG98E05g; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-24b21006804so16213355ad.3
        for <linux-pci@vger.kernel.org>; Thu, 11 Sep 2025 19:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757645270; x=1758250070; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kEod2N8uRbvkJvc+UFZ4BZQkPJQ0ifAgQ3mIeVf0CVo=;
        b=TG98E05g4HZwnKnGjecWPbkjS3E5/UOCN9/u3PsJcFmvdlZb3+X7Hgx44bjxpJfubF
         55U5cKvhA6POqtp/I8s6pyAhPu85/bnfZbjeJg+Vxj6gIg5UZk24DrvpLE22B5tYnC05
         3rO+ZpEsHodQk2IunI+PQnKQxekGD3t51a0B0wuYIU/x880xOO8GcxDXaBu/Tkg/snj7
         NbiCDZice+9zbTpRn0GsBXrYhfPqPow1fnYtQtzNxcJl6dlI6n7/1oiOMklWzp9FKoBU
         5pkVipG/h9xAhZvmVlQq/H2QYfH6VzEExk0QCxNzPsLWaxIb56pk5t4TK4k2gsMg9gaX
         mr3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757645270; x=1758250070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kEod2N8uRbvkJvc+UFZ4BZQkPJQ0ifAgQ3mIeVf0CVo=;
        b=me0me5HQMl6wyKLT9SonxfkN4VhB4XOibYA4N8mxaCcMUIZcC/+y1+N4U1DNJG8ZnG
         6CTEH4ZrERkzHbgcFIf6uxSGz1mEB/jEzHCHTfd552jHv7GshFBUm+IUlxWhakHXCEns
         aSj2qaFT4WafjwpQaanfRAENoYHt1YxbYnTAb/Bzl7sMxrbj+gL5XLyr5CED3ZosXGbn
         MZUG6DNj2WU332sJW1hkoVkLTtF/mOINKhxie9E7ngslarYSXqEBDBLj/HzYxsMERW1v
         h1XegrFs4T680FvfKar0fHFI6knNJJYF0rCnXYlOvoWrr9eyY+AsLfFXV8p7O3T4F/+2
         n9ow==
X-Forwarded-Encrypted: i=1; AJvYcCXB8NMWtXIpL1TK1je2UfgED4Oh5nzOVt4TDJ0VmBdA7IB22dTBNyLvuQWaSn6WO+i7t51yjpbesxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBbt0+Ms/UhC5e4s7vp1PeR/9wekWVu4XCmk37NFTMdi8RMrE1
	lFZQ9krTweRdi/z82pQ5tczjdXVVBpBoYmhbCa4gfEhJecOZOvuEJCIM
X-Gm-Gg: ASbGncsoekJkev9OnRkx7MAFaHzK9v+AMyT3cDb/RfytPDeq1eNG57CbHrsw4pmDLPb
	s9Xv35qSf007hYM2CRwUdwPYqLpf+d91kYzFfaTSzt30uOzRNq7SPTlyBbH+WZJY3bYU2J2x4Gw
	HRR+yb9W7kGCaA6MZJZXYml3fXiDJAtfK9QWQEcXqV0FZSfxUtMz+6H/A5TpqBEg73xpAGl/zQx
	KYO1uO9fpBtx8HJOYyZP8Bkp7pwvfdBaetGA8zp7FKqaG0DR/FI68p5I7Xnjk/lIX2xleGG7SWk
	wWsFMPtkPC8I2ponvw3hWPsQvlOE0a8IcScO1o9w8aTVn40J512VakejF9SkkOSNSS9vJJeDdLK
	3maLMz5dL9QzLNLUAFkqyETS6xw6dtKq1
X-Google-Smtp-Source: AGHT+IHk193yNMltpKeNNARwHZ7rfre7JMx5iLiB6RE3QMb05YheJaq48yb+Ee7d1Mu/dSjamjkpPw==
X-Received: by 2002:a17:902:ea09:b0:24c:829a:ee4a with SMTP id d9443c01a7336-25d247d175emr16495555ad.17.1757645270081;
        Thu, 11 Sep 2025 19:47:50 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-25c36cc53bcsm33542345ad.28.2025.09.11.19.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 19:47:49 -0700 (PDT)
Date: Fri, 12 Sep 2025 10:47:43 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
	Inochi Amaoto <inochiama@gmail.com>
Cc: Chen Wang <unicornxw@gmail.com>, kwilczynski@kernel.org, 
	u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu, alex@ghiti.fr, arnd@arndb.de, 
	bwawrzyn@cisco.com, bhelgaas@google.com, unicorn_wang@outlook.com, 
	conor+dt@kernel.org, 18255117159@163.com, kishon@kernel.org, krzk+dt@kernel.org, 
	lpieralisi@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com, robh@kernel.org, 
	s-vadapalli@ti.com, tglx@linutronix.de, thomas.richard@bootlin.com, 
	sycamoremoon376@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org, sophgo@lists.linux.dev, 
	rabenda.cn@gmail.com, chao.wei@sophgo.com, xiaoguang.xing@sophgo.com, 
	fengchun.li@sophgo.com
Subject: Re: [PATCH v2 3/7] PCI: sg2042: Add Sophgo SG2042 PCIe driver
Message-ID: <kd3wxvditosgj7rihh2q5iqvl43ljunbxaqbqpcxpmsbdnsbga@f4jm3o33ilkv>
References: <cover.1757467895.git.unicorn_wang@outlook.com>
 <162d064228261ccd0bf9313a20288e510912effd.1757467895.git.unicorn_wang@outlook.com>
 <xmk5uvnw7mcizxpaoarvx2c2sejaz2skaiyyac7oo5y6loyjgp@5v3sldwbqpw5>
 <rarvqtex3vsve3sscaky3rw727hwp5avmxve3lluwoviqbt6m6@h3nlqbi2s3fd>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rarvqtex3vsve3sscaky3rw727hwp5avmxve3lluwoviqbt6m6@h3nlqbi2s3fd>

On Thu, Sep 11, 2025 at 10:33:18PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Sep 10, 2025 at 10:56:23AM GMT, Inochi Amaoto wrote:
> > On Wed, Sep 10, 2025 at 10:08:39AM +0800, Chen Wang wrote:
> > > From: Chen Wang <unicorn_wang@outlook.com>
> > > 
> > > Add support for PCIe controller in SG2042 SoC. The controller
> > > uses the Cadence PCIe core programmed by pcie-cadence*.c. The
> > > PCIe controller will work in host mode only, supporting data
> > > rate(gen4) and lanes(x16 or x8).
> > > 
> > > Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> > > ---
> > >  drivers/pci/controller/cadence/Kconfig       |  10 ++
> > >  drivers/pci/controller/cadence/Makefile      |   1 +
> > >  drivers/pci/controller/cadence/pcie-sg2042.c | 104 +++++++++++++++++++
> > >  3 files changed, 115 insertions(+)
> > >  create mode 100644 drivers/pci/controller/cadence/pcie-sg2042.c
> > > 
> > > diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
> > > index 666e16b6367f..02a639e55fd8 100644
> > > --- a/drivers/pci/controller/cadence/Kconfig
> > > +++ b/drivers/pci/controller/cadence/Kconfig
> > > @@ -42,6 +42,15 @@ config PCIE_CADENCE_PLAT_EP
> > >  	  endpoint mode. This PCIe controller may be embedded into many
> > >  	  different vendors SoCs.
> > >  
> > > +config PCIE_SG2042_HOST
> > > +	tristate "Sophgo SG2042 PCIe controller (host mode)"
> > > +	depends on OF && (ARCH_SOPHGO || COMPILE_TEST)
> > > +	select PCIE_CADENCE_HOST
> > > +	help
> > > +	  Say Y here if you want to support the Sophgo SG2042 PCIe platform
> > > +	  controller in host mode. Sophgo SG2042 PCIe controller uses Cadence
> > > +	  PCIe core.
> > > +
> > >  config PCI_J721E
> > >  	tristate
> > >  	select PCIE_CADENCE_HOST if PCI_J721E_HOST != n
> > > @@ -67,4 +76,5 @@ config PCI_J721E_EP
> > >  	  Say Y here if you want to support the TI J721E PCIe platform
> > >  	  controller in endpoint mode. TI J721E PCIe controller uses Cadence PCIe
> > >  	  core.
> > > +
> > >  endmenu
> > > diff --git a/drivers/pci/controller/cadence/Makefile b/drivers/pci/controller/cadence/Makefile
> > > index 9bac5fb2f13d..5e23f8539ecc 100644
> > > --- a/drivers/pci/controller/cadence/Makefile
> > > +++ b/drivers/pci/controller/cadence/Makefile
> > > @@ -4,3 +4,4 @@ obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host.o
> > >  obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep.o
> > >  obj-$(CONFIG_PCIE_CADENCE_PLAT) += pcie-cadence-plat.o
> > >  obj-$(CONFIG_PCI_J721E) += pci-j721e.o
> > > +obj-$(CONFIG_PCIE_SG2042_HOST) += pcie-sg2042.o
> > > diff --git a/drivers/pci/controller/cadence/pcie-sg2042.c b/drivers/pci/controller/cadence/pcie-sg2042.c
> > > new file mode 100644
> > > index 000000000000..c026e1ca5d6e
> > > --- /dev/null
> > > +++ b/drivers/pci/controller/cadence/pcie-sg2042.c
> > > @@ -0,0 +1,104 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * pcie-sg2042 - PCIe controller driver for Sophgo SG2042 SoC
> > > + *
> > > + * Copyright (C) 2025 Sophgo Technology Inc.
> > > + * Copyright (C) 2025 Chen Wang <unicorn_wang@outlook.com>
> > > + */
> > > +
> > > +#include <linux/mod_devicetable.h>
> > > +#include <linux/pci.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/pm_runtime.h>
> > > +
> > > +#include "pcie-cadence.h"
> > > +
> > > +/*
> > > + * SG2042 only supports 4-byte aligned access, so for the rootbus (i.e. to
> > > + * read/write the Root Port itself, read32/write32 is required. For
> > > + * non-rootbus (i.e. to read/write the PCIe peripheral registers, supports
> > > + * 1/2/4 byte aligned access, so directly using read/write should be fine.
> > > + */
> > > +
> > > +static struct pci_ops sg2042_pcie_root_ops = {
> > > +	.map_bus	= cdns_pci_map_bus,
> > > +	.read		= pci_generic_config_read32,
> > > +	.write		= pci_generic_config_write32,
> > > +};
> > > +
> > > +static struct pci_ops sg2042_pcie_child_ops = {
> > > +	.map_bus	= cdns_pci_map_bus,
> > > +	.read		= pci_generic_config_read,
> > > +	.write		= pci_generic_config_write,
> > > +};
> > > +
> > > +static int sg2042_pcie_probe(struct platform_device *pdev)
> > > +{
> > > +	struct device *dev = &pdev->dev;
> > > +	struct pci_host_bridge *bridge;
> > > +	struct cdns_pcie *pcie;
> > > +	struct cdns_pcie_rc *rc;
> > > +	int ret;
> > > +
> > > +	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*rc));
> > > +	if (!bridge) {
> > > +		dev_err_probe(dev, -ENOMEM, "Failed to alloc host bridge!\n");
> > > +		return -ENOMEM;
> > > +	}
> > > +
> > > +	bridge->ops = &sg2042_pcie_root_ops;
> > > +	bridge->child_ops = &sg2042_pcie_child_ops;
> > > +
> > > +	rc = pci_host_bridge_priv(bridge);
> > > +	pcie = &rc->pcie;
> > > +	pcie->dev = dev;
> > > +
> > > +	platform_set_drvdata(pdev, pcie);
> > > +
> > > +	pm_runtime_set_active(dev);
> > > +	pm_runtime_no_callbacks(dev);
> > > +	devm_pm_runtime_enable(dev);
> > > +
> > > +	ret = cdns_pcie_init_phy(dev, pcie);
> > > +	if (ret) {
> > > +		dev_err_probe(dev, ret, "Failed to init phy!\n");
> > > +		return ret;
> > > +	}
> > > +
> > > +	ret = cdns_pcie_host_setup(rc);
> > > +	if (ret) {
> > > +		dev_err_probe(dev, ret, "Failed to setup host!\n");
> > > +		cdns_pcie_disable_phy(pcie);
> > > +		return ret;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > 
> > > +static void sg2042_pcie_remove(struct platform_device *pdev)
> > > +{
> > > +	struct cdns_pcie *pcie = platform_get_drvdata(pdev);
> > > +
> > > +	cdns_pcie_disable_phy(pcie);
> > > +}
> > > +
> > 
> > I think this remove is useless, as it is almost impossible to
> > remove a pcie at runtime.
> > 
> 
> Why impossible? We only have concerns with removing PCIe controllers
> implementing irqchip, but this driver is not implementing it and using an
> external irqchip controller.
> 
> So it is safe and possible to remove this driver during runtime.
> 

Good to know this. It is the thing I did not know before.
So it is OK for me to see this code.

Thanks,
Inochi

