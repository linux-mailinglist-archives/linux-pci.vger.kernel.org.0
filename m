Return-Path: <linux-pci+bounces-271-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 672E87FEB00
	for <lists+linux-pci@lfdr.de>; Thu, 30 Nov 2023 09:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 982F31C204F7
	for <lists+linux-pci@lfdr.de>; Thu, 30 Nov 2023 08:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F9320DD7;
	Thu, 30 Nov 2023 08:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XL8i+Z1x"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739E5B2
	for <linux-pci@vger.kernel.org>; Thu, 30 Nov 2023 00:40:47 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-423ec1b2982so4199941cf.2
        for <linux-pci@vger.kernel.org>; Thu, 30 Nov 2023 00:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701333646; x=1701938446; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L93bb+H/bnLlsZVsia4mn0smDZsxoK+zrisz2Dquwys=;
        b=XL8i+Z1xIAFVojLpb3HjVIYbhkieNfalFQQmei/HVf31D58QRdkN041ZONU7sCYcSG
         BdoN1O2mmUCh5oRMuytOSMHvgU/7I2PN5fNhHtNVl9lpMAj3aTFMOp3APklTlVC9N+do
         EARmxCURzVcDkS0io1XxLGFISklwu9TVb84biq6btrRUrFO6V0ZL5KViuAT2qG/eEcPK
         pqogC9XB9MhWHYLE8/VH6/e9kF94WKYXiPaO0i6BgSU5WVV5CxCDsS+uwrjAWK41a6yG
         E1IPbFwWHHJL7uyrDpVspwD7DmpkLkgkn9MUd7oNPkYbYO/3Eckn/OFgxspZ+7YpjTyW
         H18w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701333646; x=1701938446;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L93bb+H/bnLlsZVsia4mn0smDZsxoK+zrisz2Dquwys=;
        b=kGso3Cut2mb0+cvSmiq1T5SjBvRVss61kpBVR5dPY00S9X6fLHTPKyJwhmzGj9OKCQ
         ZhWTn7dhu3hX26oABb0apcjvRHU9pXRqHOWqSlBus9op2dq1rsUGNatUr8tLaVIPHIC5
         3Oq70QeE36dMUb7X5u9WAn0MmqcD7n7i4pqiTs7noHeTYkfu03vQcYpwnJCgdPBbeaGr
         W6cryy2H4Y90+vejm7H5sTccGnf24DP20m61wupe080dQYY6g/qiix+T3I228OW6chSv
         4Dv+7djKMshMvl0vkAetKP5//TODsyQOx44ggpvHUqmLQU73bzzInJ7kumlmrU4Rz2ug
         WVvQ==
X-Gm-Message-State: AOJu0Yw9czn+EImCPrxkn1grA+HEwM6+tL6lRMxxYitm0+6sfsZmbkGO
	Y3pOUZ4KXh0aFHlcDpiyvX/9
X-Google-Smtp-Source: AGHT+IGlDWiiP+qk80pU7sMxwyrZEQSSl9BFPUX2PbBiZ8zwau671F6dVNJkmD/+e6xMJ/NuMKpSLw==
X-Received: by 2002:a05:622a:410c:b0:423:b92a:7fb5 with SMTP id cc12-20020a05622a410c00b00423b92a7fb5mr18522427qtb.12.1701333646551;
        Thu, 30 Nov 2023 00:40:46 -0800 (PST)
Received: from thinkpad ([59.92.100.237])
        by smtp.gmail.com with ESMTPSA id o11-20020ac8554b000000b0041812703b7esm295306qtr.52.2023.11.30.00.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 00:40:46 -0800 (PST)
Date: Thu, 30 Nov 2023 14:10:39 +0530
From: Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH v4 00/16] Cleanup IRQ type definitions
Message-ID: <20231130084039.GN3043@thinkpad>
References: <20231122060406.14695-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231122060406.14695-1-dlemoal@kernel.org>

