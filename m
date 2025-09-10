Return-Path: <linux-pci+bounces-35788-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF10B50C01
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 04:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53AC91897F8D
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 02:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09749248F78;
	Wed, 10 Sep 2025 02:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImSsWBc8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40502246BD8;
	Wed, 10 Sep 2025 02:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757472989; cv=none; b=bnQiR5PttMH+JIfhJ10URVwbV2M+SkkIfEbjDJefFswWlwaiUA1yY9rD2XBdUFuasAcEKTvWdTjvXeV9BF/sm5f7ZcpQpknD6YFbltWVOCI/bQRMwwWgiQpWGo5ejtCgd1fUjFdN8F30Btng7CGWWOj0W1z8olwRMBKr4MBdlfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757472989; c=relaxed/simple;
	bh=9aZWBowem9quzBxMewIkYmZOsbgydJUvO2LjN/H0tPI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9LJztbJ40tPcuNs3XyCpcDo9fVdj+AQ4HEnw899eZf8SQ5psVGaR2ZBB9YhjykprOAK32yqrYSV3sGhZkjZHZKEPJJeMvAus+Vm/UL7u+eMjxr539zm6RuGPvQaPZjS7XUWZkSu2CsiYbp07urz4+m4YHXswBuuama0UQHersY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImSsWBc8; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24cbd9d9f09so82071285ad.2;
        Tue, 09 Sep 2025 19:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757472987; x=1758077787; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bccMpZ/9BOkjWFOHbeJr/ZW3cHQMAN90oKmu+ORNptc=;
        b=ImSsWBc8FLTnx56pKlA6dHUdl9HzQ5g4yCl3McTfult02hgK4Sx8sJRbX6SzXEMTT/
         hbwHR+Ga2OXlVB8POcCXcNNwia/8ZGgEZKKR7xG8mxb/zhT3zAp9QjQEZ9tTmHQWUi+l
         y/5JeIE+jj+ayUTtBsxUvUx2iVMOL4To311pYzbm7SBhIEa9yhFsxhjB7Q67P7QeXWRP
         nzmCfLGYgAVjwhAcVhmDvu6334O/c5xAL7mBHqCu5SR0tWbD3nbsbyvLX93dV8GGrYYb
         56hjn/HXWIUgU1cyENBWpcJRwsyK5s/ht9Cnh1ciRmebfSRqxDhQh9Fmg4qkcg8BdHan
         9+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757472987; x=1758077787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bccMpZ/9BOkjWFOHbeJr/ZW3cHQMAN90oKmu+ORNptc=;
        b=boX+C4mAuqMMvpjvDB1Uhs5RQXY38ZJHg6stXt8R9wMfuIYDmRg27uMi/RWofoAi/a
         gAuvJPQCDmFczNl3nIHPvt0JQuiv5SkNUTbfaB5QqywM95jsbHDFR/L7xPHgA14PKPGO
         s3QWuGYc+ljUl2IGpqNAvEQ0saW+0FCfzKvzCi1BSAN+CDnRUIhD84oM0q8mGwdFFhZy
         bxZEaaF/0+V//btC/UA7jkSU67Fl+Lv2mQriUwLuDVuSiqa+Xcr9HL82lRgtcVW8iHZf
         eems2Aq43J2CgcvdchOdlsVJibccBsdbk31oMfZIaZrLdjr3baKSMBOg65znnKXAzDrL
         F/ww==
X-Forwarded-Encrypted: i=1; AJvYcCWcN0diVLSLyd1UpjcdV9mQTFKTZmnxanYlUBmOE5xnVSoMTuIGUr07sesLza7cipMhQRslq93x0kYM@vger.kernel.org, AJvYcCXN+8ZSkRveaXInp6FfYX48mSr0Dc5yX23btDwXqDcJ97ub7e17vkcZ0F3vtXdd6X1iVnEmLMDTiDHUUJYU@vger.kernel.org, AJvYcCXYT/5aS5w16rCpQNOC6ExPMVKUI2wuYU9ZiithAdJh4OnbFY/EOf674UK/xq2I5+L0CKBmwBcR678V@vger.kernel.org
X-Gm-Message-State: AOJu0YwzovAgZpbU8x/zQ3Tof0TgCJLTxhx3v/iivmzkNu90ajQdJJF5
	JpWiIY7G1HxrCuaXUxoESaoRPhQwqj/ramsnLj3DHBxgCttUwqrrsxG9
