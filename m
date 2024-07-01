Return-Path: <linux-pci+bounces-9514-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E1091DDA2
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 13:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D45111C217A0
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 11:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9C646444;
	Mon,  1 Jul 2024 11:15:51 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33891F949;
	Mon,  1 Jul 2024 11:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719832551; cv=none; b=J3XJhjEX5ArhNKCUtU6JvNtjJsj8eVD3T8ukr/Qm2Z2Kk4XiAhXqy0032iN8PFqiLIIbRNFu2h3xkCgS8OoiPJy5R27+7JxpX5qgkctX1BOJMYnDeES/oobbVf/5JwKwX9Uffwsik2J35yPGAR4cHx5qudddeDGAO74wzjMr6F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719832551; c=relaxed/simple;
	bh=FrjOrKb+tlQmpgbKQBEuV+IA2pjKYmp4EtQ4sHK9Clg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=liwFO4kDj/M7miA7lvkFGFo/EW+9MguJyJbAUfbjnSugMcf3+JJnVaWSVA7ICJGfx13UAwIDEaCOC10zhPYuGV5v74FJX5Z6D1duuKgvL2PQXiZ0EFM6YfnTJ6wN35Zmuseex0nGs/+4d+JE1GF0zY5SI3dXVDG0+5MhvhzxG44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WCNhj1kdlz6K9TV;
	Mon,  1 Jul 2024 19:13:57 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id DD25A140D30;
	Mon,  1 Jul 2024 19:15:46 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 1 Jul
 2024 12:15:45 +0100
Date: Mon, 1 Jul 2024 12:15:44 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Shradha Todi <shradha.t@samsung.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<manivannan.sadhasivam@linaro.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<robh@kernel.org>, <bhelgaas@google.com>, <jingoohan1@gmail.com>,
	<fancer.lancer@gmail.com>, <yoshihiro.shimoda.uh@renesas.com>,
	<conor.dooley@microchip.com>, <pankaj.dubey@samsung.com>,
	<gost.dev@samsung.com>
Subject: Re: [PATCH v3 0/3] Add support for RAS DES feature in PCIe DW
Message-ID: <20240701121544.00006faa@Huawei.com>
In-Reply-To: <20240625093813.112555-1-shradha.t@samsung.com>
References: <CGME20240625094434epcas5p2e48bda118809ccb841c983d737d4f09d@epcas5p2.samsung.com>
	<20240625093813.112555-1-shradha.t@samsung.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 25 Jun 2024 15:08:10 +0530
Shradha Todi <shradha.t@samsung.com> wrote:

> DesignWare controller provides a vendor specific extended capability
> called RASDES as an IP feature. This extended capability  provides
> hardware information like:
>  - Debug registers to know the state of the link or controller. 
>  - Error injection mechanisms to inject various PCIe errors including
>    sequence number, CRC
>  - Statistical counters to know how many times a particular event
>    occurred
> 
> However, in Linux we do not have any generic or custom support to be
> able to use this feature in an efficient manner. This is the reason we
> are proposing this framework. Debug and bring up time of high-speed IPs
> are highly dependent on costlier hardware analyzers and this solution
> will in some ways help to reduce the HW analyzer usage.
> 
> The debugfs entries can be used to get information about underlying
> hardware and can be shared with user space. Separate debugfs entries has
> been created to cater to all the DES hooks provided by the controller.
> The debugfs entries interacts with the RASDES registers in the required
> sequence and provides the meaningful data to the user. This eases the
> effort to understand and use the register information for debugging.

To consider this properly I think some documentation is needed.

Maybe just ABI in Documentation/ABI/testing/debugfs-*
or maybe a more freestanding document.


> 
> v2: https://lore.kernel.org/lkml/20240319163315.GD3297@thinkpad/T/
> 
> v1: https://lore.kernel.org/all/20210518174618.42089-1-shradha.t@samsung.com/T/
> 
> Shradha Todi (3):
>   PCI: dwc: Add support for vendor specific capability search
>   PCI: debugfs: Add support for RASDES framework in DWC
>   PCI: dwc: Create debugfs files in DWC driver
> 
>  drivers/pci/controller/dwc/Kconfig            |   8 +
>  drivers/pci/controller/dwc/Makefile           |   1 +
>  .../controller/dwc/pcie-designware-debugfs.c  | 474 ++++++++++++++++++
>  .../controller/dwc/pcie-designware-debugfs.h  |   0
>  .../pci/controller/dwc/pcie-designware-host.c |   2 +
>  drivers/pci/controller/dwc/pcie-designware.c  |  20 +
>  drivers/pci/controller/dwc/pcie-designware.h  |  18 +
>  7 files changed, 523 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-designware-debugfs.c
>  create mode 100644 drivers/pci/controller/dwc/pcie-designware-debugfs.h
> 