On Wed, Nov 22, 2023 at 03:03:50PM +0900, Damien Le Moal wrote:
> The first patch renames PCI_IRQ_LEGACY to PCI_IRQ_INTX as suggested by
> Bjorn (hence the patch authorship is given to him). The second patch
> removes the redundant IRQ type definitions PCI_EPC_IRQ_XXX and replace
> these with a direct use of the PCI_IRQ_XXX definitions. These 2 patches
> have been sent and reviewed previously but were never applied. Hence the
> resend with this new series version.
> 
> The remaining patches rename functions and correct comments etc to refer
> to "intx" instead of "legacy".
> 
> Changes from v3:
>  - Added tags to patch 2
>  - Added patch 3 to 16
> 
> Changes from v2:
>  - Modified PCI_IRQ_LEGACY comment in patch 1 as suggested by Serge
>  - Fixed forgotten rename in patch 2
> 
> Changes from v1:
>  - Updated first patch Signed-of tag and commit message as suggested by
>    Bjorn.
>  - Added review tags.
> 
> Bjorn Helgaas (1):
>   PCI: Rename PCI_IRQ_LEGACY to PCI_IRQ_INTX
> 
> Damien Le Moal (15):
>   PCI: endpoint: Drop PCI_EPC_IRQ_XXX definitions
>   PCI: endpoint: Use INTX instead of legacy
>   PCI: endpoint: Rename LEGACY to INTX in test function driver
>   misc: pci_endpoint_test: Use INTX instead of LEGACY
>   PCI: portdrv: Use PCI_IRQ_INTX
>   PCI: dra7xx: Rename dra7xx_pcie_raise_legacy_irq()
>   PCI: cadence: Use INTX instead of legacy
>   PCI: dwc: Rename dw_pcie_ep_raise_legacy_irq()
>   PCI: keystone: Use INTX instead of legacy
>   PCI: dw-rockchip: Rename rockchip_pcie_legacy_int_handler()
>   PCI: tegra194: Use INTX instead of legacy
>   PCI: uniphier: Use INTX instead of legacy
>   PCI: rockchip-ep: Use INTX instead of legacy
>   PCI: rockchip-host: Rename rockchip_pcie_legacy_int_handler()
>   PCI: xilinx-nwl: Use INTX instead of legacy
> 

For the series:

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

>  drivers/misc/pci_endpoint_test.c              | 30 +++----
>  .../pci/controller/cadence/pcie-cadence-ep.c  | 19 ++--
>  drivers/pci/controller/cadence/pcie-cadence.h | 12 +--
>  drivers/pci/controller/dwc/pci-dra7xx.c       | 10 +--
>  drivers/pci/controller/dwc/pci-imx6.c         | 11 ++-
>  drivers/pci/controller/dwc/pci-keystone.c     | 86 +++++++++----------
>  .../pci/controller/dwc/pci-layerscape-ep.c    | 10 +--
>  drivers/pci/controller/dwc/pcie-artpec6.c     |  8 +-
>  .../pci/controller/dwc/pcie-designware-ep.c   |  8 +-
>  .../pci/controller/dwc/pcie-designware-plat.c | 11 ++-
>  drivers/pci/controller/dwc/pcie-designware.h  |  6 +-
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c |  4 +-
>  drivers/pci/controller/dwc/pcie-keembay.c     | 13 ++-
>  drivers/pci/controller/dwc/pcie-qcom-ep.c     |  8 +-
>  drivers/pci/controller/dwc/pcie-rcar-gen4.c   |  9 +-
>  drivers/pci/controller/dwc/pcie-tegra194.c    | 19 ++--
>  drivers/pci/controller/dwc/pcie-uniphier-ep.c | 11 ++-
>  drivers/pci/controller/dwc/pcie-uniphier.c    | 12 +--
>  drivers/pci/controller/pcie-rcar-ep.c         |  7 +-
>  drivers/pci/controller/pcie-rockchip-ep.c     | 23 +++--
>  drivers/pci/controller/pcie-rockchip-host.c   |  4 +-
>  drivers/pci/controller/pcie-xilinx-nwl.c      | 52 +++++------
>  drivers/pci/endpoint/functions/pci-epf-mhi.c  |  2 +-
>  drivers/pci/endpoint/functions/pci-epf-ntb.c  |  4 +-
>  drivers/pci/endpoint/functions/pci-epf-test.c | 14 +--
>  drivers/pci/endpoint/functions/pci-epf-vntb.c |  7 +-
>  drivers/pci/endpoint/pci-epc-core.c           |  6 +-
>  drivers/pci/pcie/portdrv.c                    |  8 +-
>  include/linux/pci-epc.h                       | 11 +--
>  include/linux/pci.h                           |  4 +-
>  include/uapi/linux/pcitest.h                  |  3 +-
>  31 files changed, 206 insertions(+), 226 deletions(-)
> 
> -- 
> 2.42.0
> 

-- 
மணிவண்ணன் சதாசிவம்