X-Gm-Gg: ASbGncs+JNLtWY44fLpwpulIKpLyHrm6o0p58D/GIo8hOLr3rR3ucmXkTbcifSi/WGz
	K8hG2BnwTAB9gk3dP88zlP/n0SPK6Hl/PiJiioKPCzdJ0lxKCMa0VrStcSAdkR51FklUuhUF/LC
	yHdXa4oXf5stQHEg2/VYOxV1em4HG5J1UFRFheMNX3IgLnbwSuYSkgCn+O+RK1GFPopQo1SeDCt
	f1uCvoYYWXQdy7pO4EYRl9qqJxYnx0v+6hq267SWHP5Aan3hHZhneKocNTBeb84pJqbDbLRxgnP
	JoJV7C7K7Z6bKCTv+Wy+71vEMYFOYFFp3nE+Ig9pGdvgmkPuDnizpXaKSfzsVXvcpO6zB59wkWX
	0RFD2msOueLPgQDV4zCquwegAuwKPcHsd
X-Google-Smtp-Source: AGHT+IFNBos7noDUln9W5GM7yi+/GGgz4QmYFcZtpZbyom0FkxzLpYxnYCZbcxZV/hMMSxTnIj0g7Q==
X-Received: by 2002:a17:903:1c2:b0:249:1213:6725 with SMTP id d9443c01a7336-251753d88d0mr190803255ad.50.1757472987403;
        Tue, 09 Sep 2025 19:56:27 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-32dbb5efe7asm650016a91.17.2025.09.09.19.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 19:56:27 -0700 (PDT)
Date: Wed, 10 Sep 2025 10:56:23 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Chen Wang <unicornxw@gmail.com>, kwilczynski@kernel.org, 
	u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu, alex@ghiti.fr, arnd@arndb.de, 
	bwawrzyn@cisco.com, bhelgaas@google.com, unicorn_wang@outlook.com, 
	conor+dt@kernel.org, 18255117159@163.com, inochiama@gmail.com, kishon@kernel.org, 
	krzk+dt@kernel.org, lpieralisi@kernel.org, mani@kernel.org, palmer@dabbelt.com, 
	paul.walmsley@sifive.com, robh@kernel.org, s-vadapalli@ti.com, tglx@linutronix.de, 
	thomas.richard@bootlin.com, sycamoremoon376@gmail.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org, 
	sophgo@lists.linux.dev, rabenda.cn@gmail.com, chao.wei@sophgo.com, 
	xiaoguang.xing@sophgo.com, fengchun.li@sophgo.com
Subject: Re: [PATCH v2 3/7] PCI: sg2042: Add Sophgo SG2042 PCIe driver
Message-ID: <xmk5uvnw7mcizxpaoarvx2c2sejaz2skaiyyac7oo5y6loyjgp@5v3sldwbqpw5>
References: <cover.1757467895.git.unicorn_wang@outlook.com>
 <162d064228261ccd0bf9313a20288e510912effd.1757467895.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162d064228261ccd0bf9313a20288e510912effd.1757467895.git.unicorn_wang@outlook.com>

