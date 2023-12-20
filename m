Return-Path: <linux-pci+bounces-1223-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0629F81A247
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 16:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 322A6B2572F
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 15:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8492C40BF5;
	Wed, 20 Dec 2023 15:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAsiFVuN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D3F40BED;
	Wed, 20 Dec 2023 15:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50e3295978aso5239573e87.1;
        Wed, 20 Dec 2023 07:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703085635; x=1703690435; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lKC6ncMgnTqSLNT61vP2X3brbAVY2ogWJN9O8ynnY/Q=;
        b=gAsiFVuN233A6BhKWXmqWRuIdSfNYJc1GyunbLOppB7+6eVgWRRdVUpVvumBcwdB9K
         +6nlUu/bizgTNLV5UUK8Lj5Tqw+pQlIDPDJkxT32P6rFw3y3ChsSNKkyoDCQttURh+Bq
         iu4/Khg5SUdyuLnx7aNUmuA84UVo4mJRLbWASnkgu44QSDsX0p13R92ys8XlhqcA05fK
         R0ftkSlnAGWq7XogS3WmskrZycteJ0ZYIJbuVHaQMWqFHmtEosBVxgaaV2DZpMalYsA/
         Zbe9ePDiyZgeepQiAfFLfidJj4D8ilNh7Se6KwomhFkyGCs9rFYcjLgcv8hxetZ5QbMZ
         qbnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703085635; x=1703690435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lKC6ncMgnTqSLNT61vP2X3brbAVY2ogWJN9O8ynnY/Q=;
        b=NKWK5tzdLZjbee+6upeJoMAmZ47+YrE88vuWVGzxcO+2O2TCccWLieakd3tnjxCbNx
         UDiU82FvUlJ+v1J2Rc6DMpdBvkJyWyp07bsziGYp8UYiZLAUlbJ83RCk3W/U6TztyRkp
         wUE1qmf61M9snNnnzEzRLxMaw9HWkH5cRjGwv2ogTUkOf94TH7jvVWDaSiEr1+tFCx9n
         G0EAhUV1NKsT7BNG28mZlCZow/cKP/MW09XvIbVVptpcCc4XXgOrcg5ngLYF7aWgl1Ii
         Phx+a14BxgeQb7uZ+G1hWwMdf4oNLbfrowmI4xubey6j8MLjBDkQ2NHIgG7odbay5Ru2
         yRYQ==
X-Gm-Message-State: AOJu0Yx1uFzyX4rTvmzxV8uCf1Xu0jRCT2WboZ/pSMExbiFGz+RLD/Yt
	q7kLE1KRoMsvbsEJ9tlXnaI=
X-Google-Smtp-Source: AGHT+IHFdfW9Dhwr/JXZXK2HKCzkuvrTvaoFNcesU784zY/1p3vL6gx7GbJyOOsnE299hvOmLF8Lpw==
X-Received: by 2002:a05:6512:3f18:b0:50b:fda1:4ce with SMTP id y24-20020a0565123f1800b0050bfda104cemr11378760lfa.133.1703085634509;
        Wed, 20 Dec 2023 07:20:34 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id i17-20020a056512225100b0050e1b5e3d61sm1700191lfu.264.2023.12.20.07.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 07:20:34 -0800 (PST)
Date: Wed, 20 Dec 2023 18:20:31 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Manivannan Sadhasivam <mani@kernel.org>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, 
	bhelgaas@google.com, jingoohan1@gmail.com, gustavo.pimentel@synopsys.com, 
	mani@kernel.org, linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v4 0/6] PCI: controllers: tidy code up
Message-ID: <fgnz47aqndjyn2y4u7jhdbdagtarwaasiekajavmxolpmsdu74@plhasdd5z55b>
References: <20231220053829.1921187-1-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220053829.1921187-1-yoshihiro.shimoda.uh@renesas.com>

Hi Krzysztof, Lorenzo, Bjorn, Mani

On Wed, Dec 20, 2023 at 02:38:23PM +0900, Yoshihiro Shimoda wrote:
> This patch series tidies the code of PCIe dwc controllers and some
> controllers up.
> 
> Changes from v3:
> https://lore.kernel.org/linux-pci/20231215022955.3574063-1-yoshihiro.shimoda.uh@renesas.com/
>  - Based on the latest pci.git / next branch. So, I modified the patch 1/6
>    for pci-layerscape.c.
>  - Add Reviewed-by tag in the patch 4/6.
>  - Fix locations of read/write accessors by grouped for readability in
>    the patch 4/6.

