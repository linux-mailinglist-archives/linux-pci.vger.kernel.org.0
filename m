Return-Path: <linux-pci+bounces-18477-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F50A9F29BA
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 06:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A311118839D7
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 05:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93401C4A2E;
	Mon, 16 Dec 2024 05:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DZrRdmve"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D361BC08B
	for <linux-pci@vger.kernel.org>; Mon, 16 Dec 2024 05:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734328208; cv=none; b=M8tmag64TEWdKv4l8HgSBQ6IyzHOyO7UgDoUwX4OAg/Gs3nQLG1Rj+WiNwBzzqn6TdcwJbDk4f7MU3OgSRja0fd9GDx75Q/AVEoClHnopBx1uZAwGtJcSqIBCbcdx7WbPjlo5AufcdesBRjSelWMi/9e2PqsnCO3ayS9YXihYBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734328208; c=relaxed/simple;
	bh=2cTsVnfM7XIIl/u9mvOvjh+B2EB2+2cTlJ0+vGQVXwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/UzulZw6pXQXpUlNzYsnQ2MsD/FDT50R8gD16haka7XM/VkofdR6qNeimYKU3eAK/OU37GrbAZ4nsRxVxa2OOUPusC8TooGUdu9csKiHAkjJb4vG5BDm31wyE0I5CXGdhXynWUHEXLYRvOm0GbRwRDJ3dXqWfGqUO/tmXBsDUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DZrRdmve; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-725f4025e25so2923400b3a.1
        for <linux-pci@vger.kernel.org>; Sun, 15 Dec 2024 21:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734328206; x=1734933006; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NfDqFw/0Ge6ACx4gypsP30h0WumL7JDvT7ybs468exc=;
        b=DZrRdmveMyawvqK4vrDeb33/JM3GWMecsIqKvpiWIELwYQRK5ZYOeBWze4nWUichBD
         +LWQjKCl9JlbRACN/4L/4t7YKt/rq0btYDb3vMNHJt5aN3p1ypIcRBPRSHV3njMAGarV
         LcmMmaw6+tL05ziZDzux5RX99Jrm6NP46FDuigFGUVM/nae9gGtXKgV0RL1wopxJve6w
         BEudUxTn4lwWhQs4/HzrDmc+Yjap5Wv3yMhldEEvDfDZ2JAoYVlQXX7ArVWcV5BMupja
         ofW83ZtNU5n3wSnT9QfOrItyyX8vvThCk9rDUxxf81TgG5fY4s/Rv3Nu5oY3ZyhaQw59
         t1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734328206; x=1734933006;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NfDqFw/0Ge6ACx4gypsP30h0WumL7JDvT7ybs468exc=;
        b=YgdgAl5b1RVkm8JLPHZhAPETfwDJ+V16rF9XR3NkQg6T8AeFtzrLQYFnL4hWe9XrQY
         OMLvdrKlFaPNv+KzlgmkvH4BifJV07JCCKkqroB4McVEJvsfRV3avb5dR+ZCdACKNBtH
         vy2zKI7RN/ItmpQ7OfZiaFsu35sKM0DSoGXOJE5DjicZNJQzSXoqReRrjbmOPH9/Mqpt
         3sB4tQqyMktNBJz0c+mrOAqi0sVu0ky/FCRmWk9ToPixOZfj2eHQ4DIbnPOSY2HIgXPw
         FekbYRtRo60MFytRzr1Mns/N4WzWj/btBJBdSF4/3GmVsirEUo8kvwnD4QMmHQQtBXgi
         lw4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVc8hj/HBsTcL6lK7rUyc/zGrKJr9K7dCx/9rpj1AzjDxlXLg4xRQ8uzepWJSGG1PgDZJWopC+sy4I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8AMtI8x08fjbZSKAL8N0vvWOyj8Ng2m+7EYsq/z0mgny3w4ML
	+RgsMZAIwS33nASspAPfmnlrxRlcBBOwIW2EPRYUOVKZiCzjdELV5UsSk6Eo0g==
X-Gm-Gg: ASbGncvs33sKLz5k20dkCloyhNQOVI0RzStNCmwB06R58lIwkjMR7orIJHznMwd9rEl
	wuOHZhjyh6HH2jTmQkLZFDr4Wa55gAyyA9uB9pyl2hUZn54akHzEgSrxRBDuI8c7q5ebsE4Rb3/
	m5ibAoMzKwOhiFslbt9aXXy1RQl9LvEceG/wiP730AxfqdR81EHisLaRv+GxJ04tEpW/YOVEC3g
	D10avscCkcmJ2FchN0UyfFxCILgQq4cN+5F8xb/Zfm88Im8zAlPRm2f6ajE8kXePos=