On Wed, Sep 10, 2025 at 10:08:39AM +0800, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> Add support for PCIe controller in SG2042 SoC. The controller
> uses the Cadence PCIe core programmed by pcie-cadence*.c. The
> PCIe controller will work in host mode only, supporting data
> rate(gen4) and lanes(x16 or x8).
> 
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>  drivers/pci/controller/cadence/Kconfig       |  10 ++
>  drivers/pci/controller/cadence/Makefile      |   1 +
>  drivers/pci/controller/cadence/pcie-sg2042.c | 104 +++++++++++++++++++
>  3 files changed, 115 insertions(+)
>  create mode 100644 drivers/pci/controller/cadence/pcie-sg2042.c
> 
> diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
> index 666e16b6367f..02a639e55fd8 100644
> --- a/drivers/pci/controller/cadence/Kconfig
> +++ b/drivers/pci/controller/cadence/Kconfig
> @@ -42,6 +42,15 @@ config PCIE_CADENCE_PLAT_EP
>  	  endpoint mode. This PCIe controller may be embedded into many
>  	  different vendors SoCs.
>  
> +config PCIE_SG2042_HOST
> +	tristate "Sophgo SG2042 PCIe controller (host mode)"
> +	depends on OF && (ARCH_SOPHGO || COMPILE_TEST)
> +	select PCIE_CADENCE_HOST
> +	help
> +	  Say Y here if you want to support the Sophgo SG2042 PCIe platform
> +	  controller in host mode. Sophgo SG2042 PCIe controller uses Cadence
> +	  PCIe core.
> +
>  config PCI_J721E
>  	tristate
>  	select PCIE_CADENCE_HOST if PCI_J721E_HOST != n
> @@ -67,4 +76,5 @@ config PCI_J721E_EP
>  	  Say Y here if you want to support the TI J721E PCIe platform
>  	  controller in endpoint mode. TI J721E PCIe controller uses Cadence PCIe
>  	  core.
> +
>  endmenu
> diff --git a/drivers/pci/controller/cadence/Makefile b/drivers/pci/controller/cadence/Makefile
> index 9bac5fb2f13d..5e23f8539ecc 100644
> --- a/drivers/pci/controller/cadence/Makefile
> +++ b/drivers/pci/controller/cadence/Makefile
> @@ -4,3 +4,4 @@ obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host.o
>  obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep.o
>  obj-$(CONFIG_PCIE_CADENCE_PLAT) += pcie-cadence-plat.o
>  obj-$(CONFIG_PCI_J721E) += pci-j721e.o
> +obj-$(CONFIG_PCIE_SG2042_HOST) += pcie-sg2042.o
> diff --git a/drivers/pci/controller/cadence/pcie-sg2042.c b/drivers/pci/controller/cadence/pcie-sg2042.c
> new file mode 100644
> index 000000000000..c026e1ca5d6e
> --- /dev/null
> +++ b/drivers/pci/controller/cadence/pcie-sg2042.c
> @@ -0,0 +1,104 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * pcie-sg2042 - PCIe controller driver for Sophgo SG2042 SoC
> + *
> + * Copyright (C) 2025 Sophgo Technology Inc.
> + * Copyright (C) 2025 Chen Wang <unicorn_wang@outlook.com>
> + */
> +
> +#include <linux/mod_devicetable.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +
> +#include "pcie-cadence.h"
> +
> +/*
> + * SG2042 only supports 4-byte aligned access, so for the rootbus (i.e. to
> + * read/write the Root Port itself, read32/write32 is required. For
> + * non-rootbus (i.e. to read/write the PCIe peripheral registers, supports
> + * 1/2/4 byte aligned access, so directly using read/write should be fine.
> + */
> +
> +static struct pci_ops sg2042_pcie_root_ops = {
> +	.map_bus	= cdns_pci_map_bus,
> +	.read		= pci_generic_config_read32,
> +	.write		= pci_generic_config_write32,
> +};
> +
> +static struct pci_ops sg2042_pcie_child_ops = {
> +	.map_bus	= cdns_pci_map_bus,
> +	.read		= pci_generic_config_read,
> +	.write		= pci_generic_config_write,
> +};
> +
> +static int sg2042_pcie_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct pci_host_bridge *bridge;
> +	struct cdns_pcie *pcie;
> +	struct cdns_pcie_rc *rc;
> +	int ret;
> +
> +	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*rc));
> +	if (!bridge) {
> +		dev_err_probe(dev, -ENOMEM, "Failed to alloc host bridge!\n");
> +		return -ENOMEM;
> +	}
> +
> +	bridge->ops = &sg2042_pcie_root_ops;
> +	bridge->child_ops = &sg2042_pcie_child_ops;
> +
> +	rc = pci_host_bridge_priv(bridge);
> +	pcie = &rc->pcie;
> +	pcie->dev = dev;
> +
> +	platform_set_drvdata(pdev, pcie);
> +
> +	pm_runtime_set_active(dev);
> +	pm_runtime_no_callbacks(dev);
> +	devm_pm_runtime_enable(dev);
> +
> +	ret = cdns_pcie_init_phy(dev, pcie);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "Failed to init phy!\n");
> +		return ret;
> +	}
> +
> +	ret = cdns_pcie_host_setup(rc);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "Failed to setup host!\n");
> +		cdns_pcie_disable_phy(pcie);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +

> +static void sg2042_pcie_remove(struct platform_device *pdev)
> +{
> +	struct cdns_pcie *pcie = platform_get_drvdata(pdev);
> +
> +	cdns_pcie_disable_phy(pcie);
> +}
> +

I think this remove is useless, as it is almost impossible to
remove a pcie at runtime.

Regards,
Inochi