The series has got all the Mani's acks. The last nitpick was fixed in
v4. No more comments at least from my side. What about merging it in
(before merge window v6.8 is opened)?

-Serge(y)

> 
> Changes from v2:
> https://lore.kernel.org/linux-pci/20231114055456.2231990-1-yoshihiro.shimoda.uh@renesas.com/
>  - Based on the latest pci.git / next branch.
>  - Add Suggestion-by and Reviewed-by tags.
>  - Move read/write accessors to the header file in the patch 4/6.
>  - Revise the commit description in the patch 5/6.
> 
> Changes from v1:
> https://lore.kernel.org/linux-pci/20231113013300.2132152-1-yoshihiro.shimoda.uh@renesas.com/
>  - Based on the latest pci.git / next branch.
>  - Add a new patch to drop host prefix of members from dw_pcie_host_ops
>    in the patch 1/6.
>  - Add Reviewed-by tag in the patch 3/6.
>  - Drop unneeded local variable in the patch 4/6.
>  - Add new patches to resolve issues of clang warnings in the patch [56]/6.
> 
> Justin Stitt (1):
>   PCI: iproc: fix -Wvoid-pointer-to-enum-cast warning
> 
> Yoshihiro Shimoda (5):
>   PCI: dwc: Drop host prefix from struct dw_pcie_host_ops
>   PCI: dwc: Rename to .init in struct dw_pcie_ep_ops
>   PCI: dwc: Rename to .get_dbi_offset in struct dw_pcie_ep_ops
>   PCI: dwc: Add dw_pcie_ep_{read,write}_dbi[2] helpers
>   PCI: rcar-gen4: fix -Wvoid-pointer-to-enum-cast warning
> 
>  drivers/pci/controller/dwc/pci-dra7xx.c       |   4 +-
>  drivers/pci/controller/dwc/pci-exynos.c       |   2 +-
>  drivers/pci/controller/dwc/pci-imx6.c         |   6 +-
>  drivers/pci/controller/dwc/pci-keystone.c     |   8 +-
>  .../pci/controller/dwc/pci-layerscape-ep.c    |   7 +-
>  drivers/pci/controller/dwc/pci-layerscape.c   |   6 +-
>  drivers/pci/controller/dwc/pci-meson.c        |   2 +-
>  drivers/pci/controller/dwc/pcie-al.c          |   2 +-
>  drivers/pci/controller/dwc/pcie-armada8k.c    |   2 +-
>  drivers/pci/controller/dwc/pcie-artpec6.c     |   4 +-
>  drivers/pci/controller/dwc/pcie-bt1.c         |   4 +-
>  .../pci/controller/dwc/pcie-designware-ep.c   | 188 ++++++------------
>  .../pci/controller/dwc/pcie-designware-host.c |  30 +--
>  .../pci/controller/dwc/pcie-designware-plat.c |   2 +-
>  drivers/pci/controller/dwc/pcie-designware.h  | 105 +++++++++-
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c |   2 +-
>  drivers/pci/controller/dwc/pcie-fu740.c       |   2 +-
>  drivers/pci/controller/dwc/pcie-histb.c       |   2 +-
>  drivers/pci/controller/dwc/pcie-intel-gw.c    |   2 +-
>  drivers/pci/controller/dwc/pcie-keembay.c     |   2 +-
>  drivers/pci/controller/dwc/pcie-kirin.c       |   2 +-
>  drivers/pci/controller/dwc/pcie-qcom-ep.c     |   2 +-
>  drivers/pci/controller/dwc/pcie-qcom.c        |   6 +-
>  drivers/pci/controller/dwc/pcie-rcar-gen4.c   |  12 +-
>  drivers/pci/controller/dwc/pcie-spear13xx.c   |   2 +-
>  drivers/pci/controller/dwc/pcie-tegra194.c    |   2 +-
>  drivers/pci/controller/dwc/pcie-uniphier-ep.c |   2 +-
>  drivers/pci/controller/dwc/pcie-uniphier.c    |   2 +-
>  drivers/pci/controller/dwc/pcie-visconti.c    |   2 +-
>  drivers/pci/controller/pcie-iproc-platform.c  |   2 +-
>  30 files changed, 222 insertions(+), 194 deletions(-)
> 
> -- 
> 2.25.1
> 
> 