X-Google-Smtp-Source: AGHT+IGUEcdN6e9X082bHyB6rQbbINwZc/qg8MyVv7F/1/9Ib1cCa0Aa+2Iy8tnbGGf2gmSSQGQfZw==
X-Received: by 2002:a05:6a00:4386:b0:725:e4b9:a600 with SMTP id d2e1a72fcca58-7290c24cceamr15300939b3a.16.1734328206422;
        Sun, 15 Dec 2024 21:50:06 -0800 (PST)
Received: from thinkpad ([120.60.56.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918bad802sm4004227b3a.141.2024.12.15.21.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 21:50:05 -0800 (PST)
Date: Mon, 16 Dec 2024 11:19:53 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v5 00/14] Fix and improve the Rockchip endpoint driver
Message-ID: <20241216054953.kj43om6fbjksbjcy@thinkpad>
References: <20241017015849.190271-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241017015849.190271-1-dlemoal@kernel.org>

On Thu, Oct 17, 2024 at 10:58:35AM +0900, Damien Le Moal wrote:
> This patch series fix the PCI address mapping handling of the Rockchip
> PCI endpoint driver, refactor some of its code, improves link training
> and adds handling of the PERST# signal.
> 
> This series is organized as follows:
>  - Patch 1 fixes the rockchip ATU programming
>  - Patch 2, 3 and 4 introduce small code improvments
>  - Patch 5 implements the .align_addr() operation to make the RK3399
>    endpoint controller driver fully functional with the new
>    pci_epc_mem_map() function
>  - Patch 6 uses the new align_addr operation function to fix the ATU
>    programming for MSI IRQ data mapping
>  - Patch 7, 8, 9 and 10 refactor the driver code to make it more
>    readable
>  - Patch 11 introduces the .stop() endpoint controller operation to
>    correctly disable the endpopint controller after use
>  - Patch 12 improves link training
>  - Patch 13 implements handling of the #PERST signal
>  - Patch 14 adds a DT overlay file to enable EP mode and define the
>    PERST# GPIO (reset-gpios) property.
> 

Damien, please wait for my review before spinning the next revision. Sorry for
the delay.

- Mani

> These patches were tested using a Pine Rockpro64 board used as an
> endpoint with the test endpoint function driver and a prototype nvme
> endpoint function driver.
> 
> Changes from v4:
>  - Added patch 6
>  - Added comments to patch 12 and 13 to clarify link training handling
>    and PERST# GPIO use.
>  - Added patch 14
> 
> Changes from v3:
>  - Addressed Mani's comments (see mailing list for details).
>  - Removed old patch 11 (dt-binding changes) and instead use in patch 12
>    the already defined reset_gpios property.
>  - Added patch 6
>  - Added review tags
> 
> Changes from v2:
>  - Split the patch series
>  - Corrected patch 11 to add the missing "maxItem"
> 
> Changes from v1:
>  - Changed pci_epc_check_func() to pci_epc_function_is_valid() in patch
>    1.
>  - Removed patch "PCI: endpoint: Improve pci_epc_mem_alloc_addr()"
>    (former patch 2 of v1)
>  - Various typos cleanups all over. Also fixed some blank space
>    indentation.
>  - Added review tags
> 
> Damien Le Moal (14):
>   PCI: rockchip-ep: Fix address translation unit programming
>   PCI: rockchip-ep: Use a macro to define EP controller .align feature
>   PCI: rockchip-ep: Improve rockchip_pcie_ep_unmap_addr()
>   PCI: rockchip-ep: Improve rockchip_pcie_ep_map_addr()
>   PCI: rockchip-ep: Implement the pci_epc_ops::align_addr() operation
>   PCI: rockchip-ep: Fix MSI IRQ data mapping
>   PCI: rockchip-ep: Rename rockchip_pcie_parse_ep_dt()
>   PCI: rockchip-ep: Refactor rockchip_pcie_ep_probe() memory allocations
>   PCI: rockchip-ep: Refactor rockchip_pcie_ep_probe() MSI-X hiding
>   PCI: rockchip-ep: Refactor endpoint link training enable
>   PCI: rockship-ep: Implement the pci_epc_ops::stop_link() operation
>   PCI: rockchip-ep: Improve link training
>   PCI: rockchip-ep: Handle PERST# signal in endpoint mode
>   arm64: dts: rockchip: Add rockpro64 overlay for PCIe endpoint mode
> 
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../rockchip/rk3399-rockpro64-pcie-ep.dtso    |  20 +
>  drivers/pci/controller/pcie-rockchip-ep.c     | 432 ++++++++++++++----
>  drivers/pci/controller/pcie-rockchip-host.c   |   4 +-
>  drivers/pci/controller/pcie-rockchip.c        |  21 +-
>  drivers/pci/controller/pcie-rockchip.h        |  24 +-
>  6 files changed, 406 insertions(+), 96 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rockpro64-pcie-ep.dtso
> 
> -- 
> 2.47.0
> 

-- 
மணிவண்ணன் சதாசிவம்

