Return-Path: <linux-pci+bounces-16693-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CD49C7D20
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 21:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 696891F21BEB
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 20:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B533205ABD;
	Wed, 13 Nov 2024 20:49:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1407920513F;
	Wed, 13 Nov 2024 20:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731530958; cv=none; b=Vtk5OotJ7ji/GuyFQqZpkKKR02GTL4J2sf1/jL39OfIdyBqQgUwG9P9tbksFe3XP4pz2+VedwsoW+7I5lRqB9s2J5z5pwUBbC7iHmF+lDbpGrFNEvqYpRBrTBjRJraBiiMgaUm+cUagAhJ2aypddZillY8q2gAEHhPqlQnChY3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731530958; c=relaxed/simple;
	bh=sYenyNVhbqtoCF4Gtlg2a3yOiQus6gpv5vK311HhI9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EzV5i9CSd50kLygS9T4PmdkyQffIQYxer1k1melo4jBuvsiSRdEnxcMv2mmbSaNqCdi0L+dWeLEkfRtvzXDFsGdq7zwlMo0xr4npPLFomyUyEKn8GiBWQOe1CzKia592ULPp9/46b2viXosx0sCjtv0dPIUUboDZD3Mz0UNF3lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20cbcd71012so86264705ad.3;
        Wed, 13 Nov 2024 12:49:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731530956; x=1732135756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wqNOaupW4D7Pl4LWUGNngmSlFCvL3mz4QGohqjhdbv4=;
        b=WT4lGdT/gv6lfLg5nlzakbYoRUMXZ8QtbrOJXM75ToNU5MbZPH3OW7107/1vTuFY8g
         ceemXnhraMNNHbLvUN4jueueIhY33PoGLkhuWOsoi0VLLuZN8AGEhxyeQJKNSkohjOWd
         clEoHuF3FbZ6p6DEZ4IHiDKl3bgY0lA58cCs4Rkuen7UY0ehSaEWl7I3SuB1kzTCICcu
         GLWiV33Tf2PgpQMb4wiE1egc6MsgC10TPbr3Tx2vMyqQKpfqYYntdIrvI8JHyntcB0Ef
         +tr6fRW229aglB2aHnXGq4803rkPDlqykY+SuvCIfyjggNpHvIfkW00RS11s2aSTL2wo
         +Bwg==
X-Forwarded-Encrypted: i=1; AJvYcCWhSqId0NctXsiFjokOeMWhMwNQ2G957dCkvddIfAE/T1xOcs9BCnY0ycIxsZcPdbpIItPCx3NyMef7@vger.kernel.org, AJvYcCX/f1bLMwsiB2btEZK6ejTW3CQdCdCU23FlgBkkETOkKk+v/9UDgjVIcyyQgDnl4+ED72vyuHxH91Cw@vger.kernel.org
X-Gm-Message-State: AOJu0YwiriSIVR3SsMjDIYSgab+gZfNP92muyADGCDQwg5rKm+Y5o+vp
	pMylFeRpISPSQf4gI6vJ1bTADxNxMco/1R8FHCXtRBUjwRf+EeZH
X-Google-Smtp-Source: AGHT+IFhARDykGkT1c5RI/jZUxfJHdsS1B+MRLUP6BKDimJayPAMAWNWa7MPqjHfFlzmP7pHA6i8VA==
X-Received: by 2002:a17:902:ce90:b0:20c:8907:902 with SMTP id d9443c01a7336-211835b08a4mr279429435ad.49.1731530956214;
        Wed, 13 Nov 2024 12:49:16 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc8073sm114604295ad.5.2024.11.13.12.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 12:49:15 -0800 (PST)
Date: Thu, 14 Nov 2024 05:49:13 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v5 00/14] Fix and improve the Rockchip endpoint driver
Message-ID: <20241113204913.GC1138879@rocinante>
References: <20241017015849.190271-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017015849.190271-1-dlemoal@kernel.org>

Hello,

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
> These patches were tested using a Pine Rockpro64 board used as an
> endpoint with the test endpoint function driver and a prototype nvme
> endpoint function driver.

Applied to controller/rockchip, thank you!

[01/13] PCI: rockchip-ep: Fix address translation unit programming
        https://git.kernel.org/pci/pci/c/289cd5c0db35

[02/13] PCI: rockchip-ep: Use a macro to define EP controller .align feature
        https://git.kernel.org/pci/pci/c/8ba3b41eb7ec

[03/13] PCI: rockchip-ep: Improve rockchip_pcie_ep_unmap_addr()
        https://git.kernel.org/pci/pci/c/db68baa5d884

[04/13] PCI: rockchip-ep: Improve rockchip_pcie_ep_map_addr()
        https://git.kernel.org/pci/pci/c/c5b097d2a295

[05/13] PCI: rockchip-ep: Implement the pci_epc_ops::align_addr() operation
        https://git.kernel.org/pci/pci/c/75b011d9006e

[06/13] PCI: rockchip-ep: Fix MSI IRQ data mapping
        https://git.kernel.org/pci/pci/c/42c55124c3b2

[07/13] PCI: rockchip-ep: Rename rockchip_pcie_parse_ep_dt()
        https://git.kernel.org/pci/pci/c/c8b915ec5338

[08/13] PCI: rockchip-ep: Refactor rockchip_pcie_ep_probe() memory allocations
        https://git.kernel.org/pci/pci/c/c0473caa87f1

[09/13] PCI: rockchip-ep: Refactor rockchip_pcie_ep_probe() MSI-X hiding
        https://git.kernel.org/pci/pci/c/48e848c8727c

[10/13] PCI: rockchip-ep: Refactor endpoint link training enable
        https://git.kernel.org/pci/pci/c/c6de5dd3fd0c

[11/13] PCI: rockship-ep: Implement the pci_epc_ops::stop_link() operation
        https://git.kernel.org/pci/pci/c/8a9424d83e20

	Krzysztof

